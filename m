Return-Path: <linux-kernel+bounces-128883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD3F896172
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52183289F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADE3DDDA;
	Wed,  3 Apr 2024 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tE5V/xUV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9294C8B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104235; cv=fail; b=nkuqfHdmUpp2DvPfwQ7Wl4Cr3tO+SVsvEwgI/ueJhka0DpquhMNdh/TnLpHScSu/ecBEtzXeSheZflAgmtSxKNeOIjew5HhNLPRw6sroozXtwnkesRdeUnfQPxadRAPFldf7KHxkhPdr9G3ndlE9NxX0nSMC62PVZGkY7cUkVTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104235; c=relaxed/simple;
	bh=XiQqt/+kaDY7zotUpQuQ3ghPCvOR+Jc265NjA6FVDaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AchSGZsPM4pTYdKIypWOBMKHxU1AAK5TKWjzKzT3+HtyJS/veo//4/FEXH/WHYMtF17RfwOf/BcHt+CTxuVXPMhbjfGuhd8uMaYZWTZ4v2ychua/7VlSGUVq6dF1wYr1imXnrrEz7zJJzhm1uE4mvB78Xa0+8RzvBVs6ctK4mKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tE5V/xUV; arc=fail smtp.client-ip=40.107.237.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXwwp9zkRJA0gRSuvurJ/bZtud6K6gSR7/51EQQ7rwRgpW2e8FKx25Zwyiih5eiLGvKZUsaWwCV1pQzpM5Yq1/aGKjuJ/NY3qlyhoD2B6fRM6TxbvWgj+aZIzwPWb/YVLhSUdQjt+h9K4KJmpuVBlRYV8LhoptBjCbjUYh9TliQJbt82uz6t2HzIbHEH//kidFUsjQkxbfljlq0UfEXxb0H8IwEsPmFKixzO0UbXQBUGQmCVHkJTUBU7kBoykuAStyiyeOxzlnx8LEQglg97FsAxPUSjlrq7h4BPG4jztAMcKZGBGgYl+TNY/6l9W4UoXYevDdlEmWr5nyivHHvmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq8imWwJkc6VG/ZG2d4cfZLq5zUWA0G35lkcQA3XUB4=;
 b=JaVGxQWEseHgj5KV99wO0jJE86QSfq7248azBjxAjtw8QmnnH5TjheLRZ+/eBWMYZ0BW+inPBRuIEmCRiLq6kwVSQudJ0TXYYWPr32u3WcXS9vj63C1UpL7PQLGBf8P40gzFKZ2kPXETht2wMOOEwAtunA5b/teOvfO3zgeTG+HWFlpXyTQ/WhxB/UNrcIKbKBfKO9BxR0STyCOsxQBOE/mB+ON20oPRyTQG29oTmSMa7r66naybYdQ4GcHr6mElsS3a8kUxKbmklX1l73PWmQev22kXXwk0b4XKsHjdTjrSOXM471/daLL8QR+rLDfAP4drle921FykCSgu9sP7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq8imWwJkc6VG/ZG2d4cfZLq5zUWA0G35lkcQA3XUB4=;
 b=tE5V/xUVksNZTre6Ngbv3ygmJng5tk6czI+WnCSloJyKHWamz2fXQ5e0s7S3u8OjsGUNM+QXw+vmTAVQo0p4po+1P1k05Mfz0Bn9usb6HFRJszK3mKxHqSTB0DYHPsc+AsFUbXPOs0em1Bkd8MQqwssRLpkKssDd+gXbSstMF7ZLh1H8pVZV8bwUDz74D7m46Q5FvPXtCe/95XF8yXtitRZ7wUiI9GLeat4swVp6WPpbpgWva2J+THR7mWUiAEQvjr/qGqwR5+akzC+0KGNhHq3ER84BNbKOlku5wgBbvT8ie0w0lw0R+zwBw5AXBvCG0+sAS/hoL0d1hZKBIP6yGQ==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 00:30:30 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 00:30:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
