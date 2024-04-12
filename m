Return-Path: <linux-kernel+bounces-143423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC28A38B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967F7287044
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0815217D;
	Fri, 12 Apr 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="meX24XYz"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989904C629
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962759; cv=fail; b=CTpQL5qY2HX/eFioT4asGlAbUovkel8S8Y0DZAqeHhrFCIgY8bKn3w5eeWfxrRwAidIX7Gpm79y05HgWmongukjvMbbVNCx8HkMp9UfwOYfcUJSXPclNyr67EY4iohD2yc8QyHV/EYe6N7pa6OpkLexA5OrboskeOw0Dl173/PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962759; c=relaxed/simple;
	bh=BkhhOb1PU+DLILKEUqyj1iADk4Yf/OxAsJC3bEl8eJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5vnqCIkQi8BEt2ubsmhtzi9V+PSSZYalUPqlulQEwAnnULbPRpoD8UpDVAsUCfHfpr6uD7wjrBf71hTm2ABOk6KLXOS4p1OA8dHlP68LK9RAUpP94IsYPY04IW8u81uKwiDPla17LcvTmJNrhzv/6x9qSDG5XdmXayJHo1gzTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=meX24XYz; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mopmNbWa5P7NQ97doHovjTfzzhqAP2jpV1cbdm8Tf+/eUWJgtErYkMTrfPYCm4ZsG2rKYgfv8HrGJCKCeBdnx0yvn7VvbQG6taBc38977skrkYZOI7jBS8HMhOf3qWVlxLuPqmnb+A6/3wOTB/mSv6sGRHuenzz+PSpMhgHmYxH1FJQH03BIN61QbICxjS4j2K1FjbCtq33XgZWz/VsnAUaX0mYUt/H9tSeuGtKrZPY5qTCfpWBrUd9H+5Zt/2IxtY5orUX1gAVpyWR0+sUFlBTH0HvcGbFLEsWXk/7I7CALTm2aIq0dzU2FldUiSPPSc6Y5yapghGIKOEiLJkOwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cypcMMc7DT7ielj1Ua/mQbk7/usgY1aALztnXnFDX8k=;
 b=ESfI18SzYx8J3ZW0HTnLisgOj/dtvGTruQHh23CryIGozh87qLX4qA6gKrcVtSCZBL2oTZz7LWOOKgveOWbJ24vPW5R0N0e9vpadeHItit0fGrY2bnN//T0z2x+FJf6Or+vDCXlokfyiaAV6l2j5O3OkkKbCLS/bHtU4UNagKKVgnUVH5mdV95H8NEgvtfNLmIDAJduAvhdsLlPmOqRx6FKhc8Zt0NJ1/0nDhm++XDIVCqDoJQEYnRWwfDrEi7kjWXPXOUtMBMnx6j7fHsOI7HvLd2mlzOPRSz/YJQaTsvXjD56PRe6ydWbttnuNrwBcygYJNb048n2vjXuVphFMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cypcMMc7DT7ielj1Ua/mQbk7/usgY1aALztnXnFDX8k=;
 b=meX24XYzUhOlhtYBcB552WZMshvZhTgleOWUw0awxI9ZMXeAdkwzeHaXc95ZUbVg5iJGRi7tqdEWPy0cxL8g8IZbR2+VdCQdCYuG77Pmki9goWp7pBFz9nKMl+7vHUVeTLnVP9YMYMvvF739hMHJLFe8h2uq4hfkVMR32bvGEI7+dd+JV3lh1ViPV9HKd/Locc/vRKNpbEv/tTyX6JGRYJX5ow/ivXjfuofGG9NZHFVFRehgO289sfO7BrjqAhYbVFjjzIfVpWl4Z5Xt+vXjigTpjNd32oMQxkuWWErrqJhvvE9KcAvUv2+qpb7354T7Jv2pcSrxaDfmnSCWZgBimw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 22:59:14 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 22:59:14 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 12 Apr 2024 18:59:12 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <2BE605BB-F474-48E3-A54F-1E9371BF59E5@nvidia.com>
