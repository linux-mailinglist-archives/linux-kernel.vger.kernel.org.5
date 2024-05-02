Return-Path: <linux-kernel+bounces-166826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89538BA01A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFB2875DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325EB172BC1;
	Thu,  2 May 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FzhKlvIO"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337216FF2B;
	Thu,  2 May 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673510; cv=fail; b=ZhlbSR2VcrQG3rYdo8O/bPb8zDUV9CBpTmEn6Q9U8eXam8uRGU+3xpVBuALN+bsazZ2ctaOTSRh5fLjGbv2czzgI/6CwKxEarEGZ6INZEIvBK14BD72fjvfkY6qgPToUTWPlYVTCqkSn+Py2ZewhFA1SarKaA5rPKCQJwqfxGZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673510; c=relaxed/simple;
	bh=zhjEAQbhF1EmQlyiLIZDdyZMaESj2qC/tlmoVIHRqeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YbuSZ1KiyahaTiJrZwM5My1B2EbftwL93/J1/SHXJA77oXUYklBzx2NSK4IbWzkqz8PrfSbxibgA+0VqOub93pxR0CBk8tN9SzayfjJH2Ajcx6XsrzjN0YlrZ7wWp8Ws3GGq9/CvKe0RRoeIWY92H+25qvfvo6Z0LQ5C5xrT1/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FzhKlvIO; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxUzJq4PFhkwz3W/OkHbBxRgo129HNYt7jT1mR8kvQhDEfqqQOMdpdVlvhpXpBnYnH3tt5SgT6ZbWmTywEtmm6nY8iz5mgfRMDlt1WNTsg2WKS0VqhzO/+bSkyq6mFH1O4DplAQQeVeX/PW8UKtXcuDgyexnzxaeJG9j/xw8TuNqbk/AaXv05puD4iUvlm7k3bg7L+Z8xVH1hEQ2TJFXtinckTPlzYZSgJmz3nzFZiUVAVsGaGE8cICKbJblvOP/zF0L1x3Kn6fYtNpnXUZ8NDQIKMbeI82UAFxdICB8h+BU+1fHTZoJp/r78GDE4TrKd7YqiQdKRBQgKDiCWT4/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jwuI3aNniJvVF0z+xUk0GIU0bhtJbdgFgqTWK24cPk=;
 b=K6bz72r5BcmBc/85h23wG8vw2TPPciKuviVKfV7oWI3k2fuFk2pyrv9NB6fRbJJVPW/ngrUokPl9WBtnVqXePSwjNv27WYsKZU6lq8qgBYQLusM+1SqmwvX6EoJp/k+lPuN2tmOheEIAj/QwBTQG1QJiCMT+Wo9liKs+G6Zx93bB/lqFPxag98J3bRCtxBdVVRB/+9DTy1L4UyvNCLJ0+dSUWMyJ9yKx2ZYk9BfCL9o7Kb5VlYL88PktJcSzJ13rzeZz1WST5JSteUpCyUdzGjNn+p8QRt+zlNFt99jY0uniHDR+/lZoC04yWvIygZmwgSJzuXVjwLhutzMTHcg/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jwuI3aNniJvVF0z+xUk0GIU0bhtJbdgFgqTWK24cPk=;
 b=FzhKlvIOb4C8xH30D1mEKZya33y7AukaLBngPSJU4QC3Jok0Ml8xUEF8QDU/azC6HvVh+aQ6KZ5Pp+ybDRgwgdfjwVkQm/6jabrNOaov+JGmCSHBmX8VFH9Y6Kbd3iDQ9LbEw7ypYX02uQM6tX4Yqvypdkc4C+dMThNusxv6QTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 18:11:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 18:11:37 +0000
