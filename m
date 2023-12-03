Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10933802593
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjLCQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCQlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:41:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B6CE8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:41:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4D5C433C8;
        Sun,  3 Dec 2023 16:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701621687;
        bh=26wMpKPKrZag2Orm0i9X0BOac/BjRVT4g0G/xCMIVbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juUirD9srFrqrXnYOjDnYd+GqPB4NlmOjL8mdit7pIcQv5v4zPCbZwOAuj/URla8T
         LF2I2KGM3/3C8DG3KmQMIYBAEJyV7esvk+KfO6rEoNzEsP9OgkKEM8Has0b0XY1fw+
         f6rjAhOkVcskFLMxQwmCsGh05Vo7Tx04fZrfoR6mJ9NrDrXT2sRKBhHes3gGhzcyxm
         ZKgkuh5mNHiM/JnNp3wAb3WVAZMXbmln0OngrDtYv4svXtrH7STz+xI0IiYIZapTj2
         dNHZCjNWY3fOI4+O9cXxnT/fGUeN2C7xBH/rrb4ru/QzSzGclP5KSSRIM8ir5PUpUv
         OzchAtbJXHGnQ==
Date:   Sun, 3 Dec 2023 16:41:21 +0000
From:   Simon Horman <horms@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 1/5] octeontx2-af: Adjust Tx credits when MCS
 external bypass is disabled
Message-ID: <20231203164121.GK50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-2-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-2-gakula@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:28:14PM +0530, Geetha sowjanya wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> When MCS external bypass is disabled, MCS returns additional
> 2 credits(32B) for every packet Tx'ed on LMAC. To account for
> these extra credits, NIX_AF_TX_LINKX_NORM_CREDIT.CC_MCS_CNT
> needs to be configured as otherwise NIX Tx credits would overflow
> and will never be returned to idle state credit count
> causing issues with credit control and MTU change.
> 
> This patch fixes the same by configuring CC_MCS_CNT at probe
> time for MCS enabled SoC's
> 
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Hi Geetha and Nithin,

some minor feedback from my side.

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.c     | 12 ++++++++++++
>  drivers/net/ethernet/marvell/octeontx2/af/mcs.h     |  2 ++
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  1 +
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 ++++++++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index c43f19dfbd74..d6effbe46208 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> @@ -1219,6 +1219,17 @@ struct mcs *mcs_get_pdata(int mcs_id)
>  	return NULL;
>  }
>  
> +bool is_mcs_bypass(int mcs_id)
> +{
> +	struct mcs *mcs_dev;
> +
> +	list_for_each_entry(mcs_dev, &mcs_list, mcs_list) {
> +		if (mcs_dev->mcs_id == mcs_id)
> +			return mcs_dev->bypass;
> +	}
> +	return true;
> +}
> +
>  void mcs_set_port_cfg(struct mcs *mcs, struct mcs_port_cfg_set_req *req)
>  {
>  	u64 val = 0;
> @@ -1447,6 +1458,7 @@ static void mcs_set_external_bypass(struct mcs *mcs, u8 bypass)
>  	else
>  		val &= ~BIT_ULL(6);
>  	mcs_reg_write(mcs, MCSX_MIL_GLOBAL, val);
> +	mcs->bypass = bypass;

I think that bool would be a more appropriate type than u8 for:

* The bypass parameter of mcs_set_external_bypass()
* The bypass field of struct mcs

>  }
>  
>  static void mcs_global_cfg(struct mcs *mcs)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
> index 0f89dcb76465..ccd43c3f3460 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
> @@ -149,6 +149,7 @@ struct mcs {
>  	u16			num_vec;
>  	void			*rvu;
>  	u16			*tx_sa_active;
> +	u8                      bypass;
>  };
>  
>  struct mcs_ops {
> @@ -206,6 +207,7 @@ void mcs_get_custom_tag_cfg(struct mcs *mcs, struct mcs_custom_tag_cfg_get_req *
>  int mcs_alloc_ctrlpktrule(struct rsrc_bmap *rsrc, u16 *pf_map, u16 offset, u16 pcifunc);
>  int mcs_free_ctrlpktrule(struct mcs *mcs, struct mcs_free_ctrl_pkt_rule_req *req);
>  int mcs_ctrlpktrule_write(struct mcs *mcs, struct mcs_ctrl_pkt_rule_write_req *req);
> +bool is_mcs_bypass(int mcs_id);
>  
>  /* CN10K-B APIs */
>  void cn10kb_mcs_set_hw_capabilities(struct mcs *mcs);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index c4d999ef5ab4..9887edccadf7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -345,6 +345,7 @@ struct nix_hw {
>  	struct nix_txvlan txvlan;
>  	struct nix_ipolicer *ipolicer;
>  	u64    *tx_credits;
> +	u64 cc_mcs_cnt;
>  };
>  
>  /* RVU block's capabilities or functionality,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index c112c71ff576..daafce5fef46 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -12,6 +12,7 @@
>  #include "rvu_reg.h"
>  #include "rvu.h"
>  #include "npc.h"
> +#include "mcs.h"
>  #include "cgx.h"
>  #include "lmac_common.h"
>  #include "rvu_npc_hash.h"
> @@ -4389,6 +4390,12 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
>  			    SDP_HW_MAX_FRS << 16 | NIC_HW_MIN_FRS);
>  	}
>  
> +	/* Get MCS external bypass status for CN10K-B */
> +	if (mcs_get_blkcnt() == 1) {
> +		/* Adjust for 2 credits when external bypass is disabled */
> +		nix_hw->cc_mcs_cnt = is_mcs_bypass(0) ? 0 : 2;

Perhaps it doesn't matter, but to me it seems a bit excessive to use a
64-bit field to store such small values.

> +	}
> +
>  	/* Set credits for Tx links assuming max packet length allowed.
>  	 * This will be reconfigured based on MTU set for PF/VF.
>  	 */
> @@ -4412,6 +4419,7 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
>  			tx_credits = (lmac_fifo_len - lmac_max_frs) / 16;
>  			/* Enable credits and set credit pkt count to max allowed */
>  			cfg =  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
> +			cfg |= (nix_hw->cc_mcs_cnt << 32);

I do see that cc_mcs_cnt needs to be 64-bit here to avoid truncation.
But overall I think this function could benefit from the use
of FIELD_PREP(), which I think would side-step that problem.

>  
>  			link = iter + slink;
>  			nix_hw->tx_credits[link] = tx_credits;
> -- 
> 2.25.1
> 
