Return-Path: <linux-kernel+bounces-158922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF98B26BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B50EB23348
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A7F14D2BF;
	Thu, 25 Apr 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LNpYK0hb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FEB14A0BC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063510; cv=fail; b=ChZYEwGGxG8SqjQ7uvk9gBYu8Kl9/OorNgtLabONxA1NdIswFW9MoZsMiz7PaL+FHqI/lGxyW/JksVhDoxUfHtOsmeKUFug/aXrJUf8UYJZ+1AhHy8JI3l7b7RAyABHLKFZxY5r+LXDFondxzw3e6w3zJknmTI/YqYx7NgRsuco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063510; c=relaxed/simple;
	bh=xN7A5tl5al7JutYOa1fmvjLDosXaBpJSi0FEmH5m18s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COt1K2QZfeeTeUQ5iia7yQgEEY7tj9/6YsPcqqUAIFFCkAKCHEFFoY/wx1ci0PmGgdKvmE3GlLn/yCCd9ajB5scu2cd0e3A+UESnQsscYtmHEZc6iGNerOFeJwRobaTjFd6Oxg+ezsEK9ton8VF1bCMoGvWOr2KNY/gnn5JJhrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LNpYK0hb; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO1FIFUfdAo3GsU8S3ZRc7++//IaFGkicvi1xXyWNiCg6qTFAkkUm1IXEaiM0ny8+7QKZqDimRzsZ5rwdAl1+NSfh54bMT+si8of9K+7Duzcr8aPuMadpbD1Q9uJkeguGUXX4OuwN3WybUYxgVOcNvNLRJvR+V3yQhL75LUdUrHj/SW+ZRwjTPbQlENpaeFBU5TnBJcqzxKzhLLLUs6+N/CH0sK0V85wbiuTRlTp2bftvlZyv5eyr1GQm7wR7o0/jsZRJSn62bcZRKyvtTPCWzYIffABylmNPHunvTr6QATh/Miyc8f3WV5/YwUg18VS2JEH2Ov5lOTMtB8/PKARNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AVkvnbfH2UU9A12N9umHHgJyY/Ju/6l6jvSSNM3kog=;
 b=DipfP5v7ORyDv0kM5EHRMmNLOpJ942RkFsRyirXl4KK99spG3mBql3Xr/RX9p6d2ukLt5LoROj6ge7vz+UALwBoRCmz35qDLrrSti7BJzIakmLhb6hex7I6P39lWiPPrZhfOv/wZVV6vSb0pyJalPGCsH1jiAi0RzdSdHDhHFHluVarSPkcp7X/wkSOBBJTOY7U+/YjgWijKSIPmuGW4BNzkU6OYluQB1dOjCHBeYL8iz4t9gR4X/YXOnYIz/OsonnLi1RITZEg+sYX7oFXWu50shl1V3ZvobGuRQqq14fbzrgIbXBH0OjgO8Yb5d6pVTP2P5bQnSmUKFM3jnkCEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AVkvnbfH2UU9A12N9umHHgJyY/Ju/6l6jvSSNM3kog=;
 b=LNpYK0hboJOOTfmEtjLvA5C1/pfPIgJPA12MJbgC6lAZzm5q+10wlCyJYesJGbPClpjDYKTkb3/lQrdlPz3NP1ffisYzp1gtSXzKXR1xhXZnBSrzDyW72ecJEqSzeo7xS1fH0FKYV1KV86qERaO4CORQdkaTOj1nfChrze3owXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Thu, 25 Apr
 2024 16:45:06 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 16:45:05 +0000
