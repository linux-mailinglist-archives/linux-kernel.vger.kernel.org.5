Return-Path: <linux-kernel+bounces-71398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8136585A48F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CD81F227A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953D73613C;
	Mon, 19 Feb 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dh0CAbGp"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE536122;
	Mon, 19 Feb 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348925; cv=fail; b=bytWxRlh3/gD+JBpBvYO7273am5fycn/vrm2aQ3zCmaAQc5V/ZtwGkewvjw9T6b/wxr1ZRRPm75MKYgphkCu2hjGf3KPVlaDm0rd8oq3DMUrv1/mPlDl7/WMoDyAEbtrq6yx+T+ZDmbKkjxbQuFcHQpXDnrWfuhqeop3YFvbXj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348925; c=relaxed/simple;
	bh=sPiPuSZa4iDqYsuu+W+CXM+KJhyLdnDrOj5oSHiM4fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H65MOeqqgOMvZ252ye1djPtnMvSaFHSae+KxljVIl6w/5rsKdxdsBD/OZZ4MDr5H34nd2sG8Hdv4YK2w9MBAWLADFXCU3wHAnf2+97LdM5DD1TKLLzJIJKVz4hS1x7vInPJwnXX+zZla+zuW6PxUTReg5tBkUHRkSQuYyxEu/X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dh0CAbGp; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVB7ywO0HUqOWKZ75X/0ScSTdFRDAlcrym3117Xa2+HBW9MsVYaUgN9Bau1i3mq2rquy+h0kx/A2jiQL4pD14AYZ4Xk/koVkVfzBIqKaiV/aNrFq6mFQ4+6HcKjOGkMcu28YZBUziLZ8OMKkXHkRLhuvKmREwC6fpWGDmDXRxNhOhCI9YxUGOFuwGON/tVKA5AS0NoK3FH8fRozGW/5BgF2UOcreA7L2QEfWg0AKSLBMJedoAynNenqnS//+C1APRq4dvKwgMMzNp+MdaLp2n5Z6VJWtzGpIoy96zhZVzurIlzKH5N3g28mMjhws8c99q/RZWt8Oy1MUbFPXzZLmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woyHXYfCHRO+fUYQm1jhR2PZy7jtwwhnFDEQizWtJ40=;
 b=JvA8echIGXHO+Z0Ti90l0ULcD2FhOpvlfnpKSnBw9LJISiM+pxiZBAX6XmwAJykTDMp8VJZXbT2y4ai55FahVnCy7v7qnasQXZs2bVb4KdblGsVvCXSvdV8h8xyOJwBHRwDBE6OHSz0b46CryDhJSOt3Xti7mLEOYdUFhLP8vXBq2M8eHyh9qVRiFDp3wR+Q7b46hvwTAXkJfbjjJdJeBHhUEhnDLFsdTIDqNIzRrPErWYSquQiwSY0dx7jbDA8nN7sfBQTx6UtLSgfq1tzUQ1NYNzj/gWOaMi34WC9wiFqFPf4++xGEsW5dsKsT24LqLya9pk/JVbquRTykr9K56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woyHXYfCHRO+fUYQm1jhR2PZy7jtwwhnFDEQizWtJ40=;
 b=dh0CAbGpKawteB2dm9Vmwwk4fjGjFPY6WOwqp+Iui2w+YHEhRCaOuSqjzaB84flqICMeIbE14WW19kUtO/VE8Ex56WrXg2PqjXHPyx94r6lTm47Kai0jsQBCYIxAwQHTr9Rjbeub79/3Qi4Q+vZ7dZDoVvr0Y5/QY7BIgb1XyVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 13:22:01 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 13:22:01 +0000
