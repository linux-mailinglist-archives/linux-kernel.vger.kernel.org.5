Return-Path: <linux-kernel+bounces-85594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8E86B819
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7D11C22EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422A74434;
	Wed, 28 Feb 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0cewzcjz"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205D15E5C6;
	Wed, 28 Feb 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148256; cv=fail; b=gR0vWKB51kDnA3VoiCwaQAuvBdLr4FCjKOX084jHOI404Ud/I9sPN3p9UuVzO1MsAukQF3tiCGOgdgXeusUClkfq0o4mCbmJs/RGOjK9z7h+Bceuj3N1gU71ZXBNif4xrpyJzJTCgBpBe3VWuZcKaRMqpogzbO1BpY/2yXKzCrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148256; c=relaxed/simple;
	bh=kYsfxD+Ffb/jbhVZlNHw9rSDSWKRt32S6Q2EXLY8XM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PbzrFqZlPvimodIdDKSaV4SBDs83RQI2ZbpzVPBTLs71Gfe/3LAj6HSgros1u7Oem2/cvh9lK4b26E2ad1oXf6i9WTrVoQF8PG7MPM6/Th6yYHeMFU8HE4GdPNX4cLL6DZny1YRw+yJhrqnX/to2IVEcIY1BQ/UD3QfgxrWqB/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0cewzcjz; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPzYR4inphwdpYNX8jaeRLB6vcHYB5NJ3u7lfYoMGZYXRZ20LzZYCk6domKXc3v0glDDjK/LK7PGxzOw+kEuydRX2ChYr3UQorcor1YwAdP8swuugbmLkckVz3EyHM7WLZ+McPfzsbARef2cO5VrICoEOd+dCw+a/jlHMVcWN4+m8jytpsKSuHJBqZTgBYJkiuyJGU7cjmZiDvOLv03jsvFeYqFRrcvRgGhzwTybIkTRhrAFBUGjidtlOi8goifi9Xl089xbuObPWSwIKjdSAjyu4pIRg4sGiUw0PUpLTGVXusYUeahrLi7288quN6LvRXvjt44v53cKstMpWjgdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsULkH5mdQjb5RnzTNEKegHlIVRNVujUKrKIxHwr1Lw=;
 b=IQhQYVcCCsdf1UT8T5LrOKQ4UfJzCVOYU7r3njHcnCT0MVy7nLt+b2L3t2ceOPloCkAT/wOPLf9g8nJPf/o24dN1UCv7NAhzJ4ehP26ozssz/LKZg1oZiQTy44Fea+fRbN9sErxZs2F+iDLlbYnZL8AZ9J8OqHWkRc6iHyqAsXiJg4gsuurHTR9cjDB1Hb5UYo1t++KGsKgFqoY62Ht0FSR5nItD/pTxCZNOB1PNi/xkSqWfdVDfZROPJ02vpuZ5iDH1rDxevDi2dQHKsGhijboNpBoix+Jp43GDeXvuLTuFU/lnjGBe2eGqT+KXzUktD4rpM9Pu5Tfaq9ohoAfimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsULkH5mdQjb5RnzTNEKegHlIVRNVujUKrKIxHwr1Lw=;
 b=0cewzcjzSoTbJZ2C0/GmXYoq92ZMcG3EVL/JGAsKN34zGBrDGF9YWw5edrqKpTkMpN2fx7NkdbHTZT6q6IUmpBBO8RapAB6ovRQTWs+bTHhQgFyq+IUUfgt7FpzkTcCj8z26Xr+02dfN9bLTt8bIbUuSWhYUa9znXBYlSjq682A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 19:24:10 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::14ab:832a:11af:bfec]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::14ab:832a:11af:bfec%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:24:10 +0000
