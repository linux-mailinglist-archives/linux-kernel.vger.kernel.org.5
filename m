Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F687997EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjIIM0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjIIM0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:26:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69821CD6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:26:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40BCC433C8;
        Sat,  9 Sep 2023 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694262363;
        bh=VNsfdQ3uzhfa+/n07FcXgAj75xE3qUoTR7VC8UphANM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hf87sl4qYOREAYeTxDV3sKjbRBHIBmVQfpYz5jBWzE+6Qm1+NZa9Zyv6o+oovnDfU
         Mf0HC47ygJ3uWl3xfqv00LV9IX471TOSKlFhEgDVHYzz6pjQ6vliXUxMkRYXDBcyrr
         78VY/qjfFH/xmLb7pasN7x0iQYf+tTpO4bK14hhs=
Date:   Sat, 9 Sep 2023 13:26:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [GIT PULL] Driver symbol lookup fix for 6.6-rc1
Message-ID: <2023090918-glutton-swampland-db58@gregkh>
References: <ZPwndquCWHIicVzt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPwndquCWHIicVzt@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 09:06:14AM +0100, Greg KH wrote:
> The following changes since commit a48fa7efaf1161c1c898931fe4c7f0070964233a:
> 
>   Merge tag 'drm-next-2023-09-08' of git://anongit.freedesktop.org/drm/drm (2023-09-07 19:47:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc1-2
> 
> for you to fetch changes up to 86495af1171e1feec79faa9b64c05c89f46e41d1:
> 
>   media: dvb: symbol fixup for dvb_attach() (2023-09-09 08:15:11 +0100)
> 
> ----------------------------------------------------------------
> Driver symbol lookup fix for 6.6-rc1
> 
> Here is one last fixup for your tree for 6.6-rc1.  It resolves a problem
> with the way that symbol_get was changed in the module tree merge in
> your tree to fix up the DVB drivers which rely on this old api to attach
> new devices.
> 
> As the changelog comment says:
> 
>   In commit 9011e49d54dc ("modules: only allow symbol_get of
>   EXPORT_SYMBOL_GPL modules") the use of symbol_get is properly restricted
>   to GPL-only marked symbols.  This interacts oddly with the DVB logic
>   which only uses dvb_attach() to load the dvb driver which then uses
>   symbol_get().
> 
>   Fix this up by properly marking all of the dvb_attach attach symbols as
>   EXPORT_SYMBOL_GPL().
> 
> This has been acked by Hans from the V4L driver side, and from Luis from
> the module side, and Christoph said it was the correct solution, and was
> tested by the original reporter of the issue.

And now Mauro has acked it:
	https://lore.kernel.org/r/20230909121941.30a1b1f0@sal.lan
but I don't want to rewrite history to add it to the signed tag.

thanks,

greg k-h
