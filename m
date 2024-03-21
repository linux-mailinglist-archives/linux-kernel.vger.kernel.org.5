Return-Path: <linux-kernel+bounces-110194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE0885B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C864B1C21B35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8800486246;
	Thu, 21 Mar 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GiCoy3WU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84686134
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033448; cv=fail; b=t97qYBiNZXxftU7jHnpBHaUfzd7OJ1T9iCbcI4Y5He+gj+Q8PqxWWfVPhw8tXN4m0H3hmiJOP7kvsHpK30JYBe+rcYhShvIDqnhJe7NYoo2LgwF/rlJppk7cIDSALDm77wW7WzjrkYspLbiSFU28Tou/RkNcTVmqvJ6wqJhxpok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033448; c=relaxed/simple;
	bh=17/NNdRarRwtrXlmo9kIDthtApG3yiOHYcds+zEI7UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCli186IvjNjU/ctobrS9hsBmfbRsCqFKrOKAkxBiNlDOtCHw8QoFVLk9ad6jBtKploXK5t0kxyhmNKxnZyvcMaE3mfXxUa1W8x/OJXmXHd/k6iRp+3mrBC1IjQ/6ib0fi9RJuSuCo6DQXxD660NaFSB57QVlw+cJKA7UzB2VE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GiCoy3WU; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0YTc5y+65v1FCjzrJCnki2Dy3ZTNuacJd+dibOZ+LTZCZdHvP/+S40EM7xemRplZ2ySEwFi+0cERvF8uzD8LM9NMKG3O+1834qqcFYlGlTzKCJ79mpjUBj6+hdSphONVBZtwM4G381PNILOef6B68qhp5CYexPAGctE1TTDCXZ9WSIn5BVmEtLMjGsDJ6HgqoLQHcF6AUNnlD2SMq85ILbXwEqisIl0Cs/LwxO1pTKmtV6eoLPOJV72foCGrbk9Upy/58d84KbeN/rahfJOB8chI+P3Hm5zjlhhJ9oWcZMuHFKRZy+QeDx/YoFN9SP09uc4wd7w8uM8+wmysPyLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLVEXZ1Qwgspmb5Eeay8qRhig9wvLWVCOiLPwnI0FoU=;
 b=Ylyb9fGLiqv0IVIuaQOSA/Xrh2pf3OTMZ8R4yAlGDny71h07KanAVvRZ/C4uVo4o4AOzTguFU1Lsa68r0NBRWTlzz8zZS+H39Q0CcuXQaHC1cPNEuILBtTSGYl5XeDEhthOVw8WtEjpJoxsCBuixSwHFXC+2IYlMFSolq770ZqAzHOvaQ1jQe2KqeJ1cOR6aUjpu1CCt3RqGRheMZwtCrNEpfMEtzXW+1newn8ycwvUeoJYJWCoMi/jASbf8olGFNNur1bVniaCl+wcj+NRUG9ab0LNJ3kRRz1ee6z4Ddb9v42u50HoAlJso6Qhz09h1ZEwYL/OeSZuPp58rXk61/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLVEXZ1Qwgspmb5Eeay8qRhig9wvLWVCOiLPwnI0FoU=;
 b=GiCoy3WUzg5PlkMKhwhQkx3T5nuYXYXzP9MTyxub5uSpzTYR+KZSNyNo5RLIBRBUF9mzLKwH8rVvfBu2Ymvl/3pM84S+Z54utNenn9RJ+fMdi3a8DPhatxz1M80JHyo8ceRGCgbS3QvE1eufNE9LFeiaFlAYuGt5HIR68b/rlfoxNHLTvImUl44xs+FLTS2ss5j3dMnuVoxfIZ7CeM2RTvVcJbDqwhDi8Fcl4zjGdHlwdRMfnU9Vr7+dca6jy4kFsLNr1xR/OKUyMO7y+WeF5XfWPinB0PQ5E8pdtyYu+15d5/X5Wovy2tui18mD/p/Oyvl+zmr2IpDdvTnQuUBr7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 15:04:01 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 15:04:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] mm: page_isolation: prepare for hygienic freelists
