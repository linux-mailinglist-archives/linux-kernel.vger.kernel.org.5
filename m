Return-Path: <linux-kernel+bounces-147050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40B8A6EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E51E1C220E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31A12EBD7;
	Tue, 16 Apr 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O1wqLQPS"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A82E84FBA;
	Tue, 16 Apr 2024 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278768; cv=fail; b=h7vtSs0gCyUAvaBajYfmJ6JoERLQVDM+WqFBrUekPmxxzsSSrB3HH1yxb+2i84qF6FNJlDQCvHvqoHq8v/XIpOQ6AePeGRM9r7usLgMBXYSOEun0Km8hNwr2g/MKLVb0H+6cVO8Zygv+hbYnCB2c+vP8A3TU740aUBQ3peV35Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278768; c=relaxed/simple;
	bh=EOcBsUPZZIQNRRT0rmHRU/lARFx0iaXTfOdep0glS4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PuOF0z1U/A9Z8z9vBOpl5Td35kymsbc2QABli5w6WWS0aioLmfOJgWMh6aOdZKIn7ILxBLPkRILthimaasJBMQs5rfQT8GrS9mXZY5bQRh+lZzXgHvf4M1XJP0R8hJbmsC5wB3hsYNsfoaf0wspUKT9VFD+BwnxP0JE/mbJdbBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O1wqLQPS; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3kuiL0fgnxNh51LojTYQzav7JYnnjTVJTnjUBnWOLZ+likrf1QhdaLcfrSb+a/yJwpTab1YL508IQbSNGQBF4JIB/k6OqDJrT5Lk93bPMWaNEUeSfC9+yz/+L99E1WcVF44VbhBHfRFvoMq5XpBEJKiuW1klI81UHAYFou1s14jTNh/0wmGRq0AH4cHx2tSEY9Z6VDNkq4jiQNiRxTLbpUDkZVOklzBuo3coaZJQnrbd5YWH8UWsVPPEg2WaO3xuMAiVeDHPCAGdNsUk1krlvKud/G/ISCuK9u8lgGEy3/Sw5iYnqjRjZOyy5S78Vqq6p1RmRYekftwkE/3QKSo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+Kk755NpGvMOMSIDPoP7AoJfeuTiaRZvR1Rm0yBemc=;
 b=UJgnuoqVN6LQqf5Zs9mJ7Xo+7SN2xq4RmB21VrNbN+7JJSvlxDQ3pCdFFRAXvjnv64XzYhldJ93zZhzNtlXKVcXnz1FdnNg3O5ZCzej5R1eAd1qAzk4BtE5p1b7QTZB0hS8WxpeOw2lSl4vmpiBvwJhKDyBtrKkxO/pqjvdAwlxGp4dAftnemdnExrWxsoVZoHd/373tdAVG/e4MPsJGvpvccDN9sStPN9T6/3/7ZhknVvHpaJ+1rSoNPI+AYG3+sH7GjlRtPvGGTnJQa0b73f6gUTNblbZMoMqZs1QxfybzNH/dhwPm/iWGoqvf5pNPSkVvaqwyICGhKq78z1gPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+Kk755NpGvMOMSIDPoP7AoJfeuTiaRZvR1Rm0yBemc=;
 b=O1wqLQPSEtLLBL6DqO4RR5bZm9IgMMSR+tA2o8qqFBsp8j7rLC0Yw72hvRaibHWLt3VDG9795KfJZjp7nwPNhn63Rv+6gNUV62de55KqOPxq0xyG2fZo9E2CZDPZbos4ipHYGzodICwll4Q2Cc207eWKE/xi9UKg6W5+FBwT5n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:46:01 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::815d:4ebf:44b4:6edb%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:46:01 +0000
Message-ID: <91ddd182-cc71-480f-a1b2-e7c31b29a549@amd.com>
Date: Tue, 16 Apr 2024 09:46:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error for
 CXL root port
To: "Li, Ming" <ming4.li@intel.com>, dan.j.williams@intel.com,
 rrichter@amd.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-4-ming4.li@intel.com>
 <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
 <b4a721c2-567d-4ab3-8a85-963e3f323e61@intel.com>