Message-ID: <71dcc0f8-a59a-4aee-9349-09334b8e75f7@amd.com>
Date: Wed, 28 Feb 2024 13:24:08 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11 1/4] remoteproc: zynqmp: fix lockstep mode memory
 region
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
 <20240219174437.3722620-7-tanmay.shah@amd.com> <Zd9omCbc3UqjT7Lr@p14s>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <Zd9omCbc3UqjT7Lr@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:806:23::8) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: bb048ae1-f188-47ac-02be-08dc3892d715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i+++gVHis7bgFSiBfVKtPGCI1cv0MMsBU4ZneWXls+0WFeIqSqQl77VWf7mk4nAarOLQhnKWfZj4vT9N+Y3CDphiPKTIDro2Hm+nsIVw0ZtdsExDcL5FuiYt/BbYXVr2lJKg3HLWccGvq2nMMxHuKBvE6//yxjTcfk6d1rHD7KV1WED1l6GAsWrnmMoabAuCjCo+71gYWs3UGeclz3Erw5B2xcG/EzwBrWnBmE7pkvJyPcV86eZkjJiB8LS9P9lsBgHdB/l9szLimZViwDskF+FwqdBz9esRFkzb6mR0UT0pKrer7SNrtrTTPm722qUFxPS+qOshxI6lmor/WBW2WVjfy76d+N2ZMw+pVYPL+8HMZ8M5HzLutKBEBM+rI+W3ziRkr3Kgyc17Zs46EXUVt25XHLlOlIYcCQebrmkH8gEmzxSB9dIkpzivGYukdgOo6ZSjxClCMocRtO1dfF/oytdkssS0pc23Xziz98eSpTZQhIlNeu69LfyE0UFp6M0U2YS1ntBH+ZUUCSfYEkQD48bGZ6JzYRah5sTMx5s1WSOJUY/Mg/G0dSpwLRI9CSYKhpGvp+tdVHCH8OJh6fhxRYCaZHrVsPjxOiXT0Zg8a+QpQqGDODJUTBm9Yh8/T4uf7gyguO48aH00SP7oVVsiBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWl1bmlCc1VoZWNHZllBWURqUVo1Z2I2L2F1M25tTEtFZ0ROTy81N0E5dlZk?=
 =?utf-8?B?NEM3VkE0Q3VPWjJGREkveDNvUGxkNmZ0MXI5RFRVZ3lGQURib0JxTlcvcE5j?=
 =?utf-8?B?Smc3OEpSY21xZHp1RTE0SWtyRmR3Vnp4RDRodEZIOEkvOCs0cnl4NzNRcGpQ?=
 =?utf-8?B?MnN3dExGcmdrNXhzL0Y1L1NGb01NSDR5V1NFNk5VKzNaWVRNRm5wZ1EvZytR?=
 =?utf-8?B?MDJBT0ovQk5CKzBwQnczbVpTeiszenFDdDNsZWcwN21CemwzWklxaE90ek0r?=
 =?utf-8?B?S3Z1RW1JN3ZZZVJQR2pYcDJiUzNuNTFONzh5b2VOb2xObkM5U3o3dUtXdWRz?=
 =?utf-8?B?MGkyZWpDdHFlc05ndlRGTU00KzMxMzIxM2Z5VG1lRktwdnlnS2NWOVlCUFQz?=
 =?utf-8?B?YS9sSGcxbml1dGtLQk9TUlIrVFlsYlJrY3FxQ250NU9sK2thU3Q1WVF1TG9y?=
 =?utf-8?B?aDQ0WnRRN1Q3Qmd0V1JTME5lTHp5MXhOaWcxMXA3YmFsM2drUkdkZmNMZ2xj?=
 =?utf-8?B?eVlPVTBlclg4emJtS00vMnFPdWhzdzhPZ1laQzEwTDlvWDdLa2dJUTR2b21z?=
 =?utf-8?B?TVpvcGJlSlR5WnNOUmxTaWVGbjlmMGFjSHNvYTYvSU1kZEVMOStxU09vQzFh?=
 =?utf-8?B?VEZvT3VySDJlNVNwWGI1Rmg4TlNtNWVSbGh6TWdIWGl1TnZyWkMzZFJTZlg3?=
 =?utf-8?B?WU90THdGU0JQaVNzYUJzdnFLVWFXeTJlWG0zSVpWK0U0RmU0T09RM08xVmE0?=
 =?utf-8?B?cUttNUZ6NXBKcEI3cEQ2bk13MXMzQ2pSQjVBQUZ2NklEUkw3SzFiTndZMWFW?=
 =?utf-8?B?OHk1T0g5bk9NNGU5dDVCcFY0aGFqUXdoZDRUc3ZxNGhSOE1oM3ZiNmdsR2JK?=
 =?utf-8?B?Q1J3ZGhOcG93b3hNc3AwU1grQWFQZmVqSUVweXhnSUlMbzZYeUxLVnhkTFRO?=
 =?utf-8?B?RWI4WDJBcEloZXdWYUJkWm5nOFdyNXA3aEpub0ZYQlQ3K0gzdzBuTGxNZHNF?=
 =?utf-8?B?d3pUVERBTmdtcjF0ckloS212TXVEbTdmZHVyYS8yczBtajAwaXBnQnZlaXkx?=
 =?utf-8?B?aGcrdzNKVDVJSnl1UkRpejdjbjB1ZlVLUUpuRWFINGJPei9ydjF0dk5Ua0ZO?=
 =?utf-8?B?OUYrSUp3L3FQM1ZGT2ZHdll5eWxvanJMd0VJVHFiYU82NTVrc2llSmxQaEsw?=
 =?utf-8?B?Q0lyVTA4WUgvM1ZkOVZ6QmdtbmJGbVpxc0RKQmRTTUxEY29zc3REMmlDWUE0?=
 =?utf-8?B?Zkc4NjFhZTJjSVFIVlk0WktoZWczb1ZSV3YzbDlVZUt5ZlJSdkQ0NFZFK0Za?=
 =?utf-8?B?MUtTVG00Ni9qZ053d0xiM3hnaVZTK1AxemY2SXQyQndhSmpFdWQ4WHFXMFJl?=
 =?utf-8?B?Q2ZTVmNCSUUvWDRDS1RBQW9jZGF2TUZYN2lJNVVwanBydFFWazQ1SU1WdlF5?=
 =?utf-8?B?QlYyVzhGaDVPOWlVKzZmbnpyRExKZ0dUc1MwdUZZNWNhZFc4WDNhd3lMaG5x?=
 =?utf-8?B?S0MzM1dnWHMxVVpqdnlaRmptbmRwandtZjN5Y0Q3MzJITERxcUdrdWlZMUh4?=
 =?utf-8?B?NHhmbGpwUG04bjlSaWpHS0hHU3RuTXJ6eTE1VkxwaDF6YUY3d2dvbndRSm96?=
 =?utf-8?B?UlB5a0llRzhOa2t1NWovNUdEOHd4TTg1blVqaGxqMHhjZ2MxK1JLV2o1NFBK?=
 =?utf-8?B?TnFuZ1d1SFBQcXpoa1d0SlhxT3FwVDM3UWpiaVdieGlYeUlWajNjbndtOENS?=
 =?utf-8?B?WWs3Vnp5RUdxUmhZNXJ2OWtYdGQzN1JpeU1nTVFzNUQ2cy9zZ3hZcFo5OFVx?=
 =?utf-8?B?V1I0NElSVVRQL3VXb2d6RmRqVDl4Q2FSM3l1aXo4WjNmMzBWa3VEbFdhUXg2?=
 =?utf-8?B?NEsxb2o2ZlhCVFhVNG5vK1hFRUs5dkoySExjN21IL2NrcGhGQnNxcGQ5bytr?=
 =?utf-8?B?MUFmVFJlS3hFY09NSXBuS3JyRjE0Yjd3VVZncExySXFNZW81eHpXUDlWdk1N?=
 =?utf-8?B?em1ITFVzdmRXdVRoTTRTWmJHKzRjVlhXallIVDFPTy9IQkR5RG9sQkpueFN6?=
 =?utf-8?B?U0J0bThqd2lQUzhTZC81cHErVUVjOWZNZVowL2oySXpDUkRVSE1Ga3FuN0tS?=
 =?utf-8?Q?unjGX23PREk1uhaP0PGraI8dz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb048ae1-f188-47ac-02be-08dc3892d715
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:24:10.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9GCa321WwnVbF+yu1VxVRZLTxZCjp0mT6T5PVSVHiDwCOSDY4j2NjF+Wws787sI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354


