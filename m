Return-Path: <linux-kernel+bounces-72797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCBF85B8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03A11C2082F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062C612C9;
	Tue, 20 Feb 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o1GZhuka"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF75F470;
	Tue, 20 Feb 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424142; cv=fail; b=VofyHwUsOiWUHSm9Zqgt6fC75L/4/Kws9+EOrHLw+2/2QtPxcqr5iW9vbsQBfPS5DB8qWBGltEMO42FIsuhVI4At9hPiCbJ1R76RLdA/eBSLbdIJQ+iVoX/pLTZI20+/4fT/fc9Fs16eVm3nVuz5JESnYYe6LxVxtBEbYuA855w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424142; c=relaxed/simple;
	bh=dH7j7MhFV22yc//w5gvEg+6OPK9C+zyoVlCatzwNvnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NOHtlTl49/OvFVKVYZNQ8eohLWPZBEu0orpdl+hXTnWy8Gz4PDsQ+QPNrZ8qhXmbpoV17Ov9AnzCiouLh/7zr7f1m1sHBxrniMhjuRf2Jl/Ok2CVAo/+kvakened91Ypj2l12c15cb7BNFEFYQRwvSyZobwThD0+Eert4wyX8mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o1GZhuka; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWiwDC9mT+xpDoO07rRML5j91meYSmLaMS6CYH35o1YAjehr9rtYa+Rs9s8QMx3IJp6nAohv1gcfd1mjrI7apOeNqtUpPeJ5VBd4qxCbqgfDHv6yImrBsl624uuIV4E5Kc7F74qCbdf58WGSwSTAoEDaWS4KNQ3WndoqjQNr0J/VlJwOonZhMwG+1g2s5ljDXZKR4AHu9INdcl2e6SoVLMu65DtlQTbfheoRERFTX4g0lmIuodXL6zIoDo7VtUX0urqoasSOVtQYuATkWTgxF4UIus9ubsASaIL5T2NTyC1zoyjNO8tCrbPLGSPhvvy2WmGcAtrwxeggH2sXgIatXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4ABcmbyz/DciwLLfzoHyAsMujCz/I4k4JahDPtrmmc=;
 b=PTfgoe+Like9ZJg2ulnu3aMsKH/2abC06Fae2I+Zc8jswViEL+QcONUm5+6z5FLzxQUlhrrmp6xJBJydlRgmE0ASNbug7L52q6Asyc5lM4JfZzMpl6YDFGel19O3QgPz5BQsGlgxids+h5hlJRwINS29ge2NLoBJXeWSyNE0zn29+fdbkgOsiatsLtAf56GzLLsTZxoJrq2qICLVQkvxCHEy94RUUsGRFtRwFjX5KdeejxJPy3kH664f1xLEwv44t7auvFINqrCIi/e8Rw2W+dy2FZaQHYkcfkTurlhR8pJfkMWbVPfKRJkSWzHTz6meFTmIeWNdZ8SmzUyhHrUZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4ABcmbyz/DciwLLfzoHyAsMujCz/I4k4JahDPtrmmc=;
 b=o1GZhuka9vf7ATg2ijQdCblF6ALaYXJL55T9CUnHdmDEyJrKXkAnS1TlarctRbO9IFNmuOR8Kw07hZHmQ48o9j5vINXWhFhAcacIsvOiKkLLLaJe1VYwhxhUeVm2t8FkR+bfUn8T/te35K5yPotzjBrnzGSzmZ9pcKrzNYAxoHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 10:15:37 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 10:15:36 +0000
