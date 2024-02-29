Return-Path: <linux-kernel+bounces-87707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2686D803
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB901C21168
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812AE13C9DB;
	Thu, 29 Feb 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Niqeh+pH"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20316FF51;
	Thu, 29 Feb 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250334; cv=fail; b=rIUPvLYE906xb2yo5oW7QjwsEeDgTBLbS/NUvEmTl5zBGZKDZCMkQtJsqxDdhaa4niOljA0m6VLyaahmv3q5FtmgL14hMGFclGbQH2MpiYk7LXJdX67sME+plMGDMg2XNiVTRpE5q6aA3REFBl/4X+zRWrtZ6Ci7QTnplFYmVss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250334; c=relaxed/simple;
	bh=fGWkrWcwdkBvkJxX7b7h2sPOzbLXNpYkc15UHMjiN8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JDPqvWRkr0BKiRWIw6N0xwCupOeeqwD6/GYcB9ELzGAJt6ed0ntYWlS5LdIk1QA6LNpey8D3GDN698rcqN2x1JcejQ2KaC+aWEbjQPLZYr6nA8WVs6shMC7EgandpKgjYRKbyE7hMRb2WK2HhAKP2qGRc5l7UR5ebfUsp6zYTNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Niqeh+pH; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIXI/vltSZ1YP+0EYb+daf172OvkYJfEzqxF7IRcNyQWVlq8pbGItcdOW+TA718gTPpLdu/bDBS5YB7MrEyr7GrnktZzgEPd3KHf2RWY9omXfZwunzDaSqWIniFR4SKFNL4VuSv2wPW30E6tfG2Jlu+4l3DkVj0+UPxzKohx0KHgAqyHHg/fXzYI5PQQWDdmDrDuJUbE6gA8jHZ9kPlHNHrqII3/FFAMlCpzOQxrfzFiXTYFg811D2GJu5jGNGEvR/ZHubRV1glR5cklwKK0b/kwWM2JF0WN/BRIsEoKN5P4Ex1VBmsWnEjMPuf93xBerV5fSRPb3XBXRp2t+AyxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rAkdWfRIgiHK0dTosl7qsamX5W3Fy5c/5nYuBR1oHw=;
 b=PD928uviyYWSioa1BSpO4wlfv+ZJ8JivJQuGG1FmEzHkTSiWTfHw1rprldqppssa+kS6bDsgHsd8zCwWzTc6WWfd2+1soYykkQ6+GAr/QvKGeB7omLTD6eZSSKAuOpGwHh2efJR0DAr7nsNZHUjfRCy+sMA4kZY4W5r4OQY+KsUYxONOMD0tveYb3DJaCx3EQBXhmfl81CM4TnbISPRxdqar9rxnsaAopsK/dSDIpXElcQNzYgCexMqiCZi5NCmuC8SrPfrqtuTYsLeyg4q9quOtxDsAZMuGUp55vBQuEPxMHMKSkkM5R72VW2+l0wQmTCm6Lw3ImZeZ/FsF5RJJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rAkdWfRIgiHK0dTosl7qsamX5W3Fy5c/5nYuBR1oHw=;
 b=Niqeh+pHhldo/cgGZAglucv3jK2ymS1KdFsefZCwNtKELSlkY6GS+FHUWE7vnQ2yWfW2qpf2NYPj6yawj+5z/YyQgbQa8JrDQ2rRFZ9gS0RZRSfAsjaoP0/CfeSdfQCWWkj2qW9YhE54u5q9jsDw6zib4b9/sa2OZhIsBlcoT+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 23:45:29 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7339.031; Thu, 29 Feb 2024
 23:45:29 +0000
