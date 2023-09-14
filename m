Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6876C79F836
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjINCgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjINCgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:36:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB01AD;
        Wed, 13 Sep 2023 19:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaFAFfN8Ko5zkb65SCv5TfYdNAgbZpmQG0TxjZ0ZTbknuHs6h9/EkN6tuTwA52NPZfwhUIjU/rYD+nUUxJcvhNQXKPsXNif4VhOP4l/pzUta56bLPqtpJSCd8zdM+bCQuMOO6k5ifqRIerIsgLNfUJ9iShcHJHQ8210lYTYN8A946740gLq/phvcRBS8EQ3hp9PMa04hSt82wxvpythLSKKR7M3Hsa7yj7iAE3CMkWVREZMwHbRRCw7rRqKx8xqWgKfUpt1X2r42j6jS9WNnknYQ1yvHbAq2rh76XzXywCjfurF3MkFeQwZdFWFMuFJc5trTOpt3lM0yualMJFDCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmb+6EBiwzbMX/nnlQfzSejCxANnKVbp3rjtFvANSVE=;
 b=QiLimbX2UEPL1WLiyNy3ENMy9NyOLaCowAK+//eRfMujAXAwkGKIn2TuPVPYTSpfgfMZWWT40ztb6a0iN2kv2Exq7bFs7W0k7SmjAD8G9DweoDq1bqYyzUy8DfvMlz9Ej14qcmLc467PNmnSfrqftY8UhxafxwtyOuLKL4a6nmXqfRPXEkYQeQ+zPfzKWphY6GlZtkKX34mFeDc1wTrmHHPsTZtNF9hXWH/uVBCnROjeGvaWkZi7MIerd8Sx/i2wwrFLktASY2Mp5uQDM7F04/9z301WKJgM7XCDYm7YfD5ScKkjrdmibI/c3NyDND+nHwtwqkSivRt8ifK+gGKcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmb+6EBiwzbMX/nnlQfzSejCxANnKVbp3rjtFvANSVE=;
 b=du8EKss4S1hsYBE5vtvhSLxjqqMpGjZptSxUn1sNEKZwC+lz12q8nzYVQBv4CnEZssg7M7szKnWWLV2bPrsQbOg9rxKmh4ON46C3Lp+zVql2kwKr3p0z2FlpUlApIXHIM6uer7L9P3S6GuSsBBmhwrUylBbV9jDEGkFf9fo6kyx2j//vi6D6BjBROYCxnMgdzm/B1MGKotm80CWkZt+nluSqkGfB9enrysTZ7CjNlr6qjy47Q2+aZPRUq/7xUsL2s8eLF/6vwQhjDbMOW2jUkYzF9CFZ7PZoUb1OVQVxS9Pw0WYlHR7mLrOH5xPtXw/GtCrVHgf4TOsA4FiOKYpMBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Thu, 14 Sep 2023 02:35:59 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Thu, 14 Sep 2023
 02:35:59 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>,
        stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v3 3/5] mm/memory_hotplug: use pfn math in place of direct
 struct page manipulation.
