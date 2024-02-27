Return-Path: <linux-kernel+bounces-83497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C705C869A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7700028DAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A14314534E;
	Tue, 27 Feb 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PACYjFyj"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49F145337;
	Tue, 27 Feb 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047250; cv=fail; b=oI4EylojpukNqk1tSjhnQX/rnDZIkUkWcv931ubSSJkay/Ar9PFlP9eAmOLClOAWd7H8wOMZohkitiKkz3bQKS+ASqDHqYqUN45xVu6dqyHe6jYWT9XVsNEbtdgXm4YELCXvzFUjlM5Pr+4p7SjulG9inKtSDwxl32CMeLXOS/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047250; c=relaxed/simple;
	bh=4dVRIJVvYxUhyUYiTlqoAc4znArz9Y9aSHJJ1psMTYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NXGiJCLCZz1kjylwX8LbI14Jg0GuzxcJxhyBM4KrdPqGYotlvzmGRV5bIatt1mMEDYiZSx5JzSaENnzxDTt0DHXCJy4yG5CH7zX0Iw+UdTnsIwGPstluaOttDcVEVWu9LnCXlJwqKrLEau/93ON3Jk/kPQ7Eq5Lcjv2etYtlwzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PACYjFyj; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V72uq8pOs9G454bIZHyPtERPD0n2YwZF3sMIshxtN5wMvlkIEkFA10UkcQH3jt7lyU0uqyEpr6cRR0uDyZ/cT21/h9vAfpi6ezWK4KeZK3CYGh9z6qv7gouPKMMKa5FjsmbM4G4rjuz+zM6+JrnoLup1E2JsxOjKuQ54ecLsxd1uaoSKj77JoxagvGaqvEU+TXHQbxqaGgvNbvTHwxeyDgJ79IpnzpHWhnlF/gHPm8+fpOght3KDDEPAZg9qxLGxr+zGs4BSKBpFWu39yjVPBwqea59aFaaJMyBECXlvvyFclhLzJKNjtu8ub79pOmW3SwGab1HUiHBE+PYIhg7VKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAZBDkemFj2dvYkPpLOyBwvdc9cac38RNhnsyXTtwDw=;
 b=P+67vZQu43nbr2TKnCaqMV5ViKwWFVJCCPpIeRb99i/TQh/GceTkh63BNqpJoyUcKEcMIRoQ44V3uJCMorqyryjHLOVDCxGNIlrNrvLhDXnyGZx0MzGuuQLBtkc/myhjJbICLTROSZgrI2IWF0Jgl4MtUzny7l2fzCdUqd+FZ8i9F4pODjYiv1gFVDEEOuka/+Sz6IOS9MLQExAyozi1wNgOXgc167W4Z7qW65zi2fkQUgt7Mvq1YfqVIQxOw7bE4tMkiHWzyJXgD8y2+YpIAL2nJfY+OUNoki1JXHyDu8C0qdHvsiIG9BcSP+RljYM0gEWzMRSzfgGxO503Gzj6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAZBDkemFj2dvYkPpLOyBwvdc9cac38RNhnsyXTtwDw=;
 b=PACYjFyj5aaWzYL7lAMp4NRVf3LAVDWXDdom0ZajY5e39/YOJOuGfV+eFEkQgQ1EQkCtR8ulnNupdEtxSDZjjiUk59cwt2FDkrWJd7qYsyMQPd6Dp1YIt4nYd5BBKwLGR+jEuXsBxr6QbKURFoReNausbb/uogPeJl5fpu/f3+Wcrh/UboOLSSS7nWPhw/e36mF1b4bNRDApW7KhMRBIymWjA+UjLUXQipcVE2vUZD6RzhwANHCHSrCJy3FeJ5hzU7e6GiVYBZVCb+kQ2ZFjlbb7fnP7phCrDxOQUZ3dNYYzj+N0NjMu04GihzTbefbItPbSgMRcR/S+t+VecgK/2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Tue, 27 Feb 2024 15:20:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 15:20:43 +0000
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
Date: Tue, 27 Feb 2024 10:20:40 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <ECEF5EF8-3328-43AD-9E0B-7AE325368CB7@nvidia.com>
In-Reply-To: <42be658c-cb13-4001-aae4-8d8275a84038@redhat.com>
References: <1707814102-22682-1-git-send-email-quic_charante@quicinc.com>
 <a683e199-ce8a-4534-a21e-65f2528415a6@redhat.com>
 <8620c1a0-e091-46e9-418a-db66e621b9c4@quicinc.com>
 <845ca78f-913b-4a92-8b40-ff772a7ad333@redhat.com>
 <bc1a5e36-1983-1a39-4d06-8062993a4ca4@quicinc.com>
 <ZczLoOqdpMJpkO5N@casper.infradead.org>
 <f2ad5918-7e36-4a7c-a619-c6807cfca5ec@redhat.com>
 <30ea073d-0ccf-46e1-954d-e22f5cbf69f7@redhat.com>
 <1ABD022A-35FC-4A6E-ADAD-36F3D745FB91@nvidia.com>
 <42be658c-cb13-4001-aae4-8d8275a84038@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_FC1AC4F7-9793-461B-8752-70EA006E5032_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: db0553db-6277-407a-30e1-08dc37a7a9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ze107wPo3BkW8vAgN1PX9F6MyZiAGd6koAADDqf7hdgBD/x2n4mB79qc6rNV0ylp3tH3IVoV3ctf3OXz/QQbG0KcGDreniMr+KbWuvrke+8Tbi4J+PZdOaUxWnxOsKOgP8aRpQSe5wvNB5/xNU3FEMIu/M42gCvznOihlwBnpnSdZVkgvZJkDeXu4/BPqNUazrCCxN8J1vCH6PYD1+dK7qTsudb/Qxos0j5KNoyVp10Vi/O9Wxy7HU6dzjIqiVAfuDGYweQ/CtVue8SX95NlORPt84TTCUHmsvqBac+m/ONPw0yhcOQv+0mXz1zmP85NM/ID5Ve6lzQiJ6b48uvPUqac6gp1cQVaxhtkwEwKbP5NWqIYJkiwu7Z02qaeDELsb2An7r3Up6L5NWvBmUc/ohEpNZR3w/0OgoAO5Vycget3l48ivd8qs6kcxtP+hGBa5BJHDXPB8EiNIYe0tmniSz5HTL6E+xT2aY4Y9mOZaDm3m2dRm0iwVFCXuk3rgVG1EJh6gmrWFynDxtbOt/ICuc9h3RbX4nixOGvEhF9vLRIHUsNLSHxTw203UkG24KfGWPZYJHGWGsAfsZTxX+heGMSgXp+LPzZHUVr6O6wFrIdLoYyc0ZvldRMc8GC10sUeVt2X0dQ4mOE57x90WitOsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RFeUIzNkxNS1hEVkcrbG1YeElNMXBwOEp5bFkyZ2lLeldsZEg5ZFZWZVJH?=
 =?utf-8?B?d0p6WVlPTkdTdENYYWlzbElScTQ0L0NDUHZNRzFia1EzVVVTM05Ka0RWUmNH?=
 =?utf-8?B?SHFrZmhHd210V0Q0cmlVcnY5cktHMHprYkVJblpvNDBvUFFnZFVXNllQNTZJ?=
 =?utf-8?B?b3JnUko3UDlCMEZiUkVDZzdHWjJUTURRTndaQktKUmkyYVdTVnVIbXJuT1Js?=
 =?utf-8?B?WllRdndLb0NlQWMrQXUxY2RpdWYwaDlKbU1uaWcwdE9LTjdVLzZqNGNpVHpL?=
 =?utf-8?B?b3VVZDB3VzVhZE1VOHo5ZkNXTWZDb3prSStsWGFQbG5zYnVBQ1VBY3NQWDEv?=
 =?utf-8?B?bFlJNTJMOFhUazZDK2tRVk11QTdsRTJ1K3hBU3ljV2k2Mm5EMW5sbXA5UFZ3?=
 =?utf-8?B?WlhzZ3RUdDBpUU8wU1hqSVZBOFAwSFk5c2NSeWpJYjhYbngzMGlxbVFhWUdh?=
 =?utf-8?B?RTgvUkZSSzJMd015OFNYcURLQ29GQVRubkFWNFlING1STTA2VDJ2WUpSQmhy?=
 =?utf-8?B?QSs5NE9odlhqb0wxdGFuOFBiOFh3cXB0M3IydnRpWVJwWlhoWUQxZEUwb2RM?=
 =?utf-8?B?bmRucXk3TkRjVmgvcHF2RHRuTVRkclRVK3IxakErWHAvVytyUGkwMVZlVk5Y?=
 =?utf-8?B?dDhvZ0I5U2JjNEFkYnp5czNuK1haZnFhcE1sRzVMSUh1YVVPc3poclhqVFVH?=
 =?utf-8?B?K0pVTDlzczVpZXEveXdZb2lHbms0U0x3RmdjVndiOEh0QlV6QmgxL3FBcWJR?=
 =?utf-8?B?UGlEMCtZajVTU1RmenE1dUJRSVJFQ1RJT3ZUbmxUMHE5d3BoTjVWbHA4T1Ri?=
 =?utf-8?B?RzJHRTc0YlF3ci9YQTFMbGc5ZENuTTg5THpDYnZJaTlGb0ZJa2JCa0R5UDd2?=
 =?utf-8?B?a3VBR2ZJdDllcDY3ejVjYWFXK2JaLzNsWCt1K2tZTnBIbnE5b0I4a1JzOENS?=
 =?utf-8?B?YjRBZFRPLzNhTlh4aUo0bzd2WVZYZ29pQ2dzckxubTNnWGFzb3c2SEJ0bUF2?=
 =?utf-8?B?NVBTU3g4ci96RDRMelV5UzZFMWlsVEdRREtpaEhjMXNiSnpVVFdObFUvc2Fs?=
 =?utf-8?B?alVKNzBjVjVoT2lXUjMxaUp0UmlQRXhobGpsdnJYTXMxWkt3a0Zkb3RjVjhl?=
 =?utf-8?B?Vjl4aEl0c3ZPZEU5NUZSVU45QllPK2hjZExwRFVtTHZDS0VjaEZpVjBJRmh4?=
 =?utf-8?B?OEJ0VFZOeFpDdmZybG9UTWY5ZWtYRFBMZU8zUlRrTU9ML1Jza29oWnV3bHY5?=
 =?utf-8?B?T2tIY3hvQVhuMlN2dkM2MGVDUjFiTUdPaEI2a09sTG8rbm9sSjJvM21GRXZH?=
 =?utf-8?B?WENFYmVKSjJqTElsYi9sNjV0S0FBTjBKUXpScWhMNFNydmZvaGZBdXVqTUFo?=
 =?utf-8?B?OGNaWmNPeDhDS3M4TVp6d0tueFlrUVlqMkcwVlhnTlJlRXRSby9zaUdlMUhx?=
 =?utf-8?B?ZTZ6ZWdPUVlRN2N1bUhXeERXWW9qUnkvQXRBMEhBQWEreG0vMklIMHBWZXpI?=
 =?utf-8?B?K20xaGQzVys1SnZ6MkgvaXg5S0p3V0FrYkNQbDZiY09RQ3VZMFBFaGlObkli?=
 =?utf-8?B?NmpMWjU0Z3I3QWJscHV4dUN3S2I1RXdDOW44bnY2cUwzbDZKWjJBTThaaCtu?=
 =?utf-8?B?UHg5d1ROVUJoWS9mcTJVbUZBenpKN0NBQ2NmWTUyMGVpb3lWTUJZNFI4cFdh?=
 =?utf-8?B?UzkzcHY0WDVVVG9OUVlKTU0yOE9IL1VEZGNTRDdRUERpUFJzbkxrVENMU01h?=
 =?utf-8?B?bzBwb3p1eE9WenBRUFl6YkNaN1E3REVuUW0vbEp0ZjJkTU5hTjhxWVlyZTZY?=
 =?utf-8?B?b0trV25aMXBncXZXOU80QTRranIxNFRReDVaUitGc2E2bTF0KzR6NG16WDVS?=
 =?utf-8?B?enR6M0krbVZGcytCR2pCVUhhRk1sT01PRHdCcGNRem42WkFSZHQxbGRjMERW?=
 =?utf-8?B?SS9EVFBCL0ZabHlYNU1WRFBod1cyNVBsU2pPaWIxZmJnLytnNENOT2tkU3hG?=
 =?utf-8?B?SlpVWlBYbjZBSnpQd2F4NHR4OFJ1NktHdFlTaW9kdWNwblRUVmtaSTRxcmta?=
 =?utf-8?B?bU1UOFhQbU83bzRDM2U5dXExdWVNc2RiT2FmQlJEa0drUkhrTStTM1h6bSsw?=
 =?utf-8?Q?Kgsw+I9gGOSmlhVIUIoK/KZAY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0553db-6277-407a-30e1-08dc37a7a9fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 15:20:43.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2VUqdBqI61aIhkmDnpszWaNMeb/+PeSWdf8pbohiDG5QT+WTIiA5WeMAUcqSuM4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

