Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8979F7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjINCUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjINCUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:20:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01D4A8;
        Wed, 13 Sep 2023 19:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRrCVv/lVot/fYB/uZS2vXw63QypRqLW4Xg4xlyiKYy4rWKV6rTZceJPp7vdA+vtqTSe1gZn/5kKk7bKV5KKmr4VQywD6arXkB1HMGZxELY/tdW3EOLSr+TeiB8Jx3/Gh1d3y9KV3E/WUEminXbSUXzTz6stMTmto9dUDcrlQ4P5FqVVJ3l2DUS/vel/zwYgftTXnNHF3oRpDwC9wozcMKZQ0POkJTuOY+Q1oIZATAtD9ONugAXC+3xgACg3QMzmcvwGEZXG30WL05FVnw/AjjIneQxFQdhxaYc1+g1ZqbQWlxfZ9ByECOcvO0OM3YCrWOw9tzXboT7McEV57GHMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT8QbKFMSPvgstUsGChR3botBQLJ+XNyOw/popnID8Y=;
 b=UYkJL/0mg0XHtVzUTTxqRrr/LrTD/+j+751ghO5SgdNidos4bl6s2kCDLxk6u71c+G4Ffh5p2V7Di0YPzCdg+uQQxjoDFU+DfJbTa3Hj03qX5fgh7urvJGm6S4o2R+OWk0RCMLaA+YQXa0ELuhDsIHYg/bQH4tmjZDhfOALCwDpF0so4sIKwMewjF2D0D7N3MdIIJ+FOEv8LmS0cbwWsrZRjr2U1wn2tO2Q/EEemM47bxRXS0lBFhiJYLjMfIz1N60Pba+bPN85xYfZYrsbX8MWQMWU6adPEHljlGm/UlxbG4MP/yYczA/B5CUc2kfznsa5rUkgmmAyF0YqwAecAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT8QbKFMSPvgstUsGChR3botBQLJ+XNyOw/popnID8Y=;
 b=hVP892JCDJFeRVuFz/OkAHL9wIg62vEqexPJoiFYMk13YM/kzZ+Z60xpjnqyMDSYRm3MdkoxrH0YP4tyGk2iYFC6MIRxxb/RFHLCGvGo2DUYVuzgcMywPGQBxe2Qk+dSgLm9wgI2DobnzDDup7ttzLpA6qA8EmhczHUwYlq4wORsmkrhXam9XLGpYOTZPmXyoIhefcO/m/L3EXXsXlpwG2sOgL9l3jbi37eLwju2qEEppZ1qzTB+9wlk+klPrzjjYs8V8+JsZONdZksJDfPnI4nVxioaz2kWkMKyM9L4nW8r8aSW5W0+qC3JHio8VOveYz7d/Ec4kecavECDvNSOBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 02:20:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Thu, 14 Sep 2023
 02:20:36 +0000
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
Subject: Re: [PATCH v3 2/5] mm/hugetlb: use nth_page() in place of direct
 struct page manipulation.
