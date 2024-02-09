Return-Path: <linux-kernel+bounces-59325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187A84F56D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265E11C21D53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A80374EC;
	Fri,  9 Feb 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xoy7M7lB"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758672EB19;
	Fri,  9 Feb 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483010; cv=fail; b=Y9hMXvBnMgDNu37vexQUzINhTow+TwcfBrCAlbCRz91/gGlcQx/C8tVZocp1JyrX7W9/gHp1zKWG687LX09G1U2sSDf42q0f5NP0Y0wvEjTKxt8U+6V4UZGXStoujDHA52hj8InnPYWWz3Ddfu2VeHGM0fK2X+pVa9WpKmYZsUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483010; c=relaxed/simple;
	bh=qa0ey2O8HFuREB0IXVp/zP8MAiHg/c/k89q1LVM/kK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DHiQa7RT3RdEyrr/1uWYzbt3lBVQ48MWTzPSwyiycqAi61a8CvGHKrDJggozMWkMyOmY0p1bw/FTRcM9iFMnjlJ68H5dlPuYbaFcChGg/ziTaOk9LEST5TeOOQkwdCpYpkzldRs6alDjWCD/lI2qEkMbuDdayzHqoXZqdKd5xEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xoy7M7lB; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq8R7ZSv8GqUINvlFGt8C4LUawHAifZiuuIk1WPJ6f8CYMxwpPAC1oU9K78u5h9Pe7Q5YTvIhPyth5yUDN7URcAuxEuhokhE9qoLalwgidOLBxxzS+QA/H96SC+VVe3Q8/pZdTure/lvm9R1o/9ytBbXInBk1Hh3sUuraAxvlf8myCvLsrrbKs5xym1yPj/Pp0NQAqvwel9cUZh5qP+KfH65GdcokNjrb1ZgT06BR7qtHuNUCBoW5cdSjeWXm3bFqo1Vq8hoDkGm4/Z/4hKunaRVcvCm/4vDItEo/6negvwNoo0GNtoq9s5YtnlDqhcHMpf2cuwJ0JOLceeCDzh2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd4vNPN0cn+mVQt1c6+Tckit9EqI4x1KQRIZOxGa1Sc=;
 b=NF9GfesJAwv1yYpVvpSQAwYsAf4sn/oxAABN0HNqGL7adI5vvHimnrz4dLmELiGeSLMltGW/Ro2HLN6RdrVLWDAvb1a8yNgx2o1cjtNuvvlYyTYeT+ttmjFcKSNIrZ08qiaTryBJofW8EZeurN4eK8bZxsSBtfT1Y0B+zsWdh1AEVnENs8fwXiZmxazvbopNp4N/9TiqS4Pmjm9FE2q83HAFSRMAfPSZrVHaYLU5mVDBWRx/uY11snSaQWsREkZsFSUKEfB78+sKS5WojSKfKhHuida0VroypfpmuC4TPF1rOxw+fc/ktXiSVBob6jdYnS+P/7Y2SQ0Ons7fOhMg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd4vNPN0cn+mVQt1c6+Tckit9EqI4x1KQRIZOxGa1Sc=;
 b=Xoy7M7lBS4iw49OB/hGqeraA1G9giXuAWtnHIYrCukHEScZlmcMoTdTNESYo00tDIK30XspvTIY4arl/9pOG1nIJKI0JtrMKrPcV8iJESjyksRitcalJXDWIEp1pJWLqxwpd/TL3cirN7UJPpeKc5abjNqCuiXvjPmdylG1iiL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Fri, 9 Feb
 2024 12:50:04 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::2104:c308:eaa5:b978]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::2104:c308:eaa5:b978%4]) with mapi id 15.20.7270.015; Fri, 9 Feb 2024
 12:50:04 +0000
Message-ID: <f4b87510-4f55-4364-960f-5870c4d86874@amd.com>
Date: Fri, 9 Feb 2024 18:19:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: amd: Skip IRAM/DRAM size modification for
 Steam Deck OLED
