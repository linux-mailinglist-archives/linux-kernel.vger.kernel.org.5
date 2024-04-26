Return-Path: <linux-kernel+bounces-160613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D38B4015
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501C11F238D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51488171B0;
	Fri, 26 Apr 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RU5UFBTh"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B313AF2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159250; cv=fail; b=kMAb9Lr2ENkwTcgxb9Fy8f/Np2jhFvTOnh1rL5N4Owv6xirCv1RBfF88Xw58vVk46yXYOv+2duPb7MWxoJAIcCa2Bhhg3YUZQdcPfWE+SJOzIUMLC96XEbqvyYiyoVULIC95ojgrbV4PR427VC51vgHXxCUsoLkV/Gn4CJogSTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159250; c=relaxed/simple;
	bh=3EBFoBBKwPykRc6Nh2JTFqxgIiWXU3772gcAV8i48YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WI8ErOPgzr2EqDu/9ABHF9jvsQVissttkwW60WkQHFkwzIGe1B+TrNSxYwnqFYYoxAONNPeS/+m3wTmDsX0TNdOVow6wKN95jS3QlMwGSfsqvVK4YDBy+jNxzKU0S/ZI/Kiv+ppzQzehLwh0SvO5ipWrxTwv1TfAudtyNBgLBl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RU5UFBTh; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/abgadrDAQvfiSutD6aHuSf/xZEpWS4NqvkUbPJAIPjn+aXrL1J3QihSpv9wHeGaopX4VE3kYbArtYIzp/SnccRzdOxWsez9qzWesJI7R9DBNVwTqZWeGG1T8MxlzztfX13AhJi+j3Bsxl/3YxM0BR40lo82VkZ/DFQpPOWETcrwx1sXD08xyvtFNs/9cRiGHezVnuwftPOT/ouj687vmQf63DJM3QXnL1MwpsD2DffAclNeIWHBRV3Aau/60ryago7EEtROjlY9B9Hy+drBhIyC2cZV0rFFRkqG75fjjgxTkmoQRJdZDz02hT3Hc0y+/2wEaRY/Ti7oxgJ+6th+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgLbCHXiRNj1kV8GnKKVRdjtWalDKsFoHVj3GmnbI+s=;
 b=OVmwRjffAvm2IZs+5bJyAnit8DggZ7+dc2xPInjdzqBfYXh59kOdk1j+30m//5+SfJMS9GoGNCxWLtBQ+9gIsI4bIynt9eFO1cMqvp8npznBsAUzchJsLA6KOIFuuxMXXTrp0TizhF0P7Wj/etCJjZe+nR/8hu8HdLIH02kxO18AjesCYforGbY2NRUIE6o0HHNrYMCeyuClOsx+EI0JbFWFND+DldPjhcU/nl84te9zrrK2hbHZnLXdPB2Wco81rDQvK0mPWkPTiEZP77pMKSh8Okb7agS8w6ZujfHbZPJr16YbUqrQTw9yrrW8OchbPs6F9qvOyazgWKZZfh+RHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgLbCHXiRNj1kV8GnKKVRdjtWalDKsFoHVj3GmnbI+s=;
 b=RU5UFBThzUEr3DFW1of+AYwiy93dlBTavR8UYcLojnpE6H6TMEg5AonWew5fFAV08WPASqy4PKSw3IjuJh29n6fDe/8BHadsisQQAmMteUTpKaMAGdO4ANWgXwihS8pjUjtUSKN60cjAbCPBAGD0lAaGX5h3IQouf7ul7zsk18lBF4XTJb7QAk9RxOKmRQou/qlhps/lyacpTFsagtfG/ZtXJiUSWKntB2nCTuqGXNYCvNWW/qfVpRPBVHN9Bsux6p8SznSA/wNqZAIJIAMtd8fwxTlqn77/E8Q809uLji6k1yL1f6cKAfpfKaQxJuBzTksiCSKY8Y8wA/eUzSOf8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 19:20:44 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 19:20:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 26 Apr 2024 15:20:42 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com>
