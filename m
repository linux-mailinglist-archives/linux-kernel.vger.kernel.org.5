Return-Path: <linux-kernel+bounces-83583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F8869BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9764A2881BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9741487FF;
	Tue, 27 Feb 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxx5Duzn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50C1474D7;
	Tue, 27 Feb 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050566; cv=fail; b=or0+5H/BKf4oKTraKEpb0x20ggSps5S3U+3l42Oj5Cgw9dBmCPihJdRNZwkRSxHHTBklrJZneVzm0v05qzkfCrHqoTFVb5TOBiTAfHNl4bf59Pyhch/uIh/P1JF6UAbYf4EtoadhIcS0RpSoH2GcWdOQth4SJ0ETmsAaKrOCxT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050566; c=relaxed/simple;
	bh=t6WVAxN6yPfEo4tqy0axrJqyvlNtsebnZRQ8AXj3Z/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nv5aG1c39iHR/zIugGMKl5x3kTICPNrFnhlRp6EaE7OrooNMmpthN37xMTexpn+pktFv8Wc1xn4UFu68DiL7E4zwsLaZ139z4KDaNMhrfz8jCg5P83oA7YrvbXgJF8dIR7TPYHmVmaI3Hu4RbtFF1jCw9KV6Ic+dHjrQ3FMosu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxx5Duzn; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB2TIWzE72L4kKfOxhIBXAEJxKOrOTaZkO+aE6AZwt/Y/GthI2BPxmuUWnwFqQZaXbbrz3f3fMGJ8tz2u9yf4whHpSHEYF2kqmPkSOjZFM8ZMCe3DoUPckBHCaE5tb8T8T+Ob1AqAQnXRDp36VEdcPHM7J0y833H58Pd/0O18zEhcDqw7/eMrNuTKbjkcNxj/DjDPAoLe0XGkm4DG28UpTqghWTjs2tdkd74Eck+eNmCP/0a8i5ZD0VYkVmcVmFTT1srbJXVEgKKjWb+p5bqq+ofXhFWgAM8GQudUkBxamhgm73cC3Di8Kmn+9SExp39YeooOOrQPDlhD53T0tKBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96WnlZ75EL1sBV4VnG/+8LguK/gkMSgMrgI7MnHqDv8=;
 b=a1HtBzapOw7BfDtTEPiQO9f+UW+uh3vfu01rUs2ipyJZ9/u5zLKjo8JYFGKsuflFVzKucFI8bVofyEqlwTawx/0VF9Mp+6U4KpdCI4bhnSCtw4Ipiv/hrnbkjpQTW4TK32vzK0B4MIN6iN72U1qDhlcdX+m9eyvsiFbIcXSTXKhfwWEKxSBG1jsAI7i/JFS45mCIV0Ad95wFkbV2v89EW1aRXRlx8i9L/3soHLanUkEkkMovdEFUBXZ64p3VSsl5QB0FlwjaDYethgogM6HRagPNciJXFE1h+NG9Au3Kg/OpJgUQ9dbNZoylEjHNPQUW/Kxi15Hwv0AV1/THUdENyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96WnlZ75EL1sBV4VnG/+8LguK/gkMSgMrgI7MnHqDv8=;
 b=kxx5DuznwaLmZC62usKsniOGEXK6lGt3ICfbx75eWaxEYUOwTIT0G9IUJLAzRkCqGww5qGabmCtYxEwV+xJfOdLilYiwv2PsONlKjlm1gg1MW41RvFfZAJk58lGzYoUpkJxdKWR1EWh7jzL9jP5nIHyX8iwThRvC25qGCTZH3QqSH1V2mO3vT3Me2eYUCu335TZ5/AoL/LKUxD/pUZrT/9PJtinMNa4itOkBIjjP1LngxhN27fitSzZoHmuLCSNQCw8mx6K4ZB5BJ1yh1xfJEmDvXXcw9BcWrsoUdP7rJJr/EMIAvYa5SvxZVCI0X/bFvYoWMGRQkPEPZwXqj0zDkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Tue, 27 Feb 2024 16:15:57 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7316.037; Tue, 27 Feb 2024
 16:15:57 +0000
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
Date: Tue, 27 Feb 2024 11:15:54 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <07A26237-B17E-4418-9A19-E86F450B9695@nvidia.com>
In-Reply-To: <ECEF5EF8-3328-43AD-9E0B-7AE325368CB7@nvidia.com>
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
 <ECEF5EF8-3328-43AD-9E0B-7AE325368CB7@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DA2C71A2-E74B-4358-BDFA-8331CEF00115_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cf5d22-e958-47e1-9444-08dc37af612b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YMJqYbgV1yZib2Ia5yT3uqdYKld0Cow3JmxkR7VRD6eJiCDQbRVX5ClxDOBjgWcAdSL+KEau71ENFyyZStCLdx+oOfc5SyWX/9X4gWLYIv/b5jlTqP4cOpw3etPRopELmEeJwTKmQj63+aLeXosgxw54PT9TXdFyKZJ4pkw3KRTTqMVT0zWVVjD2QK13o8U3wOt82CCOFi8lIN75xmtTScggS0pHZBpe6j01yU6uAkZiJULL2FoEdBWLGHZDDdx/vyp8VhQJTkfpM+clxTwbKA3vB0blytQoK3j3lb5QSWljWy9euj++Fy84+9MEH2CSLfGNhio+6CTAUpNiN2B4ex7EotdCKHKwFWc7DLzbqDIcAYLwhWcuKAJXz0Y12m8nefJYLadw7ff2zDqoO5I5y3rrpw0+ljRDk/KORmOGg+gs4/kb7NYUST6HNtez23GVNzacf4E9cNexGM9amsTd4FrY3RbaRV/NPQjbGtOgOT7EO+DKUdiCkkqHTFVablp5jfgtSVjWJgQlDoI1OSOqxXUrpXqxfokIGQzjz7Nxmd7C2kZu5NQ/uIKWtPxSzynwNiv45tMHSNQX+E+7pZRTfPWUMf4NMb6yNVqJszFD07mxhciyHcPYlmU7c49xQWi6AQ5i103Ace2zDAxzskfFUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlVCejhvN2ZpaDN4MFZRTFFtc3JSNE1Eck1UTnBDL3MvZEhQSXJsVGwvSWxO?=
 =?utf-8?B?Zk43RExWN1VLSTJlTm5lZjltNC9iMUUxaWh5eXdOZkNoWGw1TWNLdm5nY3FX?=
 =?utf-8?B?RFlINHk5bkVJOTlETTdtNm5VK0tQSG92UzZPc0xiMFFIV2U1RmpOSHl1VHVC?=
 =?utf-8?B?RzQ0T0ViVm5laUFVKzM0ZzZwSWVob1VCL0N2MElpdVRHaFppM29rdWVHTTBz?=
 =?utf-8?B?UWlYNTIwejVmN25penhiZGs4VW5zVlhHVkRsTk5xRi9Ca3U4dW9ETm9GcUZv?=
 =?utf-8?B?VThDR3pQSjlUQ3RCUklMeGdBZlpJMkJSZ1EwQllNeGNndDNCVkM2WGt4SjBH?=
 =?utf-8?B?czVKSjdUZ0pvc0dCTTV5Yk5QN243T0JnUzlVUDNuMVJ3alg2U2Q5QlJsODZQ?=
 =?utf-8?B?UGhBWE5jOHdnQWlPWUhSc2J0SkJ1UGU3WE9JUWhSakFOU1doYW0xTnlOQ0FR?=
 =?utf-8?B?U2lPcElLVGZmWWJNN0RnbThIZ3ptZVdpWnJZRFBucjJMd0hZUWMyU0V4bkVh?=
 =?utf-8?B?TTIwOS8rakNudW90eHA4bmpITEdyYnlSV2svR0JidFY0WEs5MVlxVnAwMzNM?=
 =?utf-8?B?QXAyVU53T3A0TFZqRVIrd01DUXBXSjl3eGM5TVlsZTIxL25FNUNCOFh5K3hE?=
 =?utf-8?B?KzdrM3ZOb01GNWdlZysyWG93Rkt3ZlU0b3BqYW5kTjR4eTdPM0ZGaVpiT3RO?=
 =?utf-8?B?bmp1dHBQM2UwKzJ2bW1aMERxSmV6OW0rWDhOeVBteVJSWHUxOWU0all2OTIz?=
 =?utf-8?B?Ui9UL1BsVDZEalEzQk9lV1h0dTVQMXJNc2JOeFVsUXdlMlVlN0ZQdUwyUzNF?=
 =?utf-8?B?TnV2d3M0azQ2RUN6MVhpU1Q4Z0I5eVR2b1kxaE54YndKaUErakdCUHk4UEVI?=
 =?utf-8?B?cUxVL2w2MnB6bXRVb1hHTDBlTFIxT1d5TmZwOTZNN2ZMQ3FiMFNpUHdhQlNy?=
 =?utf-8?B?WHZZV3BxUnlVMEpDSGR3ZFhXajJ1bm51RWNOYmt0NTlXKzdvNFBMQ2ZkR0tt?=
 =?utf-8?B?VjlKb1AwTWwvTk0yQVZuRkFiOG1aWHUreHV0R25VOVgraWdSMTFpMjJGV3VZ?=
 =?utf-8?B?S0hNZzJYeHB2b1k1eXlBMEVaYVJiaVM3SjFsaHpUQUN4REdiVGliMGREMFgv?=
 =?utf-8?B?blR1TDR1b01pa28rZ1RsbnNNeHlKSlVVZWhMcU5zSTVpWUJiRjkwaS92M1BX?=
 =?utf-8?B?dGZYNVRCOUVvL0cwdUVBaHgvcGp3eFcwMFM2MmJLNjhlTDYzRG01WVdJQXJW?=
 =?utf-8?B?NTZISnBuRVZ1d3lnL3BVcUMzd3dGTGNERlBpSThyZDF4cVF5dUVMMW42UkpB?=
 =?utf-8?B?eVRqcldjcDhISUFLUG1xcm5QRnd5R2l6RVdnNWVIS0htY3NYNmY5Q1NzVmgx?=
 =?utf-8?B?bXRzbEo0ejliTHdVTWd2NzgraHJWSzhiQVpJQmtxLytvUVhSc1lvSFZ5d0hP?=
 =?utf-8?B?bytLOGF1Vmg0V1VhRFBXOFFkL3M1a3RlVWtYU0w0eDc1OGhWSGhiL3dMSVBZ?=
 =?utf-8?B?KzJHZzNrSzZEWmw1T1hlTm5zZFZNZWROUDM4T0pROGF4RXRuUllXYUkwbUYr?=
 =?utf-8?B?SGs5d2g5MWFLK29vQ3VSWFZYdW5KMDlXdENvaWxGZE96VWZrSFpJalhYamc4?=
 =?utf-8?B?MzB3WldCZlVIL0U4V1NvZW1VR2dCejgzQ0dhTGlmVmpFNWVldC9GWDFPeXFp?=
 =?utf-8?B?NmEyMEV5cHV6Nm45ZWk3OXBlSEVBN1ZvNFMrZkdiL0QwNmx3STZDNnpkTGNG?=
 =?utf-8?B?T1pkRFN3cFRkTTJsUHgvQkRHWlh4K1A3SUs2RzIzQnpHWjBjaUlDK0xURkhY?=
 =?utf-8?B?NFJZRUhEaUJVcWlEa0RLVkdSMlJZWVZNenFLS0xjeW5xeXRlOE4vR0RyeUYz?=
 =?utf-8?B?NDNmdDNEYTdXZHU1ZVIvdDlNdXdwNUpKY1greWpTL0FQSi84b3dHUXZQSjdw?=
 =?utf-8?B?aVh4UGg2VWVzRklhY0pyeWJ1Q1ltUVVySGRiRm00Wnl6Ym05UnZHZ0ZwN2ta?=
 =?utf-8?B?VERobVowTGpJNWhqdm5ETTVtTnVjWFNyQ28xcStEWmhUQnUzVUFEUWt5bC9S?=
 =?utf-8?B?OEFrUG1UZmxkV3BpMzYxQTFYVzZ0WVdyaGl4MTRWYVVtUTh6dkpsUTVoOXRY?=
 =?utf-8?Q?cGvABnFriEGZ4PLm536Kv3uXe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf5d22-e958-47e1-9444-08dc37af612b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:15:57.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcY7nh61R3C/ykUXGPHoQEudGNRpNvL2tNHAN6R2OwCjhD/9RktvuGU0M5zEq4pI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948