On 2/28/24 11:08 AM, Mathieu Poirier wrote:
> On Mon, Feb 19, 2024 at 09:44:34AM -0800, Tanmay Shah wrote:
> > In lockstep mode, r5 core0 uses TCM of R5 core1. Following is lockstep
> > mode memory region as per hardware reference manual.
> > 
> >     |      *TCM*         |   *R5 View* | *Linux view* |
> >     | R5_0 ATCM (128 KB) | 0x0000_0000 | 0xFFE0_0000  |
> >     | R5_0 BTCM (128 KB) | 0x0002_0000 | 0xFFE2_0000  |
> > 
> > However, driver shouldn't model it as above because R5 core0 TCM and core1
> > TCM has different power-domains mapped to it.
> > Hence, TCM address space in lockstep mode should be modeled as 64KB
> > regions only where each region has its own power-domain as following:
> > 
> >     |      *TCM*         |   *R5 View* | *Linux view* |
> >     | R5_0 ATCM0 (64 KB) | 0x0000_0000 | 0xFFE0_0000  |
> >     | R5_0 BTCM0 (64 KB) | 0x0002_0000 | 0xFFE2_0000  |
> >     | R5_0 ATCM1 (64 KB) | 0x0001_0000 | 0xFFE1_0000  |
> >     | R5_0 BTCM1 (64 KB) | 0x0003_0000 | 0xFFE3_0000  |
> > 
> > This makes driver maintanance easy and makes design robust for future
> > platorms as well.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>
> Now that I have a clearer picture of where things are going, I am adding this
> patch to rproc-next.
>
> I'll wait for the DT crew for the rest of this set.

