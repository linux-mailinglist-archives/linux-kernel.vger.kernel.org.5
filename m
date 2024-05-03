Return-Path: <linux-kernel+bounces-167501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A98BAA7D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960731C21AA5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE914F9F9;
	Fri,  3 May 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1uwP2q5R"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6814F114;
	Fri,  3 May 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730836; cv=fail; b=bk/F6efLHAGJLS8HJoCoqlyXvSIaA4fQ3EDOUr209yOyMISzxkxi0R8i/ivfupeqYYAb4FxgILIvgqjSBq6DxwlU2QjiU66KOrzOru/70xkjMlCuFjmFRPUQ8QK0dzWD0HMQMSKJlxkYTqhSE0X9t9FLya+yajiV5ykJwROhmgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730836; c=relaxed/simple;
	bh=8YDE3TY6Af90RO+SVb2FTghOr+5kQwjPVRgmP/5D0T8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Odi/1bvN8pdvbM4VE3AK36W8pPHc5HzmxOYzT5rGNTi+X6dKbn1BCu/BKc+8mXqH+2774/cChJZ/UFNmRp/taJk0lGgpAo4Lo3G6qG0bQ+9bAEzwK98uIVWLkFby9zMSSLL+HOKNQ7n/zoziX3BtvL/OMeYumSXhF+70XHKI1XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1uwP2q5R; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlzgkY5pzwSBX25hwAiYGzd31sQB9FQyBsv0Pzhd05CN3VyFHO0NRY3Z+GJnN0lG/r4ynGiWSlZZ+g1pyjjqyZd9YdKj/HOFaVg1DHpbr0/kuKf2TI8FmcL0VEjmviG48KDn8r2EXsW+E90teTezraXF7ylQk0GZCYLSo3NteezaO+K8JjfjBEOsjzdJ94cJocSysSqYFPrJZ8fIdAvlmnELS8UDF9z8RgIxE/Yq3OP5ylPqvi7RHj+beeSOW19Kks9Jz0u7QVK7yhD7s2vnEBNBVczUMbHoaBnybP3vhL1lPQSfIkDXOUlXGbQZoKl1OA9iQ0YLpyuoU1wbG7dF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U69VzoapZSsDLsDaLChWAqtggE/r9o8hVWHwp4TX0O4=;
 b=KXmubTDfjRLELFxP5ZoUm8hVNMrZe6H+K41VzDy33i3/YJQWA0WH0YZqEYUf/VKoC37Viq+5E0E/Aq3XbCFhfSY4cfflerPOZUaLvLBEzioeEtuduorW1vEF6KAiZU50CwU/jO4QZt6HEKZGEVIsEa8lSQWHSoomenBYw5uBsnRg4M6GoBWKZShq/zGar3UamIO8oNuguHoBtZOV1enoqL2BOJD/+Tycc9pLxyZM0yGJnKB0V0Y5tGz5iN42gr+C6WGj1lI5+4xl5yxVlptLprhBJljeIrmYZxWmXT5Os4UGIaptASyuonBut2TDlgFyzYe09GwMi1/j7zqR7jaLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U69VzoapZSsDLsDaLChWAqtggE/r9o8hVWHwp4TX0O4=;
 b=1uwP2q5RZliAeuZF7MLo03nBkOa60P3grSSlvnpumXU/8omLPdEjqdKOY7VTpGDV0ykIhzzJ61bpCraH0vfzGycQBNbVYb2+LPWMF6YT24AhcBb/1axzzoHS7k/wCf0LQYK8mVuk70YHTzLlKccfbjaRZ6U8ZvcBeIM5JB8GlmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.33; Fri, 3 May
 2024 10:07:12 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 10:07:12 +0000
