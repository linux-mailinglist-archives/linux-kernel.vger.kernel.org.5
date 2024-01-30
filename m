Return-Path: <linux-kernel+bounces-45238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072AF842D78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7179D1F24F61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5371B35;
	Tue, 30 Jan 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZAtX6/sa"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE371B2C;
	Tue, 30 Jan 2024 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644876; cv=fail; b=uo3BH0UY5Adp0kqdJNswLPsDJbUWou9igECltSZ1jyU3i8UKSf4aOztEVgwrQuvHvFxIsYoaD6Zy4X0tU+kxchW8V0bh83GmEDU6Nsq/XS6MOE95/kDRyFZQusgxAOrs4Ojgov431sPYCQ++jD+KoZVWxeqKXiLLQuM+r8ARA/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644876; c=relaxed/simple;
	bh=C4VS56FjZMKJ0m2rLseCPiU09MMdaUqh6jLqTVvgfRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k+6EYTMiDpF61o7/weFkUDS58DudjUl5WHk4buY1L478UhKkZ3m9pTVuqe3cYs8Y9s97Bn69VFEO7yA/emCELQWeM2Vufxodi5SFVWTq0V/grRT48w7UV0I12viRp61OWD1rPfbfTHIs3sOvfCQ59g7nRl4q2MzVVlv0d80CP50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZAtX6/sa; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTwDt9S9DLqJg344VoqVflQ5LlZSUTQpaEEL/m9j/zXSrUg3sr4YHr85rNFPKcyasq5qicln6EggVjUO2R6dTuR8hNI1woLkybLJam92Nm+8TW6B0uMSd/qJyN3c9wO5zStdaenQ9ioNdXoB5Rw9MS9gkgwIPqKfrUHF/QA883IUElTKRJuYc44cEdWidVPWBdhEeVPDEBEM3iJ7V7vVbkpHmB+2DV3pUDy9AEOjzdeDrILj9vuzAnH4hUtKIMOaJp+py1xdUV8HLdD23cqQp7bpNFS5jIoox2QbeoirUCLsPnI0GSK26zR9UZb9mnORmFP01326IootBJAIonEr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAoCU7PMqVMcAPmH8FmZK+6fpHGSeqMpjf3Gxri/33I=;
 b=gE5Zv97c63aP3MmTBg4xH8opux9+pSAeabXycCbLZsl0BSwWS8834U9rUu/sdoKVs11juyU4pG7KU7kBLQ6BA7Z+gfwo5GvLfu6PNQYDSLBbPtZFmTPlhgqzv+fxyR1snpNACqnB8OXglUCjEVAvG11KRX3HnkpB0j6V8af8agHjM1zlN2NQZ/7Z2FCb2QVV0DGJo0L5+PMb9/orRdH+l7TbKMWLF8Be2YDeBnyhm1Z88si6hAccqOlEmtYVjBHHcpvYizTqtwi5XB94xqEBIV2ojTZNAcKu5NYVYr/0bV6d0hbod10kEirqLdwclteHrrwgAKsy1Jgd7yzp8h1feA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAoCU7PMqVMcAPmH8FmZK+6fpHGSeqMpjf3Gxri/33I=;
 b=ZAtX6/saNaO8LwXa/+OE9oTcQbDGFUtSD7x6xXYwPt36HJ7PBAQdwSMQcNwrAwkcppHiRiX3vJsWzwJq1y7DJGcAPobVr+oRXz9fBCwkMGZ/s2DpKb8yywCjxSuemMxvlfcwqIL3lITVZqJsXaejev/SloBIgdQyNppA01CwQ+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 20:01:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 20:01:11 +0000