Hi Mathieu,

Is it okay if we wait for DT crew to clear new bindings as well before taking this one to rproc-next ?

Just in case any modifications needed further?


Tanmay


>
> Thanks,
> Mathieu
>
> > ---
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 145 ++----------------------
> >  1 file changed, 12 insertions(+), 133 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > index 4395edea9a64..42b0384d34f2 100644
> > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > @@ -84,12 +84,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> >  	{0xffeb0000UL, 0x20000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> >  };
> >  
> > -/* In lockstep mode cluster combines each 64KB TCM and makes 128KB TCM */
> > +/* In lockstep mode cluster uses each 64KB TCM from second core as well */
> >  static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > -	{0xffe00000UL, 0x0, 0x20000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 128KB each */
> > -	{0xffe20000UL, 0x20000, 0x20000UL, PD_R5_0_BTCM, "btcm0"},
> > -	{0, 0, 0, PD_R5_1_ATCM, ""},
> > -	{0, 0, 0, PD_R5_1_BTCM, ""},
> > +	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > +	{0xffe20000UL, 0x20000, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> > +	{0xffe10000UL, 0x10000, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> > +	{0xffe30000UL, 0x30000, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> >  };
> >  
> >  /**
> > @@ -540,14 +540,14 @@ static int tcm_mem_map(struct rproc *rproc,
> >  }
> >  
> >  /*
> > - * add_tcm_carveout_split_mode()
> > + * add_tcm_banks()
> >   * @rproc: single R5 core's corresponding rproc instance
> >   *
> > - * allocate and add remoteproc carveout for TCM memory in split mode
> > + * allocate and add remoteproc carveout for TCM memory
> >   *
> >   * return 0 on success, otherwise non-zero value on failure
> >   */
> > -static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > +static int add_tcm_banks(struct rproc *rproc)
> >  {
> >  	struct rproc_mem_entry *rproc_mem;
> >  	struct zynqmp_r5_core *r5_core;
> > @@ -580,10 +580,10 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> >  		if (ret < 0) {
> >  			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > -			goto release_tcm_split;
> > +			goto release_tcm;
> >  		}
> >  
> > -		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, da=0x%x, size=0x%lx",
> > +		dev_dbg(dev, "TCM carveout %s addr=%llx, da=0x%x, size=0x%lx",
> >  			bank_name, bank_addr, da, bank_size);
> >  
> >  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > @@ -593,7 +593,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  		if (!rproc_mem) {
> >  			ret = -ENOMEM;
> >  			zynqmp_pm_release_node(pm_domain_id);
> > -			goto release_tcm_split;
> > +			goto release_tcm;
> >  		}
> >  
> >  		rproc_add_carveout(rproc, rproc_mem);
> > @@ -601,7 +601,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  
> >  	return 0;
> >  
> > -release_tcm_split:
> > +release_tcm:
> >  	/* If failed, Turn off all TCM banks turned on before */
> >  	for (i--; i >= 0; i--) {
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > @@ -610,127 +610,6 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  	return ret;
> >  }
> >  
> > -/*
> > - * add_tcm_carveout_lockstep_mode()
> > - * @rproc: single R5 core's corresponding rproc instance
> > - *
> > - * allocate and add remoteproc carveout for TCM memory in lockstep mode
> > - *
> > - * return 0 on success, otherwise non-zero value on failure
> > - */
> > -static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > -{
> > -	struct rproc_mem_entry *rproc_mem;
> > -	struct zynqmp_r5_core *r5_core;
> > -	int i, num_banks, ret;
> > -	phys_addr_t bank_addr;
> > -	size_t bank_size = 0;
> > -	struct device *dev;
> > -	u32 pm_domain_id;
> > -	char *bank_name;
> > -	u32 da;
> > -
> > -	r5_core = rproc->priv;
> > -	dev = r5_core->dev;
> > -
> > -	/* Go through zynqmp banks for r5 node */
> > -	num_banks = r5_core->tcm_bank_count;
> > -
> > -	/*
> > -	 * In lockstep mode, TCM is contiguous memory block
> > -	 * However, each TCM block still needs to be enabled individually.
> > -	 * So, Enable each TCM block individually.
> > -	 * Although ATCM and BTCM is contiguous memory block, add two separate
> > -	 * carveouts for both.
> > -	 */
> > -	for (i = 0; i < num_banks; i++) {
> > -		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > -
> > -		/* Turn on each TCM bank individually */
> > -		ret = zynqmp_pm_request_node(pm_domain_id,
> > -					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > -					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > -		if (ret < 0) {
> > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > -			goto release_tcm_lockstep;
> > -		}
> > -
> > -		bank_size = r5_core->tcm_banks[i]->size;
> > -		if (bank_size == 0)
> > -			continue;
> > -
> > -		bank_addr = r5_core->tcm_banks[i]->addr;
> > -		da = r5_core->tcm_banks[i]->da;
> > -		bank_name = r5_core->tcm_banks[i]->bank_name;
> > -
> > -		/* Register TCM address range, TCM map and unmap functions */
> > -		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > -						 bank_size, da,
> > -						 tcm_mem_map, tcm_mem_unmap,
> > -						 bank_name);
> > -		if (!rproc_mem) {
> > -			ret = -ENOMEM;
> > -			zynqmp_pm_release_node(pm_domain_id);
> > -			goto release_tcm_lockstep;
> > -		}
> > -
> > -		/* If registration is success, add carveouts */
> > -		rproc_add_carveout(rproc, rproc_mem);
> > -
> > -		dev_dbg(dev, "TCM carveout lockstep mode %s addr=0x%llx, da=0x%x, size=0x%lx",
> > -			bank_name, bank_addr, da, bank_size);
> > -	}
> > -
> > -	return 0;
> > -
> > -release_tcm_lockstep:
> > -	/* If failed, Turn off all TCM banks turned on before */
> > -	for (i--; i >= 0; i--) {
> > -		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > -		zynqmp_pm_release_node(pm_domain_id);
> > -	}
> > -	return ret;
> > -}
> > -
> > -/*
> > - * add_tcm_banks()
> > - * @rproc: single R5 core's corresponding rproc instance
> > - *
> > - * allocate and add remoteproc carveouts for TCM memory based on cluster mode
> > - *
> > - * return 0 on success, otherwise non-zero value on failure
> > - */
> > -static int add_tcm_banks(struct rproc *rproc)
> > -{
> > -	struct zynqmp_r5_cluster *cluster;
> > -	struct zynqmp_r5_core *r5_core;
> > -	struct device *dev;
> > -
> > -	r5_core = rproc->priv;
> > -	if (!r5_core)
> > -		return -EINVAL;
> > -
> > -	dev = r5_core->dev;
> > -
> > -	cluster = dev_get_drvdata(dev->parent);
> > -	if (!cluster) {
> > -		dev_err(dev->parent, "Invalid driver data\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	/*
> > -	 * In lockstep mode TCM banks are one contiguous memory region of 256Kb
> > -	 * In split mode, each TCM bank is 64Kb and not contiguous.
> > -	 * We add memory carveouts accordingly.
> > -	 */
> > -	if (cluster->mode == SPLIT_MODE)
> > -		return add_tcm_carveout_split_mode(rproc);
> > -	else if (cluster->mode == LOCKSTEP_MODE)
> > -		return add_tcm_carveout_lockstep_mode(rproc);
> > -
> > -	return -EINVAL;
> > -}
> > -
> >  /*
> >   * zynqmp_r5_parse_fw()
> >   * @rproc: single R5 core's corresponding rproc instance
> > -- 
> > 2.25.1
> > 

