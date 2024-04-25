Return-Path: <linux-kernel+bounces-158782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34FA8B24DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA66E28D0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879CA14AD02;
	Thu, 25 Apr 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvNux0f2"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB314A638
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058208; cv=fail; b=XgnRngAxMr94qAlBqN8rwvzg+PHQoL943JkXipP8JdaM8mZkwYEevXhI3zaL4lS5dUgjaa/S7c/QOwfgZX1QJR9u8i2VEsZkN7Ay0JQvMljF6gwRdHKmNqubhEla3OZZwz08yGYPgPMAMRBolxMg3rMPfr7ESZoNjnu/gjtujrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058208; c=relaxed/simple;
	bh=a8Teigtno+BU1RlpoDlHvRrv63c0jmlK8DwaYTvxvks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpcedgHG7niUz3lZZnmnjEKc6kqQn4nyAvQoeKrYVk4CH9LpfmTuN39Gj2iCze2uoVSZyzAha11OxeYTMhx3OmoGedZzH2LHEbG3wDnso521icIIWiNo6lr3UC3LsaPGWxla9bAo6J4SlDnWVO3iZjjaP29UW46USKZXBz94OGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvNux0f2; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJFiNTgQ8zykWLmiUlb609fKjiJlvaMMahh/K2Ra7Sml8JERihm8TQGY0omPaWTwk+5K2QYA5gJGiT6057KNbb3Ddrh4W0YIXlDpGCQKQ0/yTC75MYRSQ//OETmIha/SY3UZGTo1UIDDQEKPK6E6hD+ptynJ993d9y/Yua0DHICCNMuL/JQ9zEy92PvFuOy8RMmCMPgivpP/HoucBPEGbI747w6L3ey9BDP9ZrxiEdk0RgDWss5Dyc+1LHJDoWBVkiPh2ceCGaagPt/3ebV0cWL/7bqctCNoGHdculNG3nXmngazkiLaJdaU/j3ugPIlA4OOYyq29RLBDyhpBh1gZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8Teigtno+BU1RlpoDlHvRrv63c0jmlK8DwaYTvxvks=;
 b=DXh6utcJDWILEUzqs8s19/RLUan71Dl11xhEoN7uUf+whVtGhQKM/RC02yuTqdpDvRY0L9vy6dg7r5h3pHk7sGPh5jzy3LqP4dxlGbJsiE50SXagr6ZRQ45Xn0sDLudbpXGIOAjNOhgsSJuT2qX4W1MNiDaFsGGaIhK6rgarLpIx/Qp9U1L8dR27O+rVjIZb681XsTLNTvmOFIexVcyhKL31fwO4wN65s+oOqQdpSJbxlpOCXF7+PBEnpQ7oZq2uNl4KBNc9M2Htlnh8p1Ara/gWx2I0Fmurr1h4VGrMkRWSCteRGT2hRT56hUw6B6kk5/wuirqaX/B6ZhS4BM2fvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8Teigtno+BU1RlpoDlHvRrv63c0jmlK8DwaYTvxvks=;
 b=nvNux0f2xVYYq2N6IpP6Zqy7t6b9d3+kzHFRHWd9rcx8/bOsdUOV5NFqQj416nwQZhg/A8ln4pWTlWSH7sBxOuVrioTd0lxH4kCY8UValfa2r3Z9kd2nW5NVpUEV4fHC5mXrs+PxtqsCC93VSfyDyPWK2yK+KGe9sj4B2cVK0FBZ8lN+CQxyUGC9GbFnwaS7+3sVDgdn/68gLlw8SGrcmfzad1WJdF3VcQwhw35mbCFo7xMNzL02CJ43a2rHbTLsXJgHtmiOBKiwszKzIO4NUHhmwOxZBP9dWEI3SBIw8mSjqmeR5HMx8k8M+uYzcB9F6trMFrQ1X8FNtsW3dZuCPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 15:16:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 15:16:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Thu, 25 Apr 2024 11:16:33 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <2586B1FF-91EF-41C2-AD98-7EF699716CAB@nvidia.com>