--=_MailMate_DA2C71A2-E74B-4358-BDFA-8331CEF00115_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27 Feb 2024, at 10:20, Zi Yan wrote:

> On 27 Feb 2024, at 10:01, David Hildenbrand wrote:
>
>> On 27.02.24 15:52, Zi Yan wrote:
>>> On 27 Feb 2024, at 9:11, David Hildenbrand wrote:
>>>
>>>> On 14.02.24 15:34, David Hildenbrand wrote:
>>>>> On 14.02.24 15:18, Matthew Wilcox wrote:
>>>>>> On Wed, Feb 14, 2024 at 12:04:10PM +0530, Charan Teja Kalla wrote:=

>>>>>>>> 1) Is it broken in 5.15? Did you actually try to reproduce or is=
 this
>>>>>>>>    =C2=A0=C2=A0 just a guess?
>>>>>>>>
>>>>>>>
>>>>>>> We didn't run the tests with THP enabled on 5.15, __so we didn't
>>>>>>> encounter this issue__ on older to 6.1 kernels.
>>>>>>>
>>>>>>> I mentioned that issue exists is based on my understanding after =
code
>>>>>>> walk through. To be specific, I just looked to the
>>>>>>> migrate_pages()->..->migrate_page_move_mapping() &
>>>>>>> __split_huge_page_tail() where the ->private field of thp sub-pag=
es is
>>>>>>> not filled with swap entry. If it could have set, I think these a=
re the
>>>>>>> only places where it would have done, per my understanding. CMIW.=