In-Reply-To: <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <2C698A64-268C-4E43-9EDE-6238B656A391@nvidia.com>
 <bc8effda-6ff4-458d-a3ee-0d6f25cd41e0@redhat.com>
 <BBA893A5-1463-482E-8475-384BAD1AC6FD@nvidia.com>
 <CAHbLzkrg7HpEf1_g4qpeGAR68dUKosSGihhnLRNcONnGVWdCJQ@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_38F5DF45-4531-4E6B-8DEC-9EBA48DAE181_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::9) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ea66ad-f10c-45ce-1b46-08dc5b442c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kXcH1hhySTDgYiuCeBUY7rIgEiN7WgnGh2oBOm6Z5w/AKTOmdcHFdmdcYNh7v7CmCUR07PLPZROwSTQCt+2ypXbyH0SjANye6tOT8by1PEPKYYLdlYKQYifN4P28mhh06tkLj4MxNLsKGJ1D4wjJpmD+pt42mjMakMxd0Er/CT12ooOCIE4J1h2Eb877Ktk7t6sRJpLYfh2QCVjDBTvkQ5V0XzwlA0Q2Cq+IFC2pawKrVfwsbBX1rlCq1v0jOwy9EAQkSb6quFnVqO/B3ZEnDQLBHAmC2eYhwAstJqjQ9iP0hMt+9oYKhnnq2TXVW7b+f7FAmZmiBYgGGA7Zf9Xahb38Dj3UUrm28TWuRNw1DVWDVxZClnHH/4MLFASq5pCqgnV72U32O7LXS/BvNUC6fWn9pKpGp+3odRJB2o7uK/LWJrBXIZK5iLaJiHRj3qeNi2ysmoDaBS1kVsBhJbjgE/WMS+EIAwvVpT/BHyH+wg6aD6trzvqYIrOqVwMwaL4kmQCEiwuagx1iuJsmboxYU2y9cdv3+fnoEZoyRdpYI0ajzuXoC/eYiB+ETZ/ICisyqnbqAogY1LJAp02pgtbIzx6vwYD6ggEZfsnJjNFh1XDzq9DfRBNTg22e6QmW760vzCL+lifjoG8S1djU/5R2I8MdcHABTfV+XOPR6DF98tU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0VXUDZmUExXSDJIMk5xSE9JMmVLamhra1paS01ZUGJPT1hjMkY3bTNvRDAy?=
 =?utf-8?B?S0pla1o0N2NOUFJ6UnlOSHNuYmUwNVZkN1JSRkNwemdob1BhU01NNzI4enJr?=
 =?utf-8?B?cXo5OXBwKzJhS0MwT3JXRDZwNDJTMlM5RVRYWGdYNDQ2VW9FWkNieEprbWQz?=
 =?utf-8?B?b2VnM0d5cnhZRWdwNG83Mk41RUdLbFdHS0l3THJsTGF3ZWMvTzZnekdLTVc3?=
 =?utf-8?B?aTVVUzFlNjUzVVZnZnBmN2xxNzlINVBvRm40MU8rNGhLOVlTT1NET3lFZC9o?=
 =?utf-8?B?RXhtVFNrVDRlQURVQ0N2OTMrRmZXMHAyd3pHaFR3YXJSVVZyL05rN1lycGhW?=
 =?utf-8?B?Y3Q4THpLb0lrait0WWY5eWo1NUpJU2xHNno0VnJQTXVTcGx6NlhES0RGVTBr?=
 =?utf-8?B?M21ndXhrdjMra1AwUWZDZ2NQa3F0THhlLzdISE5VT0VWN0o2dDNmaGRpSEx6?=
 =?utf-8?B?akFLWmhraXgwUnMzMk9MdUgvNlRjYXoyVlowbjBMK0FzVUVEcFNNV0lSbnM4?=
 =?utf-8?B?VkQwQXgzb204SWoyR3daVW5xcXY2MFdCVnl3Tmxvc2dhU2dNZ2pGQTFFcUJh?=
 =?utf-8?B?aWRERUpUMFloWmVHdlpXcHlnMndXMitJUGwvRks4MU8zZGFFSVlESHQzTUI0?=
 =?utf-8?B?S3hSamYrcEJad3hqcnVuM1U2USt6cUFDSUFDcWJxSmVLcmUxbDlKV251YlJu?=
 =?utf-8?B?c2MxMnZKVGpXOXpiQU1ZZnhzV1FGU095TTBQSllCd2xCbnVWWURKK29PNlE1?=
 =?utf-8?B?dWh6RUdaaGlVd09DbFFpZm9WYXJpSFBrNG5INkVCbFdtT1JDZFNuV2NyYktS?=
 =?utf-8?B?MHREQ0U3RG8xc3hFM1p1dnNwSEp3NFR0ZHN5UUdZcGZ6YlRjWmV2TWRkNkht?=
 =?utf-8?B?a1RCVEZtQS82SHQ5ZjJKRmNPSU9lcFh1a1Fob2FyaUMrTExWeU1CQnRSS1dL?=
 =?utf-8?B?MlVxLzRRUUljMmg5SnV0TG93Um1nQmVSYWlpNzRRZHRQQ3BXcDQ5UWU5L05l?=
 =?utf-8?B?Ky96dGpYMGZ2d2pHLzE3U3Y3T0Z5K3dzTDlKd0ZuVVI2VURiQVo0UWZOQjNz?=
 =?utf-8?B?UmxoY0puR0RUeGdUSDBtNGhFMmtwYTZCekFGNGMzZVQwNXBONzMzdGNEWm95?=
 =?utf-8?B?d0gxakFWVnBKQ0VkY2tUekRnUmZEU1JwcDYrUmlSVm5PNS9LaUNTdDJlQ05G?=
 =?utf-8?B?OVRnQkdYMmZOZHErckxvWDA0NjFzSE43Y0Fack9UTU1nZU5tK2l3amJLWDJG?=
 =?utf-8?B?U1ordy9BcytrOVQvaGY3Vjg1Z042N2czM0JXMTRhVHVUTGhTSndrSXRpNDI5?=
 =?utf-8?B?TGhjNU1OeWZSMmZDdHkvQTk4SjZFNzB5TlpUbC9JWW80alI5V3BIMXM5cG16?=
 =?utf-8?B?azEydVBwb29mYTNOK0IvTXVjb1RUMmVzMG9GRG5QYTFKKzF3REdQOFZocW1p?=
 =?utf-8?B?TkdaNHJ4ekFqMVg2T0RUNG9jVEtNbDFoKzdEWUtUTDl4Yy9UWU0rM21YNXB6?=
 =?utf-8?B?OTJsa3VvekpnT2pxbGdzTGRtZFhCdkRpbjBqdUFFeXhjREVudm0wUkVPcmhy?=
 =?utf-8?B?NlhZdHBieFE1N3JnczYrR2dhM0NnYll0YUZ6aEkycmZFQnUwajQ0M3d6NjVD?=
 =?utf-8?B?UlNQZlQxRUtiWklUZFhIOFNzYWM3b2Fnd05xNTJZZjlIcmJ4cW9IdnZESnl3?=
 =?utf-8?B?d3JaWjJhMXJ6S1k0dlY0WldxTFFMZTRpUGJyVTVmeXBHTWtOeXhKd3lSb3JJ?=
 =?utf-8?B?MGJDL2xYZFlxTHY4N0FiNXVCeUJ2eVBZYlg4Zkpvd0xtTVBpU2xxcEhpai8z?=
 =?utf-8?B?S3Fwdm1NRWlRTFFNMmNvRldma0s0d01nZlRVZWpIN0VCV0o3NGd4Y1ZaVWt6?=
 =?utf-8?B?Zk8yOGJPTHBQRUtsYTZUeUExWWF3Q2Jub254VWdNSW1BUDJoT3pFczNNRVFs?=
 =?utf-8?B?UE1GaXpPK0lLaWpDNWxmcmNmRVdPQ3dWOGEvMFVZdThWaVZFTmhkZmN6NXE1?=
 =?utf-8?B?azc2VFYvb1V3WXNGaTBrMXJiNGlnY0crNHk3NHBCQkJWeVZxV093UEpVZ3dx?=
 =?utf-8?B?em5VR05GZTBhTHdqQmd3MmxoQlhhelNjSy9VZlBEbG5CUG1USjRyTE8xV0E3?=
 =?utf-8?Q?lCbY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ea66ad-f10c-45ce-1b46-08dc5b442c78
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 22:59:14.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AjZB0v3FKbC1G9vgFGNyykryZh47cUDhXnfPr34oVvY7RKWfD1aaFWrtgZ0BC9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