Date:   Wed, 13 Sep 2023 22:20:31 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <E2276305-4E00-4573-B8FE-9E598457FD48@nvidia.com>
In-Reply-To: <20230913201248.452081-3-zi.yan@sent.com>
References: <20230913201248.452081-1-zi.yan@sent.com>
 <20230913201248.452081-3-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_74C351E6-48C1-42FF-9A9C-4ACD7EF1135C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: d53ea4d6-85c5-40b7-004f-08dbb4c92e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOHi9BUc9HvMH6pQSF/1sKvDGTaGB0qUtFxmu1PV10rvTE9V5W+UGGPwVsOXK037bNHSDMf3aWRMhC1WHhfQSFf3IbDIAmY3EAroRQCvpLWWSSe1PUQa3tCWVBrkMphY+fD04qwJEKRRifyFCPcRv5w/slKa1AStEzAnC2W9lLk2+04C+pO7dAVQNSpZsbgtOrdGOgeaAjXWGYNbRKtQ6FJL7WBX9QqZLUVVIpXofqWJg/QktXQ3XPsRiA0B+mKWGgliAL4mC6HKejENdICwaYTgm043UgYX9b4m8CAHcX6rvLRHZobtmL4LRvo6BQ4H87+xyN0PofyC5i9TeGKITWkYSNXQliUWgc34CCAHdQGE7+KePcyIrA1mPEKYroyfag4PyZVrPu0SHphv/vUIlQtXVpd4gQo+yzIfuhAlIS7A6iTD60wf/WJQFhhOpTvW+QTiUKephCrHx7lqroLw5W39KSqlE9cDNXhja6DqkcSrhXVLfkN1xokSM8PxA/ZAjPY9cl5zLwySoTIjZraEVb9FIc19akh1R3iZ3LulAyDTTZnEv0NPyF4bNnSfcp9cXvWdRYhNrEMlh7LYE2HFIfDxjwLfJwR80Zgye+5uto+sFm0UgBxc1tdMRhetv9Yz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(478600001)(6666004)(6486002)(66946007)(6506007)(26005)(66556008)(6512007)(2616005)(2906002)(54906003)(8676002)(8936002)(316002)(53546011)(41300700001)(4326008)(235185007)(86362001)(36756003)(33656002)(5660300002)(38100700002)(7416002)(83380400001)(66899024)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fya20NtotSRyjKEI61RGLA+q2U/D51K8DaqTfM/bxEKPbNDbBxoylNE1qUvA?=
 =?us-ascii?Q?9f9yBN/0UswZ0tii5sfvME4IHZEILgYSM29QbgGrEAjymqWarzTzj2DwI7gE?=
 =?us-ascii?Q?8fL5X9E9mmh/FY3DAxZ4/q2VXTqrZbT6xb37ZxeCuY6KsKLfTwG77Dl3+uB7?=
 =?us-ascii?Q?XCm/jbkGy/WwP530g+u27ZsF8x7ONj78vafn1iQf4tOsGG6NtARLMCE4GtW6?=
 =?us-ascii?Q?Ma0CkWC16NXFo/VaJTDzcZxRUx7rCcgnTKgNOwyOTnp8g9LEu1kLkIjHUFxw?=
 =?us-ascii?Q?V9pnHTxDGBvuztE9J/FhUrVqDHjzaZSBJ84wJ7owjXGKh0ZfrQoP0vqmIGCa?=
 =?us-ascii?Q?+iPzVyE3wfeZ0JJOt2tZ8FJAJ8M2KVYbJS8d77Pkm1j69PNjyS1prud0Lpof?=
 =?us-ascii?Q?+wFe835W/1dbeF8kKdeQzD2s2JO3Kb3pGRduUIrWsOQiol2W/454VZJtpqYR?=
 =?us-ascii?Q?lwpIxUQILblpeiRkLZFMpf8K5/4Cm8dhQdoTqH/nRKJ4cDuY36rQbDgcgJSK?=
 =?us-ascii?Q?6VElf8j6bXvMyCcBXLnNdj5J9XR55rlFWqnIOn/c0MUt3mv2QGb8L+ecRrZ2?=
 =?us-ascii?Q?WXivVGdXf5bwBkYbMXU3EdfbkMUVikmwFRLKPHmxJnbCiR5S/danOzAAp1fn?=
 =?us-ascii?Q?s1u0tJUq0YEXREwkuwxYq/NcGGgEYfjYsw30F2hmDhrjoE8YMnJo/lF0ck8X?=
 =?us-ascii?Q?oTXjNmHFrqd+fSumBfhdjFnBD8WKOJ0q/bya30fjWe0RX5HYUM4dRgXFsKkH?=
 =?us-ascii?Q?3f/EDMY8B2PcQSYEBbv9PFLk8pHADYPopygzCo68AIVa3exU96tdS+Lj9vAS?=
 =?us-ascii?Q?cVUXuALe0eWHfCLAxO28ztrtHmQ7KvPQeHnLmnyL7x1qdWDry2w36oyVsHgp?=
 =?us-ascii?Q?QvO85eFRfakIhxqqMGMyJ7e+cq9kOgqKu4SxIc0nlDNPbkAmvhSKDbVnC6ra?=
 =?us-ascii?Q?pHpG24F85vk4HXjF75jW1DtNvm39n3SiNp9iAz4PQO5O+sWixV0AEWGB/5lT?=
 =?us-ascii?Q?0zllHdqcRpbukJ/QI35FpAsZh4W8zAF1ifoRGPpuUl4KY1/W3sJeVP3ADVKC?=
 =?us-ascii?Q?WZ2cdkZh/TGqXFk+Ezj2FyeXfs+ZC4Yjq0QTx61/s8Rc97OPmIpd8wcr/54M?=
 =?us-ascii?Q?dZlKkUlKMski2LOIZS7J0rp1LMe0C8/mvtf1kaKgG11cG/6XLmjWKqqpJanr?=
 =?us-ascii?Q?In00vcFkR/OFAkRdjwpgXba5o1XMcTNxUybZVT+qGZ/qKJ8qslYyt9LI8P0t?=
 =?us-ascii?Q?NabszSe5Ude4QNn8rO9O1CSCD+jnDPtlmDq7B0OYc1a1FPGQQYSpNoUENv0W?=
 =?us-ascii?Q?3sjj7NHgqRrnVW24UY8rS/xrphInpYdZqpIxuwczuWR/kMlAm8273yrOwfDE?=
 =?us-ascii?Q?y/NAPqr2rPF+zHE8X3aLi3c7I09mZTFBdksK+aQIg/cdQuUoIYPrsUAJRYlS?=
 =?us-ascii?Q?bazD5suVyCf0fTyLibus636mEqvmIsPfl/1n7z9exoHdsUTlANTeFNBt/i0J?=
 =?us-ascii?Q?JFC4aLD1L8M/XWbxTvRX911PrflU8nCGSNp0r+DLf4OqfGCXNHC5E5/QQYK5?=
 =?us-ascii?Q?sxGN8N4Q9pC6xzTftrkS7YNJNMqLiNV9RNh/nsuX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53ea4d6-85c5-40b7-004f-08dbb4c92e81
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:20:36.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsNmGDk5LSy771iOfPR+k8ZYJQIdPnc0Hp8++wvyNNzTT7g18+WC4sa85ZLnhvuR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_74C351E6-48C1-42FF-9A9C-4ACD7EF1135C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2023, at 16:12, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> When dealing with hugetlb pages, manipulating struct page pointers
> directly can get to wrong struct page, since struct page is not guarant=
eed
> to be contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle=

