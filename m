Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536BF7D7F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbjJZJHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:07:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19CB10E;
        Thu, 26 Oct 2023 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698311224; x=1729847224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEXGA+hQXBm1ufjQHDtYW7uE1dK4Tg/P5ocdejt0Njw=;
  b=JQMTeaPDrHN4eo5X9RBBzHlXrmcI+mWM1/xlqz0qSwY1+HaNxdPQ+m/z
   flm3fNNbBt+wrLK6G24IN33K8iJFw6Ht04Dc6Rbl/IQ8C+qDqsQEOrEu8
   GHrt2qPUGMRbIIXA+E4v4hlFWaV9wH47HyW2E2SpJRI06klajxjX9IWRM
   wmgPNR/wOql6MOYa3OoFNU8AEkLgDBF694aJY8ReD4/AUlYN7EzVGDVL7
   ZbYOoG+rQ8qMr0mKAjUlfdIVsr48Ehyi6j03lnHshMTVU1TOiq6P0+dCq
   plB9B6BJpQWwezWwCW9CXBh8TGujfqsUnDaujvbkwBQqTZcjaOEbvxNz4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="451732079"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="451732079"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932662078"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="932662078"
Received: from wasp.igk.intel.com (HELO wasp) ([10.102.20.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:06:54 -0700
Date:   Thu, 26 Oct 2023 10:41:34 +0200
From:   Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>, Simon Horman <horms@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next] net/mlx5: fix uninit value use
Message-ID: <ZTomPuMY/cWwdB8S@wasp>
References: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 04:50:50PM +0200, Przemek Kitszel wrote:
> Avoid use of uninitialized state variable.
> 
> In case of mlx5e_tx_reporter_build_diagnose_output_sq_common() it's better
> to still collect other data than bail out entirely.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
> Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 6 +++++-
>  drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 8 ++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
> index fc5a9fdd06db..fea8c0a5fe89 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
> @@ -263,8 +263,12 @@ mlx5e_rx_reporter_build_diagnose_output_rq_common(struct mlx5e_rq *rq,
>  	if (rq->icosq) {
>  		struct mlx5e_icosq *icosq = rq->icosq;
>  		u8 icosq_hw_state;
> +		int err;
> +
> +		err = mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
> +		if (err)
> +			return err;
>  
> -		mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
>  		mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
>  	}
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> index ccff7c26d6ac..6b44ddce14e9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> @@ -221,12 +221,16 @@ mlx5e_tx_reporter_build_diagnose_output_sq_common(struct devlink_fmsg *fmsg,
>  	bool stopped = netif_xmit_stopped(sq->txq);
>  	struct mlx5e_priv *priv = sq->priv;
>  	u8 state;
> +	int err;
>  
> -	mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
>  	devlink_fmsg_u32_pair_put(fmsg, "tc", tc);
>  	devlink_fmsg_u32_pair_put(fmsg, "txq ix", sq->txq_ix);
>  	devlink_fmsg_u32_pair_put(fmsg, "sqn", sq->sqn);
> -	devlink_fmsg_u8_pair_put(fmsg, "HW state", state);
> +
> +	err = mlx5_core_query_sq_state(priv->mdev, sq->sqn, &state);
> +	if (!err)
> +		devlink_fmsg_u8_pair_put(fmsg, "HW state", state);
> +
>  	devlink_fmsg_bool_pair_put(fmsg, "stopped", stopped);
>  	devlink_fmsg_u32_pair_put(fmsg, "cc", sq->cc);
>  	devlink_fmsg_u32_pair_put(fmsg, "pc", sq->pc);
> -- 
LGTM
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 2.38.1
