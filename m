Return-Path: <linux-kernel+bounces-121348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F7388E67D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75C41C2DF16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99F2156C5D;
	Wed, 27 Mar 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTUcZ4yj"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE413A40D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545050; cv=fail; b=n6MocF/MWBfHO3+vb0Cq1p53Om8d4RdvuCmrSpv/0FaZWeLhvIAVhrjFvoUTxWFo8PHYGAJCcb/To9jjE9Pk/7VJLiJuLp+bWOWBdeCvd6TNleqKZR2GEyt32K3GmwyX8c+drP6+zjXQrlqMCiRF3LCmt4zmdR2ji/yZ4Ak0hCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545050; c=relaxed/simple;
	bh=OJ3jB/YfOR8fvTsDFVRjS/XHBiKhnBjcE/V4g2upxGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9/k1efbdHe28R5J3X/yL37fDYBVM3O2IlNGtKUd0yUC273Lwgu/NiI53ZWzRpafX5xOP0ABnpdW4Mm/P8O2j6DaI9vzQMx5gadS8WsKDCNkT3cRLMMmE8lIp+HDw42HZS+RAyfCMMZNeyPi9MSukx690Ks9ixYL6iqKp3vyBCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTUcZ4yj; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDvMC3aqRIGTTwgaE/u+YnXOd/LvPg/g9Ns9xkiQictEDbSp5eaNRrTvE7GUrB5mVVbAdzDezokhBDCVUKhiAKIzszIRAuKLtyLSmCDXMQqPaKy692NTYt30BOzUcU1rbB+DgIMmIMSyko0q2EUQrz50crVC1ih9wx0CgPc61BROOH+H+CNF6ZFGNl5ur8Muv37nMlInvOYKx2RedeHdE4G2IH9RTpwPsMc06LE4z/Lrf6pjh/ZSdsyPPUtrXtoRiWVASpmahwNac0A03EBTYCzJ9NH6UHoY7Us+xD/hBo+RtGpGB+UoBJ7426MDGl2jBYFr6Y6fP3MPhMFYOBaJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba7lpCZtdmJ9VOZG6ljSWkVK1ndnIkpXw92/VEmEnpc=;
 b=SEGEhfLT8kFiSC8EeVJyAs8/W03eQ7GOwCQiJlqZvlzBlvumJiScDdjj9nLVrrmCzaZQz6XSew6IKJedJOpTWKWIV+EhJadJ4+KNzhT7w+C1VHLrHF/3t06Msy+wJ+7gHk/JS+YJHKrX6O6sCzC4w+iAjTKzA6EiautN0EbWwmuut+PMv4afha2gYW2w5vkf899sdylyaEuuJfR3WpuM80OuiZwTJrck2nbzWW5ujQx20XhgzQuUVCu6iyTsvD7K1XqA5rZcFysXro7lWxDMYW3RTs2MeCTbpY1OUyOO4vBKa7t70sMT6zxCJxn0TnWLoq6HigwDokEVpUoTivllpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba7lpCZtdmJ9VOZG6ljSWkVK1ndnIkpXw92/VEmEnpc=;
 b=WTUcZ4yjTSiPOifOIWNwfI8iY4TkJsRezkSwHJQ/9EO7Rtt+WSt5Qp5nM0/DbLGS9UUUT9xQFjt9Ajq8r7T02YKiiBjgSoBEghIHJNf8Udaj403Aq1pqGfwPg3kQnWIWhhDke0ZCLUcsiAKD+j6FL4aIGFW8iKaCy78QUI+oELDH7fUR5ywdr7OHyu8/1Vgc8yq3RUPBKQ4G6NgbKrjqKG+ZO/BOf4tQMGjAcgH7MKTFGPyyo5uqKYLLOmVzzO35ms6i0FnY6xUBYa0Y40hUVfA7uizWGKnSuKjex1LquxHxPcaOMx2M/JL104ptCYs9sUStE6wq7H3fhKp7fUbNug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Wed, 27 Mar 2024 13:10:44 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 13:10:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
