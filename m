Return-Path: <linux-kernel+bounces-95080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047B8748FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF3A1C21E79
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB26312B;
	Thu,  7 Mar 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHOMKb59"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6163114;
	Thu,  7 Mar 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797573; cv=fail; b=BrcHeblsBzFBafTYHvcSqmA+7GUx6cDQbkaLDKFpj8vxFUJOpUlIRZJw/96fWzytJbgIhkc0/2PKWeWNIvUXsbLsGp7EV+DrmAyGdZ230h/UnQJ66WePHZ+asdTD+5JtuLgf6Fion11drGL/x41uwkcRSmnXKWa7LTmkOScbesw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797573; c=relaxed/simple;
	bh=sIp1lpJKssskvjO3BT8EYPyq/VPCu0B47Ff5EAki67M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtxeYIDnsbvu+p44r2Xpn+0hzWGMcpJdh+9D1aUJ8sVZCX17f73gLiY1W17MrpBjXDyFtmyQ6rURPCrX13bINOOqPXGhoanYadEqLDlNpy7Dp2GPD+b/BLyPfLo4DO6iZsStvfe2loS+7+/t+0WGoQuXAQE6lzC86Zbk2KKoIsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHOMKb59; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH687yvxhTE27yPlWLTLshAABH3UuOcAS4+g1V+ybA1fuInPQkKo/ECmcjrEpL1JzBkWHSBOxXSKTgjM4MaHyBQ3xG7ieit7VFO4m+gtngCv0F3Sxbc9+Cej+4/hiTrKzsMAktcS5X3lpY27YY6W1vg7/Dwqei5mtNI+n0rQj2TNmslf3Hh9jfP7RrT4BHpVfMdtM3qhZxdToBOKEVwlVs8J9L9aCBMtuAu0mrlI3Nz76SAcSuplkj+D2nFubVIQufmej88zqb1FmmpzUM5OS/O1mpoF0uA6R1ELjdN+bcVXL/STkhF+4pAhooIOrTCOdhK4559XXlWgEjvGzVRDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU3uGck14ed8FNMhIZisTzPYioytTXsiwlLztU2xrhQ=;
 b=lb/kexft6LFXmcSTo0SkfLp4DUa6bG1aq4BTT0aZF/2+Q64r+CFE0+zsmtcDW4In86Nal1NMHsvVUZwVc+1fQiuwt3hoWYV+kO9/c/r3azfwMofskCOcFA/IfD0j0Os+snHxLHqa/JFCVaMJ44/u6/bQP60mnq6sDR633orNYAdp68s5TvW+RaJuxE0HebFeC2YXa3ApVQvTugk1s6zZzNyfhb1nIt2e53U1L1NrqncFdRdBqJbixCqLpYoDkPhnzWM4cYmR/Z5YNhR65ob4Dr0QbDPyvJ7fo4BWIRLuuWLTltU7XKN+dKXVkwfpyHAYgeNj+8iA7JnIVMamD3umfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU3uGck14ed8FNMhIZisTzPYioytTXsiwlLztU2xrhQ=;
 b=aHOMKb59+qM2/548EAA+O2hX4jz7WnyGWsocE0arB7FbgsEonN/tNUXZATY7RBch+EIM8lCEUn32x7+XHxpYHUoW5/3glKa78Q+5OqTYlw7VixuliM2VBNJEBLz+QtwYxyO5QoIZLoRRSoFW3v2anrkSfeOE0WK37io3gf9Qmhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 07:46:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 07:46:08 +0000
