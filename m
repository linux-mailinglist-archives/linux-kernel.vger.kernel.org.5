Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2AF7EC114
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbjKOLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOLEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:04:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA495;
        Wed, 15 Nov 2023 03:04:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAEDC433C7;
        Wed, 15 Nov 2023 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700046290;
        bh=i4cAD/OCLl0SeCe8b2JD1J5zNEzd+LtYHbZCyyoXmg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPIhhLmF9Ed6qhVkzQf+3BE90Qf5Q0m9k/rTYlVPfndyrpLxV54d6nj4/nbJiIXnn
         WcSUbag9h2A1mzM01HV1GcxaheXIJ7bRu7GTfat3WGmi5gjlOePg2xyyDuNzLA/iUY
         e5+KL5WghNI7iNqIuZyAJARDOjj+IO7pMn0cuyPg=
Date:   Wed, 15 Nov 2023 06:04:48 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        initramfs@vger.kernel.org, stable@vger.kernel.org,
        Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2] rootfs: Fix support for rootfstype= when root= is
 given
Message-ID: <2023111514-tiring-outlying-521f@gregkh>
References: <20231114141030.219729-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114141030.219729-1-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:10:30AM -0500, Stefan Berger wrote:
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
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Rob Landley <rob@landley.net>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  init/do_mounts.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 5fdef94f0864..279ad28bf4fb 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -510,7 +510,10 @@ struct file_system_type rootfs_fs_type = {
>  
>  void __init init_rootfs(void)
>  {
> -	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
> -		is_tmpfs = true;
> +	if (IS_ENABLED(CONFIG_TMPFS)) {
> +		if (!saved_root_name[0] && !root_fs_names)
> +			is_tmpfs = true;
> +		else if (root_fs_names && !!strstr(root_fs_names, "tmpfs"))
> +			is_tmpfs = true;
> +	}
>  }
> -- 
> 2.41.0
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
