Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00E78FA5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjIAI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjIAI6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:58:50 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6738810D2;
        Fri,  1 Sep 2023 01:58:47 -0700 (PDT)
Received: from [78.30.34.192] (port=40982 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qbzzE-00AMu7-Nc; Fri, 01 Sep 2023 10:58:43 +0200
Date:   Fri, 1 Sep 2023 10:58:39 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     joao@overdrivepizza.com
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        rkannoth@marvell.com, wojciech.drewek@intel.com,
        steen.hegenlund@microhip.com, keescook@chromium.org,
        Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH 2/2] Ensure num_actions is not a negative
Message-ID: <ZPGnv40EYt/lnOVj@calendula>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
 <20230901010437.126631-3-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901010437.126631-3-joao@overdrivepizza.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 06:04:37PM -0700, joao@overdrivepizza.com wrote:
> From: Joao Moreira <joao.moreira@intel.com>
> 
> In nft_flow_rule_create function, num_actions is a signed integer. Yet,
> it is processed within a loop which increments its value. To prevent an
> overflow from occurring, check if num_actions is not only equal to 0,
> but also not negative.
> 
> After checking with maintainers, it was mentioned that front-end will
> cap the num_actions vlaue and that it is not possible to reach such
> condition for an overflow. Yet, for correctness, it is still better to
> fix this.
> 
> Signed-off-by: Joao Moreira <joao.moreira@intel.com>
> ---
>  net/netfilter/nf_tables_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index 12ab78fa5d84..20dbc95de895 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -102,7 +102,7 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
>  		expr = nft_expr_next(expr);
>  	}
>  
> -	if (num_actions == 0)
> +	if (num_actions <= 0)
>  		return ERR_PTR(-EOPNOTSUPP);

Better turn num_actions into unsigned int I'd suggest.

Next hypothetical problem would be an overflow in the number of
actions, you could check for UINT_MAX if you like here to report
ENOMEM.

Thanks.

>  	flow = nft_flow_rule_alloc(num_actions);
> -- 
> 2.41.0
> 