Message-ID: <9c96cf16-73a5-46c1-b4ce-de4e0561ba1c@amd.com>
Date: Thu, 25 Apr 2024 11:45:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
In-Reply-To: <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0260.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::25) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 8119dc75-8e6f-4820-f638-08dc65470f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ppYWk2U1RqR2VhMGszQisyd1NoT3RkemcxVDZoWlBQRzROSEJnVGpib2dL?=
 =?utf-8?B?VEV6TGVTd0hWdUJaU1krRjBybmNlR1BGVCtvNUNNbnJJT0RaK3pZK2hNd3Fp?=
 =?utf-8?B?T2FXbVJYL1pmVUJTQUdsOVkxWVBNdUMwbGdNcDdDMFZobkQ0Qk51MGpOUHNI?=
 =?utf-8?B?eHVDWGFhaHVYNVR4VEp2dUV5T0F3KzRjSE5xcFpUT0sxK1ZxelFVU0FudXVR?=
 =?utf-8?B?T0dwODdBR0t5MWtwKzJBNWxoRURDd29CSmpXSDNkbGVxYURnaG9NL1p4bE1w?=
 =?utf-8?B?elQrbkxUbGx4NVh3WEQ4aE1XRFlnVW94Y0l2UkhhTmgwWHVzMExsQ3Ayd1VL?=
 =?utf-8?B?cWpySVY2QWJ4eVFCQ3lwMEJwenVJMnJPOXFXLzhJRG42UHNycFVjNWl6SlZS?=
 =?utf-8?B?aXJLZ1VMNHdOYXlEUFhkZzVSWWlqL0p0UDdMVWl3Q0Zhb3pXeVFOekdaaG5P?=
 =?utf-8?B?Zi9JbHd3TkJqZmp4aUZucnpwSTBHcW96SWtFTWhJc3VpcWJlcXJJdzkyN3dI?=
 =?utf-8?B?TTZ2QW1qL2JYZXFpaHg5UklnMjZVNTFrdzJzUkF2dVFPSFo2VzRSU0hVRTNR?=
 =?utf-8?B?b0lXVjlka1N1R2ZwVWI2QzduNG9JTmNGLzFqdjR4NVN1bWJsZzJMRHgzVmd6?=
 =?utf-8?B?eUppWCs5bklONTRuN0pxZ2pLYmxoQ2dwajVFeFJleVAvUGl6aFFyNHNNZ0lv?=
 =?utf-8?B?MWt2V3kzWHlVWG95TDZRakcvZHZUbm93enhteVlqVFlMQ2pkN1J2ak5MNzBP?=
 =?utf-8?B?NHVFZlZjWXZLYjFWSTI2cmpMdXRZemFCSm1iZnJ0V29NaGdnSWVUNnBaV2Qr?=
 =?utf-8?B?SUM3bys1N2dvckxBdVc4UnRxemJ0ZnNnSDlNeUlOZFFTMExEelgwbDFIZk83?=
 =?utf-8?B?TDg5Y1VxK3lxbGowUFhpems2MEJuYWlHN3JGQlZQdmVLM1RKYjhNN1VyN01m?=
 =?utf-8?B?a2xiMmxBNmZ1TnBmSC9PNGRiaVkxRUJrL2NGS21ncjVPR25yWWlReVJ0THNB?=
 =?utf-8?B?WVQ2M3NKUnlGam9xdERCY01lTEhRaGJqOTNlb1U3d2QyNC9ZMTVlbTQ5YTFl?=
 =?utf-8?B?elhUNlRCUG5HUDc2eUlVdkI4bGtDTmZtem9xb2pxd09aNTlldUg5TTQwOG1B?=
 =?utf-8?B?eHp2cHFWeTViVXJjbWYrSDE4ZFNHbzVYWFA0Y05LZmFBQjVxcjM1NUdlUyt3?=
 =?utf-8?B?S3U1OGVlak1RY0p1bWVOUjJldjEwMWlVenFYNGFMUkpURWM3V09KZUdOQjNt?=
 =?utf-8?B?cThFcSt5SG9FelFQb3poUWtyWWxMbk5GalRMUjNqTklkZDZLb0VEUG1ESEdX?=
 =?utf-8?B?NnAyR0RuWEZJTDVrK2hhTFJJZ0hSaVN2blQ1YitIZURWMmhxZUg3c2VEWG5C?=
 =?utf-8?B?OHRVRG1YUWRWL3VIb1lzRWJuV0hmOC91SXZkMTJNUndCaTB1ak03OFIvaHRj?=
 =?utf-8?B?R0RtRXVzVGtCOGFQQ01mdFM3ZHJRMXJBTlpxWk1yY0hkUmUwQnJqa01QOXR1?=
 =?utf-8?B?aVNYU2VSalZDekQxak9iVVdZTjU1VDF4cXRXSEFtbmhPall5Vm9DMzVqMWtS?=
 =?utf-8?B?UUZZNjFZcno3SFd2MU1nUVdSaWVNdk1UV05jSjU1d1lMYmNac2tvRW00UlBs?=
 =?utf-8?B?VEV3bER1VFRrQlJQcjJ5U1k3UUFLWlJaYzF6SmhVV0JVVnRDaVJBYnlwK3RR?=
 =?utf-8?B?K2JpOUMwS0M3TEJsU0gxSlhXdXhMUi9XZTVwOFk4Z1RjeVZPNittL3hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2xqNlJFbzhSd0pjZXJVRmN4MHh2ZmNwVlRsQnJNcnNCS1daMHk2ZjhBUGhy?=
 =?utf-8?B?ZjBZTGhxSDlKeUdnR3h2d3N1MW9ZRTJBeDVwNE5Jem5hZDlRS1hQOEVpUWFD?=
 =?utf-8?B?SUZhVFFzSlNnd3ZWU0s0eFRWNVdHWnJnU1pUTlVVRGJiaGNDWWRJdThCU0lI?=
 =?utf-8?B?SjU4V1NEOVlDTE5IL1E5eDVrbjRiSm5HcmJlcU44ZTcwSlNOK1VPWUlKZUFk?=
 =?utf-8?B?NW5zWk5Ec1J6cTVwYlpTVFE3TmZkNjBXcmVqdER5NDZURHNtTm9DZjQvSWoz?=
 =?utf-8?B?REU4dW9yS2ZCd0RId1J5aVRJS0pDdXBRSDhrWTlVWDVYSS9RRmNWazU1dkxG?=
 =?utf-8?B?aTVmNUt4blpIcjBLdjRJTjRPcC9PZ3Z5MzJsQkhxNWZtc21PQlZ0Skt0bFZa?=
 =?utf-8?B?UFFEZzArY2NNbTZSS3VyQWduL3ZuL0J4Tm9Fck4reXlzTElWS09tWU85Ym5X?=
 =?utf-8?B?cTRocGpsQmZHeVlvNnFadEE0dk1ZSzVLREpqK0c1VTBIY285dFB6Z3FVSDIw?=
 =?utf-8?B?MEM0Nk43Y1dZcngxY2huakFnOUFtNWUxWWFxUXBETG9zTTl4dG8rOFJRbW12?=
 =?utf-8?B?Y1hDZWtKN2lYZFBIMmdEd0Q4WXhjWDFKU2dnRUJVcUk5NlZZclU0cmhtc3hM?=
 =?utf-8?B?TWdtWUJkVzhrRnhObGR3NnJGUDRldG0rdVhyMFR1Y1N4UHlOZTQyaG9YOHA5?=
 =?utf-8?B?Z1FEcTAwZm9MVXprQm9WMVJ4ay9aS0ZKWVhOUkZvQ0RkTDJhVFZqaENNNDc2?=
 =?utf-8?B?L3VhK1BNbzI0LzV0ait6TG83TDV1TVgvWFRheWZkM3BienBCZlNFVzZlRjhh?=
 =?utf-8?B?bkIrZHJkcnNLZWs4bFZUZHB5Tk16VW5oVmRwdStJSEVmZ0pOa2c0MHJEbWZF?=
 =?utf-8?B?TEg2T2d0dkltWGRyenFhUlVDekowMnpHb1hYbFIyUCtsZGNaQkpWenZKeDFs?=
 =?utf-8?B?czVYZUR0WEh2SW9EQjROdU4wTTY3YlpYeEtscFhLQ0xoNEFHeEVTMmhTV3ZY?=
 =?utf-8?B?dWlnY210M0lvWWxTbmJZMVU0VXZjdUZOVklCUEJSVWUxM0FINWl0aGxYRlRi?=
 =?utf-8?B?NjdRejh4RGVpVzUvR0FYemcxNXdnUU9hNGsyNmQrUXliUDBZaTUrUVdXckVs?=
 =?utf-8?B?eFdwUm1mNUhoeXFIMUF5ZG1oWW9HSWlrcm9ZNlpGMTJRem9lUXRXeXhBUFFT?=
 =?utf-8?B?R0tSdXQyN2Q5SVZWRlVsajIzRWVmZy9nd2x4cVpra2tQSERYMW4wWU1ZMzht?=
 =?utf-8?B?YTI4YTNtclZrQUo5S2l5MzFyUVlQdFEvOThWMGJ4clU5Y2dQeE1ueHk0am9Y?=
 =?utf-8?B?ZXg4STdTSWZqencyZldWckg2Q1pFanV3eVlqV2M3MlV6SkZpMFJiaEs1bGlo?=
 =?utf-8?B?cFVXZEViUlhyaXErU0tUUm94b0d3UERyMGxwZkliSWRxUURwcjRnK0REa3dK?=
 =?utf-8?B?WllScTJFS1dJN0luMDdpM2g2d3NBeTU3VnE3NSsvWHhZbzZjQWMxUEpHUlhj?=
 =?utf-8?B?ckRocjZuNUU5VEhmblU3S1lJanpuSG9xLzVUN0pGalVzSHNFeXQxT2pZak5Y?=
 =?utf-8?B?c00xT1ZRRVJoRG9QcWtOVkUxZURacExTcXowQXdKRmIvT01rWjB0eHZ2OFhR?=
 =?utf-8?B?RWRaNWNmV080ZGFUK3dBOEJIWlBxOFZrY09EdkhxbDJPNS8xQWRWMVlSekgw?=
 =?utf-8?B?elhYLzEwMDNyN3BPUnZoSlMvU2szaENudEZlc3Z5T3E2ZXA2VFZucEp0ZE4r?=
 =?utf-8?B?QTVwTEhGRlBpMDE1N1dTM0N6VDd6R2dxTnRsaTFWSnJjN1M0T29ydEl6Zmth?=
 =?utf-8?B?d2RtUGx3aXNla0VKbzZHdzZndFl4MUFaL055OURpR21TbENOMXZNZGQ0TWNr?=
 =?utf-8?B?Zk52OHpaNWZjUlRXbm81MDVBM21IQ084ejVaMUE0UGRKQTJRb1ZsZHI0bmhH?=
 =?utf-8?B?dm02U0IwVi9wTkJyK05abExQWDY5N1ZRZVVPUlJjaEwrakh2cHo3UlFxcFN5?=
 =?utf-8?B?eHFNbXJFeGFUQS9jTmRVT0dLUVpDSlFITEFoSG9TK0hlT2t5dUZjR1VEQndP?=
 =?utf-8?B?VDlXZjJhb3hlOG96S09zdDFsUWQwbmdzdktEYlgrSHc1QW5LbXpHTzhHNjZp?=
 =?utf-8?Q?s6tJv8iNIXKeBWLALtLAEj4/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8119dc75-8e6f-4820-f638-08dc65470f73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 16:45:05.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcIYVy+eFTejDBVSvUgFSseVH9a02PLZO6tJqV1xO98zB+d7VllaC6GZean68G1kAidL2oiVLMTSHQsH3GCcoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

 >It sounds to me like you need to go back up, to the 10000ft view and
