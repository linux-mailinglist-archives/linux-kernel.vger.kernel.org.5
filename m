Return-Path: <linux-kernel+bounces-55269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FA84B9FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A72282C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221AC134CD6;
	Tue,  6 Feb 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IAxpNCor"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C513341F;
	Tue,  6 Feb 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234276; cv=fail; b=mAe7ZuPE51ExVNOtQswNUpbvhW9Ie+GzMq+uSqK8JBOVF8RGIWy+IRGztxAjT8rS9R4IpsgOULRm17WHZn3f/oLov42k/9/lYdIfE9SEiOWxAbeK6c3Ry+iO9E7+Zzgtoz7rF4vqj/L5qTWvJg55bB1X8gtQc8X9XSLkXcMBHgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234276; c=relaxed/simple;
	bh=yzi6Aet5NQgrz1IFknaDYzit2dEPlCuRlLFmWmrofMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YZcQiJlHczeeNn10K0wfktHiO1Pj2jj3vtkOntIHe1e3Unl3xnJ5GYeZhojL489jCzozBl3E4mQxCGFNbqmV8uix4oLSZuUhhGORFl+5dOShLcywdWozy+ZVJCWMwXP9aJi1kgdZYKhlsnYvWWNllnmZklXqL2ND33LOUCJmcZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IAxpNCor; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMbAKSHMVAJxTm1/dlsjGRXZ9HMgBKh9aYS0e1EsBxEk68AMPnUrgTzZvnd8TiEnuHSmTPtrKL9f9y6QNcw0cF8Kq36jl7DEfBYGRUodS8kQZT03U9dOH1+Xkml3HgJFXO17f1J3d85oNBWnf0zSHHDreHe+KM043SB5upKc+YcorBV24z+Wo2VLuVVDmWk3McQXEl27BgVD+ydp3DyMhPvEHHb8fWJA1nVPznn6G+++Flk9JoXGEnzGEMTzrJ2uk4nOdJ2hiDIStB1ASwQBk9112YWhemTCHOancxD98VNX6ppA2Xqrx+X58FaSvKkP21M6VlEuRyFojAdmtREiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqYuLiDxLoGz2bnGZ1MMzjkR0YDHN/CpJP6U8bluhm8=;
 b=nxtoc60FIesKoJ+4/WKDA29boR2zB9KnW2pHbM5p9lI+K9z8KPNXv5qTc0sbRoLwK34RHhTNeyXBEyEO7jyRpy6Pe9P9ZIp19tFgeXUWsuwbaqK2mHXrwD/o04nArSXepykPgA1AcBRXht1jVFZrWTd4NzszOOl+doU6pSJ8G4NyyCeI2U+ZRjFKouIbjB+FyJpArfivLPpvpvMZUMfjNf7Pi3/LNvSs/ne8PfYNozNKjnsCBkSvKoe/y7nCZ3aKCay9h31cHxQM3J3SU4L88ORJnK2BQEvIHszR4g1bgfmHjeVF6zDdOcCf/48+egF/t/zuUUIVw0lTGzvYtZK3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqYuLiDxLoGz2bnGZ1MMzjkR0YDHN/CpJP6U8bluhm8=;
 b=IAxpNCorxFyvS8djOWB9Fp2YmGqyUxMwxv0n+i/TKNLd4bPZWf12T0c1DFBfWw0jQn5HiunMd5xo1XLi3vZDY3ENB/lO2doG5Yah65aAOXgectZxunVj3tMXJgoC169Drba/AsdiOhGrhlPAeCWmZgSMDQTAYJ60exeCdIvqj8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 15:44:31 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2%5]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 15:44:31 +0000
Message-ID: <70a44ceb-2d52-4189-af42-b56e8f60d0f2@amd.com>
Date: Tue, 6 Feb 2024 21:14:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: macb: queue tie-off or disable during
 WOL suspend
Content-Language: en-US
To: claudiu beznea <claudiu.beznea@tuxon.dev>, nicolas.ferre@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-2-vineeth.karumanchi@amd.com>
 <d8c48839-8b22-47ad-b270-e96a1ad1adee@tuxon.dev>