Message-ID: <e64d07e6-b38e-456c-8f56-4a6287de8e65@amd.com>
Date: Tue, 30 Jan 2024 14:01:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend 2/8] tools/power x86_energy_perf_policy: enable AMD
 pstate EPP profile switching on MSR based system
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 Borislav.Petkov@amd.com, viresh.kumar@linaro.org, Ray.Huang@amd.com,
 gautham.shenoy@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706592301.git.perry.yuan@amd.com>
 <ecd0310b117e6b68160de9c77517dfed2b8e530c.1706592301.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ecd0310b117e6b68160de9c77517dfed2b8e530c.1706592301.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 712fbe47-763b-477f-8084-08dc21ce34a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nj38K/h5SR3CyKSSPhCwZz9kHlSMtKiP9u9cfiyMJEjd/ajVphZkij1v/Ca9nVe8cqyMEn79PHrp6bfQrJG4wtxs039VI2FycZTRl7vCDKtYGyXF9EjWEgzO/yDu8TgQbdME00U3qxGugnrxFtS+UQAIPkXU0qKCRUCLdW1Nkqmr8ylpH2a5JZXMa40iGdSqgLapr1sqlTM5ZFFIkfd8jh6p4Al0olbiiuQs+d6f/icSpypLO2w9D8iHV6/mJu9QZkAi/P7qdJYOxW2UEY6xwdR783KDEUqIuRN1yTwdjALFgK8NKwy/VuaRhD4vfVLpLjZqGVv9CErfwICAlI63ZJgNwX4MeGZksxr/TOVEIACVuqwuXRcw0QNvDIWh97Sbb1YjNkTze+RAfVAqSCSoBU/F+4QqdOSQa314GZNOzRnlTnm6yqK13mb8QF6WPXVD3szlNZrKD+a3RsjqNVOUw3J3rUIpZ40gRVP/tPKgJpB1UYW+1C9xnvd+NVhIE7NNZ7SZ1FkLM/ECVm87/46JhjPHvBXaMSPvzKaI33rHZ3j5NZlcSwvBGi3Vqzzg1+Uq/A+REI//VqFKk2p6KHpocDLv7j1MkvOt5AwTLgPjIbUReuFzMzAWEbUsRSDQJs9LO0QK+n2Lo/a4MCZPDOjFkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(31696002)(478600001)(31686004)(66946007)(2616005)(6486002)(53546011)(6512007)(6506007)(44832011)(86362001)(38100700002)(5660300002)(2906002)(8676002)(4326008)(66476007)(66556008)(316002)(8936002)(6636002)(26005)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXMwbjBVcHFYMXE2T1B4RGtPTjcvWEhDQ1cvWjQ2ckY0TElWa25qV0hBR3Qx?=
 =?utf-8?B?MitiNlpaa0grc2hPZ1NRWmVYUVZmN25meUZNZnExbGZGZ2x6U0VWdEVHZkFK?=
 =?utf-8?B?Y2QzcWFibGFTeFE0WkUzeldIS3NwWlkyNkJGMWJ1em4wMmZmTUxuVUhUQTI3?=
 =?utf-8?B?YWU0MUF0Q0g0SDdKUkNlOCtmaHdNWTk5N3V5NmkzZ0NLVmdqY1MwQ1B0aHM3?=
 =?utf-8?B?SlYvajZEdzVQRFpqNDFYbnI1V0RjQUNmRENZRmI5dVg5TFB0Tk1kNytjNUdS?=
 =?utf-8?B?a3FKTTF5TG1yWkJPVXk2Vklha09KdnlXU2hldStaK0VSQXRYWEJQMytTaGxN?=
 =?utf-8?B?cUpVc2thaUVzYnp4SUI4d3R2N3lSWnFwYW80bXMrOXJiT2JESkxUS0VOajR2?=
 =?utf-8?B?ajJqeDdKMVZ4Y2xwTjV4dktTVXBaalpDSkZlNVlHRlBrWXUyWVoxaUQ4VDVu?=
 =?utf-8?B?L2UrN2dIT2NIbDg4U211YVRzT2FnOE1tdkxPYmFwcDJ2TEVHcW1HYmdvcmE5?=
 =?utf-8?B?K0dJQWp0dE1FN2RaVUlqV3AwNVRwWXVyZmVzU3hVem1Ob2FOZ2JYYUg1cGdr?=
 =?utf-8?B?MWp6SFVROUNFQWdXY2NlUFNOV1doTXdVaXlkemk3eEJJNHpOU2xhRUk5Qkky?=
 =?utf-8?B?T1RjcCtDZDg2WTJ4SlBhdk5xb2RnL2I2VGtZaHNaWUVwSlFpcWdjcnRWbjFN?=
 =?utf-8?B?ZzJHVytNS1d0YUhvTHJNWDE5TnlJMUlpTm5lWTk1T0JPYnJ0MExjZGcxZkdk?=
 =?utf-8?B?S3dJRU9iVGIwVlpzUkdsd3dQSWVhUHlBVVBWNjRYZGZBSkhMa2tLS1RodEtk?=
 =?utf-8?B?UnNPdW5CSnFzdVlsN1Z1OCtTbTRLdEtOYTZBK0ZDaVllUE13MmpJNFdwYWtM?=
 =?utf-8?B?Q3RBNHV1RkZxTkhoNDZzeG11aEMwWXRJei82N1IzYTY3RHZtTWxGb3dPY2VN?=
 =?utf-8?B?cnBRNjF0cGF3aDlzZzFXL2tWTGlWam9yRzdvaW5sdnBESTgyMkRubm90d0po?=
 =?utf-8?B?MXFvVlZIeVdBMythMlZBQVhzNkZvV2Zsa3hTUmF5QTYzS2tTSkt2Y2pEZ2Uv?=
 =?utf-8?B?Q2kvQ1ZQN3pSckZ5QnhpZGlMaVBNaFJnUXpsTGlYSENXWGtIcmFIcjdwUmxs?=
 =?utf-8?B?WlBIaUxYU1lxQ2VZMUlOdnZucXJuNFVTQUtQOVkxVFI0S3hCNnZoYVdDZGxx?=
 =?utf-8?B?dm8vM0cyOTVmUVpKM1BQRm9DYm5mSko2MnVheEZSR3Y5ZXUrQTlSWUdOUmRT?=
 =?utf-8?B?cXRqUGZmRmtPUkZjazNlNUdCd0JoS0RFQWJrQkFCcmtSblg2bTlnN01CVWtD?=
 =?utf-8?B?NFJqQkxQMmcrSkZ6VmZPbzE0SUJCZTlnZVJveEtpRFB2aFpvU0VZOG1DZmZj?=
 =?utf-8?B?Z09KS0pyL1JNOWhGQVBpTnhGMFJpOHJFS0hxeVg2c29nY0oyUjJNL3VndnlY?=
 =?utf-8?B?cUUrZHBTMFZ2VWhUbXdLcS9KbGwycDZJdEJPbUFUMW5haUVwNFZlUUhuOE1C?=
 =?utf-8?B?L0xRbmc2bFJUcndMRGI5cXhsa3lycFdpcU1kaHdwSXBZcnp2TDlRMGdobkFQ?=
 =?utf-8?B?c0MzRU5KQzB3T3FycWpJOWZqdE9POUxkNUVQNEtxSHU1TVYwQUJYVmR3NW42?=
 =?utf-8?B?Y2I2c1BBbDhNVFJ6K2xDTjhrSXMyTm1USzlBQTlGd0tLQjlmRFVpUzJpMGI2?=
 =?utf-8?B?SEpWTTRRbS91anlXczVLaGdrbmwyV05DVERMYmxYNGMyZnBNYlVJUWxBSHRi?=
 =?utf-8?B?TnplOFdCb3NIV2d3M3VqMk4xSDNUSGJsUEpmanBONnpJR3FWZHZxZXVWQWtL?=
 =?utf-8?B?cjVodWY2U0JXWHZwSVNBM3h0V2pTV1hYWm01L0dVZFBpRG50Vk5vNUgrd0RC?=
 =?utf-8?B?c2FlS3V4dmFBNUxab1lzVW1MaituamZlVWpicEtqS1BKQTVHZUhBVkJqUlo4?=
 =?utf-8?B?M0FBN2RtQUpqQWtvNTY2T3pYYmpNRjBMRzViZ1FSanhvZngxNDhtakIwa1h2?=
 =?utf-8?B?VXdKcDlCQWc3c05ldVRwRUNTbmR0OU9CZnRFeVgzUjRoZndvbEEzZzR2cE5j?=
 =?utf-8?B?Y2E0V0ZGbDJVYktoa2xySC93Qm1tTSszcXg4RXNQZ1dGTGFZaEE5Nythcm05?=
 =?utf-8?Q?Pml7RTVAzU4ADV4ZcP/jqIZbR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712fbe47-763b-477f-8084-08dc21ce34a7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:01:11.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVb+aQybv8H2IYsa+dltd298uMWny9Nl6l6c+zvIUdFoRWDU4AZOR21Bv/+bnZCqfKDpuzF86orPbDMU9NocCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111