In-Reply-To: <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
References: <20240426190253.541419-1-zi.yan@sent.com>
 <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_EE57114B-2562-4B4A-9940-991392B220CD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: aae879f5-6ca6-4847-91f1-08dc6625f854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMWebGrXpfmFjkuwSMWKAi6Uu/JXQnTdAAai1+6mjQKPbDU8fvtJfd2KoPCm?=
 =?us-ascii?Q?HALW4JHNrOaYaLDRvRoRixM1dcm3OE9atBSLvEq+K4rruRrD2FL5yigg/Sfi?=
 =?us-ascii?Q?+0le7WX3xRStn02mCd1o8wbEbPSRFaxoSsLxTnXU3z9Xnw3CSMA5upuAihxv?=
 =?us-ascii?Q?u/hzCLNDTrZpJ5saSX3t1ZIxTFVhjvAhR1iF74RfMDUpupH1N5EqVWOatGSj?=
 =?us-ascii?Q?hcpCAtE4TDZra4c2v2URD+hwGDSulZFPjtrmFnCG7OqKo2l0XEfpX7LiVTdv?=
 =?us-ascii?Q?anyWj2IV11llVsa9hFDNDvx382PHwB7Nsn2QoiPnNiBVpDCZ4n+te4wMVxYH?=
 =?us-ascii?Q?BX03nBbgRY/hsFYMT+a2l+bgIF/w5d2Y42VtPC6eKfmuShbsrYLy69NCaeF+?=
 =?us-ascii?Q?aDSnyXg1bPSh+7+I8c5Ywgwa8rXqiOvNbs5/T2Cz7gZbSVJ8nLnMUEvjZWwZ?=
 =?us-ascii?Q?SRunQYRLGAEmv0a5eiMXu0EeBlhtBvQxHF0oSmlhHkhP03K+NB837zIGFtRq?=
 =?us-ascii?Q?RLJUEQ5S/PFgU66ABzeOmVErENmCHMrc3mQ+TmR62VKc9c7eVy8MpN0tNQaQ?=
 =?us-ascii?Q?RIBT/pcuimottzZqtdk0JWOA+PbOR7mscVPngCKi0B0vSJuFlJ3d/m07ym7H?=
 =?us-ascii?Q?THfg6hy1Zv1rQs8NxOPe5ugLdoeywZlLuSTAPdNU0m69PuqD+2RQ+axB8qq1?=
 =?us-ascii?Q?pe5O5nvRAysUm8MQSnlIBPdxT5cLindFMVZ/lfGJBHmaTF5ZtmGA0raas9ET?=
 =?us-ascii?Q?is5KFL3bqij+mx6z17Wa3W9dprDjARiQd8RuLuNos9bfFs+FsvD2OasnrI/B?=
 =?us-ascii?Q?tKA1FHX53ZzZYftAKINOOYwf359wOp2hiUtpSZhLeIqi2oVQhecgwBoAesnf?=
 =?us-ascii?Q?pztJUrdTQBT8MnDeQ7VymTKvJQ5VEFKYYmPKVzStjjCh2ONXgtgt4Cfn4RD9?=
 =?us-ascii?Q?TCpIJiMH1SZNXRXZIz1cB+TEf5w0aQRQ2WyLxnIrO88epXcqsJnad+W4L0I2?=
 =?us-ascii?Q?ApTM/SYF4HZcGIt7OdguWtFTNdtSZJCU31CUQVTbQQGQNBx7gPXwhfc/Yj5G?=
 =?us-ascii?Q?AI4ijSqv1l5mkr+b+NqlAMjYZWiW9iPOOMUpBgWjVMnj+xZ3xFTCQ6My9rYU?=
 =?us-ascii?Q?GvpzFEx9GkEJUfCmdvbAGmMqNORp5VGZ7t6yKhNHiNRsG0KuiQ1bf76Se97W?=
 =?us-ascii?Q?LALbjlfWUrf8ESJfY9qDN/UVcKpfkQ1nO6uQ+jipVTG7r7NysiDZ/CjnTrh7?=
 =?us-ascii?Q?uiFRL4PGve4eJhzezTYK/9gXtvNT6pRcOtoxYeWPaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9qcEQ+OKbvsKNl97xBujVaMer39OX9cyK5EHVm4HCIagwyE3L/hlg1Wh8FBo?=
 =?us-ascii?Q?P+XpR/4hgM45fNTSs0EAbrhuCKCJCoiktiwqi2bXHx+3Ri5OuU22Qiw42dN3?=
 =?us-ascii?Q?aWFTKxJFnvInzcNzCQNAqp7P4xmRnavsy8nEEJKPM9pjJ7EpHKV7bY18WOAl?=
 =?us-ascii?Q?F3+8t1gftrYXDvQ9PElVb7k4Ahb5JGc/t34UN4DAxSQ6OajL9TACeBTEqCyG?=
 =?us-ascii?Q?oB6RECcNmXbvBOR6YxxGphgslOL3hM1K0jIWoqMa7W975yHHLo0/rv+DBtgg?=
 =?us-ascii?Q?eAIJoCyDCZgI/JKJUjfMOWrEC7lEU4EINq3+S96CNlqIqHC5aJf5sRdwDR1b?=
 =?us-ascii?Q?DU7vZCu7O2rrvYUf8Ktim+in2dulBFDatcfKCdy8gnY5BGkN/ARtHa8UqcR+?=
 =?us-ascii?Q?yVe+0T+eCBeyZCfKNcWVZMwLJnfdoM/hlTcuk5s2NY3AuYP77Z1IeOErrjlI?=
 =?us-ascii?Q?iU9yEhrt4oUaiWOkmN7iee+UD0bjkzwLrVaq0KsaU4AstsOGou++ytG8ykNS?=
 =?us-ascii?Q?M4C4qwl3j38oag63yx9Qm1SGksXIwOwISJb04i/WZFepDSdHHCCylHOM7hqt?=
 =?us-ascii?Q?Z+KCioz6oZxjhkoMQL9Z6oZkdmoY419FVZPgBSii7Z8QlXr2gdnApQEAeO5M?=
 =?us-ascii?Q?OBniKdOC6ubYVRQ0wZAupCaDf5QIQOee4EiK1fcbt7GWh7mjlgIXfHyQNgl8?=
 =?us-ascii?Q?osJZYkqZ/ehUg+NlpaF2hd9sB/NDlx7ABXZryR8jHqnoLaqEw7JiaozRCsLm?=
 =?us-ascii?Q?5dO+bnV13nDVQOrbgJY7HVYN2hpI06WhD7TIeAHoFPuYCy6QL/J3uv84LBWR?=
 =?us-ascii?Q?RYrbOtB2ZHe0pqFgBFvQSOSo7IrSnkj058IuTisGI2NLKkAJODuFV5Q29hGs?=
 =?us-ascii?Q?2e7JX53eQkzLqu5xBnwwi9mQP/OLEKc5F9okC2lI4E6HV3/cTYBOaO54i1h/?=
 =?us-ascii?Q?hrAQH/rFEnK2e5aighwtXk7ac6F0Ur0Cn8NPbNetr7EEPGg0Q6ze+aFzJXV5?=
 =?us-ascii?Q?yCF7aZk0Hoe+8wt8jfrjN2taz5YHU23GqhK7x+WdeDcwaIgNhvxTmmfKL+1L?=
 =?us-ascii?Q?sb7AFphK+vzxqaxfCkbtjYBxAE41GCh0PDVXh3HNHaCD0vuNWFR6RODmauTj?=
 =?us-ascii?Q?aN4FYqHrciMknRJ67tGqVC5uKGDnjz+QibH5QJKUjWtsBcA49vpwpNbwKcT0?=
 =?us-ascii?Q?WbX6wd4F7UsMLh0ecaEO8OvZb5drSA91uOQKuidyPEu65h5AtjwfXxQoHyDU?=
 =?us-ascii?Q?iokaE+GVQm8cCJdUOQbrbJRx9kJQVG06RQMhQI1bNOccrukh0FbmumMmsXGB?=
 =?us-ascii?Q?/oQ9lqrLIQrdSWDkRTjV8DNaLbdJ1fXoGmpmZyecA03tIzH87I2fyNtyq0hX?=
 =?us-ascii?Q?/luBjTlVPOuBlKBOz6QznFDXcaAP2Ba2CuZpFUWESi9zyKHrIDUlH4dxmA5d?=
 =?us-ascii?Q?M7Xbs/z5bLP0qAHgb6RWDaTQ8EIvY1BNkjuP8l6JXSv3OMrfdVCHpFuclDpS?=
 =?us-ascii?Q?pTiC3QcTfYUCVxM4U3oVn8vgrAbdwlYXoNPmjZGmdCP1uIpFMW/EXYQLSzcV?=
 =?us-ascii?Q?cGJVzLOmGd4GeoImKhw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae879f5-6ca6-4847-91f1-08dc6625f854
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 19:20:44.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuqptVtWJFPxOeZgAcKFUVVhYWLwPiXyUc4uQq5ckKJ++V4M36Qr+eOMGQVJp1z3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