Message-ID: <de8e68df-8b9b-4c75-9d0e-db6e150fe1e2@amd.com>
Date: Mon, 19 Feb 2024 14:21:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
References: <94726c90ff519185767475f672d70311472ea925.1708073513.git.michal.simek@amd.com>
 <5a81f16b-8ece-4263-b424-4dd6cd6e386f@linaro.org>
 <ed59671f-6e0b-45a2-bae7-38f7b4b7e625@amd.com>
 <ebcfd49d-f810-4d9b-8cba-b55071fc7fa6@linaro.org>
 <96c0f613-7c53-4189-bfc8-7d572b308b9f@amd.com>
 <3f26624b-7c1d-43cb-a729-5fb50d184046@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3f26624b-7c1d-43cb-a729-5fb50d184046@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a648600-e10c-4212-deb9-08dc314dc153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yA6huUOPoBQ400QAM8mGUuCaFWqAwZAYrMcjn4ZiDrpycW3iLL2rB4y1PIH+ocGv0rHgFZ0x4vNS5SKamUSF2UUg1aQ4pnI+Qz9SdrciqFRBXcZ+XfsFT+4eMZwBqsGWfIEhjO+iALEHtEJd7UHewIwyBc1OiPg3T4Jc0vM3yRwYV2TD4PwrPANSjL4UB6yAXhyNSXW3yvDoIiMLWbiKGGMdytG4hbTen0oz4Z+UT99C2CUqfa+87vsPjviV30yzcE1sT+f74sICj6ODXBwEjalyYiOKCVk9iZxPeOfFTcFEro/rdxrbM3LjXfMN9KsfOfWkoSxUz+vt7JveeR7axRs7X3UL5TjXH9xAGDbDsJYqGv9LEHTekI3BFXP6DWLZwu3Mhv8+eyPZ83Xf6ym+HLd2HsSljK9J6sHQSVKBri5imgPhuMCa58bWC2dMv8Wh7VcPm6PttYIbrK7tFRW5uEqk+3yYVzZ/XYzPY56xhYYpKKdYrk4iCNWOBfzgdB31RadOlAJ86sq/7qO0QxNXRHlQYflh7I+p/l0GPCplpGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzRicGFQNU1SNXdWUU1ZcnlGYktBOFJjbm9jOGRQWHFoL3hSc2Q3blpUZUdF?=
 =?utf-8?B?YW41SnZXOEw4V0l0UFZPOFY0MmtaWHBDUlJSczFab1k5NkFPVWUwQ2FNZXR5?=
 =?utf-8?B?dVE0ZzAwKzZabm5MWWgzeXFpczBwMUZJR0d2bE81ZGdFaFlzMUVWN2dFVDd2?=
 =?utf-8?B?VDB2amQzY0FSN1hoTUozUzBja2dvY2Z5NmtzR1I3Y3pOYld4T0wxN2RWcUtS?=
 =?utf-8?B?YXE3N3g4T0JTbXlYYnlHcVdWUlo2dzVNNTNPQ2R5dXVFczZVUzNKSmdvT2lH?=
 =?utf-8?B?NHRGTjRZN2t1Q1dhb1JxMCtuellzYmFNUnh5Nmw5bHhMZ2lXRStta2pzbjll?=
 =?utf-8?B?akNZaTUvOW1FLytodzhMclFrTmU4U2RWMnhmdTA4UUZMM05qSUYxRVpCV3RD?=
 =?utf-8?B?REtPZHI4TGVobDNkd2w0aktHUkFBanN0SThRUm5iaGI5bVNRemd1SkZhbkZK?=
 =?utf-8?B?UmNZVk1ER0cvdkRkbktCL2FvWi9md0hMQVduK0pOSlpKVXVMZkdNS3FTZnJt?=
 =?utf-8?B?RkcvZUQ4eCtDZ3ZSYnRUK2VJOVdML0FDRUxJVzVWTEpPVGl6aUtPMnRaRkRu?=
 =?utf-8?B?SGhVQmxBcUNoaC9veGlFNnFZWU9tVVkvUElGRzF6eVF1U3JFYTRKdWlFNXcr?=
 =?utf-8?B?eG9MT2dlbDQxVWJ2R1BuaEhSVVRlbXJmZHlIbkFiN1hvTFpJaG4zY1hXQjkv?=
 =?utf-8?B?YjhGc2xVaDRhWUhjWmZDdDN0QXdReVJsS28wT1N4ekRLVEl3Q0xIYlpSTWVR?=
 =?utf-8?B?dlJYSlAyNHNZbXBzZWtkNlJCU1p5Zzdhb29HR3kvTWZhemR6SnNETnRJSWEx?=
 =?utf-8?B?aUIvdCtPT0dEcUVCRmc0Nit6c2pBWGp0Q3huRmgxa2NzdWxZcENtWnJ1YkMr?=
 =?utf-8?B?YkZibDlZKzdPcEx5U05ybzU0MFVVN0dQdXduWHFhTks2QUdwbVBWQjRTUDBE?=
 =?utf-8?B?T3JBS2xuRWNDL0IxVmtwZnBIeDl0YWthRnBKM2dMRittSFNWa255dHdIckMz?=
 =?utf-8?B?aWZ6R3d1WUo3bnlhTmJiS0lFTWl5NmwrVjJlSUx1citpWFhDa3g1SitFemFM?=
 =?utf-8?B?dGhxQTlTajcwSURxbmpyb2hRTlFVN2NEMWlSdFYvL2JmSGFnUGJuMGdDc1Br?=
 =?utf-8?B?TFFaL0JaYm5HdjJ2cHEwOUpoUHo1dks3Q21Bbm52R1JjdSsrL3R4dEdYZnN5?=
 =?utf-8?B?RmVvQ29VMEZaUEhGOVc1RFkxVjVMZThtc1lPUDRMYUh2T29HcTFSSysxTDF2?=
 =?utf-8?B?M1U3eTZTSVo4Rk5QbHA2YmJzaFdwZDVWQy9wUURBWUhuUjBORVZnR1dYR3lN?=
 =?utf-8?B?UG9GSUsvVVpaM0MwaVIrZ1p5MC8xMzF5UzBPZi93WC85RTFHRzdtc2xMbURJ?=
 =?utf-8?B?SURKeHFHRTNaZXdmUWlsdUlEOTE1RnliZjZ5bVM5RlA0Rk4vVjdOSkszdUpC?=
 =?utf-8?B?YzRPYmhhWkk1MzZNb0tLNmtqQ2ZjeGEwUVI2OFV2YVVqdVNRV3FyTWMxM0Fw?=
 =?utf-8?B?V2xBN1llUlZqSHdKUjJCQkp3WTFwamtueWJTL2lRMDNtcVdtZWJWQVg2NjZj?=
 =?utf-8?B?RTM0MC9ObG94UVRvbGVDL1FjNVZQSkNMTGJQTjY4TE1UTHlkZ0hCcGxnVU9K?=
 =?utf-8?B?ejV3QmMzaWY5VkN5UVdNMHgvNHZkUlBlbW80d1hqREtrYkZ0U0RJTzZRKyt2?=
 =?utf-8?B?U3paUEV0Z3JxNDd4WDkxamwvYm93YnpZT0lKc044b0M2RnRtQTdtWllpVVBO?=
 =?utf-8?B?cTgvQy9zQlpYcWpocVZzV1ZyQmZNT2F0VnlMcjJDUSt4MWlZTUFjZkxpMjRN?=
 =?utf-8?B?c0preC9uYU12YVcvamJTRjd5d3NncVBERFZRbThISENkSHFDRHA1aTZ2NW8y?=
 =?utf-8?B?VE1HMzJFTTVHWml4cUdxZC9PbGl5bnUxL1hyVGNTKzlaYXMrVEVoaEQraUFw?=
 =?utf-8?B?dGc3dy9aeUxJbUpGRWJIdWFqOU4yYU0zMlZZYW41VU1mcWtSRnIvc1hZaUN3?=
 =?utf-8?B?eHQ3OWZmYjV4cDB4cDR3cjZRbk8ybnpnMnFjK2FWN3MxNUVUc1paZEt2cVkv?=
 =?utf-8?B?WnVYRGR3anlYTndVVnBoVFBFRXg2SDhpR3FnR0N2M1Z3cTNZSzQ3OENGQkoy?=
 =?utf-8?Q?OazAG5HfrrKoj1wnmoRJuVDCX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a648600-e10c-4212-deb9-08dc314dc153
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:22:01.3179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwySfbDtY/DgSP6fPCPWizE9s75MyqE5KhEzaiPUP2jwmaqAxqpDR4QDrN8IpW7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624



