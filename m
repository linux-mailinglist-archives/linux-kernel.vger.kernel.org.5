Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4F7B2D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjI2IKV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjI2IKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:10:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7171A5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:10:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-V-eKdlGtNjCLQJKswWmyoQ-1; Fri, 29 Sep 2023 09:10:02 +0100
X-MC-Unique: V-eKdlGtNjCLQJKswWmyoQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 09:10:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Sep 2023 09:10:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'joao@overdrivepizza.com'" <joao@overdrivepizza.com>,
        "pablo@netfilter.org" <pablo@netfilter.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kadlec@netfilter.org" <kadlec@netfilter.org>,
        "fw@strlen.de" <fw@strlen.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        "wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
        "steen.hegenlund@microhip.com" <steen.hegenlund@microhip.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Joao Moreira <joao.moreira@intel.com>
Subject: RE: [PATCH v2 2/2] Make num_actions unsigned
Thread-Topic: [PATCH v2 2/2] Make num_actions unsigned
Thread-Index: AQHZ8ObIeUWAs73e2U+3ivRy5uEH5bAxdYzQ
Date:   Fri, 29 Sep 2023 08:10:00 +0000
Message-ID: <09695e42dfaf4dfe9457aa814fef297e@AcuMS.aculab.com>
References: <20230927020221.85292-1-joao@overdrivepizza.com>
 <20230927020221.85292-3-joao@overdrivepizza.com>
In-Reply-To: <20230927020221.85292-3-joao@overdrivepizza.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: joao@overdrivepizza.com
> Sent: 27 September 2023 03:02
> 
> From: Joao Moreira <joao.moreira@intel.com>
> 
> Currently, in nft_flow_rule_create function, num_actions is a signed
> integer. Yet, it is processed within a loop which increments its
> value. To prevent an overflow from occurring, make it unsigned and
> also check if it reaches UINT_MAX when being incremented.
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
> 
> Signed-off-by: Joao Moreira <joao.moreira@intel.com>
> ---
>  net/netfilter/nf_tables_offload.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index 12ab78fa5d84..d25088791a74 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -90,7 +90,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
>  {
>  	struct nft_offload_ctx *ctx;
>  	struct nft_flow_rule *flow;
> -	int num_actions = 0, err;
> +	unsigned int num_actions = 0;
> +	int err;
>  	struct nft_expr *expr;
> 
>  	expr = nft_expr_first(rule);
> @@ -99,6 +100,9 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
>  		    expr->ops->offload_action(expr))
>  			num_actions++;
> 
> +		if (num_actions == UINT_MAX)
> +			return ERR_PTR(-ENOMEM);
> +
>  		expr = nft_expr_next(expr);

The code is going to 'crash and burn' well before the counter
can possibly overflow.

nft_expr_next() is ((void *)expr) + expr->ops->size;

It is far more likely that has got setup wrong than the
count is too big. 

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

