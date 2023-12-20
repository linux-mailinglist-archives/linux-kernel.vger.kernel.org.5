Return-Path: <linux-kernel+bounces-6393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622AC819852
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182AE288419
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3D10A1E;
	Wed, 20 Dec 2023 05:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Is2ulEUy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BEFBE0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023DEC433C7;
	Wed, 20 Dec 2023 05:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703051700;
	bh=zE9hoKwZT+bG6e1yHAU5+of3///p6PjdlDHA78HKQPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Is2ulEUyuofkPlTvO6X55Asge8NJcY2XvxzW+07OR4UOTQda9F7j0TNqisPdYj6bF
	 2r7onrvQnRdHTcVl5TpkxHBdPMuN2yICBG7Hn9SkrX/NjUp5eGmYv9ppnxOE3MvNyb
	 GvVoFfu0OtFeWaFL9ckxfSisU9kya7NWizmC0FrY=
Date: Wed, 20 Dec 2023 06:54:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jing Xia <jing.xia@unisoc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	jing.xia.mail@gmail.com, xuewen.yan@unisoc.com, ke.wang@unisoc.com,
	chunyan.zhang@unisoc.com
Subject: Re: [PATCH V2] class: fix use-after-free in class_register()
Message-ID: <2023122046-justifier-shriek-6254@gregkh>
References: <20231220024603.186078-1-jing.xia@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220024603.186078-1-jing.xia@unisoc.com>

On Wed, Dec 20, 2023 at 10:46:03AM +0800, Jing Xia wrote:
> The lock_class_key is still registered and can be found in
> lock_keys_hash hlist after subsys_private is freed in error
> handler path.A task who iterate over the lock_keys_hash
> later may cause use-after-free.So fix that up and unregister
> the lock_class_key before kfree(cp).
> 
> On our platform, a driver fails to kset_register because of
> creating duplicate filename '/class/xxx'.With Kasan enabled,
> it prints a invalid-access bug report.
> 
> KASAN bug report:
> 
> BUG: KASAN: invalid-access in lockdep_register_key+0x19c/0x1bc
> Write of size 8 at addr 15ffff808b8c0368 by task modprobe/252
> Pointer tag: [15], memory tag: [fe]
> 
> CPU: 7 PID: 252 Comm: modprobe Tainted: G        W
>  6.6.0-mainline-maybe-dirty #1
> 
> Call trace:
> dump_backtrace+0x1b0/0x1e4
> show_stack+0x2c/0x40
> dump_stack_lvl+0xac/0xe0
> print_report+0x18c/0x4d8
> kasan_report+0xe8/0x148
> __hwasan_store8_noabort+0x88/0x98
> lockdep_register_key+0x19c/0x1bc
> class_register+0x94/0x1ec
> init_module+0xbc/0xf48 [rfkill]
> do_one_initcall+0x17c/0x72c
> do_init_module+0x19c/0x3f8
> ...
> Memory state around the buggy address:
> ffffff808b8c0100: 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a 8a
> ffffff808b8c0200: 8a 8a 8a 8a 8a 8a 8a 8a fe fe fe fe fe fe fe fe
> >ffffff808b8c0300: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>                                      ^
> ffffff808b8c0400: 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
> 
> As CONFIG_KASAN_GENERIC is not set, Kasan reports invalid-access
> not use-after-free here.In this case, modprobe is manipulating
> the corrupted lock_keys_hash hlish where lock_class_key is already
> freed before.
> 
> It's worth noting that this only can happen if lockdep is enabled,
> which is not true for normal system.
> 
> Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/base/class.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 7e78aee0fd6c..7b38fdf8e1d7 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -213,6 +213,7 @@ int class_register(const struct class *cls)
>  	return 0;
>  
>  err_out:
> +	lockdep_unregister_key(key);
>  	kfree(cp);
>  	return error;
>  }
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

