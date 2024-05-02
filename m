Return-Path: <linux-kernel+bounces-166500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469858B9B80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B526F1F21F81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E384A51;
	Thu,  2 May 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJLcg3vq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A04824AB;
	Thu,  2 May 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656038; cv=fail; b=JClOJcSJUktonbgKGoAi3Cdc8m5qpjdTernPOhhZF3G3uAhRF7J4ryM4BoG83QJxDDhpd2qVsVCxEe7bT8fH7bGUwmSDikNuPn3Dz5n0fZyztJGBJA1PWTrGK7RiY/+/Oimw8te5w/asUcjihbKYqEnUq4c+DOwxfoUMLKVVe8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656038; c=relaxed/simple;
	bh=oLFnFnL4ObRrgXjEpvCuyY+DYCcuoKu8lV50F727OjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gi5sZzV9G44DDt/N3bWoBFZizP4verZRuFu9H0/wkQMAjecq++eHw47uzl/WXnAe332wr/qWoV9xPYDfP5cJGN50YZh5iTomRCuSUxQsER/8GqK4W4gyWEh+D+/NpY1+HLvj1RDyx+4ciFMhnrLHemKvS+bW4kMS2JBLeK/OKtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJLcg3vq; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hj2cC03QI39Mf5xLeuVizNWqUuTbNEmU/WABhHoSIe1oLZ1ytUovPQfkDrMwx2mSxmNEvgnCFq1zJyXIxJSbuPhh7lrNL6yHst9DjAyVKv0OyVq9ri7rFADHG0HoG+tXrB91p3yKZdagZgwbVr/Q8/sTVhD7C5tNTMV5jsMoyyu7H+5z1Xwshy4aHe7LaCtukw7e7wMQI1tsJBgsa0au1pGoATxAQfE23VXdAYyy1Cy3/n4VlRjQF+XhMKTFWw2E71SMzmluotK0c85wrSTGFe5eK13fBKoRavg28uirhyuNRTB5hC//VBZ27+vJLA1ZeTbDNnMlhMp5Q3b7YwDWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSePUjNGVflljeCwRpAsuorFCT5Kpxqs6jgY9Xv2IIg=;
 b=egxeRhR56+0+eoglqK0ZRcGn/jIbgrhQ2oJo8uazIWvxXqNQG5AYdBvKa6SjagzPBBWhnGznxhfVMW7iuX1gLM9LzboFfWVpcRTls/1zhSaDCZUXVCJLY4UN9cwaf2R78GAUaMoaeBnYAp0mnoOkWx5uFF/gryV3x4Pl3Xs9Vp6Mbucfzl5n7Me9EPMxjhj9OdnMPvItJOC9MrVAbzsC9X7gF5h49fmS50iGnShYjU/pHXkjp9RYW1uLHz6t5lR98m2YlhQKLkJYaWkV+FAiL/Oe8WS0gfkkE6xzGVDL73HiA9udARcpFNSafwmyzVPtI9sRjtw8X1tcnE58/5e+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSePUjNGVflljeCwRpAsuorFCT5Kpxqs6jgY9Xv2IIg=;
 b=SJLcg3vq+8vsimpubhXagzHhmJ2V7e98LgpluD3hyNW4L5WJuzGVi9qvaGbSFN7j13i0fulvaJ69aumB9DPKKEioUT+ofRRazmcc+53GahlEszN0TmsyZTnDKXBpN7c/Btx1+qam7RB6OMGX78X3yW4sCaPvdvjuXwHMn8Ps6k/DfhgohW/tYCxsAaGcLiZCEfG26FRAMi+hScMi8COUbqWhY8kfkZu38kDkLY11ZgEMo0bmfY5cjm/TY3CKowVUvCMtNLhebXZVsJBMMl+aa7bUxdDrLp+61xM88EAoA89FsvRrFUkTBhSzXNqgsLe4f8f7uu3wnEETJ4dQepdRbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.28; Thu, 2 May 2024 13:20:31 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 13:20:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>,
 Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Thu, 02 May 2024 09:20:28 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <0151832A-388A-40AF-8ABE-304C25B43E30@nvidia.com>
