Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE77BC75C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbjJGMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjJGMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:02:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAE3138
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:01:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87A4C433C8;
        Sat,  7 Oct 2023 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696680093;
        bh=UP/11KOVXhMDlkTzu3apHhL414ZgjdQ0NC2bI3aRAL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRQ39Ujp2QKYz8SnmeF41Q1/lGsdt90hpVqxZRn63UQIqPXNgbJ31hDNDn6+VFbVn
         6x5UHrzrgoorTRyw/d5AqNBUwqPFnX/bWE2o1UBsO7juTp++z+VjfS7baIGr4+mWON
         6Z8tp2WOUI+e8fNT3yhWH2Ixzg9+YuYh7+lFTsro=
Date:   Sat, 7 Oct 2023 14:01:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     gregkh@google.com, cmllamas@google.com, surenb@google.com,
        arve@android.com, joel@joelfernandes.org, brauner@kernel.org,
        tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] binder: add mutex_lock for mmap and NULL when free
Message-ID: <2023100715-crudely-grafting-6193@gregkh>
References: <20231007114524.76969-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007114524.76969-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 07:45:24PM +0800, Kassey Li wrote:
> - Enforce alloc->mutex in binder_alloc_mmap_handler when add the entry to
>   list.
> 
> - Assign the freed pages/page_ptr to NULL to catch possible use after free
>   with NULL pointer access.
> 
> Fixes: 19c987241ca1 ("binder: separate out binder_alloc functions")
> Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  drivers/android/binder_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index e3db8297095a..c7d126e04343 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -775,6 +775,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  	}
>  
>  	buffer->user_data = alloc->buffer;
> +	mutex_lock(&alloc->mutex);
>  	list_add(&buffer->entry, &alloc->buffers);
>  	buffer->free = 1;
>  	binder_insert_free_buffer(alloc, buffer);
> @@ -782,7 +783,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>  
>  	/* Signal binder_alloc is fully initialized */
>  	binder_alloc_set_vma(alloc, vma);
> -
> +	mutex_unlock(&alloc->mutex);
>  	return 0;
>  
>  err_alloc_buf_struct_failed:
> @@ -856,9 +857,11 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>  				     __func__, alloc->pid, i, page_addr,
>  				     on_lru ? "on lru" : "active");
>  			__free_page(alloc->pages[i].page_ptr);
> +			alloc->pages[i].page_ptr = NULL;
>  			page_count++;
>  		}
>  		kfree(alloc->pages);
> +		alloc->pages = NULL;
>  	}
>  	mutex_unlock(&alloc->mutex);
>  	if (alloc->mm)
> -- 
> 2.25.1
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