--=_MailMate_38F5DF45-4531-4E6B-8DEC-9EBA48DAE181_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12 Apr 2024, at 18:29, Yang Shi wrote:

> On Fri, Apr 12, 2024 at 2:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 12 Apr 2024, at 15:32, David Hildenbrand wrote:
>>
>>> On 12.04.24 16:35, Zi Yan wrote:
>>>> On 11 Apr 2024, at 11:46, David Hildenbrand wrote:
>>>>
>>>>> On 11.04.24 17:32, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> In __folio_remove_rmap(), a large folio is added to deferred split=
 list
>>>>>> if any page in a folio loses its final mapping. It is possible tha=
t
>>>>>> the folio is unmapped fully, but it is unnecessary to add the foli=
o
>>>>>> to deferred split list at all. Fix it by checking folio mapcount b=
efore
>>>>>> adding a folio to deferred split list.
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>>    mm/rmap.c | 9 ++++++---
>>>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 2608c40dffad..d599a772e282 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
>>>>>>                    enum rmap_level level)
>>>>>>    {
>>>>>>            atomic_t *mapped =3D &folio->_nr_pages_mapped;
>>>>>> -  int last, nr =3D 0, nr_pmdmapped =3D 0;
>>>>>> +  int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
>>>>>>            enum node_stat_item idx;
>>>>>>            __folio_rmap_sanity_checks(folio, page, nr_pages, level=
);
>>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
>>>>>>                            break;
>>>>>>                    }
>>>>>>   -                atomic_sub(nr_pages, &folio->_large_mapcount);
>>>>>> +          mapcount =3D atomic_sub_return(nr_pages,
>>>>>> +                                       &folio->_large_mapcount) +=
 1;
