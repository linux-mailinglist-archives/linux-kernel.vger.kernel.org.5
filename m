Return-Path: <linux-kernel+bounces-142840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B388A30B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B4281CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE8F13666F;
	Fri, 12 Apr 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRTN6NXX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621B135A48
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932286; cv=fail; b=GI4V5e2Srr/2hKNYECDnn9XjrV++UeYKi6kld+DFFHLpi56ygvNwnwTeGEa9bA05ukD/7kUMjrRfuHwj7EcLFtHtLStK5pZtGRjyZowg72CnE9j2PfbmKCvopdS1FeCmHnHqFm9+lUb5gp4R2YkkLnI2Fm1zilFGeq0WqdCQ1Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932286; c=relaxed/simple;
	bh=SninVoTbx5x4hKXxffTwx5MdcGq9SZfQhDcfz6P0isM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LG+Y/DeO+KgA0uhyzEe3uvVxWJ9/wGOCzIfQ1LlSZKJVvlGuTrmZynvdzYlniKgiu2fbAUHW/sfcL13RlV8MtYKgHjiyr17vvLSfRdk+5HxjBnfnnMtz29ButBgXUA4WFry4PI7MQe97Gy1L65K/3d9fohj+YKXdRf4n4dHueB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRTN6NXX; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT4hBtg4+I3+4BqO/+tJybZQ6OxBzwYRgr7AoGH8KLSltN5v/Bm/PhBE2X1kXuDjZqO98kSHZockhy+t/ETz++zcI9PtLspKgZ7bngpnaGlaNtWQWdmENLRG1r7WEIsV+H9PVdaQHlCjNwXKJ0NtGG0vh1g5lBAvwasl4Zw7SUuJLQ3GpVdb6B8tlthO06G4brsPheoqcgQLdNMwX9Uq2y1VuGxfc+l2E7Exl8BqVAjsSo9bMqEVc4n2/++mrxBT/T0v+D/UkMZsZdaOPR5BK20jFXKrB8gCi1BVG2gvV+oy34FTid2PgV+o0OHiB5W/SxOh+ZC9JVxGokHwc70S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4vmmODtaPBA4EOwRO6AoL+KDOEbXvwFu/2PDeHLPWI=;
 b=KGbq0vIIRrequgOMYXfguvVGveIqCdUsQXcOiDvhCwhnMFub4QVPfzyucrt3V752eV7AkCOv2QYlCyDUVn5UQrZYX7GX9B7eYOQQrubqs5GSSraLiojAYgASq+Knn/xQZbXPIyl6edCMW782EN1Tacu3MBVRy/Gz4Pup67xKpnxFjQNH8UTAsI4iFVemntbB0NQMtlIVlx8FHocym47yiG5WaXIO7yU3M3rKfmPIsMgx5dnb1ZUliB7K8INJ6hUsftbB9/O5RKhbv0HPvxCe59DDr4UCjyFGzpbDCI2P94Ukw+Z0qxNCpYrHWpUU8V+YoU0Fq8/OpeOnJDrIjP/fjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4vmmODtaPBA4EOwRO6AoL+KDOEbXvwFu/2PDeHLPWI=;
 b=gRTN6NXX/wDQPHndIWuWOKOYadu2300f4KjEIpEpWDbm/YihCqFET5IK1HKl/8DdbRcx41WpXIgFQEr0Qut0I2B1Iu4Sf7XBeTQHpGOiNfMt6h3diB97gb0Pq5aH5Fq3k3KnUTkBryZ6zEDtuH+0RY2BjADO4pBn49ZuAHqclQb3xhtlSrdrl3+0+xjT6vtzBx1gELLvEbomdTIMlZwpJqqQugAgX4JFdCzBc8iyHFHASOrCFbVH+xrEMz5bxaBgQyHSC4VSsmzU2HCF3kwChr5IgUA1uRXK4GGHv2BFOEZKuEV2b7SwrdmL0vyYssk/jxIgtuufX7VE6p8kmTodrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 14:31:21 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 14:31:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yang Shi <shy828301@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 12 Apr 2024 10:31:19 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <A06608B4-9187-42DD-B9A2-CBBC3D5C9312@nvidia.com>