Date:   Wed, 13 Sep 2023 22:35:56 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <D3582038-7EBC-42A7-A2E3-E94B67B7371E@nvidia.com>
In-Reply-To: <20230913201248.452081-4-zi.yan@sent.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
 <20230913201248.452081-4-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CF07ACD3-5AC1-4BE2-BB2A-094F9A86AB94_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH0PR12MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad760df-44b8-47a5-c4b7-08dbb4cb5484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gilW2ya+IP4AOtD/mbqv2NgQrKBIVMILBhegBLabGdpuDSOqlWdUbJ/nek0CTvPe4yFmcRRdQOfrJmM9RgGmdjtV+CDrpBu3LquP27pJof49xh07n3Sr7kyq+6xKbH7H8im/N6MF3mQg3CBZK7dYPBFzhDArwgGcH8ZXR9nfnKhtc9b7rnTQCHmpjDMKfx7aLGh32RJcWewoa/0gxA3MYGZ1Iq2PV1Z10FTQzqrl0jBlX6u8xWoLt1eWADHtCYyx3I16RSGZ4sr2pngAVgS+Ol8c54GnRBEO/L2+TzTGe6IA7xwaW8a4QGg8v+FwjXLHJUzhA4DqIGLxZjqL6S6FdvhleRK2Kb2PxTsZUpTdyLgULulFTNtdE2c0OzhFzz12XlVBsWwIPBKunf5zraxrA/B7Z5X6DuX/e+4ZYJA6hFvNNfftQU6BGSmPo+z9l2i4UFEcHwiXyZMGA7W9+JRcy3SYmpcNHCvYw/Y02gU2YQ7Ygk7kOU7645i9g1Cay0ux3n67G6PAM/DentA4U7FG8EDAJs3OiXcxf8l8dTFYI6vT/TREHK8gg/FweL/1cZJw9MGNEO/RIJ3nAXfIYqyek39a+E8pR5su8WAmCTAs4G3WtfoZwZKfteRG7uqQT13l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(1800799009)(451199024)(186009)(478600001)(6486002)(53546011)(6506007)(6666004)(6512007)(83380400001)(235185007)(26005)(2616005)(4326008)(316002)(41300700001)(66946007)(54906003)(66476007)(5660300002)(8676002)(66556008)(8936002)(7416002)(2906002)(86362001)(33656002)(36756003)(38100700002)(66899024)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ymjz6x8qtO0LMBUMD6R6YYSanXAyPkyWt6RGtTDdYnluNcQpnhL4Xx/P+FHf?=
 =?us-ascii?Q?NpiMVPgic7pvYQ+6U8wKLxyDngj/wh4boLySbshSrB2ECx951akhClbN9W/J?=
 =?us-ascii?Q?5gNk8/wyGS4OblLQztqkmc+XNh3DWFk/X6I4uc/zxjsC/6Lxbgomqa4t5Hwb?=
 =?us-ascii?Q?WR2sb+qLAeakzcyOfWpn8BJjzv2XUDtT2qiAKdY59nAj3d50hVFx7WgHHqhF?=
 =?us-ascii?Q?psJl71tDve/i9qGtAi9y4GwuB3Br8wzgKPUjKIG8Jd+fcj025QVpwYPAHGs2?=
 =?us-ascii?Q?LLvkFsKA+FrZDLyOahBhAjHsffAHfixyH+WU1HZ8mNhU2sptmdiS8izXiM+w?=
 =?us-ascii?Q?mySAfDGqR1+L7XNZ5LpfC1OWsywi5Qv/FbkFwc2reOlbVNMD8rcQa4jfqXAO?=
 =?us-ascii?Q?6rElrQvljM2MH51SWgoQ0Nff6b8Iugilw37v7vHknC4vDZyAsPK+hwycal5Y?=
 =?us-ascii?Q?iiSZgQ5NeO5p5vU52UI65YRTcsUGwjMqp3OyrjY3lkDmE/9m3Nw8A2FeKRIM?=
 =?us-ascii?Q?zG5wV/W4YLyN5pbdDN8qQyFH6VabDHMlTnAQdXCteFDYR6PDOQdGetmlcZQ2?=
 =?us-ascii?Q?wCP/sBNQs6+l9s1ak7vkBAE54vyHR6oMVEGlu53CoiLsBdBzgiB3jvbcHxHI?=
 =?us-ascii?Q?X+4u74yUoAdfUBZT6ptMVb5UZcBo4Dqz+i0DNkEn00CP3OQ9laCpA82ZwgZn?=
 =?us-ascii?Q?YFM3f1dGFZsIqBZ3KVHWO641BMwGOXuaGsMV7zQ2IEwK2IqHVnWp3otIA3Y6?=
 =?us-ascii?Q?+aEEWiF/c+OyBJjMZUR91y9P1Qp6QGOg3RDr5Kjd2NhPaI5eAB6S1+S8vG82?=
 =?us-ascii?Q?d3PYK7VmKay8RWfSAxo3rwExT2aQDLLF58RZ5qGGAroR/bZvi9JyUbODqa15?=
 =?us-ascii?Q?oNWt/s+WmWWu3pFNUyuvG6R8VZC5mbg+rA3dkafRct1r49/Mjfo8clQ1MAS/?=
 =?us-ascii?Q?fNXz9vJDcNTXRiWX0qyuphAUrToOjt6qBenxgBYBv7596eL4+Fvw1nl+CUXl?=
 =?us-ascii?Q?XsgEsbsJObxZl1MSz9I/byPvzM6V22HiBjNLpZFOPLR/hC1nTNc1tkQkyQtg?=
 =?us-ascii?Q?rTkvRJFPVFP2AZQNSfUvyFnMoPokyhliEZnbczT5GH/QyUtgHAwz5Li6cdyM?=
 =?us-ascii?Q?jU01jlgUh3tmzR+nCSffKX1+kKX3u2uBVyuFBQHJlVlochIaLec84FQYFma/?=
 =?us-ascii?Q?n14/M25y/a6OICh6c8h/x4XQ4y1vHpq/ao5dN8y5qfy++6tqNzKLoPqaa3ob?=
 =?us-ascii?Q?jQX0JPX06dAfHyIsnJAPP6pWRujS8PZumlOuUENDPfR+vwWug3FL5khQCkFP?=
 =?us-ascii?Q?dN/hinyrYbrwT/yjgHztvsH72UiaS7x8D5RgIwCV1vLTE5G44TaECfDC6QPw?=
 =?us-ascii?Q?JgVP/vgFZhcpz3UhnfRdYshHi1IXpNNX8Oygda22Q/qxCO8jPThk1kZzKBxe?=
 =?us-ascii?Q?7GFauEfwYL/Nxx9bu8M/DCa0T+mv8BEm9sS0a3bBqaSY94Hwgj5U2gbDF/Rg?=
 =?us-ascii?Q?g+SyU8uxbC3BqTn+GF3rSpxrdb9LXbmMB4KyJyGgu1RmVHSlKDhMe2Md/J+N?=
 =?us-ascii?Q?rLM+PYXTr+HUF/cnJWCO3lNIJyFozfbCM6KjG4yx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad760df-44b8-47a5-c4b7-08dbb4cb5484
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:35:59.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASjYkjGRGTd2jos5jBNuB+FUBGuZXLUYlDD7Cl5yYtLJ40F1+XJ2p6YrDtsHXr1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CF07ACD3-5AC1-4BE2-BB2A-094F9A86AB94_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2023, at 16:12, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> When dealing with hugetlb pages, manipulating struct page pointers
> directly can get to wrong struct page, since struct page is not guarant=
eed
> to be contiguous on SPARSEMEM without VMEMMAP. Use pfn calculation to
> handle it properly.
>
> Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for g=
igantic hugepages")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1b03f4ec6fd2..3b301c4023ff 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned long start=
, unsigned long end,
>  		 */
>  		if (HPageMigratable(head))
>  			goto found;
> -		skip =3D compound_nr(head) - (page - head);
> +		skip =3D compound_nr(head) - (pfn - page_to_pfn(head));
>  		pfn +=3D skip - 1;
>  	}
>  	return -ENOENT;
> -- =

