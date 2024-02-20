Return-Path: <linux-kernel+bounces-72498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E485B441
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644A01C2260D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FD5C5E5;
	Tue, 20 Feb 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iiSvef5k"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C1C44366;
	Tue, 20 Feb 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415672; cv=fail; b=VXOLwKPa19vUroCrO0teJxhB+hAGO6ueJVMH8TGowo/S9ptCUWA3RwOK7t2YgOKWka31pHK+yGg4Lavz+h+ZrwwCUcZOhZeSAhmIxEM/ZDE+tw9vrYsgu87H00ljsFIRWWnGqWlbpooNc71csLHmnxcIwjw2eN0fvHlRvsxh64w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415672; c=relaxed/simple;
	bh=7y2B+H5v/9qEB+iKuJW1rX/uM81nUwP41IPD2e2QYus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bK9mUgRpHDKmj5+B8NLfLjS+CoP9BxvVh52MEuzpQyYVXgRXeUdfNaDWRqMYarJvHFFQlQy1AtwQGB2oxlgGZq4Y7BrL4TQy6BJVdTDZneI817oaq1Qq4bgUaaol910mWJ11S7nZaLkkMC7bMwaSQRAO2d865yd2CDQtcEY0WW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iiSvef5k; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnIoxOFCyJ8+4dY/d/JB+0+7jHDPqTwGgvR9OnJlyq7Bm5dDtaScX8ZR3rW+3fwIN0sEromcASj6YrQqd+j6HaGqMJxvLsOoMW5UH7pqqp+FyhBnNi7UHs43QAL1YjAv6R/g1bGWEHd5+OiZ+jqFJQ+sq4m6stNvTWMi4HE3MY45R7iyvZFmlk42PDYw1UtLT11/ACnM97FUXskc085S+pvqGCyUyi4GePuAboq3WrRXzPRiVboGM9t0Y6dcqUOzsuBMx30fjQ3DLdKRXALCdAfNyAZxXqEoYU2AHyFbH+Twljkeen+XXpXkCnln89K5myJ0f86A0B3HRFoD7yMDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp5BjW8j+zH+ZzQ7a0JmgfrvyiAilLkaYrEpdluK1l4=;
 b=Ij38xcxdiIiZLISyncLHDvEBYEmKlZtRH9pwAJSc5y8JeBGPKVfskBKSXvd6A6+ZT08xIkM8qRjxUa8pWdj+ltodFteiKSFvBFlHEeRgrK6vMB79f/1Yufu73bc9BlKcKeshuq4D60fZ/4ctVvoxp3fp+P+cWIBqVq9sAlS9SYX9oSDi/nSOA+pitG5zCVue82Chi/xsY3T2smzcOhP/Jb9Pf0UTyiAXWS4g9HFT/spW7ubjzGuqOE2Gh+XxbRgih07c3RI8L8eWNcSSQAjyX5TtY1TsaKe+fG1ADMEb+mcYlUwbZszI4VXK+VqLrXOyhnggk42eVZyuFg9Ao9oh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp5BjW8j+zH+ZzQ7a0JmgfrvyiAilLkaYrEpdluK1l4=;
 b=iiSvef5kxvSe79FOAreFsXQEV9MgrZhOVrJCQyGm5pSIw50Al4j7SYzb9LaypUXBT1QFi9cYWb+lWjiKnUDPwpYSDEI4ZaZ8t6FKz240k3z/IGutsz5Is6VRHO77jwnxXUxnEXLN7ReIQ4mGu+UcF+b6opx8ySYKhuokgfsGyRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 07:54:28 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 07:54:28 +0000
