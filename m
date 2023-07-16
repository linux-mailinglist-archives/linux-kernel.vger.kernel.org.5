Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE324754F5E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGPPUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGPPUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84BA8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0280860BD6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D00C433C8;
        Sun, 16 Jul 2023 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689520821;
        bh=72ikFVHayvUhCOUqEUnivclFjsyClhyTTmSahMGBE3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yZvdeqFGDdgW22R+V1j+1f09Hyen2Ep6ijbAinq2tR/FTpL8mnTdzY/WMsnwV2vF+
         PKd8R78vntNQEW8jP/IOrulpua7jKrKqM5xBqno4suhZMvPmyR1SH97y8dOp3sqjxr
         kahCNgBrQEq8uD7g+RBZyvGYf+MPd0LuNGHa/8So=
Date:   Sun, 16 Jul 2023 17:20:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, Richard Yeh <rcy@google.com>,
        John Joseph <jnjoseph@google.com>,
        Simon Que <sque@chromium.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10] gasket: make interrupt_data NULL after free
Message-ID: <2023071601-uncombed-stifling-bb3a@gregkh>
References: <20230707134712.7019-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707134712.7019-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:47:12PM +0300, Anastasia Belova wrote:
> Gasket common interrupt module was deleted in version 5.13, 
> but there is possible double free in versions 4.19-5.12.
> 
> gasket_dev->interrupt_data should be NULL when
> gasket_interrupt_init returns error. For example,
> it is necessary in gasket_enable_device to avoid
> double free.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex driver")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/staging/gasket/gasket_interrupt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
> index 864342acfd86..24fa5df0628b 100644
> --- a/drivers/staging/gasket/gasket_interrupt.c
> +++ b/drivers/staging/gasket/gasket_interrupt.c
> @@ -337,6 +337,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>  			sizeof(*interrupt_data->eventfd_ctxs), GFP_KERNEL);
>  	if (!interrupt_data->eventfd_ctxs) {
>  		kfree(interrupt_data);
> +		gasket_dev->interrupt_data = NULL;
>  		return -ENOMEM;
>  	}
>  
> @@ -346,6 +347,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
>  	if (!interrupt_data->interrupt_counts) {
>  		kfree(interrupt_data->eventfd_ctxs);
>  		kfree(interrupt_data);
> +		gasket_dev->interrupt_data = NULL;
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.30.2
> 

As this can never happen in real life, and no one is using this code,
I'm going to ignore this patch for now, sorry.

greg k-h
