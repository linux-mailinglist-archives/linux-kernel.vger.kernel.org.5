Return-Path: <linux-kernel+bounces-150095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BE8A9A58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89051C21DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE7F161925;
	Thu, 18 Apr 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="VU6aGwsI"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639015F3EA;
	Thu, 18 Apr 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444451; cv=fail; b=Bmt/tCBLuHjGJOhhfJlTm3Ze3Bs3fW9eMKnwqvUvwtv/smyi4wr/hocykTimxMnDRXGUH076V1W1xsGmLgmIjF6B42ySTeAaNTOw62mOoQccDhbuB34Jb1k+K4QYnrXXdey9v4Loa3dPZkN6R9HNIOLE7QQ9Z1Bcv2Haa64W/XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444451; c=relaxed/simple;
	bh=/6kD84WrwSOJr3j/WL4Ss8FKlUJ0D0pW7E9e/WUojkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LlJLKQmMVj84UKxLIun7UVC4IQBHrHeIHIfKGpzjRrX+C9QYxZusPiD6vMbEj7BhhLxonwaBNnDW27TqHsoz8LS7J/sXxM110SRM90oKRhVXaJNK2CHMJjGAQDdVCQ+tjA2r7qPaf2+7jzLjxVcCA/i1B30HPSK+xA+Qirq9bVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=VU6aGwsI; arc=fail smtp.client-ip=40.107.15.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOIH8+Bw/8o9jWrDOEXs4LhdVlQS6dIrmZinN5f2cd36FxqXGZk5zINPOAms9M1o3/bbtQKR4sq81biHXi6//aZl+542P0fwl17L/uN9texMqhjbjRnYALbCXGNJd87BpczaaJqdlVvyJO2QZ1CQ6qjOHKVYKQElKSiVXGuhvw8OZdMyjH62am6rmhkNv69aM4p+8s7gBKRxnK6oGtghqEsppjPC1knouF5AlVfHRFp3wgrXl7zQANhc4uqauegZ94RXqbbJJCXqIxmfgYYFNUilTWXcl2UCbKsRtZEkfDSshyrxUPJTcHG3JAvYWGT/DPceEn0nMb2pjdwL3NcmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUJPPBJm8oQrxTiVon7EwVzTi5P879kGjYQ77b3IRs8=;
 b=kcw1y3JT+QbJoRm5TJp7EZDdIr4qLNkpALAcBOCFsC5R28/b5B3v0vYvg28YB4FOYhbga4aTIRRjzJlHTjZxzoryMad7YUab83m3BuRz8DgQvxS25I/nrq1AuSBVgQwFu0bAGYWFLVoZCWxyG5w8r8fX9cYIhXwt0uD61tZ/gjprSQpleNnJrLUX8uu7Te+nAEc/i+6bGEGgU5aqoYGL5N9rFFLszhr1fthKT773tklOT3x5q6HHDEbOihE5nW9tSdT0m6uNADKwxctvB1+IU0dUniOc2gFjLhLfsJx9+VjU01+bPTigHAEK3lHBLlwQ3S+9R1jzca6n4Qo/NJewDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUJPPBJm8oQrxTiVon7EwVzTi5P879kGjYQ77b3IRs8=;
 b=VU6aGwsIDUFIoS0kqBzYQlFbmi32t4038WReFYa9fvKB7BU18j3nYovq9WC4Ci8lSUAilVtm52f/Jbzy7c01eUKA2oJys4Ft4tvk2UHSLz+4EgSs7vhHv8sj51gF684Mro06I7L1hDU6+/875BmvTH556G4Zd7TMdZxSjZ5JKd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV1PR02MB10909.eurprd02.prod.outlook.com (2603:10a6:150:16c::9)
 by PRAPR02MB7836.eurprd02.prod.outlook.com (2603:10a6:102:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 12:47:23 +0000
Received: from GV1PR02MB10909.eurprd02.prod.outlook.com
 ([fe80::42d7:280:d9dc:e5be]) by GV1PR02MB10909.eurprd02.prod.outlook.com
 ([fe80::42d7:280:d9dc:e5be%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 12:47:23 +0000
Message-ID: <d9fe9fc1-1b28-4547-8845-399aaddc0863@axis.com>
Date: Thu, 18 Apr 2024 14:47:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Gustav Ekelund <gustav.ekelund@axis.com>, hare@suse.de,
 martin.petersen@oracle.com, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
 <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
 <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com> <Zh-hASYS4XkyNJc9@ryzen>
Content-Language: en-US
From: Gustav Ekelund <gustaek@axis.com>
In-Reply-To: <Zh-hASYS4XkyNJc9@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::34) To GV1PR02MB10909.eurprd02.prod.outlook.com
 (2603:10a6:150:16c::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR02MB10909:EE_|PRAPR02MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 656e0f66-9920-43c2-5b3b-08dc5fa5b157
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lNIJF9bTlhvASVw/zk7xLk2ijpqAws2YXEGraOOdhM9pUXLnSe4U1ZKjQ0Hyxo+b3RkGrrsf+BZRZU7YM0UpUA8sfONBBArr3brsMrQaRWjHkgD1IF6ay6qP+gvEhcRGzX44uDnadSzIUfznVtfsxrXqO+YcJcMNemcvl+gW5zNGuvHHPnf+ukjxwik/p65KZoIpBmbq9QLesngfr65oj/T3L0xr5/mLXjCvnvWXCU2MVciuSs8CZ99jY2sh2ySgM0BLMXVjcHwIrHjFzieGw8EnqS2PHmg7YR66ZDOR3eAFLR9fv7aKNqbeIcwTAn2NNQPNedV70KrugrQemtY7nE1NDdN7ZhvodtYglU0usN8mkQOAxnrsQqeNAInQWm1uO5DmK24qNjwWiR+nFqnVH6gv0R+c1vP0gOHk3MMI8ANQMfUEyuupm1KOwn0HvfqpycNG61Yn11eCX7biONV2wyb16JaCpxV9/ldfPAQr3kjc+WtOwGR8bzr8/Y5kuwjACRBwNWX+LyWO46fzTJpd//II7Btv+N73Y+w0bdoRJb5CUgm8o05CaHPDap9tz92tbhrmLcuc4TZrTDwSDtmmkUMigmeWueva0/Rg2EBX2eIJpVeHKnnFvW3B4kQ3XxxHfG6G1PCm5Yg8VsfxzuistKHz3UezdadqabYyWvSV1Tk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR02MB10909.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTE3RXYxbEt1VzBmQjdlOFloUTFwdDlUNDZzQ2VkTEhidlVQa0VvQmFJK1M5?=
 =?utf-8?B?RVZKY20xMVh0Q1lpWndTUVROV2E5WDV2TUFxbU15elU1L0FEd2dieDBHWHlV?=
 =?utf-8?B?MDlET2tTRE1Kcmd5dEwwQVNhQnlMaFl3TDJBQ0YxOG11MUtxSFZRcGNLWVZQ?=
 =?utf-8?B?SnFvMzQ1Wm9aN1czbHlzQjJQUEpBS2FmdGRBMEN6WHRYVDNMZFRFbG9velln?=
 =?utf-8?B?Yk9WUSszalBJQnJqa2VDUkxGU0JUZWVodmxvdkdFV1QyMWxOOW5DWUlZVjcy?=
 =?utf-8?B?K1BKdFVSQ1RMVktvNnVKbGNzT0VRTlB1bk1kcjJtbFh1SVJoRDhtcVFvYkpN?=
 =?utf-8?B?YklDOTk4ZGZiQmZxejhFYm1zTWY5anFVMmF1ODhzR3dScWdPYWREOUY5a2c3?=
 =?utf-8?B?Y1RVaStBNzRlNmZnU0I2Q2tJdFBJZmxpdjBMVVhlcG40TEtKOGRaVXk1djlX?=
 =?utf-8?B?ZlJFWjJQNXdUT014Unh2aVpkem9xREpRSlhvanBnaUp6bG5HeHlWRXlFYTZa?=
 =?utf-8?B?S2tWM3o2MW4rUi9HSG43R1lPVG5TSElRVTRnNjA0bWVWeGhkYXFJNytLQkpJ?=
 =?utf-8?B?Tk14Y3p2c1p5SUdaU2JOVzR1MjUvY3V1aGo3VFR3SEQ4WjhXYWdHc3NBa0dW?=
 =?utf-8?B?UTBBNGM0UCs0M2RiUXhwYXBHSkFUWkk4SW9XUDgxeXdFaURPTFkxbm9aL1Vw?=
 =?utf-8?B?T2VUb1ljTlRjczVTQkpQZ0ZSL2s3UVpNOVpoVjN5VENzTUNLK0g0Smg2Vjgv?=
 =?utf-8?B?eStIODQzYjA2b0dhMlIwRml3Mk5qZG5RdHpFbUJ3emxpK3N2Ni9WcDBmZE1o?=
 =?utf-8?B?NUYrcE5vV2VuYTFpRGJNeGZ2UTBDQWk0cEFrYk5meVZBeXJKdlNMaUVYTCtD?=
 =?utf-8?B?b2RCNmtuTGZBNk5saDBTelZSNDlKSjFPaDVkclEzdHYvN3RmTjRYV1JpcE84?=
 =?utf-8?B?dG1CaHhGeUc0RExpa3RVT0YwcGp1Z3d3V29zYU9NSVhkd1NhMnNyRXM5cUR0?=
 =?utf-8?B?K3drekxmTlc0cHRlTTQ5TDY2cldiQjNWVy9vMUNVcGFjdWpEZlhoNFRQdnVR?=
 =?utf-8?B?MXlpeXdzZWxuTTd2MXVUVmhQc29YK3QzRVgvSHc5a3VzcEdjSjdrTW1lSC9T?=
 =?utf-8?B?SkVLajMyTVNyODJ4aGFOYWVSOXRBNUF4b3V4WGdxRVpVWWIyM2pmd1UwcENX?=
 =?utf-8?B?QlFBa3FWdUNMNDYrNGw3N1pvUXBudFBKWTdHVjhOQ0ljSGtiWVhGNUFQaWlC?=
 =?utf-8?B?SHE1TmxqTllWQ3FybFh5eHZPemg4b2dxSFFSVmFZNWt4cUJOQ0o4dkN6OGEx?=
 =?utf-8?B?Qk5pWWlRSi9xQ24yeFNBMnBFSE1zMVVLS1EvQmZWaUREdDNRbVd0cncyQUs3?=
 =?utf-8?B?M2lIV0tiUFhVb2RkTXZsMjIxUXJ4RnZ1UzN0RVhjN1V4cThjOTZoLyt3V0x4?=
 =?utf-8?B?OFZrOGpmSFF2MHRGbExiYjVYQ3l1Q1VGSnE3UDI3Rkx4QXhTVjZaSTIzMXBt?=
 =?utf-8?B?YzVFZGJvNkR3c3ZybzIzRklQSVM3VDMyV3QydWhiRjFBNEgxQWczcEtTRHd4?=
 =?utf-8?B?QmdWcUxGY0tiajI1OVFwUExhVm1vL1E5emF1L0FIR3JYd3FNZXJxVFZaejgz?=
 =?utf-8?B?b2h2UWFmN0tYTW5sdS9ERFhZMGJMb0VTaHBJc1dESTRzS1pTZkFQSHhYVTVF?=
 =?utf-8?B?VEZTYzE3dXlZNTVWQ20wdW5sR3Y5SGE3SmN1V0FhLzh5eVd3eHk2c1llbzVM?=
 =?utf-8?B?cjRxVG9ZaVRSMjNoTFh6TUx6ZlZYTnVRcThsMzAzZ3AyVEp0emtWbGZBUzBu?=
 =?utf-8?B?TGhocmI3OER3SFdjOWl0Qlc0WnR2V0gwek00TzhuZXllOEkvYnVSRlc2WkRs?=
 =?utf-8?B?NlREMWdveWRYVWJuRlZWNWJCRXVmTzlPbTlDbGRZRmwxSXZ3dHU4dVZ4QjV5?=
 =?utf-8?B?aFZSVjFRa3RsUy84c21vc1dCUWxpQWJUaDdzdnozbndGS1dUYmJBVGlCR3RN?=
 =?utf-8?B?TEo0a0NMTWVkc200aDA0Qy9wNXpJNnE0RGhEWEFiQnY5N3dtWm8ydEVUN1Fx?=
 =?utf-8?B?NWtPWFZRLzllMWorMUxFZTRrWDI5ZzlhcVIxMWE3WXIrRW5ldXByZ1BXSGpE?=
 =?utf-8?Q?/UBs=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656e0f66-9920-43c2-5b3b-08dc5fa5b157
X-MS-Exchange-CrossTenant-AuthSource: GV1PR02MB10909.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 12:47:23.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0LPm3gkDHPa4v3I5tNzonNx032IwibYHSthEcLLG2WV5l5WdcFSs/7gahHb84TwspUBfjCfuuMDG7apC7Hz0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7836

On 4/17/24 12:14, Niklas Cassel wrote:
> On Mon, Apr 15, 2024 at 04:49:46PM +0200, Gustav Ekelund wrote:
>> On 4/13/24 02:29, Damien Le Moal wrote:
>>> On 4/12/24 22:48, Gustav Ekelund wrote:
>>>> Expose a new sysfs attribute to userspace that gives root the ability to
>>>> lower the link speed in a scsi_device at runtime. The handle enables
>>>> programs to, based on external circumstances that may be unbeknownst to
>>>> the kernel, determine if a link should slow down to perhaps achieve a
>>>> stabler signal. External circumstances could include the mission time
>>>> of the connected hardware or observations to temperature trends.
>>>
>>> may, perhaps, could... This does not sound very deterministic. Do you have an
>>> actual practical use case where this patch is useful and solve a real problem ?
>>>
>>> Strictly speaking, if you are seeing link stability issues due to temperature or
>>> other environmental factors (humidity, altitude), then either you are operating
>>> your hardware (board and/or HDD) outside of their environmental specifications,
>>> or you have some serious hardware issues (which can be a simple as a bad SATA
>>> cable or an inappropriate power supply). In both cases, I do not think that this
>>> patch will be of any help.
>>>
>>> Furthermore, libata already lowers a link speed automatically at runtime if it
>>> sees too many NCQ errors. Isn't that enough ? And we also have the horkage flags
>>> to force a maximum link speed for a device/adapter, which can also be specified
>>> as a libata module argument (libata.force).
>>>
>>>> Writing 1 to /sys/block/*/device/down_link_spd signals the kernel to
>>>> first lower the link speed one step with sata_down_spd_limit and then
>>>> finish off with sata_link_hardreset.
>>>
>>> We already have "/sys/class/ata_link/*/hw_sata_spd_limit", which is read-only
>>> for now. So if you can really justify this manual link speed tuning for an
>>> actual use case (not a hypothetical one), then the way to go would be to make
>>> that attribute RW and implement its store() method to lower the link speed at
>>> runtime.
>>>
>>> And by the way, looking at what that attribute says, I always get:
>>> <unknown>
>>>
>>> So it looks like there is an issue with it that went unnoticed (because no one
>>> is using it...). This needs some fixing.
>>>
>> Hello Damien and Niklas,
>>
>> Thank you for the feedback.
>>
>> I have a hotplug system, where the links behave differently depending
>> on the disk model connected. For some models the kernel emits a lot of
>> bus errors, but mostly not enough errors for it to automatically lower
>> the link speed, except during high workloads. I have not observed any
>> data-loss regarding the errors, but the excessive logging becomes a problem.
> 
> It might be interesting to compare the output of:
> $ hdparm -I
> 
> for a drive that you can hot plug insert without errors, against a drive
> that gives you errors on hot plug insertion, to see if this can give you
> a hint of why they behave differently.
> 
> (e.g. certain features, e.g. DevSleep, is only enabled if there is support
> in the HBA, the port, and the drive.)
> 
> 
> Kind regards,
> Niklas
Hi Niklas,

I mostly tested on the 6.1 kernel, and it is a quite peculiar hardware
problem, so it isn't caused by anythin in the latest 6.9 rc.

Thank you for the advice of using hdparm, maybe I can diff preset of
features between the models. I will share any interesting findings I
come across.

Best regards
Gustav

