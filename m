Return-Path: <linux-kernel+bounces-100740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D56879C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DA31F2224E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605DB14265A;
	Tue, 12 Mar 2024 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ktp3i1yI"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88CA7D406
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273999; cv=fail; b=Bqh1s11k5k54fDqTrF0DVGgDyk8pGnm64qW2x6MwqxaYg0PtcRDe0xBY9EeZcn6wH5kwVFqSlCbCbGz8c6nstYNYyDzTANRhlc540Tv2x3OgVaQLepwc4hbG3L2lO66ZH/4GlV8f2UO09fZ660xYsXbuEk2siz52ShSwG1u1Vy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273999; c=relaxed/simple;
	bh=3HW7Wd/1x31LCf0J7rz0zpPnLToLIRMRic4HvW+cju0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p4C5vhLa/9bMIhkcpciE0oifAAFRs3T25OdvcbxGfqwVbfnxVP7bqyvaSf32AmZRvzAjRQcEhUAI+DyADYm0R4V/nypDDcMjgt6uOiRr6EshGsZGk74OLKxKW2hAcpn3tNqC3juRAXsD8Ok9K+CSBXudLPKcsXG4TOIZFC42jiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ktp3i1yI; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY95J5mKC8MNR++n6Ua326IQ20KfsQYsAl6BS9YcjwD7Xvny+qDgKuK4l5C7wYtiqznj9yLRWl+4fJv6XRoR/DTWTB6EHOi3WnMpLcPUP0+l8F1snDrFJ2lF5zy9s5pkXYdBK021zKGQAH3CzF46+TFkgL44/vsPKei/8DOCSp0L0mqtPtWZ7KcmXhoeS+04A0rPe1WmR3CmFjxPt/gu4pZem1d7Zo9SenY5aCKNvh6hmoPTNyDxZBZkCN5G3Ludzbs1QNcmth6BtZwxb4Yfx7xhFNg999pEpiIR6ACSLPAzg2WCbBaIgfDL6ZAZG+6gpj+OCpfwNC6erYTpscz9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv2mUEXg22dfQk9jonDyUZ5dHu2/GbaztwfWtt9J9aU=;
 b=GVCABwr/bWi6MueyAjrqNfC8LLU6156S5Se2PexzAjAEOftW9tZrgNPsajDBJ59X6DMg6/kcq5LgAos9XN7avauqGZM3A5REv93jafmYVYWWcUtqstBpsn+RDDC/82gaQ94+M40EAP/ls7+89TYkUrtBNvK2UEh+heHEX+SMKHkruAzOIPJd1jbAqX3294DUAB+mqXHuQZlTwDt1oMYWMDMyMzBWVhSkwP60OONrqidE1daJFq8WEbvrtQ6PtcgFe9E9vx/rqCSdg6SoI9n82DbYC6fyXiWNS6usqOHaiK4n6jpZsNZ1XuF/EiIVpU1kdmJrkUKVgvnhgwjCVKU4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv2mUEXg22dfQk9jonDyUZ5dHu2/GbaztwfWtt9J9aU=;
 b=Ktp3i1yIl1z50Uu1o7e8AxvL1kEouCMxAfe5fVSrrMP4OvgI/phg58dectjN467+1dmkzRKXK1Oonk0jiM9HtKHBsPsryHxKtsTtkvmBQJe798FcPI6Sba6kOKWdO6ZDeHJF7kT7RA9fFrRzODMGlSsBeuuTsHBlKF4dTJxG9Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:06:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:06:34 +0000
