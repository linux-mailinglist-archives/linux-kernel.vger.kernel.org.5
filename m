Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11F755AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGQFrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjGQFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C849AF2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CF760F28
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175D0C433C8;
        Mon, 17 Jul 2023 05:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689572849;
        bh=1aIi6QGmmJWaRAfFq7ZpnTRt5BwsQHVjPfdBR0Ng5UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N66hWHTacECqMB8u1i5ZGH5dOeHMLY6vv6A4+RAswmIde8dmsdlKG3/tM55sfNukD
         CvLen6dqBXfwuVwDmcte+rG+TSjp4JvxFGJw9978SpaU6WJnyW+6XsEV/Pcupa6zpb
         u8UM4anctUKXaBGhUxTZ22NvjuM4MMP4szQwlk99X8hdFwYHVlVCaRZg0Pbke/y70s
         +yrV/Zqj+RD7CkCdqRvhhSV9GiLORC1/8Z/q4/s5/VI38AC8LG9JYPFN0Fa5E32LzO
         hdzMHXajfhea6p/vh9AnKWgeCEWVA8WTovOg3ZcHZdxnbEjazjUZq2vGjJVau2w1n5
         Y2WxMPhW1kjGg==
Date:   Mon, 17 Jul 2023 08:47:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH V2] octeontx2-af: Install TC filter rules in
 hardware based on priority
Message-ID: <20230717054725.GB9461@unreal>
References: <20230716182442.2467328-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716182442.2467328-1-sumang@marvell.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 11:54:42PM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch fixes the issue and install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> Changes since v1:
> - Rebased the patch on top of current 'main' branch
> 
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   9 +-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   9 +-
>  .../marvell/octeontx2/af/rvu_switch.c         |   6 +-
>  .../marvell/octeontx2/nic/otx2_common.h       |  11 +-
>  .../marvell/octeontx2/nic/otx2_devlink.c      |   1 -
>  .../marvell/octeontx2/nic/otx2_ethtool.c      |   1 +
>  .../marvell/octeontx2/nic/otx2_flows.c        |   2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 313 +++++++++++++-----
>  8 files changed, 248 insertions(+), 104 deletions(-)

<...>

> +static void otx2_tc_del_from_flow_list(struct otx2_flow_config *flow_cfg,
> +				       struct otx2_tc_flow *node)
>  {
> +	struct otx2_tc_flow *tmp;
> +	struct list_head *pos, *n;

Please declared variables in rversed Christmas tree, in all places, thanks.

> +
> +	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
> +		tmp = list_entry(pos, struct otx2_tc_flow, list);
> +		if (node == tmp) {
> +			list_del(&node->list);
> +			return;
> +		}
> +	}
> +}
> +
> +static int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
> +				    struct otx2_tc_flow *node)
> +{
> +	struct otx2_tc_flow *tmp;
> +	struct list_head *pos, *n;
> +	int index = 0;

Ditto.

> +

<...>

> +static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry, u16 *cntr_val)
> +{
> +	struct npc_delete_flow_rsp __maybe_unused *rsp;

Why __maybe_unused? This keyword is usually used when in some CONFIG_*
option, it won't be used. It is not the case here.

>  	struct npc_delete_flow_req *req;
>  	int err;

<...>

> +	ntuple = !!(nic->netdev->features & NETIF_F_NTUPLE);

No need in !! for bool variables.

Thanks
