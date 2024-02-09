Return-Path: <linux-kernel+bounces-60056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0384FF4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D991C226DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049421353;
	Fri,  9 Feb 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nu4kxPzc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14ED63B3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515949; cv=fail; b=P2aTHdWuUmFiGcEPSjo4128UbEKz5gVeu1gVcYTspdHyfXM0g6zZsouQRIM7yVIOXhcaqXbDCvUXWR98UhI0sLVovWDOGU835VrluRnMnwHPePn0KgY7yTfE2ot7qWYxXIpyo1ah9U10enMsBI5yIGzgniLXkH1dhXZzxX+aafM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515949; c=relaxed/simple;
	bh=K9jWeTWYasNM3Eiodg6F1k2SpIvKatqx4dqui9x8DOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epf5q8yqoC979vI5nCqMw/KJodzC9Mqv2wOP5mRN/9Ycyl6DrejQJUUyk/NWEINnIb7doSUmp+u5k+J/OcpDhOlFSwCYTtMV24OXvS/Am8BLmPEIKpA55A0Otp0lgdufImQFxoykz2c/M8OMb+x7k7sa2OCxZwiMshCrNDEbO04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nu4kxPzc; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kyul8Xo8O110gBnLm907AtrSOcnt/4xlcQT4GBJZz6eVCqro0jr7rTst/b12/5PJwAxqO5SPFcvv9ufcRgucP2zMexLO0eV+ZPDjjSEcjSwRapEbKDbv1Ozuu4yahDTD56RNCXk7L1yoq5VnSP+mWjayt8fNmyMknuKahzOfwQup35NZBXqAmh8UvhtnVeCZjtVvC0bXcaezh/1yRGAIfCmZptZR+MsGqodfnWbPDsVcbFN+bJKIe7LrFvywVRW56Ja+wXw/+ODG8dy3v03MZg90l/iNR49ma2u5ke5jlfh+eWsM803qHgcN+CtOm8AWpMYStLVoOibahYw7zBf3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwZMf8vJuOVztPSPBlfhCJFOnA1eOYXMR0n+mmk7RWY=;
 b=nkLNjZBQOMPJYm2ECGQRo7098OnMvzTqiQ2yw1umrcnlFIL0UsFs8HFz0DAmxiu3zkhyGfkUcQyjLhruua5ux1Tnz+EUczNeY5RZnlJ5VCB2n1I7ayoJYIiVpA1dW8Ca1TJ+6EIJd+aedqSlDNj3gmXpTfuDNdur0CdD4BNEAGs1B2Hp/7BAmGl1DTtkx3zRYnXrwSofmzNRPIYnCQje4F8T5NkYduvizTYKbPlZK2JYmBlMDkToYq84I9unFoJc8grVrTvjBoBFRtWVAkYOyuojPrukoSuTnbYIivyB88UctbRT1wzLK2w403ajpU6aMQR/Fde4xvJPPAOfDkIdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwZMf8vJuOVztPSPBlfhCJFOnA1eOYXMR0n+mmk7RWY=;
 b=Nu4kxPzc7atc3TGG3VF+vkiHpdE8d+L2wkld8Y0Oq5/VUf0pxcn+KHh/z59dPgeWR1Hle9twCwaSyATgfa2qZ348G9Yr6U+kn9D7U2clQZObQ8CKqomwDyXENoSt4zBfrvA7JMaBrURU2pbkPx+DNfqYP2TT5Py+8qxqypYHY0n+vNpERZQ1rx/e28s9ibLGxcqBEakmfHGD0N4uCB2MSG5GyltzMCSYR6yEY6nngGjEWnpP9hnheCvnlTuI6jQHHwiPjpFMTb/vWWzyt6j36StXPvV3NE8JDZNgeIddgFue6cZhleo07iNBWKHTzCepCxPGUVP2e/gL8UCfZgy4uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Fri, 9 Feb
 2024 21:59:01 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 21:59:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
