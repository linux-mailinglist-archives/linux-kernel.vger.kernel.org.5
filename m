Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F680783485
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHUUny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjHUUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:43:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47791988
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2E0mYulHFQryT43++sEmPKC/e+paZYpMIPBmz/HFHsu2XSnyxJXDjiyfAIZ614W8/GulMY53sf7yQIHmPnb/TFGgFH67Tx1v5jZ0Yh5Dten0DYjcMcF7AhEKANK9MxYCEHIpwWiuQUtXZwc7jseChrEZUZshn/PIcaxVuBIP77BRcCaxbbSWUK8vp4J8s/MVGTKu+Ejj9PQYR/KOHAF3Ug0bVBHeCon887bcUldv3nOetpoN5RnzjtN+2ARbN/yv2hk+FfV+LP1tp8OjFqB0cZpMzG3sFBhPD/KHWOm7L+DNybi8snqyYJguWckewH+J3nduPlHGI/Ifn8TYH6NAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap9jAj8OKf97L7eip4HJOiqQWpZIfxZi5v4V08AfJSc=;
 b=Q41ceaWRGpWq33hYD4eOrVwkTTGiP1yKFT/TNo+8j1s0cMcGSEvv8WD2SKUNONxPkpvJSSxZBieCCqVZ6OOhVXApVhDz9MTseEeDZGFsNeo/YoTZePNCvmoHcejpDmjAaUZ4GnZb/w080b4DTxCaQvi1GX6t1rmu8lgsYai9ty6HGfC0VnOu5qtJfyzal6HRhReEs2R6pnxFB3m26/ZikebjOrv/dVMGepf+hIp3ttMP8p2LorkhscoLZJV772QHOSnbgTT8ELHjzs2S8ObIJwbH3P3RSTwbtN5j04JkLIBQJ9aDaoYrSsjd7u5trea3aSyOUzWK4PiBxPu0Fqv9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap9jAj8OKf97L7eip4HJOiqQWpZIfxZi5v4V08AfJSc=;
 b=q5qKqMch20pkwEZTYPZyNy8ltET21KjgWQkLFIfgRxZJhPIZo7jKhrktsb9dwq8ixkHkFRip/JtsQ2HhmzKEXjD1zrQhFSY9mPR7Srat1IYp1vVkmj0E0KBCAaWBUmMFsYtOJOv1IaULoQ9c2ptLOdsatLHU+qj8iHbnngEqABxvsF1yxLWt1OzjdTTKfVx150c3tQMBULKDbU9YoiV2yuXlJoT3QnCsEVgIN2IwdpufK8tOJkp2C5aEhevhiinuQyUTxWMxS8OhKRFLNZRui5sFHdYKEV7fgHVvqwNOX5eu6es1/LBuLSBw/2MnNKU1LTFSGtFNnhOodWXUbU8TIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 20:41:47 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:41:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mm: page_alloc: fix up block types when merging
 compatible blocks