Date: Thu, 21 Mar 2024 11:03:58 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <419F2502-507B-4228-860B-217EE74C45B6@nvidia.com>
In-Reply-To: <20240321142426.GB777580@cmpxchg.org>
References: <20240320180429.678181-10-hannes@cmpxchg.org>
 <202403212118.ye7lcKjD-lkp@intel.com> <20240321142426.GB777580@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_BE5DCAED-0F87-4ACF-A8B5-DB176F96BC63_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: a356a583-060b-4b9a-c39d-08dc49b82401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7al0dhwcM9FbB4MnYcXutQv4GkKXVNL94l2CWvRwL6iHHvlGkJYoSgdbfOH05HLOfMzOpZhBevx4YqhXLepaoSGSG/smFjz320e3wjKUrt65MEvz21vfyOtozGnoSfYwYY/B97ckszTUkGHI2O10/q+Ssj8vo4skcFbY+35ACjdeZ6+bjM1xWOuzDJX8HrVIYCa6xcouzS/CqlannenAKDG5rjDVS3oGpEvx0Kx1SGwMS58Nje6xc4dfdECsYFDhBeJ57SYy2FjCbZFLW+sJbqO9dty6CxEW4z67fJBn/v2pDkL3Rpaijb1/PJ67BfaIMZYt7Zf6GJ6XlT2Ll0cxjlhf0g2AVI4bZxvq1mXX1Bsy+p0ZnuoWR4VgneKpEGa3yZmdNgJzRTKRLKy0+hhH0niDxnp15/GDMXigY5zha8Xg+aVggWKf2WiWoTsCw2ujq+n+ubq0866m++GbnJ1Z7YpdOjdfIBcihGmtH1N6+h/r4W5SXja2+xwecx2xvNR9sSeEtnuGZkSeVKMMOD2BmpwqdKE87UG5AZ3p+v4XkdsBMBktH8wStytnSA2/w7A/xLsfFblsvSx0w2pIp8+lGllw0W1V+Vvk3KZ0p33t//gpeIvhwM0eCsSVKQ6iVHPqnm3GIjmJFZ7QnZ9vBf7bXnJGPbRdPt6QrZH7qYJq2ZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVPFlNBifzwDE7NvyEnr/MmVFhkab9sp4ygXwte7p+h1DYZdbUkbJ2nCE+Rb?=
 =?us-ascii?Q?DzpmCjACcP0mpKtc5GrOsJdf4fYSk0LgaXl49M+rG3cz/i8qrY6dFKfJr7CD?=
 =?us-ascii?Q?+HwdXqQnTXKVDsP0+s4e6PfGRMV2/NtyEWikZRvMBOd5+QdDVyRaya3fwJ47?=
 =?us-ascii?Q?S2RUDDZpHFLYv+mdrtY15DV6YZ8Bu1BifuebgUsgOaTR+zgzzuDAPSCvbJB3?=
 =?us-ascii?Q?TgFcTGO7uG/iDiKwCZzJrnBN8cFZ9Zu8GIowkGUKrfWHH95CG1SPNfYuHrqT?=
 =?us-ascii?Q?s8D84/iZ5vqZVFb8vB9viRArA+Lb6BUYIcBg9aFaeIOrm83guJlSZ07/WVbX?=
 =?us-ascii?Q?11/yOxQKN91YyzgHM3URxTs3bdXwEV01P3Oh9pWSniYhCy9QzXVP1muo/Ttt?=
 =?us-ascii?Q?qjpu0dpimYwGNMYxRXmORQkYKbkml+adb0W9P0qgvh/44KejI3w395/9aJuH?=
 =?us-ascii?Q?vIJPpWFW/MBj4h3mjxFOMvci4NAGKyhIkisi9etlaP9Nk3XCXdgsdJ4RgpS7?=
 =?us-ascii?Q?UB4N0wuWqPKgYMZmgtp8fXBb24I9umvy0CRgY0mTrQd8iB4KWMcZJuKOxyu3?=
 =?us-ascii?Q?FIGgMVLjx7RaeT+xxt3bzdTRnmyym+HhfGT9CZSoX2u4IbDywQmHvxEnEgAm?=
 =?us-ascii?Q?vxuNYykv1wO66npDE5Vv8Iw8yGc2qJiQnEXN7aFUPh0xlePzr9vAdCz942OF?=
 =?us-ascii?Q?2B2yo2F/OgdA/KYdn+DsVoMQF2xzVQlhWRvuyyB2p7rFh+IwDj7MWrCfv4Ky?=
 =?us-ascii?Q?p9mD4Y88fjsBY/JZy9d+0bdUzRUXN4fSzcawoqa2yPwF+k5vrqf/U4udAFIR?=
 =?us-ascii?Q?YIwY/PMtGwyIJ1kw5DsxC3654aSpcDtRKBoLtjtkk59b8GyckCaYJPL+SWrF?=
 =?us-ascii?Q?l/TVXP8Nv40tpXgAl2G+Y6FOn2Y+WtGH2gMJ8RJdCPkjcqr0RjQLsQyXIFqK?=
 =?us-ascii?Q?tyVFmqsBCkvIdf2XUstEecZXaoZ84LaoZFl8ng1c5VMOwrnv5YC3eUMtXD8R?=
 =?us-ascii?Q?HVxbO14f9bN9Vz7whrIEP8T91HABgF/EE1XkMrJvhGu/MwgbAepdi8BXLsFe?=
 =?us-ascii?Q?axdzY3pUKGl29GmpqHQ1YMvhuJCvs73R9IwjlcpT9bPx6je1hu5kmupAuooS?=
 =?us-ascii?Q?5YnZUvZAPVTlvgQZ5jswbzwxqikidpvp6w2exA3tvvE7Dr4ryR7psn7yI8aa?=
 =?us-ascii?Q?vbyH6BRvV6YF+1I1oWOwSzPKTHitVTq5sn5TOIkAUPRgZ22LlK2LdJdAFlqc?=
 =?us-ascii?Q?RGq3XtuAqLRCRhAQRNr+SD760avL+OB8WQvN427s8yv0Yle0C7eYFQRVNBMm?=
 =?us-ascii?Q?A9kM5/GhlKN+r0MfFaU8N9qXu4M/PqpOuuXklzCDYSZMwhlUlcZRepehbSQa?=
 =?us-ascii?Q?tSxnqoQkUMmNZHIFjqtEBbb2u0AaCxN+BdJD/hd+MYSUnBkrq6Fw4PaQrR2t?=
 =?us-ascii?Q?UzbBr/gp1pOxKj5i5TbSaM5kTXHJQSd4bAWeQbg8sJd+y45ZmZO9eQzlakxx?=
 =?us-ascii?Q?SbJpbUbmMTHwVrVq+C5jlD5+K05JdvgKfRG1T4emcOWEt3MU2IpeM8SCXhoJ?=
 =?us-ascii?Q?MqYxVpLG3F0PMVqWbPw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a356a583-060b-4b9a-c39d-08dc49b82401
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 15:04:00.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB1ml7qxvlTQtjgG6mvkJc1qYAb9xe6rFaQDc37OGYmurDQh9oJxMgHj662qjSp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