Message-ID: <5e87b406-3301-410b-a479-d561d5b19f62@amd.com>
Date: Thu, 7 Mar 2024 08:45:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
 DWC3 controller
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20240223224940.y34qflo2azxrvksy@synopsys.com>
 <20240223230758.s7rodlxbsfa44frw@synopsys.com>
 <MN0PR12MB5953B24F0CB175D8C167E73FB7592@MN0PR12MB5953.namprd12.prod.outlook.com>
 <20240307014402.omtcsltp4pxpraf7@synopsys.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240307014402.omtcsltp4pxpraf7@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0266.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ea57e0-2ba2-4f27-749f-08dc3e7aa668
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/PQ+vGcgLXmV8N+hOYSsRktGP0sgUSorQIvdAxk7LVfGFov9yWx41eMDzZmgFulR6jR2PqI3L+q44TKeOLWSQ0MLQ/HfrOvrdtxDTvOYhcetj2HeuI5BjxyS5VB5Q/C2WCsXwqVnm4KFapSx5A2bLhN5UNFgr7rQqD7FR/10l2SY8AsyCfHQPyk8nKZEYYoJVDPjGE9kXGi1eKWiu48k5fX6QCiRPHG0cZ3ZVaT4Mwq+YlSZsbnVIIzDiGi8hM3yKWhjOdrAAWHFrwlsz5OfqPyJ8RjKSbgSo8y5OPPi5kEoNHvGGwlIxPl3I4/N4mft0EN8tBwv/taN8IZ58E7V3YwLjdbF9sIPFq3qquyAm7MXTzAlPWmdAu0WBTnSOVKvIep45cYGSmnrXHb/JnnzwZ9iWDG9qn8EPJJ7rX6OdVJMywBuP6s8rfcsZnBgx5kjNXYrX84GiYi9qp6Ld/rXoIBT3d3cnyJ6JDb1Wgd2FXOHHGSsZjAr7CQwJnQbu4a5Ci1PgafF1QlT1v4c2tLyQobXtLPXyWd6eYywkJ2vnE8wR+F+OiKdT31uXBLArrbM26boOXMG8U3KMaEXVE20MDkXI47SdLjLfZOiVL3oEfCNS7HpHHpfMriT1srp89fgCn2PrcixlxksKh4G782CcI8WlVz4KbVeLa23BtTjPS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpTcjIvZStWNW9NeUUrNUdWWkRhZHp1dGcwNHgxVklPZWJWQVVYdjZlR3FP?=
 =?utf-8?B?eU5oOWtXTFdlNUNBanpwT0ZxNm16eFhzL3BEUzZHdW9WVlQxbXE3aHFRaFFW?=
 =?utf-8?B?d2VKVFhWU3ZHMVkvcE5tZkdlNGpVd1FYK1lablpYVDdmeXA0dkpubkVsajAv?=
 =?utf-8?B?d1RiOXV4eC81Y25DSzhKbTY1OStaZ3dCeitFQjJ0T2Y3aDQyWXNqeDJianZ3?=
 =?utf-8?B?Ui9qTERnT2Q1a2ZkNThHVFJYYTh1SDFFZGZpdlZNeldpdmR2RzNneEhwb1RC?=
 =?utf-8?B?NFYrVkhBdEp4alB6bG9BdTZLL3JGMUx3bTdyeE9YNDhoa3p3bGozd2FvT0cz?=
 =?utf-8?B?WkFUNzJkOHM0NkFoRXJQc3pEek9ZT3ZRUzVwckhPT1J5bW9XY2tRNnRITTM5?=
 =?utf-8?B?OXJrcEwyUDBYN20xYVJlOHFROFZnTU1sdnRkN0dSMGFEOTBpdExLS3dURWRj?=
 =?utf-8?B?RUMzYnZrTWZ5QjIrSXhpZGdSaEVYY3VNL256ZEdxVEdwR1ErakNYbFNRMSt3?=
 =?utf-8?B?ZWxLTzhLcmoxc1VwTjRQV09LNklMUmtabGY4b24xdjk2Tm4xa2hMTkNvcElU?=
 =?utf-8?B?eEZuVmxOM0VwYTU1bFp1Q3JSVldJRjRLUnpDZWhiQ3JQWURDam5PZ28yNXEv?=
 =?utf-8?B?N20zdWQ0elpFWTIzZ1JCUHQxQ1RwMlZMQmRVdWFLTVh1b3RpL1ZBWktOUDFr?=
 =?utf-8?B?aExQMlRRVEcwK0hrMlFUQnFiZldESmwyUWNmNTdHcVF2N3RKbXIxRFlxc0xU?=
 =?utf-8?B?MmVaNm9ndngxSE9ma0ppSWRaamlDbnhMbkt5TWF1OFdKL0pXK0gxeG5vVTdx?=
 =?utf-8?B?MEx1SVJDc24xU0RBSG5nSndiaDBRR1B6Yy8rUXRWUGQrSGFldEltV2NNL0My?=
 =?utf-8?B?Y1ovRlRYdk1tY2trSjFWUlVreDJ0b2dyMG15bVJMWU1vTlBYQnJGTHk4ZVpo?=
 =?utf-8?B?V2hjTk0yTU9lMXE1NEp0UEVlQit2cnI1dDJRLzU3UlBhUnhqWGMweFd5dHlt?=
 =?utf-8?B?c0M3NFo5eElWMzBxZ1RLZ3duY0ppejY1cWc3Q3RQWVVCY1drZ1c2b2Z6eS81?=
 =?utf-8?B?QmhITXJialJhUkhFbGd2QkJZbTlYdDJrL0RPT2tGWkxSVkhEVHpiWnFndkww?=
 =?utf-8?B?T3lrWG1uVm56Nk9LaUdScmJEVDNPZjJyV0txd25YL2pEdXpGMXpNZTJ5OUw2?=
 =?utf-8?B?WGIxakhoTnIrVm1JT01Pei9rRitwRkdrdXlGbXhsSkJ4bHRNQjlLVmlDNjJl?=
 =?utf-8?B?N1p3Y3VkTUpUQXp5M2lacXBlNndyejd1cklRak5HQ2RNME94OWpvOGN6YUxQ?=
 =?utf-8?B?ZzFBd1ZMQWszOVNpYUtqM2RIVWJpeU5LMFBTcnVzU3JSVFlTTGJYL2w1U25Y?=
 =?utf-8?B?MU9SeDB5WHZsaUJIOWFrRmEzNWlhUThpWUVpdmUyb0lpL2xSdWw0SkI2OXRE?=
 =?utf-8?B?VWZZWVlPMU1ZU1pyOE9CUDZhS3VlYmZRSDZUb2xhVkUrK3BJdmZmdkEySmNR?=
 =?utf-8?B?amZOK3V4ZGxRTmVmY0gySm1HVzRudWFOaE1mRnNnUXBVLzdNUlZwMHZsYjVB?=
 =?utf-8?B?eTVLSllXRndwRnlUc2dCZCtlWEVXNDRFb29aTndibGJvT21sVkwxeEVEQnFG?=
 =?utf-8?B?YzNXVVgvVzdGOEQzZUp3cmF3UVJvSEtic2JjcnJucjlFUEw1MVdPLy9FSzNV?=
 =?utf-8?B?UGg0R1p1NUNRZmV2Y1MvUUdmSnJwd2V6MVZXS2duQzYxNjEvYllpU0ViRmVV?=
 =?utf-8?B?ZWxSSnd3cEdnV3U3ZjhkVTU1RWRpMHJzSVhMRXA2azU5cUJtN1p2ejR5OVQw?=
 =?utf-8?B?N0p5OFRxSXlMVGZZUVJ3UGVTZGZIVDZoSERHa3hsQVgxa1J3Sk9tODFiSCtC?=
 =?utf-8?B?YlBqYjZXZlRmcnV2ZXlheTdzOHV6UzM5RVFCVm9saTN0a1VSSlNLU2ZWODVs?=
 =?utf-8?B?R1FzblUvUHlBSG8rSXZ6YXJQQXg1NWd4dUpIdWtteUVlZk9hdEprY3FFb29J?=
 =?utf-8?B?VXN0NFFPeTBXdjhFUFFzam5aWVJJaENBZTNUK28wbFcxRlhlNWpaTkovQnZl?=
 =?utf-8?B?dGxJZEVaQUpnVDBjM0ZSMk9QVHA2eDZrdHQxRDF3bWVpb29wOWxvK2hRTWlz?=
 =?utf-8?Q?Xg3R5PuuIoBsuj3CoQnamC+w3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ea57e0-2ba2-4f27-749f-08dc3e7aa668
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 07:46:08.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9O1XoMJ0CsHqtX2CEF4v2sWGDdsQZ6WCa5W+8K/G5UB0ER9LmXBmaV9TGoZpFeIR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360



