Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8448025DB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjLCRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:00:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFDCD7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:01:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571AAC433C8;
        Sun,  3 Dec 2023 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701622860;
        bh=IBq5e7Qm+LW9YAeuTlUc2gKVcMbeUUXh3+yS9ucUOFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9M5mfsAxI9P6KoSJ74x6KzdIPxaZVD/yGyJqLyXU5DV1d46fbvniXQcXKh02nVE5
         XgZZyLeGfB1Zaw66upfe2G/ySXnRNC6G3tUo4Sqqp+7JakCFE/JkY3YYkllyoM9fof
         IYHDUKN1aP7PcxNB8iVlzmAtO2U81MQ43JYT4SvXtwdnVBKgwYOPJVn2tuwdANaPpS
         1voftH7dBwsiOwSTZ2tRP0Vzf/tcyBqA7p/2X15Cc6UoYVZ+XHi7Tu2opnNU6BVuUu
         zV96CmNa79SEY/7hZkpPRfGi3zxFDtuXwFC2eYa/piuhOZzja+fSAB2U/ikntjPvkf
         Tss/3SJ/RCRAA==
Date:   Sun, 3 Dec 2023 17:00:54 +0000
From:   Simon Horman <horms@kernel.org>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net v3 PATCH 3/5] octeontx2-af: Fix mcs stats register address
Message-ID: <20231203170054.GL50400@kernel.org>
References: <20231130075818.18401-1-gakula@marvell.com>
 <20231130075818.18401-4-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130075818.18401-4-gakula@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:28:16PM +0530, Geetha sowjanya wrote:
> This patch adds the miss mcs stats register
> for mcs supported platforms.
> 
> Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mcs.c   |  4 +--
>  .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index d6effbe46208..d4a4e4c837ec 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> @@ -117,7 +117,7 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
>  	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYTAGGEDCTLX(id);
>  	stats->pkt_tagged_ctl_cnt = mcs_reg_read(mcs, reg);
>  
> -	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(id);
> +	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
>  	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
>  
>  	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
> @@ -215,7 +215,7 @@ void mcs_get_sc_stats(struct mcs *mcs, struct mcs_sc_stats *stats,
>  		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCNOTVALIDX(id);
>  		stats->pkt_notvalid_cnt = mcs_reg_read(mcs, reg);
>  
> -		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(id);
> +		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(id);
>  		stats->pkt_unchecked_cnt = mcs_reg_read(mcs, reg);
>  
>  		if (mcs->hw->mcs_blks > 1) {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> index f3ab01fc363c..f4c6de89002c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> @@ -810,14 +810,37 @@
>  		offset = 0x9d8ull;			\
>  	offset; })
>  
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(a) ({	\
> +	u64 offset;					\
> +							\
> +	offset = 0xee80ull;				\
> +	if (mcs->hw->mcs_blks > 1)			\
> +		offset = 0xe818ull;			\
> +	offset += (a) * 0x8ull;				\
> +	offset; })

Hi Geetha,

I see this is consistent with existing code in this file,
but I do wonder if there would be value in moving to a more
compact mechanism at some point. F.e. (completely untested!):

#define MCSX_REG(base, a) ((base) + (a) * 0x8ull)
#define MCSX_MB_REG(base_mb, base, a) \
        MCSX_REG((mcs->hw->mcs_blks > 1 ? (base_mb) : (base)), (a))
...
#define MCSX_MCS_TOP_SLAVE_PORT_RESET(a) MCSX_MB_REG(0xa28ull, 0x408ull, (a))
...
#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a) MCSX_REG(0xb680ull, (a))
...

In any case, such a change isn't for this patch, which looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> +
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a) ({	\
> +	u64 offset;					\
> +							\
> +	offset = 0xa680ull;				\
> +	if (mcs->hw->mcs_blks > 1)			\
> +		offset = 0xd018ull;			\
> +	offset += (a) * 0x8ull;				\
> +	offset; })
> +
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a)	({	\
> +	u64 offset;						\
> +								\
> +	offset = 0xf680ull;					\
> +	if (mcs->hw->mcs_blks > 1)				\
> +		offset = 0xe018ull;				\
> +	offset += (a) * 0x8ull;					\
> +	offset; })
> +
>  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCDECRYPTEDX(a)	(0xe680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCVALIDATEX(a)	(0xde80ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(a)	(0xa680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(a)	(0xd218 + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a)	(0xd018ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(a)	(0xee80ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a)		(0xb680ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a) (0xf680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSAINVALIDX(a)	(0x12680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTUSINGSAERRORX(a) (0x15680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTVALIDX(a)	(0x13680ull + (a) * 0x8ull)
> -- 
> 2.25.1
> 
