Return-Path: <linux-kernel+bounces-162374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC618B5A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13411287836
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64E71749;
	Mon, 29 Apr 2024 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wLQBpLu3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5756F510
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397747; cv=fail; b=mI/C4WQSp2orD7y2XnRE/zKTW65Fi8LEOQAE+PvIbjlAL9vwBRBuH5Y9tlBcAHDWEMg2+SlgPzZRkalUaBRd9LJt9o2IjiHBxgt/xdi+7N9rU99zrQ2ps5GcW/f9Xi1S4eIbgRUZ9JihuCsaYSxppb+YGpLWUlWe7Kx+o00d6zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397747; c=relaxed/simple;
	bh=bckSx2kZt8gILJ9v5+DnwFMTNJqepm8mes25rboVh3Q=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=IwnOBkJw6A7NBj3IqQk5Dk2YyLOxJsLCMYCM7agSNI0j/yhm2L4mpu/vyLJMnw8/C7Q4GYplyV+lW9u/OtAV8m7XxdZQq8+Xr2/2DR312rvZyBfFKO3ZGdeHbvy2BKC8eTJ50fbsw514qyrvBori3Azoxdarh8kt8I5RVJaiR4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wLQBpLu3; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6Rl8Bj3vyXVCi37AkWFhyOdjtr5dNFemdyJ58HKpXe30gnubVHaC9mb2hxq4oooIGGw5xwEZ8oWq1epNATGMpGVEENv1On45aYhHHMUI/afo1l+9zwbycHllIQsokhHQJ/tTTGBLtImfGvUYPNodH413DJ2YSHp+4EIeW4udXhZZ3OosGvw8zHkDyOvV51VXJTShwe2nmekOZc8mPx0fhcr7lqWEmFI6SN8o6EpRk5CKzlSCUwN9EmBQbvwuGlWXqSuX++glwpQ32BxGQCb1021QXgxVhf3UE1YVMPpyvqCzLZn8Tw+FojvYwrb1tcRitxK31vz0vAEzvVAKAJdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RlhPCvrEO5WUIKVceaovdKVZO2/HDwAV1pF2cQGqfM=;
 b=iecxk60n8dHU/Ym+VtUvLzVKoST1iYyonCxrruJo/4zpT+C6z7m750TF66R7v0BUBCb5XhtXOPlC2NeN8AOPpY9o3QXojW4wOs7DkJzTfzRy84z/3WAoIs62Z3oaTHl09Cu2wZ0dYYw8BfZH82nK3hNBqdhHVtaqAPqLtldsKJYO0q+5YBHOfmH++6ZMXnQt+x5nX7FmpBaA3pBcQ1N/FMKV/J1oH1az2my3HbXytMcAiXYUMhAdLolG/1ewjGUI4P5dTXfpp5HMWLA57WrElsG9yu8SOKToetxYEoMicKfte24ksDvUbiRdzxvXR5g8Kmgj+3+o1/2Hhhh5E4jKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RlhPCvrEO5WUIKVceaovdKVZO2/HDwAV1pF2cQGqfM=;
 b=wLQBpLu34CesXTK77XPK05hZsFfDUxX3xbpZIo3hKUnQFyId+asbOPs64cXYm+GAGuhmyVmEot6J93vTgKucHIHDnVU6CXHSbqbcYU9Rzc42ib2m/WPihY+c+BDIGXhvnNmaLgfNLkv92zBQqz4uACDaDT3xgCPtinUGLu3YVpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 13:35:41 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:35:41 +0000
Message-ID: <f6af3a35-7ddd-7f56-d7d9-34c77647614d@amd.com>
Date: Mon, 29 Apr 2024 08:35:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
 <662c239680842_b6e02944b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility
 support in TSM
