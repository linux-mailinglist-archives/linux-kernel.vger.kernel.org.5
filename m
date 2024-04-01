Return-Path: <linux-kernel+bounces-126791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F79893CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DDE282D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDE545C15;
	Mon,  1 Apr 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SdwCgy5v"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C573FBBD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984846; cv=fail; b=c3K3eVBs3rJfK2lro5otuSmjpL4zTOhS0X70NmJDN7GONgR8Ui6OhHxWJ4pPBhgPoGlT8f0k55ofcuJDfHonu/zMLd+qRgnWC2b5lm2Jfj5IovHyYVtQ6GrvlFQ/JUcAFCM/gdONJhHddpG1NHUFFXIFq3FkP6j7smdsL6fkETE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984846; c=relaxed/simple;
	bh=BpmkAFV2wxeXB/8jf5GR6KN6hfGBM+E72CFfgjVmkRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9NV+BrnnUcjnkqi6d4pVv3AImcyvsChEmMgDRMM2FMyn0ejvg5S9zvVDuOFqQi0MVufOHZnD653gnZsQvE6ABlEgId32EdMrWlCg4jHitac5RC6qYI+pWKOjD9WdVUJZ0Hpx8mylsHs3NieuXV0CqA1WA9F5uaXrb9wRoSJ8l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SdwCgy5v; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/XIOVjCr+a9pa+qnzKuo5HXnxZUnf2o+pFy/leJiVb+5yNgWNFI4qtn3IFZISu0eQ07ODWZJQlSsEj69+lalcD0tAz2zBP+4z+zjD0wr5e4Y6XOBLrtVYZoh+8HXAKX1oaijgaYUQaXh1P8UOUcEU7N4IL8Ism/sk9HtUqPopvccaffvhYrWMCfbPUXhI/FqIHWd4Hb0/WTNhmKCZmevozgBnfx3rcCUVmAeEgNDQs/3bqokLTr+XlaLIDI3riwU/JmvY6Fse1ZgibMMGusF6uD7OynkUEGkCDaHVZngHSieWWyU0agUjSFhsOpKC97YF8MwGb4N+0q7/43XGACHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wwwUVo/DfYBtPfp9Du4Vko4asUI61SnfY1ZOi3GNDY=;
 b=Jt0Sj2eO72cy4vG86DN9PXGp86fyOYFcm8y3p3kCfONOO1RPrQTfJepwZ0/wXYUy3PWyBDUvz62dZziITbvFBCIUPVuWfpRAAvrPe3NwwWrbRHISJ5CgzGY4pnWwp5qe/vhhAOiioS0bm9UCiRcKcZWm0JZ9zDbUOfSARIYm5DTsXkz+K6/wG+AxUWEmkeNiLjOT/tr6CLDtr9NFoBDueiKrulqGvcXrFk3g54ngufh2QFRtNz0UdLSWxhi+5sr0iIf0/Mwvk0agKIUklYesNgW+YfsNDY1/IlZ8f5iR40WJMUIgjzBdVmXLStM63XiB0spsxDUsp0PiVxDxbrC4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wwwUVo/DfYBtPfp9Du4Vko4asUI61SnfY1ZOi3GNDY=;
 b=SdwCgy5viJUYHyVqYsyEfjItzQh/p4ycu733UN7yIXK7fU3QzoS1ftTiuJRJvH8tWXrYt5kY6+8n1fcOgEwZpgGQKyi4Lv8uC708AVJtfCLwzZua6bXry6aYlyy7y0SL9wu7CJhBRalZoBnj26gD+vWmgMSJE5wSS7aFPEHdhLNfYfwdU2MaVJEFDNO7odsUfSutsqLTe0zpEaidFtwC8QDY8j40zMGdIDi4Mx/l5P6qc8vVAJ/mct2+8Nu1XSCAVkrBMfg44IWn7GZ1SVet7gVc/WdU22MHzjAvzbYGAVtVBU0vBVhbyYhwhoBtPQMmbZFav/XZYDuhqt+rFffFQw==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 15:20:37 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 15:20:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 David Hildenbrand <david@redhat.com>, Alistair Popple <apopple@nvidia.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Rientjes <rientjes@google.com>, "Huang, Ying" <ying.huang@intel.com>,
 Hugh Dickins <hughd@google.com>, Itaru Kitayama <itaru.kitayama@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Yang Shi <shy828301@gmail.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm: alloc_anon_folio: avoid doing vma_thp_gfp_mask in
 fallback cases
