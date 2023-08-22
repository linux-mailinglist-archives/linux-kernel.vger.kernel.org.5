Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A35783A92
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjHVHMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjHVHL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF1CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E868649E9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2FFC433C8;
        Tue, 22 Aug 2023 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688266;
        bh=glvC+htLSGYHQkGGjvV8Jz08Hp3/iPunrXtpppKKSTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enck29HeHV5b5J53yZPeMCK9QS2bZHPVLgski5N0EG5ru7lnGomXYKOgZZL8MXqgb
         ydDWF06/zvXciVvDMsvbf0mRAGjTMCrRALjzJSN+I9qRTGLJ2BcvG9PxdQSh1wDtt4
         7KaH6B8HTIcYSq/b4yochWvAH3VlblYq7CBf9Um4hzAh1+hOadjdax6L9Rz41qEt6/
         XyH/cVa9QF3n6w8We54bdx1PlBvjFPqUSR0P0uNkQAGE1duXr6+KS4W8x5rbDFaiJ/
         lkV3tv6bEDyfLUmQxpHuKJUAjw1YlyCdVwa0B7TJ4LJ+Wdesvq97KBoTYx/3Qrt4LZ
         oYecwRfkSGjnQ==
Date:   Tue, 22 Aug 2023 09:11:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 1/3] octeontx2-pf: Fix PFC TX scheduler free
Message-ID: <20230822071101.GI2711035@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
 <20230821052516.398572-2-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821052516.398572-2-sumang@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:55:14AM +0530, Suman Ghosh wrote:
> During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
> which caused free up all schedulers other than the PFC schedulers.
> This patch fixes that to free only the PFC Tx schedulers.
> 
> Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
>  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 77c8f650f7ac..289371b8ce4f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
>  
>  	mutex_unlock(&pfvf->mbox.lock);
>  }
> +EXPORT_SYMBOL(otx2_txschq_free_one);

Hi Suman,

Given that the licence of both this file and otx2_dcbnl.c is GPLv2,
I wonder if EXPORT_SYMBOL_GPL would be more appropriate here.

>  
>  void otx2_txschq_stop(struct otx2_nic *pfvf)
>  {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
> index ccaf97bb1ce0..6492749dd7c8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
> @@ -125,19 +125,12 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
>  
>  static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
>  {
> -	struct nix_txsch_free_req *free_req;
> +	int lvl;
>  
> -	mutex_lock(&pfvf->mbox.lock);
>  	/* free PFC TLx nodes */
> -	free_req = otx2_mbox_alloc_msg_nix_txsch_free(&pfvf->mbox);
> -	if (!free_req) {
> -		mutex_unlock(&pfvf->mbox.lock);
> -		return -ENOMEM;
> -	}
> -
> -	free_req->flags = TXSCHQ_FREE_ALL;
> -	otx2_sync_mbox_msg(&pfvf->mbox);
> -	mutex_unlock(&pfvf->mbox.lock);
> +	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
> +		otx2_txschq_free_one(pfvf, lvl,
> +				     pfvf->pfc_schq_list[lvl][prio]);
>  
>  	pfvf->pfc_alloc_status[prio] = false;
>  	return 0;
> -- 
> 2.25.1
> 
> 
