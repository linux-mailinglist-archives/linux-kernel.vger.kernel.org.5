Return-Path: <linux-kernel+bounces-106866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A359F87F4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B9BB21364
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F57A29;
	Tue, 19 Mar 2024 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2IBWs+Bn"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A827FB;
	Tue, 19 Mar 2024 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808674; cv=fail; b=Q+YH2hMMKON7FFp36y53clOQk+JCT/BR2gxXmXGc443L7ZUsExEhjIJ/hJhtAig6F+GAHOZ0qwziqgzhJWPuMUKN1A6wxl4G22l2QvTDHSxHyYzzSzl+XapDpCFU2HmYxgZ0MNqdGW2OeHx/llFtLDDNkyU7aprsIdONgsTISDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808674; c=relaxed/simple;
	bh=u2lBFc2Mt8yLmToVna75kdas0K1gllyp+fhgvMpZYHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bHiB00+k07KrEVRVsBO8WPfi8WKHa3qdsIHUa4focFo6ZCfL6lumm6inImI4A8CqKGEr+DL/DZMazaa4Akh6Qn+w5DCffxIVCCQ0XsgE1BimuGIUYgVwEsNU+QsyZPYIbinDJdm8IdzYm5BUEuIuR97NgPMAL9JeHjG43db5zrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2IBWs+Bn; arc=fail smtp.client-ip=40.107.223.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVlWMBvjSZOKd9YHrm/gWod0FJuag9Z0faeBgit1tFkMGrxHiJm2i86XPZ046y75GxxdCH4tpg1LUuyVNJA08b1uffgJ3HhkoLJeThQIJxGs59pURxLrXjdDc/CqmzFmpjoXQwzpKxPGeJkGiln1X7zpWlOPBMBJ9RBzDGTP0GaYFjIJ56AC+NdpzRINgKy113WOryPht/inL99BdbiFedGhvzNdGaxNA1nzQwrH2oQx1KAO/qEGHFHO+asi4agrhbr0GTwP/5laTSQnWkHD2AoS90bECErsC2OtnbZ3FzNZf+mnmZDo2vvjpA0nIgH+w7N7EBAr5IaTbBocXzZwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBWT44kO2v91oSVWErYABZAHqw1g8QxCscJ3Wjh8kuQ=;
 b=gywe/7u3q2DBLxPcO8HcslfGodeH+TktcRoUPz1VK1yWiRqUeUOgcv2rTcvXY6T5LyOYWuskFA4qOMAZa3HN/n1Z0K/LIotM9p+0k1uGo/QeXH8ToqoxY94WcJfgw4zuPOJTVptdVFL8Zib7304J6h+zWLEkQBzfoFCjHrueDM0CqQfUzNct82IPQmdM51nvYe57mpQBTBFOw6UZGSSHs9/i0JD6fVtCQgLcbMiVeKqzh+z9yeMpMj/E0IBEdIJJdtsSdxjiCgLL67zvG4mtESBoUVuW76NAA9Jvi/3YjSOVImqOUM4rujEda/KzMwCue5vWyBrFJgCq6ClLz8/SoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBWT44kO2v91oSVWErYABZAHqw1g8QxCscJ3Wjh8kuQ=;
 b=2IBWs+BnkaBM4mFHH5XAwNhjVC6/p4133HKv1btxnWU3R7mFOgxtlIAqs2GDEvDzGiUzu5vhlokdsYkJSG69k1afS83QJciJkO612mhoHPs1stNl070+II0wJnDaLdo/Treqi2L/iixjmjX+ba6Dr+l175ylnOPfW+nz+leKkXE=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 00:37:45 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 00:37:44 +0000