Message-ID: <294dc34c-11ac-4220-9619-1578ebca6382@amd.com>
Date: Thu, 29 Feb 2024 17:45:26 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
 <20240219174437.3722620-3-tanmay.shah@amd.com>
 <d0963aeb-1165-469b-b9c7-410a61b117f4@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <d0963aeb-1165-469b-b9c7-410a61b117f4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0025.prod.exchangelabs.com (2603:10b6:805:b6::38)
 To BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e933d15-b0e5-4bc1-9af7-08dc398082dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Oj6nG47GufR8Wz9mpWtzyKgMvx/fGU9GzRn+c0JhUX/fg/0r3h4k1UVuK55AF2sxriEEmRoU0EptKKzjd4lO3CLilwWkfAhWJWpiC6RmxjTm5pwn/HZeOPRo0UrsWWGDp1LEhw8LPWaF6QmnnNMDlSfUXs7YO0gm9H8zGU1UeGu4My3bAlesSCEhptViEYFjgD5s/5l1D8FEji/90cFOYAWfIgeviVWBfBVJ/ULpgbdNh5nLrxEgXxb5kkEYn4QmUEv4g/7VzPbgOtndOH4S9I6E+HrVQSxwwFM9vcVsGHdlauANtyh9yu/jN3nLBSryzsFC4dlNoaLDDC8drYRUXfMgZNVqLy9vxzsnV0w3oURTeQziaEF/ddymbPwo7rXoFPa3FX+/CFYJ57pAJklCUHNLj6wdDALWWDzLZnjxlCNCkfbiotzMBj+yPv0D8tr4+6wZ78wflzdoTpwVwpnxFPjyOv0OvAuKE7yOD/FP3Hzqd3+qRpEVb7OmBK0eQiUaaXqJGz9L53w3T5yq4ZG6X6nxV2B+E7lDNd4/WUISCpqhJ7TF5R6gCLRkiqPhuX5KJU63uWTFfFF6lulNtoRTjWFOW2ftpOcYXrQwWz5PfbgQqhWbcYxyIV35Q1STdrhadb/mIUqx3S/ul85B5h9YdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjFMbzNzUmpLekg2RDJaOFN6YjRwejk2N2FEK0g4Qnd6bG9Wb2NacXRDMVNC?=
 =?utf-8?B?M0pad0hSUFNkNFF6R3pENHhHR3N5L0xPTXU1Y0dKZ25GUlVsbDJ3dE5Nc1dm?=
 =?utf-8?B?cktYWlRHM2s3ZjFBd0VHeFg4UjZrMnNtbkRsVmhUNTRvKzNhc1FPQWkyeVFs?=
 =?utf-8?B?SDQyOGQwMDdEMFJ6NkdUY0RkYWg4SHpZazJzSEd5QzBZRFRoQjdKMC8wNzRp?=
 =?utf-8?B?OHJMWkFBMWlCVVU5Qmtmc2tOVCtnMnhSaU5NRzgxOUZYVU5yak1yalRYR2tZ?=
 =?utf-8?B?cHF6cVVPa080b1RUUUZBbExvV1Vwc1hYcWNMVmplS0JoNzV4eHF1dE5aWjYy?=
 =?utf-8?B?MHA3NkE0KzBWKzdpbmllVjg2dHBWbnd6REVCdEhpZnRLaFc1R21HeG9rb20r?=
 =?utf-8?B?bm1WWGRROEFCRWcxOXN6WHRvb0ZKc2tYNnNRakRCdVpodm5KTUUrdGZ6Zmht?=
 =?utf-8?B?QjZMOHVJYktuYWo4R3lTUEhDVkdyQm8yUWNwUkU2WTVadXFDczZmNUo3K0hz?=
 =?utf-8?B?SXl5SUtubU5Ya0dVRXpQWEZQZ3kxSlFhdWNaZTZFUndoeG4yUzlXTFJlRGpJ?=
 =?utf-8?B?aFRlckRla0J5SlBHK3oydUlQWkVvM3MvZkhQbkpOdnlFUHdmSjRBMXpVcGdK?=
 =?utf-8?B?eUk2YUVaSzJ0ZmluVXQ3ZUNMcjdIVTcrRUpYNzJrSTFEdHQvV2lJdGxKTnNK?=
 =?utf-8?B?REJubUdSY0tCMDMveVlhc3drSjhuemJUVVdWTE8wVklpbFBVY2hzSFhWOVA3?=
 =?utf-8?B?V1EzL0NtVjBlWERnMHgva2UrTHdyUFYySS9NNGZscUxhSHdrQlBlT0dxNmlS?=
 =?utf-8?B?RmhETDZaYXRSQnlVY3pUVTVFaG41Z3V0a2VBQXdXTVVpWGpIc1lTenRaaGJC?=
 =?utf-8?B?T2JqRUg4RVZuSENaODBpei95Q2VETy9iK0MrQkx3WTZMTUdSR2U3Wll5TmRL?=
 =?utf-8?B?OEpmTVZRenVoZzlUNElFZ1dvNVpoZTQvWVN0Y085VUIzQkdValE0R1VFTTZY?=
 =?utf-8?B?MHBZSjViVnlkbEJyeXNhcU1Yelc5S1RCbTE5L0g3MmN3eHBTNlBUWURuT3JE?=
 =?utf-8?B?OUpkN0hGUG0rWUMvbU01a0xiSnF5YUptUVJ6Ynphb2F4dzZlYmZwZzM4U09h?=
 =?utf-8?B?VWFMM1NWbCtTd0FhV1pZL1ZNckVDMjF1VzVUN0RrblBncGdkaHF5VXY4Sml5?=
 =?utf-8?B?YXNjQmdRbHBhcXh1alNLekNpbDBCWEpoN0NZc2J3U3NjSUxPSmg0eDBlRVZz?=
 =?utf-8?B?VjJxYnJJaE5JS3g4eFpvcGpiWUdMb0tReHVMUXFCTm1CUTgrM2RLVzJCR0NR?=
 =?utf-8?B?akRmZDdKWC8yWFhuVTVJZ05xaC9NdTBIcUxyNXN0Y3ZZdUVub0QyZ2g4cjZC?=
 =?utf-8?B?K0k1Rk9oWHVrQzR5dUYzbXpwenk0UkJMMW5TdXFlZHd2czljMVlBUGNjMTFu?=
 =?utf-8?B?VXMrSWZBalZCR0dlVVVQTzVOeW9qWGpyY2FzTTBUUWJQZDMrZzNTSmhiT3A1?=
 =?utf-8?B?L3J0NlFFUHBxR1R5aHZDM09LZzB2ak9obUk2QXl0V3RubWxkQ2Fza1h2c09O?=
 =?utf-8?B?YW4vRTRtV1ZYRkIvd1R1UmtxeTlrWVdHLzZxNE95dzRmbFkwZnFCdGpPRE1j?=
 =?utf-8?B?cGhpWXc4b0w5VVN0RXIzWEhxaW9UWTk3UjB0ZXdLQmtsRE5WUVBVa09jYlJO?=
 =?utf-8?B?NGhVVmIvMy84Rlo1OXdTNmk5YlFLM1g1bHlkandOa3I3OTNad3cwY29zRHVL?=
 =?utf-8?B?V0NaQVRiVW5pOE9BVUFvRmY4UGZ4Qmtta2Y2eGpmSWN0NGovRk0xWit5OFlK?=
 =?utf-8?B?VUhNYXh0UU9nRkxkMGRlVDd2RXdVUGErWTlxSldlRUo5Q0ZuU25YcCtIN3JJ?=
 =?utf-8?B?eThLc2NQVFlZOXBRZE5STXd0cWVnWEphU3hHVndSaVlKMXhMQ3Bpa2VqaHZ6?=
 =?utf-8?B?ZDNBdDF6TjltQkFRSEk0U21VVHA3V0UrOWg4amRMZE5qQ1l1UEVTa21BZE9h?=
 =?utf-8?B?OU1hM1V1UnBNNWx2dkpUdVlrRkpCaFR0QnlRYiswYndHWUhLUGs2ZGgxR2ND?=
 =?utf-8?B?TElyU3NROTJWRWRvcE1zOG0zWlpyYkZzcGlUY3FwWXIvNHZSV0g0R0xSYVJ1?=
 =?utf-8?Q?TjcYTcye6nREMIlAhJU35j8IE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e933d15-b0e5-4bc1-9af7-08dc398082dc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 23:45:29.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eCBUmD6n92W+IyzfB15SvAuis5ciM2resjrxLfF0segLVoKxPyL6Cs25Q6FDPm5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842

