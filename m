Return-Path: <linux-kernel+bounces-71151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2185A162
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDBD1C221DB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6028E0B;
	Mon, 19 Feb 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b8b8QzXB"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC324B5B;
	Mon, 19 Feb 2024 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339864; cv=fail; b=fyBnzIOA4LJSY3OgEYh+M7wr8CDY7iz5eiGVP+bWmmKEmMYwATlpQuvwPNCfu7wBlPcKUVZVQfRK9WuJ0rgc0llXV5NNjcoGyziwmZhtQUldm0sv0NeV2H7ESumIEMgaEp7Ll+TTDKgfrhWzTVAVD9IGR0cM68sKbyZYJHoMr4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339864; c=relaxed/simple;
	bh=SHIH1I5e4Ng+e4p+tAIeUTnCUE1qb4m55dBIJ1/JbzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U4KKrcwaJ30lJqEhQgkGTy+Mnx4kVdXufCT2C/cUFEVO0Wc6mnbftJrcQurAx6yTmByMwCA3TpDsQvqZPTBRedK8xH+evC81HAdY5STU/n3xDhaaiDd/9OytSAqUaVEQscIdxhp7e5Z3jcKjsoFU5Z4C/+dRKN0SHjODckIF9N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b8b8QzXB; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neUnV4DLjBfbucpPpyjjqesPPKF6b4c1hyT1/AaV5U1qG5x+8X0QprJaaPFkIXK6PTl1W7LbNJtxfRe1U/DdWUwiKqxWtLlLtbj+5xkl65nEznCIzaXh50jvgMDMufHMuV5uf+xdAn2LDGvA8Vu1tgbLbTWnWdufaMevNx8y01VgALMDaKqzFlLvBwteXNed4j8LiobuPBX6UQz5T2LLdqfOu3pr9zOJIwR1eYHuT+h+DZrrkwoGPKq1oukfnSCQrMz+AMaqcePc13mXJ6zDkNopwZKn5yRQWjDkqFo+CF7kCYzXKQTx+Y+w6PaPyWCwwVLbS1A8bymG778ESRtrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnMOzACBzYtEaFKfJPQb+aJiERZXEFqXs1AkGm4KIJI=;
 b=cRBFq3CCtKRHXYHpvRKFMOm0qdSwLRWSxCFDuFOyL568j0/GVOZ/rUFlhWU+I+JV+Yw04SqMUK8ou3RZlHetpP+GVk648tOPj07zfoI/ynPFSBONqYCUWIRkAU7qn1mExRsY0LFJLNntuTUiE/Q9OGzbu0TbLveopLkgYzOxzaErNYpaoe7fQtSS/7Je1n67injzF4y+UQ0RglhAnvjglRWf/mcVdDpqeiBbE0YnaD6WlQXP8/2Ub/BT/D0Nlcb3XGByf3jQ84hDKQrCu7gU13kb3VydaIK3hdTPE10hcPWd+1ni+E7Oz5d001h1Qzm8t+9U8ifZrCifsfUch9ra4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnMOzACBzYtEaFKfJPQb+aJiERZXEFqXs1AkGm4KIJI=;
 b=b8b8QzXBKtSz+Kno0OJloEic4oBqbXPgmZ4/yUgHIMWfNMAgAAhgTRL19OgKSul1SIxnZYjDNcP2+Wy7pYw4NjHbln8xrFt2dnfwVxNguYe638CDWQU6up/s4Ne8G5KVnN8kT6tVcaHBlprJXeiA8CsKIleBmYZfg4/hl0u8ovM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 10:50:56 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::57a7:a6a2:46d1:6cba]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::57a7:a6a2:46d1:6cba%7]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 10:50:56 +0000
