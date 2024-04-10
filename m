Return-Path: <linux-kernel+bounces-137813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE089E7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92261C2167C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD744C94;
	Wed, 10 Apr 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FR4i4TLE"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2171.outbound.protection.outlook.com [40.92.63.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94FA10F1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712714756; cv=fail; b=Zd8RPXXSrrouARdOmHzISMjZ6PH9kx7kQL6Baf/i/PkZ2nvr6Ets4TpUidDD4tSok+J34JdJf1wmczpGTtXaFRWPwolrLFrgHoVA1DmL8rw1Twf+ixW8uovRQbq+qpyBDyXdjRFFTeyJfmykP4CdgAYXiee/OcvKwDxvQENEaXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712714756; c=relaxed/simple;
	bh=IZgCoeQPDUOYowApyi5c9l5jrFA0+JD/mOUOSkMuac8=;
	h=From:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZxeQgJkhqi39HL+g+ha9+wA1kWG83V8HCeW9a1I1wqiNp14/eUOiHGWeZqXUWCcBt1zZptvqZyaL8X0yHqg7yGpplZkBZ/HeqJ8+xgge6nMyLshp0n9lWdl8bsRp4zI33MnLKwIxmjWSed5HAocbfJesWQlyoy5xoOT5wDsDSQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FR4i4TLE; arc=fail smtp.client-ip=40.92.63.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7XbGv7MOTAsiUqUZjgB0hCqNYBhpOowVtL5qG/ILkfMluNbgkobwrwuxEOZWLFB9Lx8TUV+P8KrmBzZAr3rB16mKfGWa6kLuFTk53Qx6JVOUjtxOhYqidGLjtczQj6UsXN00671hcqSbnwAWtEvBV6EYDxOXi39Xjn2nU4MRd+DtBrJ9jNaf5r6A9wnWvkOL6ScahTwsX4734NdYQGQwWdaFKj4TR3TWz5UhC4sOhntWsJeEr2f+HE4b84r32lODWw6pV6zatFYyu7AN/FgyHlejrAwzo3/EaQGlpLwCTxNMEiT6DsmDjr59/Ax4poJsjoCw/hPdabVJino6Psxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZgCoeQPDUOYowApyi5c9l5jrFA0+JD/mOUOSkMuac8=;
 b=QuYRUk+1K5Rl7SYpIgyzQxV8XlP/a8o6Lh869QZHPGwGmYsrtJivW+EfnyrWQV1Xq0if8ZzGNIKClQfcX7ODUIJ824Kd6KXMrjf04G1LLmXqglhV2oz6lBU84cuJ8EI2vTT71KhXcf7+4LigFEBF1YFMjJMgDh1skMSkOq4htbR2WClGw6leUpw9tJprgxPtmEu+voIaiNVcK/FJCUFInHepSpxO8julng3wo6kK+ovx2kV64+5uLRCcgM/Q27coTo5KlV2D5ZL5EL8ghtaRXfJc+HrhIEy6VWhe5BtAZbby5GdYb3UNjHHgf5FNKb8BK9O3FmA8SNNQ5zaYkr2x3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZgCoeQPDUOYowApyi5c9l5jrFA0+JD/mOUOSkMuac8=;
 b=FR4i4TLEyenfbLNAAnnDVvTY5FvI8P6P0LO1ACmtLTD4nhsdykeJjthjeSA6tSIqZ/cPk/CWIJZcEtDFC1KInbDYyiwYc1FLox7YRBJOB5PJp/0uoc+RQ3rbnEhcVwsrNPsGLzx7b9pSpx77lHb1H15kwutnbM/8PUP8qrhMWt3pdxkauPrxHIWRxxDKkf4mLke2UOKm9Hf6D4NHWRjfBVx8RlxUFOe4PcoDAhqWoE65Pi9iYfhqjAH8sKqIcDo83eBM4gtlD8QEwx5UlAoY+hkPjGnCplqGyP0vwhokiaFlCiUMd9N3u7gUIoOt/Z8So53+HaUOvVC9Em+8PNzsyQ==
Received: from ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:108::8)
 by ME3P282MB0994.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:88::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 02:05:50 +0000
Received: from ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9f2e:2acc:8692:8c4f]) by ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9f2e:2acc:8692:8c4f%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 02:05:50 +0000
From: Holger Huo <holgerhuo@outlook.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Holger Huo <i@holger.one>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 1cc4:6a14
Date: Wed, 10 Apr 2024 10:05:46 +0800
Message-ID:
 <ME3P282MB2481C1DC0506D154FA3AA3D2B5062@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <ZhWhshq7hpPd9XrI@kbusch-mbp.dhcp.thefacebook.com>
