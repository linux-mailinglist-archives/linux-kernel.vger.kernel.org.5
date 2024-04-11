Return-Path: <linux-kernel+bounces-141561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4850D8A1FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0748A1C22C90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16718021;
	Thu, 11 Apr 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="CQZVRskc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2099.outbound.protection.outlook.com [40.107.7.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6C175A6;
	Thu, 11 Apr 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866396; cv=fail; b=mlSJt7YTKzT3SYPIVVsEFr744AAn1gpceI4hKXr0mBO4RLFnrvdfe6U5cExPVK/kZqgC5e0WYobj7h3DK0hppTdtbdLNedCi5EM+D8svQ0TkBIRAH+srV0td3UN5asJuLBBazts46h5zkj/bVU1JSTqTiRmLhDC4LZ2OPbEfqkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866396; c=relaxed/simple;
	bh=UwlonlGFlPdqNJLv6wkxxNuAkV4ptILf8Ga7rIXaiKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oSV57xOzSFwSoGVPG6nEEM7BWaH0JS3nsxy4t+Jps9IJ5Vn6KAek7violizly0Utk2sB+e6lXpLmKqMlhhm8kRrQGc++OcCZ+F6hH/ICUy2iZTZmxwWdsz89i9GDZQS09wmUHAteeQa17zUi6N/gTsrnbs7aWZXDnUe8qXfcO7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=CQZVRskc; arc=fail smtp.client-ip=40.107.7.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1dKN+4NlS4uqv7YB5X83McWYLdGRioK0zU/upS1gOvL1TLro+QGR7NfHKqNW2WeuvxzssGETGSAhhqIun2/eC/O8XbD6FoqkildZC/hT/Dwwyi106m/DJ4e3S98mWBbbVyARiasu22f0DflInX0Dm3RvTlbwpoxTYqSCxEVGJTYZ8VLJ6QSbS3GwrxYhuZAqIwm/cTveABQtL3MlyijJVBLWG08TeqjyrnL/XRIaAcwBSNYO4zbxoZoswuLJm9N4j7vbrwnFZXN1G1IvkrsGSIY/L/+tCVCnnYWRq1h9HOEJLvdLUoZbCXdr/pxnMopRvZ5a3/c0sQ4sThLHQiDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMrRfeWqVUCYHP3ITC4wkP9iDR2o4VSOBh55jFFJOcQ=;
 b=EZmCb1Qgxoq9yqca2xXgxsKE4vHD6mlPfZKe2wNdSm3vPOmHHVfvSVPfDRqtFufFg9ZciupAR0Ded+SlAn5Gf0pH6bSQ24LfBqUQk2eib0KiXJW3n5Ew7pXBiFUSSkqSFzC/4ZHTjD7/xaSm1KN8yR2XD8YR8rHvlWehYuLS3Lit9/rmuGpy2/WsTsrZTR05Q4l7fLmgV6QBxGpRpERfC4eO76To8h8qn2UP/KTyDC8n68XYKsmwtXeChnhg/6f0yYx6nu/Pj1vH+wM8ohOqFOL8Ohom2e+6I58zXhiOZGezx8DOvNYvYxhW+1klJQ7nOE3b8Ey8WhIOZZC9s+uzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMrRfeWqVUCYHP3ITC4wkP9iDR2o4VSOBh55jFFJOcQ=;
 b=CQZVRskcl6BSqEjsrHTtf24zahej83Hzfi2WVvkP9dLKlnhBO+eWuVDjN4smRdLjmQZqCKWtTlINd/3qpnx5GwO82+MTbyp21NP4B3ft7muBA4vtteSKvmsw15UItYI0zxOTQtr9BAuah7HSzp2H04XlKH/X1KA7AUZ0DoVGu98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB8PR08MB5307.eurprd08.prod.outlook.com (2603:10a6:10:114::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 20:13:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 20:13:10 +0000
Message-ID: <d7ec1064-b82c-4721-853a-06b5710fdffa@wolfvision.net>
Date: Thu, 11 Apr 2024 22:13:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] usb: typec: tipd: fix event checking for
 tps6598x
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
 <20240328-tps6598x_fix_event_handling-v1-2-502721ff705b@wolfvision.net>
 <ZgveG5Ly3mw0O0eo@kuha.fi.intel.com>
 <b6bf7f8e-7d46-4b70-930c-9483f13fd80a@wolfvision.net>
 <Zg+fD6w1MykCsEe6@kuha.fi.intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <Zg+fD6w1MykCsEe6@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0013.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::25) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB8PR08MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bf64eb-64c9-4963-21b8-08dc5a63cf15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j35TLhLdJoeH8PaJxPKG3X+tEikgaIXvUVaZ1P6+LMqlxOW0sAx8xk+nv2tRbXBn9qbH4uejmgW4Jo5epqNWQxAGe5KT9++FoYpFxUJ7O/uK8JyRrIjw7TGlhpXTYRegSSevmQPQFF2kvQSCdUYwpXnkG1KUZw5azosQraRsAfnOHkSRcOxWt1yPtLOlH4nT15BsX/omUfYN84QS1ptRa7JCWmQPIZmB+fv6fPFAMQOvlaCmGjD59vuazrDGXGku07cTFYGfbB+JW9t+9i6WwYhQK4hm61IAr6Um4o6rUN18kTkwkwfMpGPS50jZHcBsFlcJD0aaa01dPJ5t+xsYgLWzR1BopydsDHVVTapLJLEVT36/e9YEqy1oZkjtGbbSDXQz+Nsb881dHtutcKPVxVVWT1rYi90201xN6lnqWvmB0tuCWRYj7S1HEN755BnNPndm1Tk+wnxYmna9zJ7vLyFeEyGR+DAjyptn67bdqKK+E6kH6jxAv/Lp7sv7UJ2kUeEReLr4Iuf/WkWy9PoxDfAUOQ/bHxTJWDSrnjW23EgKVzBoBRBdoAyPA7h2+s5XAcMWbgtnAw8gMTFmzFQcrg90To6zKHPld6o055glN8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWI3VmIwcy9LejdhTFpONUJ0Y3lSS2hyY3Q4dFpMY2Rwbnl5QnV2am50SUMx?=
 =?utf-8?B?cEoyc0RRMklCdDJRQzNJU2kvMExYZzFnWVJGenkvZjJPUjg3cExJN094L1VP?=
 =?utf-8?B?eHBneFVEMVVVOXlXbGhPZ2xiMG1zTStQUDNOcjdrYjRVZ2Q0RUQ3RDdTd29Z?=
 =?utf-8?B?SUNPa0FCRElvL1dRYVhYTlRGT3BqSzFjcFZOb1hsTFF5MG42UE1hcnB0OVIx?=
 =?utf-8?B?RWRnWFlkaStLc0dSQzhtOWJkY0tqRlQwcWNTQnliRk5GK2d4dlFtYnhDRUJJ?=
 =?utf-8?B?SVcvZk5BdFl4SlRZQnAvdE1MV1NPSVp0VkMveXR1bGxUdUlLcS81WFp4aS9P?=
 =?utf-8?B?UXh2ckFkL3Jzak96b3RCQVpHTzdrV2lVQVFobFZ2cEw0Vzc4MjZDelplMUdm?=
 =?utf-8?B?TkVOUStHZTdFZm9seUVTU1VVYlNPNGFoaHlnbTVJR0pURUFmMU1LaXBzbkRh?=
 =?utf-8?B?RlB1bUNmM1VuMzhHdmJDbWNPMDhjTHJISUtyei8zSlR5b29SaFV3TWdqSUYy?=
 =?utf-8?B?TU1BTmdkQWtocGdzZllJS0hIaTNnVk5Cd0VqSjJiQVpKT0x4NTNRaU5FQnJv?=
 =?utf-8?B?dG5vaTZJN1kraUlnWVY1ZTRjemxXMUlVeGR6U00yckt0aUtwM2U1c1RrN1lT?=
 =?utf-8?B?dldQQVhWVTJSMzhsVndSSjZhdTJQWk5CS2NQejk2aCsvbHp3NGxhT3hndnlM?=
 =?utf-8?B?Rk1GSEYyYlZ5bFNyMWZteUkrRy9mRUpId3ptNnhockdrZ25GWjE1VythRWpy?=
 =?utf-8?B?cERLM0t3eWJpVW5JS3VaOS9RSnNVcjNRRlgrekduMGdmQmkwenl4dmw0a1Ra?=
 =?utf-8?B?Yi9BSFVZNHBOTTBxZjdtS1VKNEMyaXh4NURYaHlvYUEyMmVDOS92N2VIOTJH?=
 =?utf-8?B?dUZtVTdKT0ppK0pJSzk2NUhKbVlmbkxJQUpUaDNkeEN2UmovbXUxamt0NExa?=
 =?utf-8?B?NFk3MXd6ZkY5UWFESzVVdXBPTnNVQ2M3NTNzOWVQVU9TVStVYUtRdkpuOTJP?=
 =?utf-8?B?Mk1CbGVzVmdDbzFwbEljdW44eXVoUCthTTJ0eVRBVHVjTzRuOVB1WXpzTnlC?=
 =?utf-8?B?VFNNSms2ek1LZVJVQmVFV08xTVpORWU0NVdtSFZGcE5iZzVGSkd4eXZMOTdS?=
 =?utf-8?B?NGNWK0JrZ2RRZXBVZUVUN1IrUFp4REZVcWZJQjZFWmtFZ0JHQXZGUEdDT2o1?=
 =?utf-8?B?ZDRiUjB4dTZRY2RCa0Q1V1NwNVkzTGMxSWZkcy9DcEVDU1BFcURvcG5Zait5?=
 =?utf-8?B?R1pNSHRTNWphdmVrZmxTZVRzOGlIeEt2OGI2Z3R1L2gzb0JZUUtQZTZtQjRB?=
 =?utf-8?B?bDdBRzk1WjI1QVJHVGJBdjZDTmhHT3Z3RXpFdlJEMk9uYUtPenFrZmpYUFVZ?=
 =?utf-8?B?Vlg3L1VlNkVWN3VYRnJkYVFqVUpxWTRUbUVRR2hsVHM0WFovNFB0NlZQSmVt?=
 =?utf-8?B?M3kzSUoyVm1QN2s4S3g1MXVjMnFwRWZtNnFtcjhzajRrTG1VZVQyNVNLeHZm?=
 =?utf-8?B?RmhEczV3TFhpeDdPWTg0d2VhWldFV3hybEtHUHVsemFWbWVYdm1wc0t6YU80?=
 =?utf-8?B?RlYrRGxaSE84MlQrWWhFVFQvTHNscVZwcFU4YkJmeHRjTmxCYzVlcm95RXI2?=
 =?utf-8?B?dmtsd1A3RHVCOUJOdzdYVjFGVm1sRFhsS1NHc09BRlNnTUp0VlRuV0hOVjRt?=
 =?utf-8?B?cHF4ZXVlc2VuTGc3Szd0MGtIQ1JpeGl0d0J2RjBVWWIrOXFYeEp3YkhuNVJL?=
 =?utf-8?B?amJnckdyUmx0aUxyanE0T29QV2tQbGpOZWt4OVB5NTFVUGRHd0pvUkJTSm9j?=
 =?utf-8?B?Y2IzcnNyQ0VZUUw4dGRJUEoxcHJlanBsZ29qNVUxSU5jY0pTRllHLzNUNmVJ?=
 =?utf-8?B?ZXh4aFNQdmVIaVF2OTNpQlVVUlUvcGl2R09GSm1ROUJnSDAwa29oTTZhZnkz?=
 =?utf-8?B?YUN5dUNGNVpML24ycnF6ZlRjRGlCQzJuY0RKSXU2bks0NlRKR0E3ZHdzNHBB?=
 =?utf-8?B?dVN4T1VPcno4VFJsQndMeGkzOHJSNXo1TUVlQzY2SmdsUzB6UmtCRTNkMzcy?=
 =?utf-8?B?WWZ6Um5HK3lzL0V4Q3kvb0Z1VVBWYU8wczdqVjNxOUt5NmFWb3BEVWUxQTJM?=
 =?utf-8?B?bldHT3owQnFRditiQkI2dXp6OG13bjF1a1hmQmNleFozOGtyVWVhb3Y1OVFR?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bf64eb-64c9-4963-21b8-08dc5a63cf15
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 20:13:10.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyczT6U79Yn5a2m+7QXR/0khM3bEcjZkQlRXSmwIzk9+gcDmzaDP1ZKvoMPCmucGth4bdtN4PWN4KnnLEsTyr9d5CafCnW1+3W3uUu+U2cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5307

