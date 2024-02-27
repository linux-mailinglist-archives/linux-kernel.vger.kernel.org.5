Return-Path: <linux-kernel+bounces-83432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6EE86991B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32191C22902
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49EB13B29B;
	Tue, 27 Feb 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nuv6LdrQ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F83D68;
	Tue, 27 Feb 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045584; cv=fail; b=mfXw4yJm3sSOYrJ8NCgs6rck+0XXF5xjg2j4jJt2TTsyp3PdLpvTZtP1nL/xhfHgnoKhBBiyWKWAMwyHSZLzfTKr2T1Gs5W20jFEhs5XNJgnMS1Lz02KovYXUqEhXrbOGdW5LDocBQU5vEOQHpvUHp8Mc4J16fRrjiKQVY54JEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045584; c=relaxed/simple;
	bh=kGvZCVyHfCe4BUW9jVvbDjmxEYwN+QANNyDqDbpQYjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j2u+0rzgRvr5YBDITGH/oWO/nHfi7oqHaP706ln7kw0zh5OePT7kIqE2D4C+9Gk6XokY3MOivh5eGopmOHZwi4oaEdZjfmHfABWax6TS6QwNfBITmgf7Ia0KEjDas9t4slZ3nH2in/DnGrMolvQ2gCa7qZK4YpX5E9YGHmPEqJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nuv6LdrQ; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=accVWL3nerZHqeeKEdVUZCxHK8JmSwIsmrcLnm/5ow2uR5MZrPAwIIMRAKGK8BfeGXXyhcpTpGovJiuMNyu8vxpFMASHgbbeFULmJf6zSKXe//IK809TCX1l99DC1HHMN3uqCbHG+PwZNnS3dDFQxi1c7GTpx7ZlFNWhqhSeW30XLUsYAmJHKQ8vIIo6v1XiDg5AE8gRoz9XuZGOTB8JLCak+DBTlSCuFjRN5XKWNKMM83KEMA5bHvGGs6CQq2bb8uH/OrhQdrAtPkfmPNy16MMGs7tTgX/1wNvBgHV3fbogFmQwFnNbVoT9/kwH4bhGG7Wl1XwCGc01b6Van0BIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHO2NmammESb+DWc1dsvwYSs0UPgmlez9ro7QMBIEiY=;
 b=as6hXFEm2bFnxTwPFXe+0wyN1+6ywy8rgtF0wiPG8fhDsstu7zH7e0BC4WX6TmVLmE4pu7kAI40NCiAVhq4yNbyvwkQ0klXMtBMEEgXDbx1YfxOhe6xDgtvZ9CBsavR8JhqpGTXXxVTc3UPZuHt0gWri+S2v61RCGK4MKN3lGY7HpGzrFHYRkjwZLo+q97qXVfRHTvTI5mdXsvQ6GfyIgvtM4ttemZeU6lAMhU7FM3euJn0Pb3U1fAD0qBHLWldxgMEuS/5xXMrh6YEw95ROkrn/oz0GAWokI+2ul2SspX6MsK47OemlazrfkF1neQTjWbsIbkfigKmJdJy7A/GhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHO2NmammESb+DWc1dsvwYSs0UPgmlez9ro7QMBIEiY=;
 b=Nuv6LdrQ/ALvKrbciEDYjPKd+9bzVHGXT3BnBuwaKngAP+i6/vQfltcqZrEQk5WII5PqW6Qs7c0adjVvV+Wu0GHmBtMEJVUXAWjxmKQGh7kc3wIpPIxoHWTjQ9z+JFfMhoMrzpPROGv5US5brOSQS+CwUQ51erSRuRR3bRWdMWEFoE86nqxdmYpGUW2FdMz/6RI2vifHgqFTYLEYnZRMw8z2CpJRJTcIPakoNyyFZJ88Lj6B4yzg0CSFH5pAkij/rIOJfwjQlVUBl8YiwsgYMKxZPcIPUAWMHlCYGaB4KmxLPyjOfL6R5MlBXaOpmpnsEL/bPE6CF0uU5nk0yEIqZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Tue, 27 Feb
 2024 14:52:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 14:52:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, vbabka@suse.cz, dhowells@redhat.com,
 surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"# see patch description\"" <stable@vger.kernel.org>,
 Huang Ying <ying.huang@intel.com>,
 Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH] mm/huge_memory: fix swap entry values of tail pages of
 THP