>>>>>>
>>>>>> I think you have a misunderstanding.  David's patch cfeed8ffe55b (=
part
>>>>>> of 6.6) _stopped_ us using the tail ->private entries.  So in 6.1,=
 these
>>>>>> tail pages should already have page->private set, and I don't unde=
rstand
>>>>>> what you're fixing.
>>>>>
>>>>> I think the issue is, that migrate_page_move_mapping() /
>>>>> folio_migrate_mapping() would update ->private for a folio in the
>>>>> swapcache (head page)
>>>>>
>>>>> 	newfolio->private =3D folio_get_private(folio);
>>>>>
>>>>> but not the ->private of the tail pages.
>>>>>
>>>>> So once you migrate a THP that is in the swapcache, ->private of th=
e
>>>>> tail pages would not be migrated and, therefore, be stale/wrong.
>>>>>
>>>>> Even before your patch that was the case.
>>>>>
>>>>> Looking at migrate_page_move_mapping(), we had:
>>>>>
>>>>> 	if (PageSwapBacked(page)) {
>>>>> 		__SetPageSwapBacked(newpage);
>>>>> 		if (PageSwapCache(page)) {
>>>>> 			SetPageSwapCache(newpage);
>>>>> 			set_page_private(newpage, page_private(page));
>>>>> 		}
>>>>> 	} else {
>>>>> 		VM_BUG_ON_PAGE(PageSwapCache(page), page);
>>>>> 	}
>>>>>
>>>>>
>>>>> I don't immediately see where the tail pages would similarly get up=
dated
>>>>> (via set_page_private).
>>>>>
>>>>> With my patch the problem is gone, because the tail page entries do=
n't
>>>>> have to be migrated, because they are unused.
>>>>>
>>>>>
>>>>> Maybe this was an oversight from THP_SWAP -- 38d8b4e6bdc8 ("mm, THP=
,
>>>>> swap: delay splitting THP during swap out").
>>>>>
>>>>> It did update __add_to_swap_cache():
>>>>>
>>>>> for (i =3D 0; i < nr; i++) {
>>>>>            set_page_private(page + i, entry.val + i);
>>>>>            error =3D radix_tree_insert(&address_space->page_tree,
>>>>>                                      idx + i, page + i);
>>>>>            if (unlikely(error))
>>>>>                    break;
>>>>> }
>>>>>
>>>>> and similarly __delete_from_swap_cache().
>>>>>
>>>>> But I don't see any updates to migration code.
>>>>>
>>>>> Now, it could be that THP migration was added later (post 2017), in=
 that
>>>>> case the introducing commit would not have been 38d8b4e6bdc8.
>>>>>
>>>>
>>>> Let's continue:
>>>>
>>>> The introducing commit is likely either
>>>>
>>>> (1) 38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap o=
ut")
>>>>
>>>> That one added THP_SWAP, but THP migration wasn't supported yet AFAI=
KS.
>>>>
>>>> -> v4.13
>>>>
>>>> (2) 616b8371539a6 ("mm: thp: enable thp migration in generic path")
>>>
>>> I think this is the one, since it makes THP entering migrate_page_mov=
e_mapping()
>>> possible.
>>>
>>>>
>>>> Or likely any of the following that actually allocate THP for migrat=
ion:
>>>>
>>>> 8135d8926c08e mm: memory_hotplug: memory hotremove supports thp migr=
ation
>>>> e8db67eb0ded3 mm: migrate: move_pages() supports thp migration
>>>> c8633798497ce mm: mempolicy: mbind and migrate_pages support thp mig=
ration
>>>>
>>>> That actually enable THP migration.
>>>>
>>>> -> v4.14
>>>>
>>>>
>>>> So likely we'd have to fix the stable kernels:
>>>>
>>>> 4.19
>>>> 5.4
>>>> 5.10
>>>> 5.15
>>>> 6.1
>>>>
>>>> That's a lot of pre-folio code. A backport of my series likely won't=
 really make any sense.
>>>>
>>>> Staring at 4.19.307 code base, we likely have to perform a stable-on=
ly fix that properly handles the swapcache of compoud pages in migrate_pa=
ge_move_mapping().
>>>
>>> Something like (applies to v4.19.307):
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 171573613c39..59878459c28c 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -514,8 +514,13 @@ int migrate_page_move_mapping(struct address_spa=
ce *mapping,
>>>          if (PageSwapBacked(page)) {
>>>                  __SetPageSwapBacked(newpage);
>>>                  if (PageSwapCache(page)) {
>>> +                       int i;
>>> +
>>>                          SetPageSwapCache(newpage);
>>> -                       set_page_private(newpage, page_private(page))=
;
>>> +                       for (i =3D 0; i < (1 << compound_order(page))=
; i++) {
>>> +                               set_page_private(newpage + i,
>>> +                                                page_private(page + =
i));
>>> +                       }
>>>                  }
>>>          } else {
>>>                  VM_BUG_ON_PAGE(PageSwapCache(page), page);
>>
>> I'm wondering if there is a swapcache update missing as well.
>
> It seems that e71769ae5260 ("mm: enable thp migration for shmem thp") f=
ixed
> swapcache entry part, starting from v4.19.

For v6.1, the fix would like below?

diff --git a/mm/migrate.c b/mm/migrate.c
index c93dd6a31c31..c5968021fde0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -423,8 +423,12 @@ int folio_migrate_mapping(struct address_space *mapp=
ing,
        if (folio_test_swapbacked(folio)) {
                __folio_set_swapbacked(newfolio);
                if (folio_test_swapcache(folio)) {
+                       int i;
+
                        folio_set_swapcache(newfolio);
-                       newfolio->private =3D folio_get_private(folio);
+                       for (i =3D 0; i < nr; i++)
+                               set_page_private(folio_page(newfolio, i),=

+                                       page_private(folio_page(folio, i)=
));
                }
                entries =3D nr;
        } else {

--
Best Regards,
Yan, Zi

--=_MailMate_DA2C71A2-E74B-4358-BDFA-8331CEF00115_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXeCrsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUa7kP/3IKAV9/nu+XfjV8UmHTIztYhpk1fiHEgtCf
IGrkMeTElmeBMmNPBNLxsTha8xBZQS2oDbr/p7RSMqS03g2+wjxsngvx2SbX3V9o
1L9VGg8hUJRivLuGH/ghqFmVBtEGv9o8iSCa1BkgsPae6fG7xWkDNLjJFJHaRTr/
u9NRFvsaFMKmVl99DbB93ezcuTRMCsqVMHpc1rmBmGRQskDNzjyqMaH3IYF7QtbW
+4th3tDdT2el/DCX96n7Bm14ApwqgTuOi2n69iVl+zY7kNurHj/Id/EX/8eyTIbl
HeIcdBj64zxTw9JtB0wMF6FoklLftzT5ZnWAL/irGJKkTW34rcOQpP5GhfL+T87I
VdcIYO8Otpmpcp3pElS1022IzGOHlaaprPfQWNqYoyPmwb8URD7vxeq5aGsOg5qZ
4GDtdL6dHjtjlTFMsc/CrHG78haTct3vwpt3ypMVYxQggNfanZO+hE5LcMCYmfG9
ABBSiWWhJCIXZiHYVWk3Brmx61EUWLM5dbhgQvsHOszYioKcXKEmN58rPBiseo3c
apSFU2pDRjvMmLq1AQtH4XlVZwsvC15eHouLLjsTsXjC9334RLWCdVESvgksqDPy
emOEbOAkFLttXsEYWSVrOalsASH2L6Ryn8EFgeYX20IAHYB2pT5nMXbp2DJfFON9
CBjhltzY
=3KrN
-----END PGP SIGNATURE-----

--=_MailMate_DA2C71A2-E74B-4358-BDFA-8331CEF00115_=--