In-Reply-To: <ZjOSkPc8f5u5J6m5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240426190253.541419-1-zi.yan@sent.com>
 <ZjJCdodEf4CBa1N7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <5FAD7FB6-4AC0-4427-B56E-4942A95DB68C@nvidia.com>
 <ZjOSkPc8f5u5J6m5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A41DE513-9D3A-4B0F-95C2-9F2389B85FBD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:207:3d::42) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: d034cf49-0fd1-4ed7-c35e-08dc6aaaa3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpHqMCBBOW/fJpVwgbWXuWrsQIatPDrSZA8+SZVmTr5QDTvdveP0NMq18vMs?=
 =?us-ascii?Q?ZTnxZO2PQmPvz4nzWI+KZsFgoggUCq/TvmBBr6Iuw8oinu3H2twEmA03MQ1N?=
 =?us-ascii?Q?f7vRFzR3SYirqTuLRneqPcKZNO5ZQNyKeY7Lr2+EtA33JdJOEsSvka7KZ0Ac?=
 =?us-ascii?Q?jYfqeQ9XvDb9vyRCg1TBBf8dywxrVtxG/JH3rL5EXQ2HAY1VPsQMzFnpe89V?=
 =?us-ascii?Q?s9JgwTJndIslPdIujYbZ/UGkCu8+FgpVwB4CfsGb9hUvmvx2JVmOPdMZDiD+?=
 =?us-ascii?Q?RRhrNZVst4SoXe+8Xd88yiLc8yT72RxkvUA9g+Ykbh357oJsoNlHV8NAnJMC?=
 =?us-ascii?Q?fJ2UWHTMm/zyCecF+RUCwkSZ5EicLeykHGU/g+1JXQZFsGlVNbCESsJf2fBe?=
 =?us-ascii?Q?Z7NnwT6vUWRwLJjJp4ly9NV8hSNo4MXNUHP4XvzDkJvKLYPNdQuBxiGdpsmM?=
 =?us-ascii?Q?9/iN9517PbTnWp5/z87rId2BYz3oizV6CpeX2jcZS4sMb7JtBVOQTRVM5QvP?=
 =?us-ascii?Q?ywA1vBKnpwDAUDJSgF62Zx9Ryqofo2yhsydR2C4WkqexaJmYXYfaITAR9blR?=
 =?us-ascii?Q?wwpOYhvtq7/C+6AgO23JfWIcad7enb1kyH6R1BNZimmMwCisHL7/O3blbs8N?=
 =?us-ascii?Q?sGmUGM5WaaDU7MVUWM7TX0w3QRcOpCnIF4sQsfMs5lhKFyWiXiaVXrV7eGdN?=
 =?us-ascii?Q?GSj+2C6KrDJtLVeRehZ5JhucXO4Hj8b+UDSNEdX9FQfgiJmCcwN4KtXFoX5n?=
 =?us-ascii?Q?sGwIO4EjACt1gKicctUn1fLPty02+h3CEtEDno38YUy/NJkIV+eB2QPRdYPB?=
 =?us-ascii?Q?mQHmBmjXLrBxnCQVn5PdWf9Cjx0HDpK1sAk6eJoiC9CR0xKChGg60BZPcNq+?=
 =?us-ascii?Q?B+ZCgYfg543GXEA/bwe7o2NGuSDnk7fvqEo+KoXn7c9PMoGwy26hxH8V/4p0?=
 =?us-ascii?Q?9PfJAXnvrSs87p1OJHeWiFyr/WVNdXpubW1DbRj/B5azIwuml3BY8wvojbeN?=
 =?us-ascii?Q?cJ54PGej/UKOsUXrSgL3RQr+WQrjojBwVjn7B8XKR0LBbyruRkpEa1PkKUj0?=
 =?us-ascii?Q?JZYbY7FDneXV7+bNCo6lVRotKR6dpupjAH3+T7B6NMSMrg59oVbIQ6PJY4iW?=
 =?us-ascii?Q?qf5EY194kgGI3rfdtyCTXF5A0ouAB1jrcAuSMU25UniMRUsWvhccngtdXkh4?=
 =?us-ascii?Q?NmxDWMc2iuEy3JE6tHxVce9Xbm+BNR9pR80c8WlxmY4UMhRceeFLFThtzR7d?=
 =?us-ascii?Q?RI7plCo54hnEzR3Hs1I4rOLOY5HAR9ovnbWzricOSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KcoQ71B35zjfiZ0QgCxdJr0lmRE8iLIvdNRCwVd58Or3e+E0fMYqrOI7dDQI?=
 =?us-ascii?Q?iWBBclj/9QRQc/Xq3cA6ToZmxhjP7u6ypr/gGKxq67glCU1261Gpgk8aJ+0z?=
 =?us-ascii?Q?88tlo/zuV79VBcPnSXUpqoV+YJ2PK4T89TJyOLoJMwR+0bwZPe6qbAO0nNkc?=
 =?us-ascii?Q?qCSkji6h11K7XhLyPJgebkC/LSuWTPoPZGGIPpXbF23dRAUbR66rYL7O3QEt?=
 =?us-ascii?Q?+KIiArohP9PxPmR537JpuDJegCvBr29VeOqR+vRm0Xq40chr9mCvXfSQnmEZ?=
 =?us-ascii?Q?mDFHi/vn/zu3Q90Grt8SaJ9jou0WoX2aSzm572lqdEsUMMqnPaXIhABFEDDC?=
 =?us-ascii?Q?v9ZIeux3eP8EKiuF3plyUnUwX5KpHM7grx4GnexLQrmsGOhjbEiRTdHZWGmr?=
 =?us-ascii?Q?xoZzHx3Myj/qbsA6s0g9TnfvDDM9ob8pgJEXuQr3g5lHkU6DRdjzAQOo3zV3?=
 =?us-ascii?Q?WxSZVLyVd/pxBSlhvYR3HRGOpfXCB4j7M7d446PttZbVSAscMEZ1pflj+DiC?=
 =?us-ascii?Q?pmvY+j3Ua+Krm5bLgNIUEOX4K3qb202TofbNeCzXSG1npczbMwcX0J52Bh9Q?=
 =?us-ascii?Q?UcKnCf7i/xCbdiIamtgwBphhtMEB6qve2/WY/ubHZptMo/gS0MNJk6YvP/Oh?=
 =?us-ascii?Q?SOvv+lGdMzR+oI5QMOe58KWehmgANZzxvvNP2SrVs+YL7BxtcTotKGCgQk1h?=
 =?us-ascii?Q?+Tqux/EqauCkgQgyLVZfu7eQXCOI38hT0X+P5GDuMCLYATrDte4XV7ByQLIt?=
 =?us-ascii?Q?SgE9V9li43yqEM2N/aPrXGMhNYdDOFRn8y8cdxfqiWXN/h029odDVvsX9NqX?=
 =?us-ascii?Q?vfJvGOpWvBuR0PfOy29V9JX6YNv+FXzLTDZIXKa+0JQ8ByrnmBSE+70yRnW4?=
 =?us-ascii?Q?A2pjZtXzv3eqgx2KmbCDjJSWn0Ae4fvLF6Vdv9bktFY1ssTGQs0xkGqeYp27?=
 =?us-ascii?Q?ALaMwp7Zd+Ul/FzHxlgiubWXU8v0Ja08I+p/mfZA7UNKuz+ksHUKiIUaMJvY?=
 =?us-ascii?Q?awYS2ToyucznYGp3s//1oaGhBSQGS1QT8kuICDrCW6IDMZYwbSOOQiFwhtly?=
 =?us-ascii?Q?1i15ggbUnxt1FokQQxjbmqwA5chwCU/Roc3Y6F7qwrBAncgXEuCafD+yUXil?=
 =?us-ascii?Q?7Du72L5RLxNdw866CnXw/erxs/Z9skRA2xRtPCjo2JNFZ5F9OZkB/WRmGVJE?=
 =?us-ascii?Q?X0qZWzCIs4ENm58LEAjVZ7V04fpFWK/kr8mmxIu7H/gyNChh/nwrScaEvQ2P?=
 =?us-ascii?Q?XE7nDyRGhOxLtZJN6jt4aTPDAxMxKWjT4WUs/2n//MBwBDk59wUAE3avHS4M?=
 =?us-ascii?Q?xbfgJ1krhLGghGIpTmAyVFrigwa1okEpFuLmLhyDKOElMucXE6LFMvUftSsY?=
 =?us-ascii?Q?WMcmHoLKa5WAFSljTb7WRq/XIXssShgLrJYIACysVBEV6jqWSN/1GdKAK7Me?=
 =?us-ascii?Q?aisZPJnOtsI/amJeptg0agmw2bEdfgYpGMVnsIE45WT8cX5n474KIoNY1J6O?=
 =?us-ascii?Q?0R2XUEyl/sduFRLIAsdnRCwgyI4aPri/2tZmMoQYHqiZaSXgN7GbbM8n0fbw?=
 =?us-ascii?Q?judSRm7FDEsFXZnJaSiNpUW1/SIgurUr5WaoJiA0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d034cf49-0fd1-4ed7-c35e-08dc6aaaa3ef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:20:30.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVGAnUuKPA7duLtNKAiapdC8MgxawQkHi5ra6YrRjZdv92nEaR0RCedKn7/hh2A/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202