--=_MailMate_BE5DCAED-0F87-4ACF-A8B5-DB176F96BC63_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Mar 2024, at 10:24, Johannes Weiner wrote:

> On Thu, Mar 21, 2024 at 09:13:57PM +0800, kernel test robot wrote:
>> Hi Johannes,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on akpm-mm/mm-everything]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Weiner=
/mm-page_alloc-remove-pcppage-migratetype-caching/20240321-020814
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm=
-everything
>> patch link:    https://lore.kernel.org/r/20240320180429.678181-10-hann=
es%40cmpxchg.org
>> patch subject: [PATCH 09/10] mm: page_isolation: prepare for hygienic =
freelists
>> config: i386-randconfig-003-20240321 (https://download.01.org/0day-ci/=
archive/20240321/202403212118.ye7lcKjD-lkp@intel.com/config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/ar=
chive/20240321/202403212118.ye7lcKjD-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202403212118.ye7lcKjD-=
lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>    mm/page_alloc.c: In function 'move_freepages_block_isolate':
>>>> mm/page_alloc.c:688:17: warning: array subscript 11 is above array b=
ounds of 'struct free_area[11]' [-Warray-bounds]
>>      688 |  zone->free_area[order].nr_free--;
>>          |  ~~~~~~~~~~~~~~~^~~~~~~
>>>> mm/page_alloc.c:688:17: warning: array subscript 11 is above array b=
ounds of 'struct free_area[11]' [-Warray-bounds]
>
> I think this is a bug in the old gcc.
>
> We have this in move_freepages_block_isolate():
>
> 	/* We're the starting block of a larger buddy */
> 	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
> 		int mt =3D get_pfnblock_migratetype(page, pfn);
> 		int order =3D buddy_order(page);
>
> 		if (!is_migrate_isolate(mt))
> 			__mod_zone_freepage_state(zone, -(1UL << order), mt);
> 		del_page_from_free_list(page, zone, order);
>
> And this config doesn't have hugetlb enabled, so:
>
> /* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
> #define pageblock_order         MAX_PAGE_ORDER
>
> If buddies were indeed >MAX_PAGE_ORDER, this would be an out-of-bounds
> access when delete updates the freelist count. Of course, buddies per
> definition cannot be larger than MAX_PAGE_ORDER. But the older gcc
> doesn't seem to realize this branch in this configuration is dead.
>
> Maybe we can help it out and make the impossible scenario a bit more
> explicit? Does this fixlet silence the warning?
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index efb2581ac142..4cdc356e73f6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1698,6 +1698,10 @@ bool move_freepages_block_isolate(struct zone *z=
one, struct page *page,
>  				       NULL, NULL))
>  		return false;
>
> +	/* No splits needed if buddies can't span multiple blocks */
> +	if (pageblock_order =3D=3D MAX_PAGE_ORDER)
> +		goto move;
> +
>  	/* We're a tail block in a larger buddy */
>  	pfn =3D find_large_buddy(start_pfn);
>  	if (pfn !=3D start_pfn) {
> @@ -1725,7 +1729,7 @@ bool move_freepages_block_isolate(struct zone *zo=
ne, struct page *page,
>  		split_large_buddy(zone, page, pfn, order);
>  		return true;
>  	}
> -
> +move:
>  	mt =3D get_pfnblock_migratetype(page, start_pfn);
>  	nr_moved =3D move_freepages(zone, start_pfn, end_pfn, migratetype);
>  	if (!is_migrate_isolate(mt))
>
> Zi Yan, does this look sane to you as well?
Yes. This and patch 9 look good to me. Thanks.

For both, Reviewed-by: Zi Yan <ziy@nvidia.com>

I also tested them locally and confirm it is a gcc bug and this fix
works for gcc-9.3:
1. gcc-13.2 does not give any warning for the original patch 9
2. gcc-9.3 gives the warning for the origin patch, but the warning goes
away with this patch applied.

--
Best Regards,
Yan, Zi

--=_MailMate_BE5DCAED-0F87-4ACF-A8B5-DB176F96BC63_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmX8TF4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUtjQQAKMU2OSx5GRDea5w6s3QLgnTlccTtu5IkcWh
cra/wCSnHXz/VCRSLYo6he2nWFy0qBq8jcFZdgMPPu7MwloClboFlmzanB1qxkal
AiALGBk16zWEZoHFiOV2jVEmsa2GLOJ/TUymlpc8DePdbY+fyayPJy/rZEVVjZVc
reqi2mpWsyxqcR4891SJMgeJsBfbrv4D72IOb+mTEP8GKumulXASIS3lrfYH48EJ
sJJqms66Cvt6D6owof/qXHITt9zMpNjK6Bu7WcL8MWrdaUTGszuo9fpSeUOu5h5Z
MfGTc41mUOs1WLMvHZrbDvLwt0oOUdAC7QRt9UmPcz+Ljw8mBtpMW70EhnIBr9CK
EiKP3HrOxMohk0aSV7qTWLe0U0DpZ1Sp4eob1pugQ6IhJTfWnHgYvh/jwjisDSVp
/0a8igp0cJidw0rULPTh7qpMyuMo1H5he/dxUaskF+qfKte9WqB2eu5MlpOWR+mn
WIV5g5S+jTw2V53XO3NVOQVOcuHAxjJz7VhDv6aYDpkLtr476wYNLV8w1+Kr++VA
s0Ta6ew6mJOYgR1nHjKtxDj0GYtHgdSi8oikd4nxTOEiDeWFyW4w9DC0VZwEeyWR
MeXwpaPI1u8TVEsIN9UKO+dtSGeY1lsDhJOvVQU6N2gXS0RP9Hch5ajeU40fofKK
Ep4IKSZj
=X7nu
-----END PGP SIGNATURE-----

--=_MailMate_BE5DCAED-0F87-4ACF-A8B5-DB176F96BC63_=--

