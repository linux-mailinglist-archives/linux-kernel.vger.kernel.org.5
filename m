Return-Path: <linux-kernel+bounces-148220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164988A7F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F41E1F21C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F612E1F0;
	Wed, 17 Apr 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="M1vousz1"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0BF516;
	Wed, 17 Apr 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345655; cv=fail; b=Yju1sff1DH1NmJzYokIyLIjgT/egfUejeG0mU5RrJXXoaKNTQZ5zh5FrEdesU5I66rOiUUejfoUp7hkFkXnGRBgeSv4zhB9XnqQ2u7FYdhvdo+pojb6dK2Es5H+MObRF5OEhdsrWePm3rZgCXJAAB3r85NQ0bnONHWLtVEfIHMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345655; c=relaxed/simple;
	bh=ElATqZDPowvgy7c597Lh45WiO3HcsXLmpKd+ea2jLDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u94dgUuPB7Cgz2WHzc4WYV5Ro8gv0DWRxZdOJJxuvLvZJ0eRPoGDXPqWUctmN/AfzzRil3oFVGlHkr0v6vUsNGNH265CrXV0j15yoepm5WZ/ZrhWmDSjvljPYH5ddT7/ffGW1QR7x0FWiDFfH2jjPdnc87fVDknsLdcBAJYcM70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=M1vousz1; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqgOzUSZ+Ossvn/Wx3fR8LTQvLYWdvrA9wNFgYj3catM2aLQSfqrnWZWviRUva7/esizIfxT1JnRztLpzmTSKPpaJizwv4nXBL09cAHfclxKt1sJm+UA1+k2HDlMAMWah3S191QP0h8SF9dtQSlSQQGJIGVAuDt967cv7B13eA0Cikvs+URpVtIzp7LYkvlctsyVQR4cJc+3ftJ2DGoOOkBcGNq1zQb/xd2ExzRSYdx8tOz6b73N155IMOkebvck6KnbHBFBdF2L5ldB7XnyQB7cLwlsj++ryenN5pWf/imIyTG5Q2xixEMxxQXcAtoPLwadPX0lxcySWtksthl6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vmUM6lZ3c2Q5r69CJdvRPEwRq4Pz8R+cauHkxOSVWg=;
 b=TTD41jCQDWrhrI9PZj7PhpL4IT/KvhNe2zTH+LBE/er5IYinDR528ZB9JerCSSt3gepQ6GmM+6/hRVZKIU/vg4NG6rJF6K3kyI0mpsaUj0yglOg1KRL9//vNRWQyxxT2qYUUmGPR+fJTiYItsPVCNb6wC8Ox8qC+6wG5JpLNVeqlT0jt6ikt5d1nUVf/J5aFaFTUoBXLKfujLrAHOFn8Xb12/4l8Kq7G/n17KUZWfilt2IjPvbtgG4Q+NC9MBr/asS6ecXk0CDQpoVRvNIZczFLeSsm6jSXckLU7YkjK44puKAMtS6t2jsQPV7ciUmNXmt4fRNwSfZKXO1ESXugxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vmUM6lZ3c2Q5r69CJdvRPEwRq4Pz8R+cauHkxOSVWg=;
 b=M1vousz17086YAVgBbQVdkmJf4ldt6M1apfoVWz4TMKTLN03klFuh3lsEtcKt14o0xc2hHF65DBvpVy10HSmdnJhbPvVWeoT3XbIacRASYNIoi+dvFrEoxcPV7XSxi6OBsCn34Q+BGZUmqCTGR6Fb3JDDTt9amZkmI3T3gxv48w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GV1PR02MB10909.eurprd02.prod.outlook.com (2603:10a6:150:16c::9)
 by AS2PR02MB10082.eurprd02.prod.outlook.com (2603:10a6:20b:646::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 09:20:49 +0000
Received: from GV1PR02MB10909.eurprd02.prod.outlook.com
 ([fe80::42d7:280:d9dc:e5be]) by GV1PR02MB10909.eurprd02.prod.outlook.com
 ([fe80::42d7:280:d9dc:e5be%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:20:49 +0000
Message-ID: <c12cf6a4-fd03-4049-8302-d798887d7cee@axis.com>
Date: Wed, 17 Apr 2024 11:20:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
To: Damien Le Moal <dlemoal@kernel.org>,
 Gustav Ekelund <gustav.ekelund@axis.com>, cassel@kernel.org, hare@suse.de,
 martin.petersen@oracle.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
 <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
 <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com>
 <898497f0-d279-4d01-be8d-aad4048df95d@kernel.org>
Content-Language: en-US
From: Gustav Ekelund <gustaek@axis.com>
In-Reply-To: <898497f0-d279-4d01-be8d-aad4048df95d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::10) To GV1PR02MB10909.eurprd02.prod.outlook.com
 (2603:10a6:150:16c::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR02MB10909:EE_|AS2PR02MB10082:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2c2b70-e437-469c-503c-08dc5ebfabe1
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Vi6wSigOPENJ9rzt/61BfyC4hyV+nliy4IMxQIxHfkIu1FKcbXAeDrEXoe1zhzQ5U5uJ6G1HpzONPiU09hF88+eOGDMqE84vqWGiDjZT9x3qtfkjDSv2xuEL71he/Y9ruOajo8GBm4Tl0iSdMAO8TTCTERzbpRe5HRPbis8AYUuCz4RjQokZrqGHTLmbBreXso/vTLtndcF1eiUpDuC1vvHeVtBlapx68RDQGzlzX91aVgIktq+nG2oYk6fzXFLT9GVl54knQU4HJqoZxv2cYkXqlR55EVAlN8k8wl2TYCpZydSzPxHxJKxR7QZ9GX5s0dHg9ln/SnoQu6gDnODLPWWQBQxqF1oxTV4L/xg7qUs8xtWdGz2JmNX7uvxRGz1Mdx2GEBI7bl3ROf9KnuCkpHq1IQbUwgftk5/2SDYM7zRYtuggmmfpV7QpTxl1UEaSe2zp8Kx1B7rp0E311NGoc67WVqjRZT+rORfUiPTIzgXgdMoZlo86J5y1ICMyx87AZby3jBHvXFNDDv/LhBr6m/9Uas16lD+4Wrgsl/DPlb3bFaSLoLYrFR5HNWEP0ATJTzrxutb2h8eOOfbubx3YUYzq7e/OP8yaOhdsAlrW329wpcxHfdt02YVLOQ9vKBAYcC57HysaFvQH6tF9kxPmecouXanLrJi2qQ9FfKBv7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR02MB10909.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGpjaVJlOXBPUXBCYkR6b0Y2REpYbERkMGJMM2FhS2ZGS0hHbG1mRHJCbEV5?=
 =?utf-8?B?azBSL2ZpQXY1b0EydG1ZTmxKaW9aYmorN01QMERxTEwwMlFMY3FpSGtBc1Ur?=
 =?utf-8?B?bER2RHZ1S3JFZGVpZUVxSDFqT29iUnRORGNBYlFEaXJBYUVlcDkwaUw3T2cx?=
 =?utf-8?B?Ly82ZmR1VDg0WUM0T0dhdUVRa1hvQyt4RU5PQVUvU1NybG81K0NyK0I2Nms3?=
 =?utf-8?B?Z2s2YXdkdDExNCsrWEtKRFF6ZnRKQW43Sm45T1pwT1JINFBkYmxKaXRwZXRr?=
 =?utf-8?B?SGZnNFRQSGNYVjJDM09TS3Y2cjdwS3F4dTFZLzJUOTlpRkgxZHgrOHBiRkF4?=
 =?utf-8?B?dEdiTUtJakViTUliMnY5aVF4RmNiTUhqbzJqLzFvdzZSUEsxVU5hTXlxaExv?=
 =?utf-8?B?Y003UjBJQnp4M3dYNkdKOStnTjUxbWt2SnEyM29sRC9PT0pUNDFGelNjWWtK?=
 =?utf-8?B?cndpV0RJemhobktvTThsUnVFUjRDeDdtbDZNMENyckMzcTNvWUJObm1kZ3Rs?=
 =?utf-8?B?NkZqMDhtQmZIK3pLVnVNUk12dUJ5WUVzYTB0cTlJakJpSG5aQXRKSmdEckw2?=
 =?utf-8?B?U1oyS3pFZ0Zoc1k1U0ptT1QzUk9CWmlTbU5BcGRqUVMySlh3SzlrOU9zdllL?=
 =?utf-8?B?ZURyUEYvaGFLQkFhaGErQ3hIdHJzOVBVbjM5RUJXWjI1YW5sNUNLTnpJMUR4?=
 =?utf-8?B?eHVKd2YzRkk3UWZjSGFDKzVEei8rc0V0Z1M5amYzelByZkp2andwYmNBTGdQ?=
 =?utf-8?B?N1FTN1dyR2lLRFJoWW9TSFhPQTFTeFpYSFA0R282bnl6VFpQaXUxL2wwSEJO?=
 =?utf-8?B?c1BqNGVuZTFabW1rb2tIUFRvcjQrTTNwWiszWW1hbnpVVXE4ckdOZjhkV1Nq?=
 =?utf-8?B?c05WTmdickFVaFhmRXBmR0x1d1dRTVZ5OHRkeUFMeitCa2pseS96MmtRMU05?=
 =?utf-8?B?Q25jZHR5Nmk4bXVJRFV4bXNSc1pLUEFRRFkxcEszZVdwZlMrYmVmamNVK0g2?=
 =?utf-8?B?NWcrMHRMWFB2L2lrbkRtZmFYdEw3bjlmVzZZV0VKNGU0Q2RrTE9zbFRaK0k0?=
 =?utf-8?B?ZW51WkdCaGJzVkNPSEtVN2lKeFdZWWNUYzdrQTBTbTlTUFpWbXFjZnFNRWxP?=
 =?utf-8?B?UDIwdVFvWUxpQ1N6SUNtMmdkeVp6OUFyNTd5L1BTYktQV0RQamdteXRMU1lN?=
 =?utf-8?B?NmhKclUzRGtrcFQwRVVUUjRybUsrQzZidmNqcG1VNWt6cHNuZ25XODQ0YVo5?=
 =?utf-8?B?QTJmenk3V3dCTGZ3UzNNR21hUHdqZjlZUFhHOXZBTndGUi9zajA5WVd0Zlkw?=
 =?utf-8?B?TnpRZzZmNU1QNDh0WGROKzB4RjJqZ0FzRk1OQWpmUmJCQ1ViKytjajFVZVZR?=
 =?utf-8?B?bVA3K2c1K2Rvcis2c1MzWk51K0EvL0FsK3k5SGE2RVdoQ243U0dBTzF5bW9i?=
 =?utf-8?B?cXRGMFpDeStwRlVXdDVuSlFJMHNvQ1pqcG1WTHhOdEwxQUc5RS9QeUZMWGla?=
 =?utf-8?B?VnFWd29hRUhNOHVTaXlRbWtXdkgvQTBnL2hiY2lCL2pYMHdQZlhZT2ZGM05v?=
 =?utf-8?B?WjBBZUwxRWQ4TVZXUmxSVisvbjN5Vms1b3V6c2tYcUhZMnBXQm5nWGZ1MkpV?=
 =?utf-8?B?dFc3WWRlbVlkM0tORWpYZk95bTRDRWMvTjBUUExhQXdWaUZDbm5INThheWxz?=
 =?utf-8?B?empQdlAyNHFNZXNURFN6bVJFcnNrb0g5QjgyR3BWSUNaNDlKRUpqNzYxVExB?=
 =?utf-8?B?bTR1aGd2dm1FVitna3dPWUdvTE0vZGlIdkN2WndSQ3pqcWRWVWl4ZSsvRXhI?=
 =?utf-8?B?Qk5hWSt1bGZLNXA0MVZjbDMzYXBwaFZJcTYzUFB2WnlJREVvMEE1YWMzdEZk?=
 =?utf-8?B?amp1cW55MER4NFY2Qndlam1ab09OZHFhVWJYSDFXVWlOSTJVRFY0UFp1enhq?=
 =?utf-8?B?NTQ4dnYxOHkwOGppbnFmdXRmODA3VWJtSkRkUVRXNjlEMUJicjlYelIvM3Bv?=
 =?utf-8?B?UWxSY2dFS3lRa0g0ZGJ4QXdZTjhlZHlNRFdsTEN4NHBnT2l2RGFWT2s1MXEv?=
 =?utf-8?B?VmFRSEp2VFhIVkkzRE9ZNzRQdllGU2ZsR2FOS2N2T0k1bGR2b2ZqaWJIS2lI?=
 =?utf-8?Q?2wQM=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2c2b70-e437-469c-503c-08dc5ebfabe1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR02MB10909.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:20:49.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s35NC+j0HTPJdgrq7AvOyeouxLZXG7tfVDQ6J/0QbvXgxQWzw5qJ5ZvehD+chgVV9kywo9K/tDwjLe7ZIK1uug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10082

On 4/17/24 00:59, Damien Le Moal wrote:
> On 2024/04/16 0:49, Gustav Ekelund wrote:
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
> Hot-plugging should not be an issue in itself. When hot-plugged, the port
> scanning process should detect the maximum link speed supported by your device
> and use that speed for probing the device itself (IDENTIFY etc). If you see bus
> errors, then you are either having hardware issues (e.g. a bad cable or power
> supply) or some issues with your AHCI controller that may need patching.
> 
> Can you send examples of the errors you are seeing ? That needs to be
> investigated first before going the (drastic) route of allowing to manually
> lower link speed at run-time.
> 
>>
>> So I want to adapt the link, depending on the connected model, in a
>> running system because I know that some particular models in this case
>> will operate better in SATA2 in this system.
>>
>> Can I use the libata.force module to make changes to a particular link
>> in runtime?
> 
> Nope, libata.force is a module parameter so you can specify it as a kernel boot
> parameter, or if you compile libata as a module when loading (modprobe) libata.
> At run time, you need to rmmod+modprobe again libata, and so the ahci driver as
> well (because of dependencies).
> 
> As I mentioned, if a run-time knob really is necessary (it should not be), using
> the ata_link hw_sata_spd_limit would be a better approach. But again, that
> really should not be necessary at all.
> 
>>
>> Best regards
>> Gustav
>>
> 
Hi Damien,

Unfortunately doing this selectively per link from user space seems to
be my only way forward for this particular hardware issue. I understand
if you deem this to be too specific to fit into the upstream kernel.

I will investigate if running libata as a module might be a way around
this peculiar problem. If I need to refine my first approach, I will
attempt to modify the hw_sata_spd_limit to be rw.

Thank you Damien and Niklas.

Best regards
Gustav