Date:   Mon, 21 Aug 2023 16:41:44 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <F585906E-69BB-40E6-92AB-37D4E82CD381@nvidia.com>
In-Reply-To: <20230821183733.106619-5-hannes@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
 <20230821183733.106619-5-hannes@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_F12EC893-7E6C-4964-A9AD-546AB8805FCD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0022.namprd19.prod.outlook.com
 (2603:10b6:208:178::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bee1353-f13c-4649-de04-08dba287098a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +m26wgrJuNXdiKv7IUPrq9wYWAk2sAV1meBjBQdRTm4926Zo7Q3s5MibiX2feODlicnn6N3praH9O2PMoQusVK62jCOHcflmoUipDuu1hdJ0f/Hu5wrbCtpxw3xfhZsvKyRAViAlkkUUNpJIIzZYdOGY7+rlkRnN5UYwUMdnMdtm6cXBmkp3KaN+l0ACMNZrn36iJpYbdyNC5ZiY9Tz6RydlkqhrKNuE4u90cnpW3D5ObamIDrJRnNu5XP27MJXDcSLF6hJB1b1EjMj1Cq0fW5vaJGJF5UCB2AazNmYaHB07yLU4uDEkgcpftsUgOSvH2FjCSN4Ei6AmtYADenTJy+p6SeP40V6Hj551BnQ3dObLFRy7X/nJkWa0M1z7sl6k9cJ+cGZb1lM+vo0rMwlUq+x3ejd7oJxvPsBXVLaHhwsP31Bjq6LDOkrdzo/P98N7wEIeJwX/wClfS3kh7ODARfrIbTxDpyRktmKdsxdWrz5VWFWEmj4snAUXswDGxrJQjmQdtZKEV1Y+BR9uHgtosd0uqHt8SIYmDYU7hjTOXrcIEDtcNyaubYYGsJHzZvO7zOWByoQ+faysoCPVqWmQ5BaFHY+U1NmDhRWtxXHzwACt3kYPextOX7UouctcYGM6pVR1hqutwtPunFYi41OMJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(86362001)(5660300002)(2616005)(41300700001)(33656002)(66556008)(66476007)(316002)(2906002)(66946007)(6916009)(54906003)(235185007)(8676002)(478600001)(4326008)(8936002)(6666004)(6486002)(53546011)(6506007)(38100700002)(6512007)(26005)(36756003)(83380400001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eBCG3b8cC9D5Ufet4BkhgNDgr/52PAVNeNjQ61z3gMm0I8BaeCdHVJxxTo/l?=
 =?us-ascii?Q?+85Y0HtXS+cUSyBB2pKS/6VeChC/wTnfnjr1XJ5UqhBK9kN24gj5MF6+cO+d?=
 =?us-ascii?Q?MNqi7kvDYs5KNMZDo4GiuuRQrTvOU/6jTMKEtCUMQT9mlICiJUXr5/+68LK2?=
 =?us-ascii?Q?BS+vdzqxiqUL3yLWWsCbZAxTaOksIxDt7rTccmrw6rzt7L1hnch88ndh63H7?=
 =?us-ascii?Q?a3FnDzYfYNUeMqkW9MFB/MYNsIHrar69rAaTisbSVERJ3L0S9+GLuMyUto+f?=
 =?us-ascii?Q?f8eX1tWHdq97PznXLxMlMhpPV2w6HZDxF0pRha/AikZM91Y+aV8pmuiBOigO?=
 =?us-ascii?Q?RrvAZYEPwS4phKitQFNBuRuHkSE0FDV/k4+/jQnVfAzIigpawZiPsQ9Fbv6u?=
 =?us-ascii?Q?ivjy5zJSTdD2++7Mrp3Af+EobWaMv5EAGGMZotlYfI578ZNbWmcEVS151vFp?=
 =?us-ascii?Q?zdoVHxBEMVAFDf0dniDLLJQH1UAsd9BgGUsRfqybfasTtnjkvM/O/krCZRAJ?=
 =?us-ascii?Q?x//tPsHUz9PMbi+pTDUeggZmKE72KRrpKRG20bprqlFHSjbzP7YoPGg29A8b?=
 =?us-ascii?Q?lVFiUdIW7YlYH0FwJycvcTqjotYISHmVvsoc4S4LB7DnXq2LcSqt+pEVfvo5?=
 =?us-ascii?Q?QqvjkvYKxFQgpPamTlEGdnOBDjtjkxg8/TVTWhQU9uUbfeabofGStUBXKYo+?=
 =?us-ascii?Q?v2EA9JZwDQd+I+4Ehtq3OV+0dqpkx0CIybg7HWa+ZkWyPJ21cQugRgMOmZYd?=
 =?us-ascii?Q?7ozQSiwV/4Ye5fUjhuRr9YGhA1Yo7p0TgXi9AwB2J2kWn56AS+sR6lnCRXma?=
 =?us-ascii?Q?DDaWxpPg+RG6DhoTkuQi07HPPeEtgH/rIIpcy1BWGM1f7/afEIhrLF8NB+jp?=
 =?us-ascii?Q?ppCNPFmfXBdrENQACUeKLJ3SsDy6Z/vQlu6mhZGt4FrFtGzYhom3F+GNQlx4?=
 =?us-ascii?Q?fIXW3KaZqajU5X1rIJWdooGaINdXV+6i916AL5Nw7N/YsbNIosh1g3jxTddU?=
 =?us-ascii?Q?mfZMSVwyhKsl1LLucW6D6dQfysTkvt644sGOhfSaQXotzak4OHHmtfevGrQm?=
 =?us-ascii?Q?VsihI3xsdtQxz8/SnpHIKD/VAI8LuG/kgZ8im01nMGga5g54vNDB4nsDui23?=
 =?us-ascii?Q?H2W5jXysfXsV8KcY165LGcRzd7XPDgX4ENfXm+Dt6xY3HUGTfz2A+UNuacQc?=
 =?us-ascii?Q?LA8PgznS7IL2vk6mA+LmOVwm+kw6iS4j+4F1C0aeXjKDd7gUyuiJJ2zSWNda?=
 =?us-ascii?Q?4pw3jGOkc408aDSnoODYJo5qEsR0bkoXQ9eXAZwlmY6XbXC71P8vtyp1A/YP?=
 =?us-ascii?Q?k1obvRVsc7GBWm18o6NUsfZlYepnsnbrZzhZAWcfE/1tYPTPJNgy5D4RKnAf?=
 =?us-ascii?Q?1HzGXoxJQLgkSX6T3NQzkghO4JO5NIwYVwa5IuIoxKPrNElfq6rjUSpofIfQ?=
 =?us-ascii?Q?6DlNYcRI/SMAQdOX6u5wQDJ+9v4SPeL7Sj+Wz8NC8AstQnaSWXqskjQoiN98?=
 =?us-ascii?Q?o8cOij7+6z2O0b7aZCUmeSFpkjZgcImqeGCOD234PsmHDIO9BvhBKEhS25Qu?=
 =?us-ascii?Q?+BD+h1I30++ShgU5CS5zY//0OKFsq6by6N/wdKnn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bee1353-f13c-4649-de04-08dba287098a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:41:46.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VftLOUSJRKfkOA9aYx2BY60+ktFJ+3U/9yWMxdNYvXEmBvXC+9yQ9FR+9wM1KLNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F12EC893-7E6C-4964-A9AD-546AB8805FCD_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Aug 2023, at 14:33, Johannes Weiner wrote:

> The buddy allocator coalesces compatible blocks during freeing, but it
> doesn't update the types of the subblocks to match. When an allocation
> later breaks the chunk down again, its pieces will be put on freelists
> of the wrong type. This encourages incompatible page mixing (ask for
> one type, get another), and thus long-term fragmentation.
>
> Update the subblocks when merging a larger chunk, such that a later
> expand() will maintain freelist type hygiene.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a5e36d186893..6c9f565b2613 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -438,6 +438,17 @@ void set_pageblock_migratetype(struct page *page, =
int migratetype)
>  				page_to_pfn(page), MIGRATETYPE_MASK);
>  }
>
> +static void change_pageblock_range(struct page *pageblock_page,
> +					int start_order, int migratetype)
> +{
> +	int nr_pageblocks =3D 1 << (start_order - pageblock_order);
> +
> +	while (nr_pageblocks--) {
> +		set_pageblock_migratetype(pageblock_page, migratetype);
> +		pageblock_page +=3D pageblock_nr_pages;
> +	}
> +}
> +