> it properly.
>
> Fixes: 57a196a58421 ("hugetlb: simplify hugetlb handling in follow_page=
_mask")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index af74e83d92aa..8e68e6c53e66 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6469,7 +6469,7 @@ struct page *hugetlb_follow_page_mask(struct vm_a=
rea_struct *vma,
>  			}
>  		}
>
> -		page +=3D ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
> +		page =3D nth_page(page, ((address & ~huge_page_mask(h)) >> PAGE_SHIF=
T));
>
>  		/*
>  		 * Note that page may be a sub-page, and with vmemmap
> -- =

> 2.40.1

A wrong or non-existing page might be tried to be grabbed, either leading=
 to
a non freeable page or kernel memory access errors. No bug is reported.
It comes from code inspection.


--
Best Regards,
Yan, Zi

--=_MailMate_74C351E6-48C1-42FF-9A9C-4ACD7EF1135C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUCbe8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUW50P/0q0HmZLnLMGBOXlPnpTJwjbaMv+1xcVjt+P
bemMuWmxqORchNyBXRed0jzkaDe/f/IFRt5Ft6BPV3iBH1/Km1c26xhhHI+RNvBu
2T5Yy598b8SZgB+LqCk4htj7GVjA9PSpolkEKHqKjcIRHn11EQDLpo+pAy1CvDPf
lFRwNqBcIlWcd2pBGWuzZSghPRziY5l6qJOFk6QSC+tL22va3zx/YxWZtKNWWxuU
3zosiUMnlPtcCv9NCgjiOXsiEzz6STdwjCx+Ihp5p7+WT52ypI2i/s4tcXOzs9JW
MVkfKeaniodnEIuZTsykMYuLqvsubi74eKOrO1NP0VwHCXrcsQiKfDlGmgAfqECL
MzUx32wQtF2BiS5yL0qrMf7/W8eOWwWT4Pm2JwGUcmfCeRU153D9mGpIW6CtgzQE
7KzRhFqGM/VNnqGFjFrZnbaM3NyqzKI2p5QuXQ4EaV1mJFvDPOGG5UfgmkCA/VON
B3b3El/nycroPSJKXvtLc7nyE5oKReBzkuwKgxm6Y7TTBH6tH+nR9dy6WuzZTiOv
m66Xvl+xqf1M2CrzAD9Vzdsn3cpqlXiNPN+MfZQCnghDcElHgqlhyCkAX1eFynTv
wKynwlIfS0bi+7XRNBWbW+/VA4hHURRn+CY2HkFVEQrbW7wQPp07r4Wu77BlNdl3
6RNqr8fr
=I0h5
-----END PGP SIGNATURE-----

--=_MailMate_74C351E6-48C1-42FF-9A9C-4ACD7EF1135C_=--
