Return-Path: <linux-kernel+bounces-54948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 756BA84B547
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B5F2868F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C254E134742;
	Tue,  6 Feb 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KiUINPQb"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6A134745;
	Tue,  6 Feb 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222520; cv=fail; b=PC3nJ7hl0LZg5tsgC7smiJuiCXOT3Re4OTx+GqoN0mAFYcw4biQ/lE3oQixLu9Pjq2k84iH2Yj/VHPxS+ussLYa6R6CHr6Mqwy3CbDoITPHwE4zJKRTWeJAbzvG+W1o3AuSgWydxHlOjp1jqR4UKCH6yeNUJJ7OBcTuyW4j/eIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222520; c=relaxed/simple;
	bh=JwXiERbk6hX1VU+bmZ1qsE/S/02NYdI6eCRiLOQaTpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4fX7Zj327S2tPZXkMgaJjH0qReLngWanctfIIKFxTNbMaz951Q1ZrtWCfTXq82NnPhtyFelG9anXzISfqq6OTnD51fuAFb2HTTea2fVElvPX5m2yZYkR6/5thqG2YIiYfhz6cp0XrWTTZlt4UJDIbV4twjgMmj2EUIN9PualY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KiUINPQb; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gf4mNamVmK8RTwZMpIya0PJqY6s70HgOxl0LR1vxAq4XrkpbH1JfT1S5Na7l0dLwfSURYXTTox19C9pH3lA2WEEsiKZf7FTTBy2gXQQT9YbWgs19h3b0lBA4AcwTABXJe5S9nnCgoL98Xve2nS0si2Afq3LVNggFccOr5yHkLvGtGjyrv1gZCRsNjx+0DY4kGBtRX+dHFmmYew/HPR7amaslDij0HHROWWXNv4X7KgD2TgBcHHfv5nBIOkcO/GTetb3o4EavqmZxt1FnE8QKf1AK9sV0ExwzmXeR/FymBepx1SiopTA8mYzQqu9DhyY8vCvzNjfz/S4oiSq/2pUeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRrPYW8x4kU2z6BuVSrJHSsHjs1ztFEIamhS8Le1HLQ=;
 b=XpcKk7M3ViEAjTBBC+rR28gDPr3O8rY78zfVYKvrzgjeA0JRwQSX1wOEm6t8gAnuPO5weQtv1XmoK8VEP9YpndEs30ovIMe+cR14L9Lg0O6E5FO+lMcnwzhNbMel5AucAkxkazKw0pShBEO4KR4S83ilRbILS9YtFBV7OKC46DI3YyIcn3RdhzcH0b53eTk3OIWQkJO2nH/RwNM4uNJXUYQp8m3aERoW164vB0l+fkr/6coVaYHHFM5p29sGJADG+pE0cqo33rkiEH5RLP9+MW/Bd6bLuGhukqrpuouoHjbejIxqIuhJEscLie+UJvlNi7twCTKLU7eMBvsMFlOd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRrPYW8x4kU2z6BuVSrJHSsHjs1ztFEIamhS8Le1HLQ=;
 b=KiUINPQb/TY8LVdtShkf3HNoncSKe27rSZPOHs9qZ9gLOki/bNpBC1p6ji6SiS0bWowA+LXSFtIE0yHGp8xng2T5bygkamksjwHpBdqU7GyXrf4BHJTN1VSu0PmsPIvzubhcDDJ1ex+arFn1HF45Omv79C7TwHxmFBQKDHVuAwxuOGMLx3kelnP3DIjTd7WLB/fmBE46gu2kFskfhzLXPq74g9MLPECzHVTDXm2rxbtL+t+DhNt2ATp+JS+wH9q2eYrGVhZ0jkUmczmKxT6A01a/strd9zhuW1q2QWnDoeep+mm9CwFky+w/qdOSJc+kNPWTdSxJZ+pWKvn71ANClg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Tue, 6 Feb 2024 12:28:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 12:28:32 +0000