Thanks for reviews.

Ack to all comments, I will address in next revision.


Tanmay

On 2/29/24 3:59 AM, Krzysztof Kozlowski wrote:
> On 19/02/2024 18:44, Tanmay Shah wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > 
> > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > UltraScale+ platform. It will help in defining TCM in device-tree
> > and make it's access platform agnostic and data-driven.
> > 
> > Tightly-coupled memories(TCMs) are low-latency memory that provides
> > predictable instruction execution and predictable data load/store
> > timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> > banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> > 
> > The TCM resources(reg, reg-names and power-domain) are documented for
> > each TCM in the R5 node. The reg and reg-names are made as required
> > properties as we don't want to hardcode TCM addresses for future
> > platforms and for zu+ legacy implementation will ensure that the
> > old dts w/o reg/reg-names works and stable ABI is maintained.
> > 
> > It also extends the examples for TCM split and lockstep modes.
> > 
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> > 
> > Changes in v11:
> >   - Fix yamllint warning and reduce indentation as needed
> > 
> >  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
> >  1 file changed, 170 insertions(+), 22 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> > index 78aac69f1060..77030edf41fa 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> > @@ -20,9 +20,21 @@ properties:
> >    compatible:
> >      const: xlnx,zynqmp-r5fss
> >  
> > +  "#address-cells":
> > +    const: 2
> > +
> > +  "#size-cells":
> > +    const: 2
> > +
> > +  ranges:
> > +    description: |
> > +      Standard ranges definition providing address translations for
> > +      local R5F TCM address spaces to bus addresses.
> > +
> >    xlnx,cluster-mode:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      enum: [0, 1, 2]
> > +    default: 1
> >      description: |
> >        The RPU MPCore can operate in split mode (Dual-processor performance), Safety
> >        lock-step mode(Both RPU cores execute the same code in lock-step,
> > @@ -37,7 +49,7 @@ properties:
> >        2: single cpu mode
> >  
> >  patternProperties:
> > -  "^r5f-[a-f0-9]+$":
> > +  "^r5f@[0-9a-f]+$":
> >      type: object
> >      description: |
> >        The RPU is located in the Low Power Domain of the Processor Subsystem.
> > @@ -54,9 +66,6 @@ patternProperties:
> >        compatible:
> >          const: xlnx,zynqmp-r5f
> >  
> > -      power-domains:
> > -        maxItems: 1
>
> Why power-domains are being dropped? This should have widest constraints
> if you later customize it.
>
> > -
> >        mboxes:
> >          minItems: 1
> >          items:
> > @@ -101,35 +110,174 @@ patternProperties:
> >  
> >      required:
> >        - compatible
> > -      - power-domains
>
> Don't drop power domains.
>
>
> >  
> > -    unevaluatedProperties: false
> > +allOf:
>
> allOf block goes after required:
>
> > +  - if:
> > +      properties:
> > +        xlnx,cluster-mode:
> > +          enum:
> > +            - 1
> > +    then:
> > +      patternProperties:
> > +        "^r5f@[0-9a-f]+$":
> > +          type: object
> > +
> > +          properties:
> > +            reg:
>
> reg is missing in your patternProperties earlier.
>
>
>
> Best regards,
> Krzysztof
>