Date: Wed, 27 Mar 2024 09:10:38 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <A2223EEC-5CA7-469F-AD25-0D9BA35634A9@nvidia.com>
In-Reply-To: <81b1d642-2ec0-49f5-89fc-19a3828419ff@suse.cz>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <81b1d642-2ec0-49f5-89fc-19a3828419ff@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_EE6F443E-A2AA-4140-9630-05EC3E076536_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:208:23b::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fba3d83-42cb-418e-3d77-08dc4e5f4d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/P1eAaYoY5a1b6/E97rF9kzvmPeVyI0aHQdlTSng4FQRq/mZaTZUdswJsva2MM2lqAgTXMgw7KARypmhQcFxuJueHrNMulnf2yKpuCzvRzKVJtZ/opQ9feGXBR68ITpvHlr/t115r/5knPA4wJs9Y03Ygz/iEtlvluhvHsJFeDDMQrWWjypz5fqifsllHdAjn7Xmb600O17ApoudYJQgLFqikub85ORau7u1awFE0aKpUfJLXzoMQ9Im+Fiftz7gtZwCDAYZYuktxooy3f9L9lIM6CTuoVElJzblEgyP0cJv2CvVbXzrM8a8RELETbsK09bQQ5jG3TW0fBbeNmcXn5DI0YKEOdqvHcTdFnzwOyAWk53UwOfzXCKFFmF+C3KNke6NzWP//GkWiASvEkZ06kBieo67M81B7NjwtqTKD837wDP5E9FS+VOD4l7X5pgk9p9PCnKsBPTiYfIOi6eAtqY1jIAqdaNuIhEVaFoMRol4p+6yq/1mwVmFd+JpA0zwlGt9rSCbyWADNy2+dU6tcyhXaOvM9+P+4S8P974Js5KvthtSBFSPKiLberi7ET/wG5fONMg12VRdTKTH+2jSxKSN69n9DyBZ+k6ldAq9S2Y5DgRC+UyyKZ0QnaACskw7Z6aW8yCvaFFkd83ODRRBQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zajcMaEEUVF8BQxvsm6DWU9BThW270LCYrcuPe5FAWSpxUTt3GqEltDacge8?=
 =?us-ascii?Q?JyLnOkNn7ggOF0jULdU59fbjHdC7yOJqvwXwEMH31fbdASOyXdEWdMST+6Xs?=
 =?us-ascii?Q?2pYu2KqriA1yGh7dPY/uDramN9fMtNE2ibdk2i356QpyVNsfROht2DujR+wz?=
 =?us-ascii?Q?dwUxjdU6Do2t6H1L+tfksbGMx3yOTx9zr/IlD+Kv+gMnYh3FYw7PKJRFCrMk?=
 =?us-ascii?Q?zTS4KsBTcXGIGOJ3XYMX9zepWFBPoZ3bauLaGHXhkw6D0yKjnUtAiuWJ/znt?=
 =?us-ascii?Q?Y+qv/iBOf1LXLmjm39Vd5cJcLUNWC4Lxvdx2tizkN51PhUWb09zFLIM22YU3?=
 =?us-ascii?Q?dKhDvn4d2u9tU+Lv0iwjFJl4u5tefFubW7wDeeHpfB8bWRIdWraRQJRvLmqR?=
 =?us-ascii?Q?MOnbMdyNotEMas1xqKBGe43zrH0L8x2AGoMANPOoI1hJcDV5fomrpmGYmCvc?=
 =?us-ascii?Q?pmP83b2IiwGkiomhoNhvfAumt9jioNoxKocd1vtlKy2hyLYbxw3EDFr0p0Nh?=
 =?us-ascii?Q?pdo01BDtIg243ocBEXQ/6H9y5CyScXwmCd5wgiOdHFdfjij2aeJadnxB2YZu?=
 =?us-ascii?Q?WDNv/QrGSn0Sk68wcjVj7TEyNaRcmYsHp92b7kz7hrriPzC8zXcayrRAas3v?=
 =?us-ascii?Q?i3C7vc7gZDA8YF3nLmBq8WCuI/ZW+1ZwqU1NvUz9rbYjZ8dTU4ruQq+qGaS/?=
 =?us-ascii?Q?myHb3eUx22xWAVKrBfzgdp7wWgrf5PHi1Ys8bT1i9xCHejPX3+2O+sB90GcD?=
 =?us-ascii?Q?wSlt62ewYR0KfvKFek+B334k1XQDEiFW3hbgVhC11W3KRFADAWY0uSxI2NaE?=
 =?us-ascii?Q?AzCgkRbsz5eTvJKxJxQKiG/IcyJZYEvc1JtnOxQFx3VvSuBWa9rvjM9NE9pa?=
 =?us-ascii?Q?Cfh9dKn+ccMqqfYR3BC/XQ+cdrlw6Z7N6TuqgrDrfCWW4V1egIYVgJcQEMyp?=
 =?us-ascii?Q?OU7b1RhJPYPxPe0TO1LeZJ7sdB1d/7HhG5VQrNbQ/5SizhnPcaF8/YXjucol?=
 =?us-ascii?Q?/9HvaELnOT8NeDVBBDrfKkOEyCO27GoJhmplS17dMoyus3WCRKDKzN9LLEGf?=
 =?us-ascii?Q?NjZoHo8Lu8Pqc2hWl4KJQ543hVLJXQiJ7KmWOHkuLTNKHniN29fPaDUL7BG4?=
 =?us-ascii?Q?XEIesub0bSVDMKQ/Cmld04WRWbd+nNpahzPNUGuJpuKs9iXp/f8njG+lLIVW?=
 =?us-ascii?Q?awsEVaIQuTVRCluyJC76Ld8y3v7kvRfFSMn5+NCUj9A8mdUk9igx5AYnbRXE?=
 =?us-ascii?Q?PJ1Krsnhn6KX9xs71behiKgDMWUPeXYu+PPAboH0lMe9ddHKAoYJkH0H/ua3?=
 =?us-ascii?Q?uOpuAhHbYkaiRnw/YyMNUYN4DKl0IC+7A7dJuROoV6adMi453S0HOFh/uFeY?=
 =?us-ascii?Q?inQ2Imo6ELuFIgPfORd5UBeeD9BwtJ8mI/t1pC4Q7nEgsw/idz67F4S5qTly?=
 =?us-ascii?Q?dgI5YT0Yi5np/t7+vobbTA01S7NJ/r+nuCW19ctOWyJpibeNGUpKf4dBIBkj?=
 =?us-ascii?Q?PTEATPYhUbn9wywQ4Ju2YXbICR5gaN3iQSA3EfzJ4/ox/B5kiAG2ZlIC7xGY?=
 =?us-ascii?Q?RfRAc1tLETmt+DjjJ5g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fba3d83-42cb-418e-3d77-08dc4e5f4d56
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:10:41.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpX9xd6wEQykFPn6PP+NQrvz3CNF2zBphMl+vN4yEp2Ats2ROWlepJc/89DTHWsk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180

