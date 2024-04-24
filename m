Return-Path: <linux-kernel+bounces-157617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC338B13A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFD1F24003
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9478C6D;
	Wed, 24 Apr 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FyfuweE7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24B134A8;
	Wed, 24 Apr 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987519; cv=fail; b=pZ4TtO2mobXeuqVqRs6VE+x05wKh6qGKEZWfApUWEC6AFcd2+6hxGQK7bFPqBUSHTTuLb5GyBCYcqcSx42wPeEnOmlESFK1ASbsZ/0vkueWck0qeNgZrcF3BuEwbzpwcfoLP3No+LmNlKEaSSilUhzd28bxZKCYUJYGtf68dzkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987519; c=relaxed/simple;
	bh=D82kzu3lE2RlRCO10DzY6xQ7bElGL3tpqtxcsBbGYok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jvaPZ7sqF9SmEurDVnpr9OeNzOgTWtpMu0fraxSuZYrVx8aYqoOrfLLqBQGGq9mgO0wEaXLtawGe3bwH1uFSvWAtls0srEC1QX8rPfFaYCrC24y6H5B0G5VUMJ/FRht+vOXWasUiAX/fd5oXPriVDUfv9L4q/yZRP2yVqPiFTac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FyfuweE7; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqmiKtY41pooGPZaxtA5mL4Uz2XyFy322ToBwFoWz7gfyfulo0bCIsTwoQxudUi2hf767lt8zSKJHydOU4p/tYbFfebWt365SH0cEzk1DazrhHDNXld/Rdy8q5VSWVOMvRVBiZrJADAXn87s7XCtHpQtGmHUHXZ2dnO8teP7fAHSR4GiGPc+IJ1F1pYntMwSd4jF+qdUuj3MmsV2xPQ4f3llyD6MQANm29+GarDUQSvjqz6pZDK9JshzBh9tJGA7Wwm5lTF8CAFzf9aZuoGrVPanRxUmc4TO7Tx/xEMV7ofaixXnZ7Kuy3ETbue6jfEP/ccmNcT0BdRKJ6o1IE7E6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNUPqT2xtADZJbMqIlVavLW70bS+ZDo11mXj+pI/Y8U=;
 b=AbLvk1W/J+4jmQValP8JcByt49Vsi6Y0XfX6TPLgOAgO17l7/XVqfRsZ85Hh4GFIR4AAwmxFAH9rc9WGo0Zgu48Ef1APyENret903C4j02D2j5kjCqjglKSHMJ0YTkn9lzPsI9zlFm/JrG41LxyqcW42X357kw2lNGVMxlE1JBbn1Xq2BOr+GQzYy8da8+LWWxpZCutUPjS9GB/Bdqgu/VWjS9Agm8XNrOdTSzPow6pMNiMGY70n4YMOoaTFP5Eyj337+PqF0J7mjGppPID9cM+UY22kQpkDrPmHLWdUFc1POSBLvUtICN/uZ56QYDrkdjJavZrC59GXd7fV7aSGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNUPqT2xtADZJbMqIlVavLW70bS+ZDo11mXj+pI/Y8U=;
 b=FyfuweE7SAURBr6smfCEmEO4fkZBAYH2B+cmcr+qN6PalcttfMmAdyh/z5hhMi6PNrydNQSZLmGCwFupOX7UbslbiR3vES163RCbuMiggkVA663j8g0DQtT3b9BUoNqHzxNhR2prsoal+TRcKHNIhuLaW9Kh08QzF/w43vZ4/bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Wed, 24 Apr
 2024 19:38:33 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 19:38:33 +0000
Message-ID: <ddaf1b59-fd73-4603-b49e-cf21c9971f3f@amd.com>
Date: Wed, 24 Apr 2024 14:38:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/MAINTAINERS: Update my email address
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, elena.reshetova@intel.com,
 Akira Yokosawa <akiyks@gmail.com>
Cc: bilbao@vt.edu, "Naik, Avadhut" <Avadhut.Naik@amd.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
References: <97731c94-99b0-46be-8b78-5dac8510f690@amd.com>
 <87cyqetwhh.fsf@meer.lwn.net>