Date: Tue, 02 Apr 2024 20:30:27 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <B0E526FD-64CF-4653-B624-1AFA5B7AA245@nvidia.com>
In-Reply-To: <20240327144537.4165578-3-ryan.roberts@arm.com>
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-3-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_BBAE7ACF-5C80-4C8D-A59B-B7CDCAE2254A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:208:234::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB8614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+/LZhzmGjzVhZIdIbFnEjzg7ZecGkhmiIHm6jGI+lupXoKmJ8TjOJ6O6aauiJFWZXiKZK1Bs+IeXxlApmIsS56MShXqu6ZNU916gxjHVz0GH0MycmDDI7TLAfcL/yoUh9JeGs974mU7mO9/8gg4pvQrd+xr0ioC+gb0ksDsFwaniXGWgrfz9XGadvwPiuNoKCNdAldJzx6uK8YCFfCNqNHXfvUAgHmWRqOoViDW/uD1PJFus4xClHxJ+MRpXgzRjQ/AapB1wRb6LrDYf4q+y7hbBai5Uz4j68Ccl13ocVOeFqH1bPYNhv/IBY8RekJkoRMZOlP5NYZPV8zq8SjCgFNG/20PwQ59nzJR0VHNnETKv+qWB810LWzGvjsHXDINfqpKF67wat5PNP+nJNiwYFmE0ihH2VT3Ay91yxtGTblw2/HpvGVauCMZOo+ZHRaAwF9CuDaW4YLVcMHdKOH5J1y+C7Fhuw4uR75ZmjQSTYrrqvM3fj3XUxkGHbXGdWtAVwLQeJPZYZJv+/kkNJJrij9iZRmJOQ5AUE0nmi3H0oawaw3O1UMp4ME7KIORAJbHASNEww+lEuTK03qtKC0+234xDz/0H1QqvR07i0vDMyGcJEzUFHgxveXciOG9ck8RWcAJUriwq06ObXVKjL5SBWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YuZeBZnvy++t8aM4MHTr8jeFsSlRHH+u7Vr/44T1/cvurM4acBAZ1lSfbGrp?=
 =?us-ascii?Q?eLLnNXeOo3PzJd990/d9NXXHltDYajy9b/7xd16AyFvv2NnN7oo2/z/DBIGv?=
 =?us-ascii?Q?zy4yEAtBsbeVNZPhu9iX8ma0/WRsATS7AEnMqbW3UHCYDvzjMN5slm3uUnxj?=
 =?us-ascii?Q?6U/FTPgeK+DLz+Pi3usSeSfONw4fCsZ8X+EPiNnETe1uaXSzWSiTyx00k1YS?=
 =?us-ascii?Q?mcZKeB17WbXKmTB2x6fGc96YQKrecnadMeo1/2sEjVUXFgm/mwkAmFz53N6N?=
 =?us-ascii?Q?GwnLQ1olsZl8AjKmaYx48hf7Y/talT5WTut69Q5OElgqPaHHRmT/vvCFQnF8?=
 =?us-ascii?Q?DW6ngKcStnRsqdmtEr5c/sMntBRIDpmZKOS6A8mLKIq/SvbgaaowA0DReqS5?=
 =?us-ascii?Q?HIFlfiVN3vPlr/biVZ6SfZXwOyTs6fsm94DoRUNevqbU11K+kMmBXLmiSDVI?=
 =?us-ascii?Q?QrX11gZx7VF14sn0Fav6x6isxMWXCtEGi2wWYJMBzrHl0WRHdJb95ABBvOZ+?=
 =?us-ascii?Q?OHT70gnyKYAT0f6ZEkHIOBykaYa4He9GhlaaV+vK8/36EpTkEKLYbXxcoL/s?=
 =?us-ascii?Q?cMpM/mZGhrezPkovwTKelfdxl0buoaFFRHP6OY0MUgM2t1lxAgH/Uul7hCLC?=
 =?us-ascii?Q?XUAxQMatxdYyFwigiOFkfr2S122nE8fCpyNsSViI81TN6MVeoqwhAzKFfGgr?=
 =?us-ascii?Q?XnzwrmKZxLqnw2D5qbwG4/Z0lYZQZFtD78ITMe1dD85CxffZXOlNUhxdFd8l?=
 =?us-ascii?Q?jTxVs3mKG2+Pjv4uMB0pSTnSB+E186r7qrSUkTu+QERbjjmwCeyflDaUr28C?=
 =?us-ascii?Q?/+ljtt5C8RYJiIVaJ1v6dhmr8ZCzum0wfbAqeE5yTW+3zH100EZVwDfTHaj8?=
 =?us-ascii?Q?QBqpDxv1i1zs7P7R3F3JbrxQIFKOCa6lEGAc6KezbsSVG6lBZd2xOENqIzFY?=
 =?us-ascii?Q?NjQPJB3TwMwPTE/Njvg/2O38n1OlLKSX0NK6/P3V13RqpwnfVj2CNwZujOjq?=
 =?us-ascii?Q?f7JoP6fdg+vhc6SrlZ0erkhTLKGiPrS6sJVz2xP6ssKy1Rr3bWI8Xylzysb4?=
 =?us-ascii?Q?KSdEeC/XV7xNu/gKQSN1pSQm2dc2/Wmm7zqbRWP+pI4YwCcdDxLlw67Sm2Hq?=
 =?us-ascii?Q?dJO2K66ABDZo9tdG1eiEkHl0ZcY+JRr1GqJ7fvG4NH8e+CJa9V37IJD2hon5?=
 =?us-ascii?Q?GpCyUMftOOC2yZKlohX7z/oetGqmbBfI9exujGjB9lrJW6KelMJDtsUqjmPQ?=
 =?us-ascii?Q?njYNwwupupl8nScB97NVIaCBZGDXXEtsN5rOiacsZ7atqxnIByVZGNkZuA7s?=
 =?us-ascii?Q?i/fGp3vucEzrYfnVzLO+VStzWg50q67iVIL44y1bt5kSdYXzzLupc1Xf+6Pk?=
 =?us-ascii?Q?ykeOtMwu8wn44NuWpT2JU7HwNsQK4jEBYoqO0rFq1IMbzRImMpn5gIqCm0nd?=
 =?us-ascii?Q?BYAsTQwl8SjfCnouiOZAVgrjv8dbEuBikJdirsaYT0hmpK9MbNsym/WRllpQ?=
 =?us-ascii?Q?ghlYOdCgj5WSoLAq779rgoHmzKtkM1Z6ER5zDe6M16NYsGGV2DZ+STSSuL2J?=
 =?us-ascii?Q?rfztn+2Uau4Nj/cm+wM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8837c8fe-69d4-4809-8991-08dc5375440e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 00:30:29.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1wgA9u6QPhoiwB+nUqOp77mJEMAK5UAbc3Gggb/R25WwjcE3OosVqiMc56gtn5T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614