>>>>>
>>>>> That becomes a new memory barrier on some archs. Rather just re-rea=
d it below. Re-reading should be fine here.
>>>>
>>>> Would atomic_sub_return_relaxed() work? Originally I was using atomi=
c_read(mapped)
>>>> below, but to save an atomic op, I chose to read mapcount here.
>>>
>>> Some points:
>>>
>>> (1) I suggest reading about atomic get/set vs. atomic RMW vs. atomic
>>> RMW that return a value -- and how they interact with memory barriers=
=2E
>>> Further, how relaxed variants are only optimized on some architecture=
s.
>>>
>>> atomic_read() is usually READ_ONCE(), which is just an "ordinary" mem=
ory
>>> access that should not be refetched. Usually cheaper than most other =
stuff
>>> that involves atomics.
>>
>> I should have checked the actual implementation instead of being foole=
d
>> by the name. Will read about it. Thanks.
>>
>>>
>>> (2) We can either use folio_large_mapcount() =3D=3D 0 or !atomic_read=
(mapped)
>>> to figure out if the folio is now completely unmapped.
>>>
>>> (3) There is one fundamental issue: if we are not batch-unmapping the=
 whole
>>> thing, we will still add the folios to the deferred split queue. Migr=
ation
>>> would still do that, or if there are multiple VMAs covering a folio.
>>>
>>> (4) We should really avoid making common operations slower only to ma=
ke
>>> some unreliable stats less unreliable.
>>>
>>>
>>> We should likely do something like the following, which might even be=
 a bit