Content-Language: en-US
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20240209122810.2258042-1-cristian.ciocaltea@collabora.com>
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <20240209122810.2258042-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::19) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 6020ef0c-7f34-4c95-b732-08dc296da2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oj+KJC1HogETbAeIP3bWSzGOHn7LhY5l4i+i+VeT8Hq+KCqJrBJvwVjdGfMOpxBVONKheU0Zym022X3qEhc8lSaHiznVm4FOLdB8L6JLaZiwHsGNwXUyYSOZEqb3RWrTCCuOMd6YmOTq6GWfO8/xyR9td9Sy0fKBY6vpkiqDwahg1KnHHxII3JGxYZGaYmZYx21BvFOcVY6pJFws3WAJkDAaknNsAYR9FaB5midvSYFOvUcG5t3KhIWz0jZRpzkCLYK0flrCeZaqrpt45m9Fpmn1uZ01gkg0vSCPrtnRS/clpicfwiQHJA0bZyfx9im31wWCD4emPJe0AObDatU7CyLeYWMCTuFI5KxmwyhtGJ4zMP3zxYBYfJy4UZMVWcfprZU67lBjZwgh11maLigD41xwlcToqWCSWxbN7JkMrJ7izbh4i6sWmshgx/6rVYuQf6TRm/AEWmRF1bg/EnuN+uSA49QgmqgUMeHjrZAx8u/sW6DbiKuF82ZLlZQtLcj4pGuU5EoIuY6VjdtqSu/WZT/Az3+wdGcmMytCIxgRC9KBiSFTpt80zwT1g5MHL9TOkUxarTYwIFX9F4SPbhtU5hPv4x+fgaXJgbz0mOAdT0I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(921011)(86362001)(6512007)(316002)(478600001)(6486002)(53546011)(110136005)(36756003)(66556008)(31696002)(2616005)(2906002)(6636002)(26005)(83380400001)(4326008)(66946007)(6666004)(8676002)(66476007)(38100700002)(5660300002)(7416002)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODA3eDZFMGRFMjRCM0pWVzd6WXhCUVJnbDBQMk5rdDI0SXVvTmZaNHVKQW40?=
 =?utf-8?B?TmIxYzRGeXRuSTl4UGliNWRSVjJVdnFXbk81a1JnZCtzTDdsMUxqcnZoYkxB?=
 =?utf-8?B?cGFpZm00TDFuWVZqdnB6eUhEVWlWN1I3cFJzMEFPeExuVWlvK3NwTlFIYjE0?=
 =?utf-8?B?WWNkenpTSFNuVkpuQzRVcGluSjNOL014dVpQdEswREs3K1k2VlBwTlRuaThD?=
 =?utf-8?B?NS9uYmRjSkVTbnlqN1IrT1JrRkJuZEVOdDJIOGQycVQwL0FlTHcyT3U2RUht?=
 =?utf-8?B?ZUhqUmt1Z25nUnNYMU9aWWRYUE1Rb3BYQkJMWnVqRDJ5YlVkSEdjVExMaHM0?=
 =?utf-8?B?bHNKSzVteDdJVXdXdTVzckg5YlNMcFpqU2hGanRaWlZueWtqUnY4eU10Vlhn?=
 =?utf-8?B?RXJISWxjUzJVb04vbU9Kcko1aEVwWUM1NStseHB4UjFKWEVYSWlwdzRjUVB5?=
 =?utf-8?B?Z0F4Q1U4UWcvcDFiV0dnUWhQUUNJU2NlTHVLVDZHbTAxM296OTR5em1yRGtB?=
 =?utf-8?B?c2dSVVZQTnJyNzJsMVFVWDUrWHlGM1lobit4Y0Rwa0wvMG43UGhGc0xuOE9Y?=
 =?utf-8?B?TmNkc3JlODBRb1VhN3NpVE9TS3JFMGQ0c2MyS0pTUWR4SnhCWmFjS0FEQWFU?=
 =?utf-8?B?eHVpem9HbExwZmRFTG0rTW9SNDcrL21wTm9VYzB2V25yZUtzMUhOOXowYWhv?=
 =?utf-8?B?RlZicVNDSVFVRE9QL09Vc0JZTSs2UXZYcjRmck11T3I0WlRJenN0U1ZLVXJr?=
 =?utf-8?B?bUphdjZlOTlKMDRWRXNsaHRqMGZDTTFDa1d0cFNaa3N3TFo4a00zRVdzVkZx?=
 =?utf-8?B?aWlFc3o0RWpkSWVDUEhBVXRuN1VybzEza0pES1N5eWVqSW4rclF4ZTVydzJK?=
 =?utf-8?B?SFc0S1BoNEM2ak1vSXk5ZGxqeVBGdkpsM1QyMmp5d1pPTzBRMCtWaitwdktk?=
 =?utf-8?B?SzBUb2ovWE9ucFRxdmZkNGM0T3RlM24xK096OEpMMExEU1FkTGFOSi9QSEMw?=
 =?utf-8?B?UFJNd1B4Mkp6a3owc2JwdnhkcG1FZ01uSTJYaFo4eFhXaDdpN2tUTjd5eDRn?=
 =?utf-8?B?aytTV3pmNjlFYktKOHNta09sYnNiMjFIdUliNHNUdjh6RXYrL1dySmN2S1Vr?=
 =?utf-8?B?L3Z2TDV0clJBNFNmUFJVVHVSdHlCeTljRHhVM1BxMERUYzdJT3VSOHRkWVhH?=
 =?utf-8?B?VDJJREFUaVRXMmt4bW02d3QxS2RBb2gxOEFUUnNSOEJSZFhxYzJEeDZQZS9l?=
 =?utf-8?B?SEdhWkM5RnArZnhrQ3U5eHMzTFVDcHlxMXg1NFd6bVp6amxsNmI5TklDZGhm?=
 =?utf-8?B?VWlTdXNBRXE4ZmxpOHNOREpvMFEzSHUvNnFuNW9Ca2NoOThvZkdpZ0pqdTVK?=
 =?utf-8?B?VHI4SGxOMThIeGIydlF0Q0JsYThjeE1aU1RNZ1AxbzF0TzlYL3pBamRYUU04?=
 =?utf-8?B?NHNUY0txZkNtcE80bk83TkZNd2w4NUFQb093cERHTjVwanFWbDJwQlR2cWls?=
 =?utf-8?B?Ymhsb2ZpWnByV3o2NW9ySVQ1SzFBVUVNUUQybjlCbHhESUJaU0QxNjdjWGNU?=
 =?utf-8?B?NVpHai9iYlhaUTczZDZTYU1zOFM4dlpPUmNMZ0l4N1VHTnBhUDJYTnNhWWZ0?=
 =?utf-8?B?b0luckdjc0dMNHpWeGt3ZzF4NEtLTDBSWGhxNzd5R3lhUGRSL3JkdkRmUTF2?=
 =?utf-8?B?cTdvdlhiTTJ5dGNpNURlQURGeVg4cmkwNG1EdnhGdXErODdyNzRUQWE0LzQ0?=
 =?utf-8?B?UGN2bHFDVkIyajd2SXlGRWVWQUxIRFhKOEovL3VXa1AyeG1Wc0RBdnVuNVdS?=
 =?utf-8?B?MUdBQm1STmhJR0ZoSENjVWhPVjFXK1h6SjBwUXhtTjQ4RXZqMTIxMFRxc1hw?=
 =?utf-8?B?ZjZ4R0pOTHkvcGhVcnJaaGlGejhwNFVjQWZ3MERqREFpcFJkeTl5R3ZmSFRl?=
 =?utf-8?B?UUxSSDB3cCt1bjMzN3lFZnNTV3dwT3FtRnRKdzdWMThGQm0xNkRCWTdRUVNa?=
 =?utf-8?B?N3FVL1ZUcUJlTWxqRjJncjUxcmkvakQ4M3FIVVRGRFJjeVBMdlNzLzd0UWM5?=
 =?utf-8?B?UFFmVlhlaWlRdVpKVG1sb2RKZUVRaVdxdzhTYS94TnE3ZmIrWXdZbmFHMVlj?=
 =?utf-8?Q?NFKbb+DW8nCQTLnPKWMItniVk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6020ef0c-7f34-4c95-b732-08dc296da2fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 12:50:04.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcgZd/OtaEfOlSTKRsgM0NoU7r6NfeEmDt7VrmzP/6VEQ2HLNsTbcYrMnTOXqvJboivAg+gLAz/onjv1tFKMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243