Message-ID: <252d6094-b2d6-496d-b28f-93507a193ede@nvidia.com>
Date: Tue, 6 Feb 2024 12:28:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] memory: tegra: Skip SID override from Guest VM
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: treding@nvidia.com, krzysztof.kozlowski@linaro.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 amhetre@nvidia.com, bbasu@nvidia.com
References: <20240206114852.8472-1-sumitg@nvidia.com>
 <86wmrh6b2n.wl-maz@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <86wmrh6b2n.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6ddf0e-4417-49dc-2a79-08dc270f21cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xIm5IP7rhzzLgSBV+F9wTTGaGOtS7sqtIE0D7DoIeyW5aS8Zu73OC7sp1SRwQ6/jtDjEki7/zCChylxqPmWx47CItRRPamkmvOHRJ+K1tqSqwYqA+Y7GLQ0jbENepPbxuKHYbgiRN4rIN6DQJS3JHGh2PzpngkRq0d965B5KD3QbCi/G0YvnnWTRSPtFw9QMi44G/16T9nIgEjWQkEfqBPmL5keB50TMOfKSZEYyhMKdm9Rmi3XdBXWB9ZSm7lhQqTrPJG/M/E6AM8vxjp/rYmOoZHuK8nsYdBJS7F5xboDuLeUInVBIoTy0eLhgeEjjIYciBfDk70W+TnA1Y9zQQSUCsnsn8xz+ML6ZQnCtDkDp92n4m9plJSoY1N6c7zQXMXLE9jfk3WraIFZN5KGjNf+8sXAiqi99byAjXq8CjZxRlM9fFGy6iPLQB/H59LSVeQlOPH/iCKZrTXrZVjQILZ7rqfYyGy0kQR5P+XsIkNAIxQ32b5fcTOKDr7WfnfqYMVUi3T3e8L+vkAgVfH6m8R4PdejFqFsQrRqCXqhkAAm0L9jwtvfBEGtSevUXlsxDkELCDKSZEckxom6+WDpZUVFjH86F4b5FMfq35QOZ9Uo0cB7Ixp98zoy3/n7ljrXR6Q72dljpXvv7IQKS5SWaDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(31686004)(478600001)(31696002)(55236004)(53546011)(6512007)(36756003)(86362001)(6486002)(316002)(107886003)(83380400001)(2616005)(26005)(66946007)(6636002)(8676002)(6666004)(5660300002)(110136005)(6506007)(66476007)(66556008)(38100700002)(2906002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW1FZmY0dGoxdTZjc2FxdndmRUdCV2FOWFVlZ2xJWXVKYUJEWXRKbm42LzJv?=
 =?utf-8?B?SWZoeG9oNXRLTDhPZTd0MHN6b1EvNGJJYzNRVm5mR0JsM0VvUEh5WGFKTkh2?=
 =?utf-8?B?bkV3b1hIYURjMnd1ZHdkYTllYmxxbXVGK2JTWEhFNE5EUC9sZWIvWVNYVHp0?=
 =?utf-8?B?OEorUDAveFdPUlA4ZU1aYjhZWmU0SkxGWWozYXc0b1FCMFpIQmlJS3dNT011?=
 =?utf-8?B?SnpwQlBDNEE2RzlRbnh4cFNyY0ErdUhwdVFnbGk1cnZqZ1lNQ0NGdDZMbitB?=
 =?utf-8?B?Rkc3SE01TXcrTFdLU012Ry9vK1hlUERoODdISGE5RFlPZFBLQTlhUGN5MFU0?=
 =?utf-8?B?WmgvZVlqSHRSN1J1VXN6aSsvOVN6alJzWUxRQ1NjSjkzZy8rdGM0ZWR3bW5P?=
 =?utf-8?B?SnY4ZnFKRVpEZHV0YWVFNkJYRmdTQ0FzY2xzaGFTdG1wTXFxOGFwWHY0dkp0?=
 =?utf-8?B?QTE1YlVoTlZGYnZlVVVSSnpCRmdvUFV6K05QYWNtbTZLOXNhVXh6OTBySHlu?=
 =?utf-8?B?RXlOcFhDa0VWcC96OVhhMTc3bnhLbFB1aGFIdytkMk8vaUhVekt5ak9JWjBM?=
 =?utf-8?B?V3VMRWtENGtxUUxMODlvaUJBbWpSTFFMWFdmZ1BZMGxDVk1McHF5SlFjdnBj?=
 =?utf-8?B?T1VvbjJLWU96Z0NGNE1tT1luNWlYNnRWZGpIYTV5S3dYczZuUWMwV0phVGpm?=
 =?utf-8?B?ZTlGL0d6K1VRRzRWbVE4K3laRDQ3QWlQbXN0bUpVWTIrZ2FJbUZpMkloK09K?=
 =?utf-8?B?L25JZXk5amxTSmZnamxLaVkxS2RpdWNGeEhpMDBXSXM5SnpranB2ZkpvYThz?=
 =?utf-8?B?aUxTNG44ejE2QmlLS1B6VVlDZnpZTkE2R2hJSjZoaGpraXlnWEZYQ3U3c2J3?=
 =?utf-8?B?dFA3TkI5OUVwWnduU0hMOUdwZHM5Q1drWVV1WDUvWXlHNU03WXZ4Vkc3MDdv?=
 =?utf-8?B?WU9EWHVORkxZclMzcmVwVFpjUkljOWI4ckY2aWt2b01WKzdPTEh3NDN4bGNB?=
 =?utf-8?B?WHRVd0NHMHg3U042UGxkV08zcFlMYkw2UHFDNkljM21kYXNvUGpKanJEcmgy?=
 =?utf-8?B?NldTcENjUHJvODNuZ2pocVlyd3ovOUQzcEdNc00rSW5NZW04bDhoTFB3MWNX?=
 =?utf-8?B?K0ZXRnp0ekVKYnBDQlp4aGVSRXlJd1FyeXVYTURWYU0vZUJkOGRjdzZRVTdG?=
 =?utf-8?B?aHdPREdyRzNQeUhWMHh0Q3p2OXV0RTU4T0krMFNRdGlnbEtBWGU1cDZVY2V2?=
 =?utf-8?B?eGpWKzBGZm0xTXVHQXB6K29kUGJjRnVnQnJnSDhMczlEOHBqdGhqc1NvSElI?=
 =?utf-8?B?cUFDMkJKQXVSakZZTG9FTlAydnMxY3htNlpkbmZ0QUhBMUZuTDZOcXBqdjY4?=
 =?utf-8?B?R1pIaW1kTVZuVnJmU21RK1FMM2xNMEdSOG81c2JTSnZpb1NXbngvRHE1OVdx?=
 =?utf-8?B?aVlpcktiMmVyRFl6djgxR3lWWERkbUlJMnlpdXlaRHRseEdncEFhNG5ia01U?=
 =?utf-8?B?T1RXRE1NOWxUYTFlNVE3YXRZNXlNaDdxamtGT0ZhTWFTSWlHZkh5ZUJhdnpO?=
 =?utf-8?B?anZnODU1blBiajFVcUF6aFVuc29LRis2UUN0Vm80RHJTdGhOM2p5VTJjUXpy?=
 =?utf-8?B?RzVSVWIwRkZZSkk3MTlNVWdOL2R2TEVxSEkzWm5XWElzUVNHNWZUTERUWHVX?=
 =?utf-8?B?YWpJY01ZRHJSVk5KN3hud3VxUVNVTXJrWWhXa2ZBeVFBbm5OOFoveUR1MUpL?=
 =?utf-8?B?VEdLM1lPWTN4RTBFVVQyVjdjbnc2UVZFK1RLTFlLQU51OFgyalVQRDNmc2F1?=
 =?utf-8?B?U04rUHRPcHJGNHl4R3FRY01kM2JjUUVaU3RDRFhPL256cHJPSURGOGZ2czZl?=
 =?utf-8?B?MUlja2d4cld2RUtHQnE4UFBROGlDMTNMend0TlhsK2x2dit0ME5iVlFMSFF1?=
 =?utf-8?B?ZHpKQ2s4UEdVTDVXcFMrT3VldWswV1VxbjBsMzF1bys1T0c0RVNEemI0bjlU?=
 =?utf-8?B?UDEvY0paak9KNXRxSiszZDFBQkpYcmZQeGpMNi9oSWQ1czAxdCtiMUlBUzg0?=
 =?utf-8?B?bnZCU3lBYmViYlpLcTJaSUJrSnNqWW5uL0xra2l3OEJYVllmblkzU3IzQmNz?=
 =?utf-8?Q?ies3CICjWQPytwJ9cqv4TcdLG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6ddf0e-4417-49dc-2a79-08dc270f21cd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:28:32.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6z4upQ1aon0Bz5vQy4NJSPzjJcr56bHdQgIoOYx+U0U1rDxIEwFROJYjtgTlWChBcWbBArFTulIosB2N2DRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

Hi Marc,

On 06/02/2024 12:17, Marc Zyngier wrote:
> Hi Sumit,
> 
> On Tue, 06 Feb 2024 11:48:52 +0000,
> Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> MC SID register access is restricted for Guest VM.
>> So, skip the SID override programming from the Guest VM.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/memory/tegra/tegra186.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>> index 1b3183951bfe..df441896b69d 100644
>> --- a/drivers/memory/tegra/tegra186.c
>> +++ b/drivers/memory/tegra/tegra186.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>> +#include <asm/virt.h>
>>   
>>   #include <soc/tegra/mc.h>
>>   
>> @@ -118,6 +119,11 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>>   	unsigned int i, index = 0;
>>   	u32 sid;
>>   
>> +	if (!is_kernel_in_hyp_mode()) {
>> +		dev_dbg(mc->dev, "Register access not allowed\n");
>> +		return 0;
>> +	}
>> +
>>   	if (!tegra_dev_iommu_get_stream_id(dev, &sid))
>>   		return 0;
>>   
>> @@ -146,6 +152,11 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
>>   #if IS_ENABLED(CONFIG_IOMMU_API)
>>   	unsigned int i;
>>   
>> +	if (!is_kernel_in_hyp_mode()) {
>> +		dev_dbg(mc->dev, "Register access not allowed\n");
>> +		return 0;
>> +	}
>> +
>>   	for (i = 0; i < mc->soc->num_clients; i++) {
>>   		const struct tegra_mc_client *client = &mc->soc->clients[i];
>>   
> 
> This doesn't look right. Multiple reasons:
> 
> - This helper really has nothing to do in a driver. This is
>    architectural stuff that is not intended for use outside of arch
>    core code.

We see a few other drivers using this ...

drivers/perf/arm_pmuv3.c
drivers/clocksource/arm_arch_timer.c
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
drivers/hwtracing/coresight/coresight-etm4x-core.c
drivers/hwtracing/coresight/coresight-etm4x-core.c
drivers/irqchip/irq-apple-aic.c

We were looking for a way to determine if the OS is a guest OS or not. 
However, I can see that this is a ARM64 specific API and so probably the 
above are only compiled for ARM64. Interestingly, the AMD driver 
implements the following ...

static inline bool is_virtual_machine(void)
{
#if defined(CONFIG_X86)
         return boot_cpu_has(X86_FEATURE_HYPERVISOR);
#elif defined(CONFIG_ARM64)
         return !is_kernel_in_hyp_mode();
#else
         return false;
#endif
}

> - My own tegra186 HW doesn't have VHE, since it is ARMv8.0, and this
>    helper will always return 'false'. How could this result in
>    something that still works? Can I get a free CPU upgrade?

I thought this API just checks to see if we are in EL2?

> - If you assign this device to a VM and that the hypervisor doesn't
>    correctly virtualise it, then it is a different device and you
>    should simply advertise it something else. Or even better, fix your
>    hypervisor.

Sumit can add some more details on why we don't completely disable the 
device for guest OSs.

Jon

-- 
nvpublic