Message-ID: <30f2fb65-10ed-4d60-aadf-6727f7a6e404@amd.com>
Date: Thu, 2 May 2024 13:11:32 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <ZjO9hpuLz/jJYqvT@e133380.arm.com>
 <4875492c-13cd-4a77-a42f-243fe0f868a2@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4875492c-13cd-4a77-a42f-243fe0f868a2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:806:f2::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d08f2f8-3772-490c-f846-08dc6ad34eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE55bnFsN0dSUk82WDkwUWcrOStJcHAvOHdBTmJpblFXdkx5cERwMk5Vb2tP?=
 =?utf-8?B?QysvTm51T0lvSXRhdlhqNG9mdDFrZUkveFNaaE1VNlIyR3RsWmFTQUp0NzVs?=
 =?utf-8?B?RW9BQzMzcHdZWUF2MHhkZDFNSGM5Sk1yOWYycU9sK2hQa1gzYzRnU2NIdUly?=
 =?utf-8?B?cGpFbU1lN2hTMFNxVHRmeVpNRHVnMFFFVDFmOUlUS09jcUdnRVEwZ3FIeVJq?=
 =?utf-8?B?dGk3UWk5Vnl0OTdYazdmdy9EM1ZRenlRNGx0RGZFT1ZTMzd2dWZ3MmN3dkd0?=
 =?utf-8?B?U1ljdHpoOGtlU2IwdHhjRHpEZUFraWdPSWZEZHF2akw2eUc2djhwSjYwTXll?=
 =?utf-8?B?QmkwcitaOEVJb2ZNTUFxNWFBRk9sdXRKeldDWlpjM2RXODVsVVdMaFBnNlVi?=
 =?utf-8?B?MzkwZG5iZXpFOTJMaGt0Qmo2S0JveFg4Y0ptK2ZVS250MHdRZXFTSDdZcDlT?=
 =?utf-8?B?V0NRKzlSdTU3TXBaeXYrdUNIN0Z4KzlvbVRSdkZkQXlzeTNuSEppTGtHZlgz?=
 =?utf-8?B?VE5aYXh0QWFXMHpFU3phQ0ROaVRIeDEyRXJ4bWxGYXZBbFVzRVdvR01ZSGJp?=
 =?utf-8?B?cXNqUHdudk9ZZFMvVTVGb0xPMFBRbklEKzl5ODNuelVUR0k2K0RxZGF0UHhJ?=
 =?utf-8?B?aWRmSWVaZ1RHY0Z0K0RpV3Z2Z25qMGxpWFhVN2VRK3Y1VGVDZTVBYVljb2dj?=
 =?utf-8?B?cFZzNFdOZ0U3MmlSNjVsbWNnSGhiUllaVW5DL3M1K2xnNk5Zd0lnMmo2dmdy?=
 =?utf-8?B?c2YybUtkNTFmOGNITWc1SjhNNWZCdm94WEkyYTNlcFNMTFRyWE5aVmk0anhM?=
 =?utf-8?B?MlZYMXRJdllUaVF4OHZOSXVEVWpveE9ERXdJa2V2Q2RHOEVidEJFdVd1SDkx?=
 =?utf-8?B?WUZXSCtaYk1RVkkvNVpsMUFJcHMxa3FZemNZTVhoM0hlekcrMlUxM3Zobk9q?=
 =?utf-8?B?T1VQZ0JsNjNLdlhDS29Mdm5jbE03bXIzWnkyUU1TVDJFRDBabjhaa1FsZjU5?=
 =?utf-8?B?TzdNcEFCbytSZWlBQWFyRzUxSlc4dm5aekM4U2ZsYWlsM2d2bE8zcEh3bW9S?=
 =?utf-8?B?Ly9XclBZSHYvL0JQQTBHSmREN0hXaFlUK29ZWDQ3dXFwMiszS0hBOGJtbG5o?=
 =?utf-8?B?NE9vZmZmSE9MWE85TDkyOHhGLzlMS0RZbmdYRHNSQkNudlM3THpYQ3J5Z0xY?=
 =?utf-8?B?Y0JVdGo5RU9lTjd3ZmdYbEtYeDBuTXlWSldzUFJmdjhoRzNSbytnRVJQTFlx?=
 =?utf-8?B?anpzMU9NbHN6R3ZZMGwxeHBtSkVxZ29BbzBidGFncFZWZnpudExFcEdqdXZP?=
 =?utf-8?B?alJLdk5RVkZqZXI5RWMxdFlZcTJGYUh4NFpHcDRsMDVNUDNpaithbXdNNUlR?=
 =?utf-8?B?emJOT21JTDRwdXcvM3UrNnR0STlsKzh1N1lEOWZtdnY4dEZ4QzVhNDZUNnc5?=
 =?utf-8?B?RXplS2Z5TUVGS3R2dXMvbTIyejJqWjM5M2NzRzdUb3VGYXNWRms0OVhDUWYx?=
 =?utf-8?B?eVgzMDFFM1J2TFRQL2VBWEpYWTdHZ0RFVnJhOHNOZVkxeXYxMWhMNXJYbmxy?=
 =?utf-8?B?bFdTbmovVGNRcWtPeXlVenJIUW1ZZjNMQzFMblBqby8vNzNqWUJpWUdycnJQ?=
 =?utf-8?Q?E3/ZsIVie9bORks/vnM6RM55mDLYFq+8b2OH42k4Vk/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzZsR2IyK0ZROERnL2NNNzJMaTZjaUluVUNTem5qdzY3b294Y3lPMG1SRWFl?=
 =?utf-8?B?dkN1UE9CK21vQnpjVUlEQlpIeWlaT3IzaEk2czVndk5lQ0lJdW1DZWhhZ2ky?=
 =?utf-8?B?ZzhJNlM1STlkYkVkL0NvOFJnV2FxRlc5VHFnMHJlaTdUNm5IcUtoWWM0QXkx?=
 =?utf-8?B?elVoSkFxV3JEVXJyTnMxcUI5ZERweTE4QWJseVl0WXlwWUtGcldYK09EVUla?=
 =?utf-8?B?S2x4cEo3VnQzSWRST2NKQS9mUURPWk5mWS9lcXlsT1loeXVpTHF1S0JhL0Va?=
 =?utf-8?B?OERSaEppUXAzMXB4Qk9hamxqVmlRZnJuTUZtdHFVNzdNUUtPMzc0VXZuaUUv?=
 =?utf-8?B?M0tpeWNSM296NWNURzFLNlFUbzdwNlF2K205bkl4RzMweVNwMzNncEcwRTIy?=
 =?utf-8?B?RHZOMWRMNkFvQW5EZXZZRnM1dllKenFjZjNzUjZHaG95Ly9MaTBraVVSMThW?=
 =?utf-8?B?UVNQcWtIK05xRnpMT3NFYm5CcjlJUG5KQ3dxTmdLOVR2bE12OUVqcmg4NVdk?=
 =?utf-8?B?TGRkL3NTSkFSYXJUTERNcFR2UW5aNjloK1BGV0tvaVgxTVZFNHNWbFdPaGE1?=
 =?utf-8?B?ZE1FTXBQMGprUWJBMmFqanYwaDRuUEFldnlBTUwwenYrYWJLUUlpTVBPZVh3?=
 =?utf-8?B?UkZQOVhIMWNvQS84OEc1TnA0MjhaM3F6NkxkY25hclZZeEZIQUViYmF2WXg1?=
 =?utf-8?B?WE51MEVvaFdIQ1MwdWdheHBFWUlDV1Z2N1Q4UzVVa1ZoNXh3c3NjV2N2dzBM?=
 =?utf-8?B?QkltdlQ5SHFiZ0Z2ckVSSmZNaVpML1A4OGQ0NGFuRDl1RGlQWUE1RmhuL2xH?=
 =?utf-8?B?c25DbVlyb0x0TjVFZmVRbGxaaTdxU1ZtMXBTR2hqVjlXd1RZOENINFhRZSsy?=
 =?utf-8?B?UWpqRi91VTFYTWh3Tkw3c2xNeXp0SEZ2VlRkd0pyS0JVTXFmS0pnKzBMOTM5?=
 =?utf-8?B?NkxjemtLQ3BmR3R6d3MyWWZnTEw1aXJObnNaQ1N1M0l3RFBTdEQxdEN5REFr?=
 =?utf-8?B?L1BlV1A5ODFqVm5PMXRLa1N4TWhLakR5TFd6SjRtVm1wdWcxVWFJaUhyNVNk?=
 =?utf-8?B?eWpvcEdFMGZKZHFlTVNzaDI3Y2JWVmd4TzhKNnRNMFFTTGRjTDl6UVRVQXE1?=
 =?utf-8?B?VCtZRDBadGNWdXZsWmJ6dEFScTNyQWF2M2VpaGFrTERIdGlLdXVaSmVmQTBh?=
 =?utf-8?B?R3VITy9YazF2SUIzTm1LS0JISk8wMDh2U2JhWFRud0xHLzU5Q2haT1l4Rytn?=
 =?utf-8?B?cXhsNXJWdndUcTFwOUVVLzZWWnFGNUFKTC8wd2k0SVpnZ0NBWlJtN3BwMWl2?=
 =?utf-8?B?M0FndGM0b0s4RTN4U3VGT0tZbG1IV1c2VlFoNE1lRDc3NmZ5RENUSEl0aUZ4?=
 =?utf-8?B?VGVuamwvK3huMVExcTdnODdNd3M2U3c5Y1ZZd1hqbWRKWDlVa3NGbVJFS3k5?=
 =?utf-8?B?VUpOMXZxQk9TWE4xeUhXQ0N1MjE2bkRSZ3VQSXZxdkhFU2dmdHNhQ3c2UXhL?=
 =?utf-8?B?QnA4Sk9Jdkt4SzZOZnFLNld3eU1sdFhCUzQyRXdyZTJIWGcrWlZFbDNrZDhC?=
 =?utf-8?B?RFdiUTJtckZKaWs3UmZhNXVuTXVqTVdvL3hWMDE0bnR5aEtvU2p0NjlGRWVU?=
 =?utf-8?B?MWNaVU5IT3hHRGZSVmtESmJJYVJTRUplcEtFYytHZ3Z0dGxkdHJKYmNPL3FX?=
 =?utf-8?B?alhtZGZvT011ZFpNSWEvV0s3ZTRiaXl2MFdCQitUQUZ4TVExWXM0aGtSZ2VI?=
 =?utf-8?B?eW5zYmZvZmZ0M0VxNUlVZVd2WDFHYmRxNkRPSEE3RXJ2QnVyK2Z4bjBzQVY0?=
 =?utf-8?B?K2R4VTdYNkN1ZzkzOEppaWUrTGxhb1U1ZTFILzhVM2tEU1l3aGhRQUdSMnpH?=
 =?utf-8?B?UUF5WWdaTWJGVlJIQWtrNEZKZ05lNTR3UEE3NERheHJPejg4T3VDazltR1Fi?=
 =?utf-8?B?NGtKTXN1eU5xTEJ1UG1WRTdSUUJLUlJhZU1HbGk5bmRlQjUxUHdhZGZvem1W?=
 =?utf-8?B?MmtFQnpOVWMydi9nUGlZM29OSUVRQnZiUndkWi81MCtEdTVFTGppb0hHUmsx?=
 =?utf-8?B?Q1k4RWdRYVBwRWt3anlvN0dab21MWVpXMk1FT0VvNktXbU93MHo0V1JEVXRI?=
 =?utf-8?Q?0J7w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d08f2f8-3772-490c-f846-08dc6ad34eb8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 18:11:37.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Fg8lrPbbeS7hDT3qJNNQq8bXNck4Im6MHscfnT7l7DM8vgFq9O1bLYpjCromn2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

