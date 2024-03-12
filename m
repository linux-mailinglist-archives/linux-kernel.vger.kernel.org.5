Return-Path: <linux-kernel+bounces-100305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1A87955B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82EE1C21843
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B07A71A;
	Tue, 12 Mar 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBkdQEJv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D57A713
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251359; cv=fail; b=Fch+I/V8a6/UqCgymdSJmvplL34Pm9ty/7228/ediKb/QuBHm4oPIkuNOCb8AQfV3CtufM4HC/ru+qGnXoESP9Bi1O5vTxGcqpOJpUyEQeimWb0LKcZaXPlPnrMyDcSfMzdlv+Q/VqhoB/92KcsMLm3whHRt2Pc9ch89tgcpKc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251359; c=relaxed/simple;
	bh=3FH6mw7Y6CnXTOY6RyWwZ6IczHEsul4GOXNNteKGscE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxK6imDF+GGHZ7LLl1yKfl0RazEV2N+Meo6W7pmP9LF5s0OwhJBQXeenHeXZZrZ0MWdcgjcCZKcvwlLqqG+wNJJMEZKBHSA5vVOPRzx/HGo9B7uymdm59e75ki3SM+ovqgF/4f9glm/POiNGmBa1VZAnQq39daWjR6p7j7n6Zvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBkdQEJv; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX8cSrj2scmjOr5eji1YEmpY0gQmdfWfiAaUcTNX+uVIUtEAatOzLEYC7szDUzHFdgXYewLWSEXa8B0v5Iu0Qpys2hbCfQPGKdO8OZKNdwjvE/tI7Zk3wolUXm2p7r4en0/1iKXhqaMc5m2FhN9OnALTC7wZkar+icKBcMNJaCAcjmJr+jqS7if3gABMJz0fhqtM4GxiYlgK8/p7+mfVeG2V6EkVY4KJsXWXUhzZ1VS7raSDMwX41scHEQQvLRKVzYIFIlKio77gXeKehr751/dl01C4RGLlvG434IPoQmk7q9SchTYvnmEeowlKBf48PIF5g4g1ql7MHpQ+LC8FLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=710edf2+ZGbXWeO26BNs5ezA6Qe3TA/7fYoz8UY92bk=;
 b=CcKkUm8RUFq3w1bPa1ygQIxSI9SFH/C+nFZ+DuAK1B/L+M32I1mQLQAt3W52tc8Me04BrSBu3lhtMcwwWocO8l5kMKep6PIoXbGpSSXy0xq0FWfvLDNhiOIlwawBm6zG2Qa9hV2hU/Ny8YTdEy60sVxzQkVdCBtXvBhIWOEBfa+ISpbRMl90EvJSnzP/JF1TJJ6IDYjnSS7iWr5FawMuhbdaP7AhW32b6zbdaHdozfm4zsyJcTLxEwQwrnWCOwEu/Y2hiHWYfKEKOlBrKJK6/u+FR6HcGx90XPN+gfi2DluFA2gcU3k11TEO0PDs3i9gPNJoHMbwYyaWVnRV1/+V+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=710edf2+ZGbXWeO26BNs5ezA6Qe3TA/7fYoz8UY92bk=;
 b=kBkdQEJvEKaQPULjcQtdArOoySzpxlvtZI06FnEODQSbQ+EP3rm1lt8jtg4crvAxjDiQe67Tbg22lRpLioI5kOcXIZMMAaqzvWyE2EX462XGspgZo3LJv23whxMPNjOgNSvzpHEzFeUzA3Cvc8/2x2+e/XGTpYFZXRzXYft/7wK7f82XPnBVBMt6LNDe0r0mQmlc+lkQgmmlL4k1mg0rdga6mZhjiJrr/QfYzlUQoiJ2uxZeQUZIbU1r7+FVDI1Ejg2GVb8xhbtsWnb9e1VgtPGTNYHw3j3nvAE4VfCAx44lnWUM259VzlAMU7dIC7OuaZW3AGneW/gbdB0ZcwL7hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 13:49:14 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 13:49:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Date: Tue, 12 Mar 2024 09:49:12 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <22309FE2-8F8F-44B3-BABF-0227624F38C4@nvidia.com>