--=_MailMate_BBAE7ACF-5C80-4C8D-A59B-B7CDCAE2254A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Mar 2024, at 10:45, Ryan Roberts wrote:

> Now that we no longer have a convenient flag in the cluster to determin=
e
> if a folio is large, free_swap_and_cache() will take a reference and
> lock a large folio much more often, which could lead to contention and
> (e.g.) failure to split large folios, etc.
>
> Let's solve that problem by batch freeing swap and cache with a new
> function, free_swap_and_cache_nr(), to free a contiguous range of swap
> entries together. This allows us to first drop a reference to each swap=

> slot before we try to release the cache folio. This means we only try t=
o
> release the folio once, only taking the reference and lock once - much
> better than the previous 512 times for the 2M THP case.
>
> Contiguous swap entries are gathered in zap_pte_range() and
> madvise_free_pte_range() in a similar way to how present ptes are
> already gathered in zap_pte_range().
>
> While we are at it, let's simplify by converting the return type of bot=
h
> functions to void. The return value was used only by zap_pte_range() to=

> print a bad pte, and was ignored by everyone else, so the extra
> reporting wasn't exactly guaranteed. We will still get the warning with=

> most of the information from get_swap_device(). With the batch version,=

> we wouldn't know which pte was bad anyway so could print the wrong one.=