In-Reply-To: <662c239680842_b6e02944b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:806:a7::35) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac451dd-7760-4a56-7cef-08dc68514389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzdvbW5QUXI3U3dvdGdFTTlEMFBFalZJdUhuS3N6cDVFQUErcE10WFVKdllT?=
 =?utf-8?B?WEthLzZpK1k3Z1RrRFlNenhUT2pxZVlBVERhNXZaR3ZlSmYzbXF0YWNGemZF?=
 =?utf-8?B?aldCc1lHb1hPK2RpSk9rd2ZvaVRmYk1BMVpEMnVOelRZRzZEbWRxUHhzaGRU?=
 =?utf-8?B?eEgvMlFQNUdLa2w1cjNWa1FHM2xBVml4MWt6aDdwRWE2RVBuaW5ObDBXMG1X?=
 =?utf-8?B?S2lsVjNqbE14cVZSVWNIalZpMnAyeVJPVXYwTHM0MjMya2RmL1dNSmVTOUFq?=
 =?utf-8?B?clNDdkhwOUNZSkQxOWI2NlJyV1JMdjRUNFBXdlpKbzNDRTZxU2p2RCtUU3hk?=
 =?utf-8?B?WGVzb0RJalNtNStDWjVVSGFPUDhqWnBydy9pc2pWZVhrRys0c1dKeUpJbm1D?=
 =?utf-8?B?b3JXaWlQUEtQSnFrZnRpRFNBbnd2clEzOGM3ZHRZMHpuMUVLYWYraU1MOEQv?=
 =?utf-8?B?Q21vT1RBaTcrUkhWdkJFMEpkNUQ5ZmxqbFFrMDBKZXppZjdvOWhVRm9HWW9y?=
 =?utf-8?B?N0hzU1Nicm5BblpxWWJ5ME0yU3pNSmdZSTNTTnJ2enVIbjlVa3hNT3hnMitO?=
 =?utf-8?B?d0xBOXdKOHpBSlBLTDViaHVXMHJ3dWptcDc3YVdCS2VUVEdFc3NzY3Q5dm9u?=
 =?utf-8?B?MDlsc2IrT1VWUVFSME12dDFwTlJKaDdxakhybFlac0IyR1JsMHR3dzg3YW5F?=
 =?utf-8?B?VGd2Ujlkb3hQS1krQ0NleGw2R2QxM1p6bzNFZXhUczBydGphbTdSdGNKZUt6?=
 =?utf-8?B?dUQwMHJ1WHdjK0drQ3FQQndTSjQxR3B5blNWalRtTElyTnVLd2FrM2IyOXcw?=
 =?utf-8?B?cjFKSDVBOXNlaWgzc2JxSGRCRWMvTW9CUFhNZmhEa1ovNjhTc3VUUW9jYTdB?=
 =?utf-8?B?cDlUTEZzQWVDMkl6bHJjWHFWa2x5S2dkVVRQLzBNbFpuVlBjT1NNMmY1dUMx?=
 =?utf-8?B?OXlyWnhEQ2E4c0FtcURTb0dSeTdwZ3EyTnFlK0M0a0FBdmJ0MU03eWpCSkFp?=
 =?utf-8?B?VVo3RDhETU1rU1NWQjBlTVJRenFlREFCSDhOV1N6Vk5KcjA3NG4wTWhxdWpD?=
 =?utf-8?B?cE5QWFp0Z3pJbGFHUkVCY3ZCdzUrWDVtOUduSTBBWHU1cGtLN1Z4MUw3eGg2?=
 =?utf-8?B?OThHMXVLdndOeENjajYrYkRkSlVDamcybzQ4bmtHVm5TSmNuVU1La0VEdG1a?=
 =?utf-8?B?K1dnS1JEd3lDUWc2Zll3SUdFRnZFdGxyQmFPVkRoL3pBYnVVa0RyV1FmRnNN?=
 =?utf-8?B?NmdGL1B4ckh2bWFyRm9VQVpKQzYzbWZLVVEwY05rbkx4VnZRLzhQekVpb3RD?=
 =?utf-8?B?V1cyRC95V0FFd0lySjQxUWdTczRGUUxpVzBXbTNUUldqMm4rL3ZyNndWeS9p?=
 =?utf-8?B?U01oV1dydWhLZ01SeWtVcGRqUVRIV2dwOGlvTTYySlZsTksraVhJOWdwZlMw?=
 =?utf-8?B?dmtIcWorKzFuSnRjNFVLUnJxUjlpYlRCNzVZRWU4VzJBWHQ4OUN6Yi83TGFU?=
 =?utf-8?B?MnFQWTArWWlJbWx6TmlBQURKQUQ2T0VFSXMybkxqbll6ek1DNGxXaUlROHg1?=
 =?utf-8?B?aG5ndTBwejAra2hVejZUOHZsWGowbHJGS1RKSEF5SFpJZFNoOElSc2g1T3Rj?=
 =?utf-8?B?cFZFb0YxdDc1WS90YkhCMHh3VTZNN0pRaFFTYU80OUd0amFBdTZTMGZBeDJo?=
 =?utf-8?B?NjVwdk1PTXAwOEtjdmxYYVQ0RkIrZnhNelJ3YjJZMmFKU2IzTnNBTmhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFVejgrV2NoVmpmdW1vYk9HZ25uTkxDVGR0dWY0cDZBNnozK0tPdHRxdTNL?=
 =?utf-8?B?MGVGeFVwQW51OHkyeDFUZDRsQmgxejJOWUMxcjdwSElwMENnUjRtQ3FvY00v?=
 =?utf-8?B?cEx2M0dLb250S1VicC9nWjFxZmVNSXhEeWV3blRiZjBqYXR4aExXOEdkNGF3?=
 =?utf-8?B?MEJGSUhiTWZpRlZxMDQ0WHlLUEJCTjFhYXZYTTV2S0NJeUpPSTBJU01VK1JL?=
 =?utf-8?B?YW10dXh4UXo2S3RyUllDb282alBybE1qSFBiRFVWaCtwRGFsam9OL04wSzZM?=
 =?utf-8?B?MTVkVE4rVmc0VERFRi90MUtraS96bitrKzNaWEQ3SS9YQ2V3WW1jUmV5U0lL?=
 =?utf-8?B?bUsxVGZmMlY2T00yWnBCOUtVclBZTXgzWUM3aXJpSncvK2RBZ2Z2bXgza3Rj?=
 =?utf-8?B?MEdrMkJJeWovRDBEaDh3QW9HZGp0NDFBdFUrQlN0a1FGRTlKNHFDY3ZmcDlr?=
 =?utf-8?B?S3VHbTVVb3ltanVhdXpLVG01eXVRV1p1QnFUM3hLUDdETlBDdkhHWEs1TEVm?=
 =?utf-8?B?ckY1U1pudkYwS0JTKzNDbllna2Q1c3FDVkJ6QU0vbFlkeVgxUHhmb28xdmpR?=
 =?utf-8?B?akdsT3o3UWQ4TXUrSEVUbVRKWDJyMXIzY01zMCsxVGkxa0JtWk1JZjFZdzA3?=
 =?utf-8?B?ZFBaVHAzektUTEViZ093UXVSeS9LN2RlU1ZJdDViZFVNU3NIR3pMUk4xVTQx?=
 =?utf-8?B?R0JucUNrblRhbmtnVEQzSVFwSStZV1NoSWNGQklCb1MzdUFSVlBEdEFZek55?=
 =?utf-8?B?ZVJVNFhGRWg1SVE2VGxLaDdIZXRvSlRCbnN1cUc3Z1IyS1dSL3JpWEhhcmtk?=
 =?utf-8?B?UXJCK0RZYXhmVUNXVUN6TVNWTW1kSkk3RVNmRjFpckNsVmM1NVVub0NaNHlP?=
 =?utf-8?B?OVlFZVRZSjdIQnBhQlJCeWZqWTVTazhsU21IYVJObWl6cE5lVE5oSlZBN2Rv?=
 =?utf-8?B?NFZhU2VRbmxlY2krY3AvVVJ3U0ozQ2VhQlNjZXRuVDNKNHpPWXdCNFh4N0xR?=
 =?utf-8?B?akdPT0xGTWZvWDBuZjFBYUpuMUMzVGZ4ODZNVzlsQjdnQXMrdUlWeGNHcVpy?=
 =?utf-8?B?M2t3Qm5MVzZuanhuYk5SME9jWjBYaHcwdHllTzBZL1RrazBSVGRsV3hLRjN1?=
 =?utf-8?B?NUtHb29BbGxFenhOV0FrUGZKVXdHalNSelNiYURkWjZyMFN2aUszdjdBNDlH?=
 =?utf-8?B?akd6M0Fyd2o0TU42ejI3SjA5MHZXNkhKQTFtQVBpcVJuSzEwaFc2eTU3Qjha?=
 =?utf-8?B?R3MrNXFBeWlQejJMbTZTbEM3M0lQMUFQb1Y1bzNpWWo4MElLTWFEMnJzaWlu?=
 =?utf-8?B?WFhxNVVjSGhXVTBHWkpLZmc4UHJDcytUZFlxL2syaDJsYklIakJaNmJ1aUg1?=
 =?utf-8?B?OVA0TzNYRTAyUlNkSTg3RXczSzhCMjl6WnloSDAxMWQ1b0JnY2NNYzhPNWN6?=
 =?utf-8?B?MkFkQ002VE44SDFIVGlJWFFLZ0pBTDJHWnZKTldrVEZqVWxiVUgyVGZ2VFJO?=
 =?utf-8?B?MkZFdTc0QUhocVV0MXUzRldvYitab3lHQnR4bU92MkY5bk96cXFadk1aSlp1?=
 =?utf-8?B?eEpEQm9LVGl1L1lVMkdPQXROajJpYU1NNXBud0Z2akk1ZElXMVd2eEFqVUZv?=
 =?utf-8?B?WFhPdWdVUDVWcnlWK1E5TmhzMDRqQjFtMmFLMnA1NjRBSkZOYndGY3NXRUVj?=
 =?utf-8?B?UWNSY3RFL3hKZy9OR3d2TTBubGhBTGhnT2FFUFBOOGVucm9aWFRBdmVkLzhm?=
 =?utf-8?B?MzJRZm9LUnVOczV6VlBTSy9Rb0J2UEZ1N1dkL1FiQ095dEZOK2hRSy9mQnUx?=
 =?utf-8?B?a3Uyb0YrRExqTUh6Z0ppTnRUZ25vRXhYNStmWW51SWhoc2pFN3FCcWhWRTRY?=
 =?utf-8?B?VHJKWGJJZ1JBU3NEY1ZBTStpU2J3L0Z2NEZodko2aHArc25lL0UrVkduMkNK?=
 =?utf-8?B?dkV2Zi9NVThWTUR0WXJuRTlYcUdCN2FhVHZCUzlmdmRqU29yUE44Z0cxNnY3?=
 =?utf-8?B?ODdsMllDZy9jQWlJbTZ4QWxsL2RBc3c5cmlsNDBWQ1JDTTJDdldQTENVUUtP?=
 =?utf-8?B?UFQxSzRZQmNnZ2U3WWdjNWJURjRvSVhUKzdSd1YraThXaXdJM3NIM1VPUlU0?=
 =?utf-8?Q?CAd/tCDMa6TXtb+9HDG4L2AA3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac451dd-7760-4a56-7cef-08dc68514389
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:35:41.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX8NifOWbrw7klPd+AVUaie9KyqW7mduQkn+rEjaV2XJ50sBqiOlZwnpem0/yxCEhI1RotjtL3uDUn6wCyHhAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487

