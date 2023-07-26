Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A454763596
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjGZLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjGZLtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0630FC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:48:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 505E961AE1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E5C433C7;
        Wed, 26 Jul 2023 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690372121;
        bh=eZG9v0oZO9uEfsEIeSuInQVaRCDGDxegAVVDWaK0lZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FO/McMF4qjCJ/ZEnvhx0ROGZLqNZRvkrnD/QyR5ni2dYbxz78blKyECZOeUSmTOYl
         p/Bd0GGnU4Hq+WBUscxgIngIdoLN8Cfzw4quDBiosVJsARc4iSDKujlP6LM7yu8OEb
         P0niNcp41mrQ7Is4Ri8H1gOTNcuIvI4M3voLzyhOpYoBtC4mw8Cn1MKcR79mjPF897
         GCChIgLoqO3+kyWIV1LIkpTvQaBUE0/Kx6wiGjZ+tnSzW/YgClnDFO/TWSExNbOMJA
         yg3yBBatxEnLBnr73eu6OgGvpori4tpJr/Aop2PkwBIJ1fUfwXkQwvFfLxAg+uHulF
         zkrVjB6xThYWQ==
Date:   Wed, 26 Jul 2023 14:48:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
Subject: Re: [net-next PATCH] octeontx2-af: Tc flower offload support for
 inner VLAN
Message-ID: <20230726114836.GU11388@unreal>
References: <20230725103442.2749183-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725103442.2749183-1-sumang@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:04:42PM +0530, Suman Ghosh wrote:
> This patch extends current TC flower offload support to allow filters
> involving inner VLAN matching, to be offloaded to HW.
> 
> Example command:
> tc filter add dev eth2 protocol 802.1AD parent ffff: flower vlan_id 10
> vlan_ethtype 802.1Q cvlan_id 20 skip_sw action drop
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
>  .../net/ethernet/marvell/octeontx2/af/npc.h   |   3 +
>  .../marvell/octeontx2/af/rvu_debugfs.c        |   5 +
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  13 +++
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 106 +++++++++++-------
>  5 files changed, 90 insertions(+), 38 deletions(-)

<...>

> +	if (!is_inner)
> +		flow_rule_match_vlan(rule, &match);
> +	else
> +		flow_rule_match_cvlan(rule, &match);

<...>

> +		if (!is_inner) {
> +			flow_spec->vlan_tci = htons(vlan_tci);
> +			flow_mask->vlan_tci = htons(vlan_tci_mask);
> +			req->features |= BIT_ULL(NPC_OUTER_VID);
> +		} else {
> +			flow_spec->vlan_itci = htons(vlan_tci);
> +			flow_mask->vlan_itci = htons(vlan_tci_mask);
> +			req->features |= BIT_ULL(NPC_INNER_VID);
> +		}

Slightly better approach will be to reverse these checks from
"if (!is_inner)" to be "f (is_inner)".

Other than that,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
