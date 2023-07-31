Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7623768D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGaHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGaHLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81E210D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:09:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DDA960EF0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2645CC433C8;
        Mon, 31 Jul 2023 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690787037;
        bh=z4A/IQIPWkayIF84XQQiMIyxWbCRT1XKTYCbJIaYDtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk5FRRct0o9cJ6r1gCqyZCnsTGuKTOOvLXpTMO0pypgjgN9+7k9hTo2GBM9dwhwqv
         x6Hf4oPVLCXDpUn1iE7YJYLBKMPuO/IDmH56k4SeWFXV5rfr+IYDz2I5SkSqfRe1/B
         xO7T8/pMWkBdJvlk3oBBzlGkRmR/zB69eZec2vRkiGtEhfdIcZ1aEPWYM+2IJ622W2
         SCrRRPyV/0XMwYV9EJU1VvREqunHRujAOFs+tsbIHxphqpp2O+Zb0TH8qxWT8vEchX
         T19ulWQK4iK4J05J3Gci+PYBNUXOx3JZNaS6unENR5bli/+TKUlHpaNCNJ47GcqedI
         0kA0KqXDQVAVQ==
Date:   Mon, 31 Jul 2023 09:03:52 +0200
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, simon.horman@corigine.com
Subject: Re: [net-next PATCH V2 2/2] octeontx2-af: TC flower offload support
 for inner VLAN
Message-ID: <ZMdc2Aca5AbvPKS1@kernel.org>
References: <20230730080009.2842927-1-sumang@marvell.com>
 <20230730080009.2842927-3-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730080009.2842927-3-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 01:30:09PM +0530, Suman Ghosh wrote:
> This patch extends current TC flower offload support to allow filters
> involving inner VLAN matching, to be offloaded to HW.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index f311fa6db7ce..29565680f6c4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -447,10 +447,11 @@ static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg *flow_spec
>  	u16 vlan_tci, vlan_tci_mask;
>  
>  	if (is_inner)
> -		return -EOPNOTSUPP;
> +		flow_rule_match_cvlan(rule, &match);
> +	else
> +		flow_rule_match_vlan(rule, &match);
>  
> -	flow_rule_match_vlan(rule, &match);
> -	if (ntohs(match.key->vlan_tpid) != ETH_P_8021Q) {
> +	if (!eth_type_vlan(ntohs(match.key->vlan_tpid))) {

Hi Suman,

I think this should be:

	if (!eth_type_vlan(match.key->vlan_tpid)) {

Otherwise the patch-set looks good to me.

>  		netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
>  			   ntohs(match.key->vlan_tpid));
>  		return -EOPNOTSUPP;

...