> 2.40.1

Without the fix, a wrong number of page might be skipped. Since skip cann=
ot be
negative, scan_movable_page() will end early and might miss a movable pag=
e with
-ENOENT. This might fail offline_pages(). No bug is reported. The fix com=
es
from code inspection.

--
Best Regards,
Yan, Zi

--=_MailMate_CF07ACD3-5AC1-4BE2-BB2A-094F9A86AB94_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUCcY0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUDJAQAISIFgwxwwSEumk/7K1FlUq+A9xPmFtQGMDr
Y6K/uUygbW/QKqsY/SOciEGFiqny+emJaYb8kaxNnj/QU5lmti8Y88A3gd8T2Zhl
1LDrQ2LkiTywwtsGAiD2xFCm3vJNUhcrNS/pGU0tQiDodbW0miprgLxmlQ27Xh+3
mQvtL39iCy1FwOnczguSxst6RHPlQ/Q54XH0ZVwuXQGxl2Wm12prSDnY2/Rc3utq
6OSetceM7lGt5B578KXelTlRSU485f83ClwTVli7qk5njeg61Bz+qD/UgaUkLxeM
U9chkKceAQmGkXe+ihD+BztEmWbdDfQw82tq9TyXyUWmcx7r+liBz3VLhSLu1ZME
DanbVELkplQVmJu34RFuOrGkYvCL2V5c6QJMH4ObWeq6uhgWdcwBRVk5oJuDLgUn
I8JlKCNdCIou6yH5uh/u0rOWuC1WDg3rRT7EIGa1gRFMFgwCwFnu3jlt8P7pUAjb
LOP8AHpz1CouDidS45ZJRSbqvNJclaWeboukoLu/mm+LZF9ji1Yx0BrmTfAmP+T5
QwFjmWPhUqvEXIs+dmQBHG8k3H4Y1BN8Pacd+TZRRnoz5JWXvQtWWlekgASyW5V+
kkgBr+vP3R5VRXR7Xk9NZPvs7xqWXWSDhbwgnHX57f7IKYQJAK7LXueHmyx94AoE
ZypezW9u
=TfM6
-----END PGP SIGNATURE-----

--=_MailMate_CF07ACD3-5AC1-4BE2-BB2A-094F9A86AB94_=--
