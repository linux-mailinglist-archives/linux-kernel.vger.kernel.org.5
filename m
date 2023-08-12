Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D43779F81
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjHLLLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHLLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D412A;
        Sat, 12 Aug 2023 04:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 269C861113;
        Sat, 12 Aug 2023 11:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C68AC433C8;
        Sat, 12 Aug 2023 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691838680;
        bh=jaTzjZessMaVnDkeWmo2jtJy8GiyLFaOtT4f523mTLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RyqJOmQnz78FgotzOAZmoyoBKkI+w7uCqhLOzxZeCzEPE+pwkzilHKwT+xv/ssVKa
         4yvHT/2RvZjHN5TSNQtMMe1jUpeEb1tLX312qfn0ai61B6OR6DmDuGw6bieATqY4Cj
         94dPYC+A3rM6WYujdh1ldyjUdl0RQJnzDqW3qpeA=
Date:   Sat, 12 Aug 2023 13:11:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] devtmpfs: Add missing lockdep annotation
Message-ID: <2023081210-deputy-emboss-f348@gregkh>
References: <ZNZblen+NXOrW9wE@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNZblen+NXOrW9wE@p100>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 06:02:29PM +0200, Helge Deller wrote:
> Add the lockdep annotation to the setup_done completer to avoid this
> kernel warning:
> 
>  Backtrace:
>   [<000000004030bcd0>] show_stack+0x74/0xb0
>   [<000000004146c63c>] dump_stack_lvl+0x104/0x180
>   [<000000004146c6ec>] dump_stack+0x34/0x48
>   [<000000004040e5b4>] register_lock_class+0xd24/0xd30
>   [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
>   [<000000004040cd60>] lock_acquire+0x130/0x298
>   [<000000004147095c>] _raw_spin_lock_irq+0x60/0xb8
>   [<0000000041474a4c>] wait_for_completion+0xa0/0x2d0
>   [<000000004015d9f4>] devtmpfs_init+0x1e0/0x2b8
>   [<000000004015d0e4>] driver_init+0x68/0x1b8
>   [<0000000040102b68>] kernel_init_freeable+0x4ac/0x7f0
>   [<000000004146df68>] kernel_init+0x64/0x3a8
>   [<0000000040302020>] ret_from_kernel_thread+0x20/0x28
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index b848764ef018..f98d58b0225c 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -462,6 +462,7 @@ int __init devtmpfs_init(void)
>  		return err;
>  	}
> 
> +	init_completion(&setup_done);
>  	thread = kthread_run(devtmpfsd, &err, "kdevtmpfs");
>  	if (!IS_ERR(thread)) {
>  		wait_for_completion(&setup_done);

What changed to required this now?  What commit id does this fix?  Why
doesn't the declaration of DECLARE_COMPLETION() initialize this properly
for us already?

thanks,

greg k-h