Date: Tue, 27 Feb 2024 09:52:55 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <1ABD022A-35FC-4A6E-ADAD-36F3D745FB91@nvidia.com>
In-Reply-To: <30ea073d-0ccf-46e1-954d-e22f5cbf69f7@redhat.com>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
 <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
 <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
 <ZczLoOqdpMJpkO5N@casper.infradead.org>
 <f2ad5918-7e36-4a7c-a619-c6807cfca5ec@redhat.com>
 <30ea073d-0ccf-46e1-954d-e22f5cbf69f7@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_59081F6E-59FD-4E97-8B86-B6FEA972B6EA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:408:e5::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 6439bd4b-f3b0-4489-8ede-08dc37a3c9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8OMDsh4GyUV3r3HeMkFBgydTXogFOoKilzA5p7Ftmyxb0dljOG9jUBbHXmG86SgCf10yyyySha54tcoRcfkiKF1iKG2Q4gmffkY0qcXO1OCLJmRMSO63bDVUNvEvOFxH3m+Whxl9kIsyU8RZksDWrZD8dq1lmRpjM3qeEljDh7L9O20bsCqxoyW1B0lAO83VPAUJ8/BbDicmOJFlZ7IZzP0uZj5XIZ7wWAh5JDS04w3v7WphCGaRtJszc2vpuJV9XwqkN+MzrtQrgzXD6vzdDzRA1BlH0kLBuZUx/B/7LOfJfTE61bAjP/ZBXccmC8CVrt0277uSHLpnvNrp//fqyJNBMMLJUILm2RQ+XdMB2uTqhJQMG7btvbGrzy2Sleg0xBIBwHDc2JrQrVX1E2msPYqewU97ZpbYC7zEzE030WR0yUWKLqSzLAjUUJYQE9IfnwL1p7OLplLHdpFhi8ugWCel85lw1wE/pr7u0o1Ct5hQRgF0A+GeXKHTv0dUDIEk/AfXcMaPj0mRbx3h0hHDx616oWMfi4sUavjZ+9bYqvsZDRDfV34Rry+TiIZEGmfP1V7EQn6vEpNpjNel7J254N6OnXfVi3RE97xFk6Dx9tOSY0FScnOXlTBGANZI0jfgoAY2XcaDucOBgd+Z8Y00zA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wlpuelo5bGlJT1NsbnMrWmwxUXE2ajkwdk4wVGYxRlFrNExVRHlSQzVIR21m?=
 =?utf-8?B?MDhjNG5HUFNRT29jNkNMSlBzMHZFSEVKd3hWRVZaRzNFOTdMaTJQd2Y4cUZC?=
 =?utf-8?B?OEFYS2F6K1BDZG9XMW5uMHVhb1gyMlJCWFF1N2NIbmZoUnpHd1N0ejdVa1M1?=
 =?utf-8?B?WFpTYXIvTXVqZDM2TmVGSnBremlIWm9JdjkzaVhLVVR6RE1jb2lwcCtTQWln?=
 =?utf-8?B?VW1OZ2JNUm52V2RldmhRWTlBZHVQb2hiNUlqcjI0aXZaYWpNbm9UZmRPK2t1?=
 =?utf-8?B?S1NsbFhreXMrcVNWOTRHR2JhclpLWkdIVkRpaG5tMkFoSkhnSEkrS0hNbnVr?=
 =?utf-8?B?dkliKzJtVzNySDlrVjVlOTJEaWJtSXRvMVlzRWR2VlFIRnRIc3BFdWM1MWpI?=
 =?utf-8?B?U0I4dzI2RDFML082cGFURUxvUTlrV1NFdGVKVDA2UkJFTE5SMjM2Q2Frd1My?=
 =?utf-8?B?bnlRaHZLVUlaZkY5V3Y0bWtvcWxMR3A3ejNaWHEwZ1FQSkx3aHVyWFd3VDk1?=
 =?utf-8?B?elRhcXlKQkZHNEpYS21rNlVIeWJMZHhvUWFZUndITUVyL3pZdnhtSzJBTmtP?=
 =?utf-8?B?aE9LK25lcDRxNzRxM0taUUlEZG56SEtyRmdWOWdWTU1nZWpNRDdZWWRwck80?=
 =?utf-8?B?SkM3WERmUlUwOGphTWE4ZlNlZlk4U0Z4L1VZeTZDeU1YNitsbk9iQmp3NWRK?=
 =?utf-8?B?VllwWnlOdmJxbmw4Qm5BZU04Z01IaktKMjM2UHJHdU5vMHFCUFcrMUZNc2x0?=
 =?utf-8?B?ZmxNbFBYcUVrL3FnMlEyeVRtRzNKcm43MkoyMEtrUnA2T1lxd2RVVFNucHcy?=
 =?utf-8?B?cHRQTkNPT3FzYVQ3RjdkdFdERHJCTVRPRWNsZStzZ1RUNTFWYVhUdzNHYmZl?=
 =?utf-8?B?U08xVGI3ODhpOWpWOWpQbDh6VVpVZ3VRdHVDUVpaTUtGZkRFZkZYLzdsS0NS?=
 =?utf-8?B?YXN5ajIwMjA2Uk0zQzhJSmpOQXBNbXpBZU02OVNmSDZNRnBlbzJhQWtSSkJp?=
 =?utf-8?B?dzZZcm1aWW1zVEc1V3dkVFpoS1E5V3c5TGhwQjhUOTJPRm5IczZxd2pWWitt?=
 =?utf-8?B?endKUG9RcDFVNkNUc1VnaHlaRklMQnZHdTlzSyt0amlvN3RHUkNHdC9KbXFK?=
 =?utf-8?B?dXVuOXlSR0xwTjJJTXBBYjlOOElHRVd4bjlKUzhpNUxsdmFqTHk4bmNIN0sw?=
 =?utf-8?B?Ujg5bllBZzZzbDVwOWlNOEdxSExNa1k4a1ZycFcyWHBJMXc2UWlUZEUrdG5t?=
 =?utf-8?B?clRza00vbm5IWkFUeW52eXQvOGNVQnpkby9DYncxK25Fa3BKakpCY0VraTZ2?=
 =?utf-8?B?dDJHYXJtU3R1SUVnRzJXSmhLbWtlT3hJanJSVFNMMkhpZGFOQkRJUXg1MEdk?=
 =?utf-8?B?TXJuZWdoMXpUbisrd21KS3ZRRFA0SW5WVU5FSSs4NHlwWUJHZWdoZ2RZU3Vs?=
 =?utf-8?B?UGs1dmZpSjlmQ0hVTHpXWE5CSW9Ha085RU9vT0pIUE9QaDB3OGJrSnlFMHh6?=
 =?utf-8?B?NnUzNy83ZGlFSTFxRDl6UkdjWnRwcXduNy9MTEZ3WEJ3VXhpMWNhMVdvQlUy?=
 =?utf-8?B?OFJ5ZFVpWHFXRDBFWTE4RldWOFhsVHQ0UENWbHBMek16cGhvRzloaXcxdTdo?=
 =?utf-8?B?czQ1ZFdxRzV5N2xRSHhlSWdOaGgvalJJaUFjbndmU0s5S2wxbTd6TWppRFh6?=
 =?utf-8?B?RnFMaDI2cDJLM0V5YU5UZEM3dEwxREZkcTdZZjd3NEN2c2ZqcnlYc0xzWDBB?=
 =?utf-8?B?ampRLzlHTnhwd2gzak04eldXNTdFTnYwZ0dHUkkxV0JldDVQRTg2VnlqMzhG?=
 =?utf-8?B?dzVHMkh1MS9UU2NVMDJJL09YNTMzSXZ0MXhVb1pVZlNJZzVIMUVPbWR6cDNI?=
 =?utf-8?B?VWVtVXRyMmFYVGJwNlR3YjdUQS9KWkFFdklFcm9RbHJMRkMrN2M2a1JNU1ZH?=
 =?utf-8?B?Y2xoOStoemY2dys2Y0wyaFNZc2RDK0NTbzUyOHgwU2VZdTYyK2dkczVlNDV0?=
 =?utf-8?B?MXY5NmJCakN5K3o0eldjNkg5c1l4dDQraTZyY1FDZTVFZTJmWENRa3lneGZ2?=
 =?utf-8?B?N3VaM1BEb056WGZmTzl5Mjd0bklpcDhySFFGVlhxU1hnUU9rZjFtQUM4Q2NF?=
 =?utf-8?Q?q5bY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6439bd4b-f3b0-4489-8ede-08dc37a3c9cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 14:52:58.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHjhRzRXui/9d6N3joy7GzFPFlTP/JE8UUsGoSO+vK1hsIoI5sixCvft6aRSPciH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