On 3/7/24 02:44, Thinh Nguyen wrote:
> Hi,
> 
> On Tue, Feb 27, 2024, Pandey, Radhey Shyam wrote:
>>> -----Original Message-----
>>> From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>> Sent: Saturday, February 24, 2024 4:38 AM
>>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
>>> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
>>> Subject: Re: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx
>>> DWC3 controller
>>>
>>> On Fri, Feb 23, 2024, Thinh Nguyen wrote:
>>>> On Sat, Feb 24, 2024, Radhey Shyam Pandey wrote:
>>>>> From: Piyush Mehta <piyush.mehta@amd.com>
>>>>>
>>>>> The GSBUSCFG0 register bits [31:16] are used to configure the cache type
>>>>> settings of the descriptor and data write/read transfers (Cacheable,
>>>>> Bufferable/ Posted). When CCI is enabled in the design, DWC3 core
>>> GSBUSCFG0
>>>>> cache bits must be updated to support CCI enabled transfers in USB.
>>>>>
>>>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>>>> Signed-off-by: Radhey Shyam Pandey
>>> <radhey.shyam.pandey@amd.com>
>>>>> ----
>>>>> changes for v2:
>>>>> Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
>>>>> Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
>>>>> add support for realtek SoCs custom's global register start address")
>>>
>>> Regarding that change from Realtek, it's a special case. I want to avoid
>>> doing platform specific checks in the core.c if possible. Eventually, I
>>> want to move that logic from Realtek to its glue driver.
>>>
>>> BR,
>>> Thinh
>> Thanks. As you suggested I tried "temporarily memory map and update this
>> register in your Xilinx glue driver. Its value should retain after soft reset".
>>
>> Did ioremap for core register space once again in glue driver but it resulted
>> in below error:
>> dwc3 fe200000.usb: can't request region for resource [mem 0xfe200000-0xfe23ffff]
>> dwc3-xilinx ff9d0000.usb: error -EBUSY: failed to map DWC3 registers
>>
>> So to avoid remapping, now get the struct dwc3 platform data handle in glue
>> driver and pass it to dwc3_readl/writel() like the below sequence. Is that fine?
>> If yes I will respin v3 with these changes and also do some more
>> sanity tests.
>>
>> drivers/usb/dwc3/dwc3-xilinx.c
>> #include "io.h"
>>
>> <snip>
>> ret = of_platform_populate(np, NULL, NULL, dev);
>> if (ret) {
>> 	dev_err(dev, "failed to register dwc3 core - %d\n", ret);
>>      goto err_clk_put;
>> }
>>
>> dwc3_np = of_get_compatible_child(np, "snps,dwc3");
>> priv_data->dwc3 = of_find_device_by_node(dwc3_np);
>> dwc = platform_get_drvdata(priv_data->dwc3);
>> if (of_dma_is_coherent(dev->of_node)) {
>> 	reg = dwc3_readl(dwc->regs , DWC3_GSBUSCFG0);
>> 	reg |= DWC3_GSBUSCFG0_DATRDREQINFO_MASK |
>>                DWC3_GSBUSCFG0_DESRDREQINFO_MASK |
>>                DWC3_GSBUSCFG0_DATWRREQINFO_MASK |
>>                DWC3_GSBUSCFG0_DESWRREQINFO_MASK;
> 
> It's a bit odd to use "mask" as value instead of some defined
> macros/values.
> 
>> 	dwc3_writel(dwc->regs , DWC3_GSBUSCFG0, reg);
>> }
>>
> 
> Perhaps it may be better to add a new interface for the core to interact
> with the glue drivers. The core can use these callbacks to properly set
> platform specific configuration at specified sequence of the controller
> initialization. It will be better defined and more predictable than what
> we have here. What do you think?

Not sure I fully understand what you mean by more predictable.
Are you asking for simple read/write interface to dwc3 core IP?
Do you want there any limitation for accesses to be able to control it?

I don't think we have any issue with your suggestion but it is unclear how 
exactly it should look like.
Can you please sketch it?

Thanks,
Michal