Message-ID: <0940c052-d834-4ddd-98ac-8395ab48ceb8@amd.com>
Date: Tue, 20 Feb 2024 15:45:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>
References: <20240219093900.644574-1-arnd@kernel.org>
 <465d1076-163c-4933-a9b5-e4e8736f5748@amd.com>
 <412c0a42-4c19-48dd-aa4e-de39b6ec3099@app.fastmail.com>
 <343f7b1d-1b4e-402e-bd54-4473b91b6f79@amd.com>
 <65f13ad3-989a-4699-9695-d7b1a95297eb@app.fastmail.com>
 <779d72f1-832a-4fef-a529-ebe8100b04f9@amd.com>
 <96f6e105-0e89-429f-a8c5-2e64087d7771@app.fastmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <96f6e105-0e89-429f-a8c5-2e64087d7771@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CO6PR12MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b50cd41-68ef-40d4-32a1-08dc31fce15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZoMl+HZGjghCauHRtOelLZdilEMtiOIXIIp5nd2ZCEP91H8zLZnEgx/0yytJYon8ZS0WvfOK2CtQ8C7W1MJ4ibHvxj3HPleLWver7YBm3zn8Yn/wdreN/6KMcAGGH7Yu6XWax/1C2DtBleqZmBZFSHIE/x4ZmA3gTvv9gnYbBvawvUGpNidqy/Ce4fxUvstoSGfsl0jbPpmsaH7M7Km5/nvqWbvjOCJGWIzum5YehiFhoTuD9RqlQilb5PAcISWCcxUw+Cr4Tt+xME79/B/pFgdK7GVTms3V9qTWxmiH3YsNGBJxscbAfX4Z4f2HHgDXXP6ixSd/6oRd9ClYhFUcJUVGu49an1GTDr4/UwqbI+SJGxw2hJXpaKpFJu5qoRu0qml0VB/JZJ1u40H98NAACeTpuohBf+h0BOPONjgyBZMrWfNmfF7wHizIcT9ca9O3Z9r7K5zIKR9Vfi5Pkeg+bwKQ0/NdZ1LKkcV96wPU0IBC/DUlfxwpwZMkbhNvSYdBlhzDTSHvK4BZDn3NpuHNMTcb8sZKck7wHX2Ao7pF3QE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZvcEV0UzNqTFRPR2xFVDlodzV0MmYvVUNiM1ZNY3YwUXlGWkFMVFJXZkJX?=
 =?utf-8?B?VFNzNm9EWFE0MWoxRTkyWWdkNEtwQ2x5SzRCbEsxWG02ZGYrd1AyZ3Y5Rk5r?=
 =?utf-8?B?eWdvMTJCa3RINFF6Z2xkYjlqZVEzZlJ4YUViaWRjamxwaFZpSjFScVlHNGdu?=
 =?utf-8?B?cytab00xdWNxMjd0TkZPQjE2OVFSTGhpOWtkTnhoV051RzdQV29QTUh0enov?=
 =?utf-8?B?SDJPUHhNOFJEOVRaVmhoUE5QY2k4d2RUOU94elV1NEplTmhod25Od04zVmto?=
 =?utf-8?B?VC94T2Z5UldXVkpUUjU0MnhnZlJ5cS9xYk5TY2krZXpneWRyMVNIRjlrY3dU?=
 =?utf-8?B?ckM3VXNRK3QxdnpQT2FhR2FIdDhiZkVWcUJxRG5qRm9jV0oyNkNtOTVldVBQ?=
 =?utf-8?B?ZGZGU21HSHIvZjRtSDVJaFlkWENXd0dmalNYSGRXOVNEZEpZcjVDRVhtTUli?=
 =?utf-8?B?SVdCakpzUDN6SmNQMDRHVlk5N0lramZENTZUSFBaWkYwNjBhL0pBRGxudUg5?=
 =?utf-8?B?VnlVeXkrRmozM21zWWRXcG5qRVBpUUpaT01VZGFtaSs4MTlqWDgwazBpOUt3?=
 =?utf-8?B?amI5S29aMDVQSVQ3TnIwWHpBTkliODRlZG5STEZGeUNMK25RRlJxajdPZEFQ?=
 =?utf-8?B?SmVVR1FCTE1VUkpHSHBCRUpnVENLalV3NlV5U0pKWFN2RnFkai8wSTN1V1R5?=
 =?utf-8?B?c2ZhQUJ5SEVBQjI3YWtBdEpDb2JOaVZ6b1RjdVRuVDZXSWdaQkhLZzkzOHEw?=
 =?utf-8?B?d0g3WU84NjdNV0lhcmFVVGpjWU1MT0JOWDBGTTlRbDZ2TEJvc3RkNCt6RVRT?=
 =?utf-8?B?WmxBbzIxQlhaTFlvMlkvUTJ4dkl1a0RlRWFvSU44bjF4MW13ajdmVUJmdk5a?=
 =?utf-8?B?bXRBWEhsNHBGZTJkZ0s2UE1Tek1WRFBFd0w2WWQwVmUzSmZsM3FBMUg5SHN3?=
 =?utf-8?B?UDE0M1hvRzNKU09XZFQzVXRRcmhPaGFuY3dRMFd4SURvYmRhbjlWYXdrOEhu?=
 =?utf-8?B?NGxsMEt1SkRZMUlybWkxVDM4d0p0bGNQd080QmxpTzRhdTRJOU1vUUVYZ0JC?=
 =?utf-8?B?Q3ZVNlc4VlNyRzdCOFVmdHBSV3Uwa3BsNTNFVjg2MGo1R01rMEFIc3ZURHlW?=
 =?utf-8?B?Rmc1cjZXajZJK25iNllFU2duNGdmWHRqVnVCdkVsWUdTeHVDKzYwamJtNUdS?=
 =?utf-8?B?ZWwwL0xidTR0YnRsQnpHL1U4ZktmTnFZdUxuSEh4dGtXbWJPRDYzd2haMGRu?=
 =?utf-8?B?THZ4N0lvMjAvME9rK2tualNFOUhiTlJ0VTR2eE14QzdTeDcva25xcmxYZ2la?=
 =?utf-8?B?cTRCY2VFRm1wUVk2TmtxTzBJRjF2aGxKMVJsVzJTT3FKOEZsM2tnMGYyOERr?=
 =?utf-8?B?dTNxY055bVFhdG1ncVlQeWUvMXEvNTc4RU80a1l5V2RKZGJyUUdRRmcyMjdi?=
 =?utf-8?B?a25qNmx4TWhGcWUrM0VXQXQ0bDhlaUJVV2RQZ2RDakc2V3RMZjRKM0tYdlUw?=
 =?utf-8?B?V2dLbDkwa2hFQlEvb0RzTFNicUNjeXgraHE1bWxMNlNCNWt5RzVXdkR2Z2pU?=
 =?utf-8?B?ZHFKaWp3c2VQVVVhVncwY29vaU1tZzhWRk9CaEw0ajJXSDdVQWpTcU9GUEdD?=
 =?utf-8?B?R2RCVkxlRkg3U3prZkFNc1AyMFVMTHhxSGU2SVpJeGFiNDRPZFNTSkFaWDk1?=
 =?utf-8?B?M3krNGNVRlJXaUliNkczZ0txMnZ1N0JSYmxSYWVVdE50WWN4YXA3dVhGcEMv?=
 =?utf-8?B?Y014M1BlRjNNZnF2dU0vWEg1ODEzU3hlQmltcWxHVzNXdmFqMHhHM01xcTdL?=
 =?utf-8?B?SjllbEczUXgvSnNrcm52c0VyeVcvbC9MVEVMZ0lQeGswTHUzdW1Kb0lPUlhx?=
 =?utf-8?B?NGkyZEEwTDJhYWMyTVZBdmVHUnZjUmwxQWRxaWZIWmJubm9sR2wzbDZENkhv?=
 =?utf-8?B?Y3JPUWpoTFRQaGE3Tlk5L0pIdDhpUkc4azdrZk9RM2pnVXpweDBUbDgzcmxS?=
 =?utf-8?B?S0xRRmc3d09JaFJVZHRaamZncWhzRVduN1BXQUpVOFVmNmJkVlNpaVgyVGRC?=
 =?utf-8?B?RVJ5aWNOYmw1VmVtMGRyRVhMQ2k1akc3dkg0WUhCcUgzYTYwUVlwaVc3VnU3?=
 =?utf-8?Q?5G0GNZ3fM1o7GbV0xiuBObRyt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b50cd41-68ef-40d4-32a1-08dc31fce15e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:15:36.8924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/IFFo2uKgcFg+RjEGvxyTuFfjSxaIQVHFAudRzqvKIWk5fV+mVEPa3bNW0mMK6vIr3DsEMyXQs1K/VkMU50zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428

