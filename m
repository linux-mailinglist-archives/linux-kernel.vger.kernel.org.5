Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB269762F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjGZIFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjGZIE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:04:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5478E5264;
        Wed, 26 Jul 2023 00:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEV1XsCXH4uqFOMwZ9zug0+rp+e7T4ABwAVDUbOExGHgIGNp1zYKXN7eIX+lQRt5tM3b3a/oSGsX8qso/T29k3lGIfui7HSdRa0PYFcFGfT2AXl+og1TDc6wihJwnNqwkBx5IG4JwqYrHPTOlLQET/je2ciLdNa9lLn4dEC2wtoCHt6wK0XI0jGkVTHL89gGdHhA5/YlDZld+zrkE8MPihVgOGkO65eiOzN+G14nEV60dnYClZPT7fEV5mua1BkujJ0IJMUBAMpi3DGNlMRXwwNAY0DLjz2G3EE3ANKtWD8i+J/+/XgYTCr04sWiQl2rmrz4Ijyfwq/BA892I7eJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/fEcvyzG7i4ry4MyePDNTR+Nw4/4Lw5XYYTSOBuiTo=;
 b=PDlx5g29KXOP/vDBVgo1jkfWh110uLavih1742FLEG5/gZTfJ9ZflmzEaqN5IQQjJYYgXpf/PLjB5pmunpF6/I8D4Sm+3dCLarGtSoInWddu7HVCz2vdeFaaYwxE5aGfof8hyVILEKQ21qNMd5xhxrrkw+jEoSupnMtxYZhKx6VcPYI/tGx93iHdPSmjfuMNAV4e0gpbghSuwvfWxWVjh5GTXIq8DWP/z7sLKEzfjppeKi0EZwhzHqZWoWllfJQqBZ+EhxZZpRS6yNaoZD1CbvWJOTJ0FF+fZNkMm92zDvFDE5rtDIyw1t18fNf6D7HarG0hETQQ6J71aa0t8SBQSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/fEcvyzG7i4ry4MyePDNTR+Nw4/4Lw5XYYTSOBuiTo=;
 b=RIO6p4uhSIqyB1AWFpJFiDjpO1ozymD7nu0fPvfOia3aInW1d7LJ6wWvo+74LP3Xhk0ktTeBii1kes4CJSF30REr3nrmG7BA69jHdm5QRK+e7tsA+2h3xhs9HeX8Iq/tNYLuByPggTV/qfR1XoUQL+jJs1WjezJQrvhQSP5PW+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH3PR13MB6458.namprd13.prod.outlook.com (2603:10b6:610:198::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 07:56:45 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:56:45 +0000
Date:   Wed, 26 Jul 2023 09:56:36 +0200
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
Subject: Re: [PATCH v8.1 net-next 03/23] net/tcp: Introduce TCP_AO
 setsockopt()s
Message-ID: <ZMDRtB2eJ25Lb+2P@corigine.com>
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-4-dima@arista.com>
 <ZL7RdEEz2nH/QFqZ@corigine.com>
 <732218bf-9388-e8ce-0913-d681d1302a37@arista.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <732218bf-9388-e8ce-0913-d681d1302a37@arista.com>
X-ClientProxiedBy: AM0PR08CA0033.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::46) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH3PR13MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: f7349619-1607-4866-1111-08db8daddb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDiG8/mBtC/+FCmT22Hgy8vI8GVtw+MZAWG+b43t9alm0J6z/BDOmhhR6uz7M2HEGMKV3qvSKXSRVtUfHInYvXFCIMbmhk5dI1aVaQ3Ft3YRCEWbGHMyyEFu5ziLpZfsr5fG2J3/XAcoS2Kxsl17D6eUK8Uord7jcO9gbV2WLrY4b+bJ2vlM/8vS9/hSQjTu43o7tF0T56xPzeoWXKN6GWyxmnG7ZF952/HpV6n2gtj+fmBmbExDOLDuxjWhb9RWW1SfJjFHTZi6tlttTbc7KtGZN/tEH1m3g7F3OBa20SGDabZ8JpREjmm7h0ebsECBlb8aznO9ljWfnHJJRqkiy4tkAq9YJnOv6iDtTbPt4dpmdYsQZUl0gY8J+fxcUg7WWPswHMOAsKfVOqg2M6az0UAArCAagHrfkcjgGRSr+2VJH1s0ucpNT3KEbdvdy2hbjQ3ZcWuGzYRtO4qi8oHua1grHKaGHa98mXKGFPoATRe8ffOl49lZS8Y0oezeDkDFDNrxmR4LOn4wxoOSlG76eF01ZwcQphgBV/HiCYtNB2qzsq4oF90MID/M9Tnizfti3wVBQ1AuWP0Zzu/beQAercNCAcnF5Kz/5eTJ9ZG9KUsM8gqmW3SAzap/BGUqDpslUgIZa+wHBJOlcmD1aKDSoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(451199021)(6666004)(6486002)(478600001)(83380400001)(53546011)(6506007)(966005)(6512007)(4326008)(6916009)(54906003)(66946007)(66556008)(66476007)(186003)(38100700002)(2616005)(44832011)(5660300002)(7416002)(8676002)(8936002)(2906002)(316002)(41300700001)(86362001)(36756003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7AST7bKd81QnJfbb/qGitMJ/chON5lauOH2+YBF8OoUNEtZ+X0e9RQSKf3g3?=
 =?us-ascii?Q?H5/s/3yHqkNci9n7bLOM2LPGKQFUpKbplLbMZs0wIffRBj0T8q19KEzi7S7b?=
 =?us-ascii?Q?7lxpc/tGh9H3KAYkSm9tWYdweflTYSh+TGYcN5zkXJjIT0coRaIsupLiVWGt?=
 =?us-ascii?Q?EX4sFSBuThoOdjc6PYscgNM5a2hpK2JP2l7LBNCuht75HkK5qKQEe7Ifs1Iy?=
 =?us-ascii?Q?NOHuScjh+ycOrDge5M6EUB9uWcObMwaJHABvW+EuRhkSymMuqmtkYYWbgmlm?=
 =?us-ascii?Q?kDrG2WsXJTANNneAkcWBlrzmNGZtqC1TGVRyNUBbdufG9ErRpz+OzNsqFVUO?=
 =?us-ascii?Q?/hLQmeuH1qmdMukux8+PxRLBQPDAECUVVaSNnIKjmTNEkOEVY4kd6Ra42izs?=
 =?us-ascii?Q?oyDqj8SfMpoGsoswXlmp4pBDgeIW5XUttTXIfE2kbXPEZ/7oSi1PBwadhDCC?=
 =?us-ascii?Q?lx76eKrm4FYBRwik19ObFRTdkfh/qtaYzpqUxfj9K4hThjBN0t7NhoGKzZIf?=
 =?us-ascii?Q?x6jElrJav9OtKXRXSTlNv3eolTgCRyRU+TE+9MKrIw1LQPhuhD8XOWS234KS?=
 =?us-ascii?Q?G4MKT9tyOi46FCWEjcw0IGGU3x2Um/JWnc4HImIRGzmG79YwrpvZcDefNDAj?=
 =?us-ascii?Q?4ayXwvr94yi4W7NVFA/ss3DarSxVixCdxXSZNzKhicFd9RL4c/eLlZZWrFgd?=
 =?us-ascii?Q?jXZZBzkoyqyCvNVZJ439uqfOBS0kwI8PEyGcVUh9c8J9BE11CpYBhRt+cAca?=
 =?us-ascii?Q?6+3uQolDVoQKVRjhVUtOx2B5o4if/9cmm2ntgkbAcYr77N7v6juNj8iEWHyW?=
 =?us-ascii?Q?7yKVCeOK5mJSjv4zkg4hMwGvJjaUpIKIPaMbhi6V2N+W2PtFBJktdQ3ZKCPr?=
 =?us-ascii?Q?xYiweOFvezOBEknccnb9/vLxmAL+079c+w7wdLF3oTduLF5k+EGKWWKBGVza?=
 =?us-ascii?Q?UduVHnM64c+3hmotj2F+pQQZgTYOyoqOpB5Cfhtf5do4kF9VsBnEpW33Yqgj?=
 =?us-ascii?Q?tCFr1h7SDbrxOvoKaWARqQuf5jxq2utz+DuQhppXK3lWfd8pkAUBwGyuv3K9?=
 =?us-ascii?Q?Wcn4cPdx+ym28PoH2+UpNJpGZKXUi3kzqLh5u3nvd/JwpOVR4+6bTg1JUbrb?=
 =?us-ascii?Q?K2iu8Usy9fE3eLs0iDZQbGcTWHu1IS2wbnomZOzOkjJ/8Ii2xo2MQ++aI8n+?=
 =?us-ascii?Q?Ydjr6ljFIla5ctevttzAMCN43ueOCF877S8c+JJ0ClLV+VgKw5dH/9WNNELb?=
 =?us-ascii?Q?P5MecR/dqgmxzNjPUVgzYrLBOchfkkOWpFqz9MVjNLwUROcnXCVdibPFHzGH?=
 =?us-ascii?Q?MQ2n3bWc5loNuc8evsnYO03ueN2+cf5cH12G6N1IaQz3QFRb8Yw0cBFIWvOl?=
 =?us-ascii?Q?9ZLK2TlAizjpQErtJWkyBnbIRSgYPUiWGUbdqIpXn1IfsZBMLjXaNobyGDCB?=
 =?us-ascii?Q?vpxsGV6naEpcQ3qRw1umpOyJSrQ4B6cxuzORd4wCmQaL6bWUTfebUO6aWc4Z?=
 =?us-ascii?Q?9OVoH+VVzc9t7KdPpOwICtG30lzle+HaKL/1z4o+/dffqvefof4YkG+oD1eL?=
 =?us-ascii?Q?3NAQV1nCn9P5UpVsy0sryKTERTdRPZNM868pfYjEtL/Md2Gy2YApi07eKuVW?=
 =?us-ascii?Q?jb++GE/AFVKSexwUo4m0tQa/v6D6fz8bNLTIHMErgR+1sh3K+K2QAIKQlOYi?=
 =?us-ascii?Q?qLWzLA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7349619-1607-4866-1111-08db8daddb79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:56:45.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BEoc8cdnmyCTCrevqMdnJTgZulsu+UitLBRk/57RiBSKk2v5Ec3B+Jno5/KP+FXGGoATnRxN4+YHmgSS+NFx81LrzNm3EIR/Ey3bFuQ0jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6458
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dimitry,

On Tue, Jul 25, 2023 at 09:16:37PM +0100, Dmitry Safonov wrote:
> Hi Simon,
> 
> On 7/24/23 20:31, Simon Horman wrote:
> > On Fri, Jul 21, 2023 at 05:18:54PM +0100, Dmitry Safonov wrote:
> > 
> > ...
> > 
> > Hi Dimitry,
> > 
> >> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> >> index bae5e2369b4f..307961b41541 100644
> >> --- a/include/linux/sockptr.h
> >> +++ b/include/linux/sockptr.h
> >> @@ -55,6 +55,29 @@ static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
> >>  	return copy_from_sockptr_offset(dst, src, 0, size);
> >>  }
> >>  
> >> +static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
> >> +		sockptr_t src, size_t usize)
> > 
> > The indentation of the two lines above is not correct,
> > they should be aligned to the inside of the opening '('
> > on the preceding line.
> > 
> > In order to stop things being too far to the left,
> > which is perhaps the intent of the current indention scheme,
> > the return type of the function can be moved to it's own line.
> > 
> > static inline int
> > copy_struct_from_sockptr(void *dst, size_t ksize, sockptr_t src, size_t usize)
> 
> Well, that would be a bit more GNU coding-style alike. Which I don't
> mind, I can do that. Albeit it's a bit contrary to an example from
> kernel's coding-style, where it seems preferred to keep it on the same
> line with function name and rather not to indent argument list, see
> (6.1), second example with action().
> 
> Yet, I don't feel particularly strong on either of options, so I can
> just do as you suggest.