Content-Language: en-US
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <b4a721c2-567d-4ab3-8a85-963e3f323e61@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:805:f2::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9801c420-d806-4da4-913b-08dc5e23ef77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LX6F47pPtjkPsTeehR3AG9Jn6Nw3C3LXEkllp6gZ8MQjW3151uA2kr2EqNxxmiAv2P7W0IYeKdCweWogB91HgA9jSF64Tr1Bsu8uLSXVwwJAVPpwUTTesR2ocCfUTVcjiUHymEE0STIM9cY3ZF2QfX/S6jmvWPPrHOXyu9lG7cULe9X7B/7Sc3ut/ppl2mybG8Hk1yY5ugOSIaE5LNbB5UOx6Ls3wU+8sJZJ4xFLXmvOJVpfQoeLyg2l93ypgCJGZV190bb4BqZNVu4sigTOe4YNc/9Ff9muHW6Zbvl6m6LxX8qfLkJIqR+g5WkS322plwVJBfN9Yd4FY6xHnGJKN0aRSIuxEa0gh+S35PKHRNltFFOYy9uOpxy8eru9aW5LWQL4LAMUL7lKQKXz7YZSBSeoLFnNGCYQvBa5zU/v0a4xv3KA73rKZdss8wJ7dZpuP7hApRDq9z/2IenTSs+oOejprEI0xgiqFsHS7v3gOcJM9OKnWEFZFJz606XSQq+z7CSk6dnvVeyqY01ouDdeUHXbyaucYdAroHLRCWiLkOO8KuW2NzwBWLRZWyuIyxLyylUX3PwH/hJJJGkQNXNfP6i+SRZ7jlHoqqZRCSUt+uLXUzO2rvuoCsi2uZhwcJk5eDOyImtcOnRXvftY6neC9tBQjQAOK2ZmxWXwioAmGP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2FiQkZPNmpHRTFXUVY1WGwxWmsyVS9BMENaNDdmdWFSZWQ3MmpzTkNpV0pV?=
 =?utf-8?B?VzFsQWRibldUdG54QXowNCtzZ2UxR3h1RncxejdveUIxUGhRVHhCWkVXUlJy?=
 =?utf-8?B?MDZyQVhHWVRhbldHekRMRnppbmVOVmYwV0hTNysraktNWXRUR1dNT3pvWHd2?=
 =?utf-8?B?UUh4emd4Rk94WXdZM21VWWhQM3VyMzFMVXVEVHRLU0VCUFN4S3VyNDBCQ25m?=
 =?utf-8?B?TG5KOGptNGhwMmFxbUtYNVZGYVdtSzZldlZBdUtlR29taE00OURkWTR0U250?=
 =?utf-8?B?a2Z2citWUlp0bkludmtMRWZZeEZZdmdyakJWeDNvOGpXaFV1dzJ0dTkxNm8z?=
 =?utf-8?B?K01ZWG9uMHNJRlNVa3lnZVZCYldQRG1CQytBNVdWTFRTYkR2Vk1YWnBlSmJU?=
 =?utf-8?B?Qmg3a0lEZElpK3JpNDMzMnBrYXd4NmRsUDdORGNNOTVpeUl6cjhNWVJaOHNQ?=
 =?utf-8?B?dEF2cUNldlhvRndTbVU2OTQxdTMwZU5abmRJZHQvQ2dBM1MrVlFnS3lIZHNT?=
 =?utf-8?B?WGc2d3VRL0ZYMlR1OHBCemsxM0tFMFFmRW9qUGZhemxDWkVTeEx2aUxaK3Ew?=
 =?utf-8?B?YmV4TDRySzdlMzZzczZ4UkVUNTUzSU1nK2l2UHJCSDE0YWwvQmRpWWVnUVNp?=
 =?utf-8?B?TDhaMHhGYzZTYUhvRm5zK2s2NG11ejdOWTIxRzdQS2srNWpXV2VMWE9ZUllk?=
 =?utf-8?B?Q1Q1V3EvRGc0U25Yb2NjZEljODlIQmc3dXh3SmtmdkZLUGNja1FOUnlLL0oz?=
 =?utf-8?B?VjBkZTlJL2picUdDZ0lLL1BwRFUvN2F0bGtkaGdhR2NYcjBBRE5iaTd6eXNp?=
 =?utf-8?B?SWVIc1VJN0lvc1I3RkN4VEVMQlppdXFNcHZZelRTbjJnTWQ4Skt4WmNhckFq?=
 =?utf-8?B?VXphRzBmZHBCN0drVzE0OWdLbVhaR3g1SFRibW5mbWR5eGlPVjh3QUlxRXJh?=
 =?utf-8?B?TmpkcFJpOU1pVWRzV1BEbHdrbWI5dzY3eDRGMXJzVXl5aVU2RlhrYkJ0dyt1?=
 =?utf-8?B?WkRqalR2QmJkL28wbjNjakpsNThva0Z2eWQwQWJHNzEySjRsYk12NmRMRkwy?=
 =?utf-8?B?bWcxYlNXWE9rd3llS2tXUjFtRnVUWXp5N3RDV3NzRWlSK08zWTArc1dIcmxv?=
 =?utf-8?B?WllEQ0NTOEU3YzV3VjVVWGgwM0dQQzIwdlY4SUpVZzBPQmR2SEViVHVLdzJU?=
 =?utf-8?B?T0FGSmszeHo3Q0dIS2o5dnhkcHAwb3RxV0FVV2owK0diOGhOeGk1MUdETy9s?=
 =?utf-8?B?UHl2eUl5RFNGd1BYeThwREkzVzFpU3B2SEx6ODJTMk5uWTNKNENRN2MwMVBU?=
 =?utf-8?B?U0NYZGVQa0l0WFIyZjhEVTlWMXk4eTdzRmNjY2huOTJjenhCbXhBaE14c3U3?=
 =?utf-8?B?UHRhdmlybjZuaDlBZ0RaZTl5ZmlJK3FGK2ZySURQOVVhWE1saXpYR3dmRHVm?=
 =?utf-8?B?dG9lVXc3TVRUQnpELzVVdU9HRHlrMjRjNldBR1hYMUgxWnlxbndwYUdQT3Ry?=
 =?utf-8?B?c1JjYi9YOEl5aW13djMrNnptNFFXWnF5ZUNwdGhla1VOdjMwcEVxSGF5K29E?=
 =?utf-8?B?dnZNWFc0RHBuc015aXNrTWY5bGJwZDYvZmpFU2JLY0VtR1FwMlgzanJPWlZV?=
 =?utf-8?B?T3VPL1IycmFrVFIxTXdROFRxbDMzbGtwRWh3dWd1VVhjWkhCMW45Z3piaFFh?=
 =?utf-8?B?dnJqYXpDbmVaYXl5OWlzRGdUdHFDM2o4L2xMQURvRm55YmtLWnNMZnkwZEtS?=
 =?utf-8?B?NVFxWmRTRGwwZ2djamZ6WU1ka0xVZkUvZ0c3RkFJR1NyT1JxMHpQNnRUejJx?=
 =?utf-8?B?TXZiMFlzNjlqR3NOVVord1YreGJSWjdoNlRvTU14aXN0am5LQUNnZEhpRFhi?=
 =?utf-8?B?QVNhK0s4RjZUcmdkRHdnbVFzd21JdGc3c09WQ1FLVXBtVHB2Y2p6bkdkdGlH?=
 =?utf-8?B?YVNwaW9lcWJJa0hGbUdzT3o2ZzlaWEs5N1dVODE1bzdwZmF0SkMrNHJTVktn?=
 =?utf-8?B?U1hGYXQrdkxyRXJMVUR1VmxoVHhBOXc1UndsbFR4Sk11L094cStFWnlPc1cy?=
 =?utf-8?B?eHE3M1ZjZElYVjJOZEY1STMrRlJhWGlrRzkvSDQ1Skd0VE9ad2VkQkxaejRz?=
 =?utf-8?Q?Qz4e+f0Xe7nbBiuY7fiUkpEs/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9801c420-d806-4da4-913b-08dc5e23ef77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:46:01.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9PvMoB4R6qZTogyEAq4Pie93ba+941p0eLVLz0vFGZN50A3FJU1hvu7WLhf9bifrLvh2OXS4NcpKQGgh7n6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