--=_MailMate_A41DE513-9D3A-4B0F-95C2-9F2389B85FBD_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 May 2024, at 9:18, Alexander Gordeev wrote:

> On Wed, May 01, 2024 at 09:38:24AM -0400, Zi Yan wrote:
> Hi Zi,
>> @@ -1557,9 +1557,8 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
>>                  * page of the folio is unmapped and at least one page=

>>                  * is still mapped.
>>                  */
>> -               if (folio_test_anon(folio) &&
>> -                   list_empty(&folio->_deferred_list) &&
>> -                   partially_mapped)
>> +               if (folio_test_anon(folio) && partially_mapped &&
>> +                   list_empty(&folio->_deferred_list))
>>                         deferred_split_folio(folio);
>>         }
>
> That helps.
>
>> Best Regards,
>> Yan, Zi
>
> Thanks!

Great! I will send a v6.

--
Best Regards,
Yan, Zi

--=_MailMate_A41DE513-9D3A-4B0F-95C2-9F2389B85FBD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYzkxwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUF08P/AppBhA7R/l0drHEjiAItav9kVWfrMsjLOZi
gWdoUd9c5bdD0wZLF+j+70iarYx0VBooCu8XJDKMmYzuDLyQs71q6ypZuK2Xlpd1
qgrBu6pQITOJzZLtkJZUt7vDJmF9sG32YtR4wCeQa1M5xgePFPd4+EuFGG1C6O0m
ai0ydAOORmC8NeEOhVypLNBmwimiJCim7x7+GYuo+WOtacYRblAe+175aWZaUjHx
Thf19iArKnhgYMGOWE3WywtE/GlyZsQfxnUIp8uCNLtGaGjHooOdmzZMy7uB6Z5Y
2E8agGl0zeWQipoNHd17Xe9ZTemWlv+QCtprfyskYZFd1xEbycI9gFmG00dlU23F
z/J8KUMt6TOv4pPOqQuinKYuPSgvtlOgpwOubHlp29CdDyCowlBPesR3PEwTbj2o
ZGrq5wPasEQPWswmLga/KVJ++vNOB89PjFQfeA5yZmSPaaGYEOM9YIhMNTm8oPmX
ghXF/sQkoXDiCpcv+eibVn7uK/omDmhQ6aIjbQVM/ajfVGl2COek+OrLKE1WkCsR
41Ia+YC357PdPdWg7B2UdJbIKmJ6Ro/Ti9xKivn9krCvDBnBve8IdGErWG3xUR6z
+hwyBR6FetwCJOOrndwMyhhjPrc9xs9HRdtMXsUZ7ZKvewDeRvwYoCI9ti2pAN6k
LsRyIre2
=1xnh
-----END PGP SIGNATURE-----

--=_MailMate_A41DE513-9D3A-4B0F-95C2-9F2389B85FBD_=--