References:
 <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
 <ZhWhshq7hpPd9XrI@kbusch-mbp.dhcp.thefacebook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-TMN: [NMg0V3qOjA5pAed/TXZMF3wSEnAQwD2aJ6UW5/FKPHW7iMACiFAQdGNd+xJ+luIv]
X-ClientProxiedBy: TY2PR06CA0039.apcprd06.prod.outlook.com
 (2603:1096:404:2e::27) To ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:108::8)
X-Microsoft-Original-Message-ID: <5771101.DvuYhMxLoT@arch-thinkbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2481:EE_|ME3P282MB0994:EE_
X-MS-Office365-Filtering-Correlation-Id: 82604f8d-aa06-4ce4-e762-08dc5902be80
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qhFnuYCVO8P5qzOMKSNS2V1pd0XqPvGDDhnOoIAgVO3g/N9c96li7qQPEXqXmi5o116kg8M8Og58Rl4HLQAZu2EVQIdajcjQAL5w+w2NXcmrMH6kUuK0dwAlaXO08PNqdbypzjhM/VbzXKiHKjSamXiYflKCYPIyPq/R/BM7mhX+YVVeHsD3UrSymIi/5vy7VgnnYKYd5hTusUN3NBGzYJuazXJo/XH+u9V164O3Ht3pZRIwSLKra5bmjttWf1n3JDN1xyLuu/ZN2MzLanQqO4bxDoRn2sqwBIPLKsNZ8FjqbrodugnFQE94DMm5WfQOaM/agFYX1V1uwRlhae3XXMuisTFri2FHlxG7xkdbN57PybliM6jum4+m8ryQAXi8tz9BN+PBnrcEonZvvY+7D6MQu9cX1NC+C8J2GSwFUuS/pCErw5+eoJJTth2lSwepERXXJuE/mLGa+6JIrnkziCfDzP3Q68v/OUzvsG+Rc4CpJhP3dCaE45vAoamgZgMR3UnNisuzOrcg0c9MgrJoDrX+z5Q8n9gF3Rl9QIPD6bm3FDVA0xBoKIo5YeqmGaCx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEhPQkFldU5WME10NmJLN1k0WHB2enc0cVQ0S2psS1h5WUdMeGh6UDc2T0VR?=
 =?utf-8?B?VkVrUEIwTENyVE9wTC9QdUgwbG16YVNlVVI1Z3FZSnJSVnh1NTd6bTNBMEV1?=
 =?utf-8?B?dUFDa2tBVndlcWI0bEd4QzRuY2tVRVJlNGJLbFhIV013U052VXYvZ3VqdW1p?=
 =?utf-8?B?VmhZdlFqL0I5NVVRRktoTTB6MDJhWFg4ZzRrVW42aW9ONTM0NFpxcHVoMWhH?=
 =?utf-8?B?Wk1OdWFBbzMvajZBUFdhNTZ3RFpmVkc0U29KSFRVSURaMGo3NGcvUjZXV0pE?=
 =?utf-8?B?WEE1MEJ2L0J2VHVrNUhNYkJWc0RYZzlaM2xPNldvYXNFR044OHE5Mi9yN0N3?=
 =?utf-8?B?VTZ1TURFLzh3WW9rUTh1bGRjMXNVTHJLQW5BL3ZpM3ptSnAwWnFhUFlyTENn?=
 =?utf-8?B?NmpCU0xJbklCV3Q2TWlHUVBWanc4ZXF0Y2pIcm9uakFHNDVwREdNdUxubUwx?=
 =?utf-8?B?eGhUTVlFZGY1VGRya3lyM0FPRU0wL1k1ZkpCZGN2bU1Cbks0WGtqMWVDYURy?=
 =?utf-8?B?bG82NTFjc0FSWkh5TWN1cHR5c0RSM0JPVDlTdXB6OHBIeG45S2N0MExzSEps?=
 =?utf-8?B?OVBuQ09KeXRDM0E2MnRMbldScnFybnViYzczems1UTduSWYvOW9BZU1GMmVa?=
 =?utf-8?B?anFVMHlTZENucGd5LzVBd0d0NmZzVkhTZGR6anNUcksyQ04yRXNNcWMzVElk?=
 =?utf-8?B?SGVJR1laSkNURnFIZXRKc2FrM3Z6UmtKQ1VZWGE2ZWd1amxvdTM5VEVlb3Ba?=
 =?utf-8?B?WGlrS29TTndIQk1NVy9TVzBDRXpSZEZSaGlhc2pteVNrRW5oMVNaQzdpK1BE?=
 =?utf-8?B?WllkeHRiNWVBMVc1elBBVlFZZkNHVmQ4RmZuZFMwMzhOOXVkSXlvdkJKaC9j?=
 =?utf-8?B?aU5DQWZsWlovNWpvTHluZGpleU9qQ3NhbHQzSm1USFBvbmlRQkxxMDRVKzd0?=
 =?utf-8?B?Vmo2ZUdSUjkrckZrQVI0S3VlazlXaUJNNlBrMkxQNkg0Wkh5L0tjd2tIeTlK?=
 =?utf-8?B?MzZoenVqS0ZOaVk4aWNSdjBQbzhWdmlzcHc2RzdmSGpLaXBycXRNbXVhVEJX?=
 =?utf-8?B?SkZCZWNYZVFaY2hVamtSY241RVpBa3lYNCtKcEtsQUZ0RHUwemRwbklMb3d0?=
 =?utf-8?B?NlllOFBxaDB4eWlGOVJacHRxQ09aWlE1bkg1SGRNbVlFNFdaZDRmU0pEeXhC?=
 =?utf-8?B?RWhHVzZQbVlnNlJyZit6bXozM2RTbHJxSmU1N3JOclpuTmc5SWFWNFdVb0VC?=
 =?utf-8?B?M1dwdFRLaWx2Wms5RnR1RkE2VW15M0hBR3hQMWJnWlV3RjNrdUFiU0cwdVNN?=
 =?utf-8?B?bTlxQ0ZJTk4rSmJlMW1XNFdWT0prL0x4TlcyR0NRS3ArVklmckdiUGl4QXB5?=
 =?utf-8?B?SCtGZ2xhaEdYL09WcFFBZUwyS3RIV1JCZUoxVkFibk9XM0diMi9MMGpFRzY5?=
 =?utf-8?B?RFA3TVgrSytNMExNcExYNlNiRWtnZ0VhSjFqbWM2Zm5odGJuS3A3Q0QvVmVz?=
 =?utf-8?B?T1orSlUrejNrYnhORmQ5Zi9KSEhPNGc3UUhDb1haQ3o5YkpsS3NKK2J3Z0Zt?=
 =?utf-8?B?dElHRGNuREJ4MWFhL0VpUXJNcFBnS0dOaStsYzlNRmhqTUdYZU5qZERRaktj?=
 =?utf-8?B?RmVpRDB5UmdrMGxvUXliR0UzRys4QkNoYXVIcEgvS0dCeSt4R1Z3RTI3K3BG?=
 =?utf-8?B?OFRnWERvUE9TWkdST0dvK2s4d0V0eGJyMDVZaUJ3WDRsT0ExbTlOaGo0dXdD?=
 =?utf-8?Q?U2XbtVJ9AbmlPOV+GU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82604f8d-aa06-4ce4-e762-08dc5902be80
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 02:05:50.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB0994

On Wednesday, April 10, 2024 4:14:42=E2=80=AFAM +08 Keith Busch wrote:
> On Wed, Apr 10, 2024 at 03:28:50AM +0800, Holger Huo wrote:
> > This commit adds NVME_QUIRK_BOGUS_NID for device [1cc4:6a14], the
> > Shenzhen Unionmemory Information System Ltd. RPEYJ1T24MKN2QWY PCIe
> > 4.0 NVMe SSD 1024GB (DRAM-less), which can be found on many Lenovo
> > notebooks. This SSD produces all-zero nguid.
> >=20
> > Other SSDs manufatured by Shenzhen Unionmemory Information System
> > Ltd are likely to face similar issues, but I currently have no
> > device to test.
>=20
> Are you using the most recent stable kernel and still need this patch?
> These quirks shouldn't be necessary anymore unless it's advertising
> multipath capabilities, and it doesn't sound like this one should be
> doing that.

Yes. My current Linux kernel version is 6.8.4 by arch. After further=20
investigation I found these quirks truly had no effects.
But my nvme drive still freezes with Device not ready; aborting reset,=20
CSTS=3D0x1 failures and AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x0001=
 ...]=20
waking from s0 (s2idle) sleep. Are there any other quirks or what that I=20
should try




