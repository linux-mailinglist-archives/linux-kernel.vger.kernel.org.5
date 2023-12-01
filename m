Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30BE8009F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378577AbjLALe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378541AbjLALe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:34:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B263CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:35:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5443AC433C8;
        Fri,  1 Dec 2023 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701430503;
        bh=bAkOKZYHWz/B6ZGojduBi42RS2pXekoCHVmKsM+KArI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mn0YDiwFNb08kiD6dNABvWp7l8WtnwibCdgonnaOwbp1itZwfh4Tlx5+66qirmbGh
         r9Lcrm/m9evgsndO4KfaM3W31iwHQLiilkp9Nl0M5513m4NX6yvybmsF05tnRm/CFs
         dgAQEWVKRO0eVzRdc2ykXRsih+t7lAns5P8+s1uYdv2+J2xS/ex43dxDkl8691GpEX
         IOMnDdk5l7SLOJXJm6NyRttFpBvYqE4wpYr6tnoJo0Z0/oDiexOr+jfovNVFA019TW
         JeDq5j+0eFOdkx+W9/MpTihQhiq0G4GXScOqEP9O3N1pgjbq836l+5M/WugHP1W9bw
         3W15ZN3K90n/w==
Date:   Fri, 1 Dec 2023 11:34:56 +0000
From:   Simon Horman <horms@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, pbhagavatula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com
Subject: Re: [net-next PATCH] octeontx2-af: cn10k: Increase outstanding LMTST
 transactions
Message-ID: <20231201113456.GU32077@kernel.org>
References: <20231129112155.9967-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129112155.9967-1-gakula@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:51:55PM +0530, Geetha sowjanya wrote:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Currently the number of outstanding store transactions issued by AP as
> a part of LMTST operation is set to 1 i.e default value.
> This patch set to max supported value to increase the performance.
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> index 0e74c5a2231e..93fedabfe31e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
> @@ -559,3 +559,12 @@ void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw)
>  	cfg |= BIT_ULL(1) | BIT_ULL(2);
>  	rvu_write64(rvu, blkaddr, NIX_AF_CFG, cfg);
>  }
> +
> +void rvu_apr_block_cn10k_init(struct rvu *rvu)
> +{
> +	u64 reg;
> +
> +	reg = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
> +	reg |= 0xFULL << 35;

Hi Pavan and Geetha,

I think it would be best to avoid the magic value 35 here.

Best would probably be to use GENMASK_ULL and FIELD_PREP.
Else defining something similar to APR_LMT_MAP_ENT_SCH_ENA_SHIFT.

It might also be nice to avoid the magic value 0xFULL using a #define.

> +	rvu_write64(rvu, BLKADDR_APR, APR_AF_LMT_CFG, reg);
> +}
> -- 
> 2.25.1
> 
