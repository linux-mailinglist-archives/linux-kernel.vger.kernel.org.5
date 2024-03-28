Return-Path: <linux-kernel+bounces-123123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BFA890272
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E02295890
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BC380028;
	Thu, 28 Mar 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETd01BtU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF47E56E;
	Thu, 28 Mar 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637905; cv=none; b=bEdZi38Vbjy3IYRQFJZbj67qOzLJeazDoxyd7dp55eZ7Q3s/ogyUwJYjC27t32zAj2ADktGZyYituwIA+fUMmUOUSbis3483VtzMIMrKdBT9WkqsWaN1ChlIwIDQ0FkLoROnKquhEibzy4i/50e10yTCIClpWe5hH2TKJyOPr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637905; c=relaxed/simple;
	bh=KE28sO4h/UaOjEn9eEmHuxOAJzdiKt3XKrBSNlZvEK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2LwD2JlV2mjWHDIZ2L9hAxhOEl/+R4DNHnbWAK8MrOW77q6352BAkkS8A8j8ne7lAtqWEUU/xfB3ayDMT4UBFk4NcZ0FKGq1H9/AJ2knt1mf16//+oms1MSFpHvw8tfsmo4nZkLlNVKK+hNwMZpg2aTBERC2rFrujuUyeLDJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETd01BtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF32C433C7;
	Thu, 28 Mar 2024 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711637904;
	bh=KE28sO4h/UaOjEn9eEmHuxOAJzdiKt3XKrBSNlZvEK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETd01BtUu1iBbG7kPAosbZdnMWU0YU79BNgBeIFaA4NqD0ZG7SQSIw09tYMePW+bG
	 HRc258xosQbqXItAV0nMZt+X3XenYrjIN5y1q/kD8ox/WQr7BkZnl6bckqCUdLnqn7
	 QONob5QYEc1JvvaEqohC3GJ5DV+lDSR+GCaEVufqpGHXEWRXNJxBmSe/4a7WG34VKr
	 6Keu2ioXEp4oKiuf/mWA68tsI40khBx/IrooKVj3xA3QzqevVyyE29KgFDDaYkVSLK
	 rclLH0oyd3nvaBwId5sqrtqKF+XsiYIZJ5+Zc4F/yOAoRVd0N9uxisyYkO2QDx0Fpv
	 X92pGfkorGY6A==
Date: Thu, 28 Mar 2024 14:58:19 +0000
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
	naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com
Subject: Re: [net-next Patch] octeontx2-af: map management port always to
 first PF
Message-ID: <20240328145819.GN403975@kernel.org>
References: <20240327160348.3023-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327160348.3023-1-hkelam@marvell.com>

On Wed, Mar 27, 2024 at 09:33:48PM +0530, Hariprasad Kelam wrote:
> The user can enable or disable any MAC block or a few ports of the
> block. The management port's interface name varies depending on the
> setup of the user if its not mapped to the first pf.
> 
> The management port mapping is now configured to always connect to the
> first PF. This patch implements this change.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>

Hi Hariprasad and Sunil,

some feedback from my side.

> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
>  .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 60 +++++++++++++++----
>  2 files changed, 53 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index eb2a20b5a0d0..105d2e8f25df 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -638,7 +638,10 @@ struct cgx_lmac_fwdata_s {
>  	/* Only applicable if SFP/QSFP slot is present */
>  	struct sfp_eeprom_s sfp_eeprom;
>  	struct phy_s phy;
> -#define LMAC_FWDATA_RESERVED_MEM 1021
> +	u32 lmac_type;
> +	u32 portm_idx;
> +	u64 mgmt_port:1;
> +#define LMAC_FWDATA_RESERVED_MEM 1019
>  	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
>  };
>  
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 72e060cf6b61..446344801576 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -118,15 +118,40 @@ static void rvu_map_cgx_nix_block(struct rvu *rvu, int pf,
>  		pfvf->nix_blkaddr = BLKADDR_NIX1;
>  }
>  
> -static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
> +static bool rvu_cgx_is_mgmt_port(struct rvu *rvu, int cgx_id, int lmac_id)
> +{
> +	struct cgx_lmac_fwdata_s *fwdata;
> +
> +	fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];
> +	if (fwdata->mgmt_port)
> +		return true;
> +
> +	return false;

nit: I think this could be more succinctly expressed as:

	return !!fwdata->mgmt_port;