For some reason I thought the style I suggested is acceptable,
at least in (some) Networking code.

In any case, I also don't feel strongly about this.

> > ...
> > 
> >> diff --git a/include/net/tcp.h b/include/net/tcp.h
> > 
> > ...
> > 
> >> +static inline int ipv4_prefix_cmp(const struct in_addr *addr1,
> >> +				  const struct in_addr *addr2,
> >> +				  unsigned int prefixlen)
> >> +{
> >> +	__be32 mask = inet_make_mask(prefixlen);
> >> +
> >> +	if ((addr1->s_addr & mask) == (addr2->s_addr & mask))
> >> +		return 0;
> >> +	return ((addr1->s_addr & mask) > (addr2->s_addr & mask)) ? 1 : -1;
> >> +}
> > 
> > Above, '>' is operating on two big endian values.
> > But typically such maths operates on host byte order values.
> > 
> > Flagged by Sparse.
> 
> Yeah, the function just has to provide any way to compare keys.
> So, it's not very important, but just to silence Sparse I can convert
> them to host's byte order before the comparison.

If you just care about equality, then perhaps you can use an equality
operator and avoid converting the endieness.

But, unless I am mistaken, '<' will give the wrong answer a little-endian host.
And this feels, well ..., wrong.

> > ...
> > 
> >> +static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
> >> +		const union tcp_ao_addr *addr, int family, u8 prefix,
> >> +		int sndid, int rcvid, u16 port)
> > 
> > Same comment about indentation as above.
> > 
> > static struct tcp_ao_key *
> > __tcp_ao_do_lookup(const struct sock *sk, const union tcp_ao_addr *addr,
> > 		   int family, u8 prefix, int sndid, int rcvid, u16 port)
> > 
> > ...
> > 
> >> +struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
> >> +				    const union tcp_ao_addr *addr,
> >> +				    int family, int sndid, int rcvid, u16 port)
> > 
> > Should tcp_ao_do_lookup be static?
> > It seems to only be used in this file.
> 
> Yeah, indeed. I think, I noticed previously, but probably managed to
> forget. Will fix.
> 
> > 
> > ...
> > 
> >> +static int tcp_ao_verify_port(struct sock *sk, u16 port)
> >> +{
> >> +	struct inet_sock *inet = inet_sk(sk);
> >> +
> >> +	if (port != 0) /* FIXME */
> > 
> > I guess this should be fixed :)
> 
> Fair enough. I think, what I'll do is to remove from these initial
> patches TCP-port from uAPI: we've expected that it will be useful to
> implement port-matching, but so far none from customers requested it.
> So, it was left as reserved member in uAPI, not meant to be used just yet.