In-Reply-To: <0A4D2CA1-E156-43E9-A1C9-E09E62E760A3@nvidia.com>
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <CAHbLzkr99knWKZvE4WCWKKr=eezkg89idpE59oo_oBneAQynAA@mail.gmail.com>
 <86722546-1d54-4224-9f31-da4f368cd47e@redhat.com>
 <CAHbLzkrxR_cpVd_KF1rz9CTVmr4q0KX7T=SseOo8X5u23-5ZJQ@mail.gmail.com>
 <0A4D2CA1-E156-43E9-A1C9-E09E62E760A3@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_579B7740-FBC2-4B5C-8CE6-6FA5C582E6AB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:208:23c::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1905ad34-9d35-429b-6bea-08dc5afd38fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IXI/rgyW9HM1/sVk6ylv80jJqj0jWzttup01TsjLAlUpWma2/NnD3iCN8IUFCCFD47xnxQLgIFxT76Mj4TTy4YgAlUNgix31Adi4r8npLX0vXs3dUgJIUsE/9ATnU3X6our70EHynHDhl5glq0XvUuGkkjYqqIbTT2fTPsqDoBKzLVdSsS8w7jalXQGE9FI9zv9KqNmrj9Eeu6litJua/bYwImBFtQGZru7TCKvyQi6odiq6OfWZuFgT9Czid52MFZTWPHOM7c8a/0YB/uN8gfo9spdLxSPe7I8g4pm2XzCxcXXH3FAPwVmn6mOmSjecjyO4ZGmT0YeAkumedMW4zN06synS764kEzwtBBOYvpJg8RGn8tWukSSIeGKieJDteg8i13UFxzyhwD7vEPwJTKv+fqB1Ooc11eQppWRW0PRm2jzYZg2GY8hZCywgxpTutgBGpxA05wVBQX5b80Sokr8Ul/0ggXw8jo+SskQITC1KdLX6nU78dJGQ77Ci4NopZU8iFrBDslmc0liLI0LMGFQWg/EUFRYIex+szud92NSnl1SzSGRh/KHJ1oBnvVpFwKreEFm8r5SStWhuZ7sOG6JQKQHZLwTecVrOoIdC9k35STP+wAqrBKTLnWevKgkiu4vRB38ogWg3IR866VZFVj2S8fdaTW3RZ2/sqO9LAsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2U2L3pndDYyZlg1empGbS9vdzBjRVNMeGpFRU1uYnFKVC9UUGlYZVR4Vncz?=
 =?utf-8?B?V2F3ZE9jMC9PL3ZwZk54YlV6aTUxZHNOeDJtSGcrK0ZZWlc3dSsyOGJhSTIv?=
 =?utf-8?B?Q3FTUnAvK1J2QzdscU1UN3hnWEdnU3RRSVlzRDBJZGY1cTBFN2JwbXV0MVh6?=
 =?utf-8?B?SktKVjVYRk4yTHVCQ0FvQTduWkduRG5lcmdTSHYwZ2xrakU4MC9tZkdyUUdN?=
 =?utf-8?B?ZHhYM0xMbWZuSmNUQW9pTys1M2ZwdW0wNU4xL3czRkg2UU9DbURWTW9Yb1E4?=
 =?utf-8?B?ZFZVb0lKWHdzRFRZS3Fuc25CandIZGpNZy9vK3hVOEREQlhSMk1lZW0wSHJs?=
 =?utf-8?B?VkpIaHQrUUg4TjNWUUZoVTVnTEdtNTI4V09pU08vTEtvMmJuUDllaVFXZUo4?=
 =?utf-8?B?a2Fab0RpSFBpTHdQN095V1I4NDZGS0twcEdIZm9kSDc0ZnhQSkkzclYwTTJW?=
 =?utf-8?B?WWpWcEREaDFDcGRuakU1MVBDZ1hJNE54Q1BYa0JmcHRKUjV4NjN4eDA5cm9G?=
 =?utf-8?B?VjduR3g3YkRGS0xQTFZHTmJ1eVE4Z05rcG1sZ21iczZFdkVqc3NGcWd4T1c2?=
 =?utf-8?B?TExGeUtRQVJUNWNRbzc1aFpJSWpYcXZTdEdrMnduQVNVZkdHU3F5K1BpbVp0?=
 =?utf-8?B?ZVBRaDRGbWFBWTNDSmZvVWZXcXNMWCsyM1paQTFQcjEzMkRGR0txNWM0YS9W?=
 =?utf-8?B?L0xmbmoyRWFNQklCYlorWHQ1dkplQ1hCcmhJSWUwaThEeEp5NnFsdElnaTR1?=
 =?utf-8?B?clhKaVpSRThyRVhOR2Ntdm45dDg4RDQyQXh0S0xLUzloM0RUWWhvSUpVdTl6?=
 =?utf-8?B?N2xWT2pJa2ozT3ZPQ0p3K2RWbzBDUGQ4T3VxTnpHcFZQRjFVWjhvREdlNnBM?=
 =?utf-8?B?eHhPbzlkeGlsV0d6OVNIYTRGZzFUSFk2SFBadHRhWkpwOHhyZTF3MG5sc20y?=
 =?utf-8?B?TTRLUHllcmpVQzdWWnZncWtselZvSUJTSzNVSXB5aVRzRTcxY0ZGbUFISTIw?=
 =?utf-8?B?c1BLWnVJMFZHQTZMektpN0UyOWIwWndScUlxaVFFSkJqQW9pQjR6UExGaW1h?=
 =?utf-8?B?WTZFVThaMEVONDM2dGRnaDF0VkFlWjJPSGZFd3RhUEdVbzdyR0lDWmxmSVBB?=
 =?utf-8?B?WDZrK3I1RUx2T2RLK2JXVnRLV1RFU1NlZ3EyeXNPL3hESDRNSFFTdFU4Qll4?=
 =?utf-8?B?bkdZRDJlQUJzc0Z3NW0renA1bC9lZG5GRFpGUUUwL0pYNlN0V0ZxT2xzazRn?=
 =?utf-8?B?SDg2KzZYTWlPeklTaTk3QVNvTlBReHhaNXlJdExubFJVQ2RYMmE0cmgzSGY0?=
 =?utf-8?B?d2lsVGUxWkVoY2ZFNVFHTmJxSDczOGxCYUFjbzFYV3dwbG5ZSzROaFpSeHB0?=
 =?utf-8?B?K0hEU3M1NHRGNzJFZDRmTi9GK2xhNkxWSURROVZZSC9hUW9LczMzd2NnUkpO?=
 =?utf-8?B?dElKN3M4RXNoWVhWRGErR0VmT1lyTzFFZW05eGlnVkJ6YnJtOWlEMG4yVVlX?=
 =?utf-8?B?LzhzNE5PUnU3OWpDUmdzcXRGdTU2bkpuTit4VGFzTWF4bmdyZFU5dVAxUFFD?=
 =?utf-8?B?ZzBWaWxrQ3hMVHQ3ZmxNbUM5YjBBQjJwSzF5d1d4WXVsYlNxUVY3Mk9Ycjc4?=
 =?utf-8?B?OFBmUm9wdlJDaHh6NG9DbEdVWHdzRU9lYjVxTmV2RWJGc3MxVmR3T0xYSnZT?=
 =?utf-8?B?TTcweHFhSVcwY1YyUEtiMEk5czhLZTFZMVpKSG9IYnZFWHMvNEdqY0tMdlQw?=
 =?utf-8?B?VmRnWW83MUttbTF6OW1SdVJRL0p0MjF1bTQvNm1sb3pITHBsR2Zad1FqWE8w?=
 =?utf-8?B?aG5tMngzSnVpQlZxc1pqaHhzc0ZUOHdXNTFzQUQxaVRHNVB6ZEF3ZlQxNE91?=
 =?utf-8?B?NUpFbU50cXBoc1hYaXFWUDhaY3Qza0l4Q3ROZW1rcFdxY3lPZ2lhdS9WZlYz?=
 =?utf-8?B?cGswTStqd1ZOVGlndUtFTFB1RTcyZVlFcWZreUVLb1VoVy9rMVNkc0xRdEQr?=
 =?utf-8?B?NUppa0ttVURLZkpOUUdkZmJLTmpCRWd4dnp3bHhKUFBCZDk3RDBCbGpWQUov?=
 =?utf-8?B?UDc5djFCdW0rUjdsRytQejRrYkhHNnJMTkliMDU1RXV1bkh5RSttbU5UU2k0?=
 =?utf-8?Q?XMUg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1905ad34-9d35-429b-6bea-08dc5afd38fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:31:21.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw/V4j54ZiSqv4W0WokPW0E+UtZZ9Vo18lclOmg50aUO36Wl1ENvz4XdKnjB0+jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