--=_MailMate_59081F6E-59FD-4E97-8B86-B6FEA972B6EA_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27 Feb 2024, at 9:11, David Hildenbrand wrote:

> On 14.02.24 15:34, David Hildenbrand wrote:
>> On 14.02.24 15:18, Matthew Wilcox wrote:
>>> On Wed, Feb 14, 2024 at 12:04:10PM +0530, Charan Teja Kalla wrote:
>>>>> 1) Is it broken in 5.15? Did you actually try to reproduce or is th=
is
>>>>>   =C2=A0=C2=A0 just a guess?
>>>>>
>>>>
>>>> We didn't run the tests with THP enabled on 5.15, __so we didn't
>>>> encounter this issue__ on older to 6.1 kernels.
>>>>
>>>> I mentioned that issue exists is based on my understanding after cod=
e
>>>> walk through. To be specific, I just looked to the
>>>> migrate_pages()->..->migrate_page_move_mapping() &
>>>> __split_huge_page_tail() where the ->private field of thp sub-pages =
is
>>>> not filled with swap entry. If it could have set, I think these are =
the
>>>> only places where it would have done, per my understanding. CMIW.
>>>
>>> I think you have a misunderstanding.  David's patch cfeed8ffe55b (par=
t
>>> of 6.6) _stopped_ us using the tail ->private entries.  So in 6.1, th=
ese
>>> tail pages should already have page->private set, and I don't underst=
and
>>> what you're fixing.
>>
>> I think the issue is, that migrate_page_move_mapping() /
>> folio_migrate_mapping() would update ->private for a folio in the
>> swapcache (head page)
>>
>> 	newfolio->private =3D folio_get_private(folio);
>>
>> but not the ->private of the tail pages.
>>
>> So once you migrate a THP that is in the swapcache, ->private of the
>> tail pages would not be migrated and, therefore, be stale/wrong.
>>
>> Even before your patch that was the case.
>>
>> Looking at migrate_page_move_mapping(), we had:
>>
>> 	if (PageSwapBacked(page)) {
>> 		__SetPageSwapBacked(newpage);
>> 		if (PageSwapCache(page)) {
>> 			SetPageSwapCache(newpage);
>> 			set_page_private(newpage, page_private(page));
>> 		}
>> 	} else {
>> 		VM_BUG_ON_PAGE(PageSwapCache(page), page);
>> 	}
>>
>>
>> I don't immediately see where the tail pages would similarly get updat=
ed
>> (via set_page_private).
>>
>> With my patch the problem is gone, because the tail page entries don't=