In-Reply-To: <e1e3d368-4861-470f-b7ca-b222712adef5@redhat.com>
References: <20240424224614.477221-1-zi.yan@sent.com>
 <a5426fa6-442a-453f-a234-63d89675ea79@redhat.com>
 <8BBD1B75-135D-42AA-8937-53B259803AA7@nvidia.com>
 <e1e3d368-4861-470f-b7ca-b222712adef5@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8878B8EE-4BC3-4587-A43A-51F5B64E621C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:208:239::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b67a1d-abbb-4488-7111-08dc653ab2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWIA4WaZ9Ybe3WjlD07Uz2kZQKfoJs56uvc6oiLrdf6uZtzjyPrE+tktMu6I?=
 =?us-ascii?Q?ry1hypW9GnkNdCq4GCFuQBKg12PhVn+war8MM1fBnR+/ICy5aDYsWm81LT2e?=
 =?us-ascii?Q?LrmEpapPWWa+89E4f1NuF2GYrPXwugmiUYmWm946DmJNMWh1DHVTgjmfkkUu?=
 =?us-ascii?Q?NpSDgZ01dxdXgMjiZ5FeR02d2UBsLq4KwCXr4jO45qMks/tiZPVMkLJrH0d+?=
 =?us-ascii?Q?RRkRiLfiAcuSlivQjcaDDKqMvwVXBgT3wztLb27Tp7E6M80CZj3Diw1sLOBA?=
 =?us-ascii?Q?RW/pveRxSUbZ0ojsqjrjnF/YB6jRIZEdACRXLPiHuXYH62uWKkFOk+BHkTLI?=
 =?us-ascii?Q?mCqY7kJYADXjHOg1UgwlWQztnBUcWSb8+wAnZhVa9+YHJBTWyiW7zDV/N0S8?=
 =?us-ascii?Q?iXbgOPKKZQhjj7vxp8u2YHsoCXS6yqRnKzhWpOC27mdrcjfFncVU/7rtlmVF?=
 =?us-ascii?Q?cKx5wOu0cGfbGXfhwLXZXMoRLgy8QLJtHSa6UrEJd+9c4R1RkgbCg2RQBsap?=
 =?us-ascii?Q?r67oAMLtSmv0mTFWl3e55UZoquBH9uMMUOGOCSCY8R5kxKEgiNjpYnoBu4BT?=
 =?us-ascii?Q?Jki3pzuXY5zQ7OX0n3EItINzM2sMfEosMgjQ8qbmasMyxmsqtfj8P7+1E7fS?=
 =?us-ascii?Q?cAtoH+04Q6EaklczhR6ZJuOPADPkWZBLdkVIfkKJXE9ow2PasfTxL5LHvfKF?=
 =?us-ascii?Q?GULnM99RaFguZnjPg/qzDUR/WOQUhSO7cWNWOX+SiHQMtBAoIw3bJE6VaMXN?=
 =?us-ascii?Q?wPul2wtFItFGMMiqDr3VHaABVEAH1s9yp+f4LQ71f0h8zwovwZyPW6HKiN0H?=
 =?us-ascii?Q?kk9tuqSnMACEJSR1dEbgIeX0NnbPhtFWG3U76zeKp3V4ykJZx2qhJ7Ntivxu?=
 =?us-ascii?Q?PsFaDE0eCruDErMSvN0nr8Gm6/atgGFmePRGqC7fjuVMmM57hilebycxQ86m?=
 =?us-ascii?Q?6VKNQ/iJXcsTPCwwDskFiI/kVG1q7g6Wv5pda4w8+BTq5Q5u7aUuoHQaTdFw?=
 =?us-ascii?Q?i5wxFlXwnK5HNAlHRTcWHmnt1BvF1hB9JrFTHyq8q+zCrtnIfoQ5cU86wkG+?=
 =?us-ascii?Q?MEvgro2+RRkzeP+DY+yM0hHR2GFgHhcUly9rbnKt8VztULxAuu1XZbyObnni?=
 =?us-ascii?Q?z2c94iXyn0m6qaxwV8FN/CCPv1NQ7uO0trseN5tZzXhHwPLPZLsDkhTiMpHl?=
 =?us-ascii?Q?ODRMNuDQzrwUmLwFhomj95+LsEbCClty/0giLckszZSaNVpKcfGRtYqFEPpz?=
 =?us-ascii?Q?DplJ03lcO+fkL4aKkPQtl0dAvgctrB7XqX4mOK5Bzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RFO84OVbGqV42XLD57FDZlHYTBI++DXGYlQb8A5KolXMKxP7HDgAOmTAtPJa?=
 =?us-ascii?Q?gyneqI8IIHt+NgvCYw3iQTy3aXhe8CIwdojAYx/Y2pnJCeNJvMISEEF+szcz?=
 =?us-ascii?Q?uRhMwet3kNbWXC73lYsvc+xmt2NKyFuIJ/PAPyeIGySa33ML7cYHNsezDrJe?=
 =?us-ascii?Q?531Q75GMFQ3ma9GSWNwss5vClACHsVMBw9e8jPRuUtYQygaMN60Ct7y1Y0XD?=
 =?us-ascii?Q?2vrgQdytEBc8tB+nqnqsB1P58+2vzFvNtpgPRXzi0nyw5p0stfK0ipg+9dAh?=
 =?us-ascii?Q?s0HTaQptWDw65AqXi8dn63Fc+8/64Is03/rNCuIj8upphUTT7Z/ek7QWamrJ?=
 =?us-ascii?Q?wXbFzQqCTWhehqjRRjjCsL62cVRB9twuD5+nnRVHYhNo4Dxl5ljHzUolgKco?=
 =?us-ascii?Q?W7Ht/whEdRkSaecj5Ta3SDOz90xYYjhhBJPmWTYfq2wFDRjuoD/Qjc5gMmba?=
 =?us-ascii?Q?/k11uvioAZyIYcSp9jAJjqL8Pcqd8k+EfzxrHqlyoswZeHxQkqKCfkUVYrCs?=
 =?us-ascii?Q?dZ1RpiIw6yHTH7c6WgQB3SJVGYhfAL+lTB/f5uK+OWap1atyAPoR/bPjzOsf?=
 =?us-ascii?Q?GZEL9Q3GAvILIpZQesl7Ysy5BGicyVJtgORrHGmVECE0T/C34tDikC42GGK0?=
 =?us-ascii?Q?gUdpjGnA46anyyubKhgq7mXgJYI7C1IRYfXUCYOPnltHGNH9o5PZrk3Y/tfb?=
 =?us-ascii?Q?zgxppGN/kiWvKQsg00et9CR2Q2Ny+Fe/M5iNMPTW/HrR38lcy/GoaSBg4Ht2?=
 =?us-ascii?Q?/tysUY37W/TjDHJxWdhcZiT/9fpFItztCYxiHI6+1BDBCYy/Dpc4HMDRMlG3?=
 =?us-ascii?Q?uNLM8j8rPNKQxg4wKkbodiHq9Zd2VWgHVWCKMxCKTSCxdP7BS4EVvxr+39il?=
 =?us-ascii?Q?v7qRvw9EfRf4afzyfjfOl/zMdCQq2tPZm53DKHftc08ycjWyUjJazxDlICay?=
 =?us-ascii?Q?n08jntpwG1KeHkEiCoB6WB4/vZfTiRKudYnCDKi9ftygjFwD6fnRFZyLdTSe?=
 =?us-ascii?Q?NJuSkHmL3ZznqClBk6q42s0EwMedxXek9+RB228TwqLTbzeQIHfZY/9rouBT?=
 =?us-ascii?Q?PmPOceKdAWI9pRds4uXAZwM/ASdlzac8JyVfygpQBZmWCHpcRNZGKdkQp/Oz?=
 =?us-ascii?Q?amH24pgygEMcFT17qDP/1L5/QT8WRNiSOVyoH1Q/hixRm++7+fVogpbjcyBL?=
 =?us-ascii?Q?HkQsTWCsClBWaA16h2PQ+DSiu/m/zyRkp0rvjF8tX+SSuagU3a7/G6YN+JII?=
 =?us-ascii?Q?+vi2Qj2pWgnIAZORcI6oFl0WlCh3YGz9lKUdyDpCOz4bCbpRMd//jyfqvPeN?=
 =?us-ascii?Q?mBGQXVChvsEBQxy8uySuTd0NrvVNHySvmnnZx4CKdna2semETDBY+0BjJh2S?=
 =?us-ascii?Q?P2Q1ns21Wiq1zd7KlYCQml7dxd7ipqqlPdJ9xnoNIrY5MH6XKxutykwJBAZE?=
 =?us-ascii?Q?dxKKKhV36IOakeyywUh3q6eNfm2GODhwSvUTBgt/YySTWz/toXaQlCVTXmfd?=
 =?us-ascii?Q?BBMlqlp0/3LY3baeNUhUI3eeDUVOoRofoHJsX7IEDgQqpZSiPI6yq/WZpIeK?=
 =?us-ascii?Q?ddeEfUHCgGm+XvOrYe0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b67a1d-abbb-4488-7111-08dc653ab2b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:16:36.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC4Wy56atFaNuQdOHPQ8Xa7+DHgzva4J3nQme1moI05KhzDxSk33PegDTBM+bW6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051

