Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C44E79F850
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjINCpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjINCpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:45:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B672CE6C;
        Wed, 13 Sep 2023 19:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqxG8bL+p3SUE4m5fsT3CGJMRbHpglkjuHSiNUnl4XkcnuT40/OQi8IX+o+b2rbckcS7QC2g8sH59cwYzxdyBjoEPlEc9Dwmu8ppS5lGdk18eGH6+KzNkwUTRwH4bBI1hrc31h6CZbVCEWJ2aC8wROoGlghd3bxB/oHeWBqmel7GucNrwLdIQcnvGPN0+u1hjiwZ1lSizkNaFffBHTYDFQZ+iFF9h7+5X2TpV1sFoqqofSI6AkfNwVlgcFu7/LcZNWX7Yf4qTv4b4U7fj2X+XzwFOh2Yf9ZW6/il/a5tORAyOEX3LLG7BtafDiMAsBU7MZdVBkUPemhiJ6aWZ1lNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9lEUyI2ce59pgnBFyNejTBiSqw65WNwBACVHK+Xnac=;
 b=DLxiDKySNfHjsCFIWmr3DCcPetu8GhnlJG/GnuEJ0oCjyWywPDNd9Sc8xtm4P8g0fUbgFgA0k771c6ZbzchVCeF2Tqeq36DHJsxMk14bXCQ0NUQJxLqumfHlaf4wjlgswe/wNCgkYOtjjmcpm0uhmumGjLTUrJWjQnwiWSQ0H+Wp60rOu0h8wKzutItwhpnV+z3A2k2dmoXokrfmWi/6Sut3U95lYsvauUHVah+ddAaVh6YD9+TQMxROG/XGyYxxAT/0ywBWAvfnzAfU68tHQUmrT3laR758aAaaUaJWYyH1aWwWm7nfXpQEyzmOkWZqETVpGb07dcf3c3FBbmDeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9lEUyI2ce59pgnBFyNejTBiSqw65WNwBACVHK+Xnac=;
 b=kjh7MvE2yCLY0dMVV6a+Go+D2MZlSAT5k9aEvh9U0eEZGs+b57qUHAlBJ/RwB8F3XzO9WvW/AzBC3F4wlPCq9Bp1KGvEVtvJNikfkcAiyU9WTQra+GBFySQwikQY9DDOPYkWu6mmfo8nu+iLdxeU2MR7vIHyKq04BNs6v9ju03BUkKAnQn6xamDXDAGDMEMjBF9RY9WmFOkw5wch/KnM7Mo/Fq7+mfJcNh7SnDAHRVxTjqvufIHT3pbQIvSKbEBoy7qm4CdUdLuCXj1yQm5IPhuzbbdRYO+bCaUPwo1gBMkzAz0oqQJIvfvNYqWxXSf+9bXVcigg3D+bdAiNRXzBAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Thu, 14 Sep 2023 02:45:35 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Thu, 14 Sep 2023
 02:45:35 +0000
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
Subject: Re: [PATCH v3 4/5] use nth_page() in place of direct struct page
 manipulation.
