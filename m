Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537677EB0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjKNNTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjKNNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:19:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512C1A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:19:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE98C433C8;
        Tue, 14 Nov 2023 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699967954;
        bh=ajebofFLcCvOKNg3qpy7bOy4DIHswEHw66sRMaGX4Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggfWaf3x/VsUz49R3n8GRM8jaN3sXlMhoKHx7TQ/JfMZcoUk2NyOypyi0NjbUt3tL
         XVZE1txN7xHGOgMr723DQgG9TugyUbon4fjFcYRlwP1rLiaOsk1NfmYgYGmS67SknN
         f+wJfnQFJAHIyi76pTXMq3WUDwwaE0b3ZPK5Tv2E=
Date:   Tue, 14 Nov 2023 08:19:12 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        initramfs@vger.kernel.org, Rob Landley <rob@landley.net>
Subject: Re: [PATCH] rootfs: Fix support for rootfstype= when root= is given
Message-ID: <2023111455-fabulous-simmering-51fc@gregkh>
References: <20231113211735.23267-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113211735.23267-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 04:17:35PM -0500, Stefan Berger wrote:
> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> 
>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>   line.
> 
> This currently does not work when root= is provided since then
> saved_root_name contains a string and initfstype= is ignored. Therefore,
> ramfs is currently always chosen when root= is provided.
> 
> The current behavior for rootfs's filesystem is:
> 
>    root=       | initfstype= | chosen rootfs filesystem
>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs
>    unspecified | tmpfs       | tmpfs
>    unspecified | ramfs       | ramfs
>     provided   | ignored     | ramfs
> 
> initfstype= should be respected regardless whether root= is given,
> as shown below:
> 
>    root=       | initfstype= | chosen rootfs filesystem
>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs  (as before)
>    unspecified | tmpfs       | tmpfs  (as before)
>    unspecified | ramfs       | ramfs  (as before)
>     provided   | unspecified | ramfs  (compatibility with before)
>     provided   | tmpfs       | tmpfs  (new)
>     provided   | ramfs       | ramfs  (new)
> 
> This table represents the new behavior.
> 
> Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root=  specified")
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Rob Landley <rob@landley.net>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  init/do_mounts.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