--=_MailMate_579B7740-FBC2-4B5C-8CE6-6FA5C582E6AB_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12 Apr 2024, at 10:21, Zi Yan wrote:

> On 11 Apr 2024, at 17:59, Yang Shi wrote:
>
>> On Thu, Apr 11, 2024 at 2:15=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
>>>
>>> On 11.04.24 21:01, Yang Shi wrote:
>>>> On Thu, Apr 11, 2024 at 8:46=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
>>>>>
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
>>>>>>                enum rmap_level level)
>>>>>>    {
>>>>>>        atomic_t *mapped =3D &folio->_nr_pages_mapped;
>>>>>> -     int last, nr =3D 0, nr_pmdmapped =3D 0;
>>>>>> +     int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
>>>>>>        enum node_stat_item idx;
>>>>>>
>>>>>>        __folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
>>>>>>                        break;
>>>>>>                }
>>>>>>
>>>>>> -             atomic_sub(nr_pages, &folio->_large_mapcount);
>>>>>> +             mapcount =3D atomic_sub_return(nr_pages,
>>>>>> +                                          &folio->_large_mapcount=
) + 1;
>>>>>
>>>>> That becomes a new memory barrier on some archs. Rather just re-rea=
d it
>>>>> below. Re-reading should be fine here.
>>>>>
>>>>>>                do {
>>>>>>                        last =3D atomic_add_negative(-1, &page->_ma=
pcount);
>>>>>>                        if (last) {
>>>>>> @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
>>>>>>                 * is still mapped.
>>>>>>                 */
>>>>>>                if (folio_test_large(folio) && folio_test_anon(foli=
o))
>>>>>> -                     if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_p=
mdmapped)
>>>>>> +                     if ((level =3D=3D RMAP_LEVEL_PTE &&
>>>>>> +                          mapcount !=3D 0) ||
>>>>>> +                         (level =3D=3D RMAP_LEVEL_PMD && nr < nr_=
pmdmapped))
>>>>>>                                deferred_split_folio(folio);
>>>>>>        }
>>>>>
>>>>> But I do wonder if we really care? Usually the folio will simply ge=
t
>>>>> freed afterwards, where we simply remove it from the list.
>>>>>
>>>>> If it's pinned, we won't be able to free or reclaim, but it's rathe=
r a
>>>>> corner case ...
>>>>>
>>>>> Is it really worth the added code? Not convinced.
>>>>
>>>> It is actually not only an optimization, but also fixed the broken
>>>> thp_deferred_split_page counter in /proc/vmstat.
>>>>
>>>> The counter actually counted the partially unmapped huge pages (so
>>>> they are on deferred split queue), but it counts the fully unmapped
>>>> mTHP as well now. For example, when a 64K THP is fully unmapped, the=