>> have to be migrated, because they are unused.
>>
>>
>> Maybe this was an oversight from THP_SWAP -- 38d8b4e6bdc8 ("mm, THP,
>> swap: delay splitting THP during swap out").
>>
>> It did update __add_to_swap_cache():
>>
>> for (i =3D 0; i < nr; i++) {
>>           set_page_private(page + i, entry.val + i);
>>           error =3D radix_tree_insert(&address_space->page_tree,
>>                                     idx + i, page + i);
>>           if (unlikely(error))
>>                   break;
>> }
>>
>> and similarly __delete_from_swap_cache().
>>
>> But I don't see any updates to migration code.
>>
>> Now, it could be that THP migration was added later (post 2017), in th=
at
>> case the introducing commit would not have been 38d8b4e6bdc8.
>>
>
> Let's continue:
>
> The introducing commit is likely either
>
> (1) 38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap out"=
)
>
> That one added THP_SWAP, but THP migration wasn't supported yet AFAIKS.=

>
> -> v4.13
>
> (2) 616b8371539a6 ("mm: thp: enable thp migration in generic path")

I think this is the one, since it makes THP entering migrate_page_move_ma=
pping()
possible.

>
> Or likely any of the following that actually allocate THP for migration=
:
>
> 8135d8926c08e mm: memory_hotplug: memory hotremove supports thp migrati=
on
> e8db67eb0ded3 mm: migrate: move_pages() supports thp migration
> c8633798497ce mm: mempolicy: mbind and migrate_pages support thp migrat=
ion
>
> That actually enable THP migration.
>
> -> v4.14
>
>
> So likely we'd have to fix the stable kernels:
>
> 4.19
> 5.4
> 5.10
> 5.15
> 6.1
>
> That's a lot of pre-folio code. A backport of my series likely won't re=
ally make any sense.
>
> Staring at 4.19.307 code base, we likely have to perform a stable-only =
fix that properly handles the swapcache of compoud pages in migrate_page_=
move_mapping().