>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h | 28 +++++++++++++++
>  include/linux/swap.h    | 12 +++++--
>  mm/internal.h           | 48 +++++++++++++++++++++++++
>  mm/madvise.c            | 12 ++++---
>  mm/memory.c             | 13 +++----
>  mm/swapfile.c           | 78 ++++++++++++++++++++++++++++++-----------=

>  6 files changed, 157 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 09c85c7bf9c2..8185939df1e8 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -708,6 +708,34 @@ static inline void pte_clear_not_present_full(stru=
ct mm_struct *mm,
>  }
>  #endif
>
> +#ifndef clear_not_present_full_ptes
> +/**
> + * clear_not_present_full_ptes - Clear consecutive not present PTEs.
> + * @mm: Address space the ptes represent.
> + * @addr: Address of the first pte.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + * @full: Whether we are clearing a full mm.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a =
simple
> + * loop over pte_clear_not_present_full().
> + *
> + * Context: The caller holds the page table lock.  The PTEs are all no=
t present.
> + * The PTEs are all in the same PMD.
> + */
> +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> +{
> +	for (;;) {
> +		pte_clear_not_present_full(mm, addr, ptep, full);
> +		if (--nr =3D=3D 0)
> +			break;
> +		ptep++;
> +		addr +=3D PAGE_SIZE;
> +	}
> +}
> +#endif
> +

Would the code below be better?

for (i =3D 0; i < nr; i++, ptep++, addr +=3D PAGE_SIZE)
	pte_clear_not_present_full(mm, addr, ptep, full);

--
Best Regards,
Yan, Zi

--=_MailMate_BBAE7ACF-5C80-4C8D-A59B-B7CDCAE2254A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYMoyMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUeSEP/i690bSUUVVRPvewpwQ771NH0CRmcNBSVOUF
3pMiXVweKtglsMohVmeTlOhzIEP5ZKI5HbBglxq81Jye1IO7T6iFCh9MhmypvNje
ZbdRStfJMGN2frUiJz3A9a3Tc7gyVymY8Q4Nmt7avAAno/0FQjvJoavtWPVF9e4H
CH4WxbU7zhvcCoNAJw5eIJqzrK7AQF1UsXcTg0dUxLpTA5kulufWyyVqNT2Yu6vz
n0HIBqUgVLxxVtz5ogyW5nbfw/9pG0CBRayhl7eqWLpEDSlTo/uCfnY4vlyYZH+0
+IRPHxZHdek9TBDn3gbMJ2FsNcHkeqXBl5y5REBgHMqp7+NObKnJWXHO5bSDoqPQ
MPjTDIeptdMxRU4hzfnHufRoAY2HssdNqhQ9oqZMeItjym/XDym8dlqwA7E7k/E/
DQyvQQIkwlUxL6UoX359vxW6fCsianFrChz+ivAymOy27WkWTsPKqjiRhN6VeOb4
r11EWQZlYhi8yW4TdaKtqdrwVN1JNMfAsFfvzJZmR2KsmaIr1Q0XLaHfNu9UBfb5
rdnVWKfG2kHTkCMCuNKEq3Rym7OGQoeJcGLD+Fr5pWsb6GSf0Lkvey7cS2RoblyL
Jf6XKdYcMVQcIF6kVPH02DQOU4LrCQB0H6LaXaG/P9NLYyTBCMdmh+pdIEe7l58H
3dYaTzKJ
=dZbE
-----END PGP SIGNATURE-----

--=_MailMate_BBAE7ACF-5C80-4C8D-A59B-B7CDCAE2254A_=--