--=_MailMate_EE57114B-2562-4B4A-9940-991392B220CD_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Apr 2024, at 15:08, David Hildenbrand wrote:

> On 26.04.24 21:02, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
>> if any page in a folio loses its final mapping. But it is possible tha=
t
>> the folio is fully unmapped and adding it to deferred split list is
>> unnecessary.
>>
>> For PMD-mapped THPs, that was not really an issue, because removing th=
e
>> last PMD mapping in the absence of PTE mappings would not have added t=
he
>> folio to the deferred split queue.
>>
>> However, for PTE-mapped THPs, which are now more prominent due to mTHP=
,
>> they are always added to the deferred split queue. One side effect
>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be=

>> unintentionally increased, making it look like there are many partiall=
y
>> mapped folios -- although the whole folio is fully unmapped stepwise.
>>
>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
>> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-map=
ped
>> folio is unmapped in one go and can avoid being added to deferred spli=
t
>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still=
 be
>> noise when we cannot batch-unmap a complete PTE-mapped folio in one go=

>> -- or where this type of batching is not implemented yet, e.g., migrat=
ion.
>>
>> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
>> to tell if the whole folio is unmapped. If the folio is already on
>> deferred split list, it will be skipped, too.
>>
>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still=

>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().=

>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/rmap.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2608c40dffad..a9bd64ebdd9a 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
>>   {
>>   	atomic_t *mapped =3D &folio->_nr_pages_mapped;
>>   	int last, nr =3D 0, nr_pmdmapped =3D 0;
>> +	bool partially_mapped =3D false;
>>   	enum node_stat_item idx;
>>    	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
>>   					nr++;
>>   			}
>>   		} while (page++, --nr_pages > 0);
>> +
>> +		partially_mapped =3D !!nr && !!atomic_read(mapped);
>
> Nit: The && should remove the need for both !!.