Date: Fri, 09 Feb 2024 16:58:59 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <06B3E4A1-856F-4469-A703-37C98F3DD062@nvidia.com>
In-Reply-To: <025b7e7c-b17f-47c7-8677-ee36fc6dbc52@suse.cz>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <20240202161554.565023-3-zi.yan@sent.com>
 <025b7e7c-b17f-47c7-8677-ee36fc6dbc52@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_5A4D7140-F5E8-48CB-865A-F91482228BD6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0109.namprd02.prod.outlook.com
 (2603:10b6:208:35::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 69670a7b-00b7-4572-2154-08dc29ba531e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VQcLIbFOISzdr19BB92PBVpE1xTKpmRso48B8F5RHqJ6/UIzXwajBB7CWld6mOmvG1lvq7qmqnYSyUJIFzPotEi4TJNJkNvKJ6cVMSMMiuBqrdBK2ZIKF7jfpbShCyTtx7KMfzQfXfVfX+QgwKvfD+p+nrhOOgNg0cXjf9UzpM/hGBWu1DCz9Cpdq5vEF9oFZNCFfv+fJm+2Pk0deKCfJMc86iYKVBvJWYlHnYrDzS+iSwe8lFT6JXqqK574AWdzr03GBPuGM24eYkL3g80lOyCUnxv6/rvw5zQtFkUp3mvUKgHJX/ijfxgLZmi+jLKXlJ3FjGtxOkA+ET0yTGQ+9SuRAEYXD5Xr5GebsEm2/ub//oaVmWAMHbcI0K0P9ER5MeefFSY7UXSLbb2czCwB7U1j/2VBrcP71aG7hwM5BbBoVOzfUrzh/lL2kw3vygBY4qG3mE8wKlYEEAt4Am2kq9OQwKK9uAykhjroe6TNlPHjegxFhdu7j7un2n6J3Ay/NCVYXUhHa2EVrJzDFXhbxUuorrCWR/xiBkv+ssOoYccBym7b5asIMlvI3mjOjMfL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(53546011)(2616005)(66946007)(41300700001)(26005)(478600001)(235185007)(8676002)(6916009)(4326008)(54906003)(6512007)(6506007)(6486002)(8936002)(5660300002)(66556008)(66476007)(83380400001)(33656002)(7416002)(86362001)(36756003)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1KFuPWggRn6N0dCWIiUVhsk12tXD+i3RTnEBUNf0N7R+sMSMO+QprPZleQt?=
 =?us-ascii?Q?++zvZUhnXH8jvM5ENN75rOvHwJ+/TQnEz6ZaxbqVse8DlcrADN7B2AZlI0ek?=
 =?us-ascii?Q?HBYEWH7CyImUhi/Gjg/EPZaw8ZQ1n4ek82HW99KdYbh7wV2aYeRdyPFImVjo?=
 =?us-ascii?Q?/vH4S9SfbfXI8W6A+AxRTsSVvdC0WvfJ8gslsmjr7v7ni5QI9HC48bhtaqw0?=
 =?us-ascii?Q?mDyxu2ax2XFDk1t6YH4GEiXjfpw9T3da5DSORvwSA019FXQFMPWRVPBnmO5E?=
 =?us-ascii?Q?ieJ+BdaeUSUeoYws4qO/4m7KX1B3I1ynVNcAGxzDkbPxZmW+CmLi+/XfAW4R?=
 =?us-ascii?Q?jBofe6l8W0GMlOmow5fPtuBnsuaa60h00gVKnkP+ZZIcx1hatNZuueqfebGT?=
 =?us-ascii?Q?PSusdajAKfwGoY3VYDHcQHgWs0BCKjwkDqv9VXleAWYAz/f4f2W5kVJ7FK2a?=
 =?us-ascii?Q?X80r3XDnN25lwXNUgD/22qZytLw5ed+/4TKY8v2sicmFrO4qatzCEmPEWenm?=
 =?us-ascii?Q?GilBg+EnPCZOwOTUNcTAMFX5xM+aL/CB7h4D3DbbewYeRV70dli4iThNXKRN?=
 =?us-ascii?Q?m1nuUS5yFzBDRzdB/+pg6zxrzkEDe+1DO7L0w8ksJ3CA+U3EsMu1tPGUBfsW?=
 =?us-ascii?Q?4Xpgq1TXC80kmhdCPB86ISiBdsZpjDyHDABR1bpy4MjpnDPs95JECpVpj3f7?=
 =?us-ascii?Q?YZb8ncVjWjK42c/g73yKPcZdIDACV3zFGwT7dwpHCWlq1YEG9cXVv8lW/+HY?=
 =?us-ascii?Q?6QJrzqVC5PwaJsdG94/UyczMEzvJ0Ll+Kk0gwmbZ4gDzgEpT5FD3a1m9h0zW?=
 =?us-ascii?Q?MfZtQjT4C52IH2D/kDWY+Zyt2IddNksiBhMVYBym3zgapoed5IdTN/vBU+oz?=
 =?us-ascii?Q?7MYuwv8Znr8NL98DV1DzqBx2lOyQ63uAkXDoMLrj0TDy319E724GUYmEH50u?=
 =?us-ascii?Q?6RDmG5S40CcWs+j5RaAObpjqIhTZLyzBkKqTRp4ZWLEcPrYY+XqjU3Xq4L7p?=
 =?us-ascii?Q?mWQEAp836x9WIMg8wio6VQPEqFKS92M7AAGofzl0ad9BoQU01VTb/3Sm8Dzs?=
 =?us-ascii?Q?W6AIop7/ZLF6UeJObOtFbfW5zmcwoQ13giFaoYimvgfGhbkbeusvE/RfwYyT?=
 =?us-ascii?Q?StN4DBCe2+QHdD7ivpzaCVl8Q9FWWthmgvSfIUnAeSex2adkmwE6Uc30etfj?=
 =?us-ascii?Q?HOiqtKqnD/XDXp3AWqRBNcfKGMaBokpMJ6zRFY0usQkmdy0yewnelurSfZ2M?=
 =?us-ascii?Q?saLtuwEHxbFULwOjholRksBmHk/l6yUUtWYqS9ckfs6WAIsyne3zBFrJvnR/?=
 =?us-ascii?Q?URalUwQZd5vNArcKijChoIFZGvfR6n5BCuRD7TXLVhO8E2COnaHM68+cRSGj?=
 =?us-ascii?Q?w0h+ivxzayi3Tn/SbintBhEeGmdEqSUgoZ1F3HxNdPq3To0amEYfEwf6EpRf?=
 =?us-ascii?Q?mjTDnmsVcIhHT726jfu5arSa5+3w1/NgzDYVKsOxnCEiNp9PSytBitIRQkiK?=
 =?us-ascii?Q?KlF2fu6pXrdogwfxf0KvLcU3eYf9V6tHhzSx7+ebp/3cSduCHz1Pfz3d9GSa?=
 =?us-ascii?Q?zkZk29xPzUaZBZ30PzuS+mP1s3TxdHoo6gGyT/XD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69670a7b-00b7-4572-2154-08dc29ba531e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:59:01.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFXxb4/dUpFoAv8Z+6E8g0VGW5bfgKgLF8x7x2Mm3Ua2yuDf6f8CUO3oZfiR3NJo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

--=_MailMate_5A4D7140-F5E8-48CB-865A-F91482228BD6_=
Content-Type: text/plain

On 9 Feb 2024, at 11:37, Vlastimil Babka wrote:
>>
>>  extern void free_unref_page(struct page *page, unsigned int order);
>> @@ -473,6 +475,11 @@ int split_free_page(struct page *free_page,
>>  /*
>>   * in mm/compaction.c
>>   */
>> +
>> +struct page_list {
>> +	struct list_head	pages;
>> +	unsigned long		nr_pages;
>
> I've checked and even with patch 3/3 I don't think you actually need the
> counter? The only check of the counter I noticed was to check for
> zero/non-zero, and you could use list_empty() instead.

Should I just use struct list_head instead of a new struct page_list?

list_empty(&cc->freepages[order]) vs list_empty(&cc->freepages[order].pages).

--
Best Regards,
Yan, Zi

--=_MailMate_5A4D7140-F5E8-48CB-865A-F91482228BD6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXGoCMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTqAP/35ZQsa69MuXrhRwmSsPIcf24flTZUt8/T84
j9jO6dbtwhcVmIZrv56DBaNZXCYWeOgRs9OdYjJmvMuPTiLRjiVXP3Cs3Hijth9V
E37wp4sTL8HBCPHqPLI7gjJCvKFVtt9LBUxdwdkfCjRJUGIwqGATNlbj6G6/QPbE
n3A7IVK/+GZF3PP/KoTCPAYcewau+pj6OQMNBUJbWWRc2so9I4evPDpmIE+I35GK
3g7H1isCpOCJolB2JeE14MdixUn4g1ymOAn9yHEg0U5CPW80WnZaaQY/Sy55kNVK
GLho8qnfU0Ph4+4NuOCMv1NDqS69eesrJ5RY4KFwt8XpmdtWhvcMB+Jf6PnKdh4t
TsC/RNau6DpUVVLvfSMkyEwtxVWInlpnLRpkLeJM1jSimWQcA3sZLvotBdPUl80d
9OkpvDeA/Z44HpuzHxo5x1WOGWZVb6BqHLyK80ObpmwHfRY/hCV1odDCs2uCN+tE
srGxd3fSzS+xx1imUXf7HFLm2MM7Bso+1gXmqAOJDtvMG7JR93Oac7+FC1XifA2W
Yu2phdtsFBkt9LDBggRvNS6DLGZY4pawwUWMGwDo4KiPkmU2SENhinl0JeZL/yZE
Vt+o/0mesrOpoJsbckIw33Lk1euXhhjBc8tAOJ3Dj027ZI9tXguzHKwyd5CXDX3p
X/vKgWIz
=KZWD
-----END PGP SIGNATURE-----

--=_MailMate_5A4D7140-F5E8-48CB-865A-F91482228BD6_=--

