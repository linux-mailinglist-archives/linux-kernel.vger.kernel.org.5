Return-Path: <linux-kernel+bounces-55460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F184BCFB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815781F24915
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC7313AE3;
	Tue,  6 Feb 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i5XPSR9R"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE113AD1;
	Tue,  6 Feb 2024 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244380; cv=fail; b=H3rTGzy1DYlF4uFjBRTzBtUYWm0r7C4wKGqDEJijn79tM0KxK6D9VcvSbWcTTUIDFM1SVRwjDD4t6KYqfCyXYY707H8m6CUZ6BHSDkBJpaNIyjCgh1b6zJ45p+A3HK4dBJvgFnjHFd/VIEo6/3+Agzo6ArkjiAfsr5CfBuVCKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244380; c=relaxed/simple;
	bh=EJvdWI3Fob9/1fj8awqKiFlhYB2xQkPFRbjlHJG4jAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lv+i2VnhTlxlF43zGt0quQWchBBYv8mKjiEhk0PVKtUOC5t+Q6eFd+6Ile4avqxfqxZuVlHyJ0ZcGG9Af/LibhhXZJabk1htdbuEReoBkyAYOpy9euqLlfqsGeBfg2Eie510Tf+F48p4LKo3sCaaC8PXcgn/2uYgmjvfLaAkMuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i5XPSR9R; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7YjShLa6E1H2PJCkFZG+Gy6PefEElgcaZ3L+hAjvX4aT1AwPi8tu7EqU7tHV2Cn5zr3XF7ESMDSAMTFiWdu0CFgS3RACLU4CxGLCsUpXXqSqUO9Jyr72j3y2zwWb8XQ9Pn3VijDZcOkoD7CxQAKQuwELkaqf45oAmBJyaKIrUEEMEKO4uVORwhxtvafTqAPkt2JQCRYSQQ/5AECoCQma9ul0l67sMappz7KBP2pbgjs7+1Lr5jf8/J42YSPKkKkxumYuK4jFfoymu6WusP8p6McQMk6NZGKG2mUu7shogtvMBtY2NY26VpT310GurouYeYFG7REFl6bttp5qKSdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwzerOiNxGxQY2ZBWchqu2KScv5sW4VgpoKwbdhdqRs=;
 b=K+PRmEbZd03m/frmutNyrElrE8WuWZn7LwfuieCos40L0v4kU7jg9vMONk/beZtpxBXTuirEzrZ+NdjNVSU4q5DmeQs7Nc5GBJyFJCvU1ItxejUZXLkQNRwr5fmtAKVYDnjB5IjyjUg3+TC29o2gbTMh0KrmxGgKMS3rwvwYZ6g6mYgI/0jXKQ/Q8EH5mRfMChtKe08EzFcYHNCzglSwaE9H62SnB4u7hF7JUyuxm3/J+4sK32LvinFWl7N4k86TL6b3SeLjkKQA+9u0d2QnEt0xrlG0wcxa2ncTc8lIg1V8CJRfnvy1NZ1LSKMvsNvt5DuEFPXiY9oWBlAlxC/nCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwzerOiNxGxQY2ZBWchqu2KScv5sW4VgpoKwbdhdqRs=;
 b=i5XPSR9R6VNciRUj0gbsC0Jmv+BV/bqvrl+du1CDBsuMhggkIdSQNk9CrJA/HTiSZo/W+lPsXcnpRrhmDE9Xr9Tkmt89BpcLbpnPQVoBQAtmewCWQcKGgeWtKgclRG6spRiltQzbY9YTRAoNBHkSV913qqfROFrFesfmjVkb6w0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 18:32:53 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 18:32:53 +0000