On 20/02/24 13:51, Arnd Bergmann wrote:
> On Tue, Feb 20, 2024, at 08:54, Mukunda,Vijendar wrote:
>> On 20/02/24 12:40, Arnd Bergmann wrote:
>>> On Tue, Feb 20, 2024, at 07:23, Mukunda,Vijendar wrote:
>>>> On 20/02/24 11:43, Arnd Bergmann wrote:
>>>>> On Tue, Feb 20, 2024, at 06:57, Mukunda,Vijendar wrote:
>>>>>> On 19/02/24 15:08, Arnd Bergmann wrote:
>>>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>>>> In normal configs, they should all either be built-in or all loadable
>>>>>>> modules anyway, so this simplification does not limit any real usecases.
>>>>>> Tested this patch. SOUNWIRE_AMD flag is not selected by default causing
>>>>>> AMD SOF driver for ACP 6.3 platform is build without enabling SoundWire.
>>>>> Yes, that is what I described. But as SOUNWIRE_AMD is a user visible
>>>>> symbol, there is no problem in expecting users to enable it when they
>>>>> have this hardware, and distros just enable all the drivers anyway.
>>>> Want to set SOUNDWIRE_AMD flag by default, similar to Intel & Qcom
>>>> platforms instead of explicitly enabling the Kconfig option.
>>> Maybe use 'default SND_SOC_SOF_AMD_TOPLEVEL' then?
>> Didn't get your point.
>>
>> Even with the current patch, if we select 'SOUNDWIRE_AMD' flag explicitly
>> AMD ACP63 SOF driver Kconfig option is not visible for user configuration.
>> This results in ACP63 SOF driver won't be built at all.
> I don't understand what you mean here. What I see
> in linux-next both with and without my patch is
>
> config SND_SOC_SOF_AMD_ACP63
>         tristate "SOF support for ACP6.3 platform"
>         depends on SND_SOC_SOF_PCI
>
> so it clearly should be visible as long as SND_SOC_SOF_PCI
> is enabled.
>
> There is still a problem that SND_SOC_SOF_AMD_TOPLEVEL
> can't use my "depends on SOUNDWIRE_AMD || !SOUNDWIRE_AMD"
> trick if SOUNDWIRE_AMD in turn uses
> "default SND_SOC_SOF_AMD_TOPLEVEL", but I don't think you
> meant that, right?
Yes, you are correct.
>
>>> I don't think copying the mistake from the intel driver
>>> is helpful, though I agree it would be nice to be consistent
>>> between them.
>>>
>>> As a general rule, you should not have a Kconfig symbol that
>>> is both user visible and also selected by the drivers that
>>> depend on it.
>>>
>>> To avoid the dependency problems from coming back and keep
>>> the complexity to a minimum, I think there are two logical
>>> ways to handle soundwire:
>>>
>>> a) keep the current drivers/soundwire/Kconfig contents and
>>>    change all the 'select SOUNDWIRE_foo' to 'depends on'.
>> Current patch already using 'depends on SOUNDWIRE_AMD" for
>> SND_SOC_SOF_AMD_SOUNDWIRE Kconfig option.
> Correct, because this is the Kconfig option that actually
> controls whether sound/soc/sof/amd/acp-common.c calls into
> the soundwire-amd module.
>
>> Still we couldn't see SND_SOC_SOF_AMD_ACP63 Kconfig option
>> is enabled.
> I need more information here. Do you have additional
> patches on top of what is in today's linux-next?
> I have it enabled on my build here.
Sorry, it's my bad. My local patches created the problem.
Validated patch on our side. It's working fine.

>
>       Arnd


