Return-Path: <linux-kernel+bounces-950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326181486B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD01C23060
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F272C6BB;
	Fri, 15 Dec 2023 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/wBerEs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649A24B31;
	Fri, 15 Dec 2023 12:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA1C433C7;
	Fri, 15 Dec 2023 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702644648;
	bh=cGBCAD1f4hEb7dtum2nFolXt6PKKGmfo44pDoi3WtPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/wBerEsrxdCAXVtWQR93N6s3k9E3sY9g9eq7aElypMoyu98IUdzCFgYSOuErdZtw
	 vQF1LvXH554m8/2M3jC0UKLyywHvMgGhK7kNsfBmK9Hf5o/eBTpEGT0/4tdphWjJFa
	 1RdzAQ1IYeDzlUMDZN3vGYMh48ZSKibaNyN3GFGqf+koV6PfGDmLbxPXmHduBPFDyp
	 l0uDabaDoGCpM4CqD5qXmsXBX+RsfltbewejPsP2zE6auWXMsYyE7xLeYBxLWplG6L
	 6FvZ4dRwRJ2svRU+se/FT6Vo5twE8T3GV5eoqTq44/aRMqSLpmgkfrRycHElcwvGKT
	 9bIGs9dl3YGOw==
Date: Fri, 15 Dec 2023 12:50:43 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
	jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	lcherian@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] octeontx2-pf: Fix graceful exit during PFC
 configuration failure
Message-ID: <20231215125043.GJ6288@kernel.org>
References: <20231213181044.103943-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213181044.103943-1-sumang@marvell.com>

On Wed, Dec 13, 2023 at 11:40:44PM +0530, Suman Ghosh wrote:
> During PFC configuration failure the code was not handling a graceful
> exit. This patch fixes the same and add proper code for a graceful exit.
> 
> Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
> index bfddbff7bcdf..28fb643d2917 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
> @@ -399,9 +399,10 @@ static int otx2_dcbnl_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
>  static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
>  {
>  	struct otx2_nic *pfvf = netdev_priv(dev);
> +	u8 old_pfc_en;
>  	int err;
>  
> -	/* Save PFC configuration to interface */
> +	old_pfc_en = pfvf->pfc_en;
>  	pfvf->pfc_en = pfc->pfc_en;
>  
>  	if (pfvf->hw.tx_queues >= NIX_PF_PFC_PRIO_MAX)
> @@ -411,13 +412,17 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
>  	 * supported by the tx queue configuration
>  	 */
>  	err = otx2_check_pfc_config(pfvf);
> -	if (err)
> +	if (err) {
> +		pfvf->pfc_en = old_pfc_en;
>  		return err;

Hi Suman,

I think that rather than duplicating this logic,
it would be appropriate to use a goto label.

(OTOH, while not related to this patch, removing the process_pfc
 label would be a win for readability, IMHO.)

> +	}
>  
>  process_pfc:
>  	err = otx2_config_priority_flow_ctrl(pfvf);
> -	if (err)
> +	if (err) {
> +		pfvf->pfc_en = old_pfc_en;
>  		return err;
> +	}
>  
>  	/* Request Per channel Bpids */
>  	if (pfc->pfc_en)
> @@ -425,6 +430,12 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
>  
>  	err = otx2_pfc_txschq_update(pfvf);
>  	if (err) {
> +		if (pfc->pfc_en)
> +			otx2_nix_config_bp(pfvf, false);
> +
> +		otx2_pfc_txschq_stop(pfvf);
> +		pfvf->pfc_en = old_pfc_en;
> +		otx2_config_priority_flow_ctrl(pfvf);
>  		dev_err(pfvf->dev, "%s failed to update TX schedulers\n", __func__);
>  		return err;
>  	}
> -- 
> 2.25.1
> 

Perhaps I am on the wrong track here, but if
1. otx2_pfc_txschq_stop() was called by otx2_pfc_txschq_update()
   (or otx2_pfc_txschq_config()) for relevant error cases; and
2. pfc_en was passed as a parameter to otx2_config_priority_flow_ctrl()

Then I think that the unwind logic in the if condition above could
be expressed as unwind ladder with goto labels whereby the order
of unwinding is strictly the reverse of configuration.

This is a subjective opinion, but the advantage of this approach is that it
tends to lead to more maintainable code and fewer errors in... error paths.

(Completely untested!)

	...
	if (err)
		goto err_pfc_en;
	...
	err = otx2_pfc_txschq_update(pfvf);
	if (err)
		goto err_config;

	return 0;

err_config:
	if (pfc->pfc_en)
		otx2_nix_config_bp(pfvf, false);
	otx2_config_priority_flow_ctrl(pfvf, old_pfc_en);
err_pfc_en:
	pfvf->pfc_en = old_pfc_en;

	return err;