Message-ID: <32b1b0e0-133f-4000-b4ab-9babaa2ae035@amd.com>
Date: Fri, 3 May 2024 15:37:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
 ananth.narayan@amd.com, gautham.shenoy@amd.com,
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, sandipan.das@amd.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 gustavoars@kernel.org, kprateek.nayak@amd.com, ravi.bangoria@amd.com
References: <20240502095115.177713-1-Dhananjay.Ugwekar@amd.com>
 <20240502095115.177713-3-Dhananjay.Ugwekar@amd.com>
 <ZjS0Uio+nvZLLmyb@gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <ZjS0Uio+nvZLLmyb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba15695-8298-459f-7fb8-08dc6b58cce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WThnMldxMnA0U3Y5V3NPTHN2aisyTDBnTnprTVRna0pjVXhFdkhpN0xlSGVF?=
 =?utf-8?B?dWZSMUxQS2x4cXR0aitabzFaWHVQQmc5UlN6eVJDU2s1Sjg1UHlPWWxLVlVU?=
 =?utf-8?B?OXNWMnF3RW5EZytZcTRZcGRvd2JKNkZqdVIxbEQvTGZWRUJ0MW5qdDVrTDdk?=
 =?utf-8?B?bGY3Sk45b1FCQnA0dDU1b0RwZWNlTTFOMEJORzBvbFpYMXkrdkFhVXo4L2Fu?=
 =?utf-8?B?cDJ4aFdudFo5RkFOVFQvcHpIRlpWNDEwZkhXckdRVnFpVytJTjN1b1hHdGcy?=
 =?utf-8?B?MzBkOVQ0YzJoamZDY1ZaVUJOa3ZPWGtHRUlybFZzbzhheG1SNHo1VTEvbjZy?=
 =?utf-8?B?QXg3T3NwZWpaRjlDcjN0V1M4ZjkwMkNEZ3U4TVhaK2ZON2drbHF0WHVEejM3?=
 =?utf-8?B?NnVDbnlmWXRFVWxUZ2FWTU53Ynp5QUpYdXFxSmJvdWhSUkpNL0ZoL2JuUWd3?=
 =?utf-8?B?bldPNmJwR1drTWptMDRmSmFJNUhyMXNOL2QvanNkVTB4bmluUzJBWXFVRU9Y?=
 =?utf-8?B?Mm9EUFM4eUZUeUFKaUljMkxjNEhSRmRhVG1yeTJYU0dDamg2RWpZd2J1VkdB?=
 =?utf-8?B?MXBDRGhRY1p2UU5kWVBPZjVuVHNMeENzZHJmTHFkOWYxa3dtbkdoaVF2UVNL?=
 =?utf-8?B?eDVmUDB5VEp5WE5YNkNqazNBeHZEK0JsYkhVdGJoalgyRzFnL2NaamRscW8z?=
 =?utf-8?B?QW1lQUFsSldJY1cvZXEvczVJRkxFeHowUGpkbFhZbGRhRkhYWmN0SEJuY1c5?=
 =?utf-8?B?bmM0NjUzQW5rMk4ySGxnZk1jaHlLbVdTeWFENEZseTNicXRRdGZhMzhSZ0xD?=
 =?utf-8?B?MEV6b2dBSUJ6M0QxVllNQWhFYU11TmxFQkxlSjczdFpxZCtDMmRPYTFKWUhD?=
 =?utf-8?B?NXVWTWRocjM2eUdZRnNWcjl1eGNKVzVJOUs1R1lQWFhpMGRDa0h3UUxoRGZP?=
 =?utf-8?B?bkpkSVl5VnFGdGVNa0dsbGxHcTlsUlB0QUNjQk9hWERSY1ZJcldHRWptWUE1?=
 =?utf-8?B?WEgxZnkwZnNZc1h6bGdTUEhCdVkyOTAvVFN2b3BxNXhPNXZPOUlzRUtVamRG?=
 =?utf-8?B?S3orTEFRNmpIRnprTzlmWS91bGxhRXgwTU9CcVp6Skh0RXN2bEV2WmhYblFU?=
 =?utf-8?B?VWliWHlhOGwrVGRpRmhidHNGVXYxYld4TnpwbHNkWHdUTDRCYWlBK2I4cWRP?=
 =?utf-8?B?RWpPeDhYRjJrbjJsQzE4NkJNWnlMaDNqTkNFNnZsWDdnL0dyaVVZQkhrdU1h?=
 =?utf-8?B?RG9rSHhzMGpyQjBsbERIMzBYK0lHOE1VcisyQTVUZVM2QlBMcFIwZWxwUjdw?=
 =?utf-8?B?V2tnWTZ6SDBnRE9yK09MOVVaM3VpTkRzdVVwemY5TUttdjltOUxpRzVHVitU?=
 =?utf-8?B?bERlbWRKd2llcCsrQjVONHRsM2w5ZzBwMFBDd3hZSVlzVndWWSt0T2YvQ3hj?=
 =?utf-8?B?UnJ0bzhnVEVERHpVb3ZPS1hhSkRVa0FrZUsxWGZTY1NkL1ZCRzRELzVIS2pX?=
 =?utf-8?B?anlIQlYwTzlXbkM3WThNazhLK3RVVm9zaHBTMUU4MXRsVlFLWlRBa2FISHNM?=
 =?utf-8?B?Rjd1cElxQnNua0ZycjNTS1RacnYxRDFhVzlFRlpsaERNMzJ1dENleGNDamxr?=
 =?utf-8?Q?jGFOLRH5JdGAcsw8d0QG+EVqMNaNRYNr7g8GSklaDeQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzdDZ3QyTmJ1S1VHY1g5d1ZoZTBUYmVzbHhaQ3F2NjYvZnhaeWQ1Zi9iUlY5?=
 =?utf-8?B?a1dWOWN5QWt2VkNDemRkdmtuUkkwa0h2cElxR1BaY3R5eWN2NlhuRzBOM0lO?=
 =?utf-8?B?YUFpVWlCU0Iwekw2endTS3M4Y05NRmVJVXkyVHVSQUczKzd0WFZlVmJmVnN6?=
 =?utf-8?B?VW8venNTNE53MGgrMGROMmxRck9NRXRjSDVmZTBhUFJxcTRQS1E0M1FrRGE4?=
 =?utf-8?B?aE5wUC8rVExnRFpDSkV6S0ZDL1lkeG5weng1bnlZUkc2b1Zkd0pLVjRlb0p5?=
 =?utf-8?B?WWZQL0xwb0o0V1dDRnJiS1h0RzRVVW0rcVdGVnVyWk1CVUY0UE13MVhpcEVw?=
 =?utf-8?B?VXh2eEtldmhURUdDNVhWMm13QXpLRE5qU1JqaWtrM0lzN3lQd1VGSVJHQU9k?=
 =?utf-8?B?L281RU9OczUyUStaQ0d1cnVONDdESGx0NlBZb1VHSm80UGFMeTRNUENiakNq?=
 =?utf-8?B?ODJ5YXpTME5ONmh1amVJdzczTmtoTXJzdFR5Tko5VTZuYTYyTGhrWWJpMlBh?=
 =?utf-8?B?VEhNRkd6eHdrQXRIRVoxaldxanBMWGJTT25KUExXTFFIMU1KUUV3ckVkeVVu?=
 =?utf-8?B?REVRSVZRUnVyc0pkOHVYSWQ1Y1NvbHQvTEVyTFNCSXRick1jaEcwb01oc2E0?=
 =?utf-8?B?bWx4YmVleUN4eVBEdnhTOXl2YTFkdXRUT3NsWEhscllyVWJvYmZHcTNEajRH?=
 =?utf-8?B?YVNsZE80Y2pBNGovV0d2Wk16MEptcjFPall3eFhHUjVKUlg3WjB6QXkvM1Zi?=
 =?utf-8?B?S3o1QWRwdFJDOWowL3hLV21GNStEL2xJWGQxQ1I5ejZWdHcyamJ5ZC9wcC9P?=
 =?utf-8?B?dVZSWDd3NTVwOHI0LzZYTnpWZlAya2ZFdk9XS0VMYWVwZjMzb3dyQUpzYzZC?=
 =?utf-8?B?d1VIV1ZJeStjMU9RUW5UdXJhdzFwU2N3dDcrbS8wOW5kdEdLTGZkQkhlckVD?=
 =?utf-8?B?NE81TDQ2YmZHbHJWcDU2Nk1YenI4bDhNbloyK2hGTHJTZlg1b2VLekpSYms3?=
 =?utf-8?B?czNLVkZvc250SmRYQkU2M2pEZ2Y2TTEwckZ4YzdtSmNsc1JxV3l5bURqSVAw?=
 =?utf-8?B?aStLNlRUbGp1ckF5UUl5VVZpdjQ4V2xaanVyTEJ1U0xpTnloOTAwV2ZaYlRI?=
 =?utf-8?B?ZUV1ZjJZMExsejY4cDY3dFh0cTU5bmVCdG0rVm9pWVg5VHUvM3RjWTg5ckl4?=
 =?utf-8?B?d1p5MFlNSCtGMXdoeFVTcjJRTGVnMm9VVW9mYWRsTnN6dUJYLzZqTkhjUnNY?=
 =?utf-8?B?RGhIN3ZUMXpBejhweEdJTU9POXlmOUtnVi9ROG9WQXIreDZIN01pNzg1Q3JR?=
 =?utf-8?B?SThBWEJYbTVMdlFVN1lqOVpkRE05SFUvSEFJQVJCbTQ0TGdkMnNGWWdpcHZx?=
 =?utf-8?B?RXliamU4azkzZDZ1VUJIb1pQdXl1N09IYzBENmp5T1pkcWhTWEk5SDM4M3hY?=
 =?utf-8?B?SzNqQldhR0lkRkIwLzVKR2VTK3NjMHF0dmw0RUtoOWdnbDUzT3hadENGa2ZW?=
 =?utf-8?B?Tm9sL3RkTWVwZ3JWc1ZzRXlzaFhDZU5sVmh0bkFSUkhIMjZZaUozL2ppNVpm?=
 =?utf-8?B?VXQ0c2lkaGdaWmFVTmJVNytvTE5Cb00yb3p2bnR6MGlyTHhnNUg3aDZ3ZWpl?=
 =?utf-8?B?cXJsaFpxQjFNUXlDZEdkZ1hHbjhQQ1NtaUZZcFJUbGd1Z0ZRTUpHUndKT0FY?=
 =?utf-8?B?MW1Rei9CMHVvbjA3V1g4WHkrbUUxbi8rY2MrQXcrWjhvd1kwdEJwREFEay9p?=
 =?utf-8?B?NjdTTWtGMXVNOHdMdy8rQ2Z2Y0J1aVA4Ky9YemZIandHeHRtRjZma3ZRUzY3?=
 =?utf-8?B?VWpHSEROOFB6Y1lvNVNBblptbnVMU0RXRnREOG1IQ04vTFB5b3l3OEQ3Z1Rm?=
 =?utf-8?B?ZkZOY1N2blFaTjVMNENRUUFEQ1lGU21XL040bUFFMGVWRExpN0prZFFSRFZO?=
 =?utf-8?B?WGpNR1VmbURmMGJyMDlqUFYreGJ5Y25nYUtkMlZqbHFpNlVSakJ0WjlBWEpV?=
 =?utf-8?B?WW9NWVBZeXhXTHU5R21aM1R1TEhXVTk1eG5JdDVKWS9jM0ZwS0pkVjBUYWdF?=
 =?utf-8?B?aTYwMlpGRUszZjBJVzNNQ1ozTzZiZGZmdjhLNnJ6T084WHZyZnlna1pGVjJk?=
 =?utf-8?Q?2cGWPchvXiZ5MveT0hl1JdoNx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba15695-8298-459f-7fb8-08dc6b58cce4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 10:07:12.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKwd1s8xBdMD5wT68ioLd2Dojm3xJkxwiZlieGQL7/Wu/z2t4QHUbZ3UkQ6mVlnGfcKlJadvxlnVkIOGOhKkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