--=_MailMate_FC1AC4F7-9793-461B-8752-70EA006E5032_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27 Feb 2024, at 10:01, David Hildenbrand wrote:

> On 27.02.24 15:52, Zi Yan wrote:
>> On 27 Feb 2024, at 9:11, David Hildenbrand wrote:
>>
>>> On 14.02.24 15:34, David Hildenbrand wrote:
>>>> On 14.02.24 15:18, Matthew Wilcox wrote:
>>>>> On Wed, Feb 14, 2024 at 12:04:10PM +0530, Charan Teja Kalla wrote:
>>>>>>> 1) Is it broken in 5.15? Did you actually try to reproduce or is =
this
>>>>>>>    =C2=A0=C2=A0 just a guess?
>>>>>>>
>>>>>>
>>>>>> We didn't run the tests with THP enabled on 5.15, __so we didn't
>>>>>> encounter this issue__ on older to 6.1 kernels.
>>>>>>
>>>>>> I mentioned that issue exists is based on my understanding after c=
ode
>>>>>> walk through. To be specific, I just looked to the
>>>>>> migrate_pages()->..->migrate_page_move_mapping() &
>>>>>> __split_huge_page_tail() where the ->private field of thp sub-page=
s is
>>>>>> not filled with swap entry. If it could have set, I think these ar=
e the
>>>>>> only places where it would have done, per my understanding. CMIW.
>>>>>
>>>>> I think you have a misunderstanding.  David's patch cfeed8ffe55b (p=
art
>>>>> of 6.6) _stopped_ us using the tail ->private entries.  So in 6.1, =
these
>>>>> tail pages should already have page->private set, and I don't under=
stand
>>>>> what you're fixing.
>>>>
>>>> I think the issue is, that migrate_page_move_mapping() /
>>>> folio_migrate_mapping() would update ->private for a folio in the
>>>> swapcache (head page)
>>>>
>>>> 	newfolio->private =3D folio_get_private(folio);
>>>>
>>>> but not the ->private of the tail pages.
>>>>
>>>> So once you migrate a THP that is in the swapcache, ->private of the=