On 2/9/24 17:58, Cristian Ciocaltea wrote:
> The recent introduction of the ACP/PSP communication for IRAM/DRAM fence
> register modification breaks the audio support on Valve's Steam Deck
> OLED device.
>
> It causes IPC timeout errors when trying to load DSP topology during
> probing:
>
> 1707255557.688176 kernel: snd_sof_amd_vangogh 0000:04:00.5: ipc tx timed out for 0x30100000 (msg/reply size: 48/0)
> 1707255557.689035 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ IPC dump start ]------------
> 1707255557.689421 kernel: snd_sof_amd_vangogh 0000:04:00.5: dsp_msg = 0x0 dsp_ack = 0x91d14f6f host_msg = 0x1 host_ack = 0xead0f1a4 irq_stat >
> 1707255557.689730 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ IPC dump end ]------------
> 1707255557.690074 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ DSP dump start ]------------
> 1707255557.690376 kernel: snd_sof_amd_vangogh 0000:04:00.5: IPC timeout
> 1707255557.690744 kernel: snd_sof_amd_vangogh 0000:04:00.5: fw_state: SOF_FW_BOOT_COMPLETE (7)
> 1707255557.691037 kernel: snd_sof_amd_vangogh 0000:04:00.5: invalid header size 0xdb43fe7. FW oops is bogus
> 1707255557.694824 kernel: snd_sof_amd_vangogh 0000:04:00.5: unexpected fault 0x6942d3b3 trace 0x6942d3b3
> 1707255557.695392 kernel: snd_sof_amd_vangogh 0000:04:00.5: ------------[ DSP dump end ]------------
> 1707255557.695755 kernel: snd_sof_amd_vangogh 0000:04:00.5: Failed to setup widget PIPELINE.6.ACPHS1.IN
> 1707255557.696069 kernel: snd_sof_amd_vangogh 0000:04:00.5: error: tplg component load failed -110
> 1707255557.696374 kernel: snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP topology -22
> 1707255557.697904 kernel: snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at snd_soc_component_probe on 0000:04:00.5: -22
> 1707255557.698405 kernel: sof_mach nau8821-max: ASoC: failed to instantiate card -22
> 1707255557.701061 kernel: sof_mach nau8821-max: error -EINVAL: Failed to register card(sof-nau8821-max)
> 1707255557.701624 kernel: sof_mach: probe of nau8821-max failed with error -22
>
> It's worth noting this is the only Vangogh compatible device for which
> signed firmware support has been enabled in AMD ACP SOF driver via
> acp_sof_quirk_table.
>
> Hence, use this information and skip IRAM/DRAM size modification for Vangogh
> platforms having the signed_fw_image field set.
>
> Fixes: 55d7bbe43346 ("ASoC: SOF: amd: Add acp-psp mailbox interface for iram-dram fence register modification")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   sound/soc/sof/amd/acp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
> index 9b3c26210db3..71689d2a5b56 100644
> --- a/sound/soc/sof/amd/acp.c
> +++ b/sound/soc/sof/amd/acp.c
> @@ -278,7 +278,14 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
>   	}
>   
>   	/* psp_send_cmd only required for vangogh platform (rev - 5) */
> -	if (desc->rev == 5) {
> +	/*
> +	 * FIXME: This causes IPC timeout when trying to load DSP topology
> +	 * on the Steam Deck OLED device matching acp_sof_quirk_table above.
> +	 * The quirk enables signed firmware support on this particular
> +	 * Vangogh compatible device, hence skip IRAM/DRAM size modification
> +	 * when signed_fw_image is set.
> +	 */
> +	if (desc->rev == 5 && !adata->signed_fw_image) {

Programming ACP_IRAM_DRAM_FENCE register to modify the size of IRAM and 
DRAM and it's noting related to signed or unsigned fw_image.

This ACP_IRAM_DRAM_FENCE register writing need to do before starting sha 
dma.


>   		/* Modify IRAM and DRAM size */
>   		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | IRAM_DRAM_FENCE_2);
>   		if (ret)