On 2/19/24 14:19, Krzysztof Kozlowski wrote:
> On 19/02/2024 14:11, Michal Simek wrote:
>>
>>
>> On 2/17/24 09:26, Krzysztof Kozlowski wrote:
>>> On 16/02/2024 10:42, Michal Simek wrote:
>>>>
>>>>
>>>> On 2/16/24 10:19, Krzysztof Kozlowski wrote:
>>>>> On 16/02/2024 09:51, Michal Simek wrote:
>>>>>> RTC has its own power domain on Xilinx Versal SOC that's why describe it as
>>>>>> optional property.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>>     Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>
>>>>> But Versal is not described in this binding, is it? I see only one
>>>>> compatible.
>>>>
>>>> It is the same IP only as is on zynqmp with own power rail.
>>>
>>> Then you should have separate compatible, because they are not
>>> identical. It would also allow you to narrow the domains to versal and
>>> also require it (on versal).
>>
>> I can double check with HW guys but I am quite sure IP itself is exactly the
>> same. What it is different is that there is own power domain to it (not shared
>> one as is in zynqmp case).
> 
> What does it mean shared one? If several devices share power domain,
> then they all should have power-domains property.

Shared one means that the same power domain is shared with other IPs or simply 
enabled by default without any option to disable it.

Thanks,
Michal


