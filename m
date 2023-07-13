Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B672752440
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGMNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGMNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462119B9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A0B261488
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72D5C433CA;
        Thu, 13 Jul 2023 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689256408;
        bh=ncmOXOmF0coP+7w8kC3VThcrDoAbs0WeDbHd5ujY3vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1X47sO18Kv5VsulB417I4LXHGL9fullVg2/umPyBAzomvXpw/cih1ryUO7P057Vm1
         EWapYbkdJ13zFd0dTFLpYgu3mUqPHBO1fkFa1RuwKV0qSTlaUcf1hQzqLiFEPRwOQ8
         dKOMV0M7Dg5OHC8j1kg2xQ3M+Bk7xQJE0Ieps5Pc=
Date:   Thu, 13 Jul 2023 15:53:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2]  android: Remove error checking for
 debugfs_create_dir()
Message-ID: <2023071310-unbounded-alkalize-a491@gregkh>
References: <20230713080649.1893-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713080649.1893-1-machel@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:06:37PM +0800, Wang Ming wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in binder_init().
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/android/binder.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 486c8271cab7..49d84a6c4594 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6557,6 +6557,7 @@ static int __init binder_init(void)
>  	struct binder_device *device;
>  	struct hlist_node *tmp;
>  	char *device_names = NULL;
> +	const struct binder_debugfs_entry *db_entry;
>  
>  	ret = binder_alloc_shrinker_init();
>  	if (ret)
> @@ -6566,19 +6567,16 @@ static int __init binder_init(void)
>  	atomic_set(&binder_transaction_log_failed.cur, ~0U);
>  
>  	binder_debugfs_dir_entry_root = debugfs_create_dir("binder", NULL);
> -	if (binder_debugfs_dir_entry_root) {
> -		const struct binder_debugfs_entry *db_entry;
>  
> -		binder_for_each_debugfs_entry(db_entry)
> -			debugfs_create_file(db_entry->name,
> -					    db_entry->mode,
> -					    binder_debugfs_dir_entry_root,
> -					    db_entry->data,
> -					    db_entry->fops);
> +	binder_for_each_debugfs_entry(db_entry)
> +		debugfs_create_file(db_entry->name,
> +					db_entry->mode,
> +					binder_debugfs_dir_entry_root,
> +					db_entry->data,
> +					db_entry->fops);
>  
> -		binder_debugfs_dir_entry_proc = debugfs_create_dir("proc",
> -						 binder_debugfs_dir_entry_root);
> -	}
> +	binder_debugfs_dir_entry_proc = debugfs_create_dir("proc",
> +						binder_debugfs_dir_entry_root);
>  
>  	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
>  	    strcmp(binder_devices_param, "") != 0) {
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