Hi Ming,

On 4/16/24 02:27, Li, Ming wrote:
> On 3/26/2024 3:42 AM, Terry Bowman wrote:
>> Hi Li, 
>>
>> I added comments below.
>>
>> On 3/13/24 03:35, Li Ming wrote:
>>> Per CXl r3.1 section 12.2.2, CXL.cachemem protocol erros detected by CXL
>>> root port could be logged in RCEC AER Extended Capability as
>>> PCI_ERR_UNC_INTN or PCI_ERR_COR_INTERNAL. Unmask these errors for that
>>> case.
>>>
>>> Signed-off-by: Li Ming <ming4.li@intel.com>
>>> ---
>>>  drivers/pci/pcie/aer.c | 24 +++++++++++++++++-------
>>>  1 file changed, 17 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index 42a3bd35a3e1..364c74e47273 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -985,7 +985,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>  {
>>>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>>  
>>> -	return (pcie_ports_native || host->native_aer);
>>> +	return (pcie_ports_native || host->native_aer) && host->is_cxl;
>>>  }
>>>  
>>>  static bool is_internal_error(struct aer_err_info *info)
>>> @@ -1041,8 +1041,13 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>  {
>>>  	bool *handles_cxl = data;
>>>  
>>> -	if (!*handles_cxl)
>>> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
>>> +	if (!*handles_cxl && cxl_error_is_native(dev)) {
>>> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END &&
>>> +		    dev->rcec && is_cxl_mem_dev(dev))
>>> +			*handles_cxl = true;
>>> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>>> +			*handles_cxl = true;
>>> +	}
>> I understand a root port can be found under an RCEC. It's possible. But, does the downstream 
>> root port forward AER to the upstream RCEC? My understanding is AER is handled and processed
>> at the first root port/RCEC upstream from the device/RCH/USP/DSP.
>>  
>> Regards,
>> Terry
>>
> 
> CXL r3.1 section 12.2.2 mentions this:
> 
> "If the CXL.cachemem protocol errors detected by a CXL root port are logged as
> CIEs or UIEs in an RCEC’s AER Extended Capability, it is recommended that the System
> Firmware populate an RDPAS record (see Section 9.18.1.5) to establish the association
> between the RCEC and the root port."
> 
> I think it means that CXL root port is possible to forward its AER to RCEC.
> 
> Thanks
> Ming
> 