Hi Dave,


On 5/2/24 12:52, Reinette Chatre wrote:
> Hi Dave,
> 
> On 5/2/2024 9:21 AM, Dave Martin wrote:
>> On Thu, Mar 28, 2024 at 08:06:50PM -0500, Babu Moger wrote:
>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>> index 2d96565501ab..64ec70637c66 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -328,6 +328,77 @@ with the following files:
>>>  	 None of events are assigned on this mon group. This is a child
>>>  	 monitor group of the non default control mon group.
>>>  
>>> +	Assignment state can be updated by writing to this interface.
>>> +
>>> +	NOTE: Assignment on one domain applied on all the domains. User can
>>> +	pass one valid domain and assignment will be updated on all the
>>> +	available domains.
>>> +
>>> +	Format is similar to the list format with addition of op-code for the
>>> +	assignment operation.
>>> +
>>> +        * Default CTRL_MON group:
>>> +                "//<domain_id><op-code><assignment_flags>"
>>> +
>>> +        * Non-default CTRL_MON group:
>>> +                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
>>> +
>>> +        * Child MON group of default CTRL_MON group:
>>> +                "/<MON group>/<domain_id><op-code><assignment_flags>"
>>> +
>>> +        * Child MON group of non-default CTRL_MON group:
>>> +                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
>>
>> The final bullet seems to cover everything, if we allow <CTRL_MON group>
>> and <MON group> to be independently empty strings to indicate the
>> default control and/or monitoring group respectively.
>>
>> Would that be simpler than treating this as four separate cases?