In-Reply-To: <081dc7bb-ae60-4a38-b9c8-560280cf5cf8@linux.alibaba.com>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <081dc7bb-ae60-4a38-b9c8-560280cf5cf8@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C6E98530-D19E-4F73-8B86-E900CB7DE6DC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:91::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a0a544-77f2-4e00-9a6d-08dc429b343d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YiQsaAOXOqFwFxhIgZ3swHSFREVmSnHIIW9Lui7exAkVJ3IF+175k3Xnwky3GfUV/fwpucxljTkz/fz3avQzTTeqJw2J+8BEAZht1/S4a5MzeRWOGTFkNh1m2gUyTmDoA8ceCewudtWMhdkpElvcWZk9p08KoXnR/t5uF+JhfoByy8lWdjPeasp+pXLg4XJbWt2H8s3Mc/YERZjfbV1/wvy9m+JMsN7KvdR2NFu0pEIMXk3949yF3xFGxHwoIMeuOjpQjr/5y8pvchCghmjoXc4XOsVVTLVa3lA1x+4Dc7jtUb8QmtGAnVtLqyQ5DsJV6brJUB6XFMZephIhSh7HRHhwNlhcJaiLu5HURkYTejWGvhr3QMwWlkdSDhviePebscKEyTRdhpdd5SRwNI1+S28LwFubPjkIk8ADz1IXRTL/rGEMhI+m1kZTZGIoTwotszfP8qF/V/4RERNU57k+NQpMyY3CAoeGZH6Vj97twLfXFpynPGN3kk2YolXv/ErP/51O8zT06j+hRTVoxJoIEHHUUHKiI39T+wiJ4mjQ5z3gU6ggYZb4B4QzNKCG7NfNB4uHngi5Zs5N4uzGiwKBM7D6t6PF3I5akn9bWI/c39H7JReFufcU3uTKtW3QMSz+VK0ViKhatvq7gKDK/fQ/G7de9vShQezngPljv6xzDEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REgZDYASPNQ3m4B82/1H0O3w+xmQrqE0/4kqT0JYF2IgLVZl9k1CX5DhReiK?=
 =?us-ascii?Q?v+FeyH5ZuNpMfEwNxQtfS1cqDHz4ccHPR49CdEwlM8savKIOfwsSMJJ9eBte?=
 =?us-ascii?Q?jIkJqTY7Xe+SoWJF9dG0yGQfubNAqhmmDa+UqXF9jAZS6OkR071Zu5clA4ei?=
 =?us-ascii?Q?u+24OXCve5maT5uwmIhzIcH5/EEvtK3hRCe2rvRLc5y9065NMNhlXOIgEtQl?=
 =?us-ascii?Q?r3vZBqJYObTptd26Gdj+3tYx4s1Tc136QYjUuNi0HCAjaSdUkABr0c3tpizo?=
 =?us-ascii?Q?XIYCgFlwdA2vBJHyvnNlKUc8m1NQL6D5WS7ftopM/yovyf3WRCRA+NNvku+U?=
 =?us-ascii?Q?p0aASxFv72fLEEBHRPrljcs/kmxlJfMq9TSzIzy1XtGdqfpjKcYOLmXeWhMb?=
 =?us-ascii?Q?FEIS8O+aLaF4DWW1hv79vhk2UviXpMN05FQfg2+4H2SKKwKFkOURBEDvZbOy?=
 =?us-ascii?Q?u7XCyVbWzSbi35wDvfWKOCPGxOO1TECamXIYTa5h+mYnVxZqvhY/LT7wuqjI?=
 =?us-ascii?Q?HapoYnedBMelAOBDAKUILOunwXjvcOns7moV6XuLg3p5WifQrc4zYq2+o9Mz?=
 =?us-ascii?Q?bwQMHleKQIuXZCQIhHl6ZPB3FcZKJSdnixQDYv46gpwVrr6EYvDG9G5xH7z9?=
 =?us-ascii?Q?41E5zbI3NnNouysP/d8g0zkEALcjpYS8GkStsdh/8nUuFDGDFeMdXXyZbYWl?=
 =?us-ascii?Q?/6bOltNNsDdHI7iYdjbDDV/cbMPLFi8Ibbgq16ddHCrCiAohO3mUHtYD0YB4?=
 =?us-ascii?Q?UWJn3CdK+YuAHfvggI8OXTNiNbtquUMZh5sQ2w+qOUfy2srG5sKa4q2PwVh0?=
 =?us-ascii?Q?8wySwfCOID+qyZNUicTUj/cTCSqV6XBcstH7jt9MqqFOIcyr6vhBz8Zx6/AZ?=
 =?us-ascii?Q?XIb3LA1K01qpP+ito8vtst0l9KLNfnlHprv4lTyfkhm3z0G/iX36e4XluHGc?=
 =?us-ascii?Q?vNyZtZHFB2TXyDZv4/wTTp/SoFCDg+Ooh19Ow506YkFKol6A43mWoY7Mm2Ki?=
 =?us-ascii?Q?F8GzZv5tr2ryd6WLFTm4i1qIe4Y1euWnW3vZsfEy/LACekbuiaX2TrhKzv8N?=
 =?us-ascii?Q?6FMe5dEIb6JTrS9hmpAt3kDYpYzMnsn7dGbc3UzCKDRaY/Pb+QppTClqT0YU?=
 =?us-ascii?Q?iKF0pHJGB60V9l0LsoUA66Yby+XgkGcEWeZgFvzy11reS+UvFFQLPukgUbG1?=
 =?us-ascii?Q?hdeYZqylWNifgkhs+gb2WkcNt4FsMh1N8bxQP0DAHronN/rKrae7jfj6MZ0q?=
 =?us-ascii?Q?JdYT2nJt/OjTEssL3TQ7VryD2fSBOVcGf6BMk8TuuMPPRfPWE97FQIo82yyc?=
 =?us-ascii?Q?my4xMsOJL2hLJGBdWnObXRIkqiAPXdhT41kq8Why0SsSCSy1Ejb+hESe9Gao?=
 =?us-ascii?Q?iXDL3XGsaGHQhLn5WMkiAfhydO+a/0FmUhh4JHjwl1g8bwtaGRz7cOGyMax5?=
 =?us-ascii?Q?YzFuShqofJaNgFMidpYtbW0LdWx0wfrAp3O9u7MHmMeRLMqfp5fahvu5odOd?=
 =?us-ascii?Q?AdNWHmWE/POzoKpSB4VtI3RJZbgOTJKS88Ceoz24s/94b6B5Aaby3cFYIdWh?=
 =?us-ascii?Q?dw7lc48+kLYghS+wmHg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a0a544-77f2-4e00-9a6d-08dc429b343d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:49:14.4735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQeVSe863tSfS3WS7dJlOrMJjzwwXhRiRlRM9QsUl/dwbGLGZ1VT8nexqJhVu2V0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