Message-ID: <1197b7f7-c43b-4ae6-b914-9e3f547810bb@amd.com>
Date: Mon, 18 Mar 2024 19:37:42 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: add Versal platform support
To: Conor Dooley <conor@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-2-tanmay.shah@amd.com>
 <20240317-overturn-frozen-b152dc552a2f@spud>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240317-overturn-frozen-b152dc552a2f@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0155.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::10) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS7PR12MB6189:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fBwHZ7m5ELahLvx3M9uMFmakkdz3FPJxgzLCHhXcIUFQ+vMM9Pe1QofxuRpCQOggHD3v0qscN0QUBg4Rxx4DzTWNxyOJtPVWKjkf7SoeP1rM4lK/TEh2QqNGAxXMVQQzI22A1DOYjNJaoNoYBE2fEPZnbL/4PjNfBsCtLH3CjrL+zvhelLxNr5bzazUiISG8Ez8zF/RFMY1DZ9c4eGb7nEJfG5hYNiZ5LPYP389NWL06avTuFBtidI6Paexyj2jLbi9m/OHilfyEVDMoO7asfc4HGUybWmRIF5ZtaBxWrn8IQctptzFOc2BXiALqBP8Zch8+fNtdPwTocbNJM6gBSy1znMUhjkWphPfUtBhWfGkRYmXmQJQIA9JgEKuMe+LRU+13mquaoxdQ97zNUn3Vp+OQnb1h40OK96wZoumFlYb2xeVKmaB9z+4s3Wz/zkH5dv6dJFRo6MQ+6IU8XX//Y/j70E4c8qzY2WeqYITVJNWkGg35YIVNoRLsEY9r6KApazq52txfCcnSs2lE9W+BskF819irxRxwHKtjxa7fdgW/T4Lr/XD8DkWHMgSHUrtQa04y25xuMsjuHtHlBZq1v2IOUfB3wo7FwJmTFoFZ78FqwpUcfvZZGDT0QHN7m54A+l6hxj5SIRICWQzjD9AZIdGBM8Rj0KEfjvj4K6kdrgY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU1IajFSQXZvQmUyVWhjcTBMcXUwQnZzUlJ0S1B6QTdXaGo4ckRTNk9NdWZV?=
 =?utf-8?B?NjhTcEhqOEFMekZMVnJRa0xCTmFBeUNkOTljTGVLSGU2aUNVbFYrYWhNbDhF?=
 =?utf-8?B?U1JwZmFsakgvYkVFWTJjdHpEUW1aSUxaOWpQWkNHN2hKeURaNUxaL1hUN1dw?=
 =?utf-8?B?ZDFyZWoybXhYWDZ2K0RZNEdSdFZVSXVrcnhkZ3A2WmdkYkJNSVFiS1llRG1z?=
 =?utf-8?B?YmtzcUhJc3puejV0UE55cFNpODNQd2pLNFRGNStKRUR4TStLRnZhaEEvWldx?=
 =?utf-8?B?NXZtaTlpSW41REljQ0Qwcm1rNkcvcXZIVVg5ck9sYjZQVGxld2hsTStoOSsv?=
 =?utf-8?B?cjN6SVVkTmtXNCtDcUROU0k0bU94dnV4bHY5ZDl6b2FFdGVKYVB2U29NR1lv?=
 =?utf-8?B?dDdlUXlOc3ErOXI0UURCR3JpSDlOS2hpU2kyNXlnbk5sRDhnMUY5dDZJQjZj?=
 =?utf-8?B?RUdHZEkrVFl1RkR1TXFDTkdxZE94VWNQVTk3dUVWcXBXVlM2VFpZNmlxSEw2?=
 =?utf-8?B?OUN4R1JpUy9UZzRQY0FlelEzd2c5SWpsMnh5dW4yMHl2TU9lVmdhUEVveDVH?=
 =?utf-8?B?YWFYMTBuY2RYd0ZaMVhkRHhhaGJQVTErQk4xdy9VODZ6OStRWFgwWFdlSzRn?=
 =?utf-8?B?RE9GdkVQNzRmcHRBMzVzMUJJOEx0R0dmajJ1aTVQTTRHTmFxaHhkV0VSNjV3?=
 =?utf-8?B?OHFyMjByNzN1RUliRjdQWDNaTy9XWjE0dXgyUFMrTGpmTmpRQnF1Ump5Y2g1?=
 =?utf-8?B?TytHamdjTnUzRWR4M0U3ZThLMjhRNmtaQUxmS1l1UXh6MmpoRm95S3lHYjMx?=
 =?utf-8?B?N3dpTFVxdmdrMllsRVhPTGRSSGlKVEIrc05DWjB3SHp6aDBSc1M4bVJCZElB?=
 =?utf-8?B?c1h0ZXh3b3l4Y3BJV2VYVTUxKzdkRXJNM2Q0TXVQdTlmWCtQc09nRmszd0RC?=
 =?utf-8?B?WlRUcUtrU0Q4VGtIYlFLamxTNHZQOTFUMTUvVXpUcFhUcFcvcUZXYTIzOHM5?=
 =?utf-8?B?cDl4UGNGYkRzeTRzbFNERE5rMm5oOUtRV0ZLVk5tRzcrQ3d1K2NFMk1LUWhS?=
 =?utf-8?B?clJlVnVkVFUzeUF3SUYyWlFZcHd0NkhGR0tTVGE1UmtVVzFGczFwL3hYb210?=
 =?utf-8?B?eXRQTVRqMlUrRGtHeEcxTWplc1owVW1wOEFMakFiQjVuUTREelpMUGpMakxB?=
 =?utf-8?B?L1pueVhPT282ZEdoMWhTbERBVW9SNGwwR0J0UXZHNS9CWkE1bHl1WEp4UE15?=
 =?utf-8?B?K2N1cWNPOWFZcENvYmhRdFJ5QUI2a0tSU3Q4WnlSMVZVOVlOUmptTDZmZzVX?=
 =?utf-8?B?eEY3ME5rV2x0NmR1UVhmMnZYcjlCNzZaZWRzRnQwODF4NHM1ZTBkdEtlMUlS?=
 =?utf-8?B?Zm1YSzZyamIrTVhkMUJtdU05WEpYUk4va3FaS3AvWGFGbUl6aytBbEJEaUhY?=
 =?utf-8?B?YW9nRFVZUDY5ZytEZVBxVmt6RU9iNjZ3L1k4S3cvcnB4NkYwUEIxRFhDYW9V?=
 =?utf-8?B?R2Jla1FtQ1lSOXBXSWRRWlhUV1VmRk1xblk2VFY1a3RTM2M2VVY3RUlmREh6?=
 =?utf-8?B?TExHdEN5REZNdytQQUxVNEh6T3VYT0JvbkNEdnRyNzlUdEdJdHRwcTNXWVVL?=
 =?utf-8?B?S0FjYUE1R2htNEVLV0VXMWFucnBxV1JkcDY5bmxYbGUxZmdWc0dwNTlNbDFH?=
 =?utf-8?B?aWJneUs4MVo0Y1hQTFMxcmNMczBLVUxRamhtM3FUNTE2bVlXT295Vk5POTJk?=
 =?utf-8?B?YUpyU1dCQ1FKaEo2dUNTVzZpUlpvamdsRjZUSk1RcTl4YTI3UGZoYktlcm1U?=
 =?utf-8?B?UlNiTTB3SEpuQklIWGRJQ0dXMWM0ZmkyWHUxYTBjL1c4Y2R0d0JCN1Mvd3F4?=
 =?utf-8?B?Q2NSaWNkeU9vSXFXRm80ZTRKWnR1UjVOVHF1b0V1cWVkQiswVFFnNmhsbVY1?=
 =?utf-8?B?WHJ0VUpicURKbVZsTzdCbW14c2t1dTFKenZyZ2NTSjhkNm9pY0tCWkNPTHNU?=
 =?utf-8?B?U09uQVpUZEhMd0FKNE9EZU9UWld6L0ZPZWw0NmVGVmJVSE11WCtVZVZyQ2lC?=
 =?utf-8?B?WEhuQWtiQXVZZTk5eDhZa2cydFowZTZ5WFF4OFFBL1ZiUVAvRW5JWGVGQkpL?=
 =?utf-8?Q?SostVpEFo3fc7fF5KF+GWOozg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0778848-b312-4eae-3d70-08dc47accb22
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 00:37:44.8875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RO01Lu+FTFPie2c7zWfz8kgWHhY00jyNg/pVV4KLzO4xTyw0cqhO8DKRPLe16pcx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

Hello,

Thanks for reviews, please find my comments below.

On 3/17/24 9:50 AM, Conor Dooley wrote:
> On Fri, Mar 15, 2024 at 02:15:31PM -0700, Tanmay Shah wrote:
>> AMD-Xilinx Versal platform is successor of ZynqMP platform. Real-time
>> Processor Unit R5 cluster IP on Versal is same as of ZynqMP Platform.
> 
>> Only difference is power-domains ID needed by power management firmware.
>> Hence, keeping the compatible property same as of zynqmp node.
> 
> No, don't be lazy. Add a compatible with a fallback please.

It's same IP on different platform. I am not sure how adding compatible string
adds value. I will refactor this series based on other comments provided.

> This doesn't apply to linux-next either FYI.

Actually cover-letter contains dependent series link that is needed for this
patch. That series was acked recently but hasn't made to linux-next yet.

I may be missing something in the process. In such case there is no other way
to send patch except for waiting?

Thanks,
Tanmay