Sounds good to me.
Thanks.

> Separately, as I've made UAPI structures for setsockopt() extendable,
> see copy_struct_from_sockptr() and the extendable syscall ideas
> (unfortunately, not in Documentation/):
> https://lpc.events/event/7/contributions/657/attachments/639/1159/extensible_syscalls.pdf
> https://lwn.net/Articles/830666/
> 
> So, as those structs can be extended in future, it won't be any hard to
> add port-matching on the top of the patch set. RFC5925 is permissive on
> how IP address and TCP-port matching may be performed:
> 
> : TCP connection identifier. A TCP socket pair, i.e., a local IP
> : address, a remote IP address, a TCP local port, and a TCP remote port.
> : Values can be partially specified using ranges (e.g., 2-30), masks
> : (e.g., 0xF0), wildcards (e.g., "*"), or any other suitable indication.
> 
> I can see some utility of TCP-AO key port-range matching and it seems
> most useful/flexible, so I'll add that. Unsure if that will go in
> version 9 or rather later (even post-merge).
> 
> I probably have to add something on that mater to
> Documentation/networking/tcp_ao.rst as well.
> 
> >> +		return -EINVAL;
> >> +
> >> +	/* Check that MKT port is consistent with socket */
> >> +	if (port != 0 && inet->inet_dport != 0 && port != inet->inet_dport)
> > 
> > port is host byte order, but inet->inet_dport is big endian.
> > This does not seem correct.
> 
> Thanks.

...
