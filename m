Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF98F7FDE56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjK2R0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjK2R0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:26:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96690137
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:26:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D050EC433C9;
        Wed, 29 Nov 2023 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701278798;
        bh=14utwrkfwECFxJzYSOTHRPRY0fg00Fk8Fx6zj6nhmNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFV1PVjk3CzHbKlN1oIZ5XYeQu/pCAOdI0THaCT1EYtCDNywxqA4dQUbX/hJQZZjG
         NeDPEON1l7yf5VKQl95bmtIfQay+8PtARSWstCZhiFZzTp23wfcxB/CYm2NzYT43uq
         LsVYSCgaatIi5iUztF+mHyynOvruD4TNrvA6zq+M50v+ncEz39bBoUlOt3ZRwSeWmk
         b0EXyGmLIGU8OxURFvPFN4EP7LOGMZkOWGKsn8J9h2lxc7mC2oIX0RQ6AyrrsA0aP7
         J2DHg9Qv57Gr9bhpWRYjVu/Nj0Lh0KH+JCkze9z7WKiV9b9MGQFNxPS8Y/cjdejmRU
         pgkuURdsKUHag==
Date:   Wed, 29 Nov 2023 17:26:33 +0000
From:   Simon Horman <horms@kernel.org>
To:     Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, gakula@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com
Subject: Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
Message-ID: <20231129172633.GG43811@kernel.org>
References: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:53:42AM +0530, Subbaraya Sundeep wrote:
> All the mailbox messages sent to AF needs to be guarded
> by mutex lock. Add the missing lock in otx2_get_pauseparam
> function.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v2 changes:
>  Added maintainers of AF driver too

Hi Subbaraya,

I was expecting an update to locking in otx2_dcbnl_ieee_setpfc()
Am I missing something here?

Link: https://lore.kernel.org/all/CO1PR18MB4666C2C1D1284F425E4C9F38A183A@CO1PR18MB4666.namprd18.prod.outlook.com/

> 
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> index 9efcec5..53f6258 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> @@ -334,9 +334,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
>  	if (is_otx2_lbkvf(pfvf->pdev))
>  		return;
>  
> +	mutex_lock(&pfvf->mbox.lock);
>  	req = otx2_mbox_alloc_msg_cgx_cfg_pause_frm(&pfvf->mbox);
> -	if (!req)
> +	if (!req) {
> +		mutex_unlock(&pfvf->mbox.lock);
>  		return;
> +	}
>  
>  	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
>  		rsp = (struct cgx_pause_frm_cfg *)
> @@ -344,6 +347,7 @@ static void otx2_get_pauseparam(struct net_device *netdev,
>  		pause->rx_pause = rsp->rx_pause;
>  		pause->tx_pause = rsp->tx_pause;
>  	}
> +	mutex_unlock(&pfvf->mbox.lock);
>  }
>  
>  static int otx2_set_pauseparam(struct net_device *netdev,
> -- 
> 2.7.4
> 