Message-ID: <39ae9ceb-e872-4dda-9dd0-b9e97babe39f@amd.com>
Date: Tue, 6 Feb 2024 12:32:50 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] remoteproc: zynqmp: fix lockstep mode memory region
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201004812.1471407-1-tanmay.shah@amd.com>
 <ZcJu10CIVYF9iodF@p14s>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZcJu10CIVYF9iodF@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0241.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::31) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: b479abd2-b987-4b02-ebc3-08dc274207da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RFGmSesHqAbyGEVbbR0QyuekwcPtAnU/ftEblBGK0DzusbCpVccWsoWbysDZ6Q06t7asNUB7N4RjskTqbwSHMeVKU+9Ldu9EAghJYfBmbZyLV7stuozvwRMzvuv4CQ7wn/45NIkmnl0uSdN4tXQ2jBp10dvNiXE0GkLaRbeyk9/SYdWukDQpKpPTw52IyW7UF3lqyAB8PTZdkmNZuShQkUlKqm5liPS7fV2U+Y4HE+4L0ItfLKva7ujDkCIjYQLf46bY/v+PGvOuWSfsACwrCTalgt40vVYsfXh+ibi8m5ThcnONamtgx1UBdUxmToq7EhBN2M9q2VVrTJRlBIrkkWWrLDCzklN+h/hBe1K5MGwFrCBPpFesthDMxyPXJmRsOB0CspGjRBpOMFAR26vIcHJogUzIThB/ajPWeWGUdbI0AYFyajf/10o51FeyrYBKGcs3KKqEvnZf/BQOli13uhldwNEFS2iI96GynM2N6pRVIJnwONZeopvCN9UT0CS5lQiJNFPRmWuhA/wAFYTiwtzKnUYSqsPFXklwWmM3QhqKmNWZJqrab94admAiv4P1njzHgfyj3qwW1QZklbnHrlZZVp+LClXr+uC31z1TcbFYkaoz1TFeNaY9pC333OO53Plcje4LnwqWBQIFK8Li1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(26005)(53546011)(6512007)(6506007)(5660300002)(66556008)(8676002)(4326008)(66476007)(316002)(44832011)(8936002)(66946007)(2906002)(86362001)(2616005)(31696002)(478600001)(6486002)(6916009)(83380400001)(31686004)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1FnOEh3QStYNGphL1VHSnlaZFV4c0czVUErdk4xaW9Ma2JlNVNzYzIxTnhD?=
 =?utf-8?B?eW9RRWFPUERlZmZnQ1BvcWkzL3ZRcUFScmlzRmtWeVpBaUFNMmFEMDFFdDhT?=
 =?utf-8?B?WVphT3QvYU5oNzBzTU9yck9JTnFBSHgzRG9ldzZUZmk0dThRYllNNGdXQzM2?=
 =?utf-8?B?b1Jrd2dSQzNxbEVKT2thbUQwcVhFTHNvNk95emRIU3JMUGJFZVBOV0dtY2F0?=
 =?utf-8?B?NW5YR0FadGx6RDkrM3R4UWpJMVprb3dUb2d6a3FYSHFZbllPQmZnd1VJNjA5?=
 =?utf-8?B?L25JVW4rUnEyczB3bHRxZzVseGhZZnRjaEM3OTh2OTkwdFplSGpWTzdCMnBR?=
 =?utf-8?B?ODlsejFiVmNMaFdtTmRNcG9UUDZNalBwV1htQ285a0Y0QmgwNWNPWnExcTlG?=
 =?utf-8?B?bzMvcUNpQW00WWZ3R3pyNGkzeEw3b0dyVllDV1lLU1JJcW05NTlTWUJSZklT?=
 =?utf-8?B?UTNGZlVkb1dMWUF6UXJNOE1aZzloMU1LWFFwRlZWcnJwSzRMZUUrS283cnBm?=
 =?utf-8?B?VkFCK0g0OGswZHZFakl6TEl1S1VGRlltTjdXdUdzOGhBVGZpQVQwSU5NZ2Fr?=
 =?utf-8?B?UHpMOWxGUzkyVmxHc2ptT0FJYjhTV242UWxaNm1qSGN1NFZQVHV4SkdkeGUv?=
 =?utf-8?B?V094bkFzR2M2eXpad1l5bDBJM0YrcFMvRU13SG01MmF4NzNQeFQ3M1MvbU5R?=
 =?utf-8?B?VytDUys2NzVYN0pJWkRKejhkU09Sazdrb3ZQWUY2ek5QS2ZkU251a1VBZjcr?=
 =?utf-8?B?NjVpWGNDeWNZamNVTEk2c2MyQjR6Vk94L1lYMEdZS2lBZVVtVGtpeUxOa1NR?=
 =?utf-8?B?VUlSTWE3ZSszU253bzdsWmx3TTNpcG1RSUtXdlNVS0puYVFneE55UDk2RU5P?=
 =?utf-8?B?TWxoUk81d3c4bFRKU0xhdHZXK2dSK1NPYVIwaVJYRXNmUVlLdDdyaVhmSHYz?=
 =?utf-8?B?RC9ybm93N01UTjQ2Rld3SnVRQkszQzhBTi9EVnRMUmp6ZlIrUTByaU9WdlFp?=
 =?utf-8?B?KzN0aU5ZcTdJVFZzTXJFWS94RzZ0ZFdkcTVmdC9qT3RjRERNVFZNUXIrSjZo?=
 =?utf-8?B?bk9XM21uMWVVWkNsbS85OHh0VDFJb0R1aWpkbGs1U0VIb1cxcDR2cHpHU0FX?=
 =?utf-8?B?TFZnR2Q1TlArZkdtQm1ZRUxYSTFzeVA3SUljeWhwODJTdmkxZzZWb2hGeG11?=
 =?utf-8?B?NTAwM25IYm5EM3B5T2tGby95NWZhckhkMmVQS0s1T095ek1IOGhTMktESUdN?=
 =?utf-8?B?dkk1bDBNc0RRK0g2NnE3NGlaTUpmREFLZ0x6cUlkaTZaM1d2VnpuNGZMcWU3?=
 =?utf-8?B?WS94OHpYZFVXdGhER0ZNWEVGbzltTEthdU1qYk12R29WenAxV0dLMFUrT0Vv?=
 =?utf-8?B?cXpabm0xcUlyRFFQRmJoQjFFOUVDSndxWEZmTkNaSkM3TWtNdHVBakdYS0Vo?=
 =?utf-8?B?dDV1RlE4aEQvbjRIRStDZFdDcklxMUN2OUUyRkIrdzl5dUNFTFcyemZRazdF?=
 =?utf-8?B?OXpGcjlaeGtRREwrVnlOZGFDWUUrMkpncURQZWtieUlmU0R5N3YySXliSDNU?=
 =?utf-8?B?Y0RBa2lBRlFUNStCZGFCbEZyVUdBNkRwdXdSdWZUV01UU2ZEZTRCc3dnSEVB?=
 =?utf-8?B?cyt6UFJhVWNSaStGQzR4OEliVFpYcGtwYkFmS1lCZFZ3d1pwWjh1cWcrR2sy?=
 =?utf-8?B?Rmt6MG9kZDNDcWtrS21QVXE1N3ArL1dHb1ZkMklaUG11anpFK0VXUHNHbFlI?=
 =?utf-8?B?dXhCUmR3U1NmUkJQWEVPWHAwMEs2VjBOL0M5ajZJSEZOQ2pjSzNuS0ZIMVly?=
 =?utf-8?B?V1hBSmlzV283TlhPbWZkdWdjUzUzSm5BN3hCVm15SkdSSUhoN1MrNG1nT2lJ?=
 =?utf-8?B?ZDF0dyt5M252N1NNLzBSZHcrdkxJeDQ5NExGS1pZdS9LamhBUE9PQzhHZm1P?=
 =?utf-8?B?Nk5MaCtjUDBXazlwc1ZINnlyZnhjWklNSkpGd1NKNzVRK21zYjgybkx3VVhC?=
 =?utf-8?B?b3g1RUh3dFhZc0FMOERweTlmWWc4NEt2UDc3S2preXVReUZQdHhrQzJSdWYx?=
 =?utf-8?B?akg3NkYrbFFiVzRpTWo5WWlteEFTUmNSOCtTQ2diU3BZSjVWRFRjSHNPa05B?=
 =?utf-8?Q?G/V4tJC8x+hkugvDZ9/803kwa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b479abd2-b987-4b02-ebc3-08dc274207da
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:32:53.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk+CL7rEz1rDHyr5NFQDOC2yjbkb4cLPXSQsqZxPYU56WPxcmajZH5zhcKXXV/sg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809


On 2/6/24 11:39 AM, Mathieu Poirier wrote:
> On Wed, Jan 31, 2024 at 04:48:12PM -0800, Tanmay Shah wrote:
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
> > This fix makes driver maintanance easy and makes design robust for future
> > platorms as well.
> > 
> > Fixes: 9af45bbdcbbb ("remoteproc: zynqmp: fix TCM carveouts in lockstep mode")
>
> This patch doesn't fix a bug, i.e users won't see any changes once this patch
> gets applied.  As such there is no need for a "Fixes" tag.  When you resend this
> patch (see below), please remove the line.

Ack.


> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 145 ++----------------------
> >  1 file changed, 12 insertions(+), 133 deletions(-)
> >
>
> I am happy with this patch but won't apply it because I want to see what comes
> next.  Please include it in your next patchet.

Thanks. Sure, I will include this with zynqmp tcm bindings patch series.


> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
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
> > 
> > base-commit: 99f59b148871dadb9104366e3d25b120a97f897b
> > -- 
> > 2.25.1
> > 