--=_MailMate_C6E98530-D19E-4F73-8B86-E900CB7DE6DC_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Mar 2024, at 3:27, Baolin Wang wrote:

> On 2024/3/12 03:58, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")=

>> did not check if a THP is on deferred split list before migration, thu=
s,
>> the destination THP is never put on deferred split list even if the so=
urce
>> THP might be. The opportunity of reclaiming free pages in a partially
>> mapped THP during deferred list scanning is lost, but no other harmful=

>> consequence is present[1]. Checking source folio deferred split list
>> status before page unmapped and add destination folio to the list if
>> source was after migration.
>>
>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C=
817C@nvidia.com/
>>
>>  From v1:
>> 1. Used dst to get correct deferred split list after migration
>>     (per Ryan Roberts).
>>
>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/huge_memory.c | 22 ----------------------
>>   mm/internal.h    | 23 +++++++++++++++++++++++
>>   mm/migrate.c     | 26 +++++++++++++++++++++++++-
>>   3 files changed, 48 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9859aa4f7553..c6d4d0cdf4b3 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area=
_struct *vma)
>>   	return pmd;
>>   }
>>  -#ifdef CONFIG_MEMCG
>> -static inline
>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> -{
>> -	struct mem_cgroup *memcg =3D folio_memcg(folio);
>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> -
>> -	if (memcg)
>> -		return &memcg->deferred_split_queue;
>> -	else
>> -		return &pgdat->deferred_split_queue;
>> -}
>> -#else
>> -static inline
>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> -{
>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> -
>> -	return &pgdat->deferred_split_queue;
>> -}
>> -#endif
>> -
>>   void folio_prep_large_rmappable(struct folio *folio)
>>   {
>>   	if (!folio || !folio_test_large(folio))
>> diff --git a/mm/internal.h b/mm/internal.h
>> index d1c69119b24f..8fa36e84463a 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_ar=
ea_struct *vma,
>>   				   unsigned long addr, pmd_t *pmd,
>>   				   unsigned int flags);
>>  +#ifdef CONFIG_MEMCG
>> +static inline
>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> +{
>> +	struct mem_cgroup *memcg =3D folio_memcg(folio);
>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> +
>> +	if (memcg)
>> +		return &memcg->deferred_split_queue;
>> +	else
>> +		return &pgdat->deferred_split_queue;
>> +}
>> +#else
>> +static inline
>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> +{
>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> +
>> +	return &pgdat->deferred_split_queue;
>> +}
>> +#endif
>> +
>> +
>>   /*
>>    * mm/mmap.c
>>    */
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 73a052a382f1..591e65658535 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/pagemap.h>
>>   #include <linux/buffer_head.h>
>>   #include <linux/mm_inline.h>
>> +#include <linux/mmzone.h>
>>   #include <linux/nsproxy.h>
>>   #include <linux/ksm.h>
>>   #include <linux/rmap.h>
>> @@ -1037,7 +1038,10 @@ static int move_to_new_folio(struct folio *dst,=
 struct folio *src,
>>   enum {
>>   	PAGE_WAS_MAPPED =3D BIT(0),
>>   	PAGE_WAS_MLOCKED =3D BIT(1),
>> -	PAGE_OLD_STATES =3D PAGE_WAS_MAPPED | PAGE_WAS_MLOCKED,
>> +	PAGE_WAS_ON_DEFERRED_LIST =3D BIT(2),
>> +	PAGE_OLD_STATES =3D PAGE_WAS_MAPPED |
>> +			  PAGE_WAS_MLOCKED |
>> +			  PAGE_WAS_ON_DEFERRED_LIST,
>>   };
>>    static void __migrate_folio_record(struct folio *dst,
>> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_=
new_folio,
>>   		folio_lock(src);
>>   	}
>>   	locked =3D true;
>> +	if (folio_test_large_rmappable(src) &&
>
> IMO, you should check folio_test_large() before calling folio_test_larg=
e_rmappable(), since the PG_large_rmappable flag is stored in the first t=
ail page.

You are right. Ryan also pointed this out in another email. Will fix. Tha=
nks.


--
Best Regards,
Yan, Zi

--=_MailMate_C6E98530-D19E-4F73-8B86-E900CB7DE6DC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXwXVgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU96wP/iOjz6/bs6sbMK8N6EvL0NaQzKEWz6tKwOHf
8vBKahm9cb+4xM+5H0fBd0bhyX1czCfnxIezLKygryuvmPVjDYNObRkNhJ2srKU2
cyn+mhJVkc2MMkwia9eo+yNVq5WQi20HT9oKeJSmYGa/yicYxDa8eVcPghRUrGhi
yiEougZmX6911MZEo7rD42t7JaLNCeWkGdecWbe6ee3GtHmJEf3aqI9wrtxjhSdN
Conyq+AOqiX/APza5+lomm0mapzBKZnvST5akFrbWJdIQdAnb6/pUwRmgbhOmpl8
UWanMxeevz81EBFtLSIDrPzEESDs1nKpAXJf3fu+B1AHkK2sLuXIGAUJmrQMr2HK
VbQ8KKU0JZsMRjpUrIpBzpg3fP0kD7SCJl0PaLZ+OAjY3gj0xvB92usqePGs+lOU
ZON8Hiidx8bVCGnQJsk5ExAOSmuxm41nfFTSxrkTAJBZKoI9MkjksEMkCg5TgtGC
lxVEPiKWQtmv+h9YWblR2eLjuyHAl8St5UtXIc1s2U6r8MM1rD/BWAi9ZOohhVvm
Cz8fQSMAhS/YC/8NzVxQT8ji7tthhKy7LsCUshuCOJyU6Fu0bkWr92Nl5TWoIdJ2
OUVcnESFxsL5ujGdIJRWlBqXJW6uNMX8fMqOJNg/doqA2lbZOTYV9H2KApw7kVD5
6yh3RXIt
=qpmX
-----END PGP SIGNATURE-----

--=_MailMate_C6E98530-D19E-4F73-8B86-E900CB7DE6DC_=--

