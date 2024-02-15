Return-Path: <linux-kernel+bounces-67295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C46856953
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825941F27FED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5F134751;
	Thu, 15 Feb 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n2+ffpPM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7C132C10
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013645; cv=fail; b=ATRtcNbUHaFmmjIKb71/dRUhsXEDXRmql60bCN2tfJPGyUnnjU/LsmTC9hcbs5JvuFCGTPFWwc1dlVcXLXrtie7Z7y7sXPG6cUXsV2niDyWUB15MDo5LGvtUfMjU+iLNjT0Bxznu0NFZdylxFahvpQF5TIGlp9gRDxjDv6pIbJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013645; c=relaxed/simple;
	bh=mJd6jd1hQoWsGNNIwq9lpTKUIsPooIR4iNno40gRix8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hNZJlMqUuoL+08suX2wDExrKWBtV4dvISgIrlNqIc/yTQi//eNkBTWqahmV+5Wg8UjcHI0kmqL0PsWmhUeDvUx85E6sk8Bcmyp9EwB0yHIJeuNs6Dvb/ZZQ5cnlSVxY8dl4JpmFR6rZ5uXBnB2ZB0r069BzGchDX1ULO0suR1Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n2+ffpPM; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqMVZJHLvMhh05ysecIgx7ogFqKQZ2SzdCtSF1irlyeRRIqIIsTPQH7h880n9iSB/jYI9feHx+52bvQUhAvFYm9YIAk/osi9gR1LuRGXrnMyc6tTBk/YB1YYLL0s2hycoYGZMCygUkKswsR+0uG9cnZv6tQTQNcFMgUOX8gs9JHu7AsEwz4dgghUyWWMKD4DQvwwjzhYr8+oOaxB5WJ7FwuE9LRCRIB/LpLwI4/5bMhHH11tJROuDBPDO/u2oC8pMc0z9oIi6iJXxy/sHkhqYNw4+LTfRzk1X1fxWFo+qf5lurexzc+0MtAUvS+uVD6SD7RLSuF68Pf5fRQZFLwe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coTfamranPKQqiIOQSXCSG/0/NRYq8jhrxyeTQuVwK8=;
 b=aWiArFXxfvEgtmWuk0GF8A0dyAp9+sL9ZYgSNlODAffozBqVKKuhSSIkSpECKgRKlKQXnNIeLWvfx6vOvieXSC+FRWRULsPPAbRitkMIKl18+KtvdmTIot5FrthnqyrY7uA2SqjNw01GaeBEAwP9ynKKr4Lb2ctO1b8sj5DWFTYJ1sewr+oNVIWh2Ks48H8fHR3RFj7KbPMD/MfjKN4bynYfrKqe7pDvvl+u/uC57HrfWRACHV+lgZp5XOthQKf9Qnir5NIVhaJZArIjfdvCBjatmn8u9/sWuZAVNwFH+jD3y6S9nQRhaYKMBTXM1UK85a48QPs+zLTVNku4qyYqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coTfamranPKQqiIOQSXCSG/0/NRYq8jhrxyeTQuVwK8=;
 b=n2+ffpPMNDrHzHyfQaJd8ubvDQy+z54D7hqHuChFOOJmwYqXIPJ+o+5FKilyp8bmGIQvbRYq7n+vaFGLQGv/UUny8amiBxDmcLhY+vW847AOUjN1VVHNxHGJvbDzDKoUFPv8F9A17iRJf2bQEFwfx37+W7E6Vc+a8SyYuZkUuRH4w1Vv+JR5o5an13kcC+ymKgxpU4+Rw7o3W1lpbmcQhByKJnoUp0joFCSSeGdbLF1/KJbpdfa/lYYUQOeAWPl77yZAc01ZzVn6GZhsU7ao5QEvRslP/dhcQJGrER4tg2b0Z9l2jGfvqk04c/32WdurRfLAJ4jIDpjEN96AFuDirA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.14; Thu, 15 Feb 2024 16:14:00 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 16:14:00 +0000
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
Subject: Re: [PATCH v5 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
Date: Thu, 15 Feb 2024 11:13:56 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <01060AED-C371-4E3C-A1E6-77DADB3B4E60@nvidia.com>
In-Reply-To: <7d2b44bb-e3b0-435d-98ff-670b5029bd93@suse.cz>
References: <20240214220420.1229173-1-zi.yan@sent.com>
 <20240214220420.1229173-3-zi.yan@sent.com>
 <7d2b44bb-e3b0-435d-98ff-670b5029bd93@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_B7C8D105-1764-4414-AB77-E568CB5ACF43_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac6dc64-ccc2-4bdb-3ebe-08dc2e411e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UcNrFNXSmBiV57GZkLyZRb1BU6Widfx9t0v9yXXUXsRHBvuQk79lIeSKKO5brhLVeMUfkHTtc7PM27jUvgfX2nIAVTlAPfu0pxZwfUt5XQT6IMeeGm4agaS1eLRU1TKTg42NOIAE1nCh02hgmQOpvUCvQFigp0cHZFKUAXRNyveIzmQI7dlom/vbip6iv5kG1/LMRMFn0TBA/vUawcjf/u914sHyiq4P2YXtfbG8tulceFeoey/MkzLz+Zv9QxNlw8dcGafQIujB+Dr6kyY6aI9oFm2eun/gEiPBQ5EQ/aIP8BAaKMBL8qvgVxk6wGtKMOi5YSj4RcRmAo1MG8MtBddisWCiTNpBKJ2v60hZe4USj+/4iOLXX0AOOlSerXDGEaC2ZNqBrGmb/5LeljiyCaTVbIbBXzCmBBO9GnyK76g1O+uyOgDJbBLkr+gQ/Y6/+JJ3is0E14Az+KWABkL7XVI7lsXkMoavg+Dd+htaLmieC2wfPpWUhw9TiI4QJS3wtwXBiDra0qPgLB1OugNIAidDF8BRdFhroL/oGJRLsp7VR+xT75WLZRAVcFfqNK9+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(33656002)(2906002)(83380400001)(316002)(86362001)(6666004)(54906003)(6512007)(6486002)(6506007)(53546011)(478600001)(6916009)(4326008)(26005)(8936002)(7416002)(235185007)(5660300002)(36756003)(41300700001)(2616005)(8676002)(66556008)(66946007)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FLfDedM/RZnAwAHu2ggCAkQ00fijM0l95zbtunDdlxebZ0DbXpgsuh/oBlNT?=
 =?us-ascii?Q?Xc8dNGHMYQTfPCEbqZCEhsP1WObxYXAK53ZQWBdWvVUHyaLQxrCPtRmsZGXh?=
 =?us-ascii?Q?ROEvwz8zbYRiZfpMhz1yLRjy39/rVJs9ZeDRzCxmKdzZLMquxt0T0VoF3J+v?=
 =?us-ascii?Q?7C4TD93wJEHUusuuyUswRnkMRDZPhqreiofi0DByq7/KOe9FJJt+WZY3JjxF?=
 =?us-ascii?Q?c3FZ399Jv6b8E5a07wVv2Ma3ELMSA5639xDhnu0TrygxYAP2XfVDQPPG7k8+?=
 =?us-ascii?Q?6dyJIGZ6BaAbGYy8AKabYdyT2dLUG93FRvl+6HlJuFzT169UmgR8UJM3eMiK?=
 =?us-ascii?Q?/Xua86/X8a40mQny5Xr2uFs+ifYcLwjSHKP5ap8/4Qf0f8Bd94sQqQ+pN5E4?=
 =?us-ascii?Q?0BfJ1CPRg83wfsyOrK1jAgI/DF/wMRcRxo3H1lLez+4eYAQOI9OjhNkKmhxv?=
 =?us-ascii?Q?hkqnI7JcWRZ11WOkjCpUOlAV5GS3i12RKUAL25aeochh6vANyl1IJOjdIv+M?=
 =?us-ascii?Q?eDyNA3R9A7TS6hvrBkcBiAtN51EbzQFo7z9a63nqVpQwtKbOS0sl/1pxES/i?=
 =?us-ascii?Q?ofGLhmkMzkAaZgNIvTjb55zr3o48WysVH31QSHsOGYjePzxO82jFauVFACYU?=
 =?us-ascii?Q?3xsHv4mVJd7KwT/SINFEDeIbJBauqXm/LDkNaafrXL/ZZRBzklRRD0kx22YA?=
 =?us-ascii?Q?DuhQtc5GrAcx8yyWgNfHXaEYc2u8sxP1mdFvK+dh4MSPzism0pKynPiFPw2V?=
 =?us-ascii?Q?jhoVQg1EHwIFd/gdFB1Sh50YVHbSnpUz+/pfP6pMKG95OiKQ7oymUX7r1+ZI?=
 =?us-ascii?Q?eAr2SHKuS/xlpAHSaW4bVVoVyst+tmGnO3z2boBezcSuOQ03yyqGQ9kY/u8+?=
 =?us-ascii?Q?4I/1A/x6wlLACfpiHSmJ82subSH5SWLpCXo+kQpDm3Irif/UgZtr4/gfk4ld?=
 =?us-ascii?Q?056hELyTgsyI088adIhYk9hAjZeuzclbtyhSmyNmPTkGBp60WaGZuozzI2BU?=
 =?us-ascii?Q?5vf8IVbmkkO19gYACG16VYAgaMvVUGtKhiDvwSzZtjTNarL0Ag331g2++YEa?=
 =?us-ascii?Q?wjzhpoC/pImjsqAikHrAJluCmrhM7WuXkkU5WPHIJiZvn72qbvNdFWVGQtVr?=
 =?us-ascii?Q?fekgb+5in1JX+UxmKo7ARVbQE35952cZWI0AAmG7eLaJkmYE+Iud65NBgqbi?=
 =?us-ascii?Q?Eg2UQSy7m9GjQQrhPUwbhhu/IjT29f24zCARyClAyNI55asBb+ukH/feddeh?=
 =?us-ascii?Q?MjnpmBCTq62GJakI6t29tRKNrRLKMLtyQOkczYMQGFgIQM9RhcJuPBwIWp7V?=
 =?us-ascii?Q?E4eBPxZWpUQP6LPeqKhvz11ftPTmRPHzf9Ic/QGAf8ws/EYS72gylo5cnq5I?=
 =?us-ascii?Q?6sWuS4e2FjnRecCZDGLHnOZQQXmnVPMkibGSI/zUuIOCGCcxd2g+8Y8qoR61?=
 =?us-ascii?Q?dWr/XYPXuBSUCOqFT+4hh7hJrGHBaLqedqrGWk3wA7nXPn1dcWa5G+YfBmEg?=
 =?us-ascii?Q?DTvyh2VO0xfbb56aFGr4xGQaVU3vV2zfacS4dAUM2OU6IEj6aQbwwX8kHdL2?=
 =?us-ascii?Q?LOT3eYF/pwPw04sPXhw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac6dc64-ccc2-4bdb-3ebe-08dc2e411e61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 16:13:59.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xedW/vSdjarkO7F4QKBG8B0R7sZskQPkMyY1tiZYu5RFWF46epcU4fvskpErNUZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875

--=_MailMate_B7C8D105-1764-4414-AB77-E568CB5ACF43_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 15 Feb 2024, at 11:07, Vlastimil Babka wrote:

> On 2/14/24 23:04, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Before last commit, memory compaction only migrates order-0 folios and=

>> skips >0 order folios.  Last commit splits all >0 order folios during
>> compaction.  This commit migrates >0 order folios during compaction by=

>> keeping isolated free pages at their original size without splitting t=
hem
>> into order-0 pages and using them directly during migration process.
>>
>> What is different from the prior implementation:
>> 1. All isolated free pages are kept in a NR_PAGE_ORDERS array of page
>>    lists, where each page list stores free pages in the same order.
>> 2. All free pages are not post_alloc_hook() processed nor buddy pages,=

>>    although their orders are stored in first page's private like buddy=

>>    pages.
>> 3. During migration, in new page allocation time (i.e., in
>>    compaction_alloc()), free pages are then processed by post_alloc_ho=
ok().
>>    When migration fails and a new page is returned (i.e., in
>>    compaction_free()), free pages are restored by reversing the
>>    post_alloc_hook() operations using newly added
>>    free_pages_prepare_fpi_none().
>>
>> Step 3 is done for a latter optimization that splitting and/or merging=

>> free pages during compaction becomes easier.
>>
>> Note: without splitting free pages, compaction can end prematurely due=
 to
>> migration will return -ENOMEM even if there is free pages.  This happe=
ns
>> when no order-0 free page exist and compaction_alloc() return NULL.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Tested-by: Yu Zhao <yuzhao@google.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Thanks.

>
> Noticed a possible simplification:
>
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -447,6 +447,8 @@ extern void prep_compound_page(struct page *page, =
unsigned int order);
>>
>>  extern void post_alloc_hook(struct page *page, unsigned int order,
>>  					gfp_t gfp_flags);
>> +extern bool free_pages_prepare_fpi_none(struct page *page, unsigned i=
nt order);
>> +
>>  extern int user_min_free_kbytes;
>>
>>  extern void free_unref_page(struct page *page, unsigned int order);
>> @@ -481,7 +483,7 @@ int split_free_page(struct page *free_page,
>>   * completes when free_pfn <=3D migrate_pfn
>>   */
>>  struct compact_control {
>> -	struct list_head freepages;	/* List of free pages to migrate to */
>> +	struct list_head freepages[NR_PAGE_ORDERS];	/* List of free pages to=
 migrate to */
>>  	struct list_head migratepages;	/* List of pages being migrated */
>>  	unsigned int nr_freepages;	/* Number of isolated free pages */
>>  	unsigned int nr_migratepages;	/* Number of pages to migrate */
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 7ae4b74c9e5c..e6e2ac722a82 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1179,6 +1179,12 @@ static __always_inline bool free_pages_prepare(=
struct page *page,
>>  	return true;
>>  }
>>
>> +__always_inline bool free_pages_prepare_fpi_none(struct page *page,
>> +			unsigned int order)
>> +{
>> +	return free_pages_prepare(page, order, FPI_NONE);
>
> Seems like free_pages_prepare() currently only passes  fpi_flags to
> should_skip_kasan_poison() and that ignores them. You could remove the
> parameter from both and declare and use free_pages_prepare(page, order)=

> directly.

Got it. I can send a cleanup patch after this series. No, to avoid unnece=
ssary
code churn, it is better to put a cleanup patch before this series and us=
e
free_pages_prepare(). Will do it in v6.

>> +}
>> +
>>  /*
>>   * Frees a number of pages from the PCP lists
>>   * Assumes all pages on list are in same zone.


--
Best Regards,
Yan, Zi

--=_MailMate_B7C8D105-1764-4414-AB77-E568CB5ACF43_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXOOEQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUmGgP/2BNwWsv6ZsY/3YWp9mAa8zO3dGiDPXhybOS
FTibDHhqaM4v1lLa7bj0dy9uQzkrNTd0f7RI7Zh2IP7eleffzo/8ajaszqHO10q/
Khyhgq0ltnCz11hd36SbjZdmALpm7uXNX637EGo9paBENQzvHMyo/MwBnsSXGiPW
alS42+T3gc8eSoewfZ5kLMTv/k0a9CbTpkiZDRKYpytzGYo2r7sUwecAjpz3rMOU
p/SoYfh6cuc0Q9zmNXuvDCjowQbc8+gV9Zl5VGmz6QfE/2am4DfRcCrtFmvWgBIT
pUhn36915hvXX11zfYoaUD8Y7FU80P7YC5hQtI+EXl0lMgXw2EGuJutRaXG+T84i
qzsC7gQvAOdLiRA2wW4uQb4U2yvutA0q3mBml4/b6A39bQR5BbxW66K86xplH/Vq
2deLwQICvDTJ7FplrufxAxl1HiOPikxRO8oepS2muRzc6lEKyaewlK/5BaC342FT
3WwcXzAz6smWKnoCbmRLn8oAfe0qkQISiSq/s7mkZI4K5P/9HwudROpPHXP8AM+z
qyOE1fExuZSZJiCqLlSgXNxc2OuaZ9Y3Amnm39hXIEKZTtBf18mV2m74ewr48CHe
Or9CYGIV3uTuQ7atMqFZblguYDLtwaBM2k/RuH18y2Acc0w4JiUSxYZexKSxTEnD
TPLSExcg
=uxam
-----END PGP SIGNATURE-----

--=_MailMate_B7C8D105-1764-4414-AB77-E568CB5ACF43_=--