From: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
In-Reply-To: <d8c48839-8b22-47ad-b270-e96a1ad1adee@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::14) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: be07759b-deae-4999-8b66-08dc272a8295
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2fKt8lS9AY8S/v1bptGt8spfgvA4PZPyxsMFtSQQUeAvEvG3rWSn+JAlI/vMeuwkODmQtkLrOKls69SRz9/qNrunudvknPQZRiWQuGPnQb6LRE9n/dPCegB+oXKgdVk2LVBamFlozTw/Q0fnMqxcnT3PqbQ1EsPO80q+tfadrr7nAkrWFME0Dlb1iTOC+5pHPleeSEC2mkiGcIGUGlhC4lSWJBTdjy+RlgfSAA/pnOf5vKppSpZm+E0LkGDn3Zm7qdmCz58jVXnZaPZ6GdhJQRacBujh5h7Y0ZV5kKfz/nHMDwSfQsFd5R2LbQhXLrTs+xy8Z58FDCUwgU4kGXTDH++wxwpwFYnDgfpD8imbtT4JONvdzr9HDLvpr58fWDmstbvabuHyLVrkDDExNtd04rY0polwC3qHVQS2FsUv+WGZG6Y45330ezJ0yGsy48dbIFZvOLYhjmZz4vcWm3hfepGB/BmqbVXjBZ/uGrKEjfaSmCzHsrEIiHHAB63hmJoPTbWyvNBTIdSK6AUsc3oQml7DKevO+PpyCj3VPMXZPM/vwxMqWWDbw0qFn2OqfzR4/auYIaald6I/AIhONgndjdX9/W8Y2/91C2q42Z3NvBJ80GlF4cBx/RGKwcAXLfboWd7O00DvH0jqcNduRLuJztU5ViU+3BExva1ZOqJiXEo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(921011)(2616005)(26005)(31686004)(6512007)(41300700001)(38100700002)(36756003)(478600001)(66556008)(66476007)(316002)(6666004)(6506007)(53546011)(83380400001)(6486002)(66946007)(7416002)(5660300002)(8936002)(8676002)(4744005)(4326008)(15650500001)(31696002)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXpKU0ZDRWEzczFPL0RISEZ0ZXM3MlljTk1Gb2RQaWpFMWx3cEg5S2JJZk5L?=
 =?utf-8?B?cXpJZ3RrRG42ZTd1ZDNxampDWERRb1QzVGtYQjJITEdkSE5WdVQ5ZmVEY1Nm?=
 =?utf-8?B?alF2dExCeWhWOVNIaUlHRDh4V0hkeWY3R1JhVm94Sktlc29xbWp3K0dEblhJ?=
 =?utf-8?B?L1R4WTh2Mjc0eWExT2RSSUtHV3Rqa28rRENJODFLMUZ6dHhvK0JQQkVKY0Jp?=
 =?utf-8?B?cEd0Z2JFaUZSZ2pObWVQRndkdzBoRjJJK0FvMUlzYVRnQ0NOcG53eGhaQUEz?=
 =?utf-8?B?bUs4QllsU0NTMjNNd1lVYWlremducEhiSnkzNXJhbEJnK2ZnL0c4c1JrcWJB?=
 =?utf-8?B?ZWxGNm5VQ05TVE44ZURKTWZaanRwYjQ5Y2JMd1ZSWHEybWtCZzFjLzRPVUI2?=
 =?utf-8?B?SDFHMlo1SzNja0p2Q2lFQ2VmQ3cyQlJlOCtzQ212bzIxcERJeUQwczhwSXF5?=
 =?utf-8?B?WVIzVEhTbUZnby83SkhDbm1SS1Rnbm1EeWxSMVVhZWdQaURoZEJ2UHFpeTZj?=
 =?utf-8?B?R2xLTjMyd1U3T0Z1K2l5NjZhcVhDUHN6dExqbllJVHQrTVgwdFpQV0kwd3VT?=
 =?utf-8?B?N3BzWEtHdk5OK2pyUmhsaFVkLzZPMXVTLytUMEd3QXQwOTdETGxDUWpRbTZh?=
 =?utf-8?B?VXF3ejdkVXU2OXR4azI1bDlRbzZzZkxIYzdLa3dmMDVmeFdkc3NVWkVCZUND?=
 =?utf-8?B?cytjcVlMdjNBMkhaOWpXYjcrd2NLNzZCc0k0Z0sxRDZlOVhWOW94QWEzNWpF?=
 =?utf-8?B?RFJza1c5bkJocUl1MStlb0xwYTJmcHA2ckNEem9UZjZvMVgrYXV3NmFKSnMw?=
 =?utf-8?B?Vk9WQTlQUjFQTWhzY1BDNVQxa2dDNENFRnY1RlZ4Qm5uamxJVVU5b0NRR2Mv?=
 =?utf-8?B?ZW42ZFpLTTFtMzZNcjVGeEVSNTE4bjkwd1U0YW9EakZYVGFkTGpVSFRid3lD?=
 =?utf-8?B?QW1uaTFJSDFIWE5QOWFVRVBRdTJxeVVuNkMwczcwcUlGQ0lJb0o0a0Z4Nml5?=
 =?utf-8?B?VnU2RkxtekRlaWFaeTl4Q3M0cnZhdXZsTEVCaXUreCtxeG1MSHRXeGdROG91?=
 =?utf-8?B?MEt4ZlBVamMyMEJONUgwRGwrNGFZNEFvQ2ozd1ZzNm1JTmVFcEl4ZzdZN1Ey?=
 =?utf-8?B?TWVCYUtaVEFWQ0xkdUcrNXc2dml1SEU5VDFIR0FtY2IrcE5mMnVicXlUTWN3?=
 =?utf-8?B?YUF4MTNBaHFOZitLYXpzUkZUTWJIYVEwUDBaLzR1eHdTYXFKQkVmbnJlY09P?=
 =?utf-8?B?QzREVzNmelFTdUQ4RDJUQzBaZEdBcjlqYzYrV25NeUd5RDlZV0xOQXFYT1l2?=
 =?utf-8?B?ZDFZT3lOSmE5UVhTd0JHV25hM2s0V3JVQ1YwNnJqWjZnZUlmTzdMbGhXNyth?=
 =?utf-8?B?ZlZJUzVDM0xVSWExc2l4OXJQdjcvK0NuYm84U3BGT0xteWwwRGt5OHNHRmxW?=
 =?utf-8?B?NEN0R2V4bG5qendqSVVPMm5KUjNsMW9yOWMyc21TWkpZSER2c00yek5Da3ln?=
 =?utf-8?B?LzZhTmFYa3JoaEE2RGYwclNGdVVXb3dwYnR5MjdKTVpUdUtoWnNMQUp5bC8r?=
 =?utf-8?B?WEIzcjBTZ20xNHZMb0RuaEZCUTZtME9qTWRTMGd1MytDTks0S000aklUWHZu?=
 =?utf-8?B?V1BOampzOGdtRFY0L3laUlNDcEh3ZEtZZ0lqRktzWFJzeHpmZ1Jud00yMkVY?=
 =?utf-8?B?bkc5SzNudi9jQ0RpNGNPbUZwblZsRlV2SlE2V2xKRmwrZVZ6cy92V1Z2bzQ5?=
 =?utf-8?B?NzdEa3prNkJpUURXZ3pqclduTk1PUW56Rm5MN05RdERaelJJVVRCSFp4Z3kv?=
 =?utf-8?B?YzIyeU5mbHY2cFFXODRPR2JKWmkvL29zNm50MFFJSURGMjFwTkg4c2NDK1FZ?=
 =?utf-8?B?UDUzWXRoK25PNmIvVEVmUGhPYldJWG8wNWtQa1R3bXA5OXlQSEovNGRqZEt0?=
 =?utf-8?B?RG9mcE1tTmoxSlRCcGVBTTBQNVRrdlIwaHJXekFhOXhPbWxhMUVNWmpkMXBO?=
 =?utf-8?B?MXVmc2xjTnJpN3ZYS2pLQ2EycEIyZ0xGa0ovb2k2VGViM3oxR1pIMkU0RzFu?=
 =?utf-8?B?T016OVN0MWpFUDE3YlArN3ZKcjRjL2xCR3FRVlh0ZThpWkhDUGV1KzY3R3BO?=
 =?utf-8?Q?mecurPPKfHMiJG93XZFKzqkbo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be07759b-deae-4999-8b66-08dc272a8295
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:44:31.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njGOXmoH5Uw6idWAIbBCArSdj1KwRPBL+ey1Y97iaNaVYSDxIuFuZW7va2cPgdnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

Hi Claudiu,


On 2/3/2024 9:08 PM, claudiu beznea wrote:
<...>
>> +		for (q = 0, queue = bp->queues; q < bp->num_queues;
>> +		     ++q, ++queue) {
>> +			/* Disable RX queues */
> Operation in this for loop could be moved in the the above IRQ disable
> loop. Have you tried it? are there any issues with it?

OK. I haven't tried it. I will try and update.

> 
>> +			if (bp->caps & MACB_CAPS_QUEUE_DISABLE) {
>> +				queue_writel(queue, RBQP, GEM_RBQP_DISABLE);
>> +			} else {
>> +				/* Tie off RX queues */
>> +				queue_writel(queue, RBQP,
>> +					     lower_32_bits(bp->rx_ring_tieoff_dma));
> I think this should be guarded by:
> #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +				queue_writel(queue, RBQPH,
>> +					     upper_32_bits(bp->rx_ring_tieoff_dma));
>> +			}
>> +		}
>> +		/* Enable Receive engine */
>> +		ctrlmask = macb_readl(bp, NCR);
> Is this needed?

Yes, not needed, we can use earlier value directly.

> 
>> +		ctrlmask |= MACB_BIT(RE);
<...>
-- 
🙏 vineeth

