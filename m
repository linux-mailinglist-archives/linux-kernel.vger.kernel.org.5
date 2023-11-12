Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751C57E9273
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKLUOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 15:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 15:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDBE2116
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 12:14:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9EDC433C8;
        Sun, 12 Nov 2023 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699820074;
        bh=oRGBYTEliw7AYNH0BwmcNNXHy3XA7EOZkxh+XB9u+Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ut0JJClrFdy6dOuewkyVjfw1vgHAeJAl8qrEiyAKAlJAh0XDXXOgn6ChGU7/PI9WY
         4uqz1paKLXnHOT2mivdX7zlfp2SifYQyL10L129FKLp6fHTkpKa1EaLrAciVw1TPP5
         Nr0r9PR0tH7iLbZPFNl0SjxtdGUpcnJHG4uuxBidNyOqf7iqQjJRDRz2zUclNb+RNy
         ZocyNlCH0qSpUkqcWClsWjlxiiUgd+kpkeMh0ctD/tdPq7ZRmASNlWzc80FpF26ojo
         CuLRCH3HFRcupN3rxgy2I5ORlgvyoJxeNoQ8xb6mRGY36KqoisripSZK+KoyL3ToKR
         cDH4yN7xHSHJA==
Date:   Sun, 12 Nov 2023 21:14:27 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH v1 0/1] fs: Consider capabilities relative to namespace
 for linkat permission check
Message-ID: <20231112-bekriegen-branche-fbc86a9aaa5e@brauner>
References: <20231110170615.2168372-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110170615.2168372-1-cmirabil@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 12:06:14PM -0500, Charles Mirabile wrote:
> This is a one line change that makes `linkat` aware of namespaces when
> checking for capabilities.
> 
> As far as I can tell, the call to `capable` in this code dates back to
> before the `ns_capable` function existed, so I don't think the author
> specifically intended to prefer regular `capable` over `ns_capable`,
> and no one has noticed or cared to change it yet... until now!
> 
> It is already hard enough to use `linkat` to link temporarily files
> into the filesystem without the `/proc` workaround, and when moving
> a program that was working fine on bare metal into a container,
> I got hung up on this additional snag due to the lack of namespace
> awareness in `linkat`.

I agree that it would be nice to relax this a bit to make this play
nicer with containers.

The current checks want to restrict scenarios where an application is
able to create a hardlink for an arbitrary file descriptor it has
received via e.g., SCM_RIGHTS or that it has inherited.

So we want to somehow get a good enough approximation to the question
whether the caller would have been able to open the source file.

When we check for CAP_DAC_READ_SEARCH in the caller's namespace we
presuppose that the file is accessible in the current namespace and that
CAP_DAC_READ_SEARCH would have been enough to open it. Both aren't
necessarily true. Neither need the file be accessible, e.g., due to a
chroot or pivot_root nor need CAP_DAC_READ_SEARCH be enough. For
example, the file could be accessible in the caller's namespace but due
to uid/gid mapping the {g,u}id of the file doesn't have a mapping in the
caller's namespace. So that doesn't really cut it imho.

However, if we check for CAP_DAC_READ_SEARCH in the namespace the file
was opened in that could work. We know that the file must've been
accessible in the namespace the file was opened in and we
know that the {g,u}id of the file must have been mapped in the namespace
the file was opened in. So if we check that the caller does have
CAP_DAC_READ_SEARCH in the opener's namespace we can approximate that
the caller could've opened the file.

So that should allow us to enabled this for containers.