>> explain how exactly this efi_mem_reserve() causes trouble for the
>> kexec-ed kernel so that we can think of a proper solution, not some
>> random hackery.
>
> The above details explain why and how efi_arch_mem_reserve() causes 
> trouble for the (nested) kexec-ed kernel, additionally, there is a 
> another reason to skip efi_arch_mem_reserve() altogether for the kexec 
> case, as for kexec use case we need to use the EFI memmap passed from 
> the 1st kernel via setup_data and probably need to avoid any 
> additional EFI memory map additions/updates.
>
> Therefore, the first revision of this patch had the following code to 
> skip efi_arch_mem_reserve():
>
> void __init efi_arch_mem_reserve(..) {
>
> + if (efi_setup) + return;
>
> But then based on upstream review/feedback, the second revision of 
> this patch, updated the patch to check the md attribute of the EFI 
> memory descriptor instead of checking for efi_setup for detecting if 
> running under kexec kernel and the checking of the md attribute of the 
> EFI memory descriptor introduces these additional checks and pr_err() 
> which you commented on above.
>
> Hopefully, the above detailed explanation captures the reason to skip 
> efi_arch_mem_reserve() in case of (SNP) guest kexec, looking forward 
> to your comments/feedback on the same for me to rework this patch 
> (especially the commit message) and post it again.

<snip>

I am actually going to rename this patch to something more appropriate like:

Fix EFI memory map corruption during SNP guest kexec

And in the patch itself, go back to skipping efi_arch_mem_reserve() by 
checking efi_setup to check for running under kexec kernel similar to 
how it used by efi_enter_virtual_mode().

Thanks, Ashish