Message-ID: <779d72f1-832a-4fef-a529-ebe8100b04f9@amd.com>
Date: Tue, 20 Feb 2024 13:24:17 +0530
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
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <65f13ad3-989a-4699-9695-d7b1a95297eb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::18) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: d135c386-d24a-46d1-dd28-08dc31e929c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZMNcob8pNX01kzKESj1wbu549D8f1nihUbmkZWuZQaLN30Vw15wv8FKd/ZZk8CjYH41zqI/fNTv+6oTCiAuyHaoRJqVgk2pJgNSsbUzjYrRIEwOYO/xQxmUAHlay1oQwcoHusdqNkBy7SjslJLKcqDgkqcIby1wndywVU4OZ6SsjitB+ZzPRcDv8prxB5xIKZjdczaXwxxF5MJmkyEVCJzWvX+mInbJB82X0lsdqcd1JHpi2IWDbXDdAJO9PjsggoKByR9AEDXl5b9/R7Ylldtit2vUl8dmhvHOyIxlC6esqmAj1nd9oor952dpvfHNXyjrREzcb5fTls35rSp1yrQewvVW+o4mc4wFysuva0PkDNXhpzxD3/GgG/5Vdkb0n0jAVBKqDUfYgTNN3nnpqqVjsLplXdcTDF7Tw1cGp0gYgTw2QSfVIltJ95PnKI7BaYa0SMvwV3pAhqPSwEqXXyn7q/pM7ZwxcUF9Cd4YaVWBgDffS9dnQotij+V3BePWu9UzX5ersou8l8VciQp+98Jq94EV2JfjUa9ay4qeK6SM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU13SnBnVTdXNWo2Um0yV3piU0YyRWkvdnExcHY0NjhmUFF2M3d4K1kvSnJj?=
 =?utf-8?B?K0Q5eHZUa1dNakx1QWdjeEVZNTVUMnNRbFEzQXg4NS9NNHVTM3pnbkRBcnky?=
 =?utf-8?B?U2piZmVqQ2JzUmRtRFZkVUY2cFNxNmF6VFhQc0MrZFYyN1dGdEZicG1yVzFz?=
 =?utf-8?B?Qmk4dWY5QnBzb05JQjBVeU9JZHJZRldWQUxwQ0wrL2xUbzYxY0plTVcrRUpG?=
 =?utf-8?B?UkJRT2t1aTA4WkxiSzJKYi9OVnFEdzVYR3dvU1g3NEdIY0orNVZWeitqSXA0?=
 =?utf-8?B?Y0I1SW5hK1ZSTW1Gd3dkV3liNGEyeXFtcnJHL0h0MTRyT0ptQ2FSTUg0OUc5?=
 =?utf-8?B?VG5GVllpOHVOb1lLNFIvSHlvQmtSazc3c3MxeWd5Q09pNTUyTU9qWlFRd3JJ?=
 =?utf-8?B?c1dmVjN2YUhMbVlncWEvZW1wK1hLQ1NKWVA4eFdRMzc2RnVwU0ZTUzM4ZXQw?=
 =?utf-8?B?aEkvY21jbHFTM2FwZUFmaUw2V2NyWW42MzFITjBzYTJNU2Q0ckYwbHEvc1BC?=
 =?utf-8?B?KzdLVktxbFdsaFNqamwzS2c0WGh5c3BxR2gwV2lYTTBlQlVBZkNxVEY2UWRF?=
 =?utf-8?B?NklubnMxSG9PakxjTjV2NWxUUHBnWitxRlFIWnMrUzVEczBiMHd4ZVZSWWp3?=
 =?utf-8?B?ZzJoVks2eVJCV0RoWTJYeUkxeCtucGRQUE1HYllaV2JyTmdVOEVuRno0d3Z5?=
 =?utf-8?B?aTBuaWZmdTNKWlZ3eG92OTltY3NoZGphalBXZG91aWo4b2hFTEdqaU1CWmx3?=
 =?utf-8?B?M3Z4Nk9uSThzUStUbCtQWnFxMjl1NzJsQ0lQMjJZSnVpdExkaTRtRXUzSm5L?=
 =?utf-8?B?WHpuZG9sWGRxUDZ5YTFkUzB4dldoZEFzTDVPYmtWN2N3ZkwwUGpXR3lxYnpU?=
 =?utf-8?B?VE1XZlRUZEJRY1VBQWZsRWcrZzdqdmZKQmQ3SEhyQkpCUmhlY0pmdkl6aEFs?=
 =?utf-8?B?T0ZQTHdubkp4Y1IyWGlMWnpRY3k2dVpIVEdYN3YrTjJETEx4a0lpcVRnTXNT?=
 =?utf-8?B?VEFRUTRiQkdXd001QkVZYytvTzEzT0d2Q3lMOVVIdFdGMkJObjF2RDduTWNx?=
 =?utf-8?B?enE0RDRrU09iSHpzc2tzQnZyRUlUWDZZQjJ6endZOFVoaW9vdmJOWElOL3Jj?=
 =?utf-8?B?QkdLTnZkcG8yMHFUK09DN3d1ZGVRRXFkSmxhd29TVWxWazFBWGJKZE0wQ3By?=
 =?utf-8?B?S20xcTZRWGNTNnU2N0NEWVZxYTRWSWlwQUFHdjJBYkVoOW1SK0hidml3MWVL?=
 =?utf-8?B?czBHRkQybGhhUGxuYlh6cHlsa3M3cG5QTlR5YWZ6TDhPYTkrVnZ2bFNxeGo4?=
 =?utf-8?B?cm0xRDU4bHNoRHFNUEd3VFFYdVpEUDBQOE5yRzN4QXh3NTZUOGFjVE9hUmdV?=
 =?utf-8?B?a0gxb3pXbE5heVpUdkRmYm5MTWsycVVUZ3F3b0NCM0krZnJPNUVkb25Vcks0?=
 =?utf-8?B?bEVxWm0rRSsydWQxRFVrRkg0ZDRaTWduZDU0TWdRQmxkY0xCVWtTNWJnSVky?=
 =?utf-8?B?MWtYZnhPWEFWT3FiQnZ0bk8wTm9GeTU2M2Z0VWNnWERPdlBuRDJqT1djRmRs?=
 =?utf-8?B?MG5OcTlZdnJxbzc5c3FiN0owakNHeHNaQWZYTVpVaUJ1WGJtSVlZbDM4UUht?=
 =?utf-8?B?WE5LTEIwUGc4TmMrMWFQSXFZekk3WDVMdjUrdjM1QWtORW1NYnJOaU5sVGRX?=
 =?utf-8?B?REphQmR1dTZtYk9mRVkwWGJaMnoyMXI4NFNTOUlXU1UrMjFKek1FdDlPRGUr?=
 =?utf-8?B?RWtRQmVqak4yZXkySW1WekZGQjdXNUhJN1VmK0FmZ2MxN2VrMTdpdFJ6VTIy?=
 =?utf-8?B?WHFhUkswUllMN28vYmpEQWljZDRTcXJiSFZsSEllSEcwRUw2d29SUGtpcDRU?=
 =?utf-8?B?UVhxcVluS3BPbEJ4YnR5WEZCV1RTdFYzeXRPMk9TNkNnbXVVNWpWVjlITzRZ?=
 =?utf-8?B?dGltVkFpTExHUEdJay9JbFY0L1plenFPd0EvdkVEc3pDeGpLTVVBa1lrVEl1?=
 =?utf-8?B?UlNZcmFTUFBVSnJ0ZHhkNWdxTTlvUFNKZzlCR3lYaGlSdmxiOWtLNnQvM0Zr?=
 =?utf-8?B?VTAvc3ZzbUVZa05XbjZYb215ZHdkMmd2QnVhVWFCRll5SmtGU2UvUWdtejZp?=
 =?utf-8?Q?jRo7QQn3lgR8nL1J9c+qRLAB8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d135c386-d24a-46d1-dd28-08dc31e929c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 07:54:28.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+izv+0LTEgipajYm3bco7nUIeS2nqHPUoRxqAlL8rNtGWv6B8eo+YpCL3CL9azYB9tHmUPNKKiOpuPgs4Sqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420

