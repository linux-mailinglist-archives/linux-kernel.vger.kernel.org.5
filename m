Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7E75FED4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjGXSLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87493
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C14661280
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C635AC433C8;
        Mon, 24 Jul 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690222269;
        bh=lVl/AoyoC3+s3150PJB7m2OVF2U2VY5mosVKutorV/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLxx1cJ7WRLyBjboZj27c0pna1eGR+fCO+km4x5R9cBWxpNR9AHc2zVnostvDm33y
         ouKZWeqCO2jyWpcuzSGXqJsKjcw1BQTyMWv2cer8LbSL/juksaHecI7R9I0KtTHmFv
         +tErBrJc5HiKIY4YislKAQKbpCW0JAEMHKDR4rBYYWjRcFAk80SCF3kn4k0lH/cUUd
         /4N3YPyo8/Is+KPdHWY14mAjm1cE6lghRAQM+jTfzxse8ZErgC8dinjpoRtmmPXynY
         s9waxOgIcU18SW6csvbm2epdLW0999zHzd7XmazwwKeRel0yU6LaUu2A9V1cqAzTib
         lyPASW3sHewcg==
Date:   Mon, 24 Jul 2023 21:11:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ilia Lin <ilia.lin@kernel.org>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230724181105.GD11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724090044.2668064-1-ilia.lin@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:00:44PM +0300, Ilia Lin wrote:
> If XFRM_OFFLOAD is configured, but XFRM is not

How did you do it?

>, it will cause
> compilation error on include xfrm.h:
>  C 05:56:39 In file included from /src/linux/kernel_platform/msm-kernel/net/core/sock.c:127:
>  C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.h:1932:30: error: no member named 'xfrm' in 'struct dst_entry'
>  C 05:56:39         struct xfrm_state *x = dst->xfrm;
>  C 05:56:39                                ~~~  ^
> 
> Making the XFRM_OFFLOAD select the XFRM.
> 
> Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
> Reported-by: Ilia Lin <ilia.lin@kernel.org>
> Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> ---
>  net/xfrm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index 3adf31a83a79a..3fc2c1bcb5bbe 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -10,6 +10,7 @@ config XFRM
> 
>  config XFRM_OFFLOAD
>  	bool
> +	select XFRM

struct dst_entry depends on CONFIG_XFRM and not on CONFIG_XFRM_OFFLOAD,
so it is unclear to me why do you need to add new "select XFRM" line.

   26 struct dst_entry {
   27         struct net_device       *dev;
   28         struct  dst_ops         *ops;
   29         unsigned long           _metrics;
   30         unsigned long           expires;
   31 #ifdef CONFIG_XFRM
   32         struct xfrm_state       *xfrm;
   33 #else
   34         void                    *__pad1;
   35 #endif
   36         int

Thanks