--=_MailMate_EE6F443E-A2AA-4140-9630-05EC3E076536_=
Content-Type: text/plain

On 27 Mar 2024, at 5:30, Vlastimil Babka wrote:

> On 3/20/24 7:02 PM, Johannes Weiner wrote:
>> V4:
>> - fixed !pcp_order_allowed() case in free_unref_folios()
>> - reworded the patch 0 changelog a bit for the git log
>> - rebased to mm-everything-2024-03-19-23-01
>> - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
>>
>> ---
>>
>> The page allocator's mobility grouping is intended to keep unmovable
>> pages separate from reclaimable/compactable ones to allow on-demand
>> defragmentation for higher-order allocations and huge pages.
>>
>> Currently, there are several places where accidental type mixing
>> occurs: an allocation asks for a page of a certain migratetype and
>> receives another. This ruins pageblocks for compaction, which in turn
>> makes allocating huge pages more expensive and less reliable.
>>
>> The series addresses those causes. The last patch adds type checks on
>> all freelist movements to prevent new violations being introduced.
>>
>> The benefits can be seen in a mixed workload that stresses the machine
>> with a memcache-type workload and a kernel build job while
>> periodically attempting to allocate batches of THP. The following data
>> is aggregated over 50 consecutive defconfig builds:
>
> Great stuff. What would you say to the following on top?
>
> ----8<----
> From 84f8a6d3a9e34c7ed8b438c3152d56e359a4ffb4 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 27 Mar 2024 10:19:47 +0100
> Subject: [PATCH] mm: page_alloc: change move_freepages() to
>  __move_freepages_block()
>
> The function is now supposed to be called only on a single pageblock and
> checks start_pfn and end_pfn accordingly. Rename it to make this more
> obvious and drop the end_pfn parameter which can be determined trivially
> and none of the callers use it for anything else.
>
> Also make the (now internal) end_pfn exclusive, which is more common.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/page_alloc.c | 43 ++++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
>
This looks good to me and makes sense. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_EE6F443E-A2AA-4140-9630-05EC3E076536_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYEGs4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUHrUQAKHhEop4mkFtZVXp+3/WbrANacnUjftW1U+E
RA300v1Jp3C8do8AzzraXMVw7BgswG8mY5oecmPcsUKF2anhr14GP4GihMfzwxs7
ZiHhA/u01yfgWMz/FfZu/M+uhnhS+1wPu2HNeGaZY0PynWdi9zF+SZi4X5d7aCDm
FoWFCz2TgYd6KXgxfSqMcebEFiMiTAdv3Yv9nCAdxIDKjvDglVQInBItioAqIe8e
HZOO5ERzKIKWytK5ISWjMyvsjY2DtdYGbn0bZETq9by7oiQlhcSMQuTt7jCIZJE2
eLW28pVET8SzSCOxey+3zrGayd+GKRpncvOeTwGvVhRIR96OkBAFYVXMteOYp2Gf
qVKfHgzBqMm+R4pMgdDyC3A5LXeM+ukCANoAs3blws7fm51aaMyx0hXN/9hwgbxc
tv/R87Q20vIdnvnRScJnjIGa9yro/hiHFweE7fcwKOaaqJm2OiQD3wY3YhhnuORX
gxS4kyMprjrObK2raADRbosh41Q4r4o5no5I0tEARU0WvUDGSnGO94/I2srXsgiW
XSOUU9h6oPKYoF+zEzwb7RCrLhea+jLHMl6/sMHtugquuPDMrJBFvJZFlFCk9q77
ueHzBILgsUQom2N71bzm8fGo4Eis8YKnWHbunTVSWg59v53E5sYqadFVG8DM8ywh
WJTkrKr7
=HwrE
-----END PGP SIGNATURE-----

--=_MailMate_EE6F443E-A2AA-4140-9630-05EC3E076536_=--