That is correct. I will add a generic format before this description and
then add these 4 cases. That way it will be more clear.


>>
>> Also, will this go wrong if someone creates a resctrl group with '\n'
>> (i.e., a newline character) in the name?
> 
> There is a check for this in rdtgroup_mkdir().
> 
>>
>>> +
>>> +	Op-code can be one of the following:
>>> +	::
>>> +
>>> +	 = Update the assignment to match the flags
>>> +	 + Assign a new state
>>> +	 - Unassign a new state
>>> +	 _ Unassign all the states
>>
>> I can't remember whether I already asked this, but is "_" really
>> needed here?
> 
> Asked twice:
> https://lore.kernel.org/lkml/ZiaRXrmDDjc194JI@e133380.arm.com/
> https://lore.kernel.org/lkml/ZiervIprcwoApAqw@e133380.arm.com/
> 
> Answered:
> https://lore.kernel.org/lkml/4cd220cc-2e8e-4193-b01a-d3cd798c7118@amd.com/
> 
> You seemed ok with answer then:
> https://lore.kernel.org/lkml/ZiffF93HM8bE3qo7@e133380.arm.com/
> 
>>
>> Wouldn't it be the case that
>>
>> 	//*_
>>
>> would mean just the same thing as
>>
>> 	//*=_
>>
>> ...?  (assuming the "*" = "all domains" convention already discussed)
>>
>> Maybe I'm missing something here.
> 
> I believe have an explicit operator ("+", "=", or "-") simplifies
> parsing while providing an interface consistent with what users are already
> used to.
> 
> Reinette

-- 
Thanks
Babu Moger

