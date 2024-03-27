Return-Path: <linux-kernel+bounces-122138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A95D88F29C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4957C1C28F63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B0153BFB;
	Wed, 27 Mar 2024 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="G5nixNe0"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2178.outbound.protection.outlook.com [40.92.63.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFA12E1F9;
	Wed, 27 Mar 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580701; cv=fail; b=di8TZgCPG9cmjiygrJOHVCrjIZO/2MtcHcYzAlCHo5gjlKhPVYSOhjvTz+sZalSWN4djhIZaxWUXZj9QmkG+wF/CxD1ONMNaVwX5axUW1f+koLzTgoOik9wmdjFvT8wsvJGGAq5BCGRqYCjcv+PPoNoYNlEVd0WHYzeMPSfI1Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580701; c=relaxed/simple;
	bh=M6VfBUKp8dZdfhbNGtAUVc/bat2LYPbJzyEWbtz9dWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NSEvbzlCGISj9iPXhHKiZjTFT6JQPTzAfY2IdQQGDSR/CT7BOI80zlkEbslHwoHwAPdcERNzcVk/iIlaxu6jQhVFbgcwPw316PmBOY/HzWHwTEDkDur8ao9APQX6SqNd+NZu9Qv6eLJ/U5l9xmAF1PhnXaEzuF9gRA8issaefbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=G5nixNe0; arc=fail smtp.client-ip=40.92.63.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJuckfZtB3SsfMwhlhPrzmLmKwFxv2EgtY30HGqchO4TwIzYCasg2/1dBShBlwthwh5FqYLBmCGps2gvES/wqm82gQNmUgizprhRNIUt5GJX2iYXJzD+VNGTZfTt7B0f4OdJAUkT26RbSYrrzIj2buTlqgiC/NTO5w03HepqwWeSi8wpzOpZ3MhJg6Uhn2ZSgWwiYorw5GRdy29Il7WhUP1j6A32FemRoTycEcvIYJMJ+jhQCSyaA3XcZ7Vw1sGY3S4oVGoE34YcgIBM3Yq5sr/8ozMzpB89gzDRjHwDYXOAyGodvjZu+uF/UEUw2hvI5X1ABr62Tjs4LyQCPmDs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brGpXINsfc/EJa5g2oYOJlnMT9HgrKNoo1R7XbQ1EbI=;
 b=g37ljb48FLOHygjM4nIGsCWW0VkyTj2X/I38/Ark9uTOHY9ZOkJi0OhBtxaPjqZha2NtktCyqQYHXwzaZxfrIDo03nxsNwVGjaCxT2EnV2Zde7U984bazGneIzcGGHwqQsXBG35h/ndB2l24IlhCIjipNn4wqu/T4rVlnqxPNXpekb5TzO8B9/VcGob0l/oBIKolq46Ie4M1ZbeEEvVc1XUG4spm239cR6eEo8Sy0sP1FT6hLF2TDjyN8UrFClN6Wm2vZzNy8gOpZEQwCRPtPBTvP83NP8j+FTEjXGWwNn+JXu9eN35TmcaN5IS/OIOPMcmw9J/9wHa1uvXuEbaMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brGpXINsfc/EJa5g2oYOJlnMT9HgrKNoo1R7XbQ1EbI=;
 b=G5nixNe0VBMe0JZU5lT+T7VP43qZECx0MiKG8KJ76WvfRiwkyncLeeoJZL0xZ+aV3yRLJo7ILnmVzF21Bm54mCSCtad2A0EM/4dveOToocd+AWJ8+CjEAhOui+r3zwWjoC2YS1adkeNe2FKJ1uf6Y3/iBKi/HKBYnd7Y/2ReEjAp1M2l/bRrVt6736gqXtc/XXzddB4Iv7fXcM5cp92RKrX7529Nivnf9L3zO24NjdKGbcYTDJ3WsVraup8mSXh2Ibx6mWKBYiFGeg+kZbu3nQo14mJdg1K/9pPsbpcnxYC3B1lAWtIDVq2m4yfLnFUvzdraX0Df1Mx82/jHb6Gbxw==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 ME3P282MB1201.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Wed, 27 Mar 2024 23:04:51 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 23:04:51 +0000
Message-ID:
 <SY4P282MB30637A1C21807E1B4DE3A226C5342@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Thu, 28 Mar 2024 09:04:47 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: thermal_lib: Continue registering thermal zones
 even if trip points fail validation
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <SY4P282MB3063EE2CC37BD0EF2318B746C5362@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <CAJZ5v0iogogd+AxL5ZPU-80Nj-nQz4avkymaPRPa4SiJdvBfjg@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB
From: Stephen Horvath <s.horvath@outlook.com.au>
In-Reply-To: <CAJZ5v0iogogd+AxL5ZPU-80Nj-nQz4avkymaPRPa4SiJdvBfjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [mK8aUBCw3FaA9r9U4J3Nh0WffLaKCFeX]
X-ClientProxiedBy: SY6PR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::22) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <805530b6-4016-47ad-9e45-d9a6edb4aa16@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|ME3P282MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: 2981fd4d-8699-4ba6-9261-08dc4eb24e99
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PUOJg6ijlazpF+DDLFfxGfJ9S5Gh6kXVvlocYYSrmzjepitfTVOWBEBFGNWtH27iF0Xoopb0342Cvvoi8pSs3qlC2J9UpudwtFxTq3+3CXvoMHqKNvSWm2rrj3UMBZkgBv2YFaybSTkKVdk0Bzdj3x01gvMZXeiwUcYF34ajIZvwWuTecNTEMRTO4I7lSIEceZrpf4qaFpWcde2FfffkyE9S4nQUIy69pLgYsRyPgpG84PZZuleJoellMCNpdj6BmEdEv029tKwjST9lIdgkrRiooHOhgx0UYame+hSo99xjD4P6rGIWFgmgq12jalHhJefwS7CB3HhNela+riGloTGNl27wgRjtIJgExXLwXU7lJNu6BJuYNWGodXx5Uu3mnQkyNqglcd78jh/VRtljnv35v4FQkQMXlQBEcaE2lYZKEHjZqjquRLWEm5r+/ypr0XS/SjJEnKFsZxnGdeawUkSfphV1wyN6CgdjQPiXbQXsE0ZjlknhyJFDRXoAOymIsHHBdHEnkUa88uZf7sifCqsYgj5oDKaACeAuKSRv9CsTymsaCGLbRsJo/K3iu/VbWb/hDBR3WNidYuTJ4YXt8VBg6pJ61ZUlUw/HzHc2EcryqsA3zBpR8wmsBrf7+Hhq/tSe4a63xr9RWTKCIh3HKBdYiCrk3QDYazWiK2W1kEA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFlzMGJZS1BxVlhyaFA5Lyt0ZlBocWNaNnVvWHNSR3dSSm1QZTlUQmYrUkFn?=
 =?utf-8?B?ajJxS1BvWjBaVk1xNlBvRTJ1WGY2ZEY3Y0VQa0hpOEhZT01YRnlhc0gvNzFk?=
 =?utf-8?B?eERmeXI2MFhSMDdRL0tNcnIySlZES2hDWGpXNm90OXpRRUQwblBMRFR6c1Nu?=
 =?utf-8?B?cHBZTXVuYXZ5dUxScWdIWkFJNzlNNXdjM0s2M3BKM0FBUFBPc3EvZ09NVjZY?=
 =?utf-8?B?ODVuay9NRDRhNmxoTDZiQ0tnWERLUVFLeWE3NTAxTVhZNlR6NEtwOTNsWHcx?=
 =?utf-8?B?Z1J4dnZQZ1ducG1JdXNHTVg0MWQ3dGtIVmloK1BMQ2diMnBtK1VGMXNNQmpW?=
 =?utf-8?B?bnFpUjVreVRsanVBWUJyWlZsbGVWMkhQelY4cmk2NmlFempmSXg3MVVxYkFE?=
 =?utf-8?B?UWVVbUkzdXBRK0NuZ0hIUEpwMUppWEpGVkNDVlNmMzdaaDkrb0wvWHFOYnZ2?=
 =?utf-8?B?eit0d1VOc1ZGUjlScXN5NGFKQmkxSmdzWjlFdEZmTUFKUlBPY3lvOXh6UjJW?=
 =?utf-8?B?OThHQUh4RFhGTjN6RmlBWXl2ZitPd3lPTisrTnIwQ2xBNmdGMkRCL2JzZ2t3?=
 =?utf-8?B?eERDRkRMZHZ1U0FJQ2RhcHJnUTVwVzRUd2FmZ3gzWmN1enl1cFp4OVNYMXRY?=
 =?utf-8?B?YnFKMS9ldURIbW1LMjRjR2hacW8xamdkTldQMFZMRW9CU1puWHI0V3cxWTd4?=
 =?utf-8?B?WHBGYXArcFpVMUlJNklyem1NZGwvTGVHc2o4eFVwWGI4Z2lYRHRLTDhtR1I4?=
 =?utf-8?B?aHBzWEhqUHpSUC95cVJOd3YzMmxuV0dwKy9rSUlUSVlOaVB4a2xtN3Q0Wk5l?=
 =?utf-8?B?NVlJRUN2U0Z1dzAyMEdnZzJoZ0ZjY0pKNzc2a2VEK0cycFFvc2RSNkl3anVC?=
 =?utf-8?B?VVIwcWVvZHNkV01xMSsxZnlRL2Riclp0amcybVJUaGNBbU9tVHhBc2xEQ3pX?=
 =?utf-8?B?ZlBBVWo3UkhzSFExTnJ0VUdockk4S01aRFlpcHY0WjFYSUJHU2psQUQrb3kx?=
 =?utf-8?B?STVMUC9NbThwTGN1cm9rRVpmSjZoTmJTTWp2Zk1pdmt2emYyM21aQXkwbGpz?=
 =?utf-8?B?emUzVDVKN0NHd2hsSXBISjB5UXZnUnB5YlNXQ1BtZkNFSEVwcWlkS1hRVXlw?=
 =?utf-8?B?andyaTF6SWJTNXBDNVBUTmtQblMyS29vN09VelhobC9Eakkxc0ZUNnhZdnEr?=
 =?utf-8?B?dWVjZ3NocnZkYUluMDl1K2pyME9CQ0hMQVFWWnFaL00rbm0zUjh6TmpEbGxj?=
 =?utf-8?B?VzZkbUVlU2VqbFora0xtQkM5bDV5bHNrNDVaTURUdTBQWTRMeUw1VUkraUhz?=
 =?utf-8?B?RWtidjF3ODNjZDhncis1cktRUEN0aFBnNGpaSWpnU0pVUG9uNDBlQm8wL091?=
 =?utf-8?B?b1paSjlrMUs1T1ZsOWtDTmhrSEZyYW9YdWVxWk9TckdrVTBvMGxmdVhPdVg1?=
 =?utf-8?B?blFNTXVnMXZYYzRqT0NoK25jN2J4L3BRTEdMMmJEVk04Q3BNdGdzUVNXNWtT?=
 =?utf-8?B?TUlZTVZDVmxld0Y4WUNtLzJKa3Y1dGN2TmlSWGUzanppbnNoTkNFeHgxY2Mz?=
 =?utf-8?B?bVgrNDlxVzJiVDNkSGxXNGlyNWxsWU1Na3I5aXdYOHlremE2T1pxUVdsLzhE?=
 =?utf-8?B?eWFFTW9wVnZlUlQ0ckUrMkZKTUxLR21oTUF4M1ZMZTFNeUw1RElnbkFQUUJp?=
 =?utf-8?Q?ybfKSYUgTNSn4bHlt824?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2981fd4d-8699-4ba6-9261-08dc4eb24e99
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:04:51.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1201

On 28/3/24 01:34, Rafael J. Wysocki wrote:
> I believe that this is a regression introduced recently, so would it
> be possible to provide a pointer to the commit that introduced it?

Yeah sorry, here's the commit id: 9c8647224e9fabb765019193aa43c054a638f808

I've also created a bug report with slightly more info here: 
https://bugzilla.kernel.org/show_bug.cgi?id=218586

> Because the thermal zone becomes effectively tripless, it should be
> registered with thermal_tripless_zone_device_register().

Cool I'll do that for v2.

Thanks a lot for your feedback!
Steve