Date: Mon, 01 Apr 2024 11:20:33 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <7E032ECE-7656-4470-8138-249BED7FB631@nvidia.com>
In-Reply-To: <20240329073750.20012-1-21cnbao@gmail.com>
References: <20240329073750.20012-1-21cnbao@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_268F9331-D064-4604-A70F-AEC44BC84C35_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:208:235::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB7590:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lUoqGS0iAR5GcfAw9PZR0tbEOKiND4knniN/IXqoNeyqwOMrm1MKI21vmvCFa0CvkKqi8WBG/Lud/Spnt4qBQJEwI1HxtDTxOZv5LZEmsxdelRRTCZVG91FxjsyoY1E1qKhS9QdTzM8/ZJyid7qo9Ljwkabu/nAqMQc5GYQVy4udkzI66uBhMeBjMXy5FWlausJMcWxmzbcxNNpOMGavDdoXjHV8sVgX4B+z8nr0h73UWIMeBOwc1YRJhHzBY6WSDfQ1hHVjsAgTQOwQckV08TQHjjLhvkaXKMuXoAGjev8hDTpHHUKe4yI8mp0mJjIw1Mz6IGl8c453lnwX53KDRvprMuC25+kZxIvrz2WWxYrPi8oLMHhrAn/1bWf4Y/CR0idHGjHoJjR7kNU+KgPppxGp9f3VxlAMtuMaQlcyZ8SBRsWnajkf2Oy+SZLjzZQIMBm5idsHM0/a2lVMt8KRsKwIzA7tDbb6YVM0QYAnHqYUDhZ2anWKY6TX3cxpb24WMC6FB5FNUGT0RBsTn4/00jT8J88lXZxiAhiCpC/VIPyiIY9gYIp3iA9hyTzqBN5In0GIoqXg6otZWMtOzd8T8BwQHUS2InsdnmujESciLgrsMKhGDUraEHlWECrhSg95o6L4qcWwINZwbpLjXQzqROmYuUd5Y40V5cei5THKTvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ivCK3xPLbh3sPZeAhLb95Sc5y06/2IjE/2Xmiwi3xE7ZhAL/os6B+urUOIHr?=
 =?us-ascii?Q?58QQvZiYGmpuNna1rlt0/8SxmpAQMq1CoFr46zPC1hIojCVoD9xc7WhUPW73?=
 =?us-ascii?Q?zatm80y+KHx8VajVntT1IV1MClKbGguyTJf18tucDXqKERkugVqvldSxwTVx?=
 =?us-ascii?Q?7bMjkM7IUWONFEHxfN8XGH2/NUzwNHc+E6cgodZc/Vz4NUkNUHnqeXd0rTlo?=
 =?us-ascii?Q?GBBa9FtVu4Q4iGx+5U04u58O9nzzi6jqZKVdD2/8kxiezhfKDTLuKzJBf6wM?=
 =?us-ascii?Q?IP9rzmjfeC1u4DD7GoczJ2MP1WR+1BlrXGvr4D61O25DZlbHxpuY7BDNDRnR?=
 =?us-ascii?Q?jkT312W7gkvQROrzISRdlItSbGAmqhbeMTfDBoR18xSxGApKHHm0ZI7KGqD6?=
 =?us-ascii?Q?xg6ARVYYjLHKUmCVid3jPm4ZatL4vH6Zi8yH1gytTgxnQqpVj0lNnI+sjRsU?=
 =?us-ascii?Q?lO4DjcNJuaI/BoaNFcybZetWFv/WRRAxNRDDjwd2Letd63GejmQUBObyT7RD?=
 =?us-ascii?Q?dmgpCtaiMPGfFbE8ihYEuu/F3M+Sue4OVABZCZ7Xr14EIv7I/GfAIja3Corw?=
 =?us-ascii?Q?uaJAmPTKSsc2xwoPZoPnqfA0BN2Q9LxC8WQlLOO7gX6ohhAKXv8wYgPfxECh?=
 =?us-ascii?Q?vVrlL6Mn0IsO1MLHdw8RWD4VKkHOBIzkkuDNWwgUYp78TAKtncS01qzI39fU?=
 =?us-ascii?Q?3/mBmcYgebvpsUEuwPD8rdYKqdHzVCQ2yaeFN3XkwYbsspcULHIsRVjqnFFg?=
 =?us-ascii?Q?N45pcsSffDbKhXnWide8hBYKFJ72DCVLFmWW8LnxK4fwuktspQua8wLg4vxk?=
 =?us-ascii?Q?34ZsKhrsN4TEowPGd/KlNjn7DmbqhO1oGCJAewCIMAMmOFOL/SdKV3HThRSq?=
 =?us-ascii?Q?O3z+vVJgXeiocCh7SAhuVeQB7hYl5eMPu9JU07Fc4RcLV2s6//fbO0NhhLYF?=
 =?us-ascii?Q?DsCJfYDBoW/s4Vo7lUbumV3GJBVBMMTgIilExxxV9NZf9SR83WIWH6QZbmWA?=
 =?us-ascii?Q?R6D8h/CEiDQBwJqUU/42gpH25rXFg4OFFmgT2zeSsesigdp6VcD3Qb8N1mOr?=
 =?us-ascii?Q?2CzMtTGkeiCbPjM1ET04g0bIUj7Kt/rI6aNtQHcJdA3R6bjs5BeZjnjx8WwX?=
 =?us-ascii?Q?yGGPEVvD1556zLR5IrR/VCOg3dnv2ffyKfr2PpjV8TvTFm5d1QvNTDBHUsGT?=
 =?us-ascii?Q?lw91Wtj2tJcSpfadKW3PRgheCpK8QD4+rsgkwT6pF/2hjb2B2KsbTYf9aARv?=
 =?us-ascii?Q?czdVx3ZrQcc/GNTLfltiG/175wa0IvZSSFD8cnpCAsBCDonajwMRVbPGO6x4?=
 =?us-ascii?Q?r8sTeJiGaFp+mHiwcr+Q1KvB+PlYy5Bhn3DH7wma7/WQipH/SMTXuKdJdgCO?=
 =?us-ascii?Q?/bInWw3Wzzimlnzgfl4syDl6gifgiRKAocIyxTqMUYwfhkF+YjmEkKWDsaqF?=
 =?us-ascii?Q?TFslZlUF3UDzxcviZPFafvvMfv3NLJNBOkxcNaM5/eZImbITdDRyWPtbyw+V?=
 =?us-ascii?Q?N5nm4IGu/JiTwjUnT6ni4lqA5Qgr+tK/n+E+MRsrfObmjwph3hYKQxVKEMld?=
 =?us-ascii?Q?xHe4XTWKMBK1L5kAHd4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29643065-680d-4e97-14ac-08dc525f4861
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:20:37.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yC8iYG0RZV04KGNu3oqawDgVKbWG+ZsWjqNV7c4lHkZwr/17fKzR5qXv35cNmzYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