Something like (applies to v4.19.307):

diff --git a/mm/migrate.c b/mm/migrate.c
index 171573613c39..59878459c28c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -514,8 +514,13 @@ int migrate_page_move_mapping(struct address_space *=
mapping,
        if (PageSwapBacked(page)) {
                __SetPageSwapBacked(newpage);
                if (PageSwapCache(page)) {
+                       int i;
+
                        SetPageSwapCache(newpage);
-                       set_page_private(newpage, page_private(page));
+                       for (i =3D 0; i < (1 << compound_order(page)); i+=
+) {
+                               set_page_private(newpage + i,
+                                                page_private(page + i));=

+                       }
                }
        } else {
                VM_BUG_ON_PAGE(PageSwapCache(page), page);

for all stable kernels above?

--
Best Regards,
Yan, Zi

--=_MailMate_59081F6E-59FD-4E97-8B86-B6FEA972B6EA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXd90cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhULu8P/ijdY/enw2CrZJ6MqE/LhIQBgI8ErCl5wbSd
5SvjBdX+AZ+BtgEP4kFEYUKPoG7IjYPFZLIN/SelgKoH4Bx1+Vl1d/hu9Y62/DH9
TfMjU+DhD3ARbAQ+gIyqjKp7FK7I1SN00uQZiFLYTM7DuMkkpAhKIaA8bz8PmtHe
JjtUMSRSw0H/Fggb+AlTH4JdlPvQZWEUmKrPtT6k1tyIPWwD1Br0qhDdOTiGsLwi
jGQ/MouMHzDpLKUZj0JcIAqQomIFHNX+Z746mB0sgarhWzfTWmZk0LXtu56WXtPG
BiEjMhclZIlRo5tivYB5v4+V8CgLzY71nmElcrHHXhAJmIeLs9aaKid4TGOXRN2p
OKfFt2ilhqqMaZpMS2W6gjgBf963jZ3nvXXtFSPg9vE1FEaaez+ZL8BKYedktkWi
9Wi8deW9I7SaGh4sIizTmTYEkNr6cZ4RE4Ijx6SleQ0+RJpL/FA2JT9wYcwc/jnz
7biBHX3nfWE5S5dbYpCJY1JHf5UHABL6Wl1zG3oYCSrOL6ulYcroDzRqSQweoQLt
A497na1LpeoGikJF+vOpIivQaLo59gOzXbUtCcxK42Fjm2prmCFDxHnig3vSE4BP
OxWjHNJ+fZi2WHXmyiSLYXe5Najzh+waYehnTfK+Z9bWUjStDAn3XCLhR4ATV4Mz
5utz7KqV
=eYtj
-----END PGP SIGNATURE-----

--=_MailMate_59081F6E-59FD-4E97-8B86-B6FEA972B6EA_=--