Thanks for pointing to spec details. 

In testing here, we used root port as agent to consume root port CXL protocol errors.
The logic to handle the root port errors requires little to no AER driver changes.
This results in a root port consuming VH protocol errors and RCEC consuming RCD 
protocol errors. The RCEC and root port both use the PCIe port bus driver's AER service
driver in separate instances for RCEC-RCD and root-port-VH.

The driver support is much simpler if RCEC does not handle VH protocol errors. Is there 
a reason to forward root port VH mode protocol errors to an RCEC rather than consume 
in the root port's AER driver and forward to CXL error handler? 

Regards,
Terry

>>>  
>>>  	/* Non-zero terminates iteration */
>>>  	return *handles_cxl;
>>> @@ -1054,13 +1059,18 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>>>  
>>>  	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>>>  	    pcie_aer_is_native(rcec))
>>> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>>> +		pcie_walk_rcec_all(rcec, handles_cxl_error_iter, &handles_cxl);
>>>  
>>>  	return handles_cxl;
>>>  }
>>>  
>>> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>> +static void cxl_enable_rcec(struct pci_dev *rcec)
>>>  {
>>> +	/*
>>> +	 * Enable RCEC's internal error report for two cases:
>>> +	 * 1. RCiEP detected CXL.cachemem protocol errors
>>> +	 * 2. CXL root port detected CXL.cachemem protocol errors.
>>> +	 */
>>>  	if (!handles_cxl_errors(rcec))
>>>  		return;
>>>  
>>> @@ -1069,7 +1079,7 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>>  }
>>>  
>>>  #else
>>> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>>> +static inline void cxl_enable_rcec(struct pci_dev *dev) { }
>>>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>>>  					struct aer_err_info *info) { }
>>>  #endif
>>> @@ -1494,7 +1504,7 @@ static int aer_probe(struct pcie_device *dev)
>>>  		return status;
>>>  	}
>>>  
>>> -	cxl_rch_enable_rcec(port);
>>> +	cxl_enable_rcec(port);
>>>  	aer_enable_rootport(rpc);
>>>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>>>  	return 0;
> 