Date:   Wed, 13 Sep 2023 22:45:31 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <89146F73-0D9C-474B-96CA-24B085CA46C9@nvidia.com>
In-Reply-To: <20230913201248.452081-5-zi.yan@sent.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
 <20230913201248.452081-5-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D2740B76-B33B-4B36-8B8F-6040E8CF87A0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: YQBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::38)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6574e3a3-d87c-4aa3-c305-08dbb4ccabc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1L2gRa/Jy1kjKpdDtU/V8WGYsVRJKS3h0h6rfgGjWcVw2NbOYXmiRMHj7l/OAP1letJYWLT7mzaLCmqOoIP3cojMe/vgb8iRv8iawbinJ3ygSJteVcFUfX+zG/LmNf0pG0hqhbpX+OKzU8O9pDn9+eQY7CXsynV2LPt6YiCxQMlc3hQcZe8UuNuh7LiT6dGAtG22kKCbu5v2ChNFpGLDmap2aXpAqisfz0LwVgP7weuZPO2WFmULV6RAtzCd+C9FrQLOrpgNrvFf/z0MSiK3DcvISArC28Bbxhl8F1k/3sB/wxzzC2fCp8h+kb0Eq+sO63AUIKTChGYw8pYuqf/MzGjof9Em9ztgPFaXCCpBGkXiAQNOECmrREuOpSxweESjic6iyCewb4rNX/1T2mV+m66ELZxEH/YPKP0PwgvPGO0LpbKufkBFWuY2K8/JhBQ+7vgXHdfMlwknXJgzv/i6PkyCKYsSzn7sTrWrw6sFbgzWbCRl89SowZZBLcdO9tILe+Eww9ryooz9mXl0xo79bSDNf44B4rDShCgLdrIsta2GLhOfc/5cc6kaFm0hJ7DZ1A74P/DdQlowEPyCKHLPTjPSC6C07RjKu4XgBBg/6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199024)(186009)(1800799009)(66899024)(6666004)(6506007)(53546011)(8676002)(6486002)(36756003)(26005)(33656002)(38100700002)(86362001)(83380400001)(235185007)(2906002)(66556008)(6512007)(478600001)(66946007)(5660300002)(8936002)(4326008)(66476007)(316002)(2616005)(41300700001)(54906003)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fvg5M1UwNz6iURBR3OVTpZ6l4YQrR6YCbFvprfMdQPE5z640laiO+HkMxIrS?=
 =?us-ascii?Q?IkZ3Qg7Er80jX2OOKvSJ07MGdZgvqxk23FHYZqwrOXLgoI+kfV8mmUZQL5hz?=
 =?us-ascii?Q?ny146yKHva0Q8kiCHtXIydK4YGeRvdybSQuhV4Aujy3ycd+HvNemUcV3PL7o?=
 =?us-ascii?Q?jgQZMipRZ6/ZnPlfI/7FWi6hu7HdONaaXhJNmBItCyP59bGhN8+dToSF7edZ?=
 =?us-ascii?Q?r7hfuAyq5QqoIKUpu1oGQhBz5XmO8tzsPvnr9OOqJqwCD5qGNGo7T6cMQmxR?=
 =?us-ascii?Q?bcJ/ZMr289fV9q1M9blwc7QIUIC9Ra0xkQlOLtOKIhnjFLh+CbGaLLqByLLU?=
 =?us-ascii?Q?RZERbvshlb2K/bb31+bs75lxSc78/F0WpamYb13gxRrgML4bbx52vfglw9vp?=
 =?us-ascii?Q?f0y1KZ4VHkswjJ+vTAsYgoKvYlVdxo/fQsdUuMXGq/CbgQfUSF50rJyQsE97?=
 =?us-ascii?Q?VvPMaGwW0ia44eXGhWQ8ZzTx491NDxGP2DOWrXw643f1ZoLlZTD6X56FIoeD?=
 =?us-ascii?Q?hfb+Mj8F9Y6hIN+Mj0pd4rlVXQ+RVP4RNvBW1maJxCxsS5M15lJkgC6jAXf3?=
 =?us-ascii?Q?+G2aKqr5CkxOep/AqHYFbkzdJCsJhH+0B4RCLIo40ln6CpNoicdmVDDqdr+7?=
 =?us-ascii?Q?ElgAxsZs2aHmIFE5PcH1PULFg+pLeFSVUEf800nUQBnXfvHJMplqM7zIwWZ/?=
 =?us-ascii?Q?76Lqbb+E4JNCzydF+rmHqA58E9Ks+Nyp0wppwK9d3L9WDuO9LQWiXyufGYwc?=
 =?us-ascii?Q?e7ubsVpeep1td2e3Fkj6cbV+MsrPjs/vldhDn+xrhCSfhYy/961GPE+XWVeW?=
 =?us-ascii?Q?/B0t24UppYCY9vYT1AVM4kGgyRBQXt8PjS3GaJQBwG+o5DYi9430ugkVU7Nx?=
 =?us-ascii?Q?IY5oAxv6H9Z9vIR90btouMtmZ40IkHAXs/utlL44/jvKxYZkGxV97nrcFith?=
 =?us-ascii?Q?hyk6I/PaaraBOUEjDepGC+uhMlnxBfMJ6oo1/LeGmaHpJC1Ft2UeLITS3fcI?=
 =?us-ascii?Q?gCQoEUzpqHkFLcKRQdXvbi5Zxu3SRf9WdcWLUDkUjNEayOHZE7ntMI5Ezjgr?=
 =?us-ascii?Q?Uz4EEmoesvDUAjIonhGrxhsO+vJhaVpu/M/AXH9yP7q1n75z9caQNvLamuN/?=
 =?us-ascii?Q?LdHVJod0a+48rC3PlU4UMqN5wNjksL20T9LB2L0oJI64igNQWQiHfemHNL8H?=
 =?us-ascii?Q?FZIiTFcO0buRVeFRMr8vFSSFwT15CfNAS0ZQ696l7wO9GHu8ydi9XrhISUpI?=
 =?us-ascii?Q?+26vnLoyL4fHo5PSVsgjjwbQdCD1KcLqiPXWfFtVj3goObiLSHWCQ+C7hFjB?=
 =?us-ascii?Q?ls/+QFgfijj0OZ0cu3Cw0wigvtyhQ/dOHEiApK30PCkjm79tZlcGuYkKcwHN?=
 =?us-ascii?Q?J7VCHna1sW4AicMmpEB3QftsA3y8u49i7fKQmOUXtaB1VnBQWiN0W2eY7/iK?=
 =?us-ascii?Q?X53tH+ditfROsiUTKYv3UjmyDdKFeYq2KWlBGGaipWeFEfaeHEpiPnpetnPz?=
 =?us-ascii?Q?wI/rT32ScASR/J18sSQ19ap3/XSZJb2pNodHL6QsdkVdElx/5Qmu1Jww9X69?=
 =?us-ascii?Q?4r3HMK0yC/mKmYGj/sCXjarWveUHFRrvDfuTnttA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6574e3a3-d87c-4aa3-c305-08dbb4ccabc3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:45:35.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3DZG8/H2A4lRQLCnF2Md7WL1w6orSD5gxpoObs32w74Sk6ZzAsv6uvJRHIx8Wh1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D2740B76-B33B-4B36-8B8F-6040E8CF87A0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2023, at 16:12, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> When dealing with hugetlb pages, struct page is not guaranteed to be
> contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle it
> properly.
>
> Fixes: 38c1ddbde6c6 ("hugetlbfs: improve read HWPOISON hugepage")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  fs/hugetlbfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7083fa0caaab..14d3d28e41b0 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -295,7 +295,7 @@ static size_t adjust_range_hwpoison(struct page *pa=
ge, size_t offset, size_t byt
>  	size_t res =3D 0;
>
>  	/* First subpage to start the loop. */
> -	page +=3D offset / PAGE_SIZE;
> +	page =3D nth_page(page, offset / PAGE_SIZE);
>  	offset %=3D PAGE_SIZE;
>  	while (1) {
>  		if (is_raw_hwpoison_page_in_hugepage(page))
> @@ -309,7 +309,7 @@ static size_t adjust_range_hwpoison(struct page *pa=
ge, size_t offset, size_t byt
>  			break;
>  		offset +=3D n;
>  		if (offset =3D=3D PAGE_SIZE) {
> -			page++;
> +			page =3D nth_page(page, 1);
>  			offset =3D 0;
>  		}
>  	}
> -- =

> 2.40.1

Without the fix, a wrong subpage might be checked for HWPoison, causing w=
rong
number of bytes of a page copied to user space. No bug is reported. The f=
ix
comes from code inspection.

--
Best Regards,
Yan, Zi

--=_MailMate_D2740B76-B33B-4B36-8B8F-6040E8CF87A0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUCc8sPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUlzYP/iEUlKNBgw1pGQNs9IkwZRK4fy9+7IOGYtga
FWDfxNGRLWq340UpU15iE7b155YNQX62Bm9axKBOAPouaZ+ZnXruJThEdPsoPeDc
Ru36wfb1UsYY9h/p7S4WNk+R/OS6D5jwOKDoFzA1bdUw6dP7hwI66Nv5McvOnl9f
5qRR7WpniAcxd3kvFD2yAPbej1vBOlNp6CNsxqAn8mJFxdEOqJTdSABmIRhSxSR5
mzfcPasuzUhehPwMW3PMa5lt1t6OZuxrtFXtX2FDstn0WDFzvXON5Z35K+PlmihP
ezSNhCMyogFRmj/E5qK6kcxIVobAAxAyHjBlzkPH4rr29IGOF3D2dKe9YvjXOlhM
MCneJm3ytm8jD91oX1f33sGF3VOckoVXGZy8DHZHkvpMShj5/0cyGtVb9X44pJu2
xr0lWbg5KI9bQcHX245GZn1g0k0XGCiis0qX8gYniyh1x3qGUDM4jydV66eq3wEJ
6DMBgUrB//FRjZf5Z763/JU79IW1fL6muCTfVJm3oMFSkmz+FxESDInmguluqGpk
wlqRFyvw2iurDY+YekHN9Xmy0RSmkTtY5XP0/zZqliDR8F6GLE6VZcKZVJ5pi6FJ
W0kURFrrMnKvY5jM04fReG1T22D1Gvr0VZ4YOYlIXiwichs1kRyk+tYf2/l/5exQ
ymjtYrU+
=vFdC
-----END PGP SIGNATURE-----

--=_MailMate_D2740B76-B33B-4B36-8B8F-6040E8CF87A0_=--
