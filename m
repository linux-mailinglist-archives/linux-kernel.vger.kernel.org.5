Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A257B75FFEF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGXTqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjGXTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:46:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2121.outbound.protection.outlook.com [40.107.244.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7431713;
        Mon, 24 Jul 2023 12:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVICpvZcmj2MbCS7AQBzUwzDsWAEw7GsWGR7ro6XCJePAv8bxIJKfk/ErEHRFNf8abnzO8CrCa7z0T8SHWJy6l+Ri0VHvu9slMzu8jLE3amqz1K0w+5uoWjO+SL2MQb4JpaLHyuSNz3LCBlZAufaYO72SY3FhBRCPpMnBs5Zc/q/srkUI7AdeIhAxFQNKDDTdTiviF9VxgIxiS58yBXZas7E3e0F+PLvD3vEcdDELQp41O3K6dy55GWnownL7jFAIN6bwa0pnUkWHzAeJ++UjnSNOYTk6E0Hg92GzsFZXTySFu+f3Vv8zm3z6PvSVnXfwPWVFd9auPIDBPsY/IUauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfS/ZDrzUrHe0auivOJhoq6S/6ESI5rnuNdiwU/HgtQ=;
 b=OXZZ7ScsA4Yis3/N4u3YyJpCgP6jUIaqTVJLkRJjSh5HwuDqdoo4NWH0m9iK0WmFDtpAycC5VRHcokzCI9plsP4q0KfZ7RUwdmvAHqVJNb3XpUe3hBdFsuCfkNklD51CY9wdDmTYFpgMh0/nucPjDXGY3w1sT5qr//p8XD9+mfFfuvTyH4XVREKMJSc3xPyqAd1QzP7MG+6k66WfJt5huMmdw3CGn0KQIe1Wc4A32yTU7F8xPTYDt/jllzSqK4EqUEyIPid9L0tBLyn/AoVMDLShrs8x6poFKWohBbtU5bUvWMj75Co6Xw989AeCXUXYs/Rjo4QECk7v1CeoWJrkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfS/ZDrzUrHe0auivOJhoq6S/6ESI5rnuNdiwU/HgtQ=;
 b=GmvxgB5sElQCCAkTaCh6FYqNV/i5/q2SXum/IePLH4NzU++wVI1GXDz49S98kF+mBvyKcEghuRPZZ0snhaA9P0HJ+1od4s+Wqn/2I+Uoxh5a0AITkmOjx0qUFwRKznZp0ZX7xwf+uAsSTjWddIU1pMlc2VBNLEsdhdVyhD8VsR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM8PR13MB5222.namprd13.prod.outlook.com (2603:10b6:8:9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 19:46:29 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 19:46:29 +0000
Date:   Mon, 24 Jul 2023 21:46:19 +0200
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
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: Re: [PATCH v8.1 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for
 TCP-AO
Message-ID: <ZL7VCxdVCrOti72U@corigine.com>
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-2-dima@arista.com>
 <ZL54mOdTzX5Z9Fji@corigine.com>
 <db7bc3ce-dea0-9abe-9b06-300c10c37759@arista.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db7bc3ce-dea0-9abe-9b06-300c10c37759@arista.com>
X-ClientProxiedBy: AM0PR02CA0163.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM8PR13MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db57751-8b8e-4c80-84fe-08db8c7eac4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IaDEZ6R8IjqOa6P3UhvrnDSD++YGPmMTh88nqh5lTnTl4HmHXxn3pCi5Axto+lKOv46m2GtTLivx8cH5O2qWPI4+vAfLKLgmVIdtv1VgoaTiTyjUjr2U8WZbr/JR7H9fFStg15iGBlQWYT16Fqlt6VYvY169b0Pal6LqhALeKGy68H4lIPEAbVigsvz73Lge08VHaLWrC+D1R3N16rJSD4wJ7f1wM3x2MRmbG7+8It/BecHZ3fIYit0rZS+GpdsZDtWEdRocpbgY+5uN80qVuAh0OeamH0WGLugpzMOWbp2QXYGizNYCCgU8GeQJBMnMQs9+k5UBOG/nFRMbMgXeBI4osmRAVcKEkykf1bIzzdegrqyPPB1zWNQzDe5LA6wVIchcyd3u1taDiR8roxJs6CAFJewtJlV2XL5OhOgXgKvKEqDn3G+uls1bBd3crPNYOpZUTdNKWruTmAcxsx51VAHouboGHwDnQcPc6DN7WhK/yvAlSzxbTYD2J/tq2tcjPqNRofFQIEmaOVXrWaxMenwPnEPsdua5EMDascox47pzJIqWjRuuKT8lC73h6a4ox2R8Mjl+vqPqRfEvTMP/16TDuPPJ+Dp4hNWQpxKLYCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39840400004)(346002)(366004)(376002)(451199021)(2616005)(36756003)(2906002)(83380400001)(41300700001)(7416002)(44832011)(5660300002)(53546011)(6506007)(8676002)(8936002)(186003)(6666004)(54906003)(66946007)(6486002)(478600001)(86362001)(38100700002)(66556008)(6512007)(316002)(66476007)(4326008)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwuVecYCFktsyc2D1bLIXSIW/y8S/xYvDClDb/J1zxIHmwzXIPKDmQ9pAth3?=
 =?us-ascii?Q?5VMZYGWnurKLRsrDhXvL8v3OWWc6sywoFd3nh1KoGkO/CAy8Segqvqi3cK6V?=
 =?us-ascii?Q?B8PuK2vBTTL84yqzKr6FV7n2uoxpfzm+wD675HmNAwdq2/mHt0dpyVZFd43y?=
 =?us-ascii?Q?vPlTOU0Bx6qeVsYnaEYcJwPPay6YTCKNtUTFjfk78xtyRYvNNar2btt49LWq?=
 =?us-ascii?Q?GZjq46he9rqhdWpsjI8GNOBNmaRMZI4i19dbcfrMqTVB0VjmyI2xD71jR+GY?=
 =?us-ascii?Q?uYfv3tDhwCjkwCY2fZx19tOVSP0SMyJDMnOkoQ15ueoaBNQU9y55XiIje63Y?=
 =?us-ascii?Q?qMV3QcFpfmMdXzBxGrYeHyr6nmV75GDmta5jLZ+PxE/rKjQXXDf4otcT/tU0?=
 =?us-ascii?Q?h2RqS0k+FCKmPkszMcevKqCz4TCggx8QfYnhBc0TbK+V91bieGhNe1mLKvJv?=
 =?us-ascii?Q?KhSRqZOEVINwURi0dz59kX/J479J1u+ks/SKpxmkngN/Tbf/yUQgo5MmO+vz?=
 =?us-ascii?Q?rERgrZhEY+IqPqCiLob8wmUZPkgwBqxI6qm+NgItO68trrjcFd+oMUP4hJj8?=
 =?us-ascii?Q?524l5mL7TlXnUc2gGIy7fCGF10gcz5x0rKCP7YqzaToer8hyndZao4XP3QuQ?=
 =?us-ascii?Q?JwhdLtd3Vw6MiIChlJRYX5JDImg/FIu0caoCCD4Hdz/CftLkQkwdOzSEdsaL?=
 =?us-ascii?Q?SKpRX1Cokeyxh/YnrJlUPF8cJNL5FY9tFjtGKSo1wwqvz/2b6OAUYmOqLBMQ?=
 =?us-ascii?Q?Z1Aibxmu9+JyXWoOyjBMbe2JC/QD0oBwUcINGSwZQWrbRWnCiykebSqkWfUK?=
 =?us-ascii?Q?jiMfS9YNIUkWxkI+5frKe6YaAGaK1lQsYltK4/HWHQPdoIHUGciDAxke7iEZ?=
 =?us-ascii?Q?2fiJ4aynfkCzuapYjouo8RqLNjwlA7HHCWlzv0p7Ce2auWjK7XImvnMsAOM/?=
 =?us-ascii?Q?WeTeo7NGe8BaNaE6LLWF2ch90k40+ep9y46L0pZnfAch4zt1opERjR1FQmPk?=
 =?us-ascii?Q?OpaFxdHb4vrrKSLqcauZY+X46yXMvn389SPvCFdiifVWOiyExRwXSu7Q/i0H?=
 =?us-ascii?Q?ERJZsqraM4EDYqwCIedHQK/xbynYk1dmvVBiX0a5Neza3Mz0VdRql5cDtjBP?=
 =?us-ascii?Q?xiXOSts5m8l3oqD/kzQjfVzVZSFQ6l7w17iKhuYxVVgGBFa+S+0xFAYoFE5R?=
 =?us-ascii?Q?654w4NNXjo4otPRY71ePGDhc8lRtPYCGZijr44H1+cdfPULmrCV4qiKIeChe?=
 =?us-ascii?Q?QGI8o5i+LJb69ouPwiNoCeeZ0u4gfskZFEzZoOo3mE7DewM0GC7o2IRV9tJo?=
 =?us-ascii?Q?MGgOirhbnuNDrBD9hhn2A7yR4hYg9x5JOlzmJJWbU/Xaa8jq65f/EtrzIxOg?=
 =?us-ascii?Q?okWRBL96z5NmcixiafXIxtLLkPG0ewUmoEYF7y4iDZz1YVZag1ouOy1ukkeD?=
 =?us-ascii?Q?cUlpmynw9uv4hxZemI4y+hOcs1htBESj7L5zzlMCyfAbhK3X+Lvb0B5hR3NN?=
 =?us-ascii?Q?VWWNWs4XIpvMnU8LxIZcc5VXZkbeA31JLnpaK5ho8u8QNUlOElFWeOJNL3Gz?=
 =?us-ascii?Q?ShyVFknU40s10rfrFgLJsg6Bnrpig4Z5mi/8ZS/vQPYj7xlJDQUP/Qs0XABI?=
 =?us-ascii?Q?fpAWH7QsthCjiyIRA/vQych++k/Dm6smADtGTNbA4NLmqOfe23DaLi4oj40e?=
 =?us-ascii?Q?UELZWg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db57751-8b8e-4c80-84fe-08db8c7eac4b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:46:29.0198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVe1/0N6o+woCYy+c1N4tF/l7Xa3oGEn9TdRMw8M3YlNn57T5Cb7tQ74T4JKFYG7YW7ZNe1V6XoGy4pWgAGO/i/BbARrmWyXHOAq227iGB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5222
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:06:30PM +0100, Dmitry Safonov wrote:
> Hi Simon,
> 
> On 7/24/23 14:11, Simon Horman wrote:
> > On Fri, Jul 21, 2023 at 05:18:52PM +0100, Dmitry Safonov wrote:
> > 
> > Hi Dmitry,
> > 
> > some minor nits from my side.
> > 
> > ...
> > 
> >> +/**
> >> + * tcp_sigpool_start - disable bh and start using tcp_sigpool_ahash
> >> + * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
> >> + * @c: returned tcp_sigpool for usage (uninitialized on failure)
> >> + */
> >> +int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c);
> >> +/**
> >> + * tcp_sigpool_end - enable bh and stop using tcp_sigpool
> > 
> > nit: as this is a kernel doc, please document @c here.
> 
> Thanks, yeah, I also noticed that on netdev/kdoc and there are some
> other nits on the patchwork that Intel's build bot didn't report to my
> surprise. Will address them in v9.

Always room for improvement :)

> >> + */
> >> +void tcp_sigpool_end(struct tcp_sigpool *c);
> >> +size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len);
> >>  /* - functions */
> >>  int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
> >>  			const struct sock *sk, const struct sk_buff *skb);
> > 
> > ...
> > 
> >> @@ -1439,8 +1443,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
> >>  			const struct sock *sk,
> >>  			const struct sk_buff *skb)
> >>  {
> >> -	struct tcp_md5sig_pool *hp;
> >> -	struct ahash_request *req;
> >> +	struct tcp_sigpool hp;
> >>  	const struct tcphdr *th = tcp_hdr(skb);
> >>  	__be32 saddr, daddr;
> > 
> > nit: please consider using reverse xmas tree - longest line to shortest -
> >      for these local variable declarations.
> > 
> > 	const struct tcphdr *th = tcp_hdr(skb);
> > 	struct tcp_sigpool hp;
> > 	__be32 saddr, daddr;
> > 
> > Likewise, elsewhere, when it can be done without excess churn.
> 
> Yeah, fail enough, I usually keep it Xmas-like, but sometimes they slip
> in unnoticed. I'll take a look over the patches.

Thanks. I also flagged this in my review of 3/23,
as I hadn't noticed your response here.