Is this code move included by accident?

>  #ifdef CONFIG_DEBUG_VM
>  static int page_outside_zone_boundaries(struct zone *zone, struct page=
 *page)
>  {
> @@ -808,10 +819,17 @@ static inline void __free_one_page(struct page *p=
age,
>  			 */
>  			int buddy_mt =3D get_pfnblock_migratetype(buddy, buddy_pfn);
>
> -			if (migratetype !=3D buddy_mt
> -					&& (!migratetype_is_mergeable(migratetype) ||
> -						!migratetype_is_mergeable(buddy_mt)))
> -				goto done_merging;
> +			if (migratetype !=3D buddy_mt) {
> +				if (!migratetype_is_mergeable(migratetype) ||
> +				    !migratetype_is_mergeable(buddy_mt))
> +					goto done_merging;
> +				/*
> +				 * Match buddy type. This ensures that
> +				 * an expand() down the line puts the
> +				 * sub-blocks on the right freelists.
> +				 */
> +				set_pageblock_migratetype(buddy, migratetype);
> +			}
>  		}
>
>  		/*
> @@ -1687,17 +1705,6 @@ int move_freepages_block(struct zone *zone, stru=
ct page *page,
>  								num_movable);
>  }
>
> -static void change_pageblock_range(struct page *pageblock_page,
> -					int start_order, int migratetype)
> -{
> -	int nr_pageblocks =3D 1 << (start_order - pageblock_order);
> -
> -	while (nr_pageblocks--) {
> -		set_pageblock_migratetype(pageblock_page, migratetype);
> -		pageblock_page +=3D pageblock_nr_pages;
> -	}
> -}
> -
>  /*
>   * When we are falling back to another migratetype during allocation, =
try to
>   * steal extra free pages from the same pageblocks to satisfy further
> -- =

> 2.41.0


--
Best Regards,
Yan, Zi

--=_MailMate_F12EC893-7E6C-4964-A9AD-546AB8805FCD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTjzAgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU+wYP/1iV6uG5LJcHOjy4ic9XL1jpuiNsbnmm7pwG
z2+lh63xRO2XXC6fZomCv+LQEGJmCkVDRnx1paTpTQI4Qx7GjfiEQMR8+MKUJY0f
GtH6HQ9mn1NnUkwyqoOxD9Jpbo8jzXwJxsOspdUHSDpVvoFuNEo/xCcQ6iw20pT9
AnIErRJBdYzc9liZ77wn8LNfnxhLk4N5cNAP9Li/nsIsKs98rEEgnq/iYWEfMq9n
F70q2RpYUWdJLbC4G82N8qYT5JiIpBN8rRFO4vgB1pMyEYcGO9/wMw1+OXJFycC1
Cevk4VWLKEy1tKVPMFfbRPY5x5QWsGViwT4dBh9qhbmspVZeadOAasEjoDy7ChPl
ECJXzj/ti0SsbEpro6C1e09uMCx3GEX9/oBKxf3NpGzsejwAbpHw7Ygwf0f7HJCg
c3DNBlzKTQg1pNBXufScf98VaxAxeY+6Dm/DafOJwuACbL5dff1ib1zNJnYxwhWd
+IdgT5FO+g3DwyP4aBfcjUXdwc6Xwe7jzH5oLvUqXNqN5fhjTfHdcR1AYEmv5anZ
DCO0xQaV95JWNp6wgexLES9PsaD69lbvbpN9FC/dThsRw3nzjqlvKE31jho0/0MF
jLojTGgah8EpkDyZlwGE5hXdCiLEG0dVTG969yVQqZQ/Wo47YtAx1qEJT01yNcqk
hS9B6n6z
=Hf5z
-----END PGP SIGNATURE-----

--=_MailMate_F12EC893-7E6C-4964-A9AD-546AB8805FCD_=--