From: "Bilbao, Carlos" <carlos.bilbao@amd.com>
In-Reply-To: <87cyqetwhh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::12) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ac78f9-c4c5-4e82-160d-08dc649620aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTEvL3FGZklSK0JDVWpick5sTzhlWm5lc0tLVFNRM0p0SThCeE9PREhqRHpT?=
 =?utf-8?B?SjAwVmliNFJ1YU1vV0FOQllVZExyYXRLeTh3anhiYWJ1cURWTVpsaGlkVTdT?=
 =?utf-8?B?L1QwdmpUdFd4a2ZFMGtPNVRBeHhSZ2RzZWp4U3BtQXgwK3BOL0w3QnNlcjlX?=
 =?utf-8?B?OVM4TW5zbVZhZkx0VmpMZGZIcHFqSTBEd2tvOFhueDNTWExHOTlGN3VXcVd6?=
 =?utf-8?B?RGE2YStDQlVzbDN1Sk5zOFJrOU5kTTY2eHA5aWJON29yWlREU2JpU0NNUm1x?=
 =?utf-8?B?TWFLVzgrQ1NLblZFWm1RMXFiaEtsY3JGdklRWXNsbFk5UjdPb0VLb2F5Zmox?=
 =?utf-8?B?SGxLRUF4NGZQeHUwMXZtbGxqL0VSM0RPcTlONDhPWGxIOEhhVnJXbDNZUXBS?=
 =?utf-8?B?VEQ0L1V5clBCcE1IUHZoNENWTlp0YlRkTHFmeU5KTHY5Ni83OTdnejNsdys2?=
 =?utf-8?B?WC9MVlArMGgwV1A2NHVuZ0VmR2o2dWx4WG1QVGNNdlpVTmRBdmdWemQ2NCt0?=
 =?utf-8?B?VVA5SmtmM2ExTmZzeE1TcWtIUzVyYmRlUWh6QlRKdHhrcGZveHBJS1RNQUlI?=
 =?utf-8?B?VFkrSUZ0dCt1WkU1SDY2ZkRmOHh0L3IvY0pBM3JKTHpFU0VpUnlqbFFtbmxJ?=
 =?utf-8?B?K003SXhKZGtEblR0L0NpUk9hbGsyd05iRm5BSm9VY25FT3pPUngyb2lTSW8x?=
 =?utf-8?B?SjduUG14c3hRWDhiTDJQZ3RiOW9YYTFRME9sTVRsT2o5RHhvYXdCRVdHMnVD?=
 =?utf-8?B?Ulp2QWNTWTBNWk5RcUVqdmF4UjRteHdRVjcyNkM0ZVZCTmsraktEeHkyTXFN?=
 =?utf-8?B?NnM5OE5XdDZOR3REd0hjZ3Z2d0M3cG5mS0VJVDE0UFYzUEkraDg5SXVqRGdD?=
 =?utf-8?B?R3BVOGFzVXBGQWtNdXIzSFhjUGR2b214dEV3OVM1TG04UU1aUFZleUZMLy9N?=
 =?utf-8?B?VjROT2NqYzFBSmNhQXBCTTFHRVlMWEc4Zk5uRVVPdUNZanJPcGtZMTQ5RWhv?=
 =?utf-8?B?RjJCVks0dEh3VHpQNktmei84OWhHZzNseThJMTJiSUI1VXdvaXkzK2pXdXBG?=
 =?utf-8?B?bVZJRFY2dllhNzNrZWdaTkJMY1BaVnlFaGMzcWNwWjVURFhFU0JVUUN3ZjBU?=
 =?utf-8?B?T0JWSnZCcmc1TkhjL2hRcko1bDBENUJ3MEtaUjBIZEZ6V3B3VkdpUncvQUty?=
 =?utf-8?B?bkE5Y2VqajBlU1JXVlZuN1ZjcEd0TDNrVEJ0NTRZMWJ0N3hYRW5USkJvSDlQ?=
 =?utf-8?B?WkRGTGFCZWg4a2JMb3J3eWxvL2djV042dy9HejBsdzl5NTdVN0NYclhBNk5I?=
 =?utf-8?B?VFpMV01Zd0gvdE9rQkNKUS96UDRQWlRMa1ZDS0t2RW5ZeUtJT042TVBTd0NW?=
 =?utf-8?B?L1VGU0hUaUtWZDdodHNWdlpLMndpMGwvaHdWcmJyZlhQZkpUTWNkRzhmeVBt?=
 =?utf-8?B?VWgzRTJWRkRHVGpxR05XRlRrZGJSWG1GWm9HNHdGY2lFZFUzZFZ6L2tNMUNC?=
 =?utf-8?B?SGwxaHVSWElmY2RRa0F2ZjY4WGNHRG16SFBjdENpZDdmTFU5Sk1OMTdINnNy?=
 =?utf-8?B?NlBmUEY4RnNRRWNQV0lpTVNWdTFONjFneEJSNXROTk1SUmpZSVY3d2cxYzRy?=
 =?utf-8?B?eXlmQmFESU9oR3lZbHllaXZyMm1QSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hEMHQyandLdzZ0VW1NNkROMW96c3B6alJTUDkveDZhdUZ4RzNtODlNcmNt?=
 =?utf-8?B?VWpsd21Qa2NTVHhQQjF1V2lXTGNFZXhoUzlnSHlFcGEycGU0RDArYk5xTGU4?=
 =?utf-8?B?YzEwS295SE9CN1ZPNTJHVTNFYklDUU9iMjZrWVIrVm82ZTNTdGZKSXQ5S0Rz?=
 =?utf-8?B?dWw3REdxdXFraS9KV0hvRHBnM0FYS1BCNEp2WGNSTGZ6eDVVMS9nUE1BMUhm?=
 =?utf-8?B?VUtnTDZ2QmJrR0ZpYkVlSnNtbTlvRHlrSTROc2ZWcTNkMUdPTCs3ZUVVZkFi?=
 =?utf-8?B?T3VEZXBwWGlEMkZkNmtiZmhVODdCZGFwaXhQQk1YL0hyUlI2eFExQU9Xc2E0?=
 =?utf-8?B?dTZsaTIwZDlLQWQrYTh4ZFhqMGVUWVA5ZEYwMjVFdDc0WExFMXRvOENrWFNN?=
 =?utf-8?B?ZnluaFVHSmEvRmRMenBBd1NrcXpLMjZpOWpTMmw5ZnAwMjUxRGkwdk51ZUxE?=
 =?utf-8?B?ZkZaQ1duM09EaURhYnphU3hLMlZ4Z21FanRBUWl3eElFRXl4aUV6c3dXRCtL?=
 =?utf-8?B?UmpxcDVrZXlBUVRzcTlWMElqc2NoNDJ1cVpZOEdZd1hWMSs1ZmNONXJJVWhp?=
 =?utf-8?B?ZzRjOVFNMS9tSURGYThHdElEVGtsZGN1dHhLQjNNa1lWUWZYU3AydFIwOCt0?=
 =?utf-8?B?VWRtZldwMzhNckRxVndSOWRxeUZ3RkdnNWh3RGp2QnRrUVVRSjQ4UThWMkFa?=
 =?utf-8?B?RnVaNzhjRXZyL3NYSkg2dzZweXd6NTVVRmpTMzFOc0VxMmdFZmpZbk0wQUlk?=
 =?utf-8?B?WURGR3RiZGlyY1FtdjBXUFBVK2paWnJWQnFwMXRUam9GeWE5QW5ST1hBYVVU?=
 =?utf-8?B?T1NEdDNiT1pMVU5HWnRqbHdhT1M5cmwwS3VpTmpVTzY1ZWZiR0oxYTJEOUdn?=
 =?utf-8?B?OHFFQStZd3pDM0VFWk5tZEZoOUdmR3IvZkxoWXg0Tmw5SzI4QUhFcHRuMWs4?=
 =?utf-8?B?aWRCS051bDNNV2ZmNStCajhHYVo1aUhCenlHYzR2V2ZUNU95dldJRk9NcXVH?=
 =?utf-8?B?WUFVWVdIREM0V0c4YzZzTzZIYTh5Z1lrRnRGaDhDMGtUeGowMXBuM2FaU0NQ?=
 =?utf-8?B?VVBZVm5FTGEzNFhlbS9tU2pvOWNxVXY1RGZtWkFaczF0dWNpQVYyNC8wYVcv?=
 =?utf-8?B?OGhHUWoyOEJXQ0pIL0ZTNDVqdU5SOXh6ZEttcGhXTFNrOU14cmRGVWV6M0pv?=
 =?utf-8?B?czM0WGh6a0dPaHBzdGhBaUZnWVd0ZDBBQ0RXUGlzSWhWNldYa3B1WXI1V2Jk?=
 =?utf-8?B?OUdmY3RvcjhkUThYL3dpRy84YmpoTHVlOUhjRWR4Rmgxd3N2WVIvV21lTTZu?=
 =?utf-8?B?Z0dkSVo3elB2aDhIalJMREhYSUx5ZkJjMlZxd0xTblhJVVdFdUpRUnFnS0pP?=
 =?utf-8?B?aGJrRVRyb1RMK2VpVExrekloVmw5ZlUxQlFQUjFHek5RazlBSEVxQzFjNmFu?=
 =?utf-8?B?WkxiTFdZSE1IZTJUSVZVcmNzS2tjWmkwSFVnaGxPYVI1dzY1N0hmWGRWMVZG?=
 =?utf-8?B?MlZUamlmTWpSTW5FaHlTa2l3VDVJNmJSUE42aTA3cHdQZ2pTMWE1ZE54RzFl?=
 =?utf-8?B?dGVxcUU0VDAxMjcxbTdZbGk1ZE9BVnpiTkUyWHNEMUxPWUJ4dnFuV01yWTR1?=
 =?utf-8?B?QUpKdnhBdFIraUtMRzdCN1FXRTBRS1V4SzluWDJhZGNwOHVPci9Bc01mK0tG?=
 =?utf-8?B?ZHZwMnVucFA4ZlZISVQxblJaRE9UWW1QNGp6SDdyQWJYQ3J2V0pGRDYydzVW?=
 =?utf-8?B?WEJlNXcxM0k5Uy9WaUZJb3ZMbFArekVmRkRXeXA3UEw3WE9XblFnQUxCYm9P?=
 =?utf-8?B?LzRiYXh6eUs5Zmc5QVYzN2JNQ1h4ZTVETGZZWUdwMlRsUEQwUThVUU8zM2dT?=
 =?utf-8?B?akJzbmNYc3BzNjhqdG9RcUlNZUZQTkZTTU50djd3M3dZQXJaaGJtVHNlZjFQ?=
 =?utf-8?B?dWk3ZDE0emJzaHRrRmJ1VHNnMlN0K1MzSGR0bjZWWFJNWDBMNno3eDhpUVhH?=
 =?utf-8?B?WUxaUkpkcFdSTTZYZ2FQazhuQnRJOUhvYSs0eWdSbVhuZ0dua1ZFSzdYMWlj?=
 =?utf-8?B?eWZXeVRSL2E2aUxaaGpzV1ZXTkFiVXZnRmFPY3lCdmhHQ0JZTHo2allKYkRw?=
 =?utf-8?Q?JMOBj8zLLVASxFY+ogb8gc6F3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac78f9-c4c5-4e82-160d-08dc649620aa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:38:33.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SG1rVsCLUDDbUHF1khx7KClzOuEW8UwBfxu1Ho9FkrykivaGThJHg6Xh5qUHVxoPDsPOJOZcYUeymeqU+ChwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694

Hello,

On 4/24/2024 2:02 PM, Jonathan Corbet wrote:
> "Bilbao, Carlos" <carlos.bilbao@amd.com> writes:
> 
>> In the near future, I will not have access to the email address I used as
>> maintainer of a number of things, mostly in the documentation. Update that
>> address to my personal email address (see Link) so I can continue
>> contributing and update .mailmap.
>>
>> Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>
>> Change since v2:
>> - Fix .mailmap entry from <old-email> <new-email> to <new-email> <old-email>
>>
>> Changes since v1:
>> - Update .mailmap
> 
> I went to apply this, but it doesn't apply to docs-next.  Which tree was
> this patch done against?

I apologize for the inconvenience. Re-sending now after making sure it
applies to the latest docs-next.

> 
> Thanks,
> 
> jon
> 

Thanks,
Carlos