Message-ID: <3e364929-807e-477c-8530-f23db4ae7caf@amd.com>
Date: Mon, 19 Feb 2024 16:20:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel
 6.7.2 -> 6.7.4
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
 "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
 Ethan Geller <ethang@valvesoftware.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
 <7a0cd63f-8a83-4dc5-8763-63dcdae8d68a@leemhuis.info>
 <878r3qxcyr.wl-tiwai@suse.de> <871q9hwz2w.wl-tiwai@suse.de>
 <ZdDXJyXiZ++KiNqW@finisterre.sirena.org.uk> <87msrzos6m.wl-tiwai@suse.de>
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <87msrzos6m.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b56e3e-de7a-49e1-8c62-08dc3138a699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oJuX+7aBMbnpNHUyT+Fm9PocIULPOU0+p1jn40ovh5jZH1hETeaopVLJVFmfsSggLQ8kDbYz+SEtiIOde1IzNXbGnCoe/k037djLEIsg6CZNYMBIV2B6mwVggRRrG1x0Fpc4JgIo+P7lSU4kpLeoV46AQI0jl9jqu7r//2Hr/TF+IOeXjl2sbMVVKJ+uqnji93xfCNh++TGUno190tUtpjkYlmAG+nc64n2JuO77llx2lqdiDDz3mbT0iApOKg85/iYxKaBNbi0EPxtPumqCje1RWN+QlCJFhceeqIYuRMk9ExZt5m5GaFPEuBm0WP/6+J7uTnHJ3PCEj4xTVSUvIOz7dPTygOQM47AwtsmlWLp4ZjqosoDgOcAk3A3nngfq06Nsx7SBan4yx/gctun/QflSNp/gXV6D+dXRqZymLKEdkiQ/Kdp1Wl9g89iExCoQYmoODLiD6knObvb3tQuEIiiWHtUpGeWKgvnerKjMEp/Bad9QO9rxJ6LZnAi3bMglLREeDlgYOjaXAbLWteD0mcr9dcCKALIOv0VOnbW03q8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0x5Nno5R0FhK29yRjJLeUNJbGJIUG5RS1A1ajVkRXJqL01sRTh5aGxvWmlO?=
 =?utf-8?B?M2Y3Q0xETEFvMisvOXdQbjBJcGEwcEJSSGtvS1BvSGVxaUJ3SW50UGpuZHJP?=
 =?utf-8?B?WC9NdUFZbW96QVZWMy8xcE5iY1RvZ0dZWE1nT0J5bnZUenUzb3YrOGN5blZs?=
 =?utf-8?B?bFpGSEJ5VG1Mc1pkYUFmVklXa0hBOGhBY1NuajFBaldaTzRiZnZ0SWM3bUhw?=
 =?utf-8?B?WVZMbXQ2NUlMMGY4NVdsZFlOMjlnUDl2Q3Q2YWlxS2xTQ0VIY21lTGxuSnJm?=
 =?utf-8?B?YjY0V2FuYWc4cGxyVDBCamFYNnFVWGNqQVg2ZlBlUWFQTjRhQS9KQU1mUmFp?=
 =?utf-8?B?YmhQZFZEaTdPZnpIV216Y0VMKys2WFZRT2UvUTB6TVpVR3RyazBRcDJPbnZq?=
 =?utf-8?B?VG5NWFhIRVBYMGF6aEt6MGF1WFBvendaYkxSaUE5WS94YjdpdzlkdDV4VXhY?=
 =?utf-8?B?enRQdXZhYUlPSzN6RmlISG50R3Jra0x1eCtRTjhSbkJYVWhMNlZ1WGlncVYv?=
 =?utf-8?B?U0VMMGhEbnQyaUQ4QS8zT2taKzFRMjR5ZGJjRkRWMjlJK05BVE1xUmhtVmFM?=
 =?utf-8?B?UllVK1ZVOXBIOWZNQjkwNmFNSzlrZDIva05HRWp2YjRhR3NqaHJ0U1NFekh4?=
 =?utf-8?B?eXpKTkpBOHYwdFVTWkx1Q1ExMHRETi9zeUxIMG5zd0MydGRhOGFJdXJHU1R5?=
 =?utf-8?B?UUVLd25iVXRQK0c3UVJrcGFSM3FOSEovOU9WbnhGSTNLYjRmTmN5S3l3RWNM?=
 =?utf-8?B?VFc3WDF1NFhSMEZ4NXA0V0wyN1BoT0hWNC8rYUtUalJ0cS9GSlM0NzZ3Y2FI?=
 =?utf-8?B?bFlPcStRL3NMVFdENTlGZ0hVRFhYUk1Lb3B6eVo1c1hoN2RpWHRVemtURU1s?=
 =?utf-8?B?Mk9kKzRiVkp2Q21wUVdQbFlXYWgydnVtakZBOWNLL1Z1WUFrQk9Xb0lBb0gx?=
 =?utf-8?B?M1NFUWVzNXIwdW9EeEN3angxVHhZOTVjeDgwNWppMHVud3dwZ24zN3hsY1R1?=
 =?utf-8?B?MmcxRVgyczNlZkdrVVh0cmRkTTQrV29MMFRKVS9EZ2hqNVdpRmdkN21va3lj?=
 =?utf-8?B?R2lQMUx2VmRlUFpMdUpIUnhLOVNyQXZ5RnZ3elZhTGhPc3p1ZGtUd3pjZ2Jy?=
 =?utf-8?B?dkxma1hRWmlQOEtZZE1teHJiL3paV09wNWZscldoN1NNSVU4ZkczcjFDeWs4?=
 =?utf-8?B?SitkSGNFdndZdjFlOHRTT21qeHVPS3AxdzlhRzVsK043VlJBejZIa0pLZ0hU?=
 =?utf-8?B?RXRVS1RFY2QxRGw3YkVHSWx0YXYzT1VKcFQ3ZGRnQzh2eTJwRTMySGRqR1FN?=
 =?utf-8?B?MGRrR0QwZ0dzQ3FUUThEM2l5Nm56d3VrSDFJSHRoUVdwS0YvMGl6YnRoTjZ4?=
 =?utf-8?B?a2E5RW9SbzhNeGZSeGdjU0ZVajd6M2JiYlpJNkhydEUvQVJwaDkwZkxlQmNs?=
 =?utf-8?B?ZEtqU245WVNvR3ZXQjNtNGNHNmVZM1hVSVZwSUV4OGgxTHBuUVBxNGFxQXFS?=
 =?utf-8?B?Tk1pZUNjakZYWU8rWGpZaUlWSVQzdEUvaU5qUHhSNXZEeEpjNUd0OXBvdy9G?=
 =?utf-8?B?aFhsTC95alpsUXpPeHlFRnRNVU1JVXI0VjkyNmtERGJDUWhFU3Q4UERvT3hx?=
 =?utf-8?B?VEhjYkVSOEtsZTZlZFZkZVNTY3d3dGs3RVZZV1dzWmpKS1pBaGlCL1diZkJK?=
 =?utf-8?B?Yk1LL01QQ3BaN1lNcDJGUUVDNnpGb0JleTVjZmpQU2c0aWlqbWNHNU5Pa2Z5?=
 =?utf-8?B?VWV2M3ljSk5oeDhNb2JuY0NiOVQyMWJlMEdVWS9xMFlSS3kzdExsMUUyS3hs?=
 =?utf-8?B?OXVxN0JZUnU4cy9VZzc5QWtGY2dsWFdkOWpLT2gwOG9hM0cxTTVzVy91VzVE?=
 =?utf-8?B?L0s1WSt2MUMvbUdTL2ZzUVNEL2xYd0F1MmdFcWxiSkdZczlpTGhRckxQTTh2?=
 =?utf-8?B?R0RrMzJJSVZ2NTczNzBZYkRPenZaN04xL1F1Qkd2MWtubTJDMTVOV0ZMRXJY?=
 =?utf-8?B?WlppZ1RoRVR3ejZKdjhjQml5b3JPRFluc1lNRUg4ZlkydkN4L20wSlJwT3RE?=
 =?utf-8?B?SGhSRi9XTzBRSUJxVnFXRXF0N2wyRkdiRm15SDhqSFhHVXIvN0NTRkxORnFJ?=
 =?utf-8?Q?A8BYo82EXptk45+jwbyB+L9ip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b56e3e-de7a-49e1-8c62-08dc3138a699
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 10:50:56.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2cUw3KI9ivWWOUxVVGOle9NR3dmfZUaM2UQNTN5z71yBFCz8k55AjE6ancRVMkVInhmjbWV3G59CjTRFWjcug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183