On 4/26/24 16:58, Dan Williams wrote:
> Tom Lendacky wrote:
>> The TSM attestation report support provides multiple configfs attribute
>> types (both for standard and binary attributes) to allow for additional
>> attributes to be displayed for SNP as compared to TDX. With the ability
>> to hide attributes via configfs, consoldate the multiple attribute groups
>> into a single standard attribute group and a single binary attribute
>> group. Modify the TDX support to hide the attributes that were previously
>> "hidden" as a result of registering the selective attribute groups.
>>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
>>   drivers/virt/coco/tdx-guest/tdx-guest.c | 29 ++++++++-
>>   drivers/virt/coco/tsm.c                 | 82 ++++++++++++-------------
>>   include/linux/tsm.h                     | 41 ++++++++++---
>>   4 files changed, 102 insertions(+), 53 deletions(-)
> [..]
>> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
>> index 1253bf76b570..964af57f345c 100644
>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> [..]
>> @@ -249,6 +250,30 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>>   	return ret;
>>   }
>>   
>> +static bool tdx_report_attr_visible(struct config_item *item,
>> +				    struct configfs_attribute *attr, int n)
>> +{
>> +	switch (n) {
>> +	case TSM_REPORT_GENERATION:
>> +	case TSM_REPORT_PROVIDER:
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static bool tdx_report_bin_attr_visible(struct config_item *item,
>> +					struct configfs_bin_attribute *attr, int n)
>> +{
>> +	switch (n) {
>> +	case TSM_REPORT_INBLOB:
>> +	case TSM_REPORT_OUTBLOB:
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
> 
> Why do these callbacks need @item and @attr?

It is a generic callback from configfs, so outside of TSM, an 
implementation may find it useful to have these. But, with the code 
change to require the callback at the attribute level, now, these can be 
eliminated.

> 
> [..]
>> +static bool tsm_report_is_visible(struct config_item *item,
>> +				  struct configfs_attribute *attr, int n)
> 
> Per the comment on where to find the is_visible() callbacks for a given
> item type, I expect the need to pass @item here goes away when this can
> assume that there is only one way to have is_visible() invoked for
> @attr, right?

Yes.

Thanks,
Tom

> 
> Other than that, this conversion looks good to me.