>>>> thp_deferred_split_page is not supposed to get inc'ed, but it does
>>>> now.
>>>>
>>>> The counter is also useful for performance analysis, for example,
>>>> whether a workload did a lot of partial unmap or not. So fixing the
>>>> counter seems worthy. Zi Yan should have mentioned this in the commi=
t
>>>> log.
>>>
>>> Yes, all that is information that is missing from the patch descripti=
on.
>>> If it's a fix, there should be a "Fixes:".
>>>
>>> Likely we want to have a folio_large_mapcount() check in the code bel=
ow.
>>> (I yet have to digest the condition where this happens -- can we have=
 an
>>> example where we'd use to do the wrong thing and now would do the rig=
ht
>>> thing as well?)
>>
>> For example, map 1G memory with 64K mTHP, then unmap the whole 1G or
>> some full 64K areas, you will see thp_deferred_split_page increased,
>> but it shouldn't.
>>
>> It looks __folio_remove_rmap() incorrectly detected whether the mTHP
>> is fully unmapped or partially unmapped by comparing the number of
>> still-mapped subpages to ENTIRELY_MAPPED, which should just work for
>> PMD-mappable THP.
>>
>> However I just realized this problem was kind of workaround'ed by comm=
it:
>>
>> commit 98046944a1597f3a02b792dbe9665e9943b77f28
>> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Date:   Fri Mar 29 14:59:33 2024 +0800
>>
>>     mm: huge_memory: add the missing folio_test_pmd_mappable() for THP=

