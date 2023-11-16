Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A857EE880
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjKPUun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPUul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:50:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EBF98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:50:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06BFC433C7;
        Thu, 16 Nov 2023 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700167838;
        bh=aBAhIG5ZZv+6q7MeBajGvorrQFRVmO/bABxuFh3GO44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZcxY6QbAH78bN+7VcTqkHc1XCQNNWeC0D4zmCFxss1cVqWIfbAYTTenUSqtdONTO
         w0gTd93a3t1knEVwmdTmSszjpDrWYCYAmvnFKtqf7AX5R0fdYDE82bUAPoGIBFBMy9
         173ZNkAwAAB67WysA+JQrNUNKIpJXpdLQB9yJxynHKXYHNUM5kmTU56bvTEB8Sg1oq
         pzK64BiyyheRcg1xFlfjtauLx4+qv0zTjsSP/8O+YYuRYDLWy9nN/KR1c7gZn6M3sl
         vwHkZmldvJjtbT2kcG74T+FT8uDnPTEW3AzdNw+D4ggyxgpBHgT4i/pjyElVWJxn1l
         rj59ZMXjLwUMA==
Date:   Thu, 16 Nov 2023 20:50:33 +0000
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] octeontx2-pf: Fix memory leak during interface down
Message-ID: <20231116205033.GI109951@vergenet.net>
References: <20231116155334.3277905-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116155334.3277905-1-sumang@marvell.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 09:23:34PM +0530, Suman Ghosh wrote:
> During 'ifconfig <netdev> down' one RSS memory was not getting freed.
> This patch fixes the same.
> 
> Fixes: f12098ce9b43 ("octeontx2-pf: Clear RSS enable flag on interace down")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Hi Suman,

I'm wondering if the fixes tag should refer to the commit
that introduced the allocation that your patch is freeing.

Fixes: 81a4362016e7 ("octeontx2-pf: Add RSS multi group support")

> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 91b99fd70361..ba95ac913274 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1934,6 +1934,8 @@ int otx2_stop(struct net_device *netdev)
>  	/* Clear RSS enable flag */
>  	rss = &pf->hw.rss_info;
>  	rss->enable = false;
> +	if (!netif_is_rxfh_configured(netdev))
> +		kfree(rss->rss_ctx[DEFAULT_RSS_CONTEXT_GROUP]);
>  
>  	/* Cleanup Queue IRQ */
>  	vec = pci_irq_vector(pf->pdev,
> -- 
> 2.25.1
> 
