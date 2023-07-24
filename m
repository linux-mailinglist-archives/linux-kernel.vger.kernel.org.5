Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E975F7E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjGXNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXNMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:12:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17659B7;
        Mon, 24 Jul 2023 06:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8KNCsRfUkXrqOxOPNgVJwX0IQ41hhjgP+deCv/mwZqnJUJptZwEzb+m0TphbKouqYnT15OWe+WuXrpxF1S2h0zWdd7n12am7mHEgQBsIGrJQOlmFWOc5xGRz6qyTtYmoGsflwfmCUtofDUGovhD3MG0YEePseG+oekAsGexLtnwOygeZ4VE1E3+uEi021fKkEmMuzj8XmcDdWzVn58vFb/V27TV77b34uCS19iAep6/Z9KnaVMLbEYd9WXpoPIWyeyLIhmzpImaZakTzYMchdZOIT4n85Dnq3QoeYo3bRrj5eRqKBshkJIyWzL4VULRlo67xf82LthH0rxJ2cfiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3VslZjHnlya29kdfHHa25qxC1TG2w/WC94dq6hgur0=;
 b=QyykrapoJRzl0eIIbYbKmNvk/Kp6rry39aBbImzKarR4z7FEZEdD6PDo5i9Rk/6kU98yJt+3ozpmdtNy53/bHF+JZZFUXClkaKdzbgUySZpx64L0qZ3QSKZkGWBZW6DplF7cQJCBaudHWpYmtIjSfcuosldB9cg9EHWUb05XzzEXJmGVzbJ7jMPA2ZVDS0/vbtuDomAmenstWpNLn+xigvWbcljh1cFcAfjof03UWiGRAJdAwQ4wLt/rOiW6ATWgNDueUV21ou9WhW8XPgvbbMMYUhSWWVHxm1xMoRMS9JIevaa5x+JnZi3leOJUA8ODwtwiunjSTiPIJTcsXogTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3VslZjHnlya29kdfHHa25qxC1TG2w/WC94dq6hgur0=;
 b=l+6e+RdJ9l+cq9yH20ktLaOYI/S7EEhxRFNnUnwvCW8+mcbyDOmXilJOiCbuv5DCkAiBU7Nvy1AKEUMurOlq/3e7RzZZ3r3RwEgpHLOJzLr8tqLINIy/zxnAOGrwRYYfFdGEtyut1gceNovFWARhFHJiDi1w2o0ddS/liARHeSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4797.namprd13.prod.outlook.com (2603:10b6:806:1a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 13:12:02 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:12:01 +0000
Date:   Mon, 24 Jul 2023 15:11:52 +0200
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
Message-ID: <ZL54mOdTzX5Z9Fji@corigine.com>
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-2-dima@arista.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721161916.542667-2-dima@arista.com>
X-ClientProxiedBy: AM0PR02CA0176.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: bed38107-3905-4504-f7bb-08db8c479158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eACSCYw+tl+YPpJkAL2mOjD2sZF8Llr2UP+WYzXPWV4KIFdgl70Wy8twXylhOq72Ffu5tsIC3Ip0+Yj9pEPLJwFfhE/iOD0JhQ5jOHvr+VCjWAtXnkCTv3gIR0OYOpMULnLtjoyxxqxpwIUdXL1U/qGzr8UxTXLB0REp6POEEmJ1A3lvB9LbBMt3j0jTAn6vtzv7zM716Uf3F9GwpH8lOfgSgGE9FTnuh42CkqaaDQrhi2KoACngb0ctNiXEGRFR53rGwFTwW8a/mx5TBoHwmkKGfeoyw+Q7fLYk7aQSu3axgJ0akUxjCtmFLoJHVuwEd7G5ztQC4moNUzqKYpB7H6kfmcgVtJ7yJ/+xjOEJ411AATWWWPxg77FXqS5ZMxiti2sQpJSYavNL/1aEqBzrCf7ShPfpgTGPSnbEloqxN3U5Ncis/hsZgRWEdjRwH1RsxIQyEw4oNv4MRMf0zLd4tJH8dW7zLc/yqN5FyXQlTaEoiaAb9662Pi+WSXFQMDYrzUpHdpUzycrfjLetSEwA1LiDi5jOVT1yZPH9VQmDdNFkCQ3W1A1m++hC3orOidSFXX3johCH0JiKHm55GdlKrFw2rKDsDjTTjr+BUgrKsgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199021)(36756003)(7416002)(44832011)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(2906002)(478600001)(2616005)(6486002)(6666004)(54906003)(86362001)(6506007)(186003)(6512007)(6916009)(4326008)(83380400001)(66946007)(66476007)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0wKTUmgCIrqvWJ0OTVSHDGiTm/J31oDTDunyiSseqCRzTUouQbQIaOR0VTu9?=
 =?us-ascii?Q?puHkpIDUe5kwoqk1FuUzCtj5CxFyXYVRNVv+OobxkgodNHAXsxV3w46bcJ/u?=
 =?us-ascii?Q?JLFbRoqPprE7h6fX61rlAouNmcMYbiYeRIk/4r86ItvpjmuqeWkFq9BhjA9W?=
 =?us-ascii?Q?P3Xr+G7jmefvwPpmAUqlGbl7lyL9Sb1I1TZBMix/odREPlhiQQzVCP5x/1sh?=
 =?us-ascii?Q?8pxHdxU0ApFZ0RuGTIFsiXXoUR9hspfrjaa8pq1e/JbFSTXZ7okW3gqcDHZH?=
 =?us-ascii?Q?3ECir7wJL/H1W6jxmoqW2Udo4fBPWwDbaitYKlRboTp+xsrwpln4clf6qTQX?=
 =?us-ascii?Q?4o1W+/56yVRRV1AHcEFvIqInFzcSs2nnIgf6m2Xkdpt+8U1jaPMVKuE5TeXZ?=
 =?us-ascii?Q?fIyXAIyEo7mXt+ryzHXbyrWEMAPBgwcvnZBITmqij+gWDAThe9jBptUc375+?=
 =?us-ascii?Q?2lRFWj9LkPtxq6NK+BCEZU/Pv7c2RYho1QSdNFjpBe4Bn9HnOgSrKUQLuWVl?=
 =?us-ascii?Q?ylkBM6jH7bTRESGyFX9jv5vT4XHlthv3pmc7W3Lf7G5in9lmFmLuIrcvxwzq?=
 =?us-ascii?Q?DE1937HKkFoMpv4kpFwwUKAOQG6TDWMMNpSqJ61jp8nZ4GLi64mZDku0kGno?=
 =?us-ascii?Q?MXV63FLPdbgOx0cwNFeW3ps00XhO2FjNt2RpSjDrpe9a1VvfGCCgpB8pSzMG?=
 =?us-ascii?Q?FJQvoefvwOXgNPED2mKOIjOCriisxxNwgUxwk57V0GuScUoNZ3iDBZIEvn17?=
 =?us-ascii?Q?ly53p+12AAN1NbtZI/TOO/4yGx01si7yzPmgS59lcQa8rm8mfOtkcI7e3iun?=
 =?us-ascii?Q?d6R7PuEYQRZgmxBxbYlU2AMGmWbhNUbnMzzCp7uHwD6GEimQA29Kfxc9LXNJ?=
 =?us-ascii?Q?XN2O1EwRsHdh6tSivDN/+CPQUjtG34cHIH0xUCpPj7DZaOR6eyryCp1fExP2?=
 =?us-ascii?Q?XQnkr+dCWagg76cigSXgWkR9yTrLXA4ulrpw7qq4A9olGK8JdojVfAAz9FP+?=
 =?us-ascii?Q?oQiTQnVkWP5bZKJ/xINNKg3jKdtRUfBy/k4kW+Y2Yjc/v6adN9GozE8yXCia?=
 =?us-ascii?Q?d5WbXCmO6eWMhABeVh7hjEx+61TyGYYVG3zlV3L1we4yqLMncS9IkJ5EkL9w?=
 =?us-ascii?Q?a47+e+1lZRq3akVuLrlhXZHqPDcbi9KV56JaT7BlzDvXLyKx973ISciazA28?=
 =?us-ascii?Q?8b/rJhwM8UWZY35DyMR+NUZi4NaS/LoLRQCtUuki6yPb0HtIpsEGZ/FwVFcc?=
 =?us-ascii?Q?qGx/8PlFdia5pEfJJ4ILkRfdEAaR9RCw14p1hfqSviZNI6pFGwPP9P71khv5?=
 =?us-ascii?Q?5dVhuFDa1vAI2FJ3WrphUReXy++0XKruhJLYVDJ1AkDVnki+aJ/BLpiCikvX?=
 =?us-ascii?Q?iv6Q4IZogeKCyzKEBIaPfDiBLjuTn/ztsZqJZAlsE8x6ztPENFQu+ZR7RESw?=
 =?us-ascii?Q?qrb4698F5VBLNjMpjspBCXjjd6ePsG5qC6KXMMYfO67Q4p5GDlMAfrBiuPaK?=
 =?us-ascii?Q?jQWdHloSnhBVBZ3McQMaup+Xoknqh8MJ0ajeXtur66Y/Un3MKko5PpoG6bJZ?=
 =?us-ascii?Q?x4ieqhew4bW7pCag2rMSlCn4giAqb856fmprfbyZIgWfXhbN8uuqkxZmWLmw?=
 =?us-ascii?Q?hs46fwNBkpt4Wqzrp20A5kT+K+1LIIuWUbHykmwFVFOtIgmTbpcTWx602elu?=
 =?us-ascii?Q?xq4zow=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed38107-3905-4504-f7bb-08db8c479158
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:12:01.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzQ32QvifWGJlwxdPaAblCwWQiJvXpwWlRAfbLMdqCOgkdzZBaBygjNm7cYLiIbNAHmIs7VIk58AfuzjpuG3RcGaE7Vf2kThd6CFci1E288=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:18:52PM +0100, Dmitry Safonov wrote:

Hi Dmitry,

some minor nits from my side.

...

> +/**
> + * tcp_sigpool_start - disable bh and start using tcp_sigpool_ahash
> + * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
> + * @c: returned tcp_sigpool for usage (uninitialized on failure)
> + */
> +int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c);
> +/**
> + * tcp_sigpool_end - enable bh and stop using tcp_sigpool

nit: as this is a kernel doc, please document @c here.

> + */
> +void tcp_sigpool_end(struct tcp_sigpool *c);
> +size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len);
>  /* - functions */
>  int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
>  			const struct sock *sk, const struct sk_buff *skb);

...

> @@ -1439,8 +1443,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
>  			const struct sock *sk,
>  			const struct sk_buff *skb)
>  {
> -	struct tcp_md5sig_pool *hp;
> -	struct ahash_request *req;
> +	struct tcp_sigpool hp;
>  	const struct tcphdr *th = tcp_hdr(skb);
>  	__be32 saddr, daddr;

nit: please consider using reverse xmas tree - longest line to shortest -
     for these local variable declarations.

	const struct tcphdr *th = tcp_hdr(skb);
	struct tcp_sigpool hp;
	__be32 saddr, daddr;

Likewise, elsewhere, when it can be done without excess churn.

...