On 20/02/24 12:40, Arnd Bergmann wrote:
> On Tue, Feb 20, 2024, at 07:23, Mukunda,Vijendar wrote:
>> On 20/02/24 11:43, Arnd Bergmann wrote:
>>> On Tue, Feb 20, 2024, at 06:57, Mukunda,Vijendar wrote:
>>>> On 19/02/24 15:08, Arnd Bergmann wrote:
>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>> In normal configs, they should all either be built-in or all loadable
>>>>> modules anyway, so this simplification does not limit any real usecases.
>>>> Tested this patch. SOUNWIRE_AMD flag is not selected by default causing
>>>> AMD SOF driver for ACP 6.3 platform is build without enabling SoundWire.
>>> Yes, that is what I described. But as SOUNWIRE_AMD is a user visible
>>> symbol, there is no problem in expecting users to enable it when they
>>> have this hardware, and distros just enable all the drivers anyway.
>> Want to set SOUNDWIRE_AMD flag by default, similar to Intel & Qcom
>> platforms instead of explicitly enabling the Kconfig option.
> Maybe use 'default SND_SOC_SOF_AMD_TOPLEVEL' then?
Didn't get your point.

Even with the current patch, if we select 'SOUNDWIRE_AMD' flag explicitly
AMD ACP63 SOF driver Kconfig option is not visible for user configuration.
This results in ACP63 SOF driver won't be built at all.



>
> I don't think copying the mistake from the intel driver
> is helpful, though I agree it would be nice to be consistent
> between them.
>
> As a general rule, you should not have a Kconfig symbol that
> is both user visible and also selected by the drivers that
> depend on it.
>
> To avoid the dependency problems from coming back and keep
> the complexity to a minimum, I think there are two logical
> ways to handle soundwire:
>
> a) keep the current drivers/soundwire/Kconfig contents and
>    change all the 'select SOUNDWIRE_foo' to 'depends on'.
Current patch already using 'depends on SOUNDWIRE_AMD" for
SND_SOC_SOF_AMD_SOUNDWIRE Kconfig option.
Still we couldn't see SND_SOC_SOF_AMD_ACP63 Kconfig option
is enabled.
>
> b) keep all the 'select SOUNDWIRE_foo' but drop the prompts,
>    requiring that all drivers that use soundwire have the
>    correct select statements, with the main CONFIG_SOUNDWIRE
>    getting selected by the individual drivers.
Didn't get your point. Could you please elaborate?

>     Arnd