Hi Ingo,

On 5/3/2024 3:24 PM, Ingo Molnar wrote:
> 
> * Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com> wrote:
> 
>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
>> on AMD processors that support extended CPUID leaf 0x80000026, the
>> topology_die_cpumask() and topology_logical_die_id() macros, no longer 
>> return the package cpumask and package id, instead they return the CCD 
>> (Core Complex Die) mask and id respectively. This leads to the energy-pkg 
>> event scope to be modified to CCD instead of package.
>>
>> Replacing these macros with their package counterparts fixes the
>> energy-pkg event for AMD CPUs.
>>
>> However due to the difference between the scope of energy-pkg event for 
>> Intel and AMD CPUs, we have to replace these macros conditionally only for
>> AMD CPUs.
>>
>> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
>>
>> Before:
>> $ cat /sys/devices/power/cpumask
>> 0,8,16,24,32,40,48,56,64,72,80,88.
>>
>> The expected cpumask here is supposed to be just "0", as it is a package 
>> scope event, only one CPU will be collecting the event for all the CPUs in 
>> the package.
>>
>> After:
>> $ cat /sys/devices/power/cpumask
>> 0
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
>> ---
>>  arch/x86/events/rapl.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index 46e673585560..d77bf7959a43 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -102,6 +102,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>>  	.event_str	= str,							\
>>  };
>>  
>> +#define rapl_pmu_is_pkg_scope()				\
>> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
>> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +
>>  struct rapl_pmu {
>>  	raw_spinlock_t		lock;
>>  	int			n_active;
>> @@ -139,9 +143,21 @@ static unsigned int rapl_cntr_mask;
>>  static u64 rapl_timer_ms;
>>  static struct perf_msr *rapl_msrs;
>>  
>> +static inline unsigned int get_rapl_pmu_idx(int cpu)
>> +{
>> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>> +					 topology_logical_die_id(cpu);
>> +}
>> +
>> +static inline cpumask_t *get_rapl_pmu_cpumask(int cpu)
>> +{
>> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
>> +					 topology_die_cpumask(cpu);
>> +}
> 
> Note that this breaks the build with this config:
> 
>   https://download.01.org/0day-ci/archive/20240503/202405030828.RgFuznL9-lkp@intel.com/config
> 
> I've removed the commit from perf/core for now.

Sure, will fix this in v2.

Regards,
Dhananjay

> 
> Thanks,
> 
> 	Ingo