>> split statistics
>>
>>     Now the mTHP can also be split or added into the deferred list, so=
 add
>>     folio_test_pmd_mappable() validation for PMD mapped THP, to avoid
>>     confusion with PMD mapped THP related statistics.
>>
>>     Link: https://lkml.kernel.org/r/a5341defeef27c9ac7b85c97f030f93e43=
68bbc1.1711694852.git.baolin.wang@linux.alibaba.com
>>     Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>     Acked-by: David Hildenbrand <david@redhat.com>
>>     Cc: Muchun Song <muchun.song@linux.dev>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> This commit made thp_deferred_split_page didn't count mTHP anymore, it=

>> also made thp_split_page didn't count mTHP anymore.
>>
>> However Zi Yan's patch does make the code more robust and we don't
>> need to worry about the miscounting issue anymore if we will add
>> deferred_split_page and split_page counters for mTHP in the future.
>
> Actually, the patch above does not fix everything. A fully unmapped
> PTE-mapped order-9 THP is also added to deferred split list and
> counted as THP_DEFERRED_SPLIT_PAGE without my patch, since nr is 512
> (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio()
> the order-9 folio is folio_test_pmd_mappable().
>
> I will add this information in the next version.

It might
Fixes: b06dc281aa99 ("mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]=
()"),
but before this commit fully unmapping a PTE-mapped order-9 THP still inc=
reased
THP_DEFERRED_SPLIT_PAGE, because PTEs are unmapped individually and first=
 PTE
unmapping adds the THP into the deferred split list. This means commit b0=
6dc281aa99
did not change anything and before that THP_DEFERRED_SPLIT_PAGE increase =
is
due to implementation. I will add this to the commit log as well without =
Fixes
tag.


--
Best Regards,
Yan, Zi

--=_MailMate_579B7740-FBC2-4B5C-8CE6-6FA5C582E6AB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYZRbcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUio8P/iVep8ZcP+9rSrFtEjEyBxOn6YbBflhnRAz+
VoCu6SnP8NVhmfY53rFTnoSvlRhFcCo9CYO9zLjdK8Za67PF50mqHXkJRj66Aq09
zNQsF6PN47H+2jo6ZQpNVkJY0kZJCY5akXFBR2uRheYo0JTufmosCavVH3p+CWfE
Vj3hPnvUh3V1I5IR6f3kq6GBmqtRr7Q8jbH8WJXlT/IGsBIZ2wEwQiRzF77oT4wV
ZHQRPK1MvOLs0ZfLdpavIzD67oEABxxZcrd7xDFD7wX9SULUSFd5F51/Fj2qLUK+
X947iGCZu7gg4S+V0bkpXsU/sLlTNyM3yA5imHz6y5pcNLl5I0r0yyLDnrb7iAD3
IcDPhOaHd2rB08yawxVWWKpSEbplE/1aSvTf2zJfBq5YeDbJuw4lUnaQmNdBKrrq
MGN8I5ct/mPZR56AO6cYfJ5tZmuRh5RHexDiEMY+EG14ly60XgW0SLuRmIyYbWyL
mteUumx9eSE59aHiX+7A0YfsXlgZo8Vvi3tl5lQL9uJbvC77HLF1rdUF1KC9nRlj
65OVcOyRm02EZtauSOMT0UYivSxer+EtLrnpYZdSYGvg894/PJqqvCnkW9nVfOb+
iqMA3Atx/mIjc5KyePuUCtknAbQUg1uMMpFwAdGS6H0RBFRpd8rjLulpyWhyafYH
LBijBME4
=1ZKW
-----END PGP SIGNATURE-----

--=_MailMate_579B7740-FBC2-4B5C-8CE6-6FA5C582E6AB_=--