> +}
> +
> +static void __rvu_map_cgx_lmac_pf(struct rvu *rvu, int pf, int cgx, int lmac)
>  {
>  	struct npc_pkind *pkind = &rvu->hw->pkind;
> +	int numvfs, hwvfs;
> +	int free_pkind;
> +
> +	rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
> +	rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;

This isn't strictly related to this patch, but here
it seems implied that pf is not negative and <= 63, as
rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] is only 64 bits wide.

So firstly I wonder if pf should be unsigned

> +	free_pkind = rvu_alloc_rsrc(&pkind->rsrc);
> +	pkind->pfchan_map[free_pkind] = ((pf) & 0x3F) << 16;

Here pf is masked off so it is not more than 63.
But that seems to conflict with the assumption above that it is <= 63.

If there is a concern about it being larger, it should be
capped in the for loop that calls __rvu_map_cgx_lmac_pf() ?

> +	rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
> +	rvu->cgx_mapped_pfs++;
> +	rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
> +	rvu->cgx_mapped_vfs += numvfs;
> +}
> +
> +static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
> +{
>  	int cgx_cnt_max = rvu->cgx_cnt_max;
>  	int pf = PF_CGXMAP_BASE;
>  	unsigned long lmac_bmap;
> -	int size, free_pkind;
>  	int cgx, lmac, iter;
> -	int numvfs, hwvfs;
> +	int size;
>  
>  	if (!cgx_cnt_max)
>  		return 0;
> @@ -155,6 +180,24 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
>  		return -ENOMEM;
>  
>  	rvu->cgx_mapped_pfs = 0;
> +
> +	/* Map mgmt port always to first PF */
> +	for (cgx = 0; cgx < cgx_cnt_max; cgx++) {
> +		if (!rvu_cgx_pdata(cgx, rvu))
> +			continue;
> +		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
> +		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
> +			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu), iter);
> +			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac)) {
> +				__rvu_map_cgx_lmac_pf(rvu, pf, cgx, lmac);
> +				pf++;
> +				goto non_mgmtport_mapping;
> +			}
> +		}
> +	}
> +
> +non_mgmtport_mapping:
> +
>  	for (cgx = 0; cgx < cgx_cnt_max; cgx++) {
>  		if (!rvu_cgx_pdata(cgx, rvu))
>  			continue;
> @@ -162,14 +205,9 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
>  		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
>  			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
>  					      iter);
> -			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
> -			rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;
> -			free_pkind = rvu_alloc_rsrc(&pkind->rsrc);
> -			pkind->pfchan_map[free_pkind] = ((pf) & 0x3F) << 16;
> -			rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
> -			rvu->cgx_mapped_pfs++;
> -			rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
> -			rvu->cgx_mapped_vfs += numvfs;
> +			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac))
> +				continue;
> +			__rvu_map_cgx_lmac_pf(rvu, pf, cgx, lmac);
>  			pf++;
>  		}
>  	}

There seems to be a fair amount of code duplication above.
If we can assume that there is always a management port,
then perhaps the following is simpler (compile tested only!).

And if not, I'd suggest moving the outermost for loop and everything
within it into a helper with a parameter such that it can handle
the (first?) management port on one invocation, and non management
ports on the next invocation.

 static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 {
 	struct npc_pkind *pkind = &rvu->hw->pkind;
 	int cgx_cnt_max = rvu->cgx_cnt_max;
-	int pf = PF_CGXMAP_BASE;
+	int next_pf = PF_CGXMAP_BASE + 1;
 	unsigned long lmac_bmap;
 	int size, free_pkind;
 	int cgx, lmac, iter;
@@ -158,10 +167,20 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
 	for (cgx = 0; cgx < cgx_cnt_max; cgx++) {
 		if (!rvu_cgx_pdata(cgx, rvu))
 			continue;
+
 		lmac_bmap = cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
 		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+			int pf;
+
 			lmac = cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
 					      iter);
+
+			/* Always use first PF for management port */
+			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac))
+				pf = PF_CGXMAP_BASE;
+			else
+				pf = next_pf++;
+
 			rvu->pf2cgxlmac_map[pf] = cgxlmac_id_to_bmap(cgx, lmac);
 			rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] = 1 << pf;
 			free_pkind = rvu_alloc_rsrc(&pkind->rsrc);