On 4/5/24 08:49, Heikki Krogerus wrote:
> On Wed, Apr 03, 2024 at 10:55:29AM +0200, Javier Carrasco wrote:
>>>> -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
>>>> -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
>>>> +	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);
>>>
>>> This is not going to work with the older TI PD controllers.
>>>
>>> The lenght of these registers is 8 bytes on the older TI PD
>>> controllers (TPS65981, TPS65982, etc.). I think we need to split this
>>> function.
>>>
>>
>> That is a good point. I had a look at the older TI PD controllers and I
>> agree with you that we should split the function to cover both register
>> lengths separately.
>>
>> I was thinking about adding a new compatible for the newer PD
>> controllers (tps65987 and tps65988), keeping the current tps6598x for
>> the older ones as well as backwards compatibility. But backwards
>> compatibility would also mean that flags beyond the first 8 bytes would
>> be ignored.
>>
>> On the other hand, the upper flags are only relevant for firmware
>> updates, so we could check those (i.e. read 11 bytes) if a firmware was
>> provided via "firmware-name", and ignore them (i.e. read 8 bytes) otherwise.
>>
>> Other ideas or improvements to mine are more than welcome.
> 
> I don't have any good ideas. On ACPI platforms the same device ID may
> be used with all of these, so we should actually try to figure out the
> version from registers like VID, DID and Version (if they are
> available).
> 
> thanks,
> 

VID and DID can be modified by the application firmware, but there is a
byte in the Version register we can use for this. According to TI[1], it
is guaranteed that the older TI PD controllers (TPS65981/2/6) will
always deliver AB = 0x00 when reading from the Version register, which
is 4 bytes long formatted like this: ABXX.YY.ZZ. The newer PD
controllers (TPS65987/8) will return either AB = 0xF7 (DH parts) or AB =
0xF9 (DK parts).

We can add some simple logic to read 8 bytes if AB is 0x00, which could
be the default as well, and 11 bytes otherwise.

Link:
https://e2e.ti.com/support/power-management-group/power-management/f/power-management-forum/1346521/tps65987d-register-command-to-distinguish-between-tps6591-2-6-and-tps65987-8
[1]

Thanks for your feedback and best regards,
Javier Carrasco