On 1/29/2024 23:56, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> x86_energy_perf_policy adds AMD EPP profiles switch support,the EPP
> driver also has four EPP profiles implemented under power
> firmware autonomous mode.
> (performance, balance-performance, balance-power, power)
> User can choose the new profile to use with this utility support while
> `amd_pstate_epp` driver instance loaded for the MSR support systems.
> 
> for example:
> $ sudo x86_energy_perf_policy -d --hwp-epp balance-performance
> cpu0: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> cpu0: HWP_CAP: low 13 eff 157 guar 0 high 231
> cpu0: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> cpu1: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> cpu1: HWP_CAP: low 13 eff 157 guar 0 high 236
> cpu1: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> cpu2: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> cpu2: HWP_CAP: low 13 eff 157 guar 0 high 211
> cpu2: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> cpu3: old: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> cpu3: HWP_CAP: low 13 eff 157 guar 0 high 206
> cpu3: new: HWP_REQ: min 13 max 166 des 0 epp 128 window 0x9 (9*10^0us) use_pkg 0
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   .../x86_energy_perf_policy.c                  | 69 +++++++++++++++----
>   1 file changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 5daf1c2bb601..da9087873915 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -902,14 +902,23 @@ void write_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int ms
>   			hwp_req->hwp_desired, hwp_req->hwp_epp,
>   			hwp_req->hwp_window, hwp_req->hwp_use_pkg);
>   
> -	msr |= HWP_MIN_PERF(ratio_2_msr_perf(hwp_req->hwp_min));
> -	msr |= HWP_MAX_PERF(ratio_2_msr_perf(hwp_req->hwp_max));
> -	msr |= HWP_DESIRED_PERF(ratio_2_msr_perf(hwp_req->hwp_desired));
> -	msr |= HWP_ENERGY_PERF_PREFERENCE(hwp_req->hwp_epp);
> -	msr |= HWP_ACTIVITY_WINDOW(hwp_req->hwp_window);
> -	msr |= HWP_PACKAGE_CONTROL(hwp_req->hwp_use_pkg);
> -
> -	put_msr(cpu, msr_offset, msr);
> +	if (genuine_intel) {
> +		msr |= HWP_MIN_PERF(ratio_2_msr_perf(hwp_req->hwp_min));
> +		msr |= HWP_MAX_PERF(ratio_2_msr_perf(hwp_req->hwp_max));
> +		msr |= HWP_DESIRED_PERF(ratio_2_msr_perf(hwp_req->hwp_desired));
> +		msr |= HWP_ENERGY_PERF_PREFERENCE(hwp_req->hwp_epp);
> +		msr |= HWP_ACTIVITY_WINDOW(hwp_req->hwp_window);
> +		msr |= HWP_PACKAGE_CONTROL(hwp_req->hwp_use_pkg);
> +		put_msr(cpu, msr_offset, msr);
> +	} else if (authentic_amd) {
> +		/* AMD EPP need to set desired perf with zero */
> +		hwp_req->hwp_desired = 0;

Should this be blocked a level higher up?  Like exiting the tool the 
function call when calling parse_cmdline_hwp_desired() is used?

> +		msr |= AMD_CPPC_MIN_PERF(hwp_req->hwp_min);
> +		msr |= AMD_CPPC_MAX_PERF(hwp_req->hwp_max);
> +		msr |= AMD_CPPC_DES_PERF(hwp_req->hwp_desired);

Given the msr is already initialized to 0, this is unnecessary isn't it?

> +		msr |= AMD_CPPC_ENERGY_PERF_PREF(hwp_req->hwp_epp);
> +		amd_put_msr(cpu, msr_offset, (unsigned int)msr);
> +	}
>   }
>   
>   static int get_epb(int cpu)
> @@ -1157,8 +1166,12 @@ int update_hwp_request(int cpu)
>   {
>   	struct msr_hwp_request req;
>   	struct msr_hwp_cap cap;
> +	int msr_offset = 0;
>   
> -	int msr_offset = MSR_HWP_REQUEST;
> +	if (genuine_intel)
> +		msr_offset = MSR_HWP_REQUEST;
> +	else if (authentic_amd)
> +		msr_offset = MSR_AMD_CPPC_REQ;
>   
>   	read_hwp_request(cpu, &req, msr_offset);
>   	if (debug)
> @@ -1181,7 +1194,11 @@ int update_hwp_request(int cpu)
>   
>   	req.hwp_use_pkg = req_update.hwp_use_pkg;
>   
> -	read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
> +	if (genuine_intel)
> +		read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
> +	else if (authentic_amd)
> +		read_hwp_cap(cpu, &cap, MSR_AMD_CPPC_CAP1);
> +
>   	if (debug)
>   		print_hwp_cap(cpu, &cap, "");
>   
> @@ -1203,8 +1220,12 @@ int update_hwp_request_pkg(int pkg)
>   	struct msr_hwp_request req;
>   	struct msr_hwp_cap cap;
>   	int cpu = first_cpu_in_pkg[pkg];
> +	int msr_offset = 0;
>   
> -	int msr_offset = MSR_HWP_REQUEST_PKG;
> +	if (genuine_intel)
> +		msr_offset = MSR_HWP_REQUEST_PKG;
> +	else if (authentic_amd)
> +		msr_offset = MSR_AMD_CPPC_REQ;
>   
>   	read_hwp_request(cpu, &req, msr_offset);
>   	if (debug)
> @@ -1225,7 +1246,11 @@ int update_hwp_request_pkg(int pkg)
>   	if (update_hwp_epp)
>   		req.hwp_epp = req_update.hwp_epp;
>   
> -	read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
> +	if (genuine_intel)
> +		read_hwp_cap(cpu, &cap, MSR_HWP_CAPABILITIES);
> +	else if (authentic_amd)
> +		read_hwp_cap(cpu, &cap, MSR_AMD_CPPC_CAP1);
> +
>   	if (debug)
>   		print_hwp_cap(cpu, &cap, "");
>   
> @@ -1246,13 +1271,27 @@ int update_hwp_request_pkg(int pkg)
>   int enable_hwp_on_cpu(int cpu)
>   {
>   	unsigned long long msr;
> +	int ret;
> +
> +	if (genuine_intel) {
> +		get_msr(cpu, MSR_PM_ENABLE, &msr);
> +		put_msr(cpu, MSR_PM_ENABLE, 1);
> +	} else if (authentic_amd) {
> +		ret = amd_get_msr(cpu, MSR_AMD_CPPC_ENABLE, (unsigned long *)(&msr));
> +		if (ret < 0)
> +			errx(-1, "failed to get msr with return %d", ret);
>   
> -	get_msr(cpu, MSR_PM_ENABLE, &msr);
> -	put_msr(cpu, MSR_PM_ENABLE, 1);
> +		ret = amd_put_msr(cpu, MSR_AMD_CPPC_ENABLE, 1);
> +		if (ret < 0)
> +			errx(-1, "failed to put msr with return %d", ret);
> +	}
>   
> -	if (verbose)
> +	if (verbose && genuine_intel)
>   		printf("cpu%d: MSR_PM_ENABLE old: %d new: %d\n", cpu, (unsigned int) msr, 1);
>   
> +	if (verbose && authentic_amd)
> +		printf("cpu%d: MSR_AMD_CPPC_ENABLE old: %d new: %d\n", cpu, (unsigned int) msr, 1);
> +
>   	return 0;
>   }
>   