Message-ID: <9fc33aee-8afd-4c8e-af83-74eb11a951b1@amd.com>
Date: Tue, 12 Mar 2024 15:06:32 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v5 1/2] x86/resctrl: Pass domain to target CPU
Reply-To: babu.moger@amd.com
To: Tony Luck <tony.luck@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240308213846.77075-1-tony.luck@intel.com>
 <20240308213846.77075-2-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20240308213846.77075-2-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:806:6e::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a272bd-6395-4a50-b6d4-08dc42cfeaa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LRwbvJO4ly/RH5SiOWIa+Nr6cB1zGDxtEVn3ZXkN7m3Zi03Z6uMLkxWqNa/dnhpiU7DdxtLHnKVTrCByOY/XumrP2nDxrwdebS6IZ/RkKzEatoRZBPnQzhnOEK82wDJpDLDyl2BIi4gUhyWEP/GL3Puu19wF2q29uDlAqgO70R77O61snf/ybU1g54vjHxnyaMV0vPqsd4OkAFydn76cH/JRuLfubrJrm75I2rFq3x+R83g2FtBewNCygyF5WLR/MKbXXR534A7aIM+/gYwrl7OcKktP6B12CY6b7dnQixDpTlCRETRMlQMyRr1yFiAQksJgVrcI1e1QOGJ40z75uKsgdncVwPROZ2GC05DKr4kyZanRnNdIckLlB/n8u3Lo0xdwXoD6AjIl6svON/oZRxohxEP4GnAcjLXCVNswX3gjyw08g+xPA1/d5AyucWF46atIDRZNgnj6Buca7s8gT5ut0Om3Ct+NKqKBn1wGWAxfVtmkg4O/N5zDCVCRCc1Wd2VV1jkkgldVFN3ofNe6TEO6mmD8n/WIG/IoBzXB/57+fIZEJX17KnAxlQcpyOu1U7TfIjibhzJQV6f7cht9nptwdWsX7hrPhbj0hDckSaeq9RuY94KfWHgFQmtzdMqps/r94Bw8HRtOta21cMJdbfFiBjpsgBgt0k7QvRQwfYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUVjWWd1bUd3Vjk3TWZyTFdDTnEvSU5nUVJBaTVxNWFJYVp3QkRtYUVpZnJ0?=
 =?utf-8?B?MDExUWNUK0RBMGszNXAzL2RYTU5DYkNSUjVwQUZVVjhyZVVzdjNDUjF5elpp?=
 =?utf-8?B?aGRsZnBvUTNtQzZJNThyT0pqSFdyYWZ1QXMyQWs4NWdBQUJxZkU2NVA3T25m?=
 =?utf-8?B?aGhYdTMyUmNlYXZISGQvWEVYTGQzNVZyejY0UmRyNG1mZnoyM0VoRlVSSEdE?=
 =?utf-8?B?UXQ5MGY2cmx1WkEyL0NYU2tnbXVQMGpDY2phK1dkRGlPL1A0SytSaXhVR3dZ?=
 =?utf-8?B?NjdHNHhoSWxBYTFicUYrc3dUWG04TVYrUU1wQjdkRmllcUhnelNFNlYrRUJR?=
 =?utf-8?B?R01waU5LNDhPUW5JNmlqNVlIaW50REJIbjljQThiSENnRGY2c0lTUnQxRGdT?=
 =?utf-8?B?NkkvWWtnRVZ1OGxOWW5UQXFkQ0V3MEtDd3JydkZ1aUhaaTcvc1hoZ2YvMjBm?=
 =?utf-8?B?bXAyZmdLY1ZNRjVqdlNlRUdYVjVnNXpzRlM5ZnJjTWRENVhLbGlzZ0hJZWpw?=
 =?utf-8?B?YnRUN21DZlZRS1h5K3JOc0pkM21DTTRVSmxPZFpTV2psZ1lQdWdQRXEvMDBM?=
 =?utf-8?B?clBsN2htRVNZT2hGdlk5YXFFVVhxM1AzNnhxZ0xQbzBYczlzZzlNYTlma2hy?=
 =?utf-8?B?Nm5TY2UyNlFVb3hCTFFkY0JadzhYRzQxN0FEMzhWaE1ETU5lVDR0SzlEa0Vj?=
 =?utf-8?B?aFZud2dLZlR1TWY3NncyWUFFcWE3amkraFZ6RDI4SUJQQTQxbXpXQUcwNGFB?=
 =?utf-8?B?VnY0QzlySS9IaHhIUWlPeW5qZFI2bFVqbytoTzBvTFNtdW9sdlNzT2ZpUThM?=
 =?utf-8?B?QmFvSUtVcTN2L2RmVzVQN0h3U245Rm5TL2NLMU5CMTNqZWl0TC9YSG00aXZu?=
 =?utf-8?B?bVptc1hEU2MzQzJNZHVKd0pkT0pmMWdtZmdPSlJ4N0FVcTQvcktSeUx0V2pW?=
 =?utf-8?B?eGlHc1dEYm5oZmVFZ3E5bk80cEdRSFB3RllQMHpmRlV4OTNyVUl6UzUzOWd3?=
 =?utf-8?B?cU14dGlqWVM1K3RTYk9VcDBra3E1bSt5VWhhNnJFd2dZTDVVUkhiNVpnYWRi?=
 =?utf-8?B?alJxL3JFV2pYcHowUmJqNjh0aE5JT2Z2TVh3ZWxMeElBTG5oSTRQaER0Q2I4?=
 =?utf-8?B?RWZKZGh6aDZSWmVmWUtQZnRJeXNVSzFpUGUvVURhUkpOVmYzVU1CU3pwZDAz?=
 =?utf-8?B?T2dxMVdtV0dzeVdoTWRzL29UZTIvc0dqU29pR2xmL0Z0dyt6em9KWUI3U1Bo?=
 =?utf-8?B?NEFBM0pvZVhFVVl5bXdHREIwL1FIOWYzYXJUbmp0THVqUTJ0S2piMG9majBC?=
 =?utf-8?B?THFENHY3blBGblFNaEpBU1BaREoxRUpWTTA1R3J6bXlGWXVudG5jM0lES1g1?=
 =?utf-8?B?d3VNUVVLM29iWTNpR1JwdnZabjdPUlNheEV1eTQvY2t0ODNsVmhCM0JpNjRi?=
 =?utf-8?B?dVlRWU85K1pHNXducVFXTE9hbDNJVU1yaXBLRVJGbVhnaERtTlp0eE9nTTZG?=
 =?utf-8?B?NlI3NnFnQWphR1hiVVl2UXcxVGVraFZ4RDRNSndabnRWV3lyaUhCSDdmd2ND?=
 =?utf-8?B?V1JPRVBNcXhqSXBPOHpjc2RlVm5EcGNvYTRnZW52WW40ZytEUy9ueHEzOWpR?=
 =?utf-8?B?T2xQTlkvVmdla0VMTHNUOEwvZTd6ZVJ2U3pXT3pPNm1PSVBVYmMwdWxsa2Fk?=
 =?utf-8?B?aUxmbTVlVk9xRzZZdUt1ajRQU2IxTHJSdFJscDBERXpwSFo2OFFkSXFhV1ZJ?=
 =?utf-8?B?NlNOWlhWbTJwKzNtTFpiVUZiYURGMm1tTWdoVnZDSFpHNmo2ZmFneHU0aUw2?=
 =?utf-8?B?VUxiVHpCbDFMMjVvMjFabkQ5czJTNmNIcVdoSGpIa1ZTcCtIYUNXRkFVcGF2?=
 =?utf-8?B?b2RBejYzWkRtL0ZwZk9GekFQVm5xL1ZLSXNIcmRGc1VKTXlUWHc2dEloemQ1?=
 =?utf-8?B?UGJuSzcxMUhMQTZrWHJNTGtLbVE3dDlPd0VRdEh4cFJ5MkRRZzJwK3pyUXhl?=
 =?utf-8?B?TExvMFZTbmJIRFVWdGVNQldFQ0Y5SnRvTWluOWJLaXhxRE0xMWNIaHdnRElF?=
 =?utf-8?B?bXVpb2ZKV1NyWGVqSVkwL253bDNuN2hEcTNGczFtWldVVGRNMkF2ZmJQRmx1?=
 =?utf-8?Q?1DSA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a272bd-6395-4a50-b6d4-08dc42cfeaa9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:06:34.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/jkS5H4ZYM+QBBzgD1ZAInQngUR6T8tdBlwscF1/yAhHdvNhrHxYgG6smlMP2N5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410



On 3/8/24 15:38, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> to call rdt_ctrl_update() on potentially one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain to
> apply changes to. Doing so requires a search of all domains in a resource,
> which can only be done safely if cpus_lock is held. Both callers do hold
> this lock, but there isn't a way for a function called on another CPU
> via IPI to verify this.
> 
> Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
> false positive") removed the incorrect assertions.
> 
> Add the target domain to the msr_param structure and
> call rdt_ctrl_update() for each domain separately using
> smp_call_function_single(). This means that rdt_ctrl_update() doesn't
> need to search for the domain and get_domain_from_cpu() can safely assert
> that the cpus_lock is held since the remaining callers do not use IPI.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>


