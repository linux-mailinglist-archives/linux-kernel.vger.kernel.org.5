Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853E67B1EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjI1Nnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjI1Nno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:43:44 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729CC136;
        Thu, 28 Sep 2023 06:43:42 -0700 (PDT)
Received: from [78.30.34.192] (port=35962 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlrIm-002BVs-Ok; Thu, 28 Sep 2023 15:43:39 +0200
Date:   Thu, 28 Sep 2023 15:43:36 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     joao@overdrivepizza.com
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH v3 2/2] Make num_actions unsigned
Message-ID: <ZRWDCGG5/dP12YEs@calendula>
References: <20230927164715.76744-1-joao@overdrivepizza.com>
 <20230927164715.76744-3-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927164715.76744-3-joao@overdrivepizza.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:47:15AM -0700, joao@overdrivepizza.com wrote:
> From: Joao Moreira <joao.moreira@intel.com>
> 
> Currently, in nft_flow_rule_create function, num_actions is a signed
> integer. Yet, it is processed within a loop which increments its
> value. To prevent an overflow from occurring, make it unsigned and
> also check if it reaches 256 when being incremented.
> 
> Accordingly to discussions around v2, 256 actions are more than enough
> for the frontend actions.
> 
> After checking with maintainers, it was mentioned that front-end will
> cap the num_actions value and that it is not possible to reach such
> condition for an overflow. Yet, for correctness, it is still better to
> fix this.
> 
> This issue was observed by the commit author while reviewing a write-up
> regarding a CVE within the same subsystem [1].
> 
> 1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/

Yes, but this is not related to the netfilter subsystem itself, this
harderning is good to have for the flow offload infrastructure in
general.

> Signed-off-by: Joao Moreira <joao.moreira@intel.com>
> ---
>  net/netfilter/nf_tables_offload.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index 12ab78fa5d84..9a86db1f0e07 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -90,7 +90,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
>  {
>  	struct nft_offload_ctx *ctx;
>  	struct nft_flow_rule *flow;
> -	int num_actions = 0, err;
> +	unsigned int num_actions = 0;
> +	int err;

reverse xmas tree.

>  	struct nft_expr *expr;
>  
>  	expr = nft_expr_first(rule);
> @@ -99,6 +100,10 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
>  		    expr->ops->offload_action(expr))
>  			num_actions++;
>  
> +		/* 2^8 is enough for frontend actions, avoid overflow */
> +		if (num_actions == 256)

This cap is not specific of nf_tables, it should apply to all other
subsystems. This is the wrong spot.

Moreover, please, add a definition for this, no hardcoded values.

> +			return ERR_PTR(-ENOMEM);

Better E2BIG or similar, otherwise this propagates to userspace as
ENOMEM.

> +
>  		expr = nft_expr_next(expr);
>  	}
>  
> -- 
> 2.42.0
> 
