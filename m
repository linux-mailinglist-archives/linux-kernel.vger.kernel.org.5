Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4135B761FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjGYRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGYRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:03:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DEE9;
        Tue, 25 Jul 2023 10:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9YOr3ryOJJS2Z5k0IatcAFlUINGR/UWjuTCpUU5DL8dFJR21h3sedUNJio9j8UQCk5z68ghAooRv2i5gsrcABBLDYpEygm/TRZfNziHx3sRI5GDYOIOP2lm/KqcPf2SwCsHgrUp6HNUmWeTtM/5CTU29/JWABKEmNiTIEsfo9Yh30FufiUv3j0f0HY/SQfZRd2OZQNoEYwolcgHz8pHlc9ug88Sgn0YDc01SrQKdrEfAm5ZdTaKgQejWMIXZZYPpSRuCDay6E3A3YHEFF4gDdIjOO2ILA++cHijpJAFrWZbmBdcl7M3oZKo0SguaD9hgn1ox8dPikDDfwIWcBbNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMo3uekYzQachOdt5kB1z/qh/HVkL1SZkKeC4pzJrgI=;
 b=m5yIym9xSos648YhPhrcaZENDzXEcqQm2OPul621Ozmkg1qftDehYsXfeq7yEzmO6ENt4dKPlnADl18K1IjmPPyY5rKiAD9VMnE7QkP2GQvlV93JBXSlnta6faul4DWXnJLjLxzSMh4qfXLXUQ0MoYsbnA4ISz2exNupFQJlVQkMo9L5maUqg7BaJ4/cVckzdvXkLeHsyGB01l6i68bIugWWLDWI2fpw+HxBdPo3T3LC4mbSJgY8W6OD1IN1BFakPbrvx4thBqnF5qWQxJX5IN3BIuaUU1pq1+tgi1e1rtUO8WC8zrmqNDbKLEQalI18+0Phs3a/jew4FJqcujkfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMo3uekYzQachOdt5kB1z/qh/HVkL1SZkKeC4pzJrgI=;
 b=d9lzL2kapXhKRpDQvdBvaE+ifbBOD1tfAkHFLYAq5SES1X/REH+P2uXziTH14Q9JMkSVCcYMTeadpdVZtma4PTNQXPA36wVzm8kNLthf6N/6Ir0mXyzmg5JhEigExp4/asbTuPVZNtxP98SASZENPTuX3xAVe/dTiH3M98U/IJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6371.namprd13.prod.outlook.com (2603:10b6:806:381::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 17:03:02 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 17:03:01 +0000
Date:   Tue, 25 Jul 2023 19:02:52 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v8.1 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
Message-ID: <ZMAAPBKnnrdk/c9K@corigine.com>
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-7-dima@arista.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721161916.542667-7-dima@arista.com>
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 35eca9dd-cb0a-431b-424c-08db8d310120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wZN/ooXBe4ev4Kq7U+Bsfc4XkUvdlvL0tGcLOLfOR1y1mRaqFUnvpww+DF8qgHjdh2GHYnQGEtvFmIvEajgTEuQMJGqpH4TxybjAZWPzM+RrcqgNtGFszGtM6kENPMT9BqSbV1RSfZdlBrOFral5///W6g/gjwbsWupyyiysilxsjCOOF5TbTXnlcz/AnrpYoFqRXPz7ygSzEtAfH34NqJpEjoTMvicF/sTr0dXPSdBTEZ3zDCXepk2IDKowZORIDe0i+Q3J+A4bW6kYG2GtLSfy64FjDlhcxRVtAkS/MpY7cnvaudLcKuPXess8OKKgVvgbbsUwkHiyBvWmvTsTWVhqgIPFMkEYXa+gcRZKHBbvGoglUOfOKKRlgAg0hcKqqI8x2zLgx86nwRvkmudeYpUnS+Fr1pabN4wZwc7iTO887yuFUemZw5AeHOVzfZX1P7tva6WLRbzfjogK2Utyt2+3FHg+lhYp249WzTPk4hBKkSQZO1BsxoI4Vth5ijBA2NJIBSuBb5AjTm42x4rJp365UKsNZ84xfq3s7xL/AEc6BdsaXxye5tiLGTM4kIY4NUjSlgbYVzzS8sgKfNUZN8iwyv5iBXOM6638NQBMOzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39830400003)(396003)(451199021)(6486002)(478600001)(6512007)(54906003)(6666004)(83380400001)(86362001)(44832011)(2906002)(2616005)(186003)(36756003)(6506007)(66556008)(38100700002)(66476007)(6916009)(4326008)(5660300002)(41300700001)(8936002)(66946007)(8676002)(7416002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycLOYVGqncnUeZQ41CjVP7m8vbaXQtzaWWoV2s52izVPlxmkgIZewgWap8aK?=
 =?us-ascii?Q?90/hn+j6q1hxd4AFOguuhjaMKUX/fYrU0kk8DamdY29ITeZdnpLaKDz/QLPs?=
 =?us-ascii?Q?Uj7FAhkmZbYFKurFEznwzKLltu2nw+DxSUmLkK3AUE596Ap3NULfuqtCp1HQ?=
 =?us-ascii?Q?w+z6gg7hDB3SCgUri6xc2Yx9lOWRyn9XD/AkqCm3FFFHq0bmL7rm30yTbkGW?=
 =?us-ascii?Q?8HueMlMtzaFn1EHCqzYYa2pXx5ugGf4fUw7k2h5fSHakAEoeb7lr7gRG+mTm?=
 =?us-ascii?Q?wH5T7EKQZXDVdbzeCS6XRxTi3sRprHBIPguiFZMnLg5NDVeSdIR5hTETgfD8?=
 =?us-ascii?Q?oN9EHLOC+CHqGOAXpwCZ+3tVT+z/SRopFtXHVKgw3H0lBnY9RpIz1Zcv78Iu?=
 =?us-ascii?Q?jPCWDOv7LYzXU8/Cbi8BlcFXj7pXCh30E4YzSYNAXnqgDnIdY48oEWcGFsPv?=
 =?us-ascii?Q?rDfYrDANuDS/mUGVvoyuyOe/mtDpd3vobnWkzCHS2diSt+tbpTa2GZNB9ztm?=
 =?us-ascii?Q?2js7yQG8c3ZO4LzqZYJxdiB3gYWy8b/VD6oYTIgCtEVSnNAcdNSQj5t9ujBk?=
 =?us-ascii?Q?YybqWWraJC2BM/xw4b/03zFsH907txgYYLegOZwi+gEgcWPQVb3CS+/o/v05?=
 =?us-ascii?Q?u2pwxROVqLh4mz8RTKpZv8dWh+E14gt6aH7O3LxTI7rwYZHTUcSh6C7a23JU?=
 =?us-ascii?Q?Ec/qyc0NOlAa+vl6DvTfwYhrLxKZ+jzDPhZG8ZG3fI/kv9VY9MOhkkWauPjQ?=
 =?us-ascii?Q?1LvD9jabGXAoLnF/jUK/Gq2V3cUwxxHjsgCOZus2o/r1m0/emKHDdc6ivDJc?=
 =?us-ascii?Q?hZSqgN0rnuQRXuNT3RGU2+8WawalfTy3F8FgzpTyijxNb+i5BgreNMsx6IRk?=
 =?us-ascii?Q?W0Es5XuDfDM1GYE4Y8u0PtVJKC/p29yBmJ4BH/wFmyLuvFsYitQnlUPFrDWZ?=
 =?us-ascii?Q?j6+mU/+9IICFtXmTRMjJtgUugI4gRntwdtVyMFQL2oOcJtoVOsd8Smnai3Mu?=
 =?us-ascii?Q?HvIdK++JhuTxsfWSPbxTpCKKpoOKk56xATOz1XoQHKZrehbdPl+hAbPOYRPp?=
 =?us-ascii?Q?OYgrQJbpQ9Yrf+6l6sdhrxGkAyxerJae83Re6mTKDWSra22e2rjtFEwqrom4?=
 =?us-ascii?Q?XWZrXf0qNadnw5JG+acaWiOR1oq4lWti4TpSRlhWO6uFhgMHdLUCtrboDbzc?=
 =?us-ascii?Q?94s5B/q5I7MeJsG3+RBkjH/DYKcZlMmt8RVu7UC92ARO59k2Wld/Wlc5h8L2?=
 =?us-ascii?Q?iZCwCNs5PdZaHvkQFXG7P4/W174QlDJVrCO83UXBiXsfmrTEtG72L2vR9NtI?=
 =?us-ascii?Q?H9LithdTXWXpXhnPpnDs26tEFPDB1OfqvT8x/hIxJlyPDgwtpIQH1PFdidbw?=
 =?us-ascii?Q?uHKKcOihMHKZGovjmTUeW0yxlk7jn9QJFWN0nUX4d0u/1934RhpWhT4hnmcs?=
 =?us-ascii?Q?2H+HEKl2S+wH/y3c12p5cpDuzivtocLmcqkHT1GJhYxu4ls7gXMYx4XSSH+q?=
 =?us-ascii?Q?1mZJq4wUyqoWvu57RC3vFTYOHjejq683iUdJAYQY0LIze+0b6T9hBLiTrbGJ?=
 =?us-ascii?Q?nfE9ajMV8AOorXQO4Khc/3PQ7lWXby7pMVX3KoWvBM9dULpTEc1pSUj+IFt5?=
 =?us-ascii?Q?qJdHIod1hnGmIiYEQRUOeMxdIJwL3qE0YOybSs7niAMSY2JaVTOXYkeoSgZo?=
 =?us-ascii?Q?eZCv7w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eca9dd-cb0a-431b-424c-08db8d310120
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 17:03:01.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8M/k5NiRFJPmA810Iiilq04JR158/805Rl5IU3c5DHBUNFJ1yW87rziwgxirnJC67QxQ7ZszozpNL8wdFTbYuOsw9ogcvN4DOVx3n+1HLYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6371
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:18:57PM +0100, Dmitry Safonov wrote:

...

Hi Dmitry,

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c

...

> @@ -619,7 +621,33 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		opts->hash_location = (__u8 *)ptr;
>  		ptr += 4;
>  	}
> +#ifdef CONFIG_TCP_AO
> +	if (unlikely(OPTION_AO & options) && tp) {

Smatch warns that here we check if tp is NULL,
but later on in the same function (existing) code
uses tp unconditionally.

That code looks like this:

        if (unlikely(opts->num_sack_blocks)) {
                struct tcp_sack_block *sp = tp->rx_opt.dsack ?
                        tp->duplicate_sack : tp->selective_acks;

I would recommend running Smatch.
It points out a lot of interesting things.


> +		struct tcp_ao_key *rnext_key;
> +		struct tcp_ao_info *ao_info;
> +		u8 maclen;
>  
> +		if (WARN_ON_ONCE(!ao_key))
> +			goto out_ao;
> +		ao_info = rcu_dereference_check(tp->ao_info,
> +				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));

Checkpatch complains about indentation here.

Rather than point out each case in the series,
could I ask you to run ./scripts/checkpatch.pl --strict over the patchset?

...

> @@ -1363,6 +1424,34 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>  					       md5, sk, skb);
>  	}
>  #endif
> +#ifdef CONFIG_TCP_AO
> +	if (ao) {
> +		u8 *traffic_key;
> +		void *tkey_buf = NULL;
> +		u32 disn;
> +
> +		sk_gso_disable(sk);
> +		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
> +			if (tcb->tcp_flags & TCPHDR_ACK)
> +				disn = ao->risn;

Sparse complains that there is an endian missmatch between disn and ao->risn ?

Rather than point out every problem flagged by Sparse,
could I ask you to run it over the series?

...