On 2/18/24 00:04, Takashi Iwai wrote:
> On Sat, 17 Feb 2024 16:56:23 +0100,
> Mark Brown wrote:
>> On Mon, Feb 12, 2024 at 03:12:55PM +0100, Takashi Iwai wrote:
>>> Takashi Iwai wrote:
>>>> Interestingly, the system seems working with 6.8-rc3, so some piece
>>>> might be missing.  Or simply reverting this patch should fix.
>>> In the bugzilla entry, the reporter confirmed that the revert of the
>>> commit 4b6986b170f2f2 fixed the problem.
>> Any news on a patch for this?  Venkata?
Hi Mark & Takashi,
Sorry for the late reply.

4b6986b170f2f2 ASoC: amd: Add new dmi entries for acp5x platform

There is no relation with the below error and this reverted patch, this patch is to
define is to load Legacy driver for Jupiter Steam deck variant.

We will check on this.

Error logs.
[    8.755614] cs35l41 spi-VLV1776:00: supply VA not found, using dummy regulator
[    8.760506] cs35l41 spi-VLV1776:00: supply VP not found, using dummy regulator
[    8.777148] cs35l41 spi-VLV1776:00: Cirrus Logic CS35L41 (35a40), Revision: B2
[    8.777471] cs35l41 spi-VLV1776:01: supply VA not found, using dummy regulator
[    8.777532] cs35l41 spi-VLV1776:01: supply VP not found, using dummy regulator
[    8.777709] cs35l41 spi-VLV1776:01: Reset line busy, assuming shared reset
[    8.788465] cs35l41 spi-VLV1776:01: Cirrus Logic CS35L41 (35a40), Revision: B2
[    8.877280] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
[    8.877595] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
[    8.889913] snd_acp_pci 0000:04:00.5: enabling device (0000 -> 0002)
[    8.890063] snd_acp_pci 0000:04:00.5: Unsupported device revision:0x50
[    8.890129] snd_acp_pci: probe of 0000:04:00.5 failed with error -22
[    8.906136] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu]

Thanks & regards,
Venkata prasad.

> It was already reverted in 6.7.5, as there was no further follow up.
>
>
> thanks,
>
> Takashi

