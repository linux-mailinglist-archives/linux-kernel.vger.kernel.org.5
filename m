Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B020C7BC871
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343941AbjJGOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjJGOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:52:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E381B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 07:52:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D519C433C7;
        Sat,  7 Oct 2023 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696690342;
        bh=kykrOis2w1PaWsK9svmGejE5QwtogNC++rLKy8pBryA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oA72+nIDoigy2eNMFHURszzd0IgFdTFO9R40WkcdJVNxaEIQPxXFZE2fmMvarXTeh
         n7NquBUhhwcX8G8hfOnsWpKtLuaXcCIEkn1EdHLodVTXx5pbmCDHNHafwuikmQ56EK
         +LMFxs3jqagd8WsPMnRczNy67dbeX8uoWQ7weMF1DW6HzdmcJAKJMHah6PBPMK+zRG
         ZDqOXKTmWZ+/T9G2YnnfyiViqbzvdr0GtFAOespBKwE/O9UkdlgIUiGDH4tbXsRndO
         gb/PenUBKRhSn0e0+3YARjsay6SOQQUyyhxl7QiBFZQ26XvCacEIWSvzli7thrhmXk
         E6X652S33tz/w==
Date:   Sat, 7 Oct 2023 16:52:17 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, richardcochran@gmail.com, lcherian@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
Subject: Re: [net PATCH v2] octeontx2-af: Fix hardware timestamping for VFs
Message-ID: <20231007145217.GB831234@kernel.org>
References: <20231003110504.913980-1-saikrishnag@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003110504.913980-1-saikrishnag@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:35:04PM +0530, Sai Krishna wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Currently for VFs, mailbox returns ENODEV error when hardware timestamping
> enable is requested. This patch fixes this issue. Modified this patch to
> return EPERM error for the PF/VFs which are not attached to CGX/RPM.
> 
> Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index f2b1edf1bb43..f464640e188b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -756,12 +756,11 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
>  	if (!is_mac_feature_supported(rvu, pf, RVU_LMAC_FEAT_PTP))
>  		return 0;
>  
> -	/* This msg is expected only from PFs that are mapped to CGX LMACs,
> +	/* This msg is expected only from PF/VFs that are mapped to CGX/RPM LMACs,
>  	 * if received from other PF/VF simply ACK, nothing to do.
>  	 */
> -	if ((pcifunc & RVU_PFVF_FUNC_MASK) ||
> -	    !is_pf_cgxmapped(rvu, pf))
> -		return -ENODEV;
> +	if (!is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)))

Hi Sai,

I'm not clear on why this change substitutes pf for rvu_get_pf(pcifunc),
as futher above in this function pf is set to the return value of
rvu_get_pf(pcifunc).

> +		return -EPERM;
>  
>  	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
>  	cgxd = rvu_cgx_pdata(cgx_id, rvu);
> -- 
> 2.25.1
> 
> 
