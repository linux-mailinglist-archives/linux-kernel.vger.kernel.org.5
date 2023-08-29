Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8232278C9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjH2Ql6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjH2Qlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:41:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB4185;
        Tue, 29 Aug 2023 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kDD6H57sq+SrWz/GCV0uZMPVhTELhKclCp7y6s7deVQ=; b=Da/2oEcINCS7ujsIMHtHgpSKhs
        BhJrG3uR6q6OkTEM4K8J3lYq3LD9qtUJUYlFIcOsS3UnhHIr0bWnOoDyFuthq+kECIRrnyt3uGVm2
        vY4mLta0XeZLohVYE+JDcWTqIjyTpVTUL+6yBFZcQVKyapYs1Q82wZvYx2b04TeARF7DOzZMZB0qX
        /rBM8usNcjfdHB7zQ55kMGtj7/XagRX/6ToFxCQjhhHeCRI73eCEflJW14AKV/zvsGMmz78kXzO0F
        lc7k5npZCbtB54DXKF3FpjxJSClEZT5smRXmfWB3Ug3NCzWOwVvN85+5C7aAp0Gz1ri9JjM4XsQbb
        APr6PZ6Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qb1mW-00Bru3-1W;
        Tue, 29 Aug 2023 16:41:32 +0000
Date:   Tue, 29 Aug 2023 09:41:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module/decompress: use vmalloc() for zstd decompression
 workspace
Message-ID: <ZO4fvAKJfKs8USZO@bombadil.infradead.org>
References: <20230829120508.317611-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829120508.317611-1-andrea.righi@canonical.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:05:08PM +0200, Andrea Righi wrote:
> Using kmalloc() to allocate the decompression workspace for zstd may
> trigger the following warning when large modules are loaded (i.e., xfs):
> 
> [    2.961884] WARNING: CPU: 1 PID: 254 at mm/page_alloc.c:4453 __alloc_pages+0x2c3/0x350
> ...
> [    2.989033] Call Trace:
> [    2.989841]  <TASK>
> [    2.990614]  ? show_regs+0x6d/0x80
> [    2.991573]  ? __warn+0x89/0x160
> [    2.992485]  ? __alloc_pages+0x2c3/0x350
> [    2.993520]  ? report_bug+0x17e/0x1b0
> [    2.994506]  ? handle_bug+0x51/0xa0
> [    2.995474]  ? exc_invalid_op+0x18/0x80
> [    2.996469]  ? asm_exc_invalid_op+0x1b/0x20
> [    2.997530]  ? module_zstd_decompress+0xdc/0x2a0
> [    2.998665]  ? __alloc_pages+0x2c3/0x350
> [    2.999695]  ? module_zstd_decompress+0xdc/0x2a0
> [    3.000821]  __kmalloc_large_node+0x7a/0x150
> [    3.001920]  __kmalloc+0xdb/0x170
> [    3.002824]  module_zstd_decompress+0xdc/0x2a0
> [    3.003857]  module_decompress+0x37/0xc0
> [    3.004688]  init_module_from_file+0xd0/0x100
> [    3.005668]  idempotent_init_module+0x11c/0x2b0
> [    3.006632]  __x64_sys_finit_module+0x64/0xd0
> [    3.007568]  do_syscall_64+0x59/0x90
> [    3.008373]  ? ksys_read+0x73/0x100
> [    3.009395]  ? exit_to_user_mode_prepare+0x30/0xb0
> [    3.010531]  ? syscall_exit_to_user_mode+0x37/0x60
> [    3.011662]  ? do_syscall_64+0x68/0x90
> [    3.012511]  ? do_syscall_64+0x68/0x90
> [    3.013364]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> However, continuous physical memory does not seem to be required in
> module_zstd_decompress(), so use vmalloc() instead, to prevent the
> warning and avoid potential failures at loading compressed modules.
> 
> Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  kernel/module/decompress.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 8a5d6d63b06c..87440f714c0c 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
>  	}
>  
>  	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
> -	wksp = kmalloc(wksp_size, GFP_KERNEL);
> +	wksp = vmalloc(wksp_size);
>  	if (!wksp) {
>  		retval = -ENOMEM;
>  		goto out;
> @@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
>  	retval = new_size;
>  
>   out:
> -	kfree(wksp);
> +	vfree(wksp);
>  	return retval;

Thanks! Applied and queued up.

  Luis