My impression was that !! is needed to convert from int to bool and I do
find "!!int && !!int" use in the kernel. If this is unnecessary, Andrew
can apply the fixup below. I can send a new version if it is really neede=
d.

diff --git a/mm/rmap.c b/mm/rmap.c
index a9bd64ebdd9a..c1fd5828409b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1517,7 +1517,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
                        }
                } while (page++, --nr_pages > 0);

-               partially_mapped =3D !!nr && !!atomic_read(mapped);
+               partially_mapped =3D nr && atomic_read(mapped);
                break;
        case RMAP_LEVEL_PMD:
                atomic_dec(&folio->_large_mapcount);

>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_EE57114B-2562-4B4A-9940-991392B220CD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYr/ooPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUDzUQAKT74HoLO9D1m0dcLjfukKG+28CxtXoLNVx+
6bw1Heqji1uE5Q9A9RaUbEMH2032/M5UE/0iOIJTqAuNpq/a7HKLwzpKipcedinG
pM/4Qc4SaulRatXA/+nTgRfrcMnm8gYIBpehh0rV7gLrWmaK13DLEt4t1SCfvZmA
RwzQzYyWhEDGfO5dV4lz66FeASCAAHb990gJ466WP4XYAJN1eHoPZvKzzcyCJUIf
n5tBEDwpmnE5vbodipdve/Ll9e3YitOBpx/QVL1l+K6FELkh7YISu57eJgFeYHJx
6jr8qt25NsZQEqgVhqLSp7inCOFso+1oFSHGK5YWGZ7ft3a/hv6OZPQmsm5qkisX
KoytMf8lzT8Uou2e22Eibym0PHbbkFktKNb13FHDGif6+KXm+AAdr0R6q0zlOnv/
4ELZNLx5Ey1nlJcBEFtcpojVHwwoyMY/xqalhkG0wfm77+uyPAgooNl/3MyJ6Trj
KuLCo9voBmhSnFXHoSHTfEtH9JzgYQJdyEM2FfjBo2A4332y1bWEyXDYqXAjp/Ys
w1MiuBn9UdHV/TD/2GCizVLkdj69GSBaPeykuC+lciFGlJ4s3dYFxnx+i80zpdcA
c+/gmAroNdwCk0jFtRCWmSsaaeSAzbUyv8tAtky8fDChYfW1f8gcB9DJFRrTwkRO
38FNRrjh
=qYAz
-----END PGP SIGNATURE-----

--=_MailMate_EE57114B-2562-4B4A-9940-991392B220CD_=--