--=_MailMate_268F9331-D064-4604-A70F-AEC44BC84C35_=
Content-Type: text/plain

On 29 Mar 2024, at 3:37, Barry Song wrote:

> From: Barry Song <v-songbaohua@oppo.com>
>
> Fallback rates surpassing 90% have been observed on phones utilizing 64KiB
> CONT-PTE mTHP. In these scenarios, when one out of every 16 PTEs fails
> to allocate large folios, the remaining 15 PTEs fallback. Consequently,
> invoking vma_thp_gfp_mask seems redundant in such cases. Furthermore,
> abstaining from its use can also contribute to improved code readability.
>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Itaru Kitayama <itaru.kitayama@gmail.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_268F9331-D064-4604-A70F-AEC44BC84C35_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYK0MEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUxtEP/A1uGF+nhEurYFe5ZmhTVbUL9vNED27qMTuX
Prrgz0wp9zIg/2vl/E8njstc7zGA6+obSxfYWUAE5UoRGAF/++MAwt1mf7QJoK3T
xcygJnSnKt0iZ5sjGymkU/l6PsMgDzHkBxy0PSYvWjGNNnFyL0PEXFHQ8MzuBirD
6EWtTMxHzMBSsJ8swIcmq4c9ChtMstP/WS9tf8Y/otk1FQok0KOcbdR4kmTg5gXp
qkjRjb+LoUjohf6CWTJB4RJelbzHsRZzu4igaVGUFS0jkCg0CEEkpaLMudsxVNH9
EIuxmykg00pwsGHWebogTiVXoqocufXbcLdnXMv8cuxvSRQlZGckS+k3kirehYEN
G9tos1Nzw3kZjd9W6uKFpmS7y6XSEQtdXqhBDnFn9+6d+UNSf5KmyUE0r6zo7tQ0
HXYhLfckM+kwv4ffwj47Jp6epdy7auxO1dDO2X7M3BrouDX+DDMX0rULA2J0fx6U
23Pjn7Y7mRw+OMoV0C7eVeLRs++hXhjn6maul1oK2jfufxVk1fxlCZkBGFyH/mSN
ZNLARH8Lw4TWQBIOgt0n2+svW3icThPGYM8zga2BgeJ+V/GDvGDrVzlR1zikdwVX
mJLPoAVAJvMin6OiGnGVbEeH3lRmQ/6pbr3Vz9g3+DuOIblV1UL0EsoVdMWLvu4V
LWlump8w
=4eXq
-----END PGP SIGNATURE-----

--=_MailMate_268F9331-D064-4604-A70F-AEC44BC84C35_=--