>>>> tail pages would not be migrated and, therefore, be stale/wrong.
>>>>
>>>> Even before your patch that was the case.
>>>>
>>>> Looking at migrate_page_move_mapping(), we had:
>>>>
>>>> 	if (PageSwapBacked(page)) {
>>>> 		__SetPageSwapBacked(newpage);
>>>> 		if (PageSwapCache(page)) {
>>>> 			SetPageSwapCache(newpage);
>>>> 			set_page_private(newpage, page_private(page));
>>>> 		}
>>>> 	} else {
>>>> 		VM_BUG_ON_PAGE(PageSwapCache(page), page);
>>>> 	}
>>>>
>>>>
>>>> I don't immediately see where the tail pages would similarly get upd=
ated
>>>> (via set_page_private).
>>>>
>>>> With my patch the problem is gone, because the tail page entries don=
't
>>>> have to be migrated, because they are unused.
>>>>
>>>>
>>>> Maybe this was an oversight from THP_SWAP -- 38d8b4e6bdc8 ("mm, THP,=

>>>> swap: delay splitting THP during swap out").
>>>>
>>>> It did update __add_to_swap_cache():
>>>>
>>>> for (i =3D 0; i < nr; i++) {
>>>>            set_page_private(page + i, entry.val + i);
>>>>            error =3D radix_tree_insert(&address_space->page_tree,
>>>>                                      idx + i, page + i);
>>>>            if (unlikely(error))
>>>>                    break;
>>>> }
>>>>
>>>> and similarly __delete_from_swap_cache().
>>>>
>>>> But I don't see any updates to migration code.
>>>>
>>>> Now, it could be that THP migration was added later (post 2017), in =
that
>>>> case the introducing commit would not have been 38d8b4e6bdc8.
>>>>
>>>
>>> Let's continue:
>>>
>>> The introducing commit is likely either
>>>
>>> (1) 38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap ou=
t")
>>>
>>> That one added THP_SWAP, but THP migration wasn't supported yet AFAIK=
S.
>>>
>>> -> v4.13
>>>
>>> (2) 616b8371539a6 ("mm: thp: enable thp migration in generic path")
>>
>> I think this is the one, since it makes THP entering migrate_page_move=
_mapping()
>> possible.
>>
>>>
>>> Or likely any of the following that actually allocate THP for migrati=
on:
>>>
>>> 8135d8926c08e mm: memory_hotplug: memory hotremove supports thp migra=
tion
>>> e8db67eb0ded3 mm: migrate: move_pages() supports thp migration
>>> c8633798497ce mm: mempolicy: mbind and migrate_pages support thp migr=
ation
>>>
>>> That actually enable THP migration.
>>>
>>> -> v4.14
>>>
>>>
>>> So likely we'd have to fix the stable kernels:
>>>
>>> 4.19
>>> 5.4
>>> 5.10
>>> 5.15
>>> 6.1
>>>
>>> That's a lot of pre-folio code. A backport of my series likely won't =
really make any sense.
>>>
>>> Staring at 4.19.307 code base, we likely have to perform a stable-onl=
y fix that properly handles the swapcache of compoud pages in migrate_pag=
e_move_mapping().
>>
>> Something like (applies to v4.19.307):
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 171573613c39..59878459c28c 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -514,8 +514,13 @@ int migrate_page_move_mapping(struct address_spac=
e *mapping,
>>          if (PageSwapBacked(page)) {
>>                  __SetPageSwapBacked(newpage);
>>                  if (PageSwapCache(page)) {
>> +                       int i;
>> +
>>                          SetPageSwapCache(newpage);
>> -                       set_page_private(newpage, page_private(page));=

>> +                       for (i =3D 0; i < (1 << compound_order(page));=
 i++) {
>> +                               set_page_private(newpage + i,
>> +                                                page_private(page + i=
));
>> +                       }
>>                  }
>>          } else {
>>                  VM_BUG_ON_PAGE(PageSwapCache(page), page);
>
> I'm wondering if there is a swapcache update missing as well.

It seems that e71769ae5260 ("mm: enable thp migration for shmem thp") fix=
ed
swapcache entry part, starting from v4.19.

--
Best Regards,
Yan, Zi

--=_MailMate_FC1AC4F7-9793-461B-8752-70EA006E5032_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXd/cgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUOKYP/jG/2qUkjfsll1aUVraknf/3kad+wx0x6UL+
BdlMTRElT/Pw+mdXEjBWafXnyq0D33e7l20lOc98ELy/UG/GPn0ShdaGrYvdFmts
GlmZ36+oc0htCNw5/ePSLBtHnUCcjHgCEk8561weV5z2VvcYKcRdNouMjxVw69Dx
87Pz/6IGQk+glSVWh5cvf3+J8ThHaR4NVC4E0n5FNuSeDmdGcbwlB4BlAO3BGP63
zbB/K64hz0se0AwJETPj98gKmMKm942FTSEEXdR3W7GpRU0kXe1WiJbkECT1DMol
dnIHKqJ+qOFF5HCmalP11G7l0EBMrtC9xOANupzhj++lbVxJzeMXuyeit+zNZjT7
eQ/tIuQj9A6IuRXHWaFCEdqeQALw0CrZaFbZbgwSUYO3buwQuU47YfLuPaxRYDr8
Smf4Wl4CYF+hbzHWAXTxmh8Sy/twVq4SGmrZSNYyCeQ4uA6z+yPuqqQWMCv9mr95
Zx6CYo1vSCJ3cAnjo/Pl1Hk5igTRdhYuB+ZIJFn16nwan8H2xISLYA6rJkp7F7vM
GGIRRGAsbfjWKsdv4ALDHEHSrxcRVzFrIcO1svbTgKd0SIAk8tPMgbDY/cfn6K9Q
c67xH6+Yn3tTfUELtRQFMIpr7dQeEpSyaOgNvsq8EOqrGqZnkwvtJi+bpGr/o+Fb
woH62DWc
=BeU9
-----END PGP SIGNATURE-----

--=_MailMate_FC1AC4F7-9793-461B-8752-70EA006E5032_=--