--=_MailMate_8878B8EE-4BC3-4587-A43A-51F5B64E621C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2024, at 11:15, David Hildenbrand wrote:

> On 25.04.24 16:53, Zi Yan wrote:
>> On 25 Apr 2024, at 3:19, David Hildenbrand wrote:
>>
>>> On 25.04.24 00:46, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
>>>> if any page in a folio loses its final mapping. It is possible that
>>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>>> to deferred split list at all. Fix it by checking folio->_nr_pages_m=
apped
>>>> before adding a folio to deferred split list. If the folio is alread=
y
>>>> on the deferred split list, it will be skipped. This issue applies t=
o
>>>> both PTE-mapped THP and mTHP.
>>>>
>>>> Commit 98046944a159 ("mm: huge_memory: add the missing
>>>> folio_test_pmd_mappable() for THP split statistics") tried to exclud=
e
>>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does =
not
>>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was sti=
ll
>>>
>>> Once again: your patch won't fix it either.
>>>
>>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,=

>>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable(=
).
>>>> However, this miscount was present even earlier due to implementatio=
n,
>>>> since PTEs are unmapped individually and first PTE unmapping adds th=
e THP
>>>> into the deferred split list.
>>>
>>> It will still be present. Just less frequently.
>>
>> OK. Let me reread the email exchanges between you and Yang and clarify=

>> the details in the commit log.
>
> Likely something like:
>
> --
> In __folio_remove_rmap(), a large folio is added to deferred split list=

> if any page in a folio loses its final mapping. But, it is possible tha=
t
> the folio is now fully unmapped and adding it to the deferred split lis=
t is unnecessary.
>
> For PMD-mapped THPs, that was not really an issue, because removing the=
 last PMD mapping in the absence of PTE mappings would not have added the=
 folio to the deferred split queue.
>
> However, for PTE-mapped THPs, which are now more prominent due to mTHP,=
 we will always end up adding them to the deferred split queue.
>
> One side effect of this is that we will frequently increase the THP_DEF=
ERRED_SPLIT_PAGE stat for PTE-mapped THP, making it look like we frequent=
ly get many partially mapped folios -- although we are simply
> unmapping the whole thing stepwise.
>
> Core-mm will now try batch-unmapping consecutive PTEs of PTE-mapped THP=
s where possible. If we're lucky, we unmap the whole thing in one go and =
can avoid adding the folio to the deferred split queue, reducing the THP_=
DEFERRED_SPLIT_PAGE noise.
>
> But there will still be noise when we cannot batch-unmap a complete PTE=
-mapped folio in one go -- or where this type of batching is not implemen=
ted yet.
> --
>
> Feel free to reuse what you consider reasonable.

Sure. Thank you a lot for drafting it!

--
Best Regards,
Yan, Zi

--=_MailMate_8878B8EE-4BC3-4587-A43A-51F5B64E621C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYqc9IPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUme8P/jtVbLpaTivbJaO3O7dHNq0Tu/1N28oJzW4J
SJFubeu7wRo2ifTiWBxr1psaqRNBEwJkSRpLN9u7uzVuBKPRTdZ1z2sMNdK85Nx/
ESNHLkMZx2ANF6NXxcT23iYAhvnskG+KBT5ZnrE4u0E3fXsXj3pjoWCyavUUxXtT
/Ys/1pJK955crI/ICd+VP4I6GuGq1lLzWL1pBCFPXwsWtUGy8POLbfPjDLA/5Nk+
rWPKQ3j/24NOsWcxpUCM/avBZuegysSU7ob6HQH3g2+DNZiHiipZ19RZafEM6/sg
0BMvgcYY4JGAb9rbSzGXLVwYiFl3sA1+V48q/Kx3R8ItsbmHKqgTbdUpL8TArqHN
IbuH0Tv6F0iWFQ+6vGtBxw/XImKXQzzvKM3W5ZHAxtaUgONeXQnYURkM9K/+vjHK
8qwJ4c/T57wavugMgEJXVjtftwlNu8GaZ4pEXMPdrkaLJR1dJgVKBrtGdiLv/mGq
vJHQlQentH34/12prNRCWqxA2vR0MNQwWf5U1gzPVsWkiGvmVaeYHPwVjKHKifBv
LkVefIlpcZnICxe7RmWKXhRPZjyUogmDvHMRPviETg7kANNXdF12xCzk4E4ELpTT
JRlbT+gkP/MHDa6qr8L2oVhG3XPDz0s97Ag9ko5CaG15t3niq/PJRASKJvNsUP2c
Qst+FF1R
=1uvL
-----END PGP SIGNATURE-----

--=_MailMate_8878B8EE-4BC3-4587-A43A-51F5B64E621C_=--