>>> faster in some cases because we avoid a function call in case we unma=
p
>>> individual PTEs by checking _deferred_list ahead of time
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 2608c40dffad..356598b3dc3c 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
>>>                  * page of the folio is unmapped and at least one pag=
e
>>>                  * is still mapped.
>>>                  */
>>> -               if (folio_test_large(folio) && folio_test_anon(folio)=
)
>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pm=
dmapped)
>>> -                               deferred_split_folio(folio);
>>> +               if (folio_test_large(folio) && folio_test_anon(folio)=
 &&
>>> +                   (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped=
) &&
>>> +                   atomic_read(mapped) &&
>>> +                   data_race(list_empty(&folio->_deferred_list)))
>>
>> data_race() might not be needed, as Ryan pointed out[1]
>>
>>> +                       deferred_split_folio(folio);
>>>         }
>>>
>>> I also thought about handling the scenario where we unmap the whole
>>> think in smaller chunks. We could detect "!atomic_read(mapped)" and
>>> detect that it is on the deferred split list, and simply remove it
>>> from that list incrementing an THP_UNDO_DEFERRED_SPLIT_PAGE event.
>>>
>>> But it would be racy with concurrent remapping of the folio (might ha=
ppen with
>>> anon folios in corner cases I guess).
>>>
>>> What we can do is the following, though:
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index dc30139590e6..f05cba1807f2 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3133,6 +3133,8 @@ void folio_undo_large_rmappable(struct folio *f=
olio)
>>>         ds_queue =3D get_deferred_split_queue(folio);
>>>         spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>>         if (!list_empty(&folio->_deferred_list)) {
>>> +               if (folio_test_pmd_mappable(folio))
>>> +                       count_vm_event(THP_UNDO_DEFERRED_SPLIT_PAGE);=

>>>                 ds_queue->split_queue_len--;
>>>                 list_del_init(&folio->_deferred_list);
>>>         }
>>>
>>> Adding the right event of course.
>>>
>>>
>>> Then it's easy to filter out these "temporarily added to the list, bu=
t never split
>>> before the folio was freed" cases.
>>
>> So instead of making THP_DEFERRED_SPLIT_PAGE precise, use
>> THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE instead? That s=
hould work.
>
> It is definitely possible that the THP on the deferred split queue are
> freed instead of split. For example, 1M is unmapped for a 2M THP, then
> later the remaining 1M is unmapped, or the process exits before memory
> pressure happens. So how come we can tell it is "temporarily added to
> list"? Then THP_DEFERRED_SPLIT_PAGE - THP_UNDO_DEFERRED_SPLIT_PAGE
> actually just counts how many pages are still on deferred split queue.
> It may be useful. However the counter is typically used to estimate
> how many THP are partially unmapped during a period of time. So we
> just need to know the initial value and the value when we read it
> again.
>
>>
>> I wonder what THP_DEFERRED_SPLIT_PAGE counts. If it counts THP deferre=
d
>> splits, why not just move the counter to deferred_split_scan(), where =
the actual
>> split happens. Or the counter has a different meaning?
>
> The deferred_split_scan() / deferred_split_count() just can return the
> number of pages on a specific queue (a specific node with a specific
> memcg). But THP_DEFERRED_SPLIT_PAGE is a global counter. Did I miss
> something? Or you mean traverse all memcgs and all nodes? It sounds
> too overkilling.

I mean instead of increasing THP_DEFERRED_SPLIT_PAGE when a folio is adde=
d
to the split list, increase it when a folio is split in deferred_split_sc=
an(),
regardless which list the folio is on.

--
Best Regards,
Yan, Zi

--=_MailMate_38F5DF45-4531-4E6B-8DEC-9EBA48DAE181_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYZvMAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUALIP/2AJjtFPn2bhUalps2I3KXaT2e3UlfzBeCfq
y8AT2o8oOzI4YNOoJsGdIihkJbruz84EL6feN1uJsypAqThpKGAKrC+M+/VZZa6P
EPFdzkXnLG+sZLuWf8a+t6WLTx6/sSJGsOgyIcCJc42WnqCc/r9LqImAUuCcY4cn
1H2W8ddV/6hMJw/lpXhAUZP2tTI2mQd1SYAjCBGCkHe+gXeI9ybnkb0iO3TCtj7t
apgGC9pOa3qD9Ub46SMLv0pwLoX/KRtvto9BqnVBXksyB8yo4IAw9QVNkIFWxlgF
hn3oTUz/Ve/bhrlfMqX69pa5ZWz0YL8nKTRsSLYnZTzNPXjGdc4uyfIe05x7lZm+
J8WqotyY4YzI1KXgk6RLzhwgkx5Mx/dy/HmD3Qzat7zE2dinBRUUqhS70L3b31Bq
lINMV+Q5B3sf0eS77RR7gvbLj/grUFtkbSO3WI/QwGTh6IsDywL/43qBmcSLfqQ0
IN6rSuIfZ0hvqgNc9VYlxW44gj9lS+Tu3d7sXoF0XzR/zjq9bcIJFM5MUrt+p2ML
OLzsPUQ3atyO/gey7lFXkbnXzI9t0SF9gc3ekpnvHc49NTQQCNe7TCTtjKBUA3mU
Dk0ZLFlDXK5KoYfOHyfDSbTA6FTWc0GVcUCVSEI7kIW3akqOnMAAqNuTC1NIkZVP
77CUFxX3
=GY8I
-----END PGP SIGNATURE-----

--=_MailMate_38F5DF45-4531-4E6B-8DEC-9EBA48DAE181_=--

