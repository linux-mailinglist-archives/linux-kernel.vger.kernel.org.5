Return-Path: <linux-kernel+bounces-145886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590238A5C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AAF1F237D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD315575F;
	Mon, 15 Apr 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5du1VFXV"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6D1DFEB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213914; cv=fail; b=Bd5ncosNDclydFmbeIZmh0tWdXKpucu2FCyCBayD7lMuCXiOSEZuHGiy1JSIcXSYFTTEL9Krv3CHJxYVtLaCY3YZfIP7y4s5sfUVENgkZ69SP9nCqMCWQPClaN0PHjmfRn+HJchlj35mxhI7JBVH+MbQw2X8wjuTHp+Z+mtBUcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213914; c=relaxed/simple;
	bh=kuqfNaIx3wCYXLE21oUQNb3pWhnJxxgNnAHj5XWB5EU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sMTJtE5+yWstJ5ih1IjhFzx9oX2VolMyBifDGM8bd2Rg/yDGRE7Pb4gBB6mJmB3ysWTL3BDhDT/jBvn58zuw8GywHsTtP/8WrjPdRcqnB0O6xCK1o5ijjuzbqNtZlf/w9SBao3mhfq41AElsxaokTnq/QkQjmuoLCIpdt4HiNcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5du1VFXV; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrkf9LdYpBZZCMMWk/JNXQKk+mzjVOsOhneIjWTBvcSKai7+23c/dMpfCfoeFOHYV2oBvhiEORGNaLNd+3Rhrc5cRdCHuRVxVkPV1V14n4b1cjOpeQ53HCep7a79npaBnvdrQ+kqmr8Zt0W6/UazLmMtP6m17T9DoU8QlZb2yd7svDZre+0ummmr3x67kdHSOx0kPP81Du3bOSkY5J8WNSsRsz+eMUUpwYXmP5KifSaJ2MYTIB54toszcSc+Ysr15ICqVuMPfjkndEJsgwQOU4zCCoMTR3bU5UQ83j7roRO4/LZ4MRa0kLoVT7ldc2ftf9FugbjQATt4JXYYt+xuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSRBZKm+RUO7jx3L/CicjkX0RjlWNf4mOwyK2N7BY8Q=;
 b=IqQFgW/oWFvoxEBMplOffaW9gi//PSRkZcVHTVSOimpkXD/WKUvQ0MMsrpdeVqKmgHrtG+vdm4ujk5qY6EJBEt7wNnJMCOUfKwWY2i68jsGteXAJ2u9Sp+/zsFNC4/EAZZlaLksGV4cSroIMIkdO6COHjvLqgA68vDaYYbKpt2wa5F22xmGi9u459awwlzg1eaWx9sPat3uv/Shte/PHwdoXY6tBEOeAZDZndOM0wgg5sjHfFA6TIpXt1xpAfxXAdwYwPn9Hc1EL9DFbZt0oSMu2AwfgWeYLZwlZYc4OTNrGiKHUrDi/meca6yF1AvUaOwUXEz8RV6wrbRv+vKsPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSRBZKm+RUO7jx3L/CicjkX0RjlWNf4mOwyK2N7BY8Q=;
 b=5du1VFXVT43dc3RKtLa5yH9mFz+eXDFHSvivTVAAHwYNbrdgjkwR67pqX8H7LaSLxPDKVcbu3hBkuHT122Oa0dYkFhvcjFD6Yhz2R71IlIJdIBTxV2b5iab5tSZqJiSTsY5V87HUNOLQFGFN6Gjs3D5D6EujTNE71SM5Lo7MWbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 20:44:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:44:52 +0000
Message-ID: <99ac181d-d93c-4b11-84aa-48953d9eb5a3@amd.com>
Date: Mon, 15 Apr 2024 15:44:48 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-32-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:8:2f::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b1075f-be86-4c0a-43db-08dc5d8ce683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jcmej9nfB0S4VMAXenNC/4MO9WV9VGCZ0xeTyLJ1NBvwgxtUlKq+EXQpzgitBnxgRoGIRGacWf5MJD3NgSwxKYmS3XyS14JNWxnsHMFS+X38qcND3T5exPyUaS9v4cF2ym42d+QGSR1T4aCGNGgMzzwvo3N71liI1WZqnIm0Ru7NxVhTWtbllDaIQbf6vUUI+uUzWdKVZ/6puf/GKATGyefbO7csWIQE3nycpsa+kEpt6bi5AG+Yo2zpa29r0KmN3Bk10MhHte8naB3w+2GoMAMbjy/SedLVVTZTP8UJAJWJLBNixPZTV4skOKPyemZ1pHnXEotGgKh/p5jmOxJ+wDBdHI11jCDbxzIBonjbZPHHAapx4n4TNxrSteaP5J77u3f2X01mHiqWvCpNy/fHdZgl586xyymzu/jwsVrdOSkvl0EKg7IpMHMsqbLeh0l1Ng3WveYV6d7EiBLyBe0B6xTKCg3WyFrAlBRtIdFE3qZ1ZOwIwuo81d2WgF8i+2hdedg3U8tFb5BS4mZ/p52+MeEv2EfEiLr1/WCpH1hlQWqp/0Hn0hTlw/Rh19b8fIM67pNM4JWlLETwMmXsw+tGMgrgDlb5ksn16wIkgDIqMbGlSoJHbbZDAJwhR6tFV+u4KIEkDy1bWjxg178L5Tr95BRt+fh9pvXcfmXNDeOqZgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG1VYno3MXFWajFNODFzNkVialZMZlJkRHVXZ01aRXpLZC9xRkwzU0NHTWox?=
 =?utf-8?B?bVhoQTJsZFdUY0M1Z1J4UDJLdm1sODUvdVc0Z3lSbHo1K3d6a3YwRWZyR3FR?=
 =?utf-8?B?VFE5dE5oVndNTkV5anoxRXJ6UlN1Nkh4T0Y1d2hReEU1djFvekdJMG1rQkVn?=
 =?utf-8?B?cmxLbzBteHdkcVpLRzJpUlRYOWZWVjZtelhjN3lxWDZOeUZYYnkxZmx1RXNY?=
 =?utf-8?B?aWR5OWdTUVZabHc3aGV0T05BS3FXSmtuUVdSMTRoM2xNMktPalNFYnhUTDh0?=
 =?utf-8?B?cEU0SVhPa1M2ZnVTa21SN3Y5M3hqLy82N0lsYXBTVFlOVzY4QjFhcGoycTVp?=
 =?utf-8?B?eWZoTWk0d21VenQraFhCajJZWnZyVVZXODQ3Q25CTUVPeFR1U3VPRGdLbXd3?=
 =?utf-8?B?Y2svK0VXS3c1L2RrMnNqdzQ2MUtoelMyNVhhVHRpM0ZiM3dtTktXdjU0T2gr?=
 =?utf-8?B?eTBsdHdJSWl3SlR4dXRKbzJhNHR1aXF5bWNrNEVTS05kclRJMWI3Y3hMRmpk?=
 =?utf-8?B?RUlpNEdkTXFsYlJYUnFxR0xJWmlzeEQ2cTZ6L3UzYW9xZ1ozcWczU3BLYmN4?=
 =?utf-8?B?VUlmNjhlTTYyKzhaSGRYWmw0NDIyRTB6emtOVjFHaVdSYVJSYm4yWjBVeWdI?=
 =?utf-8?B?Y1Q4OWlqT0R5MTA2VWFWQU5mQWh3OVRqc2s4bmdwYUpqTWxiME10enJPUDJR?=
 =?utf-8?B?T2pQdllVdVBWb3ZHOEg2T1pDME1OVU45WEpVVmhhaDdNcnhHRmY4am92cUV5?=
 =?utf-8?B?SXFKcHZEdVZYajJxakxXeW9yTDRpc3pTbnVFRmdlc0FNYUVpdytsZWZIYzhE?=
 =?utf-8?B?QWJ5YkYrUUpJK0tRWDVtMGdoMnlybFR4eENscFVZOVZDWXBVTm5ud0FyMzl1?=
 =?utf-8?B?a1IvYTcvRmZLSVZRRlZnc003WXlpMFlNYmFqTncwcFdiUDVNQUwrYy9GS2Nm?=
 =?utf-8?B?NlBBdTBWM0pFakhxbGpaNTF3SDdyTXJUUFdEcHE3SkZTWmMzN2p1VnlQMnNq?=
 =?utf-8?B?alFrMHB0OXVZemZhUWZCUC9jQzlPcFpsdXZWN1AvcmhnbEM2cHZDOUQvSkda?=
 =?utf-8?B?SitTVTVTN0VSNzhsUXlyV1prQ1pwV2ZicVYvNWlkb1BhTjVBWUVFczJsa2ty?=
 =?utf-8?B?NnVrZHVoK1BndWhEWDBVNlhXVGJBVURtRWl0QjRtQ0dOQjRIRDV1aTNGdHFB?=
 =?utf-8?B?Y0VTRHhqNERSTEptUkRieFlWdmZEUFd2ZjQ4KzJGcE5CQ1VOa3E4NU5qNk5q?=
 =?utf-8?B?enkrWTBOSVNCRWJlNUhNVkVsdjRLNVlhZVNtbzBNN3JrYmdSTE9wZkkwR3hK?=
 =?utf-8?B?VDE0ZEgraEw5dGsxZFBPU1dVMUJvOXczOU1XdDVyeVJVbWY2dXhxY0JZaEFq?=
 =?utf-8?B?Nnlma3REano0b0F3amlaSGk1V2FGbmh1Vm4yc0pHRmlKZmFVTVZheXFvRTY0?=
 =?utf-8?B?djFwVml3TFZIT2lGeU8xUEF4KzN4SldFUDJnUDk4ZURtVWdKdGo2UzRzTVYz?=
 =?utf-8?B?SnRtNFQzSlpycEQxQ0s4Q0R4ZzhOZEJ0RlhmNHhvcWNDZGJlUUdqL0thYkdR?=
 =?utf-8?B?TVFhSGFpWnFrSjhiTVBmNVFLMDhNdmRCM0F3SERJYlJsbi9YOFZsclF2Y2FS?=
 =?utf-8?B?MDlvNXFMa2JrbitRdkhOSTlIeUhMckdWQjIzdS9kSG5WdHZwY1d1ZkNiKy81?=
 =?utf-8?B?bEFlV0liLy9EZHF5SzZzdktsL2dkQ1N6bmZMa0dUQUdNNy96SkNnS2ZYbWlO?=
 =?utf-8?B?S29XR09GeWV4VUFOWUdnV0NWYjJpVGs2QVp0ei9lTTdSU0hRVXFwMDd3QlVO?=
 =?utf-8?B?LzhOVVQxcFJDTGxIRDVWNVBLUjJUZU9keVR6R0FEaVhtQWFSWGlkOGdUYkhG?=
 =?utf-8?B?cDF3V0hyRUw3TVZ0NlBFMDN2Q3g4b3pwVnVVMmJORjU1cEF1b3lRTXRma3pC?=
 =?utf-8?B?UmtqWExVNzBzdFRZbTlwWVgyanBCdjdPbXUrSlN6Y3RQWG10V3NlcG56eCtE?=
 =?utf-8?B?a21ibWtiSDZhSjl4ZjhjM1Q4Q1d1RFhjSUV5NG92S0Y1R0NUWm1EMXpXY0hK?=
 =?utf-8?B?cWtpWlZpNmxETDloSkZZMDVtYWdORDE5d2JMN2kwd3k3bE5TWDVvSFdKSm1E?=
 =?utf-8?Q?8bYY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b1075f-be86-4c0a-43db-08dc5d8ce683
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 20:44:52.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O4RM8hGFZU6EXwl2hjR6RTzzZ+FbiUYhRLNIykKq5BjnOOR+cUwXcHvxRWqOpMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

James/Dave,
This is a huge change. Can this be broken into multiple patches?
It will be a major task in case we need to bisect to pinpoint any issues
later.
Thanks
Babu

On 3/21/24 11:51, James Morse wrote:
> resctrl is linux's defacto interface for managing cache and bandwidth
> policies for groups of tasks.
> 
> To allow other architectures to make use of this pseudo filesystem,
> move it live in /fs/resctrl instead of /arch/x86.
> 
> This move leaves behind the parts of resctrl that form the architecture
> interface for x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Discussion needed on how/when to merge this, as it would conflict with
> all outstanding series. It's probably worth deferring to some opportune
> time, but is included here for illustration.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |   15 -
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  505 ---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  310 --
>  arch/x86/kernel/cpu/resctrl/monitor.c     |  821 -----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1093 ------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3994 --------------------
>  fs/resctrl/ctrlmondata.c                  |  527 +++
>  fs/resctrl/internal.h                     |  340 ++
>  fs/resctrl/monitor.c                      |  843 +++++
>  fs/resctrl/psuedo_lock.c                  | 1122 ++++++
>  fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
>  11 files changed, 6845 insertions(+), 6738 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index c0fb2e22e110..8ddfebd5f008 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -164,21 +164,6 @@ static inline void cache_alloc_hsw_probe(void)
>  	rdt_alloc_capable = true;
>  }
>  
> -bool is_mba_sc(struct rdt_resource *r)
> -{
> -	if (!r)
> -		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> -
> -	/*
> -	 * The software controller support is only applicable to MBA resource.
> -	 * Make sure to check for resource type.
> -	 */
> -	if (r->rid != RDT_RESOURCE_MBA)
> -		return false;
> -
> -	return r->membw.mba_sc;
> -}
> -
>  /*
>   * rdt_get_mb_table() - get a mapping of bandwidth(b/w) percentage values
>   * exposed to user interface and the h/w understandable delay values.
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b4627ae19291..c5c3eaea27b6 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -23,260 +23,6 @@
>  
>  #include "internal.h"
>  
> -struct rdt_parse_data {
> -	struct rdtgroup		*rdtgrp;
> -	char			*buf;
> -};
> -
> -typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
> -			       struct resctrl_schema *s,
> -			       struct rdt_domain *d);
> -
> -/*
> - * Check whether MBA bandwidth percentage value is correct. The value is
> - * checked against the minimum and max bandwidth values specified by the
> - * hardware. The allocated bandwidth percentage is rounded to the next
> - * control step available on the hardware.
> - */
> -static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
> -{
> -	unsigned long bw;
> -	int ret;
> -
> -	/*
> -	 * Only linear delay values is supported for current Intel SKUs.
> -	 */
> -	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
> -		rdt_last_cmd_puts("No support for non-linear MB domains\n");
> -		return false;
> -	}
> -
> -	ret = kstrtoul(buf, 10, &bw);
> -	if (ret) {
> -		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> -		return false;
> -	}
> -
> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
> -	    !is_mba_sc(r)) {
> -		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
> -				    r->membw.min_bw, r->default_ctrl);
> -		return false;
> -	}
> -
> -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> -	return true;
> -}
> -
> -static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
> -		    struct rdt_domain *d)
> -{
> -	struct resctrl_staged_config *cfg;
> -	u32 closid = data->rdtgrp->closid;
> -	struct rdt_resource *r = s->res;
> -	unsigned long bw_val;
> -
> -	cfg = &d->staged_config[s->conf_type];
> -	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> -		return -EINVAL;
> -	}
> -
> -	if (!bw_validate(data->buf, &bw_val, r))
> -		return -EINVAL;
> -
> -	if (is_mba_sc(r)) {
> -		d->mbps_val[closid] = bw_val;
> -		return 0;
> -	}
> -
> -	cfg->new_ctrl = bw_val;
> -	cfg->have_new_ctrl = true;
> -
> -	return 0;
> -}
> -
> -/*
> - * Check whether a cache bit mask is valid.
> - * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
> - *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
> - *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
> - *
> - * Haswell does not support a non-contiguous 1s value and additionally
> - * requires at least two bits set.
> - * AMD allows non-contiguous bitmasks.
> - */
> -static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> -{
> -	unsigned long first_bit, zero_bit, val;
> -	unsigned int cbm_len = r->cache.cbm_len;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 16, &val);
> -	if (ret) {
> -		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
> -		return false;
> -	}
> -
> -	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > r->default_ctrl) {
> -		rdt_last_cmd_puts("Mask out of range\n");
> -		return false;
> -	}
> -
> -	first_bit = find_first_bit(&val, cbm_len);
> -	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> -
> -	/* Are non-contiguous bitmasks allowed? */
> -	if (!r->cache.arch_has_sparse_bitmasks &&
> -	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
> -		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
> -		return false;
> -	}
> -
> -	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> -		rdt_last_cmd_printf("Need at least %d bits in the mask\n",
> -				    r->cache.min_cbm_bits);
> -		return false;
> -	}
> -
> -	*data = val;
> -	return true;
> -}
> -
> -/*
> - * Read one cache bit mask (hex). Check that it is valid for the current
> - * resource type.
> - */
> -static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> -		     struct rdt_domain *d)
> -{
> -	struct rdtgroup *rdtgrp = data->rdtgrp;
> -	struct resctrl_staged_config *cfg;
> -	struct rdt_resource *r = s->res;
> -	u32 cbm_val;
> -
> -	cfg = &d->staged_config[s->conf_type];
> -	if (cfg->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Cannot set up more than one pseudo-locked region in a cache
> -	 * hierarchy.
> -	 */
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> -	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
> -		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!cbm_validate(data->buf, &cbm_val, r))
> -		return -EINVAL;
> -
> -	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> -	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
> -	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
> -		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * The CBM may not overlap with the CBM of another closid if
> -	 * either is exclusive.
> -	 */
> -	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
> -		rdt_last_cmd_puts("Overlaps with exclusive group\n");
> -		return -EINVAL;
> -	}
> -
> -	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
> -		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> -		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -			rdt_last_cmd_puts("Overlaps with other group\n");
> -			return -EINVAL;
> -		}
> -	}
> -
> -	cfg->new_ctrl = cbm_val;
> -	cfg->have_new_ctrl = true;
> -
> -	return 0;
> -}
> -
> -static ctrlval_parser_t *get_parser(struct rdt_resource *res)
> -{
> -	if (res->fflags & RFTYPE_RES_CACHE)
> -		return &parse_cbm;
> -	else
> -		return &parse_bw;
> -}
> -
> -/*
> - * For each domain in this resource we expect to find a series of:
> - *	id=mask
> - * separated by ";". The "id" is in decimal, and must match one of
> - * the "id"s for this resource.
> - */
> -static int parse_line(char *line, struct resctrl_schema *s,
> -		      struct rdtgroup *rdtgrp)
> -{
> -	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);
> -	enum resctrl_conf_type t = s->conf_type;
> -	struct resctrl_staged_config *cfg;
> -	struct rdt_resource *r = s->res;
> -	struct rdt_parse_data data;
> -	char *dom = NULL, *id;
> -	struct rdt_domain *d;
> -	unsigned long dom_id;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> -	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
> -		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
> -		return -EINVAL;
> -	}
> -
> -next:
> -	if (!line || line[0] == '\0')
> -		return 0;
> -	dom = strsep(&line, ";");
> -	id = strsep(&dom, "=");
> -	if (!dom || kstrtoul(id, 10, &dom_id)) {
> -		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
> -		return -EINVAL;
> -	}
> -	dom = strim(dom);
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (d->id == dom_id) {
> -			data.buf = dom;
> -			data.rdtgrp = rdtgrp;
> -			if (parse_ctrlval(&data, s, d))
> -				return -EINVAL;
> -			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
> -				cfg = &d->staged_config[t];
> -				/*
> -				 * In pseudo-locking setup mode and just
> -				 * parsed a valid CBM that should be
> -				 * pseudo-locked. Only one locked region per
> -				 * resource group and domain so just do
> -				 * the required initialization for single
> -				 * region and return.
> -				 */
> -				rdtgrp->plr->s = s;
> -				rdtgrp->plr->d = d;
> -				rdtgrp->plr->cbm = cfg->new_ctrl;
> -				d->plr = rdtgrp->plr;
> -				return 0;
> -			}
> -			goto next;
> -		}
> -	}
> -	return -EINVAL;
> -}
> -
>  static bool apply_config(struct rdt_hw_domain *hw_dom,
>  			 struct resctrl_staged_config *cfg, u32 idx,
>  			 cpumask_var_t cpu_mask)
> @@ -365,100 +111,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  	return 0;
>  }
>  
> -static int rdtgroup_parse_resource(char *resname, char *tok,
> -				   struct rdtgroup *rdtgrp)
> -{
> -	struct resctrl_schema *s;
> -
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
> -			return parse_line(tok, s, rdtgrp);
> -	}
> -	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
> -	return -EINVAL;
> -}
> -
> -ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
> -				char *buf, size_t nbytes, loff_t off)
> -{
> -	struct resctrl_schema *s;
> -	struct rdtgroup *rdtgrp;
> -	struct rdt_resource *r;
> -	char *tok, *resname;
> -	int ret = 0;
> -
> -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> -		return -EINVAL;
> -	buf[nbytes - 1] = '\0';
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		rdtgroup_kn_unlock(of->kn);
> -		return -ENOENT;
> -	}
> -	rdt_last_cmd_clear();
> -
> -	/*
> -	 * No changes to pseudo-locked region allowed. It has to be removed
> -	 * and re-created instead.
> -	 */
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -		ret = -EINVAL;
> -		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
> -		goto out;
> -	}
> -
> -	rdt_staged_configs_clear();
> -
> -	while ((tok = strsep(&buf, "\n")) != NULL) {
> -		resname = strim(strsep(&tok, ":"));
> -		if (!tok) {
> -			rdt_last_cmd_puts("Missing ':'\n");
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		if (tok[0] == '\0') {
> -			rdt_last_cmd_printf("Missing '%s' value\n", resname);
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		ret = rdtgroup_parse_resource(resname, tok, rdtgrp);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		r = s->res;
> -
> -		/*
> -		 * Writes to mba_sc resources update the software controller,
> -		 * not the control MSR.
> -		 */
> -		if (is_mba_sc(r))
> -			continue;
> -
> -		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -		/*
> -		 * If pseudo-locking fails we keep the resource group in
> -		 * mode RDT_MODE_PSEUDO_LOCKSETUP with its class of service
> -		 * active and updated for just the domain the pseudo-locked
> -		 * region was requested for.
> -		 */
> -		ret = rdtgroup_pseudo_lock_create(rdtgrp);
> -	}
> -
> -out:
> -	rdt_staged_configs_clear();
> -	rdtgroup_kn_unlock(of->kn);
> -	return ret ?: nbytes;
> -}
> -
>  u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type)
>  {
> @@ -467,160 +119,3 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  
>  	return hw_dom->ctrl_val[idx];
>  }
> -
> -static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
> -{
> -	struct rdt_resource *r = schema->res;
> -	struct rdt_domain *dom;
> -	bool sep = false;
> -	u32 ctrl_val;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	seq_printf(s, "%*s:", max_name_width, schema->name);
> -	list_for_each_entry(dom, &r->domains, list) {
> -		if (sep)
> -			seq_puts(s, ";");
> -
> -		if (is_mba_sc(r))
> -			ctrl_val = dom->mbps_val[closid];
> -		else
> -			ctrl_val = resctrl_arch_get_config(r, dom, closid,
> -							   schema->conf_type);
> -
> -		seq_printf(s, r->format_str, dom->id, max_data_width,
> -			   ctrl_val);
> -		sep = true;
> -	}
> -	seq_puts(s, "\n");
> -}
> -
> -int rdtgroup_schemata_show(struct kernfs_open_file *of,
> -			   struct seq_file *s, void *v)
> -{
> -	struct resctrl_schema *schema;
> -	struct rdtgroup *rdtgrp;
> -	int ret = 0;
> -	u32 closid;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (rdtgrp) {
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -			list_for_each_entry(schema, &resctrl_schema_all, list) {
> -				seq_printf(s, "%s:uninitialized\n", schema->name);
> -			}
> -		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -			if (!rdtgrp->plr->d) {
> -				rdt_last_cmd_clear();
> -				rdt_last_cmd_puts("Cache domain offline\n");
> -				ret = -ENODEV;
> -			} else {
> -				seq_printf(s, "%s:%d=%x\n",
> -					   rdtgrp->plr->s->res->name,
> -					   rdtgrp->plr->d->id,
> -					   rdtgrp->plr->cbm);
> -			}
> -		} else {
> -			closid = rdtgrp->closid;
> -			list_for_each_entry(schema, &resctrl_schema_all, list) {
> -				if (closid < schema->num_closid)
> -					show_doms(s, schema, closid);
> -			}
> -		}
> -	} else {
> -		ret = -ENOENT;
> -	}
> -	rdtgroup_kn_unlock(of->kn);
> -	return ret;
> -}
> -
> -static int smp_mon_event_count(void *arg)
> -{
> -	mon_event_count(arg);
> -
> -	return 0;
> -}
> -
> -void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> -		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
> -		    int evtid, int first)
> -{
> -	int cpu;
> -
> -	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	/*
> -	 * Setup the parameters to pass to mon_event_count() to read the data.
> -	 */
> -	rr->rgrp = rdtgrp;
> -	rr->evtid = evtid;
> -	rr->r = r;
> -	rr->d = d;
> -	rr->val = 0;
> -	rr->first = first;
> -	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> -	if (IS_ERR(rr->arch_mon_ctx)) {
> -		rr->err = -EINVAL;
> -		return;
> -	}
> -
> -	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
> -
> -	/*
> -	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> -	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
> -	 * MPAM's resctrl_arch_rmid_read() is unable to read the
> -	 * counters on some platforms if its called in IRQ context.
> -	 */
> -	if (tick_nohz_full_cpu(cpu))
> -		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> -	else
> -		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> -
> -	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> -}
> -
> -int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> -{
> -	struct kernfs_open_file *of = m->private;
> -	u32 resid, evtid, domid;
> -	struct rdtgroup *rdtgrp;
> -	struct rdt_resource *r;
> -	union mon_data_bits md;
> -	struct rdt_domain *d;
> -	struct rmid_read rr;
> -	int ret = 0;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		ret = -ENOENT;
> -		goto out;
> -	}
> -
> -	md.priv = of->kn->priv;
> -	resid = md.u.rid;
> -	domid = md.u.domid;
> -	evtid = md.u.evtid;
> -
> -	r = resctrl_arch_get_resource(resid);
> -	d = resctrl_arch_find_domain(r, domid);
> -	if (IS_ERR_OR_NULL(d)) {
> -		ret = -ENOENT;
> -		goto out;
> -	}
> -
> -	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
> -
> -	if (rr.err == -EIO)
> -		seq_puts(m, "Error\n");
> -	else if (rr.err == -EINVAL)
> -		seq_puts(m, "Unavailable\n");
> -	else
> -		seq_printf(m, "%llu\n", rr.val);
> -
> -out:
> -	rdtgroup_kn_unlock(of->kn);
> -	return ret;
> -}
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 0f7e3f10941b..bf3538992667 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -26,227 +26,6 @@
>   */
>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>  
> -/**
> - * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
> - *			        aren't marked nohz_full
> - * @mask:	The mask to pick a CPU from.
> - * @exclude_cpu:The CPU to avoid picking.
> - *
> - * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
> - * CPUs that don't use nohz_full, these are preferred. Pass
> - * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
> - *
> - * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
> - */
> -static inline unsigned int
> -cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
> -{
> -	unsigned int cpu, hk_cpu;
> -
> -	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> -		cpu = cpumask_any(mask);
> -	else
> -		cpu = cpumask_any_but(mask, exclude_cpu);
> -
> -	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> -		return cpu;
> -
> -	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
> -	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
> -		return cpu;
> -
> -	/* Try to find a CPU that isn't nohz_full to use in preference */
> -	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> -	if (hk_cpu == exclude_cpu)
> -		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
> -
> -	if (hk_cpu < nr_cpu_ids)
> -		cpu = hk_cpu;
> -
> -	return cpu;
> -}
> -
> -struct rdt_fs_context {
> -	struct kernfs_fs_context	kfc;
> -	bool				enable_cdpl2;
> -	bool				enable_cdpl3;
> -	bool				enable_mba_mbps;
> -	bool				enable_debug;
> -};
> -
> -static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
> -{
> -	struct kernfs_fs_context *kfc = fc->fs_private;
> -
> -	return container_of(kfc, struct rdt_fs_context, kfc);
> -}
> -
> -/**
> - * struct mon_evt - Entry in the event list of a resource
> - * @evtid:		event id
> - * @name:		name of the event
> - * @configurable:	true if the event is configurable
> - * @list:		entry in &rdt_resource->evt_list
> - */
> -struct mon_evt {
> -	enum resctrl_event_id	evtid;
> -	char			*name;
> -	bool			configurable;
> -	struct list_head	list;
> -};
> -
> -/**
> - * union mon_data_bits - Monitoring details for each event file
> - * @priv:              Used to store monitoring event data in @u
> - *                     as kernfs private data
> - * @rid:               Resource id associated with the event file
> - * @evtid:             Event id associated with the event file
> - * @domid:             The domain to which the event file belongs
> - * @u:                 Name of the bit fields struct
> - */
> -union mon_data_bits {
> -	void *priv;
> -	struct {
> -		unsigned int rid		: 10;
> -		enum resctrl_event_id evtid	: 8;
> -		unsigned int domid		: 14;
> -	} u;
> -};
> -
> -struct rmid_read {
> -	struct rdtgroup		*rgrp;
> -	struct rdt_resource	*r;
> -	struct rdt_domain	*d;
> -	enum resctrl_event_id	evtid;
> -	bool			first;
> -	int			err;
> -	u64			val;
> -	void			*arch_mon_ctx;
> -};
> -
> -extern struct list_head resctrl_schema_all;
> -extern bool resctrl_mounted;
> -
> -enum rdt_group_type {
> -	RDTCTRL_GROUP = 0,
> -	RDTMON_GROUP,
> -	RDT_NUM_GROUP,
> -};
> -
> -/**
> - * enum rdtgrp_mode - Mode of a RDT resource group
> - * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
> - * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
> - * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
> - * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
> - *                          allowed AND the allocations are Cache Pseudo-Locked
> - * @RDT_NUM_MODES: Total number of modes
> - *
> - * The mode of a resource group enables control over the allowed overlap
> - * between allocations associated with different resource groups (classes
> - * of service). User is able to modify the mode of a resource group by
> - * writing to the "mode" resctrl file associated with the resource group.
> - *
> - * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
> - * writing the appropriate text to the "mode" file. A resource group enters
> - * "pseudo-locked" mode after the schemata is written while the resource
> - * group is in "pseudo-locksetup" mode.
> - */
> -enum rdtgrp_mode {
> -	RDT_MODE_SHAREABLE = 0,
> -	RDT_MODE_EXCLUSIVE,
> -	RDT_MODE_PSEUDO_LOCKSETUP,
> -	RDT_MODE_PSEUDO_LOCKED,
> -
> -	/* Must be last */
> -	RDT_NUM_MODES,
> -};
> -
> -/**
> - * struct mongroup - store mon group's data in resctrl fs.
> - * @mon_data_kn:		kernfs node for the mon_data directory
> - * @parent:			parent rdtgrp
> - * @crdtgrp_list:		child rdtgroup node list
> - * @rmid:			rmid for this rdtgroup
> - */
> -struct mongroup {
> -	struct kernfs_node	*mon_data_kn;
> -	struct rdtgroup		*parent;
> -	struct list_head	crdtgrp_list;
> -	u32			rmid;
> -};
> -
> -/**
> - * struct rdtgroup - store rdtgroup's data in resctrl file system.
> - * @kn:				kernfs node
> - * @rdtgroup_list:		linked list for all rdtgroups
> - * @closid:			closid for this rdtgroup
> - * @cpu_mask:			CPUs assigned to this rdtgroup
> - * @flags:			status bits
> - * @waitcount:			how many cpus expect to find this
> - *				group when they acquire rdtgroup_mutex
> - * @type:			indicates type of this rdtgroup - either
> - *				monitor only or ctrl_mon group
> - * @mon:			mongroup related data
> - * @mode:			mode of resource group
> - * @plr:			pseudo-locked region
> - */
> -struct rdtgroup {
> -	struct kernfs_node		*kn;
> -	struct list_head		rdtgroup_list;
> -	u32				closid;
> -	struct cpumask			cpu_mask;
> -	int				flags;
> -	atomic_t			waitcount;
> -	enum rdt_group_type		type;
> -	struct mongroup			mon;
> -	enum rdtgrp_mode		mode;
> -	struct pseudo_lock_region	*plr;
> -};
> -
> -/* List of all resource groups */
> -extern struct list_head rdt_all_groups;
> -
> -extern int max_name_width, max_data_width;
> -
> -/**
> - * struct rftype - describe each file in the resctrl file system
> - * @name:	File name
> - * @mode:	Access mode
> - * @kf_ops:	File operations
> - * @flags:	File specific RFTYPE_FLAGS_* flags
> - * @fflags:	File specific RFTYPE_* flags
> - * @seq_show:	Show content of the file
> - * @write:	Write to the file
> - */
> -struct rftype {
> -	char			*name;
> -	umode_t			mode;
> -	const struct kernfs_ops	*kf_ops;
> -	unsigned long		flags;
> -	unsigned long		fflags;
> -
> -	int (*seq_show)(struct kernfs_open_file *of,
> -			struct seq_file *sf, void *v);
> -	/*
> -	 * write() is the generic write callback which maps directly to
> -	 * kernfs write operation and overrides all other operations.
> -	 * Maximum write size is determined by ->max_write_len.
> -	 */
> -	ssize_t (*write)(struct kernfs_open_file *of,
> -			 char *buf, size_t nbytes, loff_t off);
> -};
> -
> -/**
> - * struct mbm_state - status for each MBM counter in each domain
> - * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
> - * @prev_bw:	The most recent bandwidth in MBps
> - */
> -struct mbm_state {
> -	u64	prev_bw_bytes;
> -	u32	prev_bw;
> -};
> -
>  /**
>   * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
>   *			   return value.
> @@ -327,11 +106,7 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
>  	return container_of(r, struct rdt_hw_resource, r_resctrl);
>  }
>  
> -extern struct mutex rdtgroup_mutex;
> -
>  extern struct rdt_hw_resource rdt_resources_all[];
> -extern struct rdtgroup rdtgroup_default;
> -extern struct dentry *debugfs_resctrl;
>  
>  static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
>  {
> @@ -395,95 +170,10 @@ union cpuid_0x10_x_edx {
>  	unsigned int full;
>  };
>  
> -void rdt_last_cmd_clear(void);
> -void rdt_last_cmd_puts(const char *s);
> -__printf(1, 2)
> -void rdt_last_cmd_printf(const char *fmt, ...);
> -
>  void rdt_ctrl_update(void *arg);
> -struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
> -void rdtgroup_kn_unlock(struct kernfs_node *kn);
> -int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
> -int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
> -			     umode_t mask);
> -ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
> -				char *buf, size_t nbytes, loff_t off);
> -int rdtgroup_schemata_show(struct kernfs_open_file *of,
> -			   struct seq_file *s, void *v);
> -bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
> -			   unsigned long cbm, int closid, bool exclusive);
> -unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
> -				  unsigned long cbm);
> -enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
> -int rdtgroup_tasks_assigned(struct rdtgroup *r);
> -int closids_supported(void);
> -void closid_free(int closid);
> -int alloc_rmid(u32 closid);
> -void free_rmid(u32 closid, u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
> -void resctrl_mon_resource_exit(void);
>  bool rdt_cpu_has(int flag);
> -void mon_event_count(void *info);
> -int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> -void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> -		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
> -		    int evtid, int first);
> -int resctrl_mon_resource_init(void);
> -void mbm_setup_overflow_handler(struct rdt_domain *dom,
> -				unsigned long delay_ms,
> -				int exclude_cpu);
> -void mbm_handle_overflow(struct work_struct *work);
>  void __init intel_rdt_mbm_apply_quirk(void);
> -bool is_mba_sc(struct rdt_resource *r);
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> -			     int exclude_cpu);
> -void cqm_handle_limbo(struct work_struct *work);
> -bool has_busy_rmid(struct rdt_domain *d);
> -void __check_limbo(struct rdt_domain *d, bool force_free);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
> -void mbm_config_rftype_init(const char *config);
> -void rdt_staged_configs_clear(void);
> -bool closid_allocated(unsigned int closid);
> -int resctrl_find_cleanest_closid(void);
> -
> -#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
> -int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> -int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
> -bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm);
> -bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
> -int rdt_pseudo_lock_init(void);
> -void rdt_pseudo_lock_release(void);
> -int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
> -void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
> -#else
> -static inline int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
> -{
> -	return false;
> -}
> -
> -static inline bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
> -{
> -	return false;
> -}
> -
> -static inline int rdt_pseudo_lock_init(void) { return 0; }
> -static inline void rdt_pseudo_lock_release(void) { }
> -static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
> -#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
>  
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 7e6fca138cb7..02fb9d87479a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -25,53 +25,6 @@
>  
>  #include "internal.h"
>  
> -/**
> - * struct rmid_entry - dirty tracking for all RMID.
> - * @closid:	The CLOSID for this entry.
> - * @rmid:	The RMID for this entry.
> - * @busy:	The number of domains with cached data using this RMID.
> - * @list:	Member of the rmid_free_lru list when busy == 0.
> - *
> - * Depending on the architecture the correct monitor is accessed using
> - * both @closid and @rmid, or @rmid only.
> - *
> - * Take the rdtgroup_mutex when accessing.
> - */
> -struct rmid_entry {
> -	u32				closid;
> -	u32				rmid;
> -	int				busy;
> -	struct list_head		list;
> -};
> -
> -/*
> - * @rmid_free_lru - A least recently used list of free RMIDs
> - *     These RMIDs are guaranteed to have an occupancy less than the
> - *     threshold occupancy
> - */
> -static LIST_HEAD(rmid_free_lru);
> -
> -/*
> - * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
> - *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
> - *     Indexed by CLOSID. Protected by rdtgroup_mutex.
> - */
> -static u32 *closid_num_dirty_rmid;
> -
> -/*
> - * @rmid_limbo_count - count of currently unused but (potentially)
> - *     dirty RMIDs.
> - *     This counts RMIDs that no one is currently using but that
> - *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
> - *     change the threshold occupancy value.
> - */
> -static unsigned int rmid_limbo_count;
> -
> -/*
> - * @rmid_entry - The entry in the limbo and free lists.
> - */
> -static struct rmid_entry	*rmid_ptrs;
> -
>  /*
>   * Global boolean for rdt_monitor which is true if any
>   * resource monitoring is enabled.
> @@ -83,17 +36,6 @@ bool rdt_mon_capable;
>   */
>  unsigned int rdt_mon_features;
>  
> -/*
> - * This is the threshold cache occupancy in bytes at which we will consider an
> - * RMID available for re-allocation.
> - */
> -unsigned int resctrl_rmid_realloc_threshold;
> -
> -/*
> - * This is the maximum value for the reallocation threshold, in bytes.
> - */
> -unsigned int resctrl_rmid_realloc_limit;
> -
>  #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
>  
>  /*
> @@ -157,33 +99,6 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>  	return val;
>  }
>  
> -/*
> - * x86 and arm64 differ in their handling of monitoring.
> - * x86's RMID are independent numbers, there is only one source of traffic
> - * with an RMID value of '1'.
> - * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
> - * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
> - * value is no longer unique.
> - * To account for this, resctrl uses an index. On x86 this is just the RMID,
> - * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> - *
> - * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch code
> - * must accept an attempt to read every index.
> - */
> -static inline struct rmid_entry *__rmid_entry(u32 idx)
> -{
> -	struct rmid_entry *entry;
> -	u32 closid, rmid;
> -
> -	entry = &rmid_ptrs[idx];
> -	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
> -
> -	WARN_ON_ONCE(entry->closid != closid);
> -	WARN_ON_ONCE(entry->rmid != rmid);
> -
> -	return entry;
> -}
> -
>  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
>  	u64 msr_val;
> @@ -302,735 +217,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	return 0;
>  }
>  
> -static void limbo_release_entry(struct rmid_entry *entry)
> -{
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	rmid_limbo_count--;
> -	list_add_tail(&entry->list, &rmid_free_lru);
> -
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -		closid_num_dirty_rmid[entry->closid]--;
> -}
> -
> -/*
> - * Check the RMIDs that are marked as busy for this domain. If the
> - * reported LLC occupancy is below the threshold clear the busy bit and
> - * decrement the count. If the busy count gets to zero on an RMID, we
> - * free the RMID
> - */
> -void __check_limbo(struct rdt_domain *d, bool force_free)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> -	struct rmid_entry *entry;
> -	u32 idx, cur_idx = 1;
> -	void *arch_mon_ctx;
> -	bool rmid_dirty;
> -	u64 val = 0;
> -
> -	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> -	if (IS_ERR(arch_mon_ctx)) {
> -		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> -				    PTR_ERR(arch_mon_ctx));
> -		return;
> -	}
> -
> -	/*
> -	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
> -	 * are marked as busy for occupancy < threshold. If the occupancy
> -	 * is less than the threshold decrement the busy counter of the
> -	 * RMID and move it to the free list when the counter reaches 0.
> -	 */
> -	for (;;) {
> -		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> -		if (idx >= idx_limit)
> -			break;
> -
> -		entry = __rmid_entry(idx);
> -		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> -					   QOS_L3_OCCUP_EVENT_ID, &val,
> -					   arch_mon_ctx)) {
> -			rmid_dirty = true;
> -		} else {
> -			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> -		}
> -
> -		if (force_free || !rmid_dirty) {
> -			clear_bit(idx, d->rmid_busy_llc);
> -			if (!--entry->busy)
> -				limbo_release_entry(entry);
> -		}
> -		cur_idx = idx + 1;
> -	}
> -
> -	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
> -}
> -
> -bool has_busy_rmid(struct rdt_domain *d)
> -{
> -	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> -
> -	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
> -}
> -
> -static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
> -{
> -	struct rmid_entry *itr;
> -	u32 itr_idx, cmp_idx;
> -
> -	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> -
> -	list_for_each_entry(itr, &rmid_free_lru, list) {
> -		/*
> -		 * Get the index of this free RMID, and the index it would need
> -		 * to be if it were used with this CLOSID.
> -		 * If the CLOSID is irrelevant on this architecture, the two
> -		 * index values are always the same on every entry and thus the
> -		 * very first entry will be returned.
> -		 */
> -		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> -		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> -
> -		if (itr_idx == cmp_idx)
> -			return itr;
> -	}
> -
> -	return ERR_PTR(-ENOSPC);
> -}
> -
> -/**
> - * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> - *                                  RMID are clean, or the CLOSID that has
> - *                                  the most clean RMID.
> - *
> - * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> - * may not be able to allocate clean RMID. To avoid this the allocator will
> - * choose the CLOSID with the most clean RMID.
> - *
> - * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> - * be returned.
> - */
> -int resctrl_find_cleanest_closid(void)
> -{
> -	u32 cleanest_closid = ~0;
> -	int i = 0;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -		return -EIO;
> -
> -	for (i = 0; i < closids_supported(); i++) {
> -		int num_dirty;
> -
> -		if (closid_allocated(i))
> -			continue;
> -
> -		num_dirty = closid_num_dirty_rmid[i];
> -		if (num_dirty == 0)
> -			return i;
> -
> -		if (cleanest_closid == ~0)
> -			cleanest_closid = i;
> -
> -		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
> -			cleanest_closid = i;
> -	}
> -
> -	if (cleanest_closid == ~0)
> -		return -ENOSPC;
> -
> -	return cleanest_closid;
> -}
> -
> -/*
> - * For MPAM the RMID value is not unique, and has to be considered with
> - * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> - * allows all domains to be managed by a single free list.
> - * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
> - */
> -int alloc_rmid(u32 closid)
> -{
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	entry = resctrl_find_free_rmid(closid);
> -	if (IS_ERR(entry))
> -		return PTR_ERR(entry);
> -
> -	list_del(&entry->list);
> -	return entry->rmid;
> -}
> -
> -static void add_rmid_to_limbo(struct rmid_entry *entry)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	struct rdt_domain *d;
> -	u32 idx;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
> -
> -	entry->busy = 0;
> -	list_for_each_entry(d, &r->domains, list) {
> -		/*
> -		 * For the first limbo RMID in the domain,
> -		 * setup up the limbo worker.
> -		 */
> -		if (!has_busy_rmid(d))
> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
> -						RESCTRL_PICK_ANY_CPU);
> -		set_bit(idx, d->rmid_busy_llc);
> -		entry->busy++;
> -	}
> -
> -	rmid_limbo_count++;
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> -		closid_num_dirty_rmid[entry->closid]++;
> -}
> -
> -void free_rmid(u32 closid, u32 rmid)
> -{
> -	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	/*
> -	 * Do not allow the default rmid to be free'd. Comparing by index
> -	 * allows architectures that ignore the closid parameter to avoid an
> -	 * unnecessary check.
> -	 */
> -	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> -						RESCTRL_RESERVED_RMID))
> -		return;
> -
> -	entry = __rmid_entry(idx);
> -
> -	if (resctrl_arch_is_llc_occupancy_enabled())
> -		add_rmid_to_limbo(entry);
> -	else
> -		list_add_tail(&entry->list, &rmid_free_lru);
> -}
> -
> -static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
> -				       u32 rmid, enum resctrl_event_id evtid)
> -{
> -	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> -
> -	switch (evtid) {
> -	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		return &d->mbm_total[idx];
> -	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		return &d->mbm_local[idx];
> -	default:
> -		return NULL;
> -	}
> -}
> -
> -static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
> -{
> -	struct mbm_state *m;
> -	u64 tval = 0;
> -
> -	if (rr->first) {
> -		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
> -		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
> -		if (m)
> -			memset(m, 0, sizeof(struct mbm_state));
> -		return 0;
> -	}
> -
> -	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> -					 &tval, rr->arch_mon_ctx);
> -	if (rr->err)
> -		return rr->err;
> -
> -	rr->val += tval;
> -
> -	return 0;
> -}
> -
> -/*
> - * mbm_bw_count() - Update bw count from values previously read by
> - *		    __mon_event_count().
> - * @closid:	The closid used to identify the cached mbm_state.
> - * @rmid:	The rmid used to identify the cached mbm_state.
> - * @rr:		The struct rmid_read populated by __mon_event_count().
> - *
> - * Supporting function to calculate the memory bandwidth
> - * and delta bandwidth in MBps. The chunks value previously read by
> - * __mon_event_count() is compared with the chunks value from the previous
> - * invocation. This must be called once per second to maintain values in MBps.
> - */
> -static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
> -{
> -	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> -	struct mbm_state *m = &rr->d->mbm_local[idx];
> -	u64 cur_bw, bytes, cur_bytes;
> -
> -	cur_bytes = rr->val;
> -	bytes = cur_bytes - m->prev_bw_bytes;
> -	m->prev_bw_bytes = cur_bytes;
> -
> -	cur_bw = bytes / SZ_1M;
> -
> -	m->prev_bw = cur_bw;
> -}
> -
> -/*
> - * This is scheduled by mon_event_read() to read the CQM/MBM counters
> - * on a domain.
> - */
> -void mon_event_count(void *info)
> -{
> -	struct rdtgroup *rdtgrp, *entry;
> -	struct rmid_read *rr = info;
> -	struct list_head *head;
> -	int ret;
> -
> -	rdtgrp = rr->rgrp;
> -
> -	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
> -
> -	/*
> -	 * For Ctrl groups read data from child monitor groups and
> -	 * add them together. Count events which are read successfully.
> -	 * Discard the rmid_read's reporting errors.
> -	 */
> -	head = &rdtgrp->mon.crdtgrp_list;
> -
> -	if (rdtgrp->type == RDTCTRL_GROUP) {
> -		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -			if (__mon_event_count(entry->closid, entry->mon.rmid,
> -					      rr) == 0)
> -				ret = 0;
> -		}
> -	}
> -
> -	/*
> -	 * __mon_event_count() calls for newly created monitor groups may
> -	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
> -	 * Discard error if any of the monitor event reads succeeded.
> -	 */
> -	if (ret == 0)
> -		rr->err = 0;
> -}
> -
> -/*
> - * Feedback loop for MBA software controller (mba_sc)
> - *
> - * mba_sc is a feedback loop where we periodically read MBM counters and
> - * adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs so
> - * that:
> - *
> - *   current bandwidth(cur_bw) < user specified bandwidth(user_bw)
> - *
> - * This uses the MBM counters to measure the bandwidth and MBA throttle
> - * MSRs to control the bandwidth for a particular rdtgrp. It builds on the
> - * fact that resctrl rdtgroups have both monitoring and control.
> - *
> - * The frequency of the checks is 1s and we just tag along the MBM overflow
> - * timer. Having 1s interval makes the calculation of bandwidth simpler.
> - *
> - * Although MBA's goal is to restrict the bandwidth to a maximum, there may
> - * be a need to increase the bandwidth to avoid unnecessarily restricting
> - * the L2 <-> L3 traffic.
> - *
> - * Since MBA controls the L2 external bandwidth where as MBM measures the
> - * L3 external bandwidth the following sequence could lead to such a
> - * situation.
> - *
> - * Consider an rdtgroup which had high L3 <-> memory traffic in initial
> - * phases -> mba_sc kicks in and reduced bandwidth percentage values -> but
> - * after some time rdtgroup has mostly L2 <-> L3 traffic.
> - *
> - * In this case we may restrict the rdtgroup's L2 <-> L3 traffic as its
> - * throttle MSRs already have low percentage values.  To avoid
> - * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
> - */
> -static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
> -{
> -	u32 closid, rmid, cur_msr_val, new_msr_val;
> -	struct mbm_state *pmbm_data, *cmbm_data;
> -	struct rdt_resource *r_mba;
> -	struct rdt_domain *dom_mba;
> -	u32 cur_bw, user_bw, idx;
> -	struct list_head *head;
> -	struct rdtgroup *entry;
> -
> -	if (!resctrl_arch_is_mbm_local_enabled())
> -		return;
> -
> -	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> -
> -	closid = rgrp->closid;
> -	rmid = rgrp->mon.rmid;
> -	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> -	pmbm_data = &dom_mbm->mbm_local[idx];
> -
> -	dom_mba = resctrl_get_domain_from_cpu(smp_processor_id(), r_mba);
> -	if (!dom_mba) {
> -		pr_warn_once("Failure to get domain for MBA update\n");
> -		return;
> -	}
> -
> -	cur_bw = pmbm_data->prev_bw;
> -	user_bw = dom_mba->mbps_val[closid];
> -
> -	/* MBA resource doesn't support CDP */
> -	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
> -
> -	/*
> -	 * For Ctrl groups read data from child monitor groups.
> -	 */
> -	head = &rgrp->mon.crdtgrp_list;
> -	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> -		cur_bw += cmbm_data->prev_bw;
> -	}
> -
> -	/*
> -	 * Scale up/down the bandwidth linearly for the ctrl group.  The
> -	 * bandwidth step is the bandwidth granularity specified by the
> -	 * hardware.
> -	 * Always increase throttling if current bandwidth is above the
> -	 * target set by user.
> -	 * But avoid thrashing up and down on every poll by checking
> -	 * whether a decrease in throttling is likely to push the group
> -	 * back over target. E.g. if currently throttling to 30% of bandwidth
> -	 * on a system with 10% granularity steps, check whether moving to
> -	 * 40% would go past the limit by multiplying current bandwidth by
> -	 * "(30 + 10) / 30".
> -	 */
> -	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
> -		new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
> -	} else if (cur_msr_val < MAX_MBA_BW &&
> -		   (user_bw > (cur_bw * (cur_msr_val + r_mba->membw.min_bw) / cur_msr_val))) {
> -		new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
> -	} else {
> -		return;
> -	}
> -
> -	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
> -}
> -
> -static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
> -		       u32 closid, u32 rmid)
> -{
> -	struct rmid_read rr;
> -
> -	rr.first = false;
> -	rr.r = r;
> -	rr.d = d;
> -
> -	/*
> -	 * This is protected from concurrent reads from user
> -	 * as both the user and we hold the global mutex.
> -	 */
> -	if (resctrl_arch_is_mbm_total_enabled()) {
> -		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
> -		rr.val = 0;
> -		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> -		if (IS_ERR(rr.arch_mon_ctx)) {
> -			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> -					    PTR_ERR(rr.arch_mon_ctx));
> -			return;
> -		}
> -
> -		__mon_event_count(closid, rmid, &rr);
> -
> -		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
> -	}
> -	if (resctrl_arch_is_mbm_local_enabled()) {
> -		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
> -		rr.val = 0;
> -		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> -		if (IS_ERR(rr.arch_mon_ctx)) {
> -			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> -					    PTR_ERR(rr.arch_mon_ctx));
> -			return;
> -		}
> -
> -		__mon_event_count(closid, rmid, &rr);
> -
> -		/*
> -		 * Call the MBA software controller only for the
> -		 * control groups and when user has enabled
> -		 * the software controller explicitly.
> -		 */
> -		if (is_mba_sc(NULL))
> -			mbm_bw_count(closid, rmid, &rr);
> -
> -		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
> -	}
> -}
> -
> -/*
> - * Handler to scan the limbo list and move the RMIDs
> - * to free list whose occupancy < threshold_occupancy.
> - */
> -void cqm_handle_limbo(struct work_struct *work)
> -{
> -	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
> -	struct rdt_domain *d;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	d = container_of(work, struct rdt_domain, cqm_limbo.work);
> -
> -	__check_limbo(d, false);
> -
> -	if (has_busy_rmid(d)) {
> -		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
> -							   RESCTRL_PICK_ANY_CPU);
> -		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
> -					 delay);
> -	}
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -}
> -
> -/**
> - * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
> - *                             domain.
> - * @dom:           The domain the limbo handler should run for.
> - * @delay_ms:      How far in the future the handler should run.
> - * @exclude_cpu:   Which CPU the handler should not run on,
> - *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> - */
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> -			     int exclude_cpu)
> -{
> -	unsigned long delay = msecs_to_jiffies(delay_ms);
> -	int cpu;
> -
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
> -	dom->cqm_work_cpu = cpu;
> -
> -	if (cpu < nr_cpu_ids)
> -		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> -}
> -
> -void mbm_handle_overflow(struct work_struct *work)
> -{
> -	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
> -	struct rdtgroup *prgrp, *crgrp;
> -	struct list_head *head;
> -	struct rdt_resource *r;
> -	struct rdt_domain *d;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	/*
> -	 * If the filesystem has been unmounted this work no longer needs to
> -	 * run.
> -	 */
> -	if (!resctrl_mounted || !resctrl_arch_mon_capable())
> -		goto out_unlock;
> -
> -	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	d = container_of(work, struct rdt_domain, mbm_over.work);
> -
> -	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
> -
> -		head = &prgrp->mon.crdtgrp_list;
> -		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
> -
> -		if (is_mba_sc(NULL))
> -			update_mba_bw(prgrp, d);
> -	}
> -
> -	/*
> -	 * Re-check for housekeeping CPUs. This allows the overflow handler to
> -	 * move off a nohz_full CPU quickly.
> -	 */
> -	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
> -						   RESCTRL_PICK_ANY_CPU);
> -	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -}
> -
> -/**
> - * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
> - *                                domain.
> - * @dom:           The domain the overflow handler should run for.
> - * @delay_ms:      How far in the future the handler should run.
> - * @exclude_cpu:   Which CPU the handler should not run on,
> - *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> - */
> -void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
> -				int exclude_cpu)
> -{
> -	unsigned long delay = msecs_to_jiffies(delay_ms);
> -	int cpu;
> -
> -	/*
> -	 * When a domain comes online there is no guarantee the filesystem is
> -	 * mounted. If not, there is no need to catch counter overflow.
> -	 */
> -	if (!resctrl_mounted || !resctrl_arch_mon_capable())
> -		return;
> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
> -	dom->mbm_work_cpu = cpu;
> -
> -	if (cpu < nr_cpu_ids)
> -		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
> -}
> -
> -static int dom_data_init(struct rdt_resource *r)
> -{
> -	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> -	u32 num_closid = resctrl_arch_get_num_closid(r);
> -	struct rmid_entry *entry = NULL;
> -	int err = 0, i;
> -	u32 idx;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> -		u32 *tmp;
> -
> -		/*
> -		 * If the architecture hasn't provided a sanitised value here,
> -		 * this may result in larger arrays than necessary. Resctrl will
> -		 * use a smaller system wide value based on the resources in
> -		 * use.
> -		 */
> -		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
> -		if (!tmp) {
> -			err = -ENOMEM;
> -			goto out_unlock;
> -		}
> -
> -		closid_num_dirty_rmid = tmp;
> -	}
> -
> -	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> -	if (!rmid_ptrs) {
> -		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> -			kfree(closid_num_dirty_rmid);
> -			closid_num_dirty_rmid = NULL;
> -		}
> -		err = -ENOMEM;
> -		goto out_unlock;
> -	}
> -
> -	for (i = 0; i < idx_limit; i++) {
> -		entry = &rmid_ptrs[i];
> -		INIT_LIST_HEAD(&entry->list);
> -
> -		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
> -		list_add_tail(&entry->list, &rmid_free_lru);
> -	}
> -
> -	/*
> -	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
> -	 * are always allocated. These are used for the rdtgroup_default
> -	 * control group, which will be setup later in rdtgroup_init().
> -	 */
> -	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> -					   RESCTRL_RESERVED_RMID);
> -	entry = __rmid_entry(idx);
> -	list_del(&entry->list);
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return err;
> -}
> -
> -static void dom_data_exit(struct rdt_resource *r)
> -{
> -	if (!r->mon_capable)
> -		return;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> -		kfree(closid_num_dirty_rmid);
> -		closid_num_dirty_rmid = NULL;
> -	}
> -
> -	kfree(rmid_ptrs);
> -	rmid_ptrs = NULL;
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -}
> -
> -static struct mon_evt llc_occupancy_event = {
> -	.name		= "llc_occupancy",
> -	.evtid		= QOS_L3_OCCUP_EVENT_ID,
> -};
> -
> -static struct mon_evt mbm_total_event = {
> -	.name		= "mbm_total_bytes",
> -	.evtid		= QOS_L3_MBM_TOTAL_EVENT_ID,
> -};
> -
> -static struct mon_evt mbm_local_event = {
> -	.name		= "mbm_local_bytes",
> -	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
> -};
> -
> -/*
> - * Initialize the event list for the resource.
> - *
> - * Note that MBM events are also part of RDT_RESOURCE_L3 resource
> - * because as per the SDM the total and local memory bandwidth
> - * are enumerated as part of L3 monitoring.
> - */
> -static void l3_mon_evt_init(struct rdt_resource *r)
> -{
> -	INIT_LIST_HEAD(&r->evt_list);
> -
> -	if (resctrl_arch_is_llc_occupancy_enabled())
> -		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
> -	if (resctrl_arch_is_mbm_total_enabled())
> -		list_add_tail(&mbm_total_event.list, &r->evt_list);
> -	if (resctrl_arch_is_mbm_local_enabled())
> -		list_add_tail(&mbm_local_event.list, &r->evt_list);
> -}
> -
> -int resctrl_mon_resource_init(void)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	int ret;
> -
> -	if (!r->mon_capable)
> -		return 0;
> -
> -	ret = dom_data_init(r);
> -	if (ret)
> -		return ret;
> -
> -	l3_mon_evt_init(r);
> -
> -	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
> -		mbm_total_event.configurable = true;
> -		mbm_config_rftype_init("mbm_total_bytes_config");
> -	}
> -	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
> -		mbm_local_event.configurable = true;
> -		mbm_config_rftype_init("mbm_local_bytes_config");
> -	}
> -
> -	return 0;
> -}
> -
>  int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  {
>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
> @@ -1076,13 +262,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	return 0;
>  }
>  
> -void resctrl_mon_resource_exit(void)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -
> -	dom_data_exit(r);
> -}
> -
>  void __init intel_rdt_mbm_apply_quirk(void)
>  {
>  	int cf_index;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index ba51ab1f70e6..ba1596afee10 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -39,28 +39,6 @@
>   */
>  static u64 prefetch_disable_bits;
>  
> -/*
> - * Major number assigned to and shared by all devices exposing
> - * pseudo-locked regions.
> - */
> -static unsigned int pseudo_lock_major;
> -static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
> -
> -static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
> -{
> -	const struct rdtgroup *rdtgrp;
> -
> -	rdtgrp = dev_get_drvdata(dev);
> -	if (mode)
> -		*mode = 0600;
> -	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdtgrp->kn->name);
> -}
> -
> -static const struct class pseudo_lock_class = {
> -	.name = "pseudo_lock",
> -	.devnode = pseudo_lock_devnode,
> -};
> -
>  /**
>   * resctrl_arch_get_prefetch_disable_bits - prefetch disable bits of supported
>   *                                          platforms
> @@ -121,299 +99,6 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
>  	return prefetch_disable_bits;
>  }
>  
> -/**
> - * pseudo_lock_minor_get - Obtain available minor number
> - * @minor: Pointer to where new minor number will be stored
> - *
> - * A bitmask is used to track available minor numbers. Here the next free
> - * minor number is marked as unavailable and returned.
> - *
> - * Return: 0 on success, <0 on failure.
> - */
> -static int pseudo_lock_minor_get(unsigned int *minor)
> -{
> -	unsigned long first_bit;
> -
> -	first_bit = find_first_bit(&pseudo_lock_minor_avail, MINORBITS);
> -
> -	if (first_bit == MINORBITS)
> -		return -ENOSPC;
> -
> -	__clear_bit(first_bit, &pseudo_lock_minor_avail);
> -	*minor = first_bit;
> -
> -	return 0;
> -}
> -
> -/**
> - * pseudo_lock_minor_release - Return minor number to available
> - * @minor: The minor number made available
> - */
> -static void pseudo_lock_minor_release(unsigned int minor)
> -{
> -	__set_bit(minor, &pseudo_lock_minor_avail);
> -}
> -
> -/**
> - * region_find_by_minor - Locate a pseudo-lock region by inode minor number
> - * @minor: The minor number of the device representing pseudo-locked region
> - *
> - * When the character device is accessed we need to determine which
> - * pseudo-locked region it belongs to. This is done by matching the minor
> - * number of the device to the pseudo-locked region it belongs.
> - *
> - * Minor numbers are assigned at the time a pseudo-locked region is associated
> - * with a cache instance.
> - *
> - * Return: On success return pointer to resource group owning the pseudo-locked
> - *         region, NULL on failure.
> - */
> -static struct rdtgroup *region_find_by_minor(unsigned int minor)
> -{
> -	struct rdtgroup *rdtgrp, *rdtgrp_match = NULL;
> -
> -	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> -		if (rdtgrp->plr && rdtgrp->plr->minor == minor) {
> -			rdtgrp_match = rdtgrp;
> -			break;
> -		}
> -	}
> -	return rdtgrp_match;
> -}
> -
> -/**
> - * struct pseudo_lock_pm_req - A power management QoS request list entry
> - * @list:	Entry within the @pm_reqs list for a pseudo-locked region
> - * @req:	PM QoS request
> - */
> -struct pseudo_lock_pm_req {
> -	struct list_head list;
> -	struct dev_pm_qos_request req;
> -};
> -
> -static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
> -{
> -	struct pseudo_lock_pm_req *pm_req, *next;
> -
> -	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
> -		dev_pm_qos_remove_request(&pm_req->req);
> -		list_del(&pm_req->list);
> -		kfree(pm_req);
> -	}
> -}
> -
> -/**
> - * pseudo_lock_cstates_constrain - Restrict cores from entering C6
> - * @plr: Pseudo-locked region
> - *
> - * To prevent the cache from being affected by power management entering
> - * C6 has to be avoided. This is accomplished by requesting a latency
> - * requirement lower than lowest C6 exit latency of all supported
> - * platforms as found in the cpuidle state tables in the intel_idle driver.
> - * At this time it is possible to do so with a single latency requirement
> - * for all supported platforms.
> - *
> - * Since Goldmont is supported, which is affected by X86_BUG_MONITOR,
> - * the ACPI latencies need to be considered while keeping in mind that C2
> - * may be set to map to deeper sleep states. In this case the latency
> - * requirement needs to prevent entering C2 also.
> - *
> - * Return: 0 on success, <0 on failure
> - */
> -static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
> -{
> -	struct pseudo_lock_pm_req *pm_req;
> -	int cpu;
> -	int ret;
> -
> -	for_each_cpu(cpu, &plr->d->cpu_mask) {
> -		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
> -		if (!pm_req) {
> -			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
> -			ret = -ENOMEM;
> -			goto out_err;
> -		}
> -		ret = dev_pm_qos_add_request(get_cpu_device(cpu),
> -					     &pm_req->req,
> -					     DEV_PM_QOS_RESUME_LATENCY,
> -					     30);
> -		if (ret < 0) {
> -			rdt_last_cmd_printf("Failed to add latency req CPU%d\n",
> -					    cpu);
> -			kfree(pm_req);
> -			ret = -1;
> -			goto out_err;
> -		}
> -		list_add(&pm_req->list, &plr->pm_reqs);
> -	}
> -
> -	return 0;
> -
> -out_err:
> -	pseudo_lock_cstates_relax(plr);
> -	return ret;
> -}
> -
> -/**
> - * pseudo_lock_region_clear - Reset pseudo-lock region data
> - * @plr: pseudo-lock region
> - *
> - * All content of the pseudo-locked region is reset - any memory allocated
> - * freed.
> - *
> - * Return: void
> - */
> -static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
> -{
> -	plr->size = 0;
> -	plr->line_size = 0;
> -	kfree(plr->kmem);
> -	plr->kmem = NULL;
> -	plr->s = NULL;
> -	if (plr->d)
> -		plr->d->plr = NULL;
> -	plr->d = NULL;
> -	plr->cbm = 0;
> -	plr->debugfs_dir = NULL;
> -}
> -
> -/**
> - * pseudo_lock_region_init - Initialize pseudo-lock region information
> - * @plr: pseudo-lock region
> - *
> - * Called after user provided a schemata to be pseudo-locked. From the
> - * schemata the &struct pseudo_lock_region is on entry already initialized
> - * with the resource, domain, and capacity bitmask. Here the information
> - * required for pseudo-locking is deduced from this data and &struct
> - * pseudo_lock_region initialized further. This information includes:
> - * - size in bytes of the region to be pseudo-locked
> - * - cache line size to know the stride with which data needs to be accessed
> - *   to be pseudo-locked
> - * - a cpu associated with the cache instance on which the pseudo-locking
> - *   flow can be executed
> - *
> - * Return: 0 on success, <0 on failure. Descriptive error will be written
> - * to last_cmd_status buffer.
> - */
> -static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
> -{
> -	struct cpu_cacheinfo *ci;
> -	int ret;
> -	int i;
> -
> -	/* Pick the first cpu we find that is associated with the cache. */
> -	plr->cpu = cpumask_first(&plr->d->cpu_mask);
> -
> -	if (!cpu_online(plr->cpu)) {
> -		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
> -				    plr->cpu);
> -		ret = -ENODEV;
> -		goto out_region;
> -	}
> -
> -	ci = get_cpu_cacheinfo(plr->cpu);
> -
> -	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
> -
> -	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> -			plr->line_size = ci->info_list[i].coherency_line_size;
> -			return 0;
> -		}
> -	}
> -
> -	ret = -1;
> -	rdt_last_cmd_puts("Unable to determine cache line size\n");
> -out_region:
> -	pseudo_lock_region_clear(plr);
> -	return ret;
> -}
> -
> -/**
> - * pseudo_lock_init - Initialize a pseudo-lock region
> - * @rdtgrp: resource group to which new pseudo-locked region will belong
> - *
> - * A pseudo-locked region is associated with a resource group. When this
> - * association is created the pseudo-locked region is initialized. The
> - * details of the pseudo-locked region are not known at this time so only
> - * allocation is done and association established.
> - *
> - * Return: 0 on success, <0 on failure
> - */
> -static int pseudo_lock_init(struct rdtgroup *rdtgrp)
> -{
> -	struct pseudo_lock_region *plr;
> -
> -	plr = kzalloc(sizeof(*plr), GFP_KERNEL);
> -	if (!plr)
> -		return -ENOMEM;
> -
> -	init_waitqueue_head(&plr->lock_thread_wq);
> -	INIT_LIST_HEAD(&plr->pm_reqs);
> -	rdtgrp->plr = plr;
> -	return 0;
> -}
> -
> -/**
> - * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-locked
> - * @plr: pseudo-lock region
> - *
> - * Initialize the details required to set up the pseudo-locked region and
> - * allocate the contiguous memory that will be pseudo-locked to the cache.
> - *
> - * Return: 0 on success, <0 on failure.  Descriptive error will be written
> - * to last_cmd_status buffer.
> - */
> -static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
> -{
> -	int ret;
> -
> -	ret = pseudo_lock_region_init(plr);
> -	if (ret < 0)
> -		return ret;
> -
> -	/*
> -	 * We do not yet support contiguous regions larger than
> -	 * KMALLOC_MAX_SIZE.
> -	 */
> -	if (plr->size > KMALLOC_MAX_SIZE) {
> -		rdt_last_cmd_puts("Requested region exceeds maximum size\n");
> -		ret = -E2BIG;
> -		goto out_region;
> -	}
> -
> -	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
> -	if (!plr->kmem) {
> -		rdt_last_cmd_puts("Unable to allocate memory\n");
> -		ret = -ENOMEM;
> -		goto out_region;
> -	}
> -
> -	ret = 0;
> -	goto out;
> -out_region:
> -	pseudo_lock_region_clear(plr);
> -out:
> -	return ret;
> -}
> -
> -/**
> - * pseudo_lock_free - Free a pseudo-locked region
> - * @rdtgrp: resource group to which pseudo-locked region belonged
> - *
> - * The pseudo-locked region's resources have already been released, or not
> - * yet created at this point. Now it can be freed and disassociated from the
> - * resource group.
> - *
> - * Return: void
> - */
> -static void pseudo_lock_free(struct rdtgroup *rdtgrp)
> -{
> -	pseudo_lock_region_clear(rdtgrp->plr);
> -	kfree(rdtgrp->plr);
> -	rdtgrp->plr = NULL;
> -}
> -
>  /**
>   * resctrl_arch_pseudo_lock_fn - Load kernel memory into cache
>   * @_plr: the pseudo-lock region descriptor
> @@ -543,345 +228,6 @@ int resctrl_arch_pseudo_lock_fn(void *_plr)
>  	return 0;
>  }
>  
> -/**
> - * rdtgroup_monitor_in_progress - Test if monitoring in progress
> - * @rdtgrp: resource group being queried
> - *
> - * Return: 1 if monitor groups have been created for this resource
> - * group, 0 otherwise.
> - */
> -static int rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
> -{
> -	return !list_empty(&rdtgrp->mon.crdtgrp_list);
> -}
> -
> -/**
> - * rdtgroup_locksetup_user_restrict - Restrict user access to group
> - * @rdtgrp: resource group needing access restricted
> - *
> - * A resource group used for cache pseudo-locking cannot have cpus or tasks
> - * assigned to it. This is communicated to the user by restricting access
> - * to all the files that can be used to make such changes.
> - *
> - * Permissions restored with rdtgroup_locksetup_user_restore()
> - *
> - * Return: 0 on success, <0 on failure. If a failure occurs during the
> - * restriction of access an attempt will be made to restore permissions but
> - * the state of the mode of these files will be uncertain when a failure
> - * occurs.
> - */
> -static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
> -{
> -	int ret;
> -
> -	ret = rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
> -	if (ret)
> -		return ret;
> -
> -	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
> -	if (ret)
> -		goto err_tasks;
> -
> -	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
> -	if (ret)
> -		goto err_cpus;
> -
> -	if (resctrl_arch_mon_capable()) {
> -		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
> -		if (ret)
> -			goto err_cpus_list;
> -	}
> -
> -	ret = 0;
> -	goto out;
> -
> -err_cpus_list:
> -	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
> -err_cpus:
> -	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
> -err_tasks:
> -	rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
> -out:
> -	return ret;
> -}
> -
> -/**
> - * rdtgroup_locksetup_user_restore - Restore user access to group
> - * @rdtgrp: resource group needing access restored
> - *
> - * Restore all file access previously removed using
> - * rdtgroup_locksetup_user_restrict()
> - *
> - * Return: 0 on success, <0 on failure.  If a failure occurs during the
> - * restoration of access an attempt will be made to restrict permissions
> - * again but the state of the mode of these files will be uncertain when
> - * a failure occurs.
> - */
> -static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
> -{
> -	int ret;
> -
> -	ret = rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
> -	if (ret)
> -		return ret;
> -
> -	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
> -	if (ret)
> -		goto err_tasks;
> -
> -	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
> -	if (ret)
> -		goto err_cpus;
> -
> -	if (resctrl_arch_mon_capable()) {
> -		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
> -		if (ret)
> -			goto err_cpus_list;
> -	}
> -
> -	ret = 0;
> -	goto out;
> -
> -err_cpus_list:
> -	rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
> -err_cpus:
> -	rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
> -err_tasks:
> -	rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
> -out:
> -	return ret;
> -}
> -
> -/**
> - * rdtgroup_locksetup_enter - Resource group enters locksetup mode
> - * @rdtgrp: resource group requested to enter locksetup mode
> - *
> - * A resource group enters locksetup mode to reflect that it would be used
> - * to represent a pseudo-locked region and is in the process of being set
> - * up to do so. A resource group used for a pseudo-locked region would
> - * lose the closid associated with it so we cannot allow it to have any
> - * tasks or cpus assigned nor permit tasks or cpus to be assigned in the
> - * future. Monitoring of a pseudo-locked region is not allowed either.
> - *
> - * The above and more restrictions on a pseudo-locked region are checked
> - * for and enforced before the resource group enters the locksetup mode.
> - *
> - * Returns: 0 if the resource group successfully entered locksetup mode, <0
> - * on failure. On failure the last_cmd_status buffer is updated with text to
> - * communicate details of failure to the user.
> - */
> -int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
> -{
> -	int ret;
> -
> -	/*
> -	 * The default resource group can neither be removed nor lose the
> -	 * default closid associated with it.
> -	 */
> -	if (rdtgrp == &rdtgroup_default) {
> -		rdt_last_cmd_puts("Cannot pseudo-lock default group\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Cache Pseudo-locking not supported when CDP is enabled.
> -	 *
> -	 * Some things to consider if you would like to enable this
> -	 * support (using L3 CDP as example):
> -	 * - When CDP is enabled two separate resources are exposed,
> -	 *   L3DATA and L3CODE, but they are actually on the same cache.
> -	 *   The implication for pseudo-locking is that if a
> -	 *   pseudo-locked region is created on a domain of one
> -	 *   resource (eg. L3CODE), then a pseudo-locked region cannot
> -	 *   be created on that same domain of the other resource
> -	 *   (eg. L3DATA). This is because the creation of a
> -	 *   pseudo-locked region involves a call to wbinvd that will
> -	 *   affect all cache allocations on particular domain.
> -	 * - Considering the previous, it may be possible to only
> -	 *   expose one of the CDP resources to pseudo-locking and
> -	 *   hide the other. For example, we could consider to only
> -	 *   expose L3DATA and since the L3 cache is unified it is
> -	 *   still possible to place instructions there are execute it.
> -	 * - If only one region is exposed to pseudo-locking we should
> -	 *   still keep in mind that availability of a portion of cache
> -	 *   for pseudo-locking should take into account both resources.
> -	 *   Similarly, if a pseudo-locked region is created in one
> -	 *   resource, the portion of cache used by it should be made
> -	 *   unavailable to all future allocations from both resources.
> -	 */
> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3) ||
> -	    resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2)) {
> -		rdt_last_cmd_puts("CDP enabled\n");
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Not knowing the bits to disable prefetching implies that this
> -	 * platform does not support Cache Pseudo-Locking.
> -	 */
> -	if (resctrl_arch_get_prefetch_disable_bits() == 0) {
> -		rdt_last_cmd_puts("Pseudo-locking not supported\n");
> -		return -EINVAL;
> -	}
> -
> -	if (rdtgroup_monitor_in_progress(rdtgrp)) {
> -		rdt_last_cmd_puts("Monitoring in progress\n");
> -		return -EINVAL;
> -	}
> -
> -	if (rdtgroup_tasks_assigned(rdtgrp)) {
> -		rdt_last_cmd_puts("Tasks assigned to resource group\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!cpumask_empty(&rdtgrp->cpu_mask)) {
> -		rdt_last_cmd_puts("CPUs assigned to resource group\n");
> -		return -EINVAL;
> -	}
> -
> -	if (rdtgroup_locksetup_user_restrict(rdtgrp)) {
> -		rdt_last_cmd_puts("Unable to modify resctrl permissions\n");
> -		return -EIO;
> -	}
> -
> -	ret = pseudo_lock_init(rdtgrp);
> -	if (ret) {
> -		rdt_last_cmd_puts("Unable to init pseudo-lock region\n");
> -		goto out_release;
> -	}
> -
> -	/*
> -	 * If this system is capable of monitoring a rmid would have been
> -	 * allocated when the control group was created. This is not needed
> -	 * anymore when this group would be used for pseudo-locking. This
> -	 * is safe to call on platforms not capable of monitoring.
> -	 */
> -	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> -
> -	ret = 0;
> -	goto out;
> -
> -out_release:
> -	rdtgroup_locksetup_user_restore(rdtgrp);
> -out:
> -	return ret;
> -}
> -
> -/**
> - * rdtgroup_locksetup_exit - resource group exist locksetup mode
> - * @rdtgrp: resource group
> - *
> - * When a resource group exits locksetup mode the earlier restrictions are
> - * lifted.
> - *
> - * Return: 0 on success, <0 on failure
> - */
> -int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
> -{
> -	int ret;
> -
> -	if (resctrl_arch_mon_capable()) {
> -		ret = alloc_rmid(rdtgrp->closid);
> -		if (ret < 0) {
> -			rdt_last_cmd_puts("Out of RMIDs\n");
> -			return ret;
> -		}
> -		rdtgrp->mon.rmid = ret;
> -	}
> -
> -	ret = rdtgroup_locksetup_user_restore(rdtgrp);
> -	if (ret) {
> -		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> -		return ret;
> -	}
> -
> -	pseudo_lock_free(rdtgrp);
> -	return 0;
> -}
> -
> -/**
> - * rdtgroup_cbm_overlaps_pseudo_locked - Test if CBM or portion is pseudo-locked
> - * @d: RDT domain
> - * @cbm: CBM to test
> - *
> - * @d represents a cache instance and @cbm a capacity bitmask that is
> - * considered for it. Determine if @cbm overlaps with any existing
> - * pseudo-locked region on @d.
> - *
> - * @cbm is unsigned long, even if only 32 bits are used, to make the
> - * bitmap functions work correctly.
> - *
> - * Return: true if @cbm overlaps with pseudo-locked region on @d, false
> - * otherwise.
> - */
> -bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
> -{
> -	unsigned int cbm_len;
> -	unsigned long cbm_b;
> -
> -	if (d->plr) {
> -		cbm_len = d->plr->s->res->cache.cbm_len;
> -		cbm_b = d->plr->cbm;
> -		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
> -			return true;
> -	}
> -	return false;
> -}
> -
> -/**
> - * rdtgroup_pseudo_locked_in_hierarchy - Pseudo-locked region in cache hierarchy
> - * @d: RDT domain under test
> - *
> - * The setup of a pseudo-locked region affects all cache instances within
> - * the hierarchy of the region. It is thus essential to know if any
> - * pseudo-locked regions exist within a cache hierarchy to prevent any
> - * attempts to create new pseudo-locked regions in the same hierarchy.
> - *
> - * Return: true if a pseudo-locked region exists in the hierarchy of @d or
> - *         if it is not possible to test due to memory allocation issue,
> - *         false otherwise.
> - */
> -bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
> -{
> -	cpumask_var_t cpu_with_psl;
> -	enum resctrl_res_level i;
> -	struct rdt_resource *r;
> -	struct rdt_domain *d_i;
> -	bool ret = false;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
> -		return true;
> -
> -	/*
> -	 * First determine which cpus have pseudo-locked regions
> -	 * associated with them.
> -	 */
> -	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> -		r = resctrl_arch_get_resource(i);
> -		if (!r->alloc_capable)
> -			continue;
> -
> -		list_for_each_entry(d_i, &r->domains, list) {
> -			if (d_i->plr)
> -				cpumask_or(cpu_with_psl, cpu_with_psl,
> -					   &d_i->cpu_mask);
> -		}
> -	}
> -
> -	/*
> -	 * Next test if new pseudo-locked region would intersect with
> -	 * existing region.
> -	 */
> -	if (cpumask_intersects(&d->cpu_mask, cpu_with_psl))
> -		ret = true;
> -
> -	free_cpumask_var(cpu_with_psl);
> -	return ret;
> -}
> -
>  /**
>   * resctrl_arch_measure_cycles_lat_fn - Measure cycle latency to read
>   *                                      pseudo-locked memory
> @@ -1174,442 +520,3 @@ int resctrl_arch_measure_l3_residency(void *_plr)
>  	wake_up_interruptible(&plr->lock_thread_wq);
>  	return 0;
>  }
> -
> -/**
> - * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
> - * @rdtgrp: Resource group to which the pseudo-locked region belongs.
> - * @sel: Selector of which measurement to perform on a pseudo-locked region.
> - *
> - * The measurement of latency to access a pseudo-locked region should be
> - * done from a cpu that is associated with that pseudo-locked region.
> - * Determine which cpu is associated with this region and start a thread on
> - * that cpu to perform the measurement, wait for that thread to complete.
> - *
> - * Return: 0 on success, <0 on failure
> - */
> -static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
> -{
> -	struct pseudo_lock_region *plr = rdtgrp->plr;
> -	struct task_struct *thread;
> -	unsigned int cpu;
> -	int ret = -1;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	if (rdtgrp->flags & RDT_DELETED) {
> -		ret = -ENODEV;
> -		goto out;
> -	}
> -
> -	if (!plr->d) {
> -		ret = -ENODEV;
> -		goto out;
> -	}
> -
> -	plr->thread_done = 0;
> -	cpu = cpumask_first(&plr->d->cpu_mask);
> -	if (!cpu_online(cpu)) {
> -		ret = -ENODEV;
> -		goto out;
> -	}
> -
> -	plr->cpu = cpu;
> -
> -	if (sel == 1)
> -		thread = kthread_create_on_node(resctrl_arch_measure_cycles_lat_fn,
> -						plr, cpu_to_node(cpu),
> -						"pseudo_lock_measure/%u",
> -						cpu);
> -	else if (sel == 2)
> -		thread = kthread_create_on_node(resctrl_arch_measure_l2_residency,
> -						plr, cpu_to_node(cpu),
> -						"pseudo_lock_measure/%u",
> -						cpu);
> -	else if (sel == 3)
> -		thread = kthread_create_on_node(resctrl_arch_measure_l3_residency,
> -						plr, cpu_to_node(cpu),
> -						"pseudo_lock_measure/%u",
> -						cpu);
> -	else
> -		goto out;
> -
> -	if (IS_ERR(thread)) {
> -		ret = PTR_ERR(thread);
> -		goto out;
> -	}
> -	kthread_bind(thread, cpu);
> -	wake_up_process(thread);
> -
> -	ret = wait_event_interruptible(plr->lock_thread_wq,
> -				       plr->thread_done == 1);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = 0;
> -
> -out:
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -	return ret;
> -}
> -
> -static ssize_t pseudo_lock_measure_trigger(struct file *file,
> -					   const char __user *user_buf,
> -					   size_t count, loff_t *ppos)
> -{
> -	struct rdtgroup *rdtgrp = file->private_data;
> -	size_t buf_size;
> -	char buf[32];
> -	int ret;
> -	int sel;
> -
> -	buf_size = min(count, (sizeof(buf) - 1));
> -	if (copy_from_user(buf, user_buf, buf_size))
> -		return -EFAULT;
> -
> -	buf[buf_size] = '\0';
> -	ret = kstrtoint(buf, 10, &sel);
> -	if (ret == 0) {
> -		if (sel != 1 && sel != 2 && sel != 3)
> -			return -EINVAL;
> -		ret = debugfs_file_get(file->f_path.dentry);
> -		if (ret)
> -			return ret;
> -		ret = pseudo_lock_measure_cycles(rdtgrp, sel);
> -		if (ret == 0)
> -			ret = count;
> -		debugfs_file_put(file->f_path.dentry);
> -	}
> -
> -	return ret;
> -}
> -
> -static const struct file_operations pseudo_measure_fops = {
> -	.write = pseudo_lock_measure_trigger,
> -	.open = simple_open,
> -	.llseek = default_llseek,
> -};
> -
> -/**
> - * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
> - * @rdtgrp: resource group to which pseudo-lock region belongs
> - *
> - * Called when a resource group in the pseudo-locksetup mode receives a
> - * valid schemata that should be pseudo-locked. Since the resource group is
> - * in pseudo-locksetup mode the &struct pseudo_lock_region has already been
> - * allocated and initialized with the essential information. If a failure
> - * occurs the resource group remains in the pseudo-locksetup mode with the
> - * &struct pseudo_lock_region associated with it, but cleared from all
> - * information and ready for the user to re-attempt pseudo-locking by
> - * writing the schemata again.
> - *
> - * Return: 0 if the pseudo-locked region was successfully pseudo-locked, <0
> - * on failure. Descriptive error will be written to last_cmd_status buffer.
> - */
> -int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
> -{
> -	struct pseudo_lock_region *plr = rdtgrp->plr;
> -	struct task_struct *thread;
> -	unsigned int new_minor;
> -	struct device *dev;
> -	int ret;
> -
> -	ret = pseudo_lock_region_alloc(plr);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = pseudo_lock_cstates_constrain(plr);
> -	if (ret < 0) {
> -		ret = -EINVAL;
> -		goto out_region;
> -	}
> -
> -	plr->thread_done = 0;
> -
> -	plr->closid = rdtgrp->closid;
> -	thread = kthread_create_on_node(resctrl_arch_pseudo_lock_fn, plr,
> -					cpu_to_node(plr->cpu),
> -					"pseudo_lock/%u", plr->cpu);
> -	if (IS_ERR(thread)) {
> -		ret = PTR_ERR(thread);
> -		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
> -		goto out_cstates;
> -	}
> -
> -	kthread_bind(thread, plr->cpu);
> -	wake_up_process(thread);
> -
> -	ret = wait_event_interruptible(plr->lock_thread_wq,
> -				       plr->thread_done == 1);
> -	if (ret < 0) {
> -		/*
> -		 * If the thread does not get on the CPU for whatever
> -		 * reason and the process which sets up the region is
> -		 * interrupted then this will leave the thread in runnable
> -		 * state and once it gets on the CPU it will dereference
> -		 * the cleared, but not freed, plr struct resulting in an
> -		 * empty pseudo-locking loop.
> -		 */
> -		rdt_last_cmd_puts("Locking thread interrupted\n");
> -		goto out_cstates;
> -	}
> -
> -	ret = pseudo_lock_minor_get(&new_minor);
> -	if (ret < 0) {
> -		rdt_last_cmd_puts("Unable to obtain a new minor number\n");
> -		goto out_cstates;
> -	}
> -
> -	/*
> -	 * Unlock access but do not release the reference. The
> -	 * pseudo-locked region will still be here on return.
> -	 *
> -	 * The mutex has to be released temporarily to avoid a potential
> -	 * deadlock with the mm->mmap_lock which is obtained in the
> -	 * device_create() and debugfs_create_dir() callpath below as well as
> -	 * before the mmap() callback is called.
> -	 */
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
> -		plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
> -						      debugfs_resctrl);
> -		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
> -			debugfs_create_file("pseudo_lock_measure", 0200,
> -					    plr->debugfs_dir, rdtgrp,
> -					    &pseudo_measure_fops);
> -	}
> -
> -	dev = device_create(&pseudo_lock_class, NULL,
> -			    MKDEV(pseudo_lock_major, new_minor),
> -			    rdtgrp, "%s", rdtgrp->kn->name);
> -
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	if (IS_ERR(dev)) {
> -		ret = PTR_ERR(dev);
> -		rdt_last_cmd_printf("Failed to create character device: %d\n",
> -				    ret);
> -		goto out_debugfs;
> -	}
> -
> -	/* We released the mutex - check if group was removed while we did so */
> -	if (rdtgrp->flags & RDT_DELETED) {
> -		ret = -ENODEV;
> -		goto out_device;
> -	}
> -
> -	plr->minor = new_minor;
> -
> -	rdtgrp->mode = RDT_MODE_PSEUDO_LOCKED;
> -	closid_free(rdtgrp->closid);
> -	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0444);
> -	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0444);
> -
> -	ret = 0;
> -	goto out;
> -
> -out_device:
> -	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
> -out_debugfs:
> -	debugfs_remove_recursive(plr->debugfs_dir);
> -	pseudo_lock_minor_release(new_minor);
> -out_cstates:
> -	pseudo_lock_cstates_relax(plr);
> -out_region:
> -	pseudo_lock_region_clear(plr);
> -out:
> -	return ret;
> -}
> -
> -/**
> - * rdtgroup_pseudo_lock_remove - Remove a pseudo-locked region
> - * @rdtgrp: resource group to which the pseudo-locked region belongs
> - *
> - * The removal of a pseudo-locked region can be initiated when the resource
> - * group is removed from user space via a "rmdir" from userspace or the
> - * unmount of the resctrl filesystem. On removal the resource group does
> - * not go back to pseudo-locksetup mode before it is removed, instead it is
> - * removed directly. There is thus asymmetry with the creation where the
> - * &struct pseudo_lock_region is removed here while it was not created in
> - * rdtgroup_pseudo_lock_create().
> - *
> - * Return: void
> - */
> -void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
> -{
> -	struct pseudo_lock_region *plr = rdtgrp->plr;
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -		/*
> -		 * Default group cannot be a pseudo-locked region so we can
> -		 * free closid here.
> -		 */
> -		closid_free(rdtgrp->closid);
> -		goto free;
> -	}
> -
> -	pseudo_lock_cstates_relax(plr);
> -	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
> -	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
> -	pseudo_lock_minor_release(plr->minor);
> -
> -free:
> -	pseudo_lock_free(rdtgrp);
> -}
> -
> -static int pseudo_lock_dev_open(struct inode *inode, struct file *filp)
> -{
> -	struct rdtgroup *rdtgrp;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	rdtgrp = region_find_by_minor(iminor(inode));
> -	if (!rdtgrp) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -ENODEV;
> -	}
> -
> -	filp->private_data = rdtgrp;
> -	atomic_inc(&rdtgrp->waitcount);
> -	/* Perform a non-seekable open - llseek is not supported */
> -	filp->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return 0;
> -}
> -
> -static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
> -{
> -	struct rdtgroup *rdtgrp;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -	rdtgrp = filp->private_data;
> -	WARN_ON(!rdtgrp);
> -	if (!rdtgrp) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -ENODEV;
> -	}
> -	filp->private_data = NULL;
> -	atomic_dec(&rdtgrp->waitcount);
> -	mutex_unlock(&rdtgroup_mutex);
> -	return 0;
> -}
> -
> -static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
> -{
> -	/* Not supported */
> -	return -EINVAL;
> -}
> -
> -static const struct vm_operations_struct pseudo_mmap_ops = {
> -	.mremap = pseudo_lock_dev_mremap,
> -};
> -
> -static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
> -{
> -	unsigned long vsize = vma->vm_end - vma->vm_start;
> -	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
> -	struct pseudo_lock_region *plr;
> -	struct rdtgroup *rdtgrp;
> -	unsigned long physical;
> -	unsigned long psize;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	rdtgrp = filp->private_data;
> -	WARN_ON(!rdtgrp);
> -	if (!rdtgrp) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -ENODEV;
> -	}
> -
> -	plr = rdtgrp->plr;
> -
> -	if (!plr->d) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -ENODEV;
> -	}
> -
> -	/*
> -	 * Task is required to run with affinity to the cpus associated
> -	 * with the pseudo-locked region. If this is not the case the task
> -	 * may be scheduled elsewhere and invalidate entries in the
> -	 * pseudo-locked region.
> -	 */
> -	if (!cpumask_subset(current->cpus_ptr, &plr->d->cpu_mask)) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -EINVAL;
> -	}
> -
> -	physical = __pa(plr->kmem) >> PAGE_SHIFT;
> -	psize = plr->size - off;
> -
> -	if (off > plr->size) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -ENOSPC;
> -	}
> -
> -	/*
> -	 * Ensure changes are carried directly to the memory being mapped,
> -	 * do not allow copy-on-write mapping.
> -	 */
> -	if (!(vma->vm_flags & VM_SHARED)) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -EINVAL;
> -	}
> -
> -	if (vsize > psize) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -ENOSPC;
> -	}
> -
> -	memset(plr->kmem + off, 0, vsize);
> -
> -	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
> -			    vsize, vma->vm_page_prot)) {
> -		mutex_unlock(&rdtgroup_mutex);
> -		return -EAGAIN;
> -	}
> -	vma->vm_ops = &pseudo_mmap_ops;
> -	mutex_unlock(&rdtgroup_mutex);
> -	return 0;
> -}
> -
> -static const struct file_operations pseudo_lock_dev_fops = {
> -	.owner =	THIS_MODULE,
> -	.llseek =	no_llseek,
> -	.read =		NULL,
> -	.write =	NULL,
> -	.open =		pseudo_lock_dev_open,
> -	.release =	pseudo_lock_dev_release,
> -	.mmap =		pseudo_lock_dev_mmap,
> -};
> -
> -int rdt_pseudo_lock_init(void)
> -{
> -	int ret;
> -
> -	ret = register_chrdev(0, "pseudo_lock", &pseudo_lock_dev_fops);
> -	if (ret < 0)
> -		return ret;
> -
> -	pseudo_lock_major = ret;
> -
> -	ret = class_register(&pseudo_lock_class);
> -	if (ret) {
> -		unregister_chrdev(pseudo_lock_major, "pseudo_lock");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -void rdt_pseudo_lock_release(void)
> -{
> -	class_unregister(&pseudo_lock_class);
> -	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
> -	pseudo_lock_major = 0;
> -}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1425a33d201d..fe3952514add 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -12,22 +12,8 @@
>  
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
> -#include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
> -#include <linux/debugfs.h>
> -#include <linux/fs.h>
> -#include <linux/fs_parser.h>
> -#include <linux/sysfs.h>
> -#include <linux/kernfs.h>
> -#include <linux/seq_buf.h>
> -#include <linux/seq_file.h>
> -#include <linux/sched/signal.h>
> -#include <linux/sched/task.h>
>  #include <linux/slab.h>
> -#include <linux/task_work.h>
> -#include <linux/user_namespace.h>
> -
> -#include <uapi/linux/magic.h>
>  
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -36,328 +22,6 @@ DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  
> -/* Mutex to protect rdtgroup access. */
> -DEFINE_MUTEX(rdtgroup_mutex);
> -
> -static struct kernfs_root *rdt_root;
> -struct rdtgroup rdtgroup_default;
> -LIST_HEAD(rdt_all_groups);
> -
> -/* list of entries for the schemata file */
> -LIST_HEAD(resctrl_schema_all);
> -
> -/* The filesystem can only be mounted once. */
> -bool resctrl_mounted;
> -
> -/* Kernel fs node for "info" directory under root */
> -static struct kernfs_node *kn_info;
> -
> -/* Kernel fs node for "mon_groups" directory under root */
> -static struct kernfs_node *kn_mongrp;
> -
> -/* Kernel fs node for "mon_data" directory under root */
> -static struct kernfs_node *kn_mondata;
> -
> -/*
> - * Used to store the max resource name width and max resource data width
> - * to display the schemata in a tabular format
> - */
> -int max_name_width, max_data_width;
> -
> -static struct seq_buf last_cmd_status;
> -static char last_cmd_status_buf[512];
> -
> -static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
> -static void rdtgroup_destroy_root(void);
> -
> -struct dentry *debugfs_resctrl;
> -
> -static bool resctrl_debug;
> -
> -void rdt_last_cmd_clear(void)
> -{
> -	lockdep_assert_held(&rdtgroup_mutex);
> -	seq_buf_clear(&last_cmd_status);
> -}
> -
> -void rdt_last_cmd_puts(const char *s)
> -{
> -	lockdep_assert_held(&rdtgroup_mutex);
> -	seq_buf_puts(&last_cmd_status, s);
> -}
> -
> -void rdt_last_cmd_printf(const char *fmt, ...)
> -{
> -	va_list ap;
> -
> -	va_start(ap, fmt);
> -	lockdep_assert_held(&rdtgroup_mutex);
> -	seq_buf_vprintf(&last_cmd_status, fmt, ap);
> -	va_end(ap);
> -}
> -
> -void rdt_staged_configs_clear(void)
> -{
> -	enum resctrl_res_level i;
> -	struct rdt_resource *r;
> -	struct rdt_domain *dom;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> -		r = resctrl_arch_get_resource(i);
> -		if (!r->alloc_capable)
> -			continue;
> -
> -		list_for_each_entry(dom, &r->domains, list)
> -			memset(dom->staged_config, 0, sizeof(dom->staged_config));
> -	}
> -}
> -
> -static bool resctrl_is_mbm_enabled(void)
> -{
> -	return (resctrl_arch_is_mbm_total_enabled() ||
> -		resctrl_arch_is_mbm_local_enabled());
> -}
> -
> -static bool resctrl_is_mbm_event(int e)
> -{
> -	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
> -		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
> -}
> -
> -/*
> - * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
> - * we can keep a bitmap of free CLOSIDs in a single integer.
> - *
> - * Using a global CLOSID across all resources has some advantages and
> - * some drawbacks:
> - * + We can simply set current's closid to assign a task to a resource
> - *   group.
> - * + Context switch code can avoid extra memory references deciding which
> - *   CLOSID to load into the PQR_ASSOC MSR
> - * - We give up some options in configuring resource groups across multi-socket
> - *   systems.
> - * - Our choices on how to configure each resource become progressively more
> - *   limited as the number of resources grows.
> - */
> -static unsigned long closid_free_map;
> -static int closid_free_map_len;
> -
> -int closids_supported(void)
> -{
> -	return closid_free_map_len;
> -}
> -
> -static void closid_init(void)
> -{
> -	struct resctrl_schema *s;
> -	u32 rdt_min_closid = 32;
> -
> -	/* Compute rdt_min_closid across all resources */
> -	list_for_each_entry(s, &resctrl_schema_all, list)
> -		rdt_min_closid = min(rdt_min_closid, s->num_closid);
> -
> -	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
> -
> -	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
> -	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
> -	closid_free_map_len = rdt_min_closid;
> -}
> -
> -static int closid_alloc(void)
> -{
> -	int cleanest_closid;
> -	u32 closid;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> -	    resctrl_arch_is_llc_occupancy_enabled()) {
> -		cleanest_closid = resctrl_find_cleanest_closid();
> -		if (cleanest_closid < 0)
> -			return cleanest_closid;
> -		closid = cleanest_closid;
> -	} else {
> -		closid = ffs(closid_free_map);
> -		if (closid == 0)
> -			return -ENOSPC;
> -		closid--;
> -	}
> -	__clear_bit(closid, &closid_free_map);
> -
> -	return closid;
> -}
> -
> -void closid_free(int closid)
> -{
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	__set_bit(closid, &closid_free_map);
> -}
> -
> -/**
> - * closid_allocated - test if provided closid is in use
> - * @closid: closid to be tested
> - *
> - * Return: true if @closid is currently associated with a resource group,
> - * false if @closid is free
> - */
> -bool closid_allocated(unsigned int closid)
> -{
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	return !test_bit(closid, &closid_free_map);
> -}
> -
> -/**
> - * rdtgroup_mode_by_closid - Return mode of resource group with closid
> - * @closid: closid if the resource group
> - *
> - * Each resource group is associated with a @closid. Here the mode
> - * of a resource group can be queried by searching for it using its closid.
> - *
> - * Return: mode as &enum rdtgrp_mode of resource group with closid @closid
> - */
> -enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
> -{
> -	struct rdtgroup *rdtgrp;
> -
> -	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> -		if (rdtgrp->closid == closid)
> -			return rdtgrp->mode;
> -	}
> -
> -	return RDT_NUM_MODES;
> -}
> -
> -static const char * const rdt_mode_str[] = {
> -	[RDT_MODE_SHAREABLE]		= "shareable",
> -	[RDT_MODE_EXCLUSIVE]		= "exclusive",
> -	[RDT_MODE_PSEUDO_LOCKSETUP]	= "pseudo-locksetup",
> -	[RDT_MODE_PSEUDO_LOCKED]	= "pseudo-locked",
> -};
> -
> -/**
> - * rdtgroup_mode_str - Return the string representation of mode
> - * @mode: the resource group mode as &enum rdtgroup_mode
> - *
> - * Return: string representation of valid mode, "unknown" otherwise
> - */
> -static const char *rdtgroup_mode_str(enum rdtgrp_mode mode)
> -{
> -	if (mode < RDT_MODE_SHAREABLE || mode >= RDT_NUM_MODES)
> -		return "unknown";
> -
> -	return rdt_mode_str[mode];
> -}
> -
> -/* set uid and gid of rdtgroup dirs and files to that of the creator */
> -static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
> -{
> -	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
> -				.ia_uid = current_fsuid(),
> -				.ia_gid = current_fsgid(), };
> -
> -	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
> -	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
> -		return 0;
> -
> -	return kernfs_setattr(kn, &iattr);
> -}
> -
> -static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
> -{
> -	struct kernfs_node *kn;
> -	int ret;
> -
> -	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
> -				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> -				  0, rft->kf_ops, rft, NULL, NULL);
> -	if (IS_ERR(kn))
> -		return PTR_ERR(kn);
> -
> -	ret = rdtgroup_kn_set_ugid(kn);
> -	if (ret) {
> -		kernfs_remove(kn);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
> -{
> -	struct kernfs_open_file *of = m->private;
> -	struct rftype *rft = of->kn->priv;
> -
> -	if (rft->seq_show)
> -		return rft->seq_show(of, m, arg);
> -	return 0;
> -}
> -
> -static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
> -				   size_t nbytes, loff_t off)
> -{
> -	struct rftype *rft = of->kn->priv;
> -
> -	if (rft->write)
> -		return rft->write(of, buf, nbytes, off);
> -
> -	return -EINVAL;
> -}
> -
> -static const struct kernfs_ops rdtgroup_kf_single_ops = {
> -	.atomic_write_len	= PAGE_SIZE,
> -	.write			= rdtgroup_file_write,
> -	.seq_show		= rdtgroup_seqfile_show,
> -};
> -
> -static const struct kernfs_ops kf_mondata_ops = {
> -	.atomic_write_len	= PAGE_SIZE,
> -	.seq_show		= rdtgroup_mondata_show,
> -};
> -
> -static bool is_cpu_list(struct kernfs_open_file *of)
> -{
> -	struct rftype *rft = of->kn->priv;
> -
> -	return rft->flags & RFTYPE_FLAGS_CPUS_LIST;
> -}
> -
> -static int rdtgroup_cpus_show(struct kernfs_open_file *of,
> -			      struct seq_file *s, void *v)
> -{
> -	struct rdtgroup *rdtgrp;
> -	struct cpumask *mask;
> -	int ret = 0;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -
> -	if (rdtgrp) {
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -			if (!rdtgrp->plr->d) {
> -				rdt_last_cmd_clear();
> -				rdt_last_cmd_puts("Cache domain offline\n");
> -				ret = -ENODEV;
> -			} else {
> -				mask = &rdtgrp->plr->d->cpu_mask;
> -				seq_printf(s, is_cpu_list(of) ?
> -					   "%*pbl\n" : "%*pb\n",
> -					   cpumask_pr_args(mask));
> -			}
> -		} else {
> -			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
> -				   cpumask_pr_args(&rdtgrp->cpu_mask));
> -		}
> -	} else {
> -		ret = -ENOENT;
> -	}
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret;
> -}
> -
>  /*
>   * This is safe against resctrl_arch_sched_in() called from __switch_to()
>   * because __switch_to() is executed with interrupts disabled. A local call
> @@ -381,1206 +45,6 @@ void resctrl_arch_sync_cpu_defaults(void *info)
>  	resctrl_arch_sched_in(current);
>  }
>  
> -/*
> - * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
> - *
> - * Per task closids/rmids must have been set up before calling this function.
> - * @r may be NULL.
> - */
> -static void
> -update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
> -{
> -	struct resctrl_cpu_sync defaults;
> -	struct resctrl_cpu_sync *defaults_p = NULL;
> -
> -	if (r) {
> -		defaults.closid = r->closid;
> -		defaults.rmid = r->mon.rmid;
> -		defaults_p = &defaults;
> -	}
> -
> -	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_defaults, defaults_p,
> -			 1);
> -}
> -
> -static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> -			  cpumask_var_t tmpmask)
> -{
> -	struct rdtgroup *prgrp = rdtgrp->mon.parent, *crgrp;
> -	struct list_head *head;
> -
> -	/* Check whether cpus belong to parent ctrl group */
> -	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
> -	if (!cpumask_empty(tmpmask)) {
> -		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Check whether cpus are dropped from this group */
> -	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
> -	if (!cpumask_empty(tmpmask)) {
> -		/* Give any dropped cpus to parent rdtgroup */
> -		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
> -		update_closid_rmid(tmpmask, prgrp);
> -	}
> -
> -	/*
> -	 * If we added cpus, remove them from previous group that owned them
> -	 * and update per-cpu rmid
> -	 */
> -	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
> -	if (!cpumask_empty(tmpmask)) {
> -		head = &prgrp->mon.crdtgrp_list;
> -		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> -			if (crgrp == rdtgrp)
> -				continue;
> -			cpumask_andnot(&crgrp->cpu_mask, &crgrp->cpu_mask,
> -				       tmpmask);
> -		}
> -		update_closid_rmid(tmpmask, rdtgrp);
> -	}
> -
> -	/* Done pushing/pulling - update this group with new mask */
> -	cpumask_copy(&rdtgrp->cpu_mask, newmask);
> -
> -	return 0;
> -}
> -
> -static void cpumask_rdtgrp_clear(struct rdtgroup *r, struct cpumask *m)
> -{
> -	struct rdtgroup *crgrp;
> -
> -	cpumask_andnot(&r->cpu_mask, &r->cpu_mask, m);
> -	/* update the child mon group masks as well*/
> -	list_for_each_entry(crgrp, &r->mon.crdtgrp_list, mon.crdtgrp_list)
> -		cpumask_and(&crgrp->cpu_mask, &r->cpu_mask, &crgrp->cpu_mask);
> -}
> -
> -static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> -			   cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
> -{
> -	struct rdtgroup *r, *crgrp;
> -	struct list_head *head;
> -
> -	/* Check whether cpus are dropped from this group */
> -	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
> -	if (!cpumask_empty(tmpmask)) {
> -		/* Can't drop from default group */
> -		if (rdtgrp == &rdtgroup_default) {
> -			rdt_last_cmd_puts("Can't drop CPUs from default group\n");
> -			return -EINVAL;
> -		}
> -
> -		/* Give any dropped cpus to rdtgroup_default */
> -		cpumask_or(&rdtgroup_default.cpu_mask,
> -			   &rdtgroup_default.cpu_mask, tmpmask);
> -		update_closid_rmid(tmpmask, &rdtgroup_default);
> -	}
> -
> -	/*
> -	 * If we added cpus, remove them from previous group and
> -	 * the prev group's child groups that owned them
> -	 * and update per-cpu closid/rmid.
> -	 */
> -	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
> -	if (!cpumask_empty(tmpmask)) {
> -		list_for_each_entry(r, &rdt_all_groups, rdtgroup_list) {
> -			if (r == rdtgrp)
> -				continue;
> -			cpumask_and(tmpmask1, &r->cpu_mask, tmpmask);
> -			if (!cpumask_empty(tmpmask1))
> -				cpumask_rdtgrp_clear(r, tmpmask1);
> -		}
> -		update_closid_rmid(tmpmask, rdtgrp);
> -	}
> -
> -	/* Done pushing/pulling - update this group with new mask */
> -	cpumask_copy(&rdtgrp->cpu_mask, newmask);
> -
> -	/*
> -	 * Clear child mon group masks since there is a new parent mask
> -	 * now and update the rmid for the cpus the child lost.
> -	 */
> -	head = &rdtgrp->mon.crdtgrp_list;
> -	list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> -		cpumask_and(tmpmask, &rdtgrp->cpu_mask, &crgrp->cpu_mask);
> -		update_closid_rmid(tmpmask, rdtgrp);
> -		cpumask_clear(&crgrp->cpu_mask);
> -	}
> -
> -	return 0;
> -}
> -
> -static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
> -				   char *buf, size_t nbytes, loff_t off)
> -{
> -	cpumask_var_t tmpmask, newmask, tmpmask1;
> -	struct rdtgroup *rdtgrp;
> -	int ret;
> -
> -	if (!buf)
> -		return -EINVAL;
> -
> -	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> -		return -ENOMEM;
> -	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
> -		free_cpumask_var(tmpmask);
> -		return -ENOMEM;
> -	}
> -	if (!zalloc_cpumask_var(&tmpmask1, GFP_KERNEL)) {
> -		free_cpumask_var(tmpmask);
> -		free_cpumask_var(newmask);
> -		return -ENOMEM;
> -	}
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		ret = -ENOENT;
> -		goto unlock;
> -	}
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> -	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -		ret = -EINVAL;
> -		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> -		goto unlock;
> -	}
> -
> -	if (is_cpu_list(of))
> -		ret = cpulist_parse(buf, newmask);
> -	else
> -		ret = cpumask_parse(buf, newmask);
> -
> -	if (ret) {
> -		rdt_last_cmd_puts("Bad CPU list/mask\n");
> -		goto unlock;
> -	}
> -
> -	/* check that user didn't specify any offline cpus */
> -	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
> -	if (!cpumask_empty(tmpmask)) {
> -		ret = -EINVAL;
> -		rdt_last_cmd_puts("Can only assign online CPUs\n");
> -		goto unlock;
> -	}
> -
> -	if (rdtgrp->type == RDTCTRL_GROUP)
> -		ret = cpus_ctrl_write(rdtgrp, newmask, tmpmask, tmpmask1);
> -	else if (rdtgrp->type == RDTMON_GROUP)
> -		ret = cpus_mon_write(rdtgrp, newmask, tmpmask);
> -	else
> -		ret = -EINVAL;
> -
> -unlock:
> -	rdtgroup_kn_unlock(of->kn);
> -	free_cpumask_var(tmpmask);
> -	free_cpumask_var(newmask);
> -	free_cpumask_var(tmpmask1);
> -
> -	return ret ?: nbytes;
> -}
> -
> -/**
> - * rdtgroup_remove - the helper to remove resource group safely
> - * @rdtgrp: resource group to remove
> - *
> - * On resource group creation via a mkdir, an extra kernfs_node reference is
> - * taken to ensure that the rdtgroup structure remains accessible for the
> - * rdtgroup_kn_unlock() calls where it is removed.
> - *
> - * Drop the extra reference here, then free the rdtgroup structure.
> - *
> - * Return: void
> - */
> -static void rdtgroup_remove(struct rdtgroup *rdtgrp)
> -{
> -	kernfs_put(rdtgrp->kn);
> -	kfree(rdtgrp);
> -}
> -
> -static void _update_task_closid_rmid(void *task)
> -{
> -	/*
> -	 * If the task is still current on this CPU, update PQR_ASSOC MSR.
> -	 * Otherwise, the MSR is updated when the task is scheduled in.
> -	 */
> -	if (task == current)
> -		resctrl_arch_sched_in(task);
> -}
> -
> -static void update_task_closid_rmid(struct task_struct *t)
> -{
> -	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> -		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> -	else
> -		_update_task_closid_rmid(t);
> -}
> -
> -static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
> -{
> -	u32 closid, rmid = rdtgrp->mon.rmid;
> -
> -	if (rdtgrp->type == RDTCTRL_GROUP)
> -		closid = rdtgrp->closid;
> -	else if (rdtgrp->type == RDTMON_GROUP)
> -		closid = rdtgrp->mon.parent->closid;
> -	else
> -		return false;
> -
> -	return resctrl_arch_match_closid(tsk, closid) &&
> -	       resctrl_arch_match_rmid(tsk, closid, rmid);
> -}
> -
> -static int __rdtgroup_move_task(struct task_struct *tsk,
> -				struct rdtgroup *rdtgrp)
> -{
> -	/* If the task is already in rdtgrp, no need to move the task. */
> -	if (task_in_rdtgroup(tsk, rdtgrp))
> -		return 0;
> -
> -	/*
> -	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
> -	 * updated by them.
> -	 *
> -	 * For ctrl_mon groups, move both closid and rmid.
> -	 * For monitor groups, can move the tasks only from
> -	 * their parent CTRL group.
> -	 */
> -	if (rdtgrp->type == RDTMON_GROUP &&
> -	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
> -		rdt_last_cmd_puts("Can't move task to different control group\n");
> -		return -EINVAL;
> -	}
> -
> -	if (rdtgrp->type == RDTMON_GROUP)
> -		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
> -					     rdtgrp->mon.rmid);
> -	else
> -		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
> -					     rdtgrp->mon.rmid);
> -
> -	/*
> -	 * Ensure the task's closid and rmid are written before determining if
> -	 * the task is current that will decide if it will be interrupted.
> -	 * This pairs with the full barrier between the rq->curr update and
> -	 * resctrl_arch_sched_in() during context switch.
> -	 */
> -	smp_mb();
> -
> -	/*
> -	 * By now, the task's closid and rmid are set. If the task is current
> -	 * on a CPU, the PQR_ASSOC MSR needs to be updated to make the resource
> -	 * group go into effect. If the task is not current, the MSR will be
> -	 * updated when the task is scheduled in.
> -	 */
> -	update_task_closid_rmid(tsk);
> -
> -	return 0;
> -}
> -
> -static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
> -{
> -	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
> -		resctrl_arch_match_closid(t, r->closid));
> -}
> -
> -static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
> -{
> -	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
> -		resctrl_arch_match_rmid(t, r->mon.parent->closid,
> -					r->mon.rmid));
> -}
> -
> -/**
> - * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
> - * @r: Resource group
> - *
> - * Return: 1 if tasks have been assigned to @r, 0 otherwise
> - */
> -int rdtgroup_tasks_assigned(struct rdtgroup *r)
> -{
> -	struct task_struct *p, *t;
> -	int ret = 0;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> -		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
> -			ret = 1;
> -			break;
> -		}
> -	}
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
> -static int rdtgroup_task_write_permission(struct task_struct *task,
> -					  struct kernfs_open_file *of)
> -{
> -	const struct cred *tcred = get_task_cred(task);
> -	const struct cred *cred = current_cred();
> -	int ret = 0;
> -
> -	/*
> -	 * Even if we're attaching all tasks in the thread group, we only
> -	 * need to check permissions on one of them.
> -	 */
> -	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
> -	    !uid_eq(cred->euid, tcred->uid) &&
> -	    !uid_eq(cred->euid, tcred->suid)) {
> -		rdt_last_cmd_printf("No permission to move task %d\n", task->pid);
> -		ret = -EPERM;
> -	}
> -
> -	put_cred(tcred);
> -	return ret;
> -}
> -
> -static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
> -			      struct kernfs_open_file *of)
> -{
> -	struct task_struct *tsk;
> -	int ret;
> -
> -	rcu_read_lock();
> -	if (pid) {
> -		tsk = find_task_by_vpid(pid);
> -		if (!tsk) {
> -			rcu_read_unlock();
> -			rdt_last_cmd_printf("No task %d\n", pid);
> -			return -ESRCH;
> -		}
> -	} else {
> -		tsk = current;
> -	}
> -
> -	get_task_struct(tsk);
> -	rcu_read_unlock();
> -
> -	ret = rdtgroup_task_write_permission(tsk, of);
> -	if (!ret)
> -		ret = __rdtgroup_move_task(tsk, rdtgrp);
> -
> -	put_task_struct(tsk);
> -	return ret;
> -}
> -
> -static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
> -				    char *buf, size_t nbytes, loff_t off)
> -{
> -	struct rdtgroup *rdtgrp;
> -	char *pid_str;
> -	int ret = 0;
> -	pid_t pid;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		rdtgroup_kn_unlock(of->kn);
> -		return -ENOENT;
> -	}
> -	rdt_last_cmd_clear();
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> -	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -		ret = -EINVAL;
> -		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> -		goto unlock;
> -	}
> -
> -	while (buf && buf[0] != '\0' && buf[0] != '\n') {
> -		pid_str = strim(strsep(&buf, ","));
> -
> -		if (kstrtoint(pid_str, 0, &pid)) {
> -			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
> -			ret = -EINVAL;
> -			break;
> -		}
> -
> -		if (pid < 0) {
> -			rdt_last_cmd_printf("Invalid pid %d\n", pid);
> -			ret = -EINVAL;
> -			break;
> -		}
> -
> -		ret = rdtgroup_move_task(pid, rdtgrp, of);
> -		if (ret) {
> -			rdt_last_cmd_printf("Error while processing task %d\n", pid);
> -			break;
> -		}
> -	}
> -
> -unlock:
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret ?: nbytes;
> -}
> -
> -static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
> -{
> -	struct task_struct *p, *t;
> -	pid_t pid;
> -
> -	rcu_read_lock();
> -	for_each_process_thread(p, t) {
> -		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
> -			pid = task_pid_vnr(t);
> -			if (pid)
> -				seq_printf(s, "%d\n", pid);
> -		}
> -	}
> -	rcu_read_unlock();
> -}
> -
> -static int rdtgroup_tasks_show(struct kernfs_open_file *of,
> -			       struct seq_file *s, void *v)
> -{
> -	struct rdtgroup *rdtgrp;
> -	int ret = 0;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (rdtgrp)
> -		show_rdt_tasks(rdtgrp, s);
> -	else
> -		ret = -ENOENT;
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret;
> -}
> -
> -static int rdtgroup_closid_show(struct kernfs_open_file *of,
> -				struct seq_file *s, void *v)
> -{
> -	struct rdtgroup *rdtgrp;
> -	int ret = 0;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (rdtgrp)
> -		seq_printf(s, "%u\n", rdtgrp->closid);
> -	else
> -		ret = -ENOENT;
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret;
> -}
> -
> -static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> -			      struct seq_file *s, void *v)
> -{
> -	struct rdtgroup *rdtgrp;
> -	int ret = 0;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (rdtgrp)
> -		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> -	else
> -		ret = -ENOENT;
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret;
> -}
> -
> -#ifdef CONFIG_PROC_CPU_RESCTRL
> -
> -/*
> - * A task can only be part of one resctrl control group and of one monitor
> - * group which is associated to that control group.
> - *
> - * 1)   res:
> - *      mon:
> - *
> - *    resctrl is not available.
> - *
> - * 2)   res:/
> - *      mon:
> - *
> - *    Task is part of the root resctrl control group, and it is not associated
> - *    to any monitor group.
> - *
> - * 3)  res:/
> - *     mon:mon0
> - *
> - *    Task is part of the root resctrl control group and monitor group mon0.
> - *
> - * 4)  res:group0
> - *     mon:
> - *
> - *    Task is part of resctrl control group group0, and it is not associated
> - *    to any monitor group.
> - *
> - * 5) res:group0
> - *    mon:mon1
> - *
> - *    Task is part of resctrl control group group0 and monitor group mon1.
> - */
> -int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
> -		      struct pid *pid, struct task_struct *tsk)
> -{
> -	struct rdtgroup *rdtg;
> -	int ret = 0;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	/* Return empty if resctrl has not been mounted. */
> -	if (!resctrl_mounted) {
> -		seq_puts(s, "res:\nmon:\n");
> -		goto unlock;
> -	}
> -
> -	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> -		struct rdtgroup *crg;
> -
> -		/*
> -		 * Task information is only relevant for shareable
> -		 * and exclusive groups.
> -		 */
> -		if (rdtg->mode != RDT_MODE_SHAREABLE &&
> -		    rdtg->mode != RDT_MODE_EXCLUSIVE)
> -			continue;
> -
> -		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
> -			continue;
> -
> -		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
> -			   rdtg->kn->name);
> -		seq_puts(s, "mon:");
> -		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> -				    mon.crdtgrp_list) {
> -			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
> -						     crg->mon.rmid))
> -				continue;
> -			seq_printf(s, "%s", crg->kn->name);
> -			break;
> -		}
> -		seq_putc(s, '\n');
> -		goto unlock;
> -	}
> -	/*
> -	 * The above search should succeed. Otherwise return
> -	 * with an error.
> -	 */
> -	ret = -ENOENT;
> -unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return ret;
> -}
> -#endif
> -
> -static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
> -				    struct seq_file *seq, void *v)
> -{
> -	int len;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -	len = seq_buf_used(&last_cmd_status);
> -	if (len)
> -		seq_printf(seq, "%.*s", len, last_cmd_status_buf);
> -	else
> -		seq_puts(seq, "ok\n");
> -	mutex_unlock(&rdtgroup_mutex);
> -	return 0;
> -}
> -
> -static int rdt_num_closids_show(struct kernfs_open_file *of,
> -				struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -
> -	seq_printf(seq, "%u\n", s->num_closid);
> -	return 0;
> -}
> -
> -static int rdt_default_ctrl_show(struct kernfs_open_file *of,
> -			     struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	seq_printf(seq, "%x\n", r->default_ctrl);
> -	return 0;
> -}
> -
> -static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
> -			     struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
> -	return 0;
> -}
> -
> -static int rdt_shareable_bits_show(struct kernfs_open_file *of,
> -				   struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	seq_printf(seq, "%x\n", r->cache.shareable_bits);
> -	return 0;
> -}
> -
> -/*
> - * rdt_bit_usage_show - Display current usage of resources
> - *
> - * A domain is a shared resource that can now be allocated differently. Here
> - * we display the current regions of the domain as an annotated bitmask.
> - * For each domain of this resource its allocation bitmask
> - * is annotated as below to indicate the current usage of the corresponding bit:
> - *   0 - currently unused
> - *   X - currently available for sharing and used by software and hardware
> - *   H - currently used by hardware only but available for software use
> - *   S - currently used and shareable by software only
> - *   E - currently used exclusively by one resource group
> - *   P - currently pseudo-locked by one resource group
> - */
> -static int rdt_bit_usage_show(struct kernfs_open_file *of,
> -			      struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	/*
> -	 * Use unsigned long even though only 32 bits are used to ensure
> -	 * test_bit() is used safely.
> -	 */
> -	unsigned long sw_shareable = 0, hw_shareable = 0;
> -	unsigned long exclusive = 0, pseudo_locked = 0;
> -	struct rdt_resource *r = s->res;
> -	struct rdt_domain *dom;
> -	int i, hwb, swb, excl, psl;
> -	enum rdtgrp_mode mode;
> -	bool sep = false;
> -	u32 ctrl_val;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -	hw_shareable = r->cache.shareable_bits;
> -	list_for_each_entry(dom, &r->domains, list) {
> -		if (sep)
> -			seq_putc(seq, ';');
> -		sw_shareable = 0;
> -		exclusive = 0;
> -		seq_printf(seq, "%d=", dom->id);
> -		for (i = 0; i < closids_supported(); i++) {
> -			if (!closid_allocated(i))
> -				continue;
> -			ctrl_val = resctrl_arch_get_config(r, dom, i,
> -							   s->conf_type);
> -			mode = rdtgroup_mode_by_closid(i);
> -			switch (mode) {
> -			case RDT_MODE_SHAREABLE:
> -				sw_shareable |= ctrl_val;
> -				break;
> -			case RDT_MODE_EXCLUSIVE:
> -				exclusive |= ctrl_val;
> -				break;
> -			case RDT_MODE_PSEUDO_LOCKSETUP:
> -			/*
> -			 * RDT_MODE_PSEUDO_LOCKSETUP is possible
> -			 * here but not included since the CBM
> -			 * associated with this CLOSID in this mode
> -			 * is not initialized and no task or cpu can be
> -			 * assigned this CLOSID.
> -			 */
> -				break;
> -			case RDT_MODE_PSEUDO_LOCKED:
> -			case RDT_NUM_MODES:
> -				WARN(1,
> -				     "invalid mode for closid %d\n", i);
> -				break;
> -			}
> -		}
> -		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
> -			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
> -			hwb = test_bit(i, &hw_shareable);
> -			swb = test_bit(i, &sw_shareable);
> -			excl = test_bit(i, &exclusive);
> -			psl = test_bit(i, &pseudo_locked);
> -			if (hwb && swb)
> -				seq_putc(seq, 'X');
> -			else if (hwb && !swb)
> -				seq_putc(seq, 'H');
> -			else if (!hwb && swb)
> -				seq_putc(seq, 'S');
> -			else if (excl)
> -				seq_putc(seq, 'E');
> -			else if (psl)
> -				seq_putc(seq, 'P');
> -			else /* Unused bits remain */
> -				seq_putc(seq, '0');
> -		}
> -		sep = true;
> -	}
> -	seq_putc(seq, '\n');
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -	return 0;
> -}
> -
> -static int rdt_min_bw_show(struct kernfs_open_file *of,
> -			     struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	seq_printf(seq, "%u\n", r->membw.min_bw);
> -	return 0;
> -}
> -
> -static int rdt_num_rmids_show(struct kernfs_open_file *of,
> -			      struct seq_file *seq, void *v)
> -{
> -	struct rdt_resource *r = of->kn->parent->priv;
> -
> -	seq_printf(seq, "%d\n", r->num_rmid);
> -
> -	return 0;
> -}
> -
> -static int rdt_mon_features_show(struct kernfs_open_file *of,
> -				 struct seq_file *seq, void *v)
> -{
> -	struct rdt_resource *r = of->kn->parent->priv;
> -	struct mon_evt *mevt;
> -
> -	list_for_each_entry(mevt, &r->evt_list, list) {
> -		seq_printf(seq, "%s\n", mevt->name);
> -		if (mevt->configurable)
> -			seq_printf(seq, "%s_config\n", mevt->name);
> -	}
> -
> -	return 0;
> -}
> -
> -static int rdt_bw_gran_show(struct kernfs_open_file *of,
> -			     struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	seq_printf(seq, "%u\n", r->membw.bw_gran);
> -	return 0;
> -}
> -
> -static int rdt_delay_linear_show(struct kernfs_open_file *of,
> -			     struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	seq_printf(seq, "%u\n", r->membw.delay_linear);
> -	return 0;
> -}
> -
> -static int max_threshold_occ_show(struct kernfs_open_file *of,
> -				  struct seq_file *seq, void *v)
> -{
> -	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
> -
> -	return 0;
> -}
> -
> -static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
> -					 struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
> -		seq_puts(seq, "per-thread\n");
> -	else
> -		seq_puts(seq, "max\n");
> -
> -	return 0;
> -}
> -
> -static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
> -				       char *buf, size_t nbytes, loff_t off)
> -{
> -	unsigned int bytes;
> -	int ret;
> -
> -	ret = kstrtouint(buf, 0, &bytes);
> -	if (ret)
> -		return ret;
> -
> -	if (bytes > resctrl_rmid_realloc_limit)
> -		return -EINVAL;
> -
> -	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(bytes);
> -
> -	return nbytes;
> -}
> -
> -/*
> - * rdtgroup_mode_show - Display mode of this resource group
> - */
> -static int rdtgroup_mode_show(struct kernfs_open_file *of,
> -			      struct seq_file *s, void *v)
> -{
> -	struct rdtgroup *rdtgrp;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		rdtgroup_kn_unlock(of->kn);
> -		return -ENOENT;
> -	}
> -
> -	seq_printf(s, "%s\n", rdtgroup_mode_str(rdtgrp->mode));
> -
> -	rdtgroup_kn_unlock(of->kn);
> -	return 0;
> -}
> -
> -static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
> -{
> -	switch (my_type) {
> -	case CDP_CODE:
> -		return CDP_DATA;
> -	case CDP_DATA:
> -		return CDP_CODE;
> -	default:
> -	case CDP_NONE:
> -		return CDP_NONE;
> -	}
> -}
> -
> -static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
> -					struct seq_file *seq, void *v)
> -{
> -	struct resctrl_schema *s = of->kn->parent->priv;
> -	struct rdt_resource *r = s->res;
> -
> -	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
> -
> -	return 0;
> -}
> -
> -/**
> - * __rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
> - * @r: Resource to which domain instance @d belongs.
> - * @d: The domain instance for which @closid is being tested.
> - * @cbm: Capacity bitmask being tested.
> - * @closid: Intended closid for @cbm.
> - * @type: CDP type of @r.
> - * @exclusive: Only check if overlaps with exclusive resource groups
> - *
> - * Checks if provided @cbm intended to be used for @closid on domain
> - * @d overlaps with any other closids or other hardware usage associated
> - * with this domain. If @exclusive is true then only overlaps with
> - * resource groups in exclusive mode will be considered. If @exclusive
> - * is false then overlaps with any resource group or hardware entities
> - * will be considered.
> - *
> - * @cbm is unsigned long, even if only 32 bits are used, to make the
> - * bitmap functions work correctly.
> - *
> - * Return: false if CBM does not overlap, true if it does.
> - */
> -static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
> -				    unsigned long cbm, int closid,
> -				    enum resctrl_conf_type type, bool exclusive)
> -{
> -	enum rdtgrp_mode mode;
> -	unsigned long ctrl_b;
> -	int i;
> -
> -	/* Check for any overlap with regions used by hardware directly */
> -	if (!exclusive) {
> -		ctrl_b = r->cache.shareable_bits;
> -		if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len))
> -			return true;
> -	}
> -
> -	/* Check for overlap with other resource groups */
> -	for (i = 0; i < closids_supported(); i++) {
> -		ctrl_b = resctrl_arch_get_config(r, d, i, type);
> -		mode = rdtgroup_mode_by_closid(i);
> -		if (closid_allocated(i) && i != closid &&
> -		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
> -			if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len)) {
> -				if (exclusive) {
> -					if (mode == RDT_MODE_EXCLUSIVE)
> -						return true;
> -					continue;
> -				}
> -				return true;
> -			}
> -		}
> -	}
> -
> -	return false;
> -}
> -
> -/**
> - * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
> - * @s: Schema for the resource to which domain instance @d belongs.
> - * @d: The domain instance for which @closid is being tested.
> - * @cbm: Capacity bitmask being tested.
> - * @closid: Intended closid for @cbm.
> - * @exclusive: Only check if overlaps with exclusive resource groups
> - *
> - * Resources that can be allocated using a CBM can use the CBM to control
> - * the overlap of these allocations. rdtgroup_cmb_overlaps() is the test
> - * for overlap. Overlap test is not limited to the specific resource for
> - * which the CBM is intended though - when dealing with CDP resources that
> - * share the underlying hardware the overlap check should be performed on
> - * the CDP resource sharing the hardware also.
> - *
> - * Refer to description of __rdtgroup_cbm_overlaps() for the details of the
> - * overlap test.
> - *
> - * Return: true if CBM overlap detected, false if there is no overlap
> - */
> -bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
> -			   unsigned long cbm, int closid, bool exclusive)
> -{
> -	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
> -	struct rdt_resource *r = s->res;
> -
> -	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
> -				    exclusive))
> -		return true;
> -
> -	if (!resctrl_arch_get_cdp_enabled(r->rid))
> -		return false;
> -	return  __rdtgroup_cbm_overlaps(r, d, cbm, closid, peer_type, exclusive);
> -}
> -
> -/**
> - * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
> - * @rdtgrp: Resource group identified through its closid.
> - *
> - * An exclusive resource group implies that there should be no sharing of
> - * its allocated resources. At the time this group is considered to be
> - * exclusive this test can determine if its current schemata supports this
> - * setting by testing for overlap with all other resource groups.
> - *
> - * Return: true if resource group can be exclusive, false if there is overlap
> - * with allocations of other resource groups and thus this resource group
> - * cannot be exclusive.
> - */
> -static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
> -{
> -	int closid = rdtgrp->closid;
> -	struct resctrl_schema *s;
> -	struct rdt_resource *r;
> -	bool has_cache = false;
> -	struct rdt_domain *d;
> -	u32 ctrl;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		r = s->res;
> -		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
> -			continue;
> -		has_cache = true;
> -		list_for_each_entry(d, &r->domains, list) {
> -			ctrl = resctrl_arch_get_config(r, d, closid,
> -						       s->conf_type);
> -			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
> -				rdt_last_cmd_puts("Schemata overlaps\n");
> -				return false;
> -			}
> -		}
> -	}
> -
> -	if (!has_cache) {
> -		rdt_last_cmd_puts("Cannot be exclusive without CAT/CDP\n");
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
> -/*
> - * rdtgroup_mode_write - Modify the resource group's mode
> - */
> -static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
> -				   char *buf, size_t nbytes, loff_t off)
> -{
> -	struct rdtgroup *rdtgrp;
> -	enum rdtgrp_mode mode;
> -	int ret = 0;
> -
> -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> -		return -EINVAL;
> -	buf[nbytes - 1] = '\0';
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		rdtgroup_kn_unlock(of->kn);
> -		return -ENOENT;
> -	}
> -
> -	rdt_last_cmd_clear();
> -
> -	mode = rdtgrp->mode;
> -
> -	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> -	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> -	    (!strcmp(buf, "pseudo-locksetup") &&
> -	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> -	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
> -		goto out;
> -
> -	if (mode == RDT_MODE_PSEUDO_LOCKED) {
> -		rdt_last_cmd_puts("Cannot change pseudo-locked group\n");
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	if (!strcmp(buf, "shareable")) {
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -			ret = rdtgroup_locksetup_exit(rdtgrp);
> -			if (ret)
> -				goto out;
> -		}
> -		rdtgrp->mode = RDT_MODE_SHAREABLE;
> -	} else if (!strcmp(buf, "exclusive")) {
> -		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -			ret = rdtgroup_locksetup_exit(rdtgrp);
> -			if (ret)
> -				goto out;
> -		}
> -		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
> -	} else if (IS_ENABLED(CONFIG_RESCTRL_FS_PSEUDO_LOCK) &&
> -		   !strcmp(buf, "pseudo-locksetup")) {
> -		ret = rdtgroup_locksetup_enter(rdtgrp);
> -		if (ret)
> -			goto out;
> -		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
> -	} else {
> -		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> -		ret = -EINVAL;
> -	}
> -
> -out:
> -	rdtgroup_kn_unlock(of->kn);
> -	return ret ?: nbytes;
> -}
> -
> -/**
> - * rdtgroup_cbm_to_size - Translate CBM to size in bytes
> - * @r: RDT resource to which @d belongs.
> - * @d: RDT domain instance.
> - * @cbm: bitmask for which the size should be computed.
> - *
> - * The bitmask provided associated with the RDT domain instance @d will be
> - * translated into how many bytes it represents. The size in bytes is
> - * computed by first dividing the total cache size by the CBM length to
> - * determine how many bytes each bit in the bitmask represents. The result
> - * is multiplied with the number of bits set in the bitmask.
> - *
> - * @cbm is unsigned long, even if only 32 bits are used to make the
> - * bitmap functions work correctly.
> - */
> -unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
> -				  struct rdt_domain *d, unsigned long cbm)
> -{
> -	struct cpu_cacheinfo *ci;
> -	unsigned int size = 0;
> -	int num_b, i;
> -
> -	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
> -	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
> -	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == r->cache_level) {
> -			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
> -			break;
> -		}
> -	}
> -
> -	return size;
> -}
> -
> -/*
> - * rdtgroup_size_show - Display size in bytes of allocated regions
> - *
> - * The "size" file mirrors the layout of the "schemata" file, printing the
> - * size in bytes of each region instead of the capacity bitmask.
> - */
> -static int rdtgroup_size_show(struct kernfs_open_file *of,
> -			      struct seq_file *s, void *v)
> -{
> -	struct resctrl_schema *schema;
> -	enum resctrl_conf_type type;
> -	struct rdtgroup *rdtgrp;
> -	struct rdt_resource *r;
> -	struct rdt_domain *d;
> -	unsigned int size;
> -	int ret = 0;
> -	u32 closid;
> -	bool sep;
> -	u32 ctrl;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> -	if (!rdtgrp) {
> -		rdtgroup_kn_unlock(of->kn);
> -		return -ENOENT;
> -	}
> -
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -		if (!rdtgrp->plr->d) {
> -			rdt_last_cmd_clear();
> -			rdt_last_cmd_puts("Cache domain offline\n");
> -			ret = -ENODEV;
> -		} else {
> -			seq_printf(s, "%*s:", max_name_width,
> -				   rdtgrp->plr->s->name);
> -			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
> -						    rdtgrp->plr->d,
> -						    rdtgrp->plr->cbm);
> -			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
> -		}
> -		goto out;
> -	}
> -
> -	closid = rdtgrp->closid;
> -
> -	list_for_each_entry(schema, &resctrl_schema_all, list) {
> -		r = schema->res;
> -		type = schema->conf_type;
> -		sep = false;
> -		seq_printf(s, "%*s:", max_name_width, schema->name);
> -		list_for_each_entry(d, &r->domains, list) {
> -			if (sep)
> -				seq_putc(s, ';');
> -			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -				size = 0;
> -			} else {
> -				if (is_mba_sc(r))
> -					ctrl = d->mbps_val[closid];
> -				else
> -					ctrl = resctrl_arch_get_config(r, d,
> -								       closid,
> -								       type);
> -				if (r->rid == RDT_RESOURCE_MBA ||
> -				    r->rid == RDT_RESOURCE_SMBA)
> -					size = ctrl;
> -				else
> -					size = rdtgroup_cbm_to_size(r, d, ctrl);
> -			}
> -			seq_printf(s, "%d=%u", d->id, size);
> -			sep = true;
> -		}
> -		seq_putc(s, '\n');
> -	}
> -
> -out:
> -	rdtgroup_kn_unlock(of->kn);
> -
> -	return ret;
> -}
> -
>  #define INVALID_CONFIG_INDEX   UINT_MAX
>  
>  /**
> @@ -1622,62 +86,6 @@ void resctrl_arch_mon_event_config_read(void *info)
>  	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>  }
>  
> -static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
> -{
> -	smp_call_function_any(&mon_info->d->cpu_mask,
> -			      resctrl_arch_mon_event_config_read, mon_info, 1);
> -}
> -
> -static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
> -{
> -	struct resctrl_mon_config_info mon_info = {0};
> -	struct rdt_domain *dom;
> -	bool sep = false;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	list_for_each_entry(dom, &r->domains, list) {
> -		if (sep)
> -			seq_puts(s, ";");
> -
> -		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
> -		mon_info.r = r;
> -		mon_info.d = dom;
> -		mon_info.evtid = evtid;
> -		mondata_config_read(&mon_info);
> -
> -		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
> -		sep = true;
> -	}
> -	seq_puts(s, "\n");
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -
> -	return 0;
> -}
> -
> -static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
> -				       struct seq_file *seq, void *v)
> -{
> -	struct rdt_resource *r = of->kn->parent->priv;
> -
> -	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
> -
> -	return 0;
> -}
> -
> -static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
> -				       struct seq_file *seq, void *v)
> -{
> -	struct rdt_resource *r = of->kn->parent->priv;
> -
> -	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
> -
> -	return 0;
> -}
> -
>  void resctrl_arch_mon_event_config_write(void *info)
>  {
>  	struct resctrl_mon_config_info *mon_info = info;
> @@ -1694,605 +102,6 @@ void resctrl_arch_mon_event_config_write(void *info)
>  	mon_info->err = 0;
>  }
>  
> -static int mbm_config_write_domain(struct rdt_resource *r,
> -				   struct rdt_domain *d, u32 evtid, u32 val)
> -{
> -	struct resctrl_mon_config_info mon_info = {0};
> -
> -	/*
> -	 * Read the current config value first. If both are the same then
> -	 * no need to write it again.
> -	 */
> -	mon_info.r = r;
> -	mon_info.d = d;
> -	mon_info.evtid = evtid;
> -	mondata_config_read(&mon_info);
> -	if (mon_info.mon_config == val)
> -		return 0;
> -
> -	mon_info.mon_config = val;
> -
> -	/*
> -	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
> -	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> -	 * are scoped at the domain level. Writing any of these MSRs
> -	 * on one CPU is observed by all the CPUs in the domain.
> -	 */
> -	smp_call_function_any(&d->cpu_mask, resctrl_arch_mon_event_config_write,
> -			      &mon_info, 1);
> -	if (mon_info.err) {
> -		rdt_last_cmd_puts("Invalid event configuration\n");
> -		return mon_info.err;
> -	}
> -
> -	/*
> -	 * When an Event Configuration is changed, the bandwidth counters
> -	 * for all RMIDs and Events will be cleared by the hardware. The
> -	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> -	 * every RMID on the next read to any event for every RMID.
> -	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> -	 * cleared while it is tracked by the hardware. Clear the
> -	 * mbm_local and mbm_total counts for all the RMIDs.
> -	 */
> -	resctrl_arch_reset_rmid_all(r, d);
> -
> -	return 0;
> -}
> -
> -static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
> -{
> -	char *dom_str = NULL, *id_str;
> -	unsigned long dom_id, val;
> -	struct rdt_domain *d;
> -	int err;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -next:
> -	if (!tok || tok[0] == '\0')
> -		return 0;
> -
> -	/* Start processing the strings for each domain */
> -	dom_str = strim(strsep(&tok, ";"));
> -	id_str = strsep(&dom_str, "=");
> -
> -	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> -		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
> -		rdt_last_cmd_puts("Non-numeric event configuration value\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Value from user cannot be more than the supported set of events */
> -	if ((val & r->mbm_cfg_mask) != val) {
> -		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
> -				    r->mbm_cfg_mask);
> -		return -EINVAL;
> -	}
> -
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (d->id == dom_id) {
> -			err = mbm_config_write_domain(r, d, evtid, val);
> -			if (err)
> -				return err;
> -			goto next;
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
> -					    char *buf, size_t nbytes,
> -					    loff_t off)
> -{
> -	struct rdt_resource *r = of->kn->parent->priv;
> -	int ret;
> -
> -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> -		return -EINVAL;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	rdt_last_cmd_clear();
> -
> -	buf[nbytes - 1] = '\0';
> -
> -	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -
> -	return ret ?: nbytes;
> -}
> -
> -static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
> -					    char *buf, size_t nbytes,
> -					    loff_t off)
> -{
> -	struct rdt_resource *r = of->kn->parent->priv;
> -	int ret;
> -
> -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> -		return -EINVAL;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	rdt_last_cmd_clear();
> -
> -	buf[nbytes - 1] = '\0';
> -
> -	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -
> -	return ret ?: nbytes;
> -}
> -
> -/* rdtgroup information files for one cache resource. */
> -static struct rftype res_common_files[] = {
> -	{
> -		.name		= "last_cmd_status",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_last_cmd_status_show,
> -		.fflags		= RFTYPE_TOP_INFO,
> -	},
> -	{
> -		.name		= "num_closids",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_num_closids_show,
> -		.fflags		= RFTYPE_CTRL_INFO,
> -	},
> -	{
> -		.name		= "mon_features",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_mon_features_show,
> -		.fflags		= RFTYPE_MON_INFO,
> -	},
> -	{
> -		.name		= "num_rmids",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_num_rmids_show,
> -		.fflags		= RFTYPE_MON_INFO,
> -	},
> -	{
> -		.name		= "cbm_mask",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_default_ctrl_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> -	},
> -	{
> -		.name		= "min_cbm_bits",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_min_cbm_bits_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> -	},
> -	{
> -		.name		= "shareable_bits",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_shareable_bits_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> -	},
> -	{
> -		.name		= "bit_usage",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_bit_usage_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> -	},
> -	{
> -		.name		= "min_bandwidth",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_min_bw_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
> -	},
> -	{
> -		.name		= "bandwidth_gran",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_bw_gran_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
> -	},
> -	{
> -		.name		= "delay_linear",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_delay_linear_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
> -	},
> -	/*
> -	 * Platform specific which (if any) capabilities are provided by
> -	 * thread_throttle_mode. Defer "fflags" initialization to platform
> -	 * discovery.
> -	 */
> -	{
> -		.name		= "thread_throttle_mode",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_thread_throttle_mode_show,
> -	},
> -	{
> -		.name		= "max_threshold_occupancy",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.write		= max_threshold_occ_write,
> -		.seq_show	= max_threshold_occ_show,
> -		.fflags		= RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
> -	},
> -	{
> -		.name		= "mbm_total_bytes_config",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= mbm_total_bytes_config_show,
> -		.write		= mbm_total_bytes_config_write,
> -	},
> -	{
> -		.name		= "mbm_local_bytes_config",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= mbm_local_bytes_config_show,
> -		.write		= mbm_local_bytes_config_write,
> -	},
> -	{
> -		.name		= "cpus",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.write		= rdtgroup_cpus_write,
> -		.seq_show	= rdtgroup_cpus_show,
> -		.fflags		= RFTYPE_BASE,
> -	},
> -	{
> -		.name		= "cpus_list",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.write		= rdtgroup_cpus_write,
> -		.seq_show	= rdtgroup_cpus_show,
> -		.flags		= RFTYPE_FLAGS_CPUS_LIST,
> -		.fflags		= RFTYPE_BASE,
> -	},
> -	{
> -		.name		= "tasks",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.write		= rdtgroup_tasks_write,
> -		.seq_show	= rdtgroup_tasks_show,
> -		.fflags		= RFTYPE_BASE,
> -	},
> -	{
> -		.name		= "mon_hw_id",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdtgroup_rmid_show,
> -		.fflags		= RFTYPE_MON_BASE | RFTYPE_DEBUG,
> -	},
> -	{
> -		.name		= "schemata",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.write		= rdtgroup_schemata_write,
> -		.seq_show	= rdtgroup_schemata_show,
> -		.fflags		= RFTYPE_CTRL_BASE,
> -	},
> -	{
> -		.name		= "mode",
> -		.mode		= 0644,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.write		= rdtgroup_mode_write,
> -		.seq_show	= rdtgroup_mode_show,
> -		.fflags		= RFTYPE_CTRL_BASE,
> -	},
> -	{
> -		.name		= "size",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdtgroup_size_show,
> -		.fflags		= RFTYPE_CTRL_BASE,
> -	},
> -	{
> -		.name		= "sparse_masks",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdt_has_sparse_bitmasks_show,
> -		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> -	},
> -	{
> -		.name		= "ctrl_hw_id",
> -		.mode		= 0444,
> -		.kf_ops		= &rdtgroup_kf_single_ops,
> -		.seq_show	= rdtgroup_closid_show,
> -		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> -	},
> -
> -};
> -
> -static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
> -{
> -	struct rftype *rfts, *rft;
> -	int ret, len;
> -
> -	rfts = res_common_files;
> -	len = ARRAY_SIZE(res_common_files);
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> -	if (resctrl_debug)
> -		fflags |= RFTYPE_DEBUG;
> -
> -	for (rft = rfts; rft < rfts + len; rft++) {
> -		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
> -			ret = rdtgroup_add_file(kn, rft);
> -			if (ret)
> -				goto error;
> -		}
> -	}
> -
> -	return 0;
> -error:
> -	pr_warn("Failed to add %s, err=%d\n", rft->name, ret);
> -	while (--rft >= rfts) {
> -		if ((fflags & rft->fflags) == rft->fflags)
> -			kernfs_remove_by_name(kn, rft->name);
> -	}
> -	return ret;
> -}
> -
> -static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
> -{
> -	struct rftype *rfts, *rft;
> -	int len;
> -
> -	rfts = res_common_files;
> -	len = ARRAY_SIZE(res_common_files);
> -
> -	for (rft = rfts; rft < rfts + len; rft++) {
> -		if (!strcmp(rft->name, name))
> -			return rft;
> -	}
> -
> -	return NULL;
> -}
> -
> -static void thread_throttle_mode_init(void)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> -	struct rftype *rft;
> -
> -	if (!r->alloc_capable ||
> -	    r->membw.throttle_mode == THREAD_THROTTLE_UNDEFINED)
> -		return;
> -
> -	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
> -	if (!rft)
> -		return;
> -
> -	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
> -}
> -
> -void mbm_config_rftype_init(const char *config)
> -{
> -	struct rftype *rft;
> -
> -	rft = rdtgroup_get_rftype_by_name(config);
> -	if (rft)
> -		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
> -}
> -
> -/**
> - * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
> - * @r: The resource group with which the file is associated.
> - * @name: Name of the file
> - *
> - * The permissions of named resctrl file, directory, or link are modified
> - * to not allow read, write, or execute by any user.
> - *
> - * WARNING: This function is intended to communicate to the user that the
> - * resctrl file has been locked down - that it is not relevant to the
> - * particular state the system finds itself in. It should not be relied
> - * on to protect from user access because after the file's permissions
> - * are restricted the user can still change the permissions using chmod
> - * from the command line.
> - *
> - * Return: 0 on success, <0 on failure.
> - */
> -int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name)
> -{
> -	struct iattr iattr = {.ia_valid = ATTR_MODE,};
> -	struct kernfs_node *kn;
> -	int ret = 0;
> -
> -	kn = kernfs_find_and_get_ns(r->kn, name, NULL);
> -	if (!kn)
> -		return -ENOENT;
> -
> -	switch (kernfs_type(kn)) {
> -	case KERNFS_DIR:
> -		iattr.ia_mode = S_IFDIR;
> -		break;
> -	case KERNFS_FILE:
> -		iattr.ia_mode = S_IFREG;
> -		break;
> -	case KERNFS_LINK:
> -		iattr.ia_mode = S_IFLNK;
> -		break;
> -	}
> -
> -	ret = kernfs_setattr(kn, &iattr);
> -	kernfs_put(kn);
> -	return ret;
> -}
> -
> -/**
> - * rdtgroup_kn_mode_restore - Restore user access to named resctrl file
> - * @r: The resource group with which the file is associated.
> - * @name: Name of the file
> - * @mask: Mask of permissions that should be restored
> - *
> - * Restore the permissions of the named file. If @name is a directory the
> - * permissions of its parent will be used.
> - *
> - * Return: 0 on success, <0 on failure.
> - */
> -int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
> -			     umode_t mask)
> -{
> -	struct iattr iattr = {.ia_valid = ATTR_MODE,};
> -	struct kernfs_node *kn, *parent;
> -	struct rftype *rfts, *rft;
> -	int ret, len;
> -
> -	rfts = res_common_files;
> -	len = ARRAY_SIZE(res_common_files);
> -
> -	for (rft = rfts; rft < rfts + len; rft++) {
> -		if (!strcmp(rft->name, name))
> -			iattr.ia_mode = rft->mode & mask;
> -	}
> -
> -	kn = kernfs_find_and_get_ns(r->kn, name, NULL);
> -	if (!kn)
> -		return -ENOENT;
> -
> -	switch (kernfs_type(kn)) {
> -	case KERNFS_DIR:
> -		parent = kernfs_get_parent(kn);
> -		if (parent) {
> -			iattr.ia_mode |= parent->mode;
> -			kernfs_put(parent);
> -		}
> -		iattr.ia_mode |= S_IFDIR;
> -		break;
> -	case KERNFS_FILE:
> -		iattr.ia_mode |= S_IFREG;
> -		break;
> -	case KERNFS_LINK:
> -		iattr.ia_mode |= S_IFLNK;
> -		break;
> -	}
> -
> -	ret = kernfs_setattr(kn, &iattr);
> -	kernfs_put(kn);
> -	return ret;
> -}
> -
> -static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
> -				      unsigned long fflags)
> -{
> -	struct kernfs_node *kn_subdir;
> -	int ret;
> -
> -	kn_subdir = kernfs_create_dir(kn_info, name,
> -				      kn_info->mode, priv);
> -	if (IS_ERR(kn_subdir))
> -		return PTR_ERR(kn_subdir);
> -
> -	ret = rdtgroup_kn_set_ugid(kn_subdir);
> -	if (ret)
> -		return ret;
> -
> -	ret = rdtgroup_add_files(kn_subdir, fflags);
> -	if (!ret)
> -		kernfs_activate(kn_subdir);
> -
> -	return ret;
> -}
> -
> -static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
> -{
> -	enum resctrl_res_level i;
> -	struct resctrl_schema *s;
> -	struct rdt_resource *r;
> -	unsigned long fflags;
> -	char name[32];
> -	int ret;
> -
> -	/* create the directory */
> -	kn_info = kernfs_create_dir(parent_kn, "info", parent_kn->mode, NULL);
> -	if (IS_ERR(kn_info))
> -		return PTR_ERR(kn_info);
> -
> -	ret = rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);
> -	if (ret)
> -		goto out_destroy;
> -
> -	/* loop over enabled controls, these are all alloc_capable */
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		r = s->res;
> -		fflags = r->fflags | RFTYPE_CTRL_INFO;
> -		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
> -		if (ret)
> -			goto out_destroy;
> -	}
> -
> -	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> -		r = resctrl_arch_get_resource(i);
> -		if (!r->mon_capable)
> -			continue;
> -
> -		fflags =  r->fflags | RFTYPE_MON_INFO;
> -		sprintf(name, "%s_MON", r->name);
> -		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
> -		if (ret)
> -			goto out_destroy;
> -	}
> -
> -	ret = rdtgroup_kn_set_ugid(kn_info);
> -	if (ret)
> -		goto out_destroy;
> -
> -	kernfs_activate(kn_info);
> -
> -	return 0;
> -
> -out_destroy:
> -	kernfs_remove(kn_info);
> -	return ret;
> -}
> -
> -static int
> -mongroup_create_dir(struct kernfs_node *parent_kn, struct rdtgroup *prgrp,
> -		    char *name, struct kernfs_node **dest_kn)
> -{
> -	struct kernfs_node *kn;
> -	int ret;
> -
> -	/* create the directory */
> -	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
> -	if (IS_ERR(kn))
> -		return PTR_ERR(kn);
> -
> -	if (dest_kn)
> -		*dest_kn = kn;
> -
> -	ret = rdtgroup_kn_set_ugid(kn);
> -	if (ret)
> -		goto out_destroy;
> -
> -	kernfs_activate(kn);
> -
> -	return 0;
> -
> -out_destroy:
> -	kernfs_remove(kn);
> -	return ret;
> -}
> -
>  static void l3_qos_cfg_update(void *arg)
>  {
>  	bool *enable = arg;
> @@ -2307,11 +116,6 @@ static void l2_qos_cfg_update(void *arg)
>  	wrmsrl(MSR_IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
>  }
>  
> -static inline bool is_mba_linear(void)
> -{
> -	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
> -}
> -
>  static int set_cache_qos_cfg(int level, bool enable)
>  {
>  	void (*update)(void *arg);
> @@ -2367,66 +171,6 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
>  		l3_qos_cfg_update(&hw_res->cdp_enabled);
>  }
>  
> -static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
> -{
> -	u32 num_closid = resctrl_arch_get_num_closid(r);
> -	int cpu = cpumask_any(&d->cpu_mask);
> -	int i;
> -
> -	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
> -				   GFP_KERNEL, cpu_to_node(cpu));
> -	if (!d->mbps_val)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < num_closid; i++)
> -		d->mbps_val[i] = MBA_MAX_MBPS;
> -
> -	return 0;
> -}
> -
> -static void mba_sc_domain_destroy(struct rdt_resource *r,
> -				  struct rdt_domain *d)
> -{
> -	kfree(d->mbps_val);
> -	d->mbps_val = NULL;
> -}
> -
> -/*
> - * MBA software controller is supported only if
> - * MBM is supported and MBA is in linear scale.
> - */
> -static bool supports_mba_mbps(void)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> -
> -	return (resctrl_arch_is_mbm_local_enabled() &&
> -		r->alloc_capable && is_mba_linear());
> -}
> -
> -/*
> - * Enable or disable the MBA software controller
> - * which helps user specify bandwidth in MBps.
> - */
> -static int set_mba_sc(bool mba_sc)
> -{
> -	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> -	u32 num_closid = resctrl_arch_get_num_closid(r);
> -	struct rdt_domain *d;
> -	int i;
> -
> -	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
> -		return -EINVAL;
> -
> -	r->membw.mba_sc = mba_sc;
> -
> -	list_for_each_entry(d, &r->domains, list) {
> -		for (i = 0; i < num_closid; i++)
> -			d->mbps_val[i] = MBA_MAX_MBPS;
> -	}
> -
> -	return 0;
> -}
> -
>  static int cdp_enable(int level)
>  {
>  	struct rdt_resource *r_l = &rdt_resources_all[level].r_resctrl;
> @@ -2467,414 +211,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>  	return 0;
>  }
>  
> -/*
> - * We don't allow rdtgroup directories to be created anywhere
> - * except the root directory. Thus when looking for the rdtgroup
> - * structure for a kernfs node we are either looking at a directory,
> - * in which case the rdtgroup structure is pointed at by the "priv"
> - * field, otherwise we have a file, and need only look to the parent
> - * to find the rdtgroup.
> - */
> -static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
> -{
> -	if (kernfs_type(kn) == KERNFS_DIR) {
> -		/*
> -		 * All the resource directories use "kn->priv"
> -		 * to point to the "struct rdtgroup" for the
> -		 * resource. "info" and its subdirectories don't
> -		 * have rdtgroup structures, so return NULL here.
> -		 */
> -		if (kn == kn_info || kn->parent == kn_info)
> -			return NULL;
> -		else
> -			return kn->priv;
> -	} else {
> -		return kn->parent->priv;
> -	}
> -}
> -
> -static void rdtgroup_kn_get(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
> -{
> -	atomic_inc(&rdtgrp->waitcount);
> -	kernfs_break_active_protection(kn);
> -}
> -
> -static void rdtgroup_kn_put(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
> -{
> -	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
> -	    (rdtgrp->flags & RDT_DELETED)) {
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> -		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
> -			rdtgroup_pseudo_lock_remove(rdtgrp);
> -		kernfs_unbreak_active_protection(kn);
> -		rdtgroup_remove(rdtgrp);
> -	} else {
> -		kernfs_unbreak_active_protection(kn);
> -	}
> -}
> -
> -struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
> -{
> -	struct rdtgroup *rdtgrp = kernfs_to_rdtgroup(kn);
> -
> -	if (!rdtgrp)
> -		return NULL;
> -
> -	rdtgroup_kn_get(rdtgrp, kn);
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	/* Was this group deleted while we waited? */
> -	if (rdtgrp->flags & RDT_DELETED)
> -		return NULL;
> -
> -	return rdtgrp;
> -}
> -
> -void rdtgroup_kn_unlock(struct kernfs_node *kn)
> -{
> -	struct rdtgroup *rdtgrp = kernfs_to_rdtgroup(kn);
> -
> -	if (!rdtgrp)
> -		return;
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -
> -	rdtgroup_kn_put(rdtgrp, kn);
> -}
> -
> -static int mkdir_mondata_all(struct kernfs_node *parent_kn,
> -			     struct rdtgroup *prgrp,
> -			     struct kernfs_node **mon_data_kn);
> -
> -static void rdt_disable_ctx(void)
> -{
> -	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> -	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> -	set_mba_sc(false);
> -
> -	resctrl_debug = false;
> -}
> -
> -static int rdt_enable_ctx(struct rdt_fs_context *ctx)
> -{
> -	int ret = 0;
> -
> -	if (ctx->enable_cdpl2) {
> -		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
> -		if (ret)
> -			goto out_done;
> -	}
> -
> -	if (ctx->enable_cdpl3) {
> -		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
> -		if (ret)
> -			goto out_cdpl2;
> -	}
> -
> -	if (ctx->enable_mba_mbps) {
> -		ret = set_mba_sc(true);
> -		if (ret)
> -			goto out_cdpl3;
> -	}
> -
> -	if (ctx->enable_debug)
> -		resctrl_debug = true;
> -
> -	return 0;
> -
> -out_cdpl3:
> -	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> -out_cdpl2:
> -	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> -out_done:
> -	return ret;
> -}
> -
> -static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type)
> -{
> -	struct resctrl_schema *s;
> -	const char *suffix = "";
> -	int ret, cl;
> -
> -	s = kzalloc(sizeof(*s), GFP_KERNEL);
> -	if (!s)
> -		return -ENOMEM;
> -
> -	s->res = r;
> -	s->num_closid = resctrl_arch_get_num_closid(r);
> -	if (resctrl_arch_get_cdp_enabled(r->rid))
> -		s->num_closid /= 2;
> -
> -	s->conf_type = type;
> -	switch (type) {
> -	case CDP_CODE:
> -		suffix = "CODE";
> -		break;
> -	case CDP_DATA:
> -		suffix = "DATA";
> -		break;
> -	case CDP_NONE:
> -		suffix = "";
> -		break;
> -	}
> -
> -	ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
> -	if (ret >= sizeof(s->name)) {
> -		kfree(s);
> -		return -EINVAL;
> -	}
> -
> -	cl = strlen(s->name);
> -
> -	/*
> -	 * If CDP is supported by this resource, but not enabled,
> -	 * include the suffix. This ensures the tabular format of the
> -	 * schemata file does not change between mounts of the filesystem.
> -	 */
> -	if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
> -		cl += 4;
> -
> -	if (cl > max_name_width)
> -		max_name_width = cl;
> -
> -	/*
> -	 * Choose a width for the resource data based on the resource that has
> -	 * widest name and cbm.
> -	 */
> -	max_data_width = max(max_data_width, r->data_width);
> -
> -	INIT_LIST_HEAD(&s->list);
> -	list_add(&s->list, &resctrl_schema_all);
> -
> -	return 0;
> -}
> -
> -static int schemata_list_create(void)
> -{
> -	enum resctrl_res_level i;
> -	struct rdt_resource *r;
> -	int ret = 0;
> -
> -	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> -		r = resctrl_arch_get_resource(i);
> -		if (!r->alloc_capable)
> -			continue;
> -
> -		if (resctrl_arch_get_cdp_enabled(r->rid)) {
> -			ret = schemata_list_add(r, CDP_CODE);
> -			if (ret)
> -				break;
> -
> -			ret = schemata_list_add(r, CDP_DATA);
> -		} else {
> -			ret = schemata_list_add(r, CDP_NONE);
> -		}
> -
> -		if (ret)
> -			break;
> -	}
> -
> -	return ret;
> -}
> -
> -static void schemata_list_destroy(void)
> -{
> -	struct resctrl_schema *s, *tmp;
> -
> -	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
> -		list_del(&s->list);
> -		kfree(s);
> -	}
> -}
> -
> -static int rdt_get_tree(struct fs_context *fc)
> -{
> -	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> -	unsigned long flags = RFTYPE_CTRL_BASE;
> -	struct rdt_domain *dom;
> -	int ret;
> -
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -	/*
> -	 * resctrl file system can only be mounted once.
> -	 */
> -	if (resctrl_mounted) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> -
> -	ret = rdtgroup_setup_root(ctx);
> -	if (ret)
> -		goto out;
> -
> -	ret = rdt_enable_ctx(ctx);
> -	if (ret)
> -		goto out_root;
> -
> -	ret = schemata_list_create();
> -	if (ret) {
> -		schemata_list_destroy();
> -		goto out_ctx;
> -	}
> -
> -	closid_init();
> -
> -	if (resctrl_arch_mon_capable())
> -		flags |= RFTYPE_MON;
> -
> -	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
> -	if (ret)
> -		goto out_schemata_free;
> -
> -	kernfs_activate(rdtgroup_default.kn);
> -
> -	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
> -	if (ret < 0)
> -		goto out_schemata_free;
> -
> -	if (resctrl_arch_mon_capable()) {
> -		ret = mongroup_create_dir(rdtgroup_default.kn,
> -					  &rdtgroup_default, "mon_groups",
> -					  &kn_mongrp);
> -		if (ret < 0)
> -			goto out_info;
> -
> -		ret = mkdir_mondata_all(rdtgroup_default.kn,
> -					&rdtgroup_default, &kn_mondata);
> -		if (ret < 0)
> -			goto out_mongrp;
> -		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> -	}
> -
> -	ret = rdt_pseudo_lock_init();
> -	if (ret)
> -		goto out_mondata;
> -
> -	ret = kernfs_get_tree(fc);
> -	if (ret < 0)
> -		goto out_psl;
> -
> -	if (resctrl_arch_alloc_capable())
> -		resctrl_arch_enable_alloc();
> -	if (resctrl_arch_mon_capable())
> -		resctrl_arch_enable_mon();
> -
> -	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
> -		resctrl_mounted = true;
> -
> -	if (resctrl_is_mbm_enabled()) {
> -		list_for_each_entry(dom, &l3->domains, list)
> -			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
> -						   RESCTRL_PICK_ANY_CPU);
> -	}
> -
> -	goto out;
> -
> -out_psl:
> -	rdt_pseudo_lock_release();
> -out_mondata:
> -	if (resctrl_arch_mon_capable())
> -		kernfs_remove(kn_mondata);
> -out_mongrp:
> -	if (resctrl_arch_mon_capable())
> -		kernfs_remove(kn_mongrp);
> -out_info:
> -	kernfs_remove(kn_info);
> -out_schemata_free:
> -	schemata_list_destroy();
> -out_ctx:
> -	rdt_disable_ctx();
> -out_root:
> -	rdtgroup_destroy_root();
> -out:
> -	rdt_last_cmd_clear();
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -	return ret;
> -}
> -
> -enum rdt_param {
> -	Opt_cdp,
> -	Opt_cdpl2,
> -	Opt_mba_mbps,
> -	Opt_debug,
> -	nr__rdt_params
> -};
> -
> -static const struct fs_parameter_spec rdt_fs_parameters[] = {
> -	fsparam_flag("cdp",		Opt_cdp),
> -	fsparam_flag("cdpl2",		Opt_cdpl2),
> -	fsparam_flag("mba_MBps",	Opt_mba_mbps),
> -	fsparam_flag("debug",		Opt_debug),
> -	{}
> -};
> -
> -static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
> -{
> -	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> -	struct fs_parse_result result;
> -	int opt;
> -
> -	opt = fs_parse(fc, rdt_fs_parameters, param, &result);
> -	if (opt < 0)
> -		return opt;
> -
> -	switch (opt) {
> -	case Opt_cdp:
> -		ctx->enable_cdpl3 = true;
> -		return 0;
> -	case Opt_cdpl2:
> -		ctx->enable_cdpl2 = true;
> -		return 0;
> -	case Opt_mba_mbps:
> -		if (!supports_mba_mbps())
> -			return -EINVAL;
> -		ctx->enable_mba_mbps = true;
> -		return 0;
> -	case Opt_debug:
> -		ctx->enable_debug = true;
> -		return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static void rdt_fs_context_free(struct fs_context *fc)
> -{
> -	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> -
> -	kernfs_free_fs_context(fc);
> -	kfree(ctx);
> -}
> -
> -static const struct fs_context_operations rdt_fs_context_ops = {
> -	.free		= rdt_fs_context_free,
> -	.parse_param	= rdt_parse_param,
> -	.get_tree	= rdt_get_tree,
> -};
> -
> -static int rdt_init_fs_context(struct fs_context *fc)
> -{
> -	struct rdt_fs_context *ctx;
> -
> -	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
> -	fc->fs_private = &ctx->kfc;
> -	fc->ops = &rdt_fs_context_ops;
> -	put_user_ns(fc->user_ns);
> -	fc->user_ns = get_user_ns(&init_user_ns);
> -	fc->global = true;
> -	return 0;
> -}
> -
>  static int reset_all_ctrls(struct rdt_resource *r)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> @@ -2922,1333 +258,3 @@ void resctrl_arch_reset_resources(void)
>  	for_each_capable_rdt_resource(r)
>  		reset_all_ctrls(r);
>  }
> -
> -/*
> - * Move tasks from one to the other group. If @from is NULL, then all tasks
> - * in the systems are moved unconditionally (used for teardown).
> - *
> - * If @mask is not NULL the cpus on which moved tasks are running are set
> - * in that mask so the update smp function call is restricted to affected
> - * cpus.
> - */
> -static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
> -				 struct cpumask *mask)
> -{
> -	struct task_struct *p, *t;
> -
> -	read_lock(&tasklist_lock);
> -	for_each_process_thread(p, t) {
> -		if (!from || is_closid_match(t, from) ||
> -		    is_rmid_match(t, from)) {
> -			resctrl_arch_set_closid_rmid(t, to->closid,
> -						     to->mon.rmid);
> -
> -			/*
> -			 * Order the closid/rmid stores above before the loads
> -			 * in task_curr(). This pairs with the full barrier
> -			 * between the rq->curr update and
> -			 * resctrl_arch_sched_in() during context switch.
> -			 */
> -			smp_mb();
> -
> -			/*
> -			 * If the task is on a CPU, set the CPU in the mask.
> -			 * The detection is inaccurate as tasks might move or
> -			 * schedule before the smp function call takes place.
> -			 * In such a case the function call is pointless, but
> -			 * there is no other side effect.
> -			 */
> -			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
> -				cpumask_set_cpu(task_cpu(t), mask);
> -		}
> -	}
> -	read_unlock(&tasklist_lock);
> -}
> -
> -static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
> -{
> -	struct rdtgroup *sentry, *stmp;
> -	struct list_head *head;
> -
> -	head = &rdtgrp->mon.crdtgrp_list;
> -	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> -		free_rmid(sentry->closid, sentry->mon.rmid);
> -		list_del(&sentry->mon.crdtgrp_list);
> -
> -		if (atomic_read(&sentry->waitcount) != 0)
> -			sentry->flags = RDT_DELETED;
> -		else
> -			rdtgroup_remove(sentry);
> -	}
> -}
> -
> -/*
> - * Forcibly remove all of subdirectories under root.
> - */
> -static void rmdir_all_sub(void)
> -{
> -	struct rdtgroup *rdtgrp, *tmp;
> -
> -	/* Move all tasks to the default resource group */
> -	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
> -
> -	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
> -		/* Free any child rmids */
> -		free_all_child_rdtgrp(rdtgrp);
> -
> -		/* Remove each rdtgroup other than root */
> -		if (rdtgrp == &rdtgroup_default)
> -			continue;
> -
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> -		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
> -			rdtgroup_pseudo_lock_remove(rdtgrp);
> -
> -		/*
> -		 * Give any CPUs back to the default group. We cannot copy
> -		 * cpu_online_mask because a CPU might have executed the
> -		 * offline callback already, but is still marked online.
> -		 */
> -		cpumask_or(&rdtgroup_default.cpu_mask,
> -			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
> -
> -		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> -
> -		kernfs_remove(rdtgrp->kn);
> -		list_del(&rdtgrp->rdtgroup_list);
> -
> -		if (atomic_read(&rdtgrp->waitcount) != 0)
> -			rdtgrp->flags = RDT_DELETED;
> -		else
> -			rdtgroup_remove(rdtgrp);
> -	}
> -	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
> -	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
> -
> -	kernfs_remove(kn_info);
> -	kernfs_remove(kn_mongrp);
> -	kernfs_remove(kn_mondata);
> -}
> -
> -static void rdt_kill_sb(struct super_block *sb)
> -{
> -	cpus_read_lock();
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	rdt_disable_ctx();
> -
> -	/* Put everything back to default values. */
> -	resctrl_arch_reset_resources();
> -
> -	rmdir_all_sub();
> -	rdt_pseudo_lock_release();
> -	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
> -	schemata_list_destroy();
> -	rdtgroup_destroy_root();
> -	if (resctrl_arch_alloc_capable())
> -		resctrl_arch_disable_alloc();
> -	if (resctrl_arch_mon_capable())
> -		resctrl_arch_disable_mon();
> -	resctrl_mounted = false;
> -	kernfs_kill_sb(sb);
> -	mutex_unlock(&rdtgroup_mutex);
> -	cpus_read_unlock();
> -}
> -
> -static struct file_system_type rdt_fs_type = {
> -	.name			= "resctrl",
> -	.init_fs_context	= rdt_init_fs_context,
> -	.parameters		= rdt_fs_parameters,
> -	.kill_sb		= rdt_kill_sb,
> -};
> -
> -static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
> -		       void *priv)
> -{
> -	struct kernfs_node *kn;
> -	int ret = 0;
> -
> -	kn = __kernfs_create_file(parent_kn, name, 0444,
> -				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> -				  &kf_mondata_ops, priv, NULL, NULL);
> -	if (IS_ERR(kn))
> -		return PTR_ERR(kn);
> -
> -	ret = rdtgroup_kn_set_ugid(kn);
> -	if (ret) {
> -		kernfs_remove(kn);
> -		return ret;
> -	}
> -
> -	return ret;
> -}
> -
> -/*
> - * Remove all subdirectories of mon_data of ctrl_mon groups
> - * and monitor groups with given domain id.
> - */
> -static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> -					   unsigned int dom_id)
> -{
> -	struct rdtgroup *prgrp, *crgrp;
> -	char name[32];
> -
> -	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		sprintf(name, "mon_%s_%02d", r->name, dom_id);
> -		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
> -
> -		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> -			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
> -	}
> -}
> -
> -static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
> -				struct rdt_domain *d,
> -				struct rdt_resource *r, struct rdtgroup *prgrp)
> -{
> -	union mon_data_bits priv;
> -	struct kernfs_node *kn;
> -	struct mon_evt *mevt;
> -	struct rmid_read rr;
> -	char name[32];
> -	int ret;
> -
> -	sprintf(name, "mon_%s_%02d", r->name, d->id);
> -	/* create the directory */
> -	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
> -	if (IS_ERR(kn))
> -		return PTR_ERR(kn);
> -
> -	ret = rdtgroup_kn_set_ugid(kn);
> -	if (ret)
> -		goto out_destroy;
> -
> -	if (WARN_ON(list_empty(&r->evt_list))) {
> -		ret = -EPERM;
> -		goto out_destroy;
> -	}
> -
> -	priv.u.rid = r->rid;
> -	priv.u.domid = d->id;
> -	list_for_each_entry(mevt, &r->evt_list, list) {
> -		priv.u.evtid = mevt->evtid;
> -		ret = mon_addfile(kn, mevt->name, priv.priv);
> -		if (ret)
> -			goto out_destroy;
> -
> -		if (resctrl_is_mbm_event(mevt->evtid))
> -			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
> -	}
> -	kernfs_activate(kn);
> -	return 0;
> -
> -out_destroy:
> -	kernfs_remove(kn);
> -	return ret;
> -}
> -
> -/*
> - * Add all subdirectories of mon_data for "ctrl_mon" groups
> - * and "monitor" groups with given domain id.
> - */
> -static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> -					   struct rdt_domain *d)
> -{
> -	struct kernfs_node *parent_kn;
> -	struct rdtgroup *prgrp, *crgrp;
> -	struct list_head *head;
> -
> -	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		parent_kn = prgrp->mon.mon_data_kn;
> -		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
> -
> -		head = &prgrp->mon.crdtgrp_list;
> -		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> -			parent_kn = crgrp->mon.mon_data_kn;
> -			mkdir_mondata_subdir(parent_kn, d, r, crgrp);
> -		}
> -	}
> -}
> -
> -static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
> -				       struct rdt_resource *r,
> -				       struct rdtgroup *prgrp)
> -{
> -	struct rdt_domain *dom;
> -	int ret;
> -
> -	/* Walking r->domains, ensure it can't race with cpuhp */
> -	lockdep_assert_cpus_held();
> -
> -	list_for_each_entry(dom, &r->domains, list) {
> -		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * This creates a directory mon_data which contains the monitored data.
> - *
> - * mon_data has one directory for each domain which are named
> - * in the format mon_<domain_name>_<domain_id>. For ex: A mon_data
> - * with L3 domain looks as below:
> - * ./mon_data:
> - * mon_L3_00
> - * mon_L3_01
> - * mon_L3_02
> - * ...
> - *
> - * Each domain directory has one file per event:
> - * ./mon_L3_00/:
> - * llc_occupancy
> - *
> - */
> -static int mkdir_mondata_all(struct kernfs_node *parent_kn,
> -			     struct rdtgroup *prgrp,
> -			     struct kernfs_node **dest_kn)
> -{
> -	enum resctrl_res_level i;
> -	struct rdt_resource *r;
> -	struct kernfs_node *kn;
> -	int ret;
> -
> -	/*
> -	 * Create the mon_data directory first.
> -	 */
> -	ret = mongroup_create_dir(parent_kn, prgrp, "mon_data", &kn);
> -	if (ret)
> -		return ret;
> -
> -	if (dest_kn)
> -		*dest_kn = kn;
> -
> -	/*
> -	 * Create the subdirectories for each domain. Note that all events
> -	 * in a domain like L3 are grouped into a resource whose domain is L3
> -	 */
> -	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> -		r = resctrl_arch_get_resource(i);
> -		if (!r->mon_capable)
> -			continue;
> -
> -		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
> -		if (ret)
> -			goto out_destroy;
> -	}
> -
> -	return 0;
> -
> -out_destroy:
> -	kernfs_remove(kn);
> -	return ret;
> -}
> -
> -/**
> - * cbm_ensure_valid - Enforce validity on provided CBM
> - * @_val:	Candidate CBM
> - * @r:		RDT resource to which the CBM belongs
> - *
> - * The provided CBM represents all cache portions available for use. This
> - * may be represented by a bitmap that does not consist of contiguous ones
> - * and thus be an invalid CBM.
> - * Here the provided CBM is forced to be a valid CBM by only considering
> - * the first set of contiguous bits as valid and clearing all bits.
> - * The intention here is to provide a valid default CBM with which a new
> - * resource group is initialized. The user can follow this with a
> - * modification to the CBM if the default does not satisfy the
> - * requirements.
> - */
> -static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
> -{
> -	unsigned int cbm_len = r->cache.cbm_len;
> -	unsigned long first_bit, zero_bit;
> -	unsigned long val = _val;
> -
> -	if (!val)
> -		return 0;
> -
> -	first_bit = find_first_bit(&val, cbm_len);
> -	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> -
> -	/* Clear any remaining bits to ensure contiguous region */
> -	bitmap_clear(&val, zero_bit, cbm_len - zero_bit);
> -	return (u32)val;
> -}
> -
> -/*
> - * Initialize cache resources per RDT domain
> - *
> - * Set the RDT domain up to start off with all usable allocations. That is,
> - * all shareable and unused bits. All-zero CBM is invalid.
> - */
> -static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
> -				 u32 closid)
> -{
> -	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
> -	enum resctrl_conf_type t = s->conf_type;
> -	struct resctrl_staged_config *cfg;
> -	struct rdt_resource *r = s->res;
> -	u32 used_b = 0, unused_b = 0;
> -	unsigned long tmp_cbm;
> -	enum rdtgrp_mode mode;
> -	u32 peer_ctl, ctrl_val;
> -	int i;
> -
> -	cfg = &d->staged_config[t];
> -	cfg->have_new_ctrl = false;
> -	cfg->new_ctrl = r->cache.shareable_bits;
> -	used_b = r->cache.shareable_bits;
> -	for (i = 0; i < closids_supported(); i++) {
> -		if (closid_allocated(i) && i != closid) {
> -			mode = rdtgroup_mode_by_closid(i);
> -			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
> -				/*
> -				 * ctrl values for locksetup aren't relevant
> -				 * until the schemata is written, and the mode
> -				 * becomes RDT_MODE_PSEUDO_LOCKED.
> -				 */
> -				continue;
> -			/*
> -			 * If CDP is active include peer domain's
> -			 * usage to ensure there is no overlap
> -			 * with an exclusive group.
> -			 */
> -			if (resctrl_arch_get_cdp_enabled(r->rid))
> -				peer_ctl = resctrl_arch_get_config(r, d, i,
> -								   peer_type);
> -			else
> -				peer_ctl = 0;
> -			ctrl_val = resctrl_arch_get_config(r, d, i,
> -							   s->conf_type);
> -			used_b |= ctrl_val | peer_ctl;
> -			if (mode == RDT_MODE_SHAREABLE)
> -				cfg->new_ctrl |= ctrl_val | peer_ctl;
> -		}
> -	}
> -	if (d->plr && d->plr->cbm > 0)
> -		used_b |= d->plr->cbm;
> -	unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
> -	unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
> -	cfg->new_ctrl |= unused_b;
> -	/*
> -	 * Force the initial CBM to be valid, user can
> -	 * modify the CBM based on system availability.
> -	 */
> -	cfg->new_ctrl = cbm_ensure_valid(cfg->new_ctrl, r);
> -	/*
> -	 * Assign the u32 CBM to an unsigned long to ensure that
> -	 * bitmap_weight() does not access out-of-bound memory.
> -	 */
> -	tmp_cbm = cfg->new_ctrl;
> -	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
> -		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
> -		return -ENOSPC;
> -	}
> -	cfg->have_new_ctrl = true;
> -
> -	return 0;
> -}
> -
> -/*
> - * Initialize cache resources with default values.
> - *
> - * A new RDT group is being created on an allocation capable (CAT)
> - * supporting system. Set this group up to start off with all usable
> - * allocations.
> - *
> - * If there are no more shareable bits available on any domain then
> - * the entire allocation will fail.
> - */
> -static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
> -{
> -	struct rdt_domain *d;
> -	int ret;
> -
> -	list_for_each_entry(d, &s->res->domains, list) {
> -		ret = __init_one_rdt_domain(d, s, closid);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -/* Initialize MBA resource with default values. */
> -static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
> -{
> -	struct resctrl_staged_config *cfg;
> -	struct rdt_domain *d;
> -
> -	list_for_each_entry(d, &r->domains, list) {
> -		if (is_mba_sc(r)) {
> -			d->mbps_val[closid] = MBA_MAX_MBPS;
> -			continue;
> -		}
> -
> -		cfg = &d->staged_config[CDP_NONE];
> -		cfg->new_ctrl = r->default_ctrl;
> -		cfg->have_new_ctrl = true;
> -	}
> -}
> -
> -/* Initialize the RDT group's allocations. */
> -static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
> -{
> -	struct resctrl_schema *s;
> -	struct rdt_resource *r;
> -	int ret = 0;
> -
> -	rdt_staged_configs_clear();
> -
> -	list_for_each_entry(s, &resctrl_schema_all, list) {
> -		r = s->res;
> -		if (r->rid == RDT_RESOURCE_MBA ||
> -		    r->rid == RDT_RESOURCE_SMBA) {
> -			rdtgroup_init_mba(r, rdtgrp->closid);
> -			if (is_mba_sc(r))
> -				continue;
> -		} else {
> -			ret = rdtgroup_init_cat(s, rdtgrp->closid);
> -			if (ret < 0)
> -				goto out;
> -		}
> -
> -		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> -		if (ret < 0) {
> -			rdt_last_cmd_puts("Failed to initialize allocations\n");
> -			goto out;
> -		}
> -
> -	}
> -
> -	rdtgrp->mode = RDT_MODE_SHAREABLE;
> -
> -out:
> -	rdt_staged_configs_clear();
> -	return ret;
> -}
> -
> -static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
> -{
> -	int ret;
> -
> -	if (!resctrl_arch_mon_capable())
> -		return 0;
> -
> -	ret = alloc_rmid(rdtgrp->closid);
> -	if (ret < 0) {
> -		rdt_last_cmd_puts("Out of RMIDs\n");
> -		return ret;
> -	}
> -	rdtgrp->mon.rmid = ret;
> -
> -	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
> -	if (ret) {
> -		rdt_last_cmd_puts("kernfs subdir error\n");
> -		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
> -{
> -	if (resctrl_arch_mon_capable())
> -		free_rmid(rgrp->closid, rgrp->mon.rmid);
> -}
> -
> -static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
> -			     const char *name, umode_t mode,
> -			     enum rdt_group_type rtype, struct rdtgroup **r)
> -{
> -	struct rdtgroup *prdtgrp, *rdtgrp;
> -	unsigned long files = 0;
> -	struct kernfs_node *kn;
> -	int ret;
> -
> -	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
> -	if (!prdtgrp) {
> -		ret = -ENODEV;
> -		goto out_unlock;
> -	}
> -
> -	if (rtype == RDTMON_GROUP &&
> -	    (prdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> -	     prdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)) {
> -		ret = -EINVAL;
> -		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> -		goto out_unlock;
> -	}
> -
> -	/* allocate the rdtgroup. */
> -	rdtgrp = kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
> -	if (!rdtgrp) {
> -		ret = -ENOSPC;
> -		rdt_last_cmd_puts("Kernel out of memory\n");
> -		goto out_unlock;
> -	}
> -	*r = rdtgrp;
> -	rdtgrp->mon.parent = prdtgrp;
> -	rdtgrp->type = rtype;
> -	INIT_LIST_HEAD(&rdtgrp->mon.crdtgrp_list);
> -
> -	/* kernfs creates the directory for rdtgrp */
> -	kn = kernfs_create_dir(parent_kn, name, mode, rdtgrp);
> -	if (IS_ERR(kn)) {
> -		ret = PTR_ERR(kn);
> -		rdt_last_cmd_puts("kernfs create error\n");
> -		goto out_free_rgrp;
> -	}
> -	rdtgrp->kn = kn;
> -
> -	/*
> -	 * kernfs_remove() will drop the reference count on "kn" which
> -	 * will free it. But we still need it to stick around for the
> -	 * rdtgroup_kn_unlock(kn) call. Take one extra reference here,
> -	 * which will be dropped by kernfs_put() in rdtgroup_remove().
> -	 */
> -	kernfs_get(kn);
> -
> -	ret = rdtgroup_kn_set_ugid(kn);
> -	if (ret) {
> -		rdt_last_cmd_puts("kernfs perm error\n");
> -		goto out_destroy;
> -	}
> -
> -	if (rtype == RDTCTRL_GROUP) {
> -		files = RFTYPE_BASE | RFTYPE_CTRL;
> -		if (resctrl_arch_mon_capable())
> -			files |= RFTYPE_MON;
> -	} else {
> -		files = RFTYPE_BASE | RFTYPE_MON;
> -	}
> -
> -	ret = rdtgroup_add_files(kn, files);
> -	if (ret) {
> -		rdt_last_cmd_puts("kernfs fill error\n");
> -		goto out_destroy;
> -	}
> -
> -	/*
> -	 * The caller unlocks the parent_kn upon success.
> -	 */
> -	return 0;
> -
> -out_destroy:
> -	kernfs_put(rdtgrp->kn);
> -	kernfs_remove(rdtgrp->kn);
> -out_free_rgrp:
> -	kfree(rdtgrp);
> -out_unlock:
> -	rdtgroup_kn_unlock(parent_kn);
> -	return ret;
> -}
> -
> -static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
> -{
> -	kernfs_remove(rgrp->kn);
> -	rdtgroup_remove(rgrp);
> -}
> -
> -/*
> - * Create a monitor group under "mon_groups" directory of a control
> - * and monitor group(ctrl_mon). This is a resource group
> - * to monitor a subset of tasks and cpus in its parent ctrl_mon group.
> - */
> -static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
> -			      const char *name, umode_t mode)
> -{
> -	struct rdtgroup *rdtgrp, *prgrp;
> -	int ret;
> -
> -	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
> -	if (ret)
> -		return ret;
> -
> -	prgrp = rdtgrp->mon.parent;
> -	rdtgrp->closid = prgrp->closid;
> -
> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret) {
> -		mkdir_rdt_prepare_clean(rdtgrp);
> -		goto out_unlock;
> -	}
> -
> -	kernfs_activate(rdtgrp->kn);
> -
> -	/*
> -	 * Add the rdtgrp to the list of rdtgrps the parent
> -	 * ctrl_mon group has to track.
> -	 */
> -	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
> -
> -out_unlock:
> -	rdtgroup_kn_unlock(parent_kn);
> -	return ret;
> -}
> -
> -/*
> - * These are rdtgroups created under the root directory. Can be used
> - * to allocate and monitor resources.
> - */
> -static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
> -				   const char *name, umode_t mode)
> -{
> -	struct rdtgroup *rdtgrp;
> -	struct kernfs_node *kn;
> -	u32 closid;
> -	int ret;
> -
> -	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTCTRL_GROUP, &rdtgrp);
> -	if (ret)
> -		return ret;
> -
> -	kn = rdtgrp->kn;
> -	ret = closid_alloc();
> -	if (ret < 0) {
> -		rdt_last_cmd_puts("Out of CLOSIDs\n");
> -		goto out_common_fail;
> -	}
> -	closid = ret;
> -	ret = 0;
> -
> -	rdtgrp->closid = closid;
> -
> -	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> -	if (ret)
> -		goto out_closid_free;
> -
> -	kernfs_activate(rdtgrp->kn);
> -
> -	ret = rdtgroup_init_alloc(rdtgrp);
> -	if (ret < 0)
> -		goto out_rmid_free;
> -
> -	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
> -
> -	if (resctrl_arch_mon_capable()) {
> -		/*
> -		 * Create an empty mon_groups directory to hold the subset
> -		 * of tasks and cpus to monitor.
> -		 */
> -		ret = mongroup_create_dir(kn, rdtgrp, "mon_groups", NULL);
> -		if (ret) {
> -			rdt_last_cmd_puts("kernfs subdir error\n");
> -			goto out_del_list;
> -		}
> -	}
> -
> -	goto out_unlock;
> -
> -out_del_list:
> -	list_del(&rdtgrp->rdtgroup_list);
> -out_rmid_free:
> -	mkdir_rdt_prepare_rmid_free(rdtgrp);
> -out_closid_free:
> -	closid_free(closid);
> -out_common_fail:
> -	mkdir_rdt_prepare_clean(rdtgrp);
> -out_unlock:
> -	rdtgroup_kn_unlock(parent_kn);
> -	return ret;
> -}
> -
> -/*
> - * We allow creating mon groups only with in a directory called "mon_groups"
> - * which is present in every ctrl_mon group. Check if this is a valid
> - * "mon_groups" directory.
> - *
> - * 1. The directory should be named "mon_groups".
> - * 2. The mon group itself should "not" be named "mon_groups".
> - *   This makes sure "mon_groups" directory always has a ctrl_mon group
> - *   as parent.
> - */
> -static bool is_mon_groups(struct kernfs_node *kn, const char *name)
> -{
> -	return (!strcmp(kn->name, "mon_groups") &&
> -		strcmp(name, "mon_groups"));
> -}
> -
> -static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
> -			  umode_t mode)
> -{
> -	/* Do not accept '\n' to avoid unparsable situation. */
> -	if (strchr(name, '\n'))
> -		return -EINVAL;
> -
> -	/*
> -	 * If the parent directory is the root directory and RDT
> -	 * allocation is supported, add a control and monitoring
> -	 * subdirectory
> -	 */
> -	if (resctrl_arch_alloc_capable() && parent_kn == rdtgroup_default.kn)
> -		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
> -
> -	/*
> -	 * If RDT monitoring is supported and the parent directory is a valid
> -	 * "mon_groups" directory, add a monitoring subdirectory.
> -	 */
> -	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
> -		return rdtgroup_mkdir_mon(parent_kn, name, mode);
> -
> -	return -EPERM;
> -}
> -
> -static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> -{
> -	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> -	u32 closid, rmid;
> -	int cpu;
> -
> -	/* Give any tasks back to the parent group */
> -	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
> -
> -	/* Update per cpu rmid of the moved CPUs first */
> -	closid = rdtgrp->closid;
> -	rmid = prdtgrp->mon.rmid;
> -	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> -		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
> -
> -	/*
> -	 * Update the MSR on moved CPUs and CPUs which have moved
> -	 * task running on them.
> -	 */
> -	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> -	update_closid_rmid(tmpmask, NULL);
> -
> -	rdtgrp->flags = RDT_DELETED;
> -	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> -
> -	/*
> -	 * Remove the rdtgrp from the parent ctrl_mon group's list
> -	 */
> -	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> -	list_del(&rdtgrp->mon.crdtgrp_list);
> -
> -	kernfs_remove(rdtgrp->kn);
> -
> -	return 0;
> -}
> -
> -static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
> -{
> -	rdtgrp->flags = RDT_DELETED;
> -	list_del(&rdtgrp->rdtgroup_list);
> -
> -	kernfs_remove(rdtgrp->kn);
> -	return 0;
> -}
> -
> -static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> -{
> -	u32 closid, rmid;
> -	int cpu;
> -
> -	/* Give any tasks back to the default group */
> -	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
> -
> -	/* Give any CPUs back to the default group */
> -	cpumask_or(&rdtgroup_default.cpu_mask,
> -		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
> -
> -	/* Update per cpu closid and rmid of the moved CPUs first */
> -	closid = rdtgroup_default.closid;
> -	rmid = rdtgroup_default.mon.rmid;
> -	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> -		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
> -
> -	/*
> -	 * Update the MSR on moved CPUs and CPUs which have moved
> -	 * task running on them.
> -	 */
> -	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> -	update_closid_rmid(tmpmask, NULL);
> -
> -	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> -	closid_free(rdtgrp->closid);
> -
> -	rdtgroup_ctrl_remove(rdtgrp);
> -
> -	/*
> -	 * Free all the child monitor group rmids.
> -	 */
> -	free_all_child_rdtgrp(rdtgrp);
> -
> -	return 0;
> -}
> -
> -static int rdtgroup_rmdir(struct kernfs_node *kn)
> -{
> -	struct kernfs_node *parent_kn = kn->parent;
> -	struct rdtgroup *rdtgrp;
> -	cpumask_var_t tmpmask;
> -	int ret = 0;
> -
> -	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	rdtgrp = rdtgroup_kn_lock_live(kn);
> -	if (!rdtgrp) {
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
> -	/*
> -	 * If the rdtgroup is a ctrl_mon group and parent directory
> -	 * is the root directory, remove the ctrl_mon group.
> -	 *
> -	 * If the rdtgroup is a mon group and parent directory
> -	 * is a valid "mon_groups" directory, remove the mon group.
> -	 */
> -	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn &&
> -	    rdtgrp != &rdtgroup_default) {
> -		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> -		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> -			ret = rdtgroup_ctrl_remove(rdtgrp);
> -		} else {
> -			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
> -		}
> -	} else if (rdtgrp->type == RDTMON_GROUP &&
> -		 is_mon_groups(parent_kn, kn->name)) {
> -		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
> -	} else {
> -		ret = -EPERM;
> -	}
> -
> -out:
> -	rdtgroup_kn_unlock(kn);
> -	free_cpumask_var(tmpmask);
> -	return ret;
> -}
> -
> -/**
> - * mongrp_reparent() - replace parent CTRL_MON group of a MON group
> - * @rdtgrp:		the MON group whose parent should be replaced
> - * @new_prdtgrp:	replacement parent CTRL_MON group for @rdtgrp
> - * @cpus:		cpumask provided by the caller for use during this call
> - *
> - * Replaces the parent CTRL_MON group for a MON group, resulting in all member
> - * tasks' CLOSID immediately changing to that of the new parent group.
> - * Monitoring data for the group is unaffected by this operation.
> - */
> -static void mongrp_reparent(struct rdtgroup *rdtgrp,
> -			    struct rdtgroup *new_prdtgrp,
> -			    cpumask_var_t cpus)
> -{
> -	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> -
> -	WARN_ON(rdtgrp->type != RDTMON_GROUP);
> -	WARN_ON(new_prdtgrp->type != RDTCTRL_GROUP);
> -
> -	/* Nothing to do when simply renaming a MON group. */
> -	if (prdtgrp == new_prdtgrp)
> -		return;
> -
> -	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> -	list_move_tail(&rdtgrp->mon.crdtgrp_list,
> -		       &new_prdtgrp->mon.crdtgrp_list);
> -
> -	rdtgrp->mon.parent = new_prdtgrp;
> -	rdtgrp->closid = new_prdtgrp->closid;
> -
> -	/* Propagate updated closid to all tasks in this group. */
> -	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
> -
> -	update_closid_rmid(cpus, NULL);
> -}
> -
> -static int rdtgroup_rename(struct kernfs_node *kn,
> -			   struct kernfs_node *new_parent, const char *new_name)
> -{
> -	struct rdtgroup *new_prdtgrp;
> -	struct rdtgroup *rdtgrp;
> -	cpumask_var_t tmpmask;
> -	int ret;
> -
> -	rdtgrp = kernfs_to_rdtgroup(kn);
> -	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
> -	if (!rdtgrp || !new_prdtgrp)
> -		return -ENOENT;
> -
> -	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
> -	rdtgroup_kn_get(rdtgrp, kn);
> -	rdtgroup_kn_get(new_prdtgrp, new_parent);
> -
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	rdt_last_cmd_clear();
> -
> -	/*
> -	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
> -	 * either kernfs_node is a file.
> -	 */
> -	if (kernfs_type(kn) != KERNFS_DIR ||
> -	    kernfs_type(new_parent) != KERNFS_DIR) {
> -		rdt_last_cmd_puts("Source and destination must be directories");
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
> -	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
> -		ret = -ENOENT;
> -		goto out;
> -	}
> -
> -	if (rdtgrp->type != RDTMON_GROUP || !kn->parent ||
> -	    !is_mon_groups(kn->parent, kn->name)) {
> -		rdt_last_cmd_puts("Source must be a MON group\n");
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
> -	if (!is_mon_groups(new_parent, new_name)) {
> -		rdt_last_cmd_puts("Destination must be a mon_groups subdirectory\n");
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
> -	/*
> -	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
> -	 * current parent CTRL_MON group and therefore cannot be assigned to
> -	 * the new parent, making the move illegal.
> -	 */
> -	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
> -	    rdtgrp->mon.parent != new_prdtgrp) {
> -		rdt_last_cmd_puts("Cannot move a MON group that monitors CPUs\n");
> -		ret = -EPERM;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
> -	 * possibility of failing to allocate it after kernfs_rename() has
> -	 * succeeded.
> -	 */
> -	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL)) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Perform all input validation and allocations needed to ensure
> -	 * mongrp_reparent() will succeed before calling kernfs_rename(),
> -	 * otherwise it would be necessary to revert this call if
> -	 * mongrp_reparent() failed.
> -	 */
> -	ret = kernfs_rename(kn, new_parent, new_name);
> -	if (!ret)
> -		mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
> -
> -	free_cpumask_var(tmpmask);
> -
> -out:
> -	mutex_unlock(&rdtgroup_mutex);
> -	rdtgroup_kn_put(rdtgrp, kn);
> -	rdtgroup_kn_put(new_prdtgrp, new_parent);
> -	return ret;
> -}
> -
> -static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
> -{
> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> -		seq_puts(seq, ",cdp");
> -
> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
> -		seq_puts(seq, ",cdpl2");
> -
> -	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
> -		seq_puts(seq, ",mba_MBps");
> -
> -	if (resctrl_debug)
> -		seq_puts(seq, ",debug");
> -
> -	return 0;
> -}
> -
> -static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
> -	.mkdir		= rdtgroup_mkdir,
> -	.rmdir		= rdtgroup_rmdir,
> -	.rename		= rdtgroup_rename,
> -	.show_options	= rdtgroup_show_options,
> -};
> -
> -static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
> -{
> -	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
> -				      KERNFS_ROOT_CREATE_DEACTIVATED |
> -				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
> -				      &rdtgroup_default);
> -	if (IS_ERR(rdt_root))
> -		return PTR_ERR(rdt_root);
> -
> -	ctx->kfc.root = rdt_root;
> -	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> -
> -	return 0;
> -}
> -
> -static void rdtgroup_destroy_root(void)
> -{
> -	kernfs_destroy_root(rdt_root);
> -	rdtgroup_default.kn = NULL;
> -}
> -
> -static void rdtgroup_setup_default(void)
> -{
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
> -	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
> -	rdtgroup_default.type = RDTCTRL_GROUP;
> -	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
> -
> -	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
> -
> -	mutex_unlock(&rdtgroup_mutex);
> -}
> -
> -static void domain_destroy_mon_state(struct rdt_domain *d)
> -{
> -	bitmap_free(d->rmid_busy_llc);
> -	kfree(d->mbm_total);
> -	kfree(d->mbm_local);
> -}
> -
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> -{
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
> -		mba_sc_domain_destroy(r, d);
> -
> -	if (!r->mon_capable)
> -		goto out_unlock;
> -
> -	/*
> -	 * If resctrl is mounted, remove all the
> -	 * per domain monitor data directories.
> -	 */
> -	if (resctrl_mounted && resctrl_arch_mon_capable())
> -		rmdir_mondata_subdir_allrdtgrp(r, d->id);
> -
> -	if (resctrl_is_mbm_enabled())
> -		cancel_delayed_work(&d->mbm_over);
> -	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
> -		/*
> -		 * When a package is going down, forcefully
> -		 * decrement rmid->ebusy. There is no way to know
> -		 * that the L3 was flushed and hence may lead to
> -		 * incorrect counts in rare scenarios, but leaving
> -		 * the RMID as busy creates RMID leaks if the
> -		 * package never comes back.
> -		 */
> -		__check_limbo(d, true);
> -		cancel_delayed_work(&d->cqm_limbo);
> -	}
> -
> -	domain_destroy_mon_state(d);
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -}
> -
> -static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
> -{
> -	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> -	size_t tsize;
> -
> -	if (resctrl_arch_is_llc_occupancy_enabled()) {
> -		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
> -		if (!d->rmid_busy_llc)
> -			return -ENOMEM;
> -	}
> -	if (resctrl_arch_is_mbm_total_enabled()) {
> -		tsize = sizeof(*d->mbm_total);
> -		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
> -		if (!d->mbm_total) {
> -			bitmap_free(d->rmid_busy_llc);
> -			return -ENOMEM;
> -		}
> -	}
> -	if (resctrl_arch_is_mbm_local_enabled()) {
> -		tsize = sizeof(*d->mbm_local);
> -		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
> -		if (!d->mbm_local) {
> -			bitmap_free(d->rmid_busy_llc);
> -			kfree(d->mbm_total);
> -			return -ENOMEM;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> -{
> -	int err = 0;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -
> -	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA) {
> -		/* RDT_RESOURCE_MBA is never mon_capable */
> -		err = mba_sc_domain_allocate(r, d);
> -		goto out_unlock;
> -	}
> -
> -	if (!r->mon_capable)
> -		goto out_unlock;
> -
> -	err = domain_setup_mon_state(r, d);
> -	if (err)
> -		goto out_unlock;
> -
> -	if (resctrl_is_mbm_enabled()) {
> -		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> -		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
> -					   RESCTRL_PICK_ANY_CPU);
> -	}
> -
> -	if (resctrl_arch_is_llc_occupancy_enabled())
> -		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
> -
> -	/*
> -	 * If the filesystem is not mounted then only the default resource group
> -	 * exists. Creation of its directories is deferred until mount time
> -	 * by rdt_get_tree() calling mkdir_mondata_all().
> -	 * If resctrl is mounted, add per domain monitor data directories.
> -	 */
> -	if (resctrl_mounted && resctrl_arch_mon_capable())
> -		mkdir_mondata_subdir_allrdtgrp(r, d);
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -
> -	return err;
> -}
> -
> -void resctrl_online_cpu(unsigned int cpu)
> -{
> -	mutex_lock(&rdtgroup_mutex);
> -	/* The CPU is set in default rdtgroup after online. */
> -	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> -	mutex_unlock(&rdtgroup_mutex);
> -}
> -
> -static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> -{
> -	struct rdtgroup *cr;
> -
> -	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
> -		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
> -			break;
> -	}
> -}
> -
> -void resctrl_offline_cpu(unsigned int cpu)
> -{
> -	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> -	struct rdtgroup *rdtgrp;
> -	struct rdt_domain *d;
> -
> -	mutex_lock(&rdtgroup_mutex);
> -	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> -		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
> -			clear_childcpus(rdtgrp, cpu);
> -			break;
> -		}
> -	}
> -
> -	if (!l3->mon_capable)
> -		goto out_unlock;
> -
> -	d = resctrl_get_domain_from_cpu(cpu, l3);
> -	if (d) {
> -		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> -			cancel_delayed_work(&d->mbm_over);
> -			mbm_setup_overflow_handler(d, 0, cpu);
> -		}
> -		if (resctrl_arch_is_llc_occupancy_enabled() &&
> -		    cpu == d->cqm_work_cpu && has_busy_rmid(d)) {
> -			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0, cpu);
> -		}
> -	}
> -
> -out_unlock:
> -	mutex_unlock(&rdtgroup_mutex);
> -}
> -
> -/*
> - * resctrl_init - resctrl filesystem initialization
> - *
> - * Setup resctrl file system including set up root, create mount point,
> - * register resctrl filesystem, and initialize files under root directory.
> - *
> - * Return: 0 on success or -errno
> - */
> -int resctrl_init(void)
> -{
> -	int ret = 0;
> -
> -	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
> -		     sizeof(last_cmd_status_buf));
> -
> -	rdtgroup_setup_default();
> -
> -	thread_throttle_mode_init();
> -
> -	ret = resctrl_mon_resource_init();
> -	if (ret)
> -		return ret;
> -
> -	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
> -	if (ret)
> -		return ret;
> -
> -	ret = register_filesystem(&rdt_fs_type);
> -	if (ret)
> -		goto cleanup_mountpoint;
> -
> -	/*
> -	 * Adding the resctrl debugfs directory here may not be ideal since
> -	 * it would let the resctrl debugfs directory appear on the debugfs
> -	 * filesystem before the resctrl filesystem is mounted.
> -	 * It may also be ok since that would enable debugging of RDT before
> -	 * resctrl is mounted.
> -	 * The reason why the debugfs directory is created here and not in
> -	 * rdt_get_tree() is because rdt_get_tree() takes rdtgroup_mutex and
> -	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
> -	 * (the lockdep class of inode->i_rwsem). Other filesystem
> -	 * interactions (eg. SyS_getdents) have the lock ordering:
> -	 * &sb->s_type->i_mutex_key --> &mm->mmap_lock
> -	 * During mmap(), called with &mm->mmap_lock, the rdtgroup_mutex
> -	 * is taken, thus creating dependency:
> -	 * &mm->mmap_lock --> rdtgroup_mutex for the latter that can cause
> -	 * issues considering the other two lock dependencies.
> -	 * By creating the debugfs directory here we avoid a dependency
> -	 * that may cause deadlock (even though file operations cannot
> -	 * occur until the filesystem is mounted, but I do not know how to
> -	 * tell lockdep that).
> -	 */
> -	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
> -
> -	return 0;
> -
> -cleanup_mountpoint:
> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -
> -	return ret;
> -}
> -
> -void resctrl_exit(void)
> -{
> -	debugfs_remove_recursive(debugfs_resctrl);
> -	unregister_filesystem(&rdt_fs_type);
> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -
> -	resctrl_mon_resource_exit();
> -}
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index e69de29bb2d1..a8f2dd66ede3 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -0,0 +1,527 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Resource Director Technology(RDT)
> + * - Cache Allocation code.
> + *
> + * Copyright (C) 2016 Intel Corporation
> + *
> + * Authors:
> + *    Fenghua Yu <fenghua.yu@intel.com>
> + *    Tony Luck <tony.luck@intel.com>
> + *
> + * More information about RDT be found in the Intel (R) x86 Architecture
> + * Software Developer Manual June 2016, volume 3, section 17.17.
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/kernfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include "internal.h"
> +
> +struct rdt_parse_data {
> +	struct rdtgroup		*rdtgrp;
> +	char			*buf;
> +};
> +
> +typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
> +			       struct resctrl_schema *s,
> +			       struct rdt_domain *d);
> +
> +/*
> + * Check whether MBA bandwidth percentage value is correct. The value is
> + * checked against the minimum and max bandwidth values specified by the
> + * hardware. The allocated bandwidth percentage is rounded to the next
> + * control step available on the hardware.
> + */
> +static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
> +{
> +	unsigned long bw;
> +	int ret;
> +
> +	/*
> +	 * Only linear delay values is supported for current Intel SKUs.
> +	 */
> +	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
> +		rdt_last_cmd_puts("No support for non-linear MB domains\n");
> +		return false;
> +	}
> +
> +	ret = kstrtoul(buf, 10, &bw);
> +	if (ret) {
> +		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> +		return false;
> +	}
> +
> +	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
> +	    !is_mba_sc(r)) {
> +		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
> +				    r->membw.min_bw, r->default_ctrl);
> +		return false;
> +	}
> +
> +	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> +	return true;
> +}
> +
> +static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
> +		    struct rdt_domain *d)
> +{
> +	struct resctrl_staged_config *cfg;
> +	u32 closid = data->rdtgrp->closid;
> +	struct rdt_resource *r = s->res;
> +	unsigned long bw_val;
> +
> +	cfg = &d->staged_config[s->conf_type];
> +	if (cfg->have_new_ctrl) {
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		return -EINVAL;
> +	}
> +
> +	if (!bw_validate(data->buf, &bw_val, r))
> +		return -EINVAL;
> +
> +	if (is_mba_sc(r)) {
> +		d->mbps_val[closid] = bw_val;
> +		return 0;
> +	}
> +
> +	cfg->new_ctrl = bw_val;
> +	cfg->have_new_ctrl = true;
> +
> +	return 0;
> +}
> +
> +/*
> + * Check whether a cache bit mask is valid.
> + * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
> + *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
> + *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
> + *
> + * Haswell does not support a non-contiguous 1s value and additionally
> + * requires at least two bits set.
> + * AMD allows non-contiguous bitmasks.
> + */
> +static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
> +{
> +	unsigned long first_bit, zero_bit, val;
> +	unsigned int cbm_len = r->cache.cbm_len;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 16, &val);
> +	if (ret) {
> +		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
> +		return false;
> +	}
> +
> +	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > r->default_ctrl) {
> +		rdt_last_cmd_puts("Mask out of range\n");
> +		return false;
> +	}
> +
> +	first_bit = find_first_bit(&val, cbm_len);
> +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> +
> +	/* Are non-contiguous bitmasks allowed? */
> +	if (!r->cache.arch_has_sparse_bitmasks &&
> +	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
> +		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
> +		return false;
> +	}
> +
> +	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> +		rdt_last_cmd_printf("Need at least %d bits in the mask\n",
> +				    r->cache.min_cbm_bits);
> +		return false;
> +	}
> +
> +	*data = val;
> +	return true;
> +}
> +
> +/*
> + * Read one cache bit mask (hex). Check that it is valid for the current
> + * resource type.
> + */
> +static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> +		     struct rdt_domain *d)
> +{
> +	struct rdtgroup *rdtgrp = data->rdtgrp;
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_resource *r = s->res;
> +	u32 cbm_val;
> +
> +	cfg = &d->staged_config[s->conf_type];
> +	if (cfg->have_new_ctrl) {
> +		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Cannot set up more than one pseudo-locked region in a cache
> +	 * hierarchy.
> +	 */
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> +	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
> +		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!cbm_validate(data->buf, &cbm_val, r))
> +		return -EINVAL;
> +
> +	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> +	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
> +	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
> +		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The CBM may not overlap with the CBM of another closid if
> +	 * either is exclusive.
> +	 */
> +	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
> +		rdt_last_cmd_puts("Overlaps with exclusive group\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
> +		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> +		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +			rdt_last_cmd_puts("Overlaps with other group\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	cfg->new_ctrl = cbm_val;
> +	cfg->have_new_ctrl = true;
> +
> +	return 0;
> +}
> +
> +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
> +{
> +	if (res->fflags & RFTYPE_RES_CACHE)
> +		return &parse_cbm;
> +	else
> +		return &parse_bw;
> +}
> +
> +/*
> + * For each domain in this resource we expect to find a series of:
> + *	id=mask
> + * separated by ";". The "id" is in decimal, and must match one of
> + * the "id"s for this resource.
> + */
> +static int parse_line(char *line, struct resctrl_schema *s,
> +		      struct rdtgroup *rdtgrp)
> +{
> +	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);
> +	enum resctrl_conf_type t = s->conf_type;
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_resource *r = s->res;
> +	struct rdt_parse_data data;
> +	char *dom = NULL, *id;
> +	struct rdt_domain *d;
> +	unsigned long dom_id;
> +
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
> +	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
> +		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	if (!line || line[0] == '\0')
> +		return 0;
> +	dom = strsep(&line, ";");
> +	id = strsep(&dom, "=");
> +	if (!dom || kstrtoul(id, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
> +		return -EINVAL;
> +	}
> +	dom = strim(dom);
> +	list_for_each_entry(d, &r->domains, list) {
> +		if (d->id == dom_id) {
> +			data.buf = dom;
> +			data.rdtgrp = rdtgrp;
> +			if (parse_ctrlval(&data, s, d))
> +				return -EINVAL;
> +			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
> +				cfg = &d->staged_config[t];
> +				/*
> +				 * In pseudo-locking setup mode and just
> +				 * parsed a valid CBM that should be
> +				 * pseudo-locked. Only one locked region per
> +				 * resource group and domain so just do
> +				 * the required initialization for single
> +				 * region and return.
> +				 */
> +				rdtgrp->plr->s = s;
> +				rdtgrp->plr->d = d;
> +				rdtgrp->plr->cbm = cfg->new_ctrl;
> +				d->plr = rdtgrp->plr;
> +				return 0;
> +			}
> +			goto next;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int rdtgroup_parse_resource(char *resname, char *tok,
> +				   struct rdtgroup *rdtgrp)
> +{
> +	struct resctrl_schema *s;
> +
> +	list_for_each_entry(s, &resctrl_schema_all, list) {
> +		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
> +			return parse_line(tok, s, rdtgrp);
> +	}
> +	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
> +	return -EINVAL;
> +}
> +
> +ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
> +				char *buf, size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *r;
> +	char *tok, *resname;
> +	int ret = 0;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +	buf[nbytes - 1] = '\0';
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		rdtgroup_kn_unlock(of->kn);
> +		return -ENOENT;
> +	}
> +	rdt_last_cmd_clear();
> +
> +	/*
> +	 * No changes to pseudo-locked region allowed. It has to be removed
> +	 * and re-created instead.
> +	 */
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
> +		goto out;
> +	}
> +
> +	rdt_staged_configs_clear();
> +
> +	while ((tok = strsep(&buf, "\n")) != NULL) {
> +		resname = strim(strsep(&tok, ":"));
> +		if (!tok) {
> +			rdt_last_cmd_puts("Missing ':'\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		if (tok[0] == '\0') {
> +			rdt_last_cmd_printf("Missing '%s' value\n", resname);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		ret = rdtgroup_parse_resource(resname, tok, rdtgrp);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	list_for_each_entry(s, &resctrl_schema_all, list) {
> +		r = s->res;
> +
> +		/*
> +		 * Writes to mba_sc resources update the software controller,
> +		 * not the control MSR.
> +		 */
> +		if (is_mba_sc(r))
> +			continue;
> +
> +		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +		/*
> +		 * If pseudo-locking fails we keep the resource group in
> +		 * mode RDT_MODE_PSEUDO_LOCKSETUP with its class of service
> +		 * active and updated for just the domain the pseudo-locked
> +		 * region was requested for.
> +		 */
> +		ret = rdtgroup_pseudo_lock_create(rdtgrp);
> +	}
> +
> +out:
> +	rdt_staged_configs_clear();
> +	rdtgroup_kn_unlock(of->kn);
> +	return ret ?: nbytes;
> +}
> +
> +static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
> +{
> +	struct rdt_resource *r = schema->res;
> +	struct rdt_domain *dom;
> +	bool sep = false;
> +	u32 ctrl_val;
> +
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +	seq_printf(s, "%*s:", max_name_width, schema->name);
> +	list_for_each_entry(dom, &r->domains, list) {
> +		if (sep)
> +			seq_puts(s, ";");
> +
> +		if (is_mba_sc(r))
> +			ctrl_val = dom->mbps_val[closid];
> +		else
> +			ctrl_val = resctrl_arch_get_config(r, dom, closid,
> +							   schema->conf_type);
> +
> +		seq_printf(s, r->format_str, dom->id, max_data_width,
> +			   ctrl_val);
> +		sep = true;
> +	}
> +	seq_puts(s, "\n");
> +}
> +
> +int rdtgroup_schemata_show(struct kernfs_open_file *of,
> +			   struct seq_file *s, void *v)
> +{
> +	struct resctrl_schema *schema;
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +	u32 closid;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp) {
> +		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +			list_for_each_entry(schema, &resctrl_schema_all, list) {
> +				seq_printf(s, "%s:uninitialized\n", schema->name);
> +			}
> +		} else if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> +			if (!rdtgrp->plr->d) {
> +				rdt_last_cmd_clear();
> +				rdt_last_cmd_puts("Cache domain offline\n");
> +				ret = -ENODEV;
> +			} else {
> +				seq_printf(s, "%s:%d=%x\n",
> +					   rdtgrp->plr->s->res->name,
> +					   rdtgrp->plr->d->id,
> +					   rdtgrp->plr->cbm);
> +			}
> +		} else {
> +			closid = rdtgrp->closid;
> +			list_for_each_entry(schema, &resctrl_schema_all, list) {
> +				if (closid < schema->num_closid)
> +					show_doms(s, schema, closid);
> +			}
> +		}
> +	} else {
> +		ret = -ENOENT;
> +	}
> +	rdtgroup_kn_unlock(of->kn);
> +	return ret;
> +}
> +
> +static int smp_mon_event_count(void *arg)
> +{
> +	mon_event_count(arg);
> +
> +	return 0;
> +}
> +
> +void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> +		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
> +		    int evtid, int first)
> +{
> +	int cpu;
> +
> +	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +	/*
> +	 * Setup the parameters to pass to mon_event_count() to read the data.
> +	 */
> +	rr->rgrp = rdtgrp;
> +	rr->evtid = evtid;
> +	rr->r = r;
> +	rr->d = d;
> +	rr->val = 0;
> +	rr->first = first;
> +	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
> +	if (IS_ERR(rr->arch_mon_ctx)) {
> +		rr->err = -EINVAL;
> +		return;
> +	}
> +
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask, RESCTRL_PICK_ANY_CPU);
> +
> +	/*
> +	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
> +	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
> +	 * MPAM's resctrl_arch_rmid_read() is unable to read the
> +	 * counters on some platforms if its called in IRQ context.
> +	 */
> +	if (tick_nohz_full_cpu(cpu))
> +		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
> +	else
> +		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> +
> +	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
> +}
> +
> +int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> +{
> +	struct kernfs_open_file *of = m->private;
> +	u32 resid, evtid, domid;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *r;
> +	union mon_data_bits md;
> +	struct rdt_domain *d;
> +	struct rmid_read rr;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	md.priv = of->kn->priv;
> +	resid = md.u.rid;
> +	domid = md.u.domid;
> +	evtid = md.u.evtid;
> +
> +	r = resctrl_arch_get_resource(resid);
> +	d = resctrl_arch_find_domain(r, domid);
> +	if (IS_ERR_OR_NULL(d)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
> +
> +	if (rr.err == -EIO)
> +		seq_puts(m, "Error\n");
> +	else if (rr.err == -EINVAL)
> +		seq_puts(m, "Unavailable\n");
> +	else
> +		seq_printf(m, "%llu\n", rr.val);
> +
> +out:
> +	rdtgroup_kn_unlock(of->kn);
> +	return ret;
> +}
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index e69de29bb2d1..f73267762a87 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -0,0 +1,340 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _FS_RESCTRL_INTERNAL_H
> +#define _FS_RESCTRL_INTERNAL_H
> +
> +#include <linux/resctrl.h>
> +#include <linux/sched.h>
> +#include <linux/kernfs.h>
> +#include <linux/fs_context.h>
> +#include <linux/jump_label.h>
> +#include <linux/tick.h>
> +
> +#include <asm/resctrl.h>
> +
> +/**
> + * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
> + *			        aren't marked nohz_full
> + * @mask:	The mask to pick a CPU from.
> + * @exclude_cpu:The CPU to avoid picking.
> + *
> + * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
> + * CPUs that don't use nohz_full, these are preferred. Pass
> + * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
> + *
> + * When a CPU is excluded, returns >= nr_cpu_ids if no CPUs are available.
> + */
> +static inline unsigned int
> +cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
> +{
> +	unsigned int cpu, hk_cpu;
> +
> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> +		cpu = cpumask_any(mask);
> +	else
> +		cpu = cpumask_any_but(mask, exclude_cpu);
> +
> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> +		return cpu;
> +
> +	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */
> +	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
> +		return cpu;
> +
> +	/* Try to find a CPU that isn't nohz_full to use in preference */
> +	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +	if (hk_cpu == exclude_cpu)
> +		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
> +
> +	if (hk_cpu < nr_cpu_ids)
> +		cpu = hk_cpu;
> +
> +	return cpu;
> +}
> +
> +struct rdt_fs_context {
> +	struct kernfs_fs_context	kfc;
> +	bool				enable_cdpl2;
> +	bool				enable_cdpl3;
> +	bool				enable_mba_mbps;
> +	bool				enable_debug;
> +};
> +
> +static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
> +{
> +	struct kernfs_fs_context *kfc = fc->fs_private;
> +
> +	return container_of(kfc, struct rdt_fs_context, kfc);
> +}
> +
> +/**
> + * struct mon_evt - Entry in the event list of a resource
> + * @evtid:		event id
> + * @name:		name of the event
> + * @configurable:	true if the event is configurable
> + * @list:		entry in &rdt_resource->evt_list
> + */
> +struct mon_evt {
> +	enum resctrl_event_id	evtid;
> +	char			*name;
> +	bool			configurable;
> +	struct list_head	list;
> +};
> +
> +/**
> + * union mon_data_bits - Monitoring details for each event file
> + * @priv:              Used to store monitoring event data in @u
> + *                     as kernfs private data
> + * @rid:               Resource id associated with the event file
> + * @evtid:             Event id associated with the event file
> + * @domid:             The domain to which the event file belongs
> + * @u:                 Name of the bit fields struct
> + */
> +union mon_data_bits {
> +	void *priv;
> +	struct {
> +		unsigned int rid		: 10;
> +		enum resctrl_event_id evtid	: 8;
> +		unsigned int domid		: 14;
> +	} u;
> +};
> +
> +struct rmid_read {
> +	struct rdtgroup		*rgrp;
> +	struct rdt_resource	*r;
> +	struct rdt_domain	*d;
> +	enum resctrl_event_id	evtid;
> +	bool			first;
> +	int			err;
> +	u64			val;
> +	void			*arch_mon_ctx;
> +};
> +
> +extern struct list_head resctrl_schema_all;
> +extern bool resctrl_mounted;
> +
> +enum rdt_group_type {
> +	RDTCTRL_GROUP = 0,
> +	RDTMON_GROUP,
> +	RDT_NUM_GROUP,
> +};
> +
> +/**
> + * enum rdtgrp_mode - Mode of a RDT resource group
> + * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
> + * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
> + * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
> + * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
> + *                          allowed AND the allocations are Cache Pseudo-Locked
> + * @RDT_NUM_MODES: Total number of modes
> + *
> + * The mode of a resource group enables control over the allowed overlap
> + * between allocations associated with different resource groups (classes
> + * of service). User is able to modify the mode of a resource group by
> + * writing to the "mode" resctrl file associated with the resource group.
> + *
> + * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
> + * writing the appropriate text to the "mode" file. A resource group enters
> + * "pseudo-locked" mode after the schemata is written while the resource
> + * group is in "pseudo-locksetup" mode.
> + */
> +enum rdtgrp_mode {
> +	RDT_MODE_SHAREABLE = 0,
> +	RDT_MODE_EXCLUSIVE,
> +	RDT_MODE_PSEUDO_LOCKSETUP,
> +	RDT_MODE_PSEUDO_LOCKED,
> +
> +	/* Must be last */
> +	RDT_NUM_MODES,
> +};
> +
> +/**
> + * struct mongroup - store mon group's data in resctrl fs.
> + * @mon_data_kn:		kernfs node for the mon_data directory
> + * @parent:			parent rdtgrp
> + * @crdtgrp_list:		child rdtgroup node list
> + * @rmid:			rmid for this rdtgroup
> + */
> +struct mongroup {
> +	struct kernfs_node	*mon_data_kn;
> +	struct rdtgroup		*parent;
> +	struct list_head	crdtgrp_list;
> +	u32			rmid;
> +};
> +
> +/**
> + * struct rdtgroup - store rdtgroup's data in resctrl file system.
> + * @kn:				kernfs node
> + * @rdtgroup_list:		linked list for all rdtgroups
> + * @closid:			closid for this rdtgroup
> + * @cpu_mask:			CPUs assigned to this rdtgroup
> + * @flags:			status bits
> + * @waitcount:			how many cpus expect to find this
> + *				group when they acquire rdtgroup_mutex
> + * @type:			indicates type of this rdtgroup - either
> + *				monitor only or ctrl_mon group
> + * @mon:			mongroup related data
> + * @mode:			mode of resource group
> + * @plr:			pseudo-locked region
> + */
> +struct rdtgroup {
> +	struct kernfs_node		*kn;
> +	struct list_head		rdtgroup_list;
> +	u32				closid;
> +	struct cpumask			cpu_mask;
> +	int				flags;
> +	atomic_t			waitcount;
> +	enum rdt_group_type		type;
> +	struct mongroup			mon;
> +	enum rdtgrp_mode		mode;
> +	struct pseudo_lock_region	*plr;
> +};
> +
> +/* List of all resource groups */
> +extern struct list_head rdt_all_groups;
> +
> +extern int max_name_width, max_data_width;
> +
> +/**
> + * struct rftype - describe each file in the resctrl file system
> + * @name:	File name
> + * @mode:	Access mode
> + * @kf_ops:	File operations
> + * @flags:	File specific RFTYPE_FLAGS_* flags
> + * @fflags:	File specific RFTYPE_* flags
> + * @seq_show:	Show content of the file
> + * @write:	Write to the file
> + */
> +struct rftype {
> +	char			*name;
> +	umode_t			mode;
> +	const struct kernfs_ops	*kf_ops;
> +	unsigned long		flags;
> +	unsigned long		fflags;
> +
> +	int (*seq_show)(struct kernfs_open_file *of,
> +			struct seq_file *sf, void *v);
> +	/*
> +	 * write() is the generic write callback which maps directly to
> +	 * kernfs write operation and overrides all other operations.
> +	 * Maximum write size is determined by ->max_write_len.
> +	 */
> +	ssize_t (*write)(struct kernfs_open_file *of,
> +			 char *buf, size_t nbytes, loff_t off);
> +};
> +
> +/**
> + * struct mbm_state - status for each MBM counter in each domain
> + * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
> + * @prev_bw:	The most recent bandwidth in MBps
> + */
> +struct mbm_state {
> +	u64	prev_bw_bytes;
> +	u32	prev_bw;
> +};
> +
> +static inline  bool is_mba_sc(struct rdt_resource *r)
> +{
> +	if (!r)
> +		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> +
> +	/*
> +	 * The software controller support is only applicable to MBA resource.
> +	 * Make sure to check for resource type.
> +	 */
> +	if (r->rid != RDT_RESOURCE_MBA)
> +		return false;
> +
> +	return r->membw.mba_sc;
> +}
> +
> +extern struct mutex rdtgroup_mutex;
> +extern struct rdtgroup rdtgroup_default;
> +extern struct dentry *debugfs_resctrl;
> +
> +void rdt_last_cmd_clear(void);
> +void rdt_last_cmd_puts(const char *s);
> +__printf(1, 2)
> +void rdt_last_cmd_printf(const char *fmt, ...);
> +
> +struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
> +void rdtgroup_kn_unlock(struct kernfs_node *kn);
> +int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
> +int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
> +			     umode_t mask);
> +ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
> +				char *buf, size_t nbytes, loff_t off);
> +int rdtgroup_schemata_show(struct kernfs_open_file *of,
> +			   struct seq_file *s, void *v);
> +bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
> +			   unsigned long cbm, int closid, bool exclusive);
> +unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
> +				  unsigned long cbm);
> +enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
> +int rdtgroup_tasks_assigned(struct rdtgroup *r);
> +int closids_supported(void);
> +void closid_free(int closid);
> +int alloc_rmid(u32 closid);
> +void free_rmid(u32 closid, u32 rmid);
> +void resctrl_mon_resource_exit(void);
> +void mon_event_count(void *info);
> +int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> +void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> +		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
> +		    int evtid, int first);
> +int resctrl_mon_resource_init(void);
> +void mbm_setup_overflow_handler(struct rdt_domain *dom,
> +				unsigned long delay_ms,
> +				int exclude_cpu);
> +void mbm_handle_overflow(struct work_struct *work);
> +bool is_mba_sc(struct rdt_resource *r);
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu);
> +void cqm_handle_limbo(struct work_struct *work);
> +bool has_busy_rmid(struct rdt_domain *d);
> +void __check_limbo(struct rdt_domain *d, bool force_free);
> +void mbm_config_rftype_init(const char *config);
> +void rdt_staged_configs_clear(void);
> +bool closid_allocated(unsigned int closid);
> +int resctrl_find_cleanest_closid(void);
> +
> +#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
> +int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> +int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
> +bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm);
> +bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
> +int rdt_pseudo_lock_init(void);
> +void rdt_pseudo_lock_release(void);
> +int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
> +void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
> +#else
> +static inline int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
> +{
> +	return false;
> +}
> +
> +static inline bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
> +{
> +	return false;
> +}
> +
> +static inline int rdt_pseudo_lock_init(void) { return 0; }
> +static inline void rdt_pseudo_lock_release(void) { }
> +static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
> +#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
> +
> +#endif /* _FS_RESCTRL_INTERNAL_H */
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index e69de29bb2d1..06f660dfd929 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -0,0 +1,843 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Resource Director Technology(RDT)
> + * - Monitoring code
> + *
> + * Copyright (C) 2017 Intel Corporation
> + *
> + * Author:
> + *    Vikas Shivappa <vikas.shivappa@intel.com>
> + *
> + * This replaces the cqm.c based on perf but we reuse a lot of
> + * code and datastructures originally from Peter Zijlstra and Matt Fleming.
> + *
> + * More information about RDT be found in the Intel (R) x86 Architecture
> + * Software Developer Manual June 2016, volume 3, section 17.17.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/module.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include "internal.h"
> +
> +/*
> + * struct rmid_entry - dirty tracking for all RMID.
> + * @closid:	The CLOSID for this entry.
> + * @rmid:	The RMID for this entry.
> + * @busy:	The number of domains with cached data using this RMID.
> + * @list:	Member of the rmid_free_lru list when busy == 0.
> + *
> + * Depending on the architecture the correct monitor is accessed using
> + * both @closid and @rmid, or @rmid only.
> + *
> + * Take the rdtgroup_mutex when accessing.
> + */
> +struct rmid_entry {
> +	u32				closid;
> +	u32				rmid;
> +	int				busy;
> +	struct list_head		list;
> +};
> +
> +/*
> + * @rmid_free_lru - A least recently used list of free RMIDs
> + *     These RMIDs are guaranteed to have an occupancy less than the
> + *     threshold occupancy
> + */
> +static LIST_HEAD(rmid_free_lru);
> +
> +/*
> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
> + *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
> + *     Indexed by CLOSID. Protected by rdtgroup_mutex.
> + */
> +static u32 *closid_num_dirty_rmid;
> +
> +/*
> + * @rmid_limbo_count - count of currently unused but (potentially)
> + *     dirty RMIDs.
> + *     This counts RMIDs that no one is currently using but that
> + *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
> + *     change the threshold occupancy value.
> + */
> +static unsigned int rmid_limbo_count;
> +
> +/*
> + * @rmid_entry - The entry in the limbo and free lists.
> + */
> +static struct rmid_entry	*rmid_ptrs;
> +
> +/*
> + * This is the threshold cache occupancy in bytes at which we will consider an
> + * RMID available for re-allocation.
> + */
> +unsigned int resctrl_rmid_realloc_threshold;
> +
> +/*
> + * This is the maximum value for the reallocation threshold, in bytes.
> + */
> +unsigned int resctrl_rmid_realloc_limit;
> +
> +/*
> + * x86 and arm64 differ in their handling of monitoring.
> + * x86's RMID are independent numbers, there is only one source of traffic
> + * with an RMID value of '1'.
> + * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
> + * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
> + * value is no longer unique.
> + * To account for this, resctrl uses an index. On x86 this is just the RMID,
> + * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
> + *
> + * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch code
> + * must accept an attempt to read every index.
> + */
> +static inline struct rmid_entry *__rmid_entry(u32 idx)
> +{
> +	struct rmid_entry *entry;
> +	u32 closid, rmid;
> +
> +	entry = &rmid_ptrs[idx];
> +	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
> +
> +	WARN_ON_ONCE(entry->closid != closid);
> +	WARN_ON_ONCE(entry->rmid != rmid);
> +
> +	return entry;
> +}
> +
> +static void limbo_release_entry(struct rmid_entry *entry)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	rmid_limbo_count--;
> +	list_add_tail(&entry->list, &rmid_free_lru);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]--;
> +}
> +
> +/*
> + * Check the RMIDs that are marked as busy for this domain. If the
> + * reported LLC occupancy is below the threshold clear the busy bit and
> + * decrement the count. If the busy count gets to zero on an RMID, we
> + * free the RMID
> + */
> +void __check_limbo(struct rdt_domain *d, bool force_free)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	struct rmid_entry *entry;
> +	u32 idx, cur_idx = 1;
> +	void *arch_mon_ctx;
> +	bool rmid_dirty;
> +	u64 val = 0;
> +
> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> +	if (IS_ERR(arch_mon_ctx)) {
> +		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +				    PTR_ERR(arch_mon_ctx));
> +		return;
> +	}
> +
> +	/*
> +	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
> +	 * are marked as busy for occupancy < threshold. If the occupancy
> +	 * is less than the threshold decrement the busy counter of the
> +	 * RMID and move it to the free list when the counter reaches 0.
> +	 */
> +	for (;;) {
> +		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> +		if (idx >= idx_limit)
> +			break;
> +
> +		entry = __rmid_entry(idx);
> +		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> +					   QOS_L3_OCCUP_EVENT_ID, &val,
> +					   arch_mon_ctx)) {
> +			rmid_dirty = true;
> +		} else {
> +			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
> +		}
> +
> +		if (force_free || !rmid_dirty) {
> +			clear_bit(idx, d->rmid_busy_llc);
> +			if (!--entry->busy)
> +				limbo_release_entry(entry);
> +		}
> +		cur_idx = idx + 1;
> +	}
> +
> +	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
> +}
> +
> +bool has_busy_rmid(struct rdt_domain *d)
> +{
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +
> +	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
> +}
> +
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
> +{
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
> +
> +	if (list_empty(&rmid_free_lru))
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
> +
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * Get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.
> +		 * If the CLOSID is irrelevant on this architecture, the two
> +		 * index values are always the same on every entry and thus the
> +		 * very first entry will be returned.
> +		 */
> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
> +
> +		if (itr_idx == cmp_idx)
> +			return itr;
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +/**
> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> + *                                  RMID are clean, or the CLOSID that has
> + *                                  the most clean RMID.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * choose the CLOSID with the most clean RMID.
> + *
> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> + * be returned.
> + */
> +int resctrl_find_cleanest_closid(void)
> +{
> +	u32 cleanest_closid = ~0;
> +	int i = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return -EIO;
> +
> +	for (i = 0; i < closids_supported(); i++) {
> +		int num_dirty;
> +
> +		if (closid_allocated(i))
> +			continue;
> +
> +		num_dirty = closid_num_dirty_rmid[i];
> +		if (num_dirty == 0)
> +			return i;
> +
> +		if (cleanest_closid == ~0)
> +			cleanest_closid = i;
> +
> +		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
> +			cleanest_closid = i;
> +	}
> +
> +	if (cleanest_closid == ~0)
> +		return -ENOSPC;
> +
> +	return cleanest_closid;
> +}
> +
> +/*
> + * For MPAM the RMID value is not unique, and has to be considered with
> + * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> + * allows all domains to be managed by a single free list.
> + * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
> + */
> +int alloc_rmid(u32 closid)
> +{
> +	struct rmid_entry *entry;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	entry = resctrl_find_free_rmid(closid);
> +	if (IS_ERR(entry))
> +		return PTR_ERR(entry);
> +
> +	list_del(&entry->list);
> +	return entry->rmid;
> +}
> +
> +static void add_rmid_to_limbo(struct rmid_entry *entry)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct rdt_domain *d;
> +	u32 idx;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
> +
> +	entry->busy = 0;
> +	list_for_each_entry(d, &r->domains, list) {
> +		/*
> +		 * For the first limbo RMID in the domain,
> +		 * setup up the limbo worker.
> +		 */
> +		if (!has_busy_rmid(d))
> +			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
> +						RESCTRL_PICK_ANY_CPU);
> +		set_bit(idx, d->rmid_busy_llc);
> +		entry->busy++;
> +	}
> +
> +	rmid_limbo_count++;
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]++;
> +}
> +
> +void free_rmid(u32 closid, u32 rmid)
> +{
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> +	struct rmid_entry *entry;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	/*
> +	 * Do not allow the default rmid to be free'd. Comparing by index
> +	 * allows architectures that ignore the closid parameter to avoid an
> +	 * unnecessary check.
> +	 */
> +	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> +						RESCTRL_RESERVED_RMID))
> +		return;
> +
> +	entry = __rmid_entry(idx);
> +
> +	if (resctrl_arch_is_llc_occupancy_enabled())
> +		add_rmid_to_limbo(entry);
> +	else
> +		list_add_tail(&entry->list, &rmid_free_lru);
> +}
> +
> +static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
> +				       u32 rmid, enum resctrl_event_id evtid)
> +{
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> +
> +	switch (evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return &d->mbm_total[idx];
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return &d->mbm_local[idx];
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
> +{
> +	struct mbm_state *m;
> +	u64 tval = 0;
> +
> +	if (rr->first) {
> +		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
> +		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
> +		if (m)
> +			memset(m, 0, sizeof(struct mbm_state));
> +		return 0;
> +	}
> +
> +	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
> +					 &tval, rr->arch_mon_ctx);
> +	if (rr->err)
> +		return rr->err;
> +
> +	rr->val += tval;
> +
> +	return 0;
> +}
> +
> +/*
> + * mbm_bw_count() - Update bw count from values previously read by
> + *		    __mon_event_count().
> + * @closid:	The closid used to identify the cached mbm_state.
> + * @rmid:	The rmid used to identify the cached mbm_state.
> + * @rr:		The struct rmid_read populated by __mon_event_count().
> + *
> + * Supporting function to calculate the memory bandwidth
> + * and delta bandwidth in MBps. The chunks value previously read by
> + * __mon_event_count() is compared with the chunks value from the previous
> + * invocation. This must be called once per second to maintain values in MBps.
> + */
> +static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
> +{
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> +	struct mbm_state *m = &rr->d->mbm_local[idx];
> +	u64 cur_bw, bytes, cur_bytes;
> +
> +	cur_bytes = rr->val;
> +	bytes = cur_bytes - m->prev_bw_bytes;
> +	m->prev_bw_bytes = cur_bytes;
> +
> +	cur_bw = bytes / SZ_1M;
> +
> +	m->prev_bw = cur_bw;
> +}
> +
> +/*
> + * This is scheduled by mon_event_read() to read the CQM/MBM counters
> + * on a domain.
> + */
> +void mon_event_count(void *info)
> +{
> +	struct rdtgroup *rdtgrp, *entry;
> +	struct rmid_read *rr = info;
> +	struct list_head *head;
> +	int ret;
> +
> +	rdtgrp = rr->rgrp;
> +
> +	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
> +
> +	/*
> +	 * For Ctrl groups read data from child monitor groups and
> +	 * add them together. Count events which are read successfully.
> +	 * Discard the rmid_read's reporting errors.
> +	 */
> +	head = &rdtgrp->mon.crdtgrp_list;
> +
> +	if (rdtgrp->type == RDTCTRL_GROUP) {
> +		list_for_each_entry(entry, head, mon.crdtgrp_list) {
> +			if (__mon_event_count(entry->closid, entry->mon.rmid,
> +					      rr) == 0)
> +				ret = 0;
> +		}
> +	}
> +
> +	/*
> +	 * __mon_event_count() calls for newly created monitor groups may
> +	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
> +	 * Discard error if any of the monitor event reads succeeded.
> +	 */
> +	if (ret == 0)
> +		rr->err = 0;
> +}
> +
> +/*
> + * Feedback loop for MBA software controller (mba_sc)
> + *
> + * mba_sc is a feedback loop where we periodically read MBM counters and
> + * adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs so
> + * that:
> + *
> + *   current bandwidth(cur_bw) < user specified bandwidth(user_bw)
> + *
> + * This uses the MBM counters to measure the bandwidth and MBA throttle
> + * MSRs to control the bandwidth for a particular rdtgrp. It builds on the
> + * fact that resctrl rdtgroups have both monitoring and control.
> + *
> + * The frequency of the checks is 1s and we just tag along the MBM overflow
> + * timer. Having 1s interval makes the calculation of bandwidth simpler.
> + *
> + * Although MBA's goal is to restrict the bandwidth to a maximum, there may
> + * be a need to increase the bandwidth to avoid unnecessarily restricting
> + * the L2 <-> L3 traffic.
> + *
> + * Since MBA controls the L2 external bandwidth where as MBM measures the
> + * L3 external bandwidth the following sequence could lead to such a
> + * situation.
> + *
> + * Consider an rdtgroup which had high L3 <-> memory traffic in initial
> + * phases -> mba_sc kicks in and reduced bandwidth percentage values -> but
> + * after some time rdtgroup has mostly L2 <-> L3 traffic.
> + *
> + * In this case we may restrict the rdtgroup's L2 <-> L3 traffic as its
> + * throttle MSRs already have low percentage values.  To avoid
> + * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
> + */
> +static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
> +{
> +	u32 closid, rmid, cur_msr_val, new_msr_val;
> +	struct mbm_state *pmbm_data, *cmbm_data;
> +	struct rdt_resource *r_mba;
> +	struct rdt_domain *dom_mba;
> +	u32 cur_bw, user_bw, idx;
> +	struct list_head *head;
> +	struct rdtgroup *entry;
> +
> +	if (!resctrl_arch_is_mbm_local_enabled())
> +		return;
> +
> +	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> +
> +	closid = rgrp->closid;
> +	rmid = rgrp->mon.rmid;
> +	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
> +	pmbm_data = &dom_mbm->mbm_local[idx];
> +
> +	dom_mba = resctrl_get_domain_from_cpu(smp_processor_id(), r_mba);
> +	if (!dom_mba) {
> +		pr_warn_once("Failure to get domain for MBA update\n");
> +		return;
> +	}
> +
> +	cur_bw = pmbm_data->prev_bw;
> +	user_bw = dom_mba->mbps_val[closid];
> +
> +	/* MBA resource doesn't support CDP */
> +	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
> +
> +	/*
> +	 * For Ctrl groups read data from child monitor groups.
> +	 */
> +	head = &rgrp->mon.crdtgrp_list;
> +	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> +		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> +		cur_bw += cmbm_data->prev_bw;
> +	}
> +
> +	/*
> +	 * Scale up/down the bandwidth linearly for the ctrl group.  The
> +	 * bandwidth step is the bandwidth granularity specified by the
> +	 * hardware.
> +	 * Always increase throttling if current bandwidth is above the
> +	 * target set by user.
> +	 * But avoid thrashing up and down on every poll by checking
> +	 * whether a decrease in throttling is likely to push the group
> +	 * back over target. E.g. if currently throttling to 30% of bandwidth
> +	 * on a system with 10% granularity steps, check whether moving to
> +	 * 40% would go past the limit by multiplying current bandwidth by
> +	 * "(30 + 10) / 30".
> +	 */
> +	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
> +		new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
> +	} else if (cur_msr_val < MAX_MBA_BW &&
> +		   (user_bw > (cur_bw * (cur_msr_val + r_mba->membw.min_bw) / cur_msr_val))) {
> +		new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
> +	} else {
> +		return;
> +	}
> +
> +	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
> +}
> +
> +static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
> +		       u32 closid, u32 rmid)
> +{
> +	struct rmid_read rr;
> +
> +	rr.first = false;
> +	rr.r = r;
> +	rr.d = d;
> +
> +	/*
> +	 * This is protected from concurrent reads from user
> +	 * as both the user and we hold the global mutex.
> +	 */
> +	if (resctrl_arch_is_mbm_total_enabled()) {
> +		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
> +		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx)) {
> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +					    PTR_ERR(rr.arch_mon_ctx));
> +			return;
> +		}
> +
> +		__mon_event_count(closid, rmid, &rr);
> +
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
> +	}
> +	if (resctrl_arch_is_mbm_local_enabled()) {
> +		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
> +		rr.val = 0;
> +		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (IS_ERR(rr.arch_mon_ctx)) {
> +			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
> +					    PTR_ERR(rr.arch_mon_ctx));
> +			return;
> +		}
> +
> +		__mon_event_count(closid, rmid, &rr);
> +
> +		/*
> +		 * Call the MBA software controller only for the
> +		 * control groups and when user has enabled
> +		 * the software controller explicitly.
> +		 */
> +		if (is_mba_sc(NULL))
> +			mbm_bw_count(closid, rmid, &rr);
> +
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
> +	}
> +}
> +
> +/*
> + * Handler to scan the limbo list and move the RMIDs
> + * to free list whose occupancy < threshold_occupancy.
> + */
> +void cqm_handle_limbo(struct work_struct *work)
> +{
> +	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
> +	struct rdt_domain *d;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	d = container_of(work, struct rdt_domain, cqm_limbo.work);
> +
> +	__check_limbo(d, false);
> +
> +	if (has_busy_rmid(d)) {
> +		d->cqm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
> +							   RESCTRL_PICK_ANY_CPU);
> +		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
> +					 delay);
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +}
> +
> +/**
> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
> + *                             domain.
> + * @dom:           The domain the limbo handler should run for.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on,
> + *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> + */
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu)
> +{
> +	unsigned long delay = msecs_to_jiffies(delay_ms);
> +	int cpu;
> +
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
> +	dom->cqm_work_cpu = cpu;
> +
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> +}
> +
> +void mbm_handle_overflow(struct work_struct *work)
> +{
> +	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
> +	struct rdtgroup *prgrp, *crgrp;
> +	struct list_head *head;
> +	struct rdt_resource *r;
> +	struct rdt_domain *d;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	/*
> +	 * If the filesystem has been unmounted this work no longer needs to
> +	 * run.
> +	 */
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
> +		goto out_unlock;
> +
> +	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	d = container_of(work, struct rdt_domain, mbm_over.work);
> +
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
> +
> +		head = &prgrp->mon.crdtgrp_list;
> +		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> +			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
> +
> +		if (is_mba_sc(NULL))
> +			update_mba_bw(prgrp, d);
> +	}
> +
> +	/*
> +	 * Re-check for housekeeping CPUs. This allows the overflow handler to
> +	 * move off a nohz_full CPU quickly.
> +	 */
> +	d->mbm_work_cpu = cpumask_any_housekeeping(&d->cpu_mask,
> +						   RESCTRL_PICK_ANY_CPU);
> +	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +}
> +
> +/**
> + * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
> + *                                domain.
> + * @dom:           The domain the overflow handler should run for.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on,
> + *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
> + */
> +void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +				int exclude_cpu)
> +{
> +	unsigned long delay = msecs_to_jiffies(delay_ms);
> +	int cpu;
> +
> +	/*
> +	 * When a domain comes online there is no guarantee the filesystem is
> +	 * mounted. If not, there is no need to catch counter overflow.
> +	 */
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
> +		return;
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask, exclude_cpu);
> +	dom->mbm_work_cpu = cpu;
> +
> +	if (cpu < nr_cpu_ids)
> +		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
> +}
> +
> +static int dom_data_init(struct rdt_resource *r)
> +{
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	struct rmid_entry *entry = NULL;
> +	int err = 0, i;
> +	u32 idx;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		u32 *tmp;
> +
> +		/*
> +		 * If the architecture hasn't provided a sanitised value here,
> +		 * this may result in larger arrays than necessary. Resctrl will
> +		 * use a smaller system wide value based on the resources in
> +		 * use.
> +		 */
> +		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
> +		if (!tmp) {
> +			err = -ENOMEM;
> +			goto out_unlock;
> +		}
> +
> +		closid_num_dirty_rmid = tmp;
> +	}
> +
> +	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
> +	if (!rmid_ptrs) {
> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +			kfree(closid_num_dirty_rmid);
> +			closid_num_dirty_rmid = NULL;
> +		}
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	for (i = 0; i < idx_limit; i++) {
> +		entry = &rmid_ptrs[i];
> +		INIT_LIST_HEAD(&entry->list);
> +
> +		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
> +		list_add_tail(&entry->list, &rmid_free_lru);
> +	}
> +
> +	/*
> +	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
> +	 * are always allocated. These are used for the rdtgroup_default
> +	 * control group, which will be setup later in rdtgroup_init().
> +	 */
> +	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> +					   RESCTRL_RESERVED_RMID);
> +	entry = __rmid_entry(idx);
> +	list_del(&entry->list);
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return err;
> +}
> +
> +static void dom_data_exit(struct rdt_resource *r)
> +{
> +	if (!r->mon_capable)
> +		return;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		kfree(closid_num_dirty_rmid);
> +		closid_num_dirty_rmid = NULL;
> +	}
> +
> +	kfree(rmid_ptrs);
> +	rmid_ptrs = NULL;
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
> +static struct mon_evt llc_occupancy_event = {
> +	.name		= "llc_occupancy",
> +	.evtid		= QOS_L3_OCCUP_EVENT_ID,
> +};
> +
> +static struct mon_evt mbm_total_event = {
> +	.name		= "mbm_total_bytes",
> +	.evtid		= QOS_L3_MBM_TOTAL_EVENT_ID,
> +};
> +
> +static struct mon_evt mbm_local_event = {
> +	.name		= "mbm_local_bytes",
> +	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
> +};
> +
> +/*
> + * Initialize the event list for the resource.
> + *
> + * Note that MBM events are also part of RDT_RESOURCE_L3 resource
> + * because as per the SDM the total and local memory bandwidth
> + * are enumerated as part of L3 monitoring.
> + */
> +static void l3_mon_evt_init(struct rdt_resource *r)
> +{
> +	INIT_LIST_HEAD(&r->evt_list);
> +
> +	if (resctrl_arch_is_llc_occupancy_enabled())
> +		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
> +	if (resctrl_arch_is_mbm_total_enabled())
> +		list_add_tail(&mbm_total_event.list, &r->evt_list);
> +	if (resctrl_arch_is_mbm_local_enabled())
> +		list_add_tail(&mbm_local_event.list, &r->evt_list);
> +}
> +
> +int resctrl_mon_resource_init(void)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	int ret;
> +
> +	if (!r->mon_capable)
> +		return 0;
> +
> +	ret = dom_data_init(r);
> +	if (ret)
> +		return ret;
> +
> +	l3_mon_evt_init(r);
> +
> +	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
> +		mbm_total_event.configurable = true;
> +		mbm_config_rftype_init("mbm_total_bytes_config");
> +	}
> +	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
> +		mbm_local_event.configurable = true;
> +		mbm_config_rftype_init("mbm_local_bytes_config");
> +	}
> +
> +	return 0;
> +}
> +
> +void resctrl_mon_resource_exit(void)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +
> +	dom_data_exit(r);
> +}
> diff --git a/fs/resctrl/psuedo_lock.c b/fs/resctrl/psuedo_lock.c
> index e69de29bb2d1..077c2abb6edd 100644
> --- a/fs/resctrl/psuedo_lock.c
> +++ b/fs/resctrl/psuedo_lock.c
> @@ -0,0 +1,1122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Resource Director Technology (RDT)
> + *
> + * Pseudo-locking support built on top of Cache Allocation Technology (CAT)
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Author: Reinette Chatre <reinette.chatre@intel.com>
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/debugfs.h>
> +#include <linux/kthread.h>
> +#include <linux/mman.h>
> +#include <linux/perf_event.h>
> +#include <linux/pm_qos.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/resctrl.h>
> +#include <asm/perf_event.h>
> +
> +#include "internal.h"
> +
> +/*
> + * Major number assigned to and shared by all devices exposing
> + * pseudo-locked regions.
> + */
> +static unsigned int pseudo_lock_major;
> +static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
> +
> +static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
> +{
> +	const struct rdtgroup *rdtgrp;
> +
> +	rdtgrp = dev_get_drvdata(dev);
> +	if (mode)
> +		*mode = 0600;
> +	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdtgrp->kn->name);
> +}
> +
> +static const struct class pseudo_lock_class = {
> +	.name = "pseudo_lock",
> +	.devnode = pseudo_lock_devnode,
> +};
> +
> +/**
> + * pseudo_lock_minor_get - Obtain available minor number
> + * @minor: Pointer to where new minor number will be stored
> + *
> + * A bitmask is used to track available minor numbers. Here the next free
> + * minor number is marked as unavailable and returned.
> + *
> + * Return: 0 on success, <0 on failure.
> + */
> +static int pseudo_lock_minor_get(unsigned int *minor)
> +{
> +	unsigned long first_bit;
> +
> +	first_bit = find_first_bit(&pseudo_lock_minor_avail, MINORBITS);
> +
> +	if (first_bit == MINORBITS)
> +		return -ENOSPC;
> +
> +	__clear_bit(first_bit, &pseudo_lock_minor_avail);
> +	*minor = first_bit;
> +
> +	return 0;
> +}
> +
> +/**
> + * pseudo_lock_minor_release - Return minor number to available
> + * @minor: The minor number made available
> + */
> +static void pseudo_lock_minor_release(unsigned int minor)
> +{
> +	__set_bit(minor, &pseudo_lock_minor_avail);
> +}
> +
> +/**
> + * region_find_by_minor - Locate a pseudo-lock region by inode minor number
> + * @minor: The minor number of the device representing pseudo-locked region
> + *
> + * When the character device is accessed we need to determine which
> + * pseudo-locked region it belongs to. This is done by matching the minor
> + * number of the device to the pseudo-locked region it belongs.
> + *
> + * Minor numbers are assigned at the time a pseudo-locked region is associated
> + * with a cache instance.
> + *
> + * Return: On success return pointer to resource group owning the pseudo-locked
> + *         region, NULL on failure.
> + */
> +static struct rdtgroup *region_find_by_minor(unsigned int minor)
> +{
> +	struct rdtgroup *rdtgrp, *rdtgrp_match = NULL;
> +
> +	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (rdtgrp->plr && rdtgrp->plr->minor == minor) {
> +			rdtgrp_match = rdtgrp;
> +			break;
> +		}
> +	}
> +	return rdtgrp_match;
> +}
> +
> +/**
> + * struct pseudo_lock_pm_req - A power management QoS request list entry
> + * @list:	Entry within the @pm_reqs list for a pseudo-locked region
> + * @req:	PM QoS request
> + */
> +struct pseudo_lock_pm_req {
> +	struct list_head list;
> +	struct dev_pm_qos_request req;
> +};
> +
> +static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
> +{
> +	struct pseudo_lock_pm_req *pm_req, *next;
> +
> +	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
> +		dev_pm_qos_remove_request(&pm_req->req);
> +		list_del(&pm_req->list);
> +		kfree(pm_req);
> +	}
> +}
> +
> +/**
> + * pseudo_lock_cstates_constrain - Restrict cores from entering C6
> + * @plr: Pseudo-locked region
> + *
> + * To prevent the cache from being affected by power management entering
> + * C6 has to be avoided. This is accomplished by requesting a latency
> + * requirement lower than lowest C6 exit latency of all supported
> + * platforms as found in the cpuidle state tables in the intel_idle driver.
> + * At this time it is possible to do so with a single latency requirement
> + * for all supported platforms.
> + *
> + * Since Goldmont is supported, which is affected by X86_BUG_MONITOR,
> + * the ACPI latencies need to be considered while keeping in mind that C2
> + * may be set to map to deeper sleep states. In this case the latency
> + * requirement needs to prevent entering C2 also.
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
> +{
> +	struct pseudo_lock_pm_req *pm_req;
> +	int cpu;
> +	int ret;
> +
> +	for_each_cpu(cpu, &plr->d->cpu_mask) {
> +		pm_req = kzalloc(sizeof(*pm_req), GFP_KERNEL);
> +		if (!pm_req) {
> +			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
> +			ret = -ENOMEM;
> +			goto out_err;
> +		}
> +		ret = dev_pm_qos_add_request(get_cpu_device(cpu),
> +					     &pm_req->req,
> +					     DEV_PM_QOS_RESUME_LATENCY,
> +					     30);
> +		if (ret < 0) {
> +			rdt_last_cmd_printf("Failed to add latency req CPU%d\n",
> +					    cpu);
> +			kfree(pm_req);
> +			ret = -1;
> +			goto out_err;
> +		}
> +		list_add(&pm_req->list, &plr->pm_reqs);
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	pseudo_lock_cstates_relax(plr);
> +	return ret;
> +}
> +
> +/**
> + * pseudo_lock_region_clear - Reset pseudo-lock region data
> + * @plr: pseudo-lock region
> + *
> + * All content of the pseudo-locked region is reset - any memory allocated
> + * freed.
> + *
> + * Return: void
> + */
> +static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
> +{
> +	plr->size = 0;
> +	plr->line_size = 0;
> +	kfree(plr->kmem);
> +	plr->kmem = NULL;
> +	plr->s = NULL;
> +	if (plr->d)
> +		plr->d->plr = NULL;
> +	plr->d = NULL;
> +	plr->cbm = 0;
> +	plr->debugfs_dir = NULL;
> +}
> +
> +/**
> + * pseudo_lock_region_init - Initialize pseudo-lock region information
> + * @plr: pseudo-lock region
> + *
> + * Called after user provided a schemata to be pseudo-locked. From the
> + * schemata the &struct pseudo_lock_region is on entry already initialized
> + * with the resource, domain, and capacity bitmask. Here the information
> + * required for pseudo-locking is deduced from this data and &struct
> + * pseudo_lock_region initialized further. This information includes:
> + * - size in bytes of the region to be pseudo-locked
> + * - cache line size to know the stride with which data needs to be accessed
> + *   to be pseudo-locked
> + * - a cpu associated with the cache instance on which the pseudo-locking
> + *   flow can be executed
> + *
> + * Return: 0 on success, <0 on failure. Descriptive error will be written
> + * to last_cmd_status buffer.
> + */
> +static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
> +{
> +	struct cpu_cacheinfo *ci;
> +	int ret;
> +	int i;
> +
> +	/* Pick the first cpu we find that is associated with the cache. */
> +	plr->cpu = cpumask_first(&plr->d->cpu_mask);
> +
> +	if (!cpu_online(plr->cpu)) {
> +		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
> +				    plr->cpu);
> +		ret = -ENODEV;
> +		goto out_region;
> +	}
> +
> +	ci = get_cpu_cacheinfo(plr->cpu);
> +
> +	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
> +
> +	for (i = 0; i < ci->num_leaves; i++) {
> +		if (ci->info_list[i].level == plr->s->res->cache_level) {
> +			plr->line_size = ci->info_list[i].coherency_line_size;
> +			return 0;
> +		}
> +	}
> +
> +	ret = -1;
> +	rdt_last_cmd_puts("Unable to determine cache line size\n");
> +out_region:
> +	pseudo_lock_region_clear(plr);
> +	return ret;
> +}
> +
> +/**
> + * pseudo_lock_init - Initialize a pseudo-lock region
> + * @rdtgrp: resource group to which new pseudo-locked region will belong
> + *
> + * A pseudo-locked region is associated with a resource group. When this
> + * association is created the pseudo-locked region is initialized. The
> + * details of the pseudo-locked region are not known at this time so only
> + * allocation is done and association established.
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static int pseudo_lock_init(struct rdtgroup *rdtgrp)
> +{
> +	struct pseudo_lock_region *plr;
> +
> +	plr = kzalloc(sizeof(*plr), GFP_KERNEL);
> +	if (!plr)
> +		return -ENOMEM;
> +
> +	init_waitqueue_head(&plr->lock_thread_wq);
> +	INIT_LIST_HEAD(&plr->pm_reqs);
> +	rdtgrp->plr = plr;
> +	return 0;
> +}
> +
> +/**
> + * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-locked
> + * @plr: pseudo-lock region
> + *
> + * Initialize the details required to set up the pseudo-locked region and
> + * allocate the contiguous memory that will be pseudo-locked to the cache.
> + *
> + * Return: 0 on success, <0 on failure.  Descriptive error will be written
> + * to last_cmd_status buffer.
> + */
> +static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
> +{
> +	int ret;
> +
> +	ret = pseudo_lock_region_init(plr);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * We do not yet support contiguous regions larger than
> +	 * KMALLOC_MAX_SIZE.
> +	 */
> +	if (plr->size > KMALLOC_MAX_SIZE) {
> +		rdt_last_cmd_puts("Requested region exceeds maximum size\n");
> +		ret = -E2BIG;
> +		goto out_region;
> +	}
> +
> +	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
> +	if (!plr->kmem) {
> +		rdt_last_cmd_puts("Unable to allocate memory\n");
> +		ret = -ENOMEM;
> +		goto out_region;
> +	}
> +
> +	ret = 0;
> +	goto out;
> +out_region:
> +	pseudo_lock_region_clear(plr);
> +out:
> +	return ret;
> +}
> +
> +/**
> + * pseudo_lock_free - Free a pseudo-locked region
> + * @rdtgrp: resource group to which pseudo-locked region belonged
> + *
> + * The pseudo-locked region's resources have already been released, or not
> + * yet created at this point. Now it can be freed and disassociated from the
> + * resource group.
> + *
> + * Return: void
> + */
> +static void pseudo_lock_free(struct rdtgroup *rdtgrp)
> +{
> +	pseudo_lock_region_clear(rdtgrp->plr);
> +	kfree(rdtgrp->plr);
> +	rdtgrp->plr = NULL;
> +}
> +
> +/**
> + * rdtgroup_monitor_in_progress - Test if monitoring in progress
> + * @rdtgrp: resource group being queried
> + *
> + * Return: 1 if monitor groups have been created for this resource
> + * group, 0 otherwise.
> + */
> +static int rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
> +{
> +	return !list_empty(&rdtgrp->mon.crdtgrp_list);
> +}
> +
> +/**
> + * rdtgroup_locksetup_user_restrict - Restrict user access to group
> + * @rdtgrp: resource group needing access restricted
> + *
> + * A resource group used for cache pseudo-locking cannot have cpus or tasks
> + * assigned to it. This is communicated to the user by restricting access
> + * to all the files that can be used to make such changes.
> + *
> + * Permissions restored with rdtgroup_locksetup_user_restore()
> + *
> + * Return: 0 on success, <0 on failure. If a failure occurs during the
> + * restriction of access an attempt will be made to restore permissions but
> + * the state of the mode of these files will be uncertain when a failure
> + * occurs.
> + */
> +static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
> +{
> +	int ret;
> +
> +	ret = rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
> +	if (ret)
> +		return ret;
> +
> +	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
> +	if (ret)
> +		goto err_tasks;
> +
> +	ret = rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
> +	if (ret)
> +		goto err_cpus;
> +
> +	if (resctrl_arch_mon_capable()) {
> +		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
> +		if (ret)
> +			goto err_cpus_list;
> +	}
> +
> +	ret = 0;
> +	goto out;
> +
> +err_cpus_list:
> +	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
> +err_cpus:
> +	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
> +err_tasks:
> +	rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
> +out:
> +	return ret;
> +}
> +
> +/**
> + * rdtgroup_locksetup_user_restore - Restore user access to group
> + * @rdtgrp: resource group needing access restored
> + *
> + * Restore all file access previously removed using
> + * rdtgroup_locksetup_user_restrict()
> + *
> + * Return: 0 on success, <0 on failure.  If a failure occurs during the
> + * restoration of access an attempt will be made to restrict permissions
> + * again but the state of the mode of these files will be uncertain when
> + * a failure occurs.
> + */
> +static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
> +{
> +	int ret;
> +
> +	ret = rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
> +	if (ret)
> +		return ret;
> +
> +	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
> +	if (ret)
> +		goto err_tasks;
> +
> +	ret = rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
> +	if (ret)
> +		goto err_cpus;
> +
> +	if (resctrl_arch_mon_capable()) {
> +		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
> +		if (ret)
> +			goto err_cpus_list;
> +	}
> +
> +	ret = 0;
> +	goto out;
> +
> +err_cpus_list:
> +	rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
> +err_cpus:
> +	rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
> +err_tasks:
> +	rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
> +out:
> +	return ret;
> +}
> +
> +/**
> + * rdtgroup_locksetup_enter - Resource group enters locksetup mode
> + * @rdtgrp: resource group requested to enter locksetup mode
> + *
> + * A resource group enters locksetup mode to reflect that it would be used
> + * to represent a pseudo-locked region and is in the process of being set
> + * up to do so. A resource group used for a pseudo-locked region would
> + * lose the closid associated with it so we cannot allow it to have any
> + * tasks or cpus assigned nor permit tasks or cpus to be assigned in the
> + * future. Monitoring of a pseudo-locked region is not allowed either.
> + *
> + * The above and more restrictions on a pseudo-locked region are checked
> + * for and enforced before the resource group enters the locksetup mode.
> + *
> + * Returns: 0 if the resource group successfully entered locksetup mode, <0
> + * on failure. On failure the last_cmd_status buffer is updated with text to
> + * communicate details of failure to the user.
> + */
> +int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
> +{
> +	int ret;
> +
> +	/*
> +	 * The default resource group can neither be removed nor lose the
> +	 * default closid associated with it.
> +	 */
> +	if (rdtgrp == &rdtgroup_default) {
> +		rdt_last_cmd_puts("Cannot pseudo-lock default group\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Cache Pseudo-locking not supported when CDP is enabled.
> +	 *
> +	 * Some things to consider if you would like to enable this
> +	 * support (using L3 CDP as example):
> +	 * - When CDP is enabled two separate resources are exposed,
> +	 *   L3DATA and L3CODE, but they are actually on the same cache.
> +	 *   The implication for pseudo-locking is that if a
> +	 *   pseudo-locked region is created on a domain of one
> +	 *   resource (eg. L3CODE), then a pseudo-locked region cannot
> +	 *   be created on that same domain of the other resource
> +	 *   (eg. L3DATA). This is because the creation of a
> +	 *   pseudo-locked region involves a call to wbinvd that will
> +	 *   affect all cache allocations on particular domain.
> +	 * - Considering the previous, it may be possible to only
> +	 *   expose one of the CDP resources to pseudo-locking and
> +	 *   hide the other. For example, we could consider to only
> +	 *   expose L3DATA and since the L3 cache is unified it is
> +	 *   still possible to place instructions there are execute it.
> +	 * - If only one region is exposed to pseudo-locking we should
> +	 *   still keep in mind that availability of a portion of cache
> +	 *   for pseudo-locking should take into account both resources.
> +	 *   Similarly, if a pseudo-locked region is created in one
> +	 *   resource, the portion of cache used by it should be made
> +	 *   unavailable to all future allocations from both resources.
> +	 */
> +	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3) ||
> +	    resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2)) {
> +		rdt_last_cmd_puts("CDP enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Not knowing the bits to disable prefetching implies that this
> +	 * platform does not support Cache Pseudo-Locking.
> +	 */
> +	if (resctrl_arch_get_prefetch_disable_bits() == 0) {
> +		rdt_last_cmd_puts("Pseudo-locking not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rdtgroup_monitor_in_progress(rdtgrp)) {
> +		rdt_last_cmd_puts("Monitoring in progress\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rdtgroup_tasks_assigned(rdtgrp)) {
> +		rdt_last_cmd_puts("Tasks assigned to resource group\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!cpumask_empty(&rdtgrp->cpu_mask)) {
> +		rdt_last_cmd_puts("CPUs assigned to resource group\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rdtgroup_locksetup_user_restrict(rdtgrp)) {
> +		rdt_last_cmd_puts("Unable to modify resctrl permissions\n");
> +		return -EIO;
> +	}
> +
> +	ret = pseudo_lock_init(rdtgrp);
> +	if (ret) {
> +		rdt_last_cmd_puts("Unable to init pseudo-lock region\n");
> +		goto out_release;
> +	}
> +
> +	/*
> +	 * If this system is capable of monitoring a rmid would have been
> +	 * allocated when the control group was created. This is not needed
> +	 * anymore when this group would be used for pseudo-locking. This
> +	 * is safe to call on platforms not capable of monitoring.
> +	 */
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +
> +	ret = 0;
> +	goto out;
> +
> +out_release:
> +	rdtgroup_locksetup_user_restore(rdtgrp);
> +out:
> +	return ret;
> +}
> +
> +/**
> + * rdtgroup_locksetup_exit - resource group exist locksetup mode
> + * @rdtgrp: resource group
> + *
> + * When a resource group exits locksetup mode the earlier restrictions are
> + * lifted.
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
> +{
> +	int ret;
> +
> +	if (resctrl_arch_mon_capable()) {
> +		ret = alloc_rmid(rdtgrp->closid);
> +		if (ret < 0) {
> +			rdt_last_cmd_puts("Out of RMIDs\n");
> +			return ret;
> +		}
> +		rdtgrp->mon.rmid = ret;
> +	}
> +
> +	ret = rdtgroup_locksetup_user_restore(rdtgrp);
> +	if (ret) {
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +		return ret;
> +	}
> +
> +	pseudo_lock_free(rdtgrp);
> +	return 0;
> +}
> +
> +/**
> + * rdtgroup_cbm_overlaps_pseudo_locked - Test if CBM or portion is pseudo-locked
> + * @d: RDT domain
> + * @cbm: CBM to test
> + *
> + * @d represents a cache instance and @cbm a capacity bitmask that is
> + * considered for it. Determine if @cbm overlaps with any existing
> + * pseudo-locked region on @d.
> + *
> + * @cbm is unsigned long, even if only 32 bits are used, to make the
> + * bitmap functions work correctly.
> + *
> + * Return: true if @cbm overlaps with pseudo-locked region on @d, false
> + * otherwise.
> + */
> +bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
> +{
> +	unsigned int cbm_len;
> +	unsigned long cbm_b;
> +
> +	if (d->plr) {
> +		cbm_len = d->plr->s->res->cache.cbm_len;
> +		cbm_b = d->plr->cbm;
> +		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * rdtgroup_pseudo_locked_in_hierarchy - Pseudo-locked region in cache hierarchy
> + * @d: RDT domain under test
> + *
> + * The setup of a pseudo-locked region affects all cache instances within
> + * the hierarchy of the region. It is thus essential to know if any
> + * pseudo-locked regions exist within a cache hierarchy to prevent any
> + * attempts to create new pseudo-locked regions in the same hierarchy.
> + *
> + * Return: true if a pseudo-locked region exists in the hierarchy of @d or
> + *         if it is not possible to test due to memory allocation issue,
> + *         false otherwise.
> + */
> +bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
> +{
> +	cpumask_var_t cpu_with_psl;
> +	enum resctrl_res_level i;
> +	struct rdt_resource *r;
> +	struct rdt_domain *d_i;
> +	bool ret = false;
> +
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
> +		return true;
> +
> +	/*
> +	 * First determine which cpus have pseudo-locked regions
> +	 * associated with them.
> +	 */
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->alloc_capable)
> +			continue;
> +
> +		list_for_each_entry(d_i, &r->domains, list) {
> +			if (d_i->plr)
> +				cpumask_or(cpu_with_psl, cpu_with_psl,
> +					   &d_i->cpu_mask);
> +		}
> +	}
> +
> +	/*
> +	 * Next test if new pseudo-locked region would intersect with
> +	 * existing region.
> +	 */
> +	if (cpumask_intersects(&d->cpu_mask, cpu_with_psl))
> +		ret = true;
> +
> +	free_cpumask_var(cpu_with_psl);
> +	return ret;
> +}
> +
> +/**
> + * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked region
> + * @rdtgrp: Resource group to which the pseudo-locked region belongs.
> + * @sel: Selector of which measurement to perform on a pseudo-locked region.
> + *
> + * The measurement of latency to access a pseudo-locked region should be
> + * done from a cpu that is associated with that pseudo-locked region.
> + * Determine which cpu is associated with this region and start a thread on
> + * that cpu to perform the measurement, wait for that thread to complete.
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
> +{
> +	struct pseudo_lock_region *plr = rdtgrp->plr;
> +	struct task_struct *thread;
> +	unsigned int cpu;
> +	int ret = -1;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (rdtgrp->flags & RDT_DELETED) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (!plr->d) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	plr->thread_done = 0;
> +	cpu = cpumask_first(&plr->d->cpu_mask);
> +	if (!cpu_online(cpu)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	plr->cpu = cpu;
> +
> +	if (sel == 1)
> +		thread = kthread_create_on_node(resctrl_arch_measure_cycles_lat_fn,
> +						plr, cpu_to_node(cpu),
> +						"pseudo_lock_measure/%u",
> +						cpu);
> +	else if (sel == 2)
> +		thread = kthread_create_on_node(resctrl_arch_measure_l2_residency,
> +						plr, cpu_to_node(cpu),
> +						"pseudo_lock_measure/%u",
> +						cpu);
> +	else if (sel == 3)
> +		thread = kthread_create_on_node(resctrl_arch_measure_l3_residency,
> +						plr, cpu_to_node(cpu),
> +						"pseudo_lock_measure/%u",
> +						cpu);
> +	else
> +		goto out;
> +
> +	if (IS_ERR(thread)) {
> +		ret = PTR_ERR(thread);
> +		goto out;
> +	}
> +	kthread_bind(thread, cpu);
> +	wake_up_process(thread);
> +
> +	ret = wait_event_interruptible(plr->lock_thread_wq,
> +				       plr->thread_done == 1);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = 0;
> +
> +out:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return ret;
> +}
> +
> +static ssize_t pseudo_lock_measure_trigger(struct file *file,
> +					   const char __user *user_buf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct rdtgroup *rdtgrp = file->private_data;
> +	size_t buf_size;
> +	char buf[32];
> +	int ret;
> +	int sel;
> +
> +	buf_size = min(count, (sizeof(buf) - 1));
> +	if (copy_from_user(buf, user_buf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +	ret = kstrtoint(buf, 10, &sel);
> +	if (ret == 0) {
> +		if (sel != 1 && sel != 2 && sel != 3)
> +			return -EINVAL;
> +		ret = debugfs_file_get(file->f_path.dentry);
> +		if (ret)
> +			return ret;
> +		ret = pseudo_lock_measure_cycles(rdtgrp, sel);
> +		if (ret == 0)
> +			ret = count;
> +		debugfs_file_put(file->f_path.dentry);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations pseudo_measure_fops = {
> +	.write = pseudo_lock_measure_trigger,
> +	.open = simple_open,
> +	.llseek = default_llseek,
> +};
> +
> +/**
> + * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
> + * @rdtgrp: resource group to which pseudo-lock region belongs
> + *
> + * Called when a resource group in the pseudo-locksetup mode receives a
> + * valid schemata that should be pseudo-locked. Since the resource group is
> + * in pseudo-locksetup mode the &struct pseudo_lock_region has already been
> + * allocated and initialized with the essential information. If a failure
> + * occurs the resource group remains in the pseudo-locksetup mode with the
> + * &struct pseudo_lock_region associated with it, but cleared from all
> + * information and ready for the user to re-attempt pseudo-locking by
> + * writing the schemata again.
> + *
> + * Return: 0 if the pseudo-locked region was successfully pseudo-locked, <0
> + * on failure. Descriptive error will be written to last_cmd_status buffer.
> + */
> +int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
> +{
> +	struct pseudo_lock_region *plr = rdtgrp->plr;
> +	struct task_struct *thread;
> +	unsigned int new_minor;
> +	struct device *dev;
> +	int ret;
> +
> +	ret = pseudo_lock_region_alloc(plr);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pseudo_lock_cstates_constrain(plr);
> +	if (ret < 0) {
> +		ret = -EINVAL;
> +		goto out_region;
> +	}
> +
> +	plr->thread_done = 0;
> +
> +	plr->closid = rdtgrp->closid;
> +	thread = kthread_create_on_node(resctrl_arch_pseudo_lock_fn, plr,
> +					cpu_to_node(plr->cpu),
> +					"pseudo_lock/%u", plr->cpu);
> +	if (IS_ERR(thread)) {
> +		ret = PTR_ERR(thread);
> +		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
> +		goto out_cstates;
> +	}
> +
> +	kthread_bind(thread, plr->cpu);
> +	wake_up_process(thread);
> +
> +	ret = wait_event_interruptible(plr->lock_thread_wq,
> +				       plr->thread_done == 1);
> +	if (ret < 0) {
> +		/*
> +		 * If the thread does not get on the CPU for whatever
> +		 * reason and the process which sets up the region is
> +		 * interrupted then this will leave the thread in runnable
> +		 * state and once it gets on the CPU it will dereference
> +		 * the cleared, but not freed, plr struct resulting in an
> +		 * empty pseudo-locking loop.
> +		 */
> +		rdt_last_cmd_puts("Locking thread interrupted\n");
> +		goto out_cstates;
> +	}
> +
> +	ret = pseudo_lock_minor_get(&new_minor);
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("Unable to obtain a new minor number\n");
> +		goto out_cstates;
> +	}
> +
> +	/*
> +	 * Unlock access but do not release the reference. The
> +	 * pseudo-locked region will still be here on return.
> +	 *
> +	 * The mutex has to be released temporarily to avoid a potential
> +	 * deadlock with the mm->mmap_lock which is obtained in the
> +	 * device_create() and debugfs_create_dir() callpath below as well as
> +	 * before the mmap() callback is called.
> +	 */
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
> +		plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
> +						      debugfs_resctrl);
> +		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
> +			debugfs_create_file("pseudo_lock_measure", 0200,
> +					    plr->debugfs_dir, rdtgrp,
> +					    &pseudo_measure_fops);
> +	}
> +
> +	dev = device_create(&pseudo_lock_class, NULL,
> +			    MKDEV(pseudo_lock_major, new_minor),
> +			    rdtgrp, "%s", rdtgrp->kn->name);
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		rdt_last_cmd_printf("Failed to create character device: %d\n",
> +				    ret);
> +		goto out_debugfs;
> +	}
> +
> +	/* We released the mutex - check if group was removed while we did so */
> +	if (rdtgrp->flags & RDT_DELETED) {
> +		ret = -ENODEV;
> +		goto out_device;
> +	}
> +
> +	plr->minor = new_minor;
> +
> +	rdtgrp->mode = RDT_MODE_PSEUDO_LOCKED;
> +	closid_free(rdtgrp->closid);
> +	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0444);
> +	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0444);
> +
> +	ret = 0;
> +	goto out;
> +
> +out_device:
> +	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
> +out_debugfs:
> +	debugfs_remove_recursive(plr->debugfs_dir);
> +	pseudo_lock_minor_release(new_minor);
> +out_cstates:
> +	pseudo_lock_cstates_relax(plr);
> +out_region:
> +	pseudo_lock_region_clear(plr);
> +out:
> +	return ret;
> +}
> +
> +/**
> + * rdtgroup_pseudo_lock_remove - Remove a pseudo-locked region
> + * @rdtgrp: resource group to which the pseudo-locked region belongs
> + *
> + * The removal of a pseudo-locked region can be initiated when the resource
> + * group is removed from user space via a "rmdir" from userspace or the
> + * unmount of the resctrl filesystem. On removal the resource group does
> + * not go back to pseudo-locksetup mode before it is removed, instead it is
> + * removed directly. There is thus asymmetry with the creation where the
> + * &struct pseudo_lock_region is removed here while it was not created in
> + * rdtgroup_pseudo_lock_create().
> + *
> + * Return: void
> + */
> +void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
> +{
> +	struct pseudo_lock_region *plr = rdtgrp->plr;
> +
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +		/*
> +		 * Default group cannot be a pseudo-locked region so we can
> +		 * free closid here.
> +		 */
> +		closid_free(rdtgrp->closid);
> +		goto free;
> +	}
> +
> +	pseudo_lock_cstates_relax(plr);
> +	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
> +	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
> +	pseudo_lock_minor_release(plr->minor);
> +
> +free:
> +	pseudo_lock_free(rdtgrp);
> +}
> +
> +static int pseudo_lock_dev_open(struct inode *inode, struct file *filp)
> +{
> +	struct rdtgroup *rdtgrp;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdtgrp = region_find_by_minor(iminor(inode));
> +	if (!rdtgrp) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -ENODEV;
> +	}
> +
> +	filp->private_data = rdtgrp;
> +	atomic_inc(&rdtgrp->waitcount);
> +	/* Perform a non-seekable open - llseek is not supported */
> +	filp->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}
> +
> +static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
> +{
> +	struct rdtgroup *rdtgrp;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	rdtgrp = filp->private_data;
> +	WARN_ON(!rdtgrp);
> +	if (!rdtgrp) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -ENODEV;
> +	}
> +	filp->private_data = NULL;
> +	atomic_dec(&rdtgrp->waitcount);
> +	mutex_unlock(&rdtgroup_mutex);
> +	return 0;
> +}
> +
> +static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
> +{
> +	/* Not supported */
> +	return -EINVAL;
> +}
> +
> +static const struct vm_operations_struct pseudo_mmap_ops = {
> +	.mremap = pseudo_lock_dev_mremap,
> +};
> +
> +static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	unsigned long vsize = vma->vm_end - vma->vm_start;
> +	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
> +	struct pseudo_lock_region *plr;
> +	struct rdtgroup *rdtgrp;
> +	unsigned long physical;
> +	unsigned long psize;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdtgrp = filp->private_data;
> +	WARN_ON(!rdtgrp);
> +	if (!rdtgrp) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -ENODEV;
> +	}
> +
> +	plr = rdtgrp->plr;
> +
> +	if (!plr->d) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Task is required to run with affinity to the cpus associated
> +	 * with the pseudo-locked region. If this is not the case the task
> +	 * may be scheduled elsewhere and invalidate entries in the
> +	 * pseudo-locked region.
> +	 */
> +	if (!cpumask_subset(current->cpus_ptr, &plr->d->cpu_mask)) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -EINVAL;
> +	}
> +
> +	physical = __pa(plr->kmem) >> PAGE_SHIFT;
> +	psize = plr->size - off;
> +
> +	if (off > plr->size) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -ENOSPC;
> +	}
> +
> +	/*
> +	 * Ensure changes are carried directly to the memory being mapped,
> +	 * do not allow copy-on-write mapping.
> +	 */
> +	if (!(vma->vm_flags & VM_SHARED)) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -EINVAL;
> +	}
> +
> +	if (vsize > psize) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -ENOSPC;
> +	}
> +
> +	memset(plr->kmem + off, 0, vsize);
> +
> +	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
> +			    vsize, vma->vm_page_prot)) {
> +		mutex_unlock(&rdtgroup_mutex);
> +		return -EAGAIN;
> +	}
> +	vma->vm_ops = &pseudo_mmap_ops;
> +	mutex_unlock(&rdtgroup_mutex);
> +	return 0;
> +}
> +
> +static const struct file_operations pseudo_lock_dev_fops = {
> +	.owner =	THIS_MODULE,
> +	.llseek =	no_llseek,
> +	.read =		NULL,
> +	.write =	NULL,
> +	.open =		pseudo_lock_dev_open,
> +	.release =	pseudo_lock_dev_release,
> +	.mmap =		pseudo_lock_dev_mmap,
> +};
> +
> +int rdt_pseudo_lock_init(void)
> +{
> +	int ret;
> +
> +	ret = register_chrdev(0, "pseudo_lock", &pseudo_lock_dev_fops);
> +	if (ret < 0)
> +		return ret;
> +
> +	pseudo_lock_major = ret;
> +
> +	ret = class_register(&pseudo_lock_class);
> +	if (ret) {
> +		unregister_chrdev(pseudo_lock_major, "pseudo_lock");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void rdt_pseudo_lock_release(void)
> +{
> +	class_unregister(&pseudo_lock_class);
> +	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
> +	pseudo_lock_major = 0;
> +}
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index e69de29bb2d1..936fc6e47386 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -0,0 +1,4013 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * User interface for Resource Allocation in Resource Director Technology(RDT)
> + *
> + * Copyright (C) 2016 Intel Corporation
> + *
> + * Author: Fenghua Yu <fenghua.yu@intel.com>
> + *
> + * More information about RDT be found in the Intel (R) x86 Architecture
> + * Software Developer Manual.
> + */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/fs_parser.h>
> +#include <linux/sysfs.h>
> +#include <linux/kernfs.h>
> +#include <linux/seq_buf.h>
> +#include <linux/seq_file.h>
> +#include <linux/sched/signal.h>
> +#include <linux/sched/task.h>
> +#include <linux/slab.h>
> +#include <linux/task_work.h>
> +#include <linux/user_namespace.h>
> +
> +#include <uapi/linux/magic.h>
> +
> +#include <asm/resctrl.h>
> +#include "internal.h"
> +
> +/* Mutex to protect rdtgroup access. */
> +DEFINE_MUTEX(rdtgroup_mutex);
> +
> +static struct kernfs_root *rdt_root;
> +struct rdtgroup rdtgroup_default;
> +LIST_HEAD(rdt_all_groups);
> +
> +/* list of entries for the schemata file */
> +LIST_HEAD(resctrl_schema_all);
> +
> +/* The filesystem can only be mounted once. */
> +bool resctrl_mounted;
> +
> +/* Kernel fs node for "info" directory under root */
> +static struct kernfs_node *kn_info;
> +
> +/* Kernel fs node for "mon_groups" directory under root */
> +static struct kernfs_node *kn_mongrp;
> +
> +/* Kernel fs node for "mon_data" directory under root */
> +static struct kernfs_node *kn_mondata;
> +
> +/*
> + * Used to store the max resource name width and max resource data width
> + * to display the schemata in a tabular format
> + */
> +int max_name_width, max_data_width;
> +
> +static struct seq_buf last_cmd_status;
> +static char last_cmd_status_buf[512];
> +
> +static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
> +static void rdtgroup_destroy_root(void);
> +
> +struct dentry *debugfs_resctrl;
> +
> +static bool resctrl_debug;
> +
> +void rdt_last_cmd_clear(void)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +	seq_buf_clear(&last_cmd_status);
> +}
> +
> +void rdt_last_cmd_puts(const char *s)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +	seq_buf_puts(&last_cmd_status, s);
> +}
> +
> +void rdt_last_cmd_printf(const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	lockdep_assert_held(&rdtgroup_mutex);
> +	seq_buf_vprintf(&last_cmd_status, fmt, ap);
> +	va_end(ap);
> +}
> +
> +void rdt_staged_configs_clear(void)
> +{
> +	enum resctrl_res_level i;
> +	struct rdt_resource *r;
> +	struct rdt_domain *dom;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->alloc_capable)
> +			continue;
> +
> +		list_for_each_entry(dom, &r->domains, list)
> +			memset(dom->staged_config, 0, sizeof(dom->staged_config));
> +	}
> +}
> +
> +static bool resctrl_is_mbm_enabled(void)
> +{
> +	return (resctrl_arch_is_mbm_total_enabled() ||
> +		resctrl_arch_is_mbm_local_enabled());
> +}
> +
> +static bool resctrl_is_mbm_event(int e)
> +{
> +	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
> +		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
> +}
> +
> +/*
> + * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
> + * we can keep a bitmap of free CLOSIDs in a single integer.
> + *
> + * Using a global CLOSID across all resources has some advantages and
> + * some drawbacks:
> + * + We can simply set current's closid to assign a task to a resource
> + *   group.
> + * + Context switch code can avoid extra memory references deciding which
> + *   CLOSID to load into the PQR_ASSOC MSR
> + * - We give up some options in configuring resource groups across multi-socket
> + *   systems.
> + * - Our choices on how to configure each resource become progressively more
> + *   limited as the number of resources grows.
> + */
> +static unsigned long closid_free_map;
> +static int closid_free_map_len;
> +
> +int closids_supported(void)
> +{
> +	return closid_free_map_len;
> +}
> +
> +static void closid_init(void)
> +{
> +	struct resctrl_schema *s;
> +	u32 rdt_min_closid = 32;
> +
> +	/* Compute rdt_min_closid across all resources */
> +	list_for_each_entry(s, &resctrl_schema_all, list)
> +		rdt_min_closid = min(rdt_min_closid, s->num_closid);
> +
> +	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
> +
> +	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
> +	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
> +	closid_free_map_len = rdt_min_closid;
> +}
> +
> +static int closid_alloc(void)
> +{
> +	int cleanest_closid;
> +	u32 closid;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> +	    resctrl_arch_is_llc_occupancy_enabled()) {
> +		cleanest_closid = resctrl_find_cleanest_closid();
> +		if (cleanest_closid < 0)
> +			return cleanest_closid;
> +		closid = cleanest_closid;
> +	} else {
> +		closid = ffs(closid_free_map);
> +		if (closid == 0)
> +			return -ENOSPC;
> +		closid--;
> +	}
> +	__clear_bit(closid, &closid_free_map);
> +
> +	return closid;
> +}
> +
> +void closid_free(int closid)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	__set_bit(closid, &closid_free_map);
> +}
> +
> +/**
> + * closid_allocated - test if provided closid is in use
> + * @closid: closid to be tested
> + *
> + * Return: true if @closid is currently associated with a resource group,
> + * false if @closid is free
> + */
> +bool closid_allocated(unsigned int closid)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	return !test_bit(closid, &closid_free_map);
> +}
> +
> +/**
> + * rdtgroup_mode_by_closid - Return mode of resource group with closid
> + * @closid: closid if the resource group
> + *
> + * Each resource group is associated with a @closid. Here the mode
> + * of a resource group can be queried by searching for it using its closid.
> + *
> + * Return: mode as &enum rdtgrp_mode of resource group with closid @closid
> + */
> +enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
> +{
> +	struct rdtgroup *rdtgrp;
> +
> +	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (rdtgrp->closid == closid)
> +			return rdtgrp->mode;
> +	}
> +
> +	return RDT_NUM_MODES;
> +}
> +
> +static const char * const rdt_mode_str[] = {
> +	[RDT_MODE_SHAREABLE]		= "shareable",
> +	[RDT_MODE_EXCLUSIVE]		= "exclusive",
> +	[RDT_MODE_PSEUDO_LOCKSETUP]	= "pseudo-locksetup",
> +	[RDT_MODE_PSEUDO_LOCKED]	= "pseudo-locked",
> +};
> +
> +/**
> + * rdtgroup_mode_str - Return the string representation of mode
> + * @mode: the resource group mode as &enum rdtgroup_mode
> + *
> + * Return: string representation of valid mode, "unknown" otherwise
> + */
> +static const char *rdtgroup_mode_str(enum rdtgrp_mode mode)
> +{
> +	if (mode < RDT_MODE_SHAREABLE || mode >= RDT_NUM_MODES)
> +		return "unknown";
> +
> +	return rdt_mode_str[mode];
> +}
> +
> +/* set uid and gid of rdtgroup dirs and files to that of the creator */
> +static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
> +{
> +	struct iattr iattr = { .ia_valid = ATTR_UID | ATTR_GID,
> +				.ia_uid = current_fsuid(),
> +				.ia_gid = current_fsgid(), };
> +
> +	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
> +	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
> +		return 0;
> +
> +	return kernfs_setattr(kn, &iattr);
> +}
> +
> +static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *rft)
> +{
> +	struct kernfs_node *kn;
> +	int ret;
> +
> +	kn = __kernfs_create_file(parent_kn, rft->name, rft->mode,
> +				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +				  0, rft->kf_ops, rft, NULL, NULL);
> +	if (IS_ERR(kn))
> +		return PTR_ERR(kn);
> +
> +	ret = rdtgroup_kn_set_ugid(kn);
> +	if (ret) {
> +		kernfs_remove(kn);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
> +{
> +	struct kernfs_open_file *of = m->private;
> +	struct rftype *rft = of->kn->priv;
> +
> +	if (rft->seq_show)
> +		return rft->seq_show(of, m, arg);
> +	return 0;
> +}
> +
> +static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
> +				   size_t nbytes, loff_t off)
> +{
> +	struct rftype *rft = of->kn->priv;
> +
> +	if (rft->write)
> +		return rft->write(of, buf, nbytes, off);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct kernfs_ops rdtgroup_kf_single_ops = {
> +	.atomic_write_len	= PAGE_SIZE,
> +	.write			= rdtgroup_file_write,
> +	.seq_show		= rdtgroup_seqfile_show,
> +};
> +
> +static const struct kernfs_ops kf_mondata_ops = {
> +	.atomic_write_len	= PAGE_SIZE,
> +	.seq_show		= rdtgroup_mondata_show,
> +};
> +
> +static bool is_cpu_list(struct kernfs_open_file *of)
> +{
> +	struct rftype *rft = of->kn->priv;
> +
> +	return rft->flags & RFTYPE_FLAGS_CPUS_LIST;
> +}
> +
> +static int rdtgroup_cpus_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	struct cpumask *mask;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +
> +	if (rdtgrp) {
> +		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> +			if (!rdtgrp->plr->d) {
> +				rdt_last_cmd_clear();
> +				rdt_last_cmd_puts("Cache domain offline\n");
> +				ret = -ENODEV;
> +			} else {
> +				mask = &rdtgrp->plr->d->cpu_mask;
> +				seq_printf(s, is_cpu_list(of) ?
> +					   "%*pbl\n" : "%*pb\n",
> +					   cpumask_pr_args(mask));
> +			}
> +		} else {
> +			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
> +				   cpumask_pr_args(&rdtgrp->cpu_mask));
> +		}
> +	} else {
> +		ret = -ENOENT;
> +	}
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
> +/*
> + * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
> + *
> + * Per task closids/rmids must have been set up before calling this function.
> + * @r may be NULL.
> + */
> +static void
> +update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
> +{
> +	struct resctrl_cpu_sync defaults;
> +	struct resctrl_cpu_sync *defaults_p = NULL;
> +
> +	if (r) {
> +		defaults.closid = r->closid;
> +		defaults.rmid = r->mon.rmid;
> +		defaults_p = &defaults;
> +	}
> +
> +	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_defaults, defaults_p,
> +			 1);
> +}
> +
> +static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> +			  cpumask_var_t tmpmask)
> +{
> +	struct rdtgroup *prgrp = rdtgrp->mon.parent, *crgrp;
> +	struct list_head *head;
> +
> +	/* Check whether cpus belong to parent ctrl group */
> +	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
> +	if (!cpumask_empty(tmpmask)) {
> +		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Check whether cpus are dropped from this group */
> +	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
> +	if (!cpumask_empty(tmpmask)) {
> +		/* Give any dropped cpus to parent rdtgroup */
> +		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
> +		update_closid_rmid(tmpmask, prgrp);
> +	}
> +
> +	/*
> +	 * If we added cpus, remove them from previous group that owned them
> +	 * and update per-cpu rmid
> +	 */
> +	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
> +	if (!cpumask_empty(tmpmask)) {
> +		head = &prgrp->mon.crdtgrp_list;
> +		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> +			if (crgrp == rdtgrp)
> +				continue;
> +			cpumask_andnot(&crgrp->cpu_mask, &crgrp->cpu_mask,
> +				       tmpmask);
> +		}
> +		update_closid_rmid(tmpmask, rdtgrp);
> +	}
> +
> +	/* Done pushing/pulling - update this group with new mask */
> +	cpumask_copy(&rdtgrp->cpu_mask, newmask);
> +
> +	return 0;
> +}
> +
> +static void cpumask_rdtgrp_clear(struct rdtgroup *r, struct cpumask *m)
> +{
> +	struct rdtgroup *crgrp;
> +
> +	cpumask_andnot(&r->cpu_mask, &r->cpu_mask, m);
> +	/* update the child mon group masks as well*/
> +	list_for_each_entry(crgrp, &r->mon.crdtgrp_list, mon.crdtgrp_list)
> +		cpumask_and(&crgrp->cpu_mask, &r->cpu_mask, &crgrp->cpu_mask);
> +}
> +
> +static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> +			   cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
> +{
> +	struct rdtgroup *r, *crgrp;
> +	struct list_head *head;
> +
> +	/* Check whether cpus are dropped from this group */
> +	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
> +	if (!cpumask_empty(tmpmask)) {
> +		/* Can't drop from default group */
> +		if (rdtgrp == &rdtgroup_default) {
> +			rdt_last_cmd_puts("Can't drop CPUs from default group\n");
> +			return -EINVAL;
> +		}
> +
> +		/* Give any dropped cpus to rdtgroup_default */
> +		cpumask_or(&rdtgroup_default.cpu_mask,
> +			   &rdtgroup_default.cpu_mask, tmpmask);
> +		update_closid_rmid(tmpmask, &rdtgroup_default);
> +	}
> +
> +	/*
> +	 * If we added cpus, remove them from previous group and
> +	 * the prev group's child groups that owned them
> +	 * and update per-cpu closid/rmid.
> +	 */
> +	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
> +	if (!cpumask_empty(tmpmask)) {
> +		list_for_each_entry(r, &rdt_all_groups, rdtgroup_list) {
> +			if (r == rdtgrp)
> +				continue;
> +			cpumask_and(tmpmask1, &r->cpu_mask, tmpmask);
> +			if (!cpumask_empty(tmpmask1))
> +				cpumask_rdtgrp_clear(r, tmpmask1);
> +		}
> +		update_closid_rmid(tmpmask, rdtgrp);
> +	}
> +
> +	/* Done pushing/pulling - update this group with new mask */
> +	cpumask_copy(&rdtgrp->cpu_mask, newmask);
> +
> +	/*
> +	 * Clear child mon group masks since there is a new parent mask
> +	 * now and update the rmid for the cpus the child lost.
> +	 */
> +	head = &rdtgrp->mon.crdtgrp_list;
> +	list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> +		cpumask_and(tmpmask, &rdtgrp->cpu_mask, &crgrp->cpu_mask);
> +		update_closid_rmid(tmpmask, rdtgrp);
> +		cpumask_clear(&crgrp->cpu_mask);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
> +				   char *buf, size_t nbytes, loff_t off)
> +{
> +	cpumask_var_t tmpmask, newmask, tmpmask1;
> +	struct rdtgroup *rdtgrp;
> +	int ret;
> +
> +	if (!buf)
> +		return -EINVAL;
> +
> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> +		return -ENOMEM;
> +	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
> +		free_cpumask_var(tmpmask);
> +		return -ENOMEM;
> +	}
> +	if (!zalloc_cpumask_var(&tmpmask1, GFP_KERNEL)) {
> +		free_cpumask_var(tmpmask);
> +		free_cpumask_var(newmask);
> +		return -ENOMEM;
> +	}
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		ret = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> +	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> +		goto unlock;
> +	}
> +
> +	if (is_cpu_list(of))
> +		ret = cpulist_parse(buf, newmask);
> +	else
> +		ret = cpumask_parse(buf, newmask);
> +
> +	if (ret) {
> +		rdt_last_cmd_puts("Bad CPU list/mask\n");
> +		goto unlock;
> +	}
> +
> +	/* check that user didn't specify any offline cpus */
> +	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
> +	if (!cpumask_empty(tmpmask)) {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Can only assign online CPUs\n");
> +		goto unlock;
> +	}
> +
> +	if (rdtgrp->type == RDTCTRL_GROUP)
> +		ret = cpus_ctrl_write(rdtgrp, newmask, tmpmask, tmpmask1);
> +	else if (rdtgrp->type == RDTMON_GROUP)
> +		ret = cpus_mon_write(rdtgrp, newmask, tmpmask);
> +	else
> +		ret = -EINVAL;
> +
> +unlock:
> +	rdtgroup_kn_unlock(of->kn);
> +	free_cpumask_var(tmpmask);
> +	free_cpumask_var(newmask);
> +	free_cpumask_var(tmpmask1);
> +
> +	return ret ?: nbytes;
> +}
> +
> +/**
> + * rdtgroup_remove - the helper to remove resource group safely
> + * @rdtgrp: resource group to remove
> + *
> + * On resource group creation via a mkdir, an extra kernfs_node reference is
> + * taken to ensure that the rdtgroup structure remains accessible for the
> + * rdtgroup_kn_unlock() calls where it is removed.
> + *
> + * Drop the extra reference here, then free the rdtgroup structure.
> + *
> + * Return: void
> + */
> +static void rdtgroup_remove(struct rdtgroup *rdtgrp)
> +{
> +	kernfs_put(rdtgrp->kn);
> +	kfree(rdtgrp);
> +}
> +
> +static void _update_task_closid_rmid(void *task)
> +{
> +	/*
> +	 * If the task is still current on this CPU, update PQR_ASSOC MSR.
> +	 * Otherwise, the MSR is updated when the task is scheduled in.
> +	 */
> +	if (task == current)
> +		resctrl_arch_sched_in(task);
> +}
> +
> +static void update_task_closid_rmid(struct task_struct *t)
> +{
> +	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> +		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> +	else
> +		_update_task_closid_rmid(t);
> +}
> +
> +static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgrp)
> +{
> +	u32 closid, rmid = rdtgrp->mon.rmid;
> +
> +	if (rdtgrp->type == RDTCTRL_GROUP)
> +		closid = rdtgrp->closid;
> +	else if (rdtgrp->type == RDTMON_GROUP)
> +		closid = rdtgrp->mon.parent->closid;
> +	else
> +		return false;
> +
> +	return resctrl_arch_match_closid(tsk, closid) &&
> +	       resctrl_arch_match_rmid(tsk, closid, rmid);
> +}
> +
> +static int __rdtgroup_move_task(struct task_struct *tsk,
> +				struct rdtgroup *rdtgrp)
> +{
> +	/* If the task is already in rdtgrp, no need to move the task. */
> +	if (task_in_rdtgroup(tsk, rdtgrp))
> +		return 0;
> +
> +	/*
> +	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
> +	 * updated by them.
> +	 *
> +	 * For ctrl_mon groups, move both closid and rmid.
> +	 * For monitor groups, can move the tasks only from
> +	 * their parent CTRL group.
> +	 */
> +	if (rdtgrp->type == RDTMON_GROUP &&
> +	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
> +		rdt_last_cmd_puts("Can't move task to different control group\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rdtgrp->type == RDTMON_GROUP)
> +		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
> +					     rdtgrp->mon.rmid);
> +	else
> +		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
> +					     rdtgrp->mon.rmid);
> +
> +	/*
> +	 * Ensure the task's closid and rmid are written before determining if
> +	 * the task is current that will decide if it will be interrupted.
> +	 * This pairs with the full barrier between the rq->curr update and
> +	 * resctrl_arch_sched_in() during context switch.
> +	 */
> +	smp_mb();
> +
> +	/*
> +	 * By now, the task's closid and rmid are set. If the task is current
> +	 * on a CPU, the PQR_ASSOC MSR needs to be updated to make the resource
> +	 * group go into effect. If the task is not current, the MSR will be
> +	 * updated when the task is scheduled in.
> +	 */
> +	update_task_closid_rmid(tsk);
> +
> +	return 0;
> +}
> +
> +static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
> +{
> +	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
> +		resctrl_arch_match_closid(t, r->closid));
> +}
> +
> +static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
> +{
> +	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
> +		resctrl_arch_match_rmid(t, r->mon.parent->closid,
> +					r->mon.rmid));
> +}
> +
> +/**
> + * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource group
> + * @r: Resource group
> + *
> + * Return: 1 if tasks have been assigned to @r, 0 otherwise
> + */
> +int rdtgroup_tasks_assigned(struct rdtgroup *r)
> +{
> +	struct task_struct *p, *t;
> +	int ret = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	rcu_read_lock();
> +	for_each_process_thread(p, t) {
> +		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +static int rdtgroup_task_write_permission(struct task_struct *task,
> +					  struct kernfs_open_file *of)
> +{
> +	const struct cred *tcred = get_task_cred(task);
> +	const struct cred *cred = current_cred();
> +	int ret = 0;
> +
> +	/*
> +	 * Even if we're attaching all tasks in the thread group, we only
> +	 * need to check permissions on one of them.
> +	 */
> +	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
> +	    !uid_eq(cred->euid, tcred->uid) &&
> +	    !uid_eq(cred->euid, tcred->suid)) {
> +		rdt_last_cmd_printf("No permission to move task %d\n", task->pid);
> +		ret = -EPERM;
> +	}
> +
> +	put_cred(tcred);
> +	return ret;
> +}
> +
> +static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
> +			      struct kernfs_open_file *of)
> +{
> +	struct task_struct *tsk;
> +	int ret;
> +
> +	rcu_read_lock();
> +	if (pid) {
> +		tsk = find_task_by_vpid(pid);
> +		if (!tsk) {
> +			rcu_read_unlock();
> +			rdt_last_cmd_printf("No task %d\n", pid);
> +			return -ESRCH;
> +		}
> +	} else {
> +		tsk = current;
> +	}
> +
> +	get_task_struct(tsk);
> +	rcu_read_unlock();
> +
> +	ret = rdtgroup_task_write_permission(tsk, of);
> +	if (!ret)
> +		ret = __rdtgroup_move_task(tsk, rdtgrp);
> +
> +	put_task_struct(tsk);
> +	return ret;
> +}
> +
> +static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
> +				    char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdtgroup *rdtgrp;
> +	char *pid_str;
> +	int ret = 0;
> +	pid_t pid;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		rdtgroup_kn_unlock(of->kn);
> +		return -ENOENT;
> +	}
> +	rdt_last_cmd_clear();
> +
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> +	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> +		goto unlock;
> +	}
> +
> +	while (buf && buf[0] != '\0' && buf[0] != '\n') {
> +		pid_str = strim(strsep(&buf, ","));
> +
> +		if (kstrtoint(pid_str, 0, &pid)) {
> +			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (pid < 0) {
> +			rdt_last_cmd_printf("Invalid pid %d\n", pid);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = rdtgroup_move_task(pid, rdtgrp, of);
> +		if (ret) {
> +			rdt_last_cmd_printf("Error while processing task %d\n", pid);
> +			break;
> +		}
> +	}
> +
> +unlock:
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret ?: nbytes;
> +}
> +
> +static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
> +{
> +	struct task_struct *p, *t;
> +	pid_t pid;
> +
> +	rcu_read_lock();
> +	for_each_process_thread(p, t) {
> +		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
> +			pid = task_pid_vnr(t);
> +			if (pid)
> +				seq_printf(s, "%d\n", pid);
> +		}
> +	}
> +	rcu_read_unlock();
> +}
> +
> +static int rdtgroup_tasks_show(struct kernfs_open_file *of,
> +			       struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		show_rdt_tasks(rdtgrp, s);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
> +				struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->closid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PROC_CPU_RESCTRL
> +
> +/*
> + * A task can only be part of one resctrl control group and of one monitor
> + * group which is associated to that control group.
> + *
> + * 1)   res:
> + *      mon:
> + *
> + *    resctrl is not available.
> + *
> + * 2)   res:/
> + *      mon:
> + *
> + *    Task is part of the root resctrl control group, and it is not associated
> + *    to any monitor group.
> + *
> + * 3)  res:/
> + *     mon:mon0
> + *
> + *    Task is part of the root resctrl control group and monitor group mon0.
> + *
> + * 4)  res:group0
> + *     mon:
> + *
> + *    Task is part of resctrl control group group0, and it is not associated
> + *    to any monitor group.
> + *
> + * 5) res:group0
> + *    mon:mon1
> + *
> + *    Task is part of resctrl control group group0 and monitor group mon1.
> + */
> +int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
> +		      struct pid *pid, struct task_struct *tsk)
> +{
> +	struct rdtgroup *rdtg;
> +	int ret = 0;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	/* Return empty if resctrl has not been mounted. */
> +	if (!resctrl_mounted) {
> +		seq_puts(s, "res:\nmon:\n");
> +		goto unlock;
> +	}
> +
> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		struct rdtgroup *crg;
> +
> +		/*
> +		 * Task information is only relevant for shareable
> +		 * and exclusive groups.
> +		 */
> +		if (rdtg->mode != RDT_MODE_SHAREABLE &&
> +		    rdtg->mode != RDT_MODE_EXCLUSIVE)
> +			continue;
> +
> +		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
> +			continue;
> +
> +		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
> +			   rdtg->kn->name);
> +		seq_puts(s, "mon:");
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
> +						     crg->mon.rmid))
> +				continue;
> +			seq_printf(s, "%s", crg->kn->name);
> +			break;
> +		}
> +		seq_putc(s, '\n');
> +		goto unlock;
> +	}
> +	/*
> +	 * The above search should succeed. Otherwise return
> +	 * with an error.
> +	 */
> +	ret = -ENOENT;
> +unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return ret;
> +}
> +#endif
> +
> +static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
> +				    struct seq_file *seq, void *v)
> +{
> +	int len;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	len = seq_buf_used(&last_cmd_status);
> +	if (len)
> +		seq_printf(seq, "%.*s", len, last_cmd_status_buf);
> +	else
> +		seq_puts(seq, "ok\n");
> +	mutex_unlock(&rdtgroup_mutex);
> +	return 0;
> +}
> +
> +static int rdt_num_closids_show(struct kernfs_open_file *of,
> +				struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +
> +	seq_printf(seq, "%u\n", s->num_closid);
> +	return 0;
> +}
> +
> +static int rdt_default_ctrl_show(struct kernfs_open_file *of,
> +			     struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%x\n", r->default_ctrl);
> +	return 0;
> +}
> +
> +static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
> +			     struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
> +	return 0;
> +}
> +
> +static int rdt_shareable_bits_show(struct kernfs_open_file *of,
> +				   struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%x\n", r->cache.shareable_bits);
> +	return 0;
> +}
> +
> +/*
> + * rdt_bit_usage_show - Display current usage of resources
> + *
> + * A domain is a shared resource that can now be allocated differently. Here
> + * we display the current regions of the domain as an annotated bitmask.
> + * For each domain of this resource its allocation bitmask
> + * is annotated as below to indicate the current usage of the corresponding bit:
> + *   0 - currently unused
> + *   X - currently available for sharing and used by software and hardware
> + *   H - currently used by hardware only but available for software use
> + *   S - currently used and shareable by software only
> + *   E - currently used exclusively by one resource group
> + *   P - currently pseudo-locked by one resource group
> + */
> +static int rdt_bit_usage_show(struct kernfs_open_file *of,
> +			      struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	/*
> +	 * Use unsigned long even though only 32 bits are used to ensure
> +	 * test_bit() is used safely.
> +	 */
> +	unsigned long sw_shareable = 0, hw_shareable = 0;
> +	unsigned long exclusive = 0, pseudo_locked = 0;
> +	struct rdt_resource *r = s->res;
> +	struct rdt_domain *dom;
> +	int i, hwb, swb, excl, psl;
> +	enum rdtgrp_mode mode;
> +	bool sep = false;
> +	u32 ctrl_val;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +	hw_shareable = r->cache.shareable_bits;
> +	list_for_each_entry(dom, &r->domains, list) {
> +		if (sep)
> +			seq_putc(seq, ';');
> +		sw_shareable = 0;
> +		exclusive = 0;
> +		seq_printf(seq, "%d=", dom->id);
> +		for (i = 0; i < closids_supported(); i++) {
> +			if (!closid_allocated(i))
> +				continue;
> +			ctrl_val = resctrl_arch_get_config(r, dom, i,
> +							   s->conf_type);
> +			mode = rdtgroup_mode_by_closid(i);
> +			switch (mode) {
> +			case RDT_MODE_SHAREABLE:
> +				sw_shareable |= ctrl_val;
> +				break;
> +			case RDT_MODE_EXCLUSIVE:
> +				exclusive |= ctrl_val;
> +				break;
> +			case RDT_MODE_PSEUDO_LOCKSETUP:
> +			/*
> +			 * RDT_MODE_PSEUDO_LOCKSETUP is possible
> +			 * here but not included since the CBM
> +			 * associated with this CLOSID in this mode
> +			 * is not initialized and no task or cpu can be
> +			 * assigned this CLOSID.
> +			 */
> +				break;
> +			case RDT_MODE_PSEUDO_LOCKED:
> +			case RDT_NUM_MODES:
> +				WARN(1,
> +				     "invalid mode for closid %d\n", i);
> +				break;
> +			}
> +		}
> +		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
> +			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
> +			hwb = test_bit(i, &hw_shareable);
> +			swb = test_bit(i, &sw_shareable);
> +			excl = test_bit(i, &exclusive);
> +			psl = test_bit(i, &pseudo_locked);
> +			if (hwb && swb)
> +				seq_putc(seq, 'X');
> +			else if (hwb && !swb)
> +				seq_putc(seq, 'H');
> +			else if (!hwb && swb)
> +				seq_putc(seq, 'S');
> +			else if (excl)
> +				seq_putc(seq, 'E');
> +			else if (psl)
> +				seq_putc(seq, 'P');
> +			else /* Unused bits remain */
> +				seq_putc(seq, '0');
> +		}
> +		sep = true;
> +	}
> +	seq_putc(seq, '\n');
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return 0;
> +}
> +
> +static int rdt_min_bw_show(struct kernfs_open_file *of,
> +			     struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->membw.min_bw);
> +	return 0;
> +}
> +
> +static int rdt_num_rmids_show(struct kernfs_open_file *of,
> +			      struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	seq_printf(seq, "%d\n", r->num_rmid);
> +
> +	return 0;
> +}
> +
> +static int rdt_mon_features_show(struct kernfs_open_file *of,
> +				 struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	struct mon_evt *mevt;
> +
> +	list_for_each_entry(mevt, &r->evt_list, list) {
> +		seq_printf(seq, "%s\n", mevt->name);
> +		if (mevt->configurable)
> +			seq_printf(seq, "%s_config\n", mevt->name);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rdt_bw_gran_show(struct kernfs_open_file *of,
> +			     struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->membw.bw_gran);
> +	return 0;
> +}
> +
> +static int rdt_delay_linear_show(struct kernfs_open_file *of,
> +			     struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->membw.delay_linear);
> +	return 0;
> +}
> +
> +static int max_threshold_occ_show(struct kernfs_open_file *of,
> +				  struct seq_file *seq, void *v)
> +{
> +	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
> +
> +	return 0;
> +}
> +
> +static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
> +					 struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
> +		seq_puts(seq, "per-thread\n");
> +	else
> +		seq_puts(seq, "max\n");
> +
> +	return 0;
> +}
> +
> +static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
> +				       char *buf, size_t nbytes, loff_t off)
> +{
> +	unsigned int bytes;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &bytes);
> +	if (ret)
> +		return ret;
> +
> +	if (bytes > resctrl_rmid_realloc_limit)
> +		return -EINVAL;
> +
> +	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(bytes);
> +
> +	return nbytes;
> +}
> +
> +/*
> + * rdtgroup_mode_show - Display mode of this resource group
> + */
> +static int rdtgroup_mode_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		rdtgroup_kn_unlock(of->kn);
> +		return -ENOENT;
> +	}
> +
> +	seq_printf(s, "%s\n", rdtgroup_mode_str(rdtgrp->mode));
> +
> +	rdtgroup_kn_unlock(of->kn);
> +	return 0;
> +}
> +
> +static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type)
> +{
> +	switch (my_type) {
> +	case CDP_CODE:
> +		return CDP_DATA;
> +	case CDP_DATA:
> +		return CDP_CODE;
> +	default:
> +	case CDP_NONE:
> +		return CDP_NONE;
> +	}
> +}
> +
> +static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
> +					struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
> +
> +	return 0;
> +}
> +
> +/**
> + * __rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
> + * @r: Resource to which domain instance @d belongs.
> + * @d: The domain instance for which @closid is being tested.
> + * @cbm: Capacity bitmask being tested.
> + * @closid: Intended closid for @cbm.
> + * @type: CDP type of @r.
> + * @exclusive: Only check if overlaps with exclusive resource groups
> + *
> + * Checks if provided @cbm intended to be used for @closid on domain
> + * @d overlaps with any other closids or other hardware usage associated
> + * with this domain. If @exclusive is true then only overlaps with
> + * resource groups in exclusive mode will be considered. If @exclusive
> + * is false then overlaps with any resource group or hardware entities
> + * will be considered.
> + *
> + * @cbm is unsigned long, even if only 32 bits are used, to make the
> + * bitmap functions work correctly.
> + *
> + * Return: false if CBM does not overlap, true if it does.
> + */
> +static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
> +				    unsigned long cbm, int closid,
> +				    enum resctrl_conf_type type, bool exclusive)
> +{
> +	enum rdtgrp_mode mode;
> +	unsigned long ctrl_b;
> +	int i;
> +
> +	/* Check for any overlap with regions used by hardware directly */
> +	if (!exclusive) {
> +		ctrl_b = r->cache.shareable_bits;
> +		if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len))
> +			return true;
> +	}
> +
> +	/* Check for overlap with other resource groups */
> +	for (i = 0; i < closids_supported(); i++) {
> +		ctrl_b = resctrl_arch_get_config(r, d, i, type);
> +		mode = rdtgroup_mode_by_closid(i);
> +		if (closid_allocated(i) && i != closid &&
> +		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
> +			if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len)) {
> +				if (exclusive) {
> +					if (mode == RDT_MODE_EXCLUSIVE)
> +						return true;
> +					continue;
> +				}
> +				return true;
> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
> + * @s: Schema for the resource to which domain instance @d belongs.
> + * @d: The domain instance for which @closid is being tested.
> + * @cbm: Capacity bitmask being tested.
> + * @closid: Intended closid for @cbm.
> + * @exclusive: Only check if overlaps with exclusive resource groups
> + *
> + * Resources that can be allocated using a CBM can use the CBM to control
> + * the overlap of these allocations. rdtgroup_cmb_overlaps() is the test
> + * for overlap. Overlap test is not limited to the specific resource for
> + * which the CBM is intended though - when dealing with CDP resources that
> + * share the underlying hardware the overlap check should be performed on
> + * the CDP resource sharing the hardware also.
> + *
> + * Refer to description of __rdtgroup_cbm_overlaps() for the details of the
> + * overlap test.
> + *
> + * Return: true if CBM overlap detected, false if there is no overlap
> + */
> +bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
> +			   unsigned long cbm, int closid, bool exclusive)
> +{
> +	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
> +	struct rdt_resource *r = s->res;
> +
> +	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
> +				    exclusive))
> +		return true;
> +
> +	if (!resctrl_arch_get_cdp_enabled(r->rid))
> +		return false;
> +	return  __rdtgroup_cbm_overlaps(r, d, cbm, closid, peer_type, exclusive);
> +}
> +
> +/**
> + * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
> + * @rdtgrp: Resource group identified through its closid.
> + *
> + * An exclusive resource group implies that there should be no sharing of
> + * its allocated resources. At the time this group is considered to be
> + * exclusive this test can determine if its current schemata supports this
> + * setting by testing for overlap with all other resource groups.
> + *
> + * Return: true if resource group can be exclusive, false if there is overlap
> + * with allocations of other resource groups and thus this resource group
> + * cannot be exclusive.
> + */
> +static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
> +{
> +	int closid = rdtgrp->closid;
> +	struct resctrl_schema *s;
> +	struct rdt_resource *r;
> +	bool has_cache = false;
> +	struct rdt_domain *d;
> +	u32 ctrl;
> +
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +	list_for_each_entry(s, &resctrl_schema_all, list) {
> +		r = s->res;
> +		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
> +			continue;
> +		has_cache = true;
> +		list_for_each_entry(d, &r->domains, list) {
> +			ctrl = resctrl_arch_get_config(r, d, closid,
> +						       s->conf_type);
> +			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
> +				rdt_last_cmd_puts("Schemata overlaps\n");
> +				return false;
> +			}
> +		}
> +	}
> +
> +	if (!has_cache) {
> +		rdt_last_cmd_puts("Cannot be exclusive without CAT/CDP\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * rdtgroup_mode_write - Modify the resource group's mode
> + */
> +static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
> +				   char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdtgroup *rdtgrp;
> +	enum rdtgrp_mode mode;
> +	int ret = 0;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +	buf[nbytes - 1] = '\0';
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		rdtgroup_kn_unlock(of->kn);
> +		return -ENOENT;
> +	}
> +
> +	rdt_last_cmd_clear();
> +
> +	mode = rdtgrp->mode;
> +
> +	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> +	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> +	    (!strcmp(buf, "pseudo-locksetup") &&
> +	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> +	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
> +		goto out;
> +
> +	if (mode == RDT_MODE_PSEUDO_LOCKED) {
> +		rdt_last_cmd_puts("Cannot change pseudo-locked group\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!strcmp(buf, "shareable")) {
> +		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +			ret = rdtgroup_locksetup_exit(rdtgrp);
> +			if (ret)
> +				goto out;
> +		}
> +		rdtgrp->mode = RDT_MODE_SHAREABLE;
> +	} else if (!strcmp(buf, "exclusive")) {
> +		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +			ret = rdtgroup_locksetup_exit(rdtgrp);
> +			if (ret)
> +				goto out;
> +		}
> +		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
> +	} else if (IS_ENABLED(CONFIG_RESCTRL_FS_PSEUDO_LOCK) &&
> +		   !strcmp(buf, "pseudo-locksetup")) {
> +		ret = rdtgroup_locksetup_enter(rdtgrp);
> +		if (ret)
> +			goto out;
> +		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
> +	} else {
> +		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> +		ret = -EINVAL;
> +	}
> +
> +out:
> +	rdtgroup_kn_unlock(of->kn);
> +	return ret ?: nbytes;
> +}
> +
> +/**
> + * rdtgroup_cbm_to_size - Translate CBM to size in bytes
> + * @r: RDT resource to which @d belongs.
> + * @d: RDT domain instance.
> + * @cbm: bitmask for which the size should be computed.
> + *
> + * The bitmask provided associated with the RDT domain instance @d will be
> + * translated into how many bytes it represents. The size in bytes is
> + * computed by first dividing the total cache size by the CBM length to
> + * determine how many bytes each bit in the bitmask represents. The result
> + * is multiplied with the number of bits set in the bitmask.
> + *
> + * @cbm is unsigned long, even if only 32 bits are used to make the
> + * bitmap functions work correctly.
> + */
> +unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
> +				  struct rdt_domain *d, unsigned long cbm)
> +{
> +	struct cpu_cacheinfo *ci;
> +	unsigned int size = 0;
> +	int num_b, i;
> +
> +	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
> +	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
> +	for (i = 0; i < ci->num_leaves; i++) {
> +		if (ci->info_list[i].level == r->cache_level) {
> +			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
> +			break;
> +		}
> +	}
> +
> +	return size;
> +}
> +
> +/*
> + * rdtgroup_size_show - Display size in bytes of allocated regions
> + *
> + * The "size" file mirrors the layout of the "schemata" file, printing the
> + * size in bytes of each region instead of the capacity bitmask.
> + */
> +static int rdtgroup_size_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct resctrl_schema *schema;
> +	enum resctrl_conf_type type;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *r;
> +	struct rdt_domain *d;
> +	unsigned int size;
> +	int ret = 0;
> +	u32 closid;
> +	bool sep;
> +	u32 ctrl;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		rdtgroup_kn_unlock(of->kn);
> +		return -ENOENT;
> +	}
> +
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> +		if (!rdtgrp->plr->d) {
> +			rdt_last_cmd_clear();
> +			rdt_last_cmd_puts("Cache domain offline\n");
> +			ret = -ENODEV;
> +		} else {
> +			seq_printf(s, "%*s:", max_name_width,
> +				   rdtgrp->plr->s->name);
> +			size = rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
> +						    rdtgrp->plr->d,
> +						    rdtgrp->plr->cbm);
> +			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
> +		}
> +		goto out;
> +	}
> +
> +	closid = rdtgrp->closid;
> +
> +	list_for_each_entry(schema, &resctrl_schema_all, list) {
> +		r = schema->res;
> +		type = schema->conf_type;
> +		sep = false;
> +		seq_printf(s, "%*s:", max_name_width, schema->name);
> +		list_for_each_entry(d, &r->domains, list) {
> +			if (sep)
> +				seq_putc(s, ';');
> +			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +				size = 0;
> +			} else {
> +				if (is_mba_sc(r))
> +					ctrl = d->mbps_val[closid];
> +				else
> +					ctrl = resctrl_arch_get_config(r, d,
> +								       closid,
> +								       type);
> +				if (r->rid == RDT_RESOURCE_MBA ||
> +				    r->rid == RDT_RESOURCE_SMBA)
> +					size = ctrl;
> +				else
> +					size = rdtgroup_cbm_to_size(r, d, ctrl);
> +			}
> +			seq_printf(s, "%d=%u", d->id, size);
> +			sep = true;
> +		}
> +		seq_putc(s, '\n');
> +	}
> +
> +out:
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
> +static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
> +{
> +	smp_call_function_any(&mon_info->d->cpu_mask,
> +			      resctrl_arch_mon_event_config_read, mon_info, 1);
> +}
> +
> +static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
> +{
> +	struct resctrl_mon_config_info mon_info = {0};
> +	struct rdt_domain *dom;
> +	bool sep = false;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	list_for_each_entry(dom, &r->domains, list) {
> +		if (sep)
> +			seq_puts(s, ";");
> +
> +		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
> +		mon_info.r = r;
> +		mon_info.d = dom;
> +		mon_info.evtid = evtid;
> +		mondata_config_read(&mon_info);
> +
> +		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
> +		sep = true;
> +	}
> +	seq_puts(s, "\n");
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return 0;
> +}
> +
> +static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
> +				       struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	return 0;
> +}
> +
> +static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
> +				       struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return 0;
> +}
> +
> +static int mbm_config_write_domain(struct rdt_resource *r,
> +				   struct rdt_domain *d, u32 evtid, u32 val)
> +{
> +	struct resctrl_mon_config_info mon_info = {0};
> +
> +	/*
> +	 * Read the current config value first. If both are the same then
> +	 * no need to write it again.
> +	 */
> +	mon_info.r = r;
> +	mon_info.d = d;
> +	mon_info.evtid = evtid;
> +	mondata_config_read(&mon_info);
> +	if (mon_info.mon_config == val)
> +		return 0;
> +
> +	mon_info.mon_config = val;
> +
> +	/*
> +	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
> +	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> +	 * are scoped at the domain level. Writing any of these MSRs
> +	 * on one CPU is observed by all the CPUs in the domain.
> +	 */
> +	smp_call_function_any(&d->cpu_mask, resctrl_arch_mon_event_config_write,
> +			      &mon_info, 1);
> +	if (mon_info.err) {
> +		rdt_last_cmd_puts("Invalid event configuration\n");
> +		return mon_info.err;
> +	}
> +
> +	/*
> +	 * When an Event Configuration is changed, the bandwidth counters
> +	 * for all RMIDs and Events will be cleared by the hardware. The
> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> +	 * every RMID on the next read to any event for every RMID.
> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> +	 * cleared while it is tracked by the hardware. Clear the
> +	 * mbm_local and mbm_total counts for all the RMIDs.
> +	 */
> +	resctrl_arch_reset_rmid_all(r, d);
> +
> +	return 0;
> +}
> +
> +static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
> +{
> +	char *dom_str = NULL, *id_str;
> +	unsigned long dom_id, val;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +	id_str = strsep(&dom_str, "=");
> +
> +	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
> +		rdt_last_cmd_puts("Non-numeric event configuration value\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Value from user cannot be more than the supported set of events */
> +	if ((val & r->mbm_cfg_mask) != val) {
> +		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
> +				    r->mbm_cfg_mask);
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		if (d->id == dom_id) {
> +			err = mbm_config_write_domain(r, d, evtid, val);
> +			if (err)
> +				return err;
> +			goto next;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
> +					    char *buf, size_t nbytes,
> +					    loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	ret = mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
> +static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
> +					    char *buf, size_t nbytes,
> +					    loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	ret = mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
> +/* rdtgroup information files for one cache resource. */
> +static struct rftype res_common_files[] = {
> +	{
> +		.name		= "last_cmd_status",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_last_cmd_status_show,
> +		.fflags		= RFTYPE_TOP_INFO,
> +	},
> +	{
> +		.name		= "num_closids",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_num_closids_show,
> +		.fflags		= RFTYPE_CTRL_INFO,
> +	},
> +	{
> +		.name		= "mon_features",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_mon_features_show,
> +		.fflags		= RFTYPE_MON_INFO,
> +	},
> +	{
> +		.name		= "num_rmids",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_num_rmids_show,
> +		.fflags		= RFTYPE_MON_INFO,
> +	},
> +	{
> +		.name		= "cbm_mask",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_default_ctrl_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
> +	{
> +		.name		= "min_cbm_bits",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_min_cbm_bits_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
> +	{
> +		.name		= "shareable_bits",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_shareable_bits_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
> +	{
> +		.name		= "bit_usage",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_bit_usage_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
> +	{
> +		.name		= "min_bandwidth",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_min_bw_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
> +	},
> +	{
> +		.name		= "bandwidth_gran",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_bw_gran_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
> +	},
> +	{
> +		.name		= "delay_linear",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_delay_linear_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
> +	},
> +	/*
> +	 * Platform specific which (if any) capabilities are provided by
> +	 * thread_throttle_mode. Defer "fflags" initialization to platform
> +	 * discovery.
> +	 */
> +	{
> +		.name		= "thread_throttle_mode",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_thread_throttle_mode_show,
> +	},
> +	{
> +		.name		= "max_threshold_occupancy",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= max_threshold_occ_write,
> +		.seq_show	= max_threshold_occ_show,
> +		.fflags		= RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
> +	},
> +	{
> +		.name		= "mbm_total_bytes_config",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= mbm_total_bytes_config_show,
> +		.write		= mbm_total_bytes_config_write,
> +	},
> +	{
> +		.name		= "mbm_local_bytes_config",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= mbm_local_bytes_config_show,
> +		.write		= mbm_local_bytes_config_write,
> +	},
> +	{
> +		.name		= "cpus",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= rdtgroup_cpus_write,
> +		.seq_show	= rdtgroup_cpus_show,
> +		.fflags		= RFTYPE_BASE,
> +	},
> +	{
> +		.name		= "cpus_list",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= rdtgroup_cpus_write,
> +		.seq_show	= rdtgroup_cpus_show,
> +		.flags		= RFTYPE_FLAGS_CPUS_LIST,
> +		.fflags		= RFTYPE_BASE,
> +	},
> +	{
> +		.name		= "tasks",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= rdtgroup_tasks_write,
> +		.seq_show	= rdtgroup_tasks_show,
> +		.fflags		= RFTYPE_BASE,
> +	},
> +	{
> +		.name		= "mon_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_rmid_show,
> +		.fflags		= RFTYPE_MON_BASE | RFTYPE_DEBUG,
> +	},
> +	{
> +		.name		= "schemata",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= rdtgroup_schemata_write,
> +		.seq_show	= rdtgroup_schemata_show,
> +		.fflags		= RFTYPE_CTRL_BASE,
> +	},
> +	{
> +		.name		= "mode",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.write		= rdtgroup_mode_write,
> +		.seq_show	= rdtgroup_mode_show,
> +		.fflags		= RFTYPE_CTRL_BASE,
> +	},
> +	{
> +		.name		= "size",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_size_show,
> +		.fflags		= RFTYPE_CTRL_BASE,
> +	},
> +	{
> +		.name		= "sparse_masks",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_has_sparse_bitmasks_show,
> +		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
> +	{
> +		.name		= "ctrl_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_closid_show,
> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> +	},
> +
> +};
> +
> +static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
> +{
> +	struct rftype *rfts, *rft;
> +	int ret, len;
> +
> +	rfts = res_common_files;
> +	len = ARRAY_SIZE(res_common_files);
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (resctrl_debug)
> +		fflags |= RFTYPE_DEBUG;
> +
> +	for (rft = rfts; rft < rfts + len; rft++) {
> +		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
> +			ret = rdtgroup_add_file(kn, rft);
> +			if (ret)
> +				goto error;
> +		}
> +	}
> +
> +	return 0;
> +error:
> +	pr_warn("Failed to add %s, err=%d\n", rft->name, ret);
> +	while (--rft >= rfts) {
> +		if ((fflags & rft->fflags) == rft->fflags)
> +			kernfs_remove_by_name(kn, rft->name);
> +	}
> +	return ret;
> +}
> +
> +static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
> +{
> +	struct rftype *rfts, *rft;
> +	int len;
> +
> +	rfts = res_common_files;
> +	len = ARRAY_SIZE(res_common_files);
> +
> +	for (rft = rfts; rft < rfts + len; rft++) {
> +		if (!strcmp(rft->name, name))
> +			return rft;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void thread_throttle_mode_init(void)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> +	struct rftype *rft;
> +
> +	if (!r->alloc_capable ||
> +	    r->membw.throttle_mode == THREAD_THROTTLE_UNDEFINED)
> +		return;
> +
> +	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
> +	if (!rft)
> +		return;
> +
> +	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
> +}
> +
> +void mbm_config_rftype_init(const char *config)
> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_get_rftype_by_name(config);
> +	if (rft)
> +		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
> +}
> +
> +/**
> + * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
> + * @r: The resource group with which the file is associated.
> + * @name: Name of the file
> + *
> + * The permissions of named resctrl file, directory, or link are modified
> + * to not allow read, write, or execute by any user.
> + *
> + * WARNING: This function is intended to communicate to the user that the
> + * resctrl file has been locked down - that it is not relevant to the
> + * particular state the system finds itself in. It should not be relied
> + * on to protect from user access because after the file's permissions
> + * are restricted the user can still change the permissions using chmod
> + * from the command line.
> + *
> + * Return: 0 on success, <0 on failure.
> + */
> +int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name)
> +{
> +	struct iattr iattr = {.ia_valid = ATTR_MODE,};
> +	struct kernfs_node *kn;
> +	int ret = 0;
> +
> +	kn = kernfs_find_and_get_ns(r->kn, name, NULL);
> +	if (!kn)
> +		return -ENOENT;
> +
> +	switch (kernfs_type(kn)) {
> +	case KERNFS_DIR:
> +		iattr.ia_mode = S_IFDIR;
> +		break;
> +	case KERNFS_FILE:
> +		iattr.ia_mode = S_IFREG;
> +		break;
> +	case KERNFS_LINK:
> +		iattr.ia_mode = S_IFLNK;
> +		break;
> +	}
> +
> +	ret = kernfs_setattr(kn, &iattr);
> +	kernfs_put(kn);
> +	return ret;
> +}
> +
> +/**
> + * rdtgroup_kn_mode_restore - Restore user access to named resctrl file
> + * @r: The resource group with which the file is associated.
> + * @name: Name of the file
> + * @mask: Mask of permissions that should be restored
> + *
> + * Restore the permissions of the named file. If @name is a directory the
> + * permissions of its parent will be used.
> + *
> + * Return: 0 on success, <0 on failure.
> + */
> +int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
> +			     umode_t mask)
> +{
> +	struct iattr iattr = {.ia_valid = ATTR_MODE,};
> +	struct kernfs_node *kn, *parent;
> +	struct rftype *rfts, *rft;
> +	int ret, len;
> +
> +	rfts = res_common_files;
> +	len = ARRAY_SIZE(res_common_files);
> +
> +	for (rft = rfts; rft < rfts + len; rft++) {
> +		if (!strcmp(rft->name, name))
> +			iattr.ia_mode = rft->mode & mask;
> +	}
> +
> +	kn = kernfs_find_and_get_ns(r->kn, name, NULL);
> +	if (!kn)
> +		return -ENOENT;
> +
> +	switch (kernfs_type(kn)) {
> +	case KERNFS_DIR:
> +		parent = kernfs_get_parent(kn);
> +		if (parent) {
> +			iattr.ia_mode |= parent->mode;
> +			kernfs_put(parent);
> +		}
> +		iattr.ia_mode |= S_IFDIR;
> +		break;
> +	case KERNFS_FILE:
> +		iattr.ia_mode |= S_IFREG;
> +		break;
> +	case KERNFS_LINK:
> +		iattr.ia_mode |= S_IFLNK;
> +		break;
> +	}
> +
> +	ret = kernfs_setattr(kn, &iattr);
> +	kernfs_put(kn);
> +	return ret;
> +}
> +
> +static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
> +				      unsigned long fflags)
> +{
> +	struct kernfs_node *kn_subdir;
> +	int ret;
> +
> +	kn_subdir = kernfs_create_dir(kn_info, name,
> +				      kn_info->mode, priv);
> +	if (IS_ERR(kn_subdir))
> +		return PTR_ERR(kn_subdir);
> +
> +	ret = rdtgroup_kn_set_ugid(kn_subdir);
> +	if (ret)
> +		return ret;
> +
> +	ret = rdtgroup_add_files(kn_subdir, fflags);
> +	if (!ret)
> +		kernfs_activate(kn_subdir);
> +
> +	return ret;
> +}
> +
> +static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
> +{
> +	enum resctrl_res_level i;
> +	struct resctrl_schema *s;
> +	struct rdt_resource *r;
> +	unsigned long fflags;
> +	char name[32];
> +	int ret;
> +
> +	/* create the directory */
> +	kn_info = kernfs_create_dir(parent_kn, "info", parent_kn->mode, NULL);
> +	if (IS_ERR(kn_info))
> +		return PTR_ERR(kn_info);
> +
> +	ret = rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);
> +	if (ret)
> +		goto out_destroy;
> +
> +	/* loop over enabled controls, these are all alloc_capable */
> +	list_for_each_entry(s, &resctrl_schema_all, list) {
> +		r = s->res;
> +		fflags = r->fflags | RFTYPE_CTRL_INFO;
> +		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
> +		if (ret)
> +			goto out_destroy;
> +	}
> +
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->mon_capable)
> +			continue;
> +
> +		fflags =  r->fflags | RFTYPE_MON_INFO;
> +		sprintf(name, "%s_MON", r->name);
> +		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
> +		if (ret)
> +			goto out_destroy;
> +	}
> +
> +	ret = rdtgroup_kn_set_ugid(kn_info);
> +	if (ret)
> +		goto out_destroy;
> +
> +	kernfs_activate(kn_info);
> +
> +	return 0;
> +
> +out_destroy:
> +	kernfs_remove(kn_info);
> +	return ret;
> +}
> +
> +static int
> +mongroup_create_dir(struct kernfs_node *parent_kn, struct rdtgroup *prgrp,
> +		    char *name, struct kernfs_node **dest_kn)
> +{
> +	struct kernfs_node *kn;
> +	int ret;
> +
> +	/* create the directory */
> +	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
> +	if (IS_ERR(kn))
> +		return PTR_ERR(kn);
> +
> +	if (dest_kn)
> +		*dest_kn = kn;
> +
> +	ret = rdtgroup_kn_set_ugid(kn);
> +	if (ret)
> +		goto out_destroy;
> +
> +	kernfs_activate(kn);
> +
> +	return 0;
> +
> +out_destroy:
> +	kernfs_remove(kn);
> +	return ret;
> +}
> +
> +static inline bool is_mba_linear(void)
> +{
> +	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
> +}
> +
> +static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	int cpu = cpumask_any(&d->cpu_mask);
> +	int i;
> +
> +	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
> +				   GFP_KERNEL, cpu_to_node(cpu));
> +	if (!d->mbps_val)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_closid; i++)
> +		d->mbps_val[i] = MBA_MAX_MBPS;
> +
> +	return 0;
> +}
> +
> +static void mba_sc_domain_destroy(struct rdt_resource *r,
> +				  struct rdt_domain *d)
> +{
> +	kfree(d->mbps_val);
> +	d->mbps_val = NULL;
> +}
> +
> +/*
> + * MBA software controller is supported only if
> + * MBM is supported and MBA is in linear scale.
> + */
> +static bool supports_mba_mbps(void)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> +
> +	return (resctrl_arch_is_mbm_local_enabled() &&
> +		r->alloc_capable && is_mba_linear());
> +}
> +
> +/*
> + * Enable or disable the MBA software controller
> + * which helps user specify bandwidth in MBps.
> + */
> +static int set_mba_sc(bool mba_sc)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
> +	u32 num_closid = resctrl_arch_get_num_closid(r);
> +	struct rdt_domain *d;
> +	int i;
> +
> +	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
> +		return -EINVAL;
> +
> +	r->membw.mba_sc = mba_sc;
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		for (i = 0; i < num_closid; i++)
> +			d->mbps_val[i] = MBA_MAX_MBPS;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * We don't allow rdtgroup directories to be created anywhere
> + * except the root directory. Thus when looking for the rdtgroup
> + * structure for a kernfs node we are either looking at a directory,
> + * in which case the rdtgroup structure is pointed at by the "priv"
> + * field, otherwise we have a file, and need only look to the parent
> + * to find the rdtgroup.
> + */
> +static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
> +{
> +	if (kernfs_type(kn) == KERNFS_DIR) {
> +		/*
> +		 * All the resource directories use "kn->priv"
> +		 * to point to the "struct rdtgroup" for the
> +		 * resource. "info" and its subdirectories don't
> +		 * have rdtgroup structures, so return NULL here.
> +		 */
> +		if (kn == kn_info || kn->parent == kn_info)
> +			return NULL;
> +		else
> +			return kn->priv;
> +	} else {
> +		return kn->parent->priv;
> +	}
> +}
> +
> +static void rdtgroup_kn_get(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
> +{
> +	atomic_inc(&rdtgrp->waitcount);
> +	kernfs_break_active_protection(kn);
> +}
> +
> +static void rdtgroup_kn_put(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
> +{
> +	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
> +	    (rdtgrp->flags & RDT_DELETED)) {
> +		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> +		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
> +			rdtgroup_pseudo_lock_remove(rdtgrp);
> +		kernfs_unbreak_active_protection(kn);
> +		rdtgroup_remove(rdtgrp);
> +	} else {
> +		kernfs_unbreak_active_protection(kn);
> +	}
> +}
> +
> +struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
> +{
> +	struct rdtgroup *rdtgrp = kernfs_to_rdtgroup(kn);
> +
> +	if (!rdtgrp)
> +		return NULL;
> +
> +	rdtgroup_kn_get(rdtgrp, kn);
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	/* Was this group deleted while we waited? */
> +	if (rdtgrp->flags & RDT_DELETED)
> +		return NULL;
> +
> +	return rdtgrp;
> +}
> +
> +void rdtgroup_kn_unlock(struct kernfs_node *kn)
> +{
> +	struct rdtgroup *rdtgrp = kernfs_to_rdtgroup(kn);
> +
> +	if (!rdtgrp)
> +		return;
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	rdtgroup_kn_put(rdtgrp, kn);
> +}
> +
> +static int mkdir_mondata_all(struct kernfs_node *parent_kn,
> +			     struct rdtgroup *prgrp,
> +			     struct kernfs_node **mon_data_kn);
> +
> +static void rdt_disable_ctx(void)
> +{
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +	set_mba_sc(false);
> +
> +	resctrl_debug = false;
> +}
> +
> +static int rdt_enable_ctx(struct rdt_fs_context *ctx)
> +{
> +	int ret = 0;
> +
> +	if (ctx->enable_cdpl2) {
> +		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
> +		if (ret)
> +			goto out_done;
> +	}
> +
> +	if (ctx->enable_cdpl3) {
> +		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
> +		if (ret)
> +			goto out_cdpl2;
> +	}
> +
> +	if (ctx->enable_mba_mbps) {
> +		ret = set_mba_sc(true);
> +		if (ret)
> +			goto out_cdpl3;
> +	}
> +
> +	if (ctx->enable_debug)
> +		resctrl_debug = true;
> +
> +	return 0;
> +
> +out_cdpl3:
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +out_cdpl2:
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +out_done:
> +	return ret;
> +}
> +
> +static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type)
> +{
> +	struct resctrl_schema *s;
> +	const char *suffix = "";
> +	int ret, cl;
> +
> +	s = kzalloc(sizeof(*s), GFP_KERNEL);
> +	if (!s)
> +		return -ENOMEM;
> +
> +	s->res = r;
> +	s->num_closid = resctrl_arch_get_num_closid(r);
> +	if (resctrl_arch_get_cdp_enabled(r->rid))
> +		s->num_closid /= 2;
> +
> +	s->conf_type = type;
> +	switch (type) {
> +	case CDP_CODE:
> +		suffix = "CODE";
> +		break;
> +	case CDP_DATA:
> +		suffix = "DATA";
> +		break;
> +	case CDP_NONE:
> +		suffix = "";
> +		break;
> +	}
> +
> +	ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
> +	if (ret >= sizeof(s->name)) {
> +		kfree(s);
> +		return -EINVAL;
> +	}
> +
> +	cl = strlen(s->name);
> +
> +	/*
> +	 * If CDP is supported by this resource, but not enabled,
> +	 * include the suffix. This ensures the tabular format of the
> +	 * schemata file does not change between mounts of the filesystem.
> +	 */
> +	if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
> +		cl += 4;
> +
> +	if (cl > max_name_width)
> +		max_name_width = cl;
> +
> +	/*
> +	 * Choose a width for the resource data based on the resource that has
> +	 * widest name and cbm.
> +	 */
> +	max_data_width = max(max_data_width, r->data_width);
> +
> +	INIT_LIST_HEAD(&s->list);
> +	list_add(&s->list, &resctrl_schema_all);
> +
> +	return 0;
> +}
> +
> +static int schemata_list_create(void)
> +{
> +	enum resctrl_res_level i;
> +	struct rdt_resource *r;
> +	int ret = 0;
> +
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->alloc_capable)
> +			continue;
> +
> +		if (resctrl_arch_get_cdp_enabled(r->rid)) {
> +			ret = schemata_list_add(r, CDP_CODE);
> +			if (ret)
> +				break;
> +
> +			ret = schemata_list_add(r, CDP_DATA);
> +		} else {
> +			ret = schemata_list_add(r, CDP_NONE);
> +		}
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void schemata_list_destroy(void)
> +{
> +	struct resctrl_schema *s, *tmp;
> +
> +	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
> +		list_del(&s->list);
> +		kfree(s);
> +	}
> +}
> +
> +static int rdt_get_tree(struct fs_context *fc)
> +{
> +	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> +	unsigned long flags = RFTYPE_CTRL_BASE;
> +	struct rdt_domain *dom;
> +	int ret;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +	/*
> +	 * resctrl file system can only be mounted once.
> +	 */
> +	if (resctrl_mounted) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	ret = rdtgroup_setup_root(ctx);
> +	if (ret)
> +		goto out;
> +
> +	ret = rdt_enable_ctx(ctx);
> +	if (ret)
> +		goto out_root;
> +
> +	ret = schemata_list_create();
> +	if (ret) {
> +		schemata_list_destroy();
> +		goto out_ctx;
> +	}
> +
> +	closid_init();
> +
> +	if (resctrl_arch_mon_capable())
> +		flags |= RFTYPE_MON;
> +
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
> +	if (ret)
> +		goto out_schemata_free;
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +
> +	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
> +	if (ret < 0)
> +		goto out_schemata_free;
> +
> +	if (resctrl_arch_mon_capable()) {
> +		ret = mongroup_create_dir(rdtgroup_default.kn,
> +					  &rdtgroup_default, "mon_groups",
> +					  &kn_mongrp);
> +		if (ret < 0)
> +			goto out_info;
> +
> +		ret = mkdir_mondata_all(rdtgroup_default.kn,
> +					&rdtgroup_default, &kn_mondata);
> +		if (ret < 0)
> +			goto out_mongrp;
> +		rdtgroup_default.mon.mon_data_kn = kn_mondata;
> +	}
> +
> +	ret = rdt_pseudo_lock_init();
> +	if (ret)
> +		goto out_mondata;
> +
> +	ret = kernfs_get_tree(fc);
> +	if (ret < 0)
> +		goto out_psl;
> +
> +	if (resctrl_arch_alloc_capable())
> +		resctrl_arch_enable_alloc();
> +	if (resctrl_arch_mon_capable())
> +		resctrl_arch_enable_mon();
> +
> +	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
> +		resctrl_mounted = true;
> +
> +	if (resctrl_is_mbm_enabled()) {
> +		list_for_each_entry(dom, &l3->domains, list)
> +			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
> +						   RESCTRL_PICK_ANY_CPU);
> +	}
> +
> +	goto out;
> +
> +out_psl:
> +	rdt_pseudo_lock_release();
> +out_mondata:
> +	if (resctrl_arch_mon_capable())
> +		kernfs_remove(kn_mondata);
> +out_mongrp:
> +	if (resctrl_arch_mon_capable())
> +		kernfs_remove(kn_mongrp);
> +out_info:
> +	kernfs_remove(kn_info);
> +out_schemata_free:
> +	schemata_list_destroy();
> +out_ctx:
> +	rdt_disable_ctx();
> +out_root:
> +	rdtgroup_destroy_root();
> +out:
> +	rdt_last_cmd_clear();
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return ret;
> +}
> +
> +enum rdt_param {
> +	Opt_cdp,
> +	Opt_cdpl2,
> +	Opt_mba_mbps,
> +	Opt_debug,
> +	nr__rdt_params
> +};
> +
> +static const struct fs_parameter_spec rdt_fs_parameters[] = {
> +	fsparam_flag("cdp",		Opt_cdp),
> +	fsparam_flag("cdpl2",		Opt_cdpl2),
> +	fsparam_flag("mba_MBps",	Opt_mba_mbps),
> +	fsparam_flag("debug",		Opt_debug),
> +	{}
> +};
> +
> +static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, rdt_fs_parameters, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_cdp:
> +		ctx->enable_cdpl3 = true;
> +		return 0;
> +	case Opt_cdpl2:
> +		ctx->enable_cdpl2 = true;
> +		return 0;
> +	case Opt_mba_mbps:
> +		if (!supports_mba_mbps())
> +			return -EINVAL;
> +		ctx->enable_mba_mbps = true;
> +		return 0;
> +	case Opt_debug:
> +		ctx->enable_debug = true;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void rdt_fs_context_free(struct fs_context *fc)
> +{
> +	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> +
> +	kernfs_free_fs_context(fc);
> +	kfree(ctx);
> +}
> +
> +static const struct fs_context_operations rdt_fs_context_ops = {
> +	.free		= rdt_fs_context_free,
> +	.parse_param	= rdt_parse_param,
> +	.get_tree	= rdt_get_tree,
> +};
> +
> +static int rdt_init_fs_context(struct fs_context *fc)
> +{
> +	struct rdt_fs_context *ctx;
> +
> +	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
> +	fc->fs_private = &ctx->kfc;
> +	fc->ops = &rdt_fs_context_ops;
> +	put_user_ns(fc->user_ns);
> +	fc->user_ns = get_user_ns(&init_user_ns);
> +	fc->global = true;
> +	return 0;
> +}
> +
> +/*
> + * Move tasks from one to the other group. If @from is NULL, then all tasks
> + * in the systems are moved unconditionally (used for teardown).
> + *
> + * If @mask is not NULL the cpus on which moved tasks are running are set
> + * in that mask so the update smp function call is restricted to affected
> + * cpus.
> + */
> +static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
> +				 struct cpumask *mask)
> +{
> +	struct task_struct *p, *t;
> +
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(p, t) {
> +		if (!from || is_closid_match(t, from) ||
> +		    is_rmid_match(t, from)) {
> +			resctrl_arch_set_closid_rmid(t, to->closid,
> +						     to->mon.rmid);
> +
> +			/*
> +			 * Order the closid/rmid stores above before the loads
> +			 * in task_curr(). This pairs with the full barrier
> +			 * between the rq->curr update and
> +			 * resctrl_arch_sched_in() during context switch.
> +			 */
> +			smp_mb();
> +
> +			/*
> +			 * If the task is on a CPU, set the CPU in the mask.
> +			 * The detection is inaccurate as tasks might move or
> +			 * schedule before the smp function call takes place.
> +			 * In such a case the function call is pointless, but
> +			 * there is no other side effect.
> +			 */
> +			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
> +				cpumask_set_cpu(task_cpu(t), mask);
> +		}
> +	}
> +	read_unlock(&tasklist_lock);
> +}
> +
> +static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
> +{
> +	struct rdtgroup *sentry, *stmp;
> +	struct list_head *head;
> +
> +	head = &rdtgrp->mon.crdtgrp_list;
> +	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
> +		free_rmid(sentry->closid, sentry->mon.rmid);
> +		list_del(&sentry->mon.crdtgrp_list);
> +
> +		if (atomic_read(&sentry->waitcount) != 0)
> +			sentry->flags = RDT_DELETED;
> +		else
> +			rdtgroup_remove(sentry);
> +	}
> +}
> +
> +/*
> + * Forcibly remove all of subdirectories under root.
> + */
> +static void rmdir_all_sub(void)
> +{
> +	struct rdtgroup *rdtgrp, *tmp;
> +
> +	/* Move all tasks to the default resource group */
> +	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
> +
> +	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
> +		/* Free any child rmids */
> +		free_all_child_rdtgrp(rdtgrp);
> +
> +		/* Remove each rdtgroup other than root */
> +		if (rdtgrp == &rdtgroup_default)
> +			continue;
> +
> +		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> +		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
> +			rdtgroup_pseudo_lock_remove(rdtgrp);
> +
> +		/*
> +		 * Give any CPUs back to the default group. We cannot copy
> +		 * cpu_online_mask because a CPU might have executed the
> +		 * offline callback already, but is still marked online.
> +		 */
> +		cpumask_or(&rdtgroup_default.cpu_mask,
> +			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
> +
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +
> +		kernfs_remove(rdtgrp->kn);
> +		list_del(&rdtgrp->rdtgroup_list);
> +
> +		if (atomic_read(&rdtgrp->waitcount) != 0)
> +			rdtgrp->flags = RDT_DELETED;
> +		else
> +			rdtgroup_remove(rdtgrp);
> +	}
> +	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
> +	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
> +
> +	kernfs_remove(kn_info);
> +	kernfs_remove(kn_mongrp);
> +	kernfs_remove(kn_mondata);
> +}
> +
> +static void rdt_kill_sb(struct super_block *sb)
> +{
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_disable_ctx();
> +
> +	/* Put everything back to default values. */
> +	resctrl_arch_reset_resources();
> +
> +	rmdir_all_sub();
> +	rdt_pseudo_lock_release();
> +	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
> +	schemata_list_destroy();
> +	rdtgroup_destroy_root();
> +	if (resctrl_arch_alloc_capable())
> +		resctrl_arch_disable_alloc();
> +	if (resctrl_arch_mon_capable())
> +		resctrl_arch_disable_mon();
> +	resctrl_mounted = false;
> +	kernfs_kill_sb(sb);
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +}
> +
> +static struct file_system_type rdt_fs_type = {
> +	.name			= "resctrl",
> +	.init_fs_context	= rdt_init_fs_context,
> +	.parameters		= rdt_fs_parameters,
> +	.kill_sb		= rdt_kill_sb,
> +};
> +
> +static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
> +		       void *priv)
> +{
> +	struct kernfs_node *kn;
> +	int ret = 0;
> +
> +	kn = __kernfs_create_file(parent_kn, name, 0444,
> +				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> +				  &kf_mondata_ops, priv, NULL, NULL);
> +	if (IS_ERR(kn))
> +		return PTR_ERR(kn);
> +
> +	ret = rdtgroup_kn_set_ugid(kn);
> +	if (ret) {
> +		kernfs_remove(kn);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Remove all subdirectories of mon_data of ctrl_mon groups
> + * and monitor groups with given domain id.
> + */
> +static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> +					   unsigned int dom_id)
> +{
> +	struct rdtgroup *prgrp, *crgrp;
> +	char name[32];
> +
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		sprintf(name, "mon_%s_%02d", r->name, dom_id);
> +		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
> +
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> +			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
> +	}
> +}
> +
> +static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
> +				struct rdt_domain *d,
> +				struct rdt_resource *r, struct rdtgroup *prgrp)
> +{
> +	union mon_data_bits priv;
> +	struct kernfs_node *kn;
> +	struct mon_evt *mevt;
> +	struct rmid_read rr;
> +	char name[32];
> +	int ret;
> +
> +	sprintf(name, "mon_%s_%02d", r->name, d->id);
> +	/* create the directory */
> +	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
> +	if (IS_ERR(kn))
> +		return PTR_ERR(kn);
> +
> +	ret = rdtgroup_kn_set_ugid(kn);
> +	if (ret)
> +		goto out_destroy;
> +
> +	if (WARN_ON(list_empty(&r->evt_list))) {
> +		ret = -EPERM;
> +		goto out_destroy;
> +	}
> +
> +	priv.u.rid = r->rid;
> +	priv.u.domid = d->id;
> +	list_for_each_entry(mevt, &r->evt_list, list) {
> +		priv.u.evtid = mevt->evtid;
> +		ret = mon_addfile(kn, mevt->name, priv.priv);
> +		if (ret)
> +			goto out_destroy;
> +
> +		if (resctrl_is_mbm_event(mevt->evtid))
> +			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
> +	}
> +	kernfs_activate(kn);
> +	return 0;
> +
> +out_destroy:
> +	kernfs_remove(kn);
> +	return ret;
> +}
> +
> +/*
> + * Add all subdirectories of mon_data for "ctrl_mon" groups
> + * and "monitor" groups with given domain id.
> + */
> +static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> +					   struct rdt_domain *d)
> +{
> +	struct kernfs_node *parent_kn;
> +	struct rdtgroup *prgrp, *crgrp;
> +	struct list_head *head;
> +
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		parent_kn = prgrp->mon.mon_data_kn;
> +		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
> +
> +		head = &prgrp->mon.crdtgrp_list;
> +		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
> +			parent_kn = crgrp->mon.mon_data_kn;
> +			mkdir_mondata_subdir(parent_kn, d, r, crgrp);
> +		}
> +	}
> +}
> +
> +static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
> +				       struct rdt_resource *r,
> +				       struct rdtgroup *prgrp)
> +{
> +	struct rdt_domain *dom;
> +	int ret;
> +
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
> +	list_for_each_entry(dom, &r->domains, list) {
> +		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * This creates a directory mon_data which contains the monitored data.
> + *
> + * mon_data has one directory for each domain which are named
> + * in the format mon_<domain_name>_<domain_id>. For ex: A mon_data
> + * with L3 domain looks as below:
> + * ./mon_data:
> + * mon_L3_00
> + * mon_L3_01
> + * mon_L3_02
> + * ...
> + *
> + * Each domain directory has one file per event:
> + * ./mon_L3_00/:
> + * llc_occupancy
> + *
> + */
> +static int mkdir_mondata_all(struct kernfs_node *parent_kn,
> +			     struct rdtgroup *prgrp,
> +			     struct kernfs_node **dest_kn)
> +{
> +	enum resctrl_res_level i;
> +	struct rdt_resource *r;
> +	struct kernfs_node *kn;
> +	int ret;
> +
> +	/*
> +	 * Create the mon_data directory first.
> +	 */
> +	ret = mongroup_create_dir(parent_kn, prgrp, "mon_data", &kn);
> +	if (ret)
> +		return ret;
> +
> +	if (dest_kn)
> +		*dest_kn = kn;
> +
> +	/*
> +	 * Create the subdirectories for each domain. Note that all events
> +	 * in a domain like L3 are grouped into a resource whose domain is L3
> +	 */
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		r = resctrl_arch_get_resource(i);
> +		if (!r->mon_capable)
> +			continue;
> +
> +		ret = mkdir_mondata_subdir_alldom(kn, r, prgrp);
> +		if (ret)
> +			goto out_destroy;
> +	}
> +
> +	return 0;
> +
> +out_destroy:
> +	kernfs_remove(kn);
> +	return ret;
> +}
> +
> +/**
> + * cbm_ensure_valid - Enforce validity on provided CBM
> + * @_val:	Candidate CBM
> + * @r:		RDT resource to which the CBM belongs
> + *
> + * The provided CBM represents all cache portions available for use. This
> + * may be represented by a bitmap that does not consist of contiguous ones
> + * and thus be an invalid CBM.
> + * Here the provided CBM is forced to be a valid CBM by only considering
> + * the first set of contiguous bits as valid and clearing all bits.
> + * The intention here is to provide a valid default CBM with which a new
> + * resource group is initialized. The user can follow this with a
> + * modification to the CBM if the default does not satisfy the
> + * requirements.
> + */
> +static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
> +{
> +	unsigned int cbm_len = r->cache.cbm_len;
> +	unsigned long first_bit, zero_bit;
> +	unsigned long val = _val;
> +
> +	if (!val)
> +		return 0;
> +
> +	first_bit = find_first_bit(&val, cbm_len);
> +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> +
> +	/* Clear any remaining bits to ensure contiguous region */
> +	bitmap_clear(&val, zero_bit, cbm_len - zero_bit);
> +	return (u32)val;
> +}
> +
> +/*
> + * Initialize cache resources per RDT domain
> + *
> + * Set the RDT domain up to start off with all usable allocations. That is,
> + * all shareable and unused bits. All-zero CBM is invalid.
> + */
> +static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
> +				 u32 closid)
> +{
> +	enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
> +	enum resctrl_conf_type t = s->conf_type;
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_resource *r = s->res;
> +	u32 used_b = 0, unused_b = 0;
> +	unsigned long tmp_cbm;
> +	enum rdtgrp_mode mode;
> +	u32 peer_ctl, ctrl_val;
> +	int i;
> +
> +	cfg = &d->staged_config[t];
> +	cfg->have_new_ctrl = false;
> +	cfg->new_ctrl = r->cache.shareable_bits;
> +	used_b = r->cache.shareable_bits;
> +	for (i = 0; i < closids_supported(); i++) {
> +		if (closid_allocated(i) && i != closid) {
> +			mode = rdtgroup_mode_by_closid(i);
> +			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
> +				/*
> +				 * ctrl values for locksetup aren't relevant
> +				 * until the schemata is written, and the mode
> +				 * becomes RDT_MODE_PSEUDO_LOCKED.
> +				 */
> +				continue;
> +			/*
> +			 * If CDP is active include peer domain's
> +			 * usage to ensure there is no overlap
> +			 * with an exclusive group.
> +			 */
> +			if (resctrl_arch_get_cdp_enabled(r->rid))
> +				peer_ctl = resctrl_arch_get_config(r, d, i,
> +								   peer_type);
> +			else
> +				peer_ctl = 0;
> +			ctrl_val = resctrl_arch_get_config(r, d, i,
> +							   s->conf_type);
> +			used_b |= ctrl_val | peer_ctl;
> +			if (mode == RDT_MODE_SHAREABLE)
> +				cfg->new_ctrl |= ctrl_val | peer_ctl;
> +		}
> +	}
> +	if (d->plr && d->plr->cbm > 0)
> +		used_b |= d->plr->cbm;
> +	unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
> +	unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
> +	cfg->new_ctrl |= unused_b;
> +	/*
> +	 * Force the initial CBM to be valid, user can
> +	 * modify the CBM based on system availability.
> +	 */
> +	cfg->new_ctrl = cbm_ensure_valid(cfg->new_ctrl, r);
> +	/*
> +	 * Assign the u32 CBM to an unsigned long to ensure that
> +	 * bitmap_weight() does not access out-of-bound memory.
> +	 */
> +	tmp_cbm = cfg->new_ctrl;
> +	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
> +		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
> +		return -ENOSPC;
> +	}
> +	cfg->have_new_ctrl = true;
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize cache resources with default values.
> + *
> + * A new RDT group is being created on an allocation capable (CAT)
> + * supporting system. Set this group up to start off with all usable
> + * allocations.
> + *
> + * If there are no more shareable bits available on any domain then
> + * the entire allocation will fail.
> + */
> +static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
> +{
> +	struct rdt_domain *d;
> +	int ret;
> +
> +	list_for_each_entry(d, &s->res->domains, list) {
> +		ret = __init_one_rdt_domain(d, s, closid);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Initialize MBA resource with default values. */
> +static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
> +{
> +	struct resctrl_staged_config *cfg;
> +	struct rdt_domain *d;
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		if (is_mba_sc(r)) {
> +			d->mbps_val[closid] = MBA_MAX_MBPS;
> +			continue;
> +		}
> +
> +		cfg = &d->staged_config[CDP_NONE];
> +		cfg->new_ctrl = r->default_ctrl;
> +		cfg->have_new_ctrl = true;
> +	}
> +}
> +
> +/* Initialize the RDT group's allocations. */
> +static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
> +{
> +	struct resctrl_schema *s;
> +	struct rdt_resource *r;
> +	int ret = 0;
> +
> +	rdt_staged_configs_clear();
> +
> +	list_for_each_entry(s, &resctrl_schema_all, list) {
> +		r = s->res;
> +		if (r->rid == RDT_RESOURCE_MBA ||
> +		    r->rid == RDT_RESOURCE_SMBA) {
> +			rdtgroup_init_mba(r, rdtgrp->closid);
> +			if (is_mba_sc(r))
> +				continue;
> +		} else {
> +			ret = rdtgroup_init_cat(s, rdtgrp->closid);
> +			if (ret < 0)
> +				goto out;
> +		}
> +
> +		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
> +		if (ret < 0) {
> +			rdt_last_cmd_puts("Failed to initialize allocations\n");
> +			goto out;
> +		}
> +
> +	}
> +
> +	rdtgrp->mode = RDT_MODE_SHAREABLE;
> +
> +out:
> +	rdt_staged_configs_clear();
> +	return ret;
> +}
> +
> +static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
> +{
> +	int ret;
> +
> +	if (!resctrl_arch_mon_capable())
> +		return 0;
> +
> +	ret = alloc_rmid(rdtgrp->closid);
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("Out of RMIDs\n");
> +		return ret;
> +	}
> +	rdtgrp->mon.rmid = ret;
> +
> +	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
> +	if (ret) {
> +		rdt_last_cmd_puts("kernfs subdir error\n");
> +		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
> +{
> +	if (resctrl_arch_mon_capable())
> +		free_rmid(rgrp->closid, rgrp->mon.rmid);
> +}
> +
> +static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
> +			     const char *name, umode_t mode,
> +			     enum rdt_group_type rtype, struct rdtgroup **r)
> +{
> +	struct rdtgroup *prdtgrp, *rdtgrp;
> +	unsigned long files = 0;
> +	struct kernfs_node *kn;
> +	int ret;
> +
> +	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
> +	if (!prdtgrp) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	if (rtype == RDTMON_GROUP &&
> +	    (prdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> +	     prdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)) {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> +		goto out_unlock;
> +	}
> +
> +	/* allocate the rdtgroup. */
> +	rdtgrp = kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
> +	if (!rdtgrp) {
> +		ret = -ENOSPC;
> +		rdt_last_cmd_puts("Kernel out of memory\n");
> +		goto out_unlock;
> +	}
> +	*r = rdtgrp;
> +	rdtgrp->mon.parent = prdtgrp;
> +	rdtgrp->type = rtype;
> +	INIT_LIST_HEAD(&rdtgrp->mon.crdtgrp_list);
> +
> +	/* kernfs creates the directory for rdtgrp */
> +	kn = kernfs_create_dir(parent_kn, name, mode, rdtgrp);
> +	if (IS_ERR(kn)) {
> +		ret = PTR_ERR(kn);
> +		rdt_last_cmd_puts("kernfs create error\n");
> +		goto out_free_rgrp;
> +	}
> +	rdtgrp->kn = kn;
> +
> +	/*
> +	 * kernfs_remove() will drop the reference count on "kn" which
> +	 * will free it. But we still need it to stick around for the
> +	 * rdtgroup_kn_unlock(kn) call. Take one extra reference here,
> +	 * which will be dropped by kernfs_put() in rdtgroup_remove().
> +	 */
> +	kernfs_get(kn);
> +
> +	ret = rdtgroup_kn_set_ugid(kn);
> +	if (ret) {
> +		rdt_last_cmd_puts("kernfs perm error\n");
> +		goto out_destroy;
> +	}
> +
> +	if (rtype == RDTCTRL_GROUP) {
> +		files = RFTYPE_BASE | RFTYPE_CTRL;
> +		if (resctrl_arch_mon_capable())
> +			files |= RFTYPE_MON;
> +	} else {
> +		files = RFTYPE_BASE | RFTYPE_MON;
> +	}
> +
> +	ret = rdtgroup_add_files(kn, files);
> +	if (ret) {
> +		rdt_last_cmd_puts("kernfs fill error\n");
> +		goto out_destroy;
> +	}
> +
> +	/*
> +	 * The caller unlocks the parent_kn upon success.
> +	 */
> +	return 0;
> +
> +out_destroy:
> +	kernfs_put(rdtgrp->kn);
> +	kernfs_remove(rdtgrp->kn);
> +out_free_rgrp:
> +	kfree(rdtgrp);
> +out_unlock:
> +	rdtgroup_kn_unlock(parent_kn);
> +	return ret;
> +}
> +
> +static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
> +{
> +	kernfs_remove(rgrp->kn);
> +	rdtgroup_remove(rgrp);
> +}
> +
> +/*
> + * Create a monitor group under "mon_groups" directory of a control
> + * and monitor group(ctrl_mon). This is a resource group
> + * to monitor a subset of tasks and cpus in its parent ctrl_mon group.
> + */
> +static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
> +			      const char *name, umode_t mode)
> +{
> +	struct rdtgroup *rdtgrp, *prgrp;
> +	int ret;
> +
> +	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
> +	if (ret)
> +		return ret;
> +
> +	prgrp = rdtgrp->mon.parent;
> +	rdtgrp->closid = prgrp->closid;
> +
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret) {
> +		mkdir_rdt_prepare_clean(rdtgrp);
> +		goto out_unlock;
> +	}
> +
> +	kernfs_activate(rdtgrp->kn);
> +
> +	/*
> +	 * Add the rdtgrp to the list of rdtgrps the parent
> +	 * ctrl_mon group has to track.
> +	 */
> +	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
> +
> +out_unlock:
> +	rdtgroup_kn_unlock(parent_kn);
> +	return ret;
> +}
> +
> +/*
> + * These are rdtgroups created under the root directory. Can be used
> + * to allocate and monitor resources.
> + */
> +static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
> +				   const char *name, umode_t mode)
> +{
> +	struct rdtgroup *rdtgrp;
> +	struct kernfs_node *kn;
> +	u32 closid;
> +	int ret;
> +
> +	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTCTRL_GROUP, &rdtgrp);
> +	if (ret)
> +		return ret;
> +
> +	kn = rdtgrp->kn;
> +	ret = closid_alloc();
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("Out of CLOSIDs\n");
> +		goto out_common_fail;
> +	}
> +	closid = ret;
> +	ret = 0;
> +
> +	rdtgrp->closid = closid;
> +
> +	ret = mkdir_rdt_prepare_rmid_alloc(rdtgrp);
> +	if (ret)
> +		goto out_closid_free;
> +
> +	kernfs_activate(rdtgrp->kn);
> +
> +	ret = rdtgroup_init_alloc(rdtgrp);
> +	if (ret < 0)
> +		goto out_rmid_free;
> +
> +	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
> +
> +	if (resctrl_arch_mon_capable()) {
> +		/*
> +		 * Create an empty mon_groups directory to hold the subset
> +		 * of tasks and cpus to monitor.
> +		 */
> +		ret = mongroup_create_dir(kn, rdtgrp, "mon_groups", NULL);
> +		if (ret) {
> +			rdt_last_cmd_puts("kernfs subdir error\n");
> +			goto out_del_list;
> +		}
> +	}
> +
> +	goto out_unlock;
> +
> +out_del_list:
> +	list_del(&rdtgrp->rdtgroup_list);
> +out_rmid_free:
> +	mkdir_rdt_prepare_rmid_free(rdtgrp);
> +out_closid_free:
> +	closid_free(closid);
> +out_common_fail:
> +	mkdir_rdt_prepare_clean(rdtgrp);
> +out_unlock:
> +	rdtgroup_kn_unlock(parent_kn);
> +	return ret;
> +}
> +
> +/*
> + * We allow creating mon groups only with in a directory called "mon_groups"
> + * which is present in every ctrl_mon group. Check if this is a valid
> + * "mon_groups" directory.
> + *
> + * 1. The directory should be named "mon_groups".
> + * 2. The mon group itself should "not" be named "mon_groups".
> + *   This makes sure "mon_groups" directory always has a ctrl_mon group
> + *   as parent.
> + */
> +static bool is_mon_groups(struct kernfs_node *kn, const char *name)
> +{
> +	return (!strcmp(kn->name, "mon_groups") &&
> +		strcmp(name, "mon_groups"));
> +}
> +
> +static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
> +			  umode_t mode)
> +{
> +	/* Do not accept '\n' to avoid unparsable situation. */
> +	if (strchr(name, '\n'))
> +		return -EINVAL;
> +
> +	/*
> +	 * If the parent directory is the root directory and RDT
> +	 * allocation is supported, add a control and monitoring
> +	 * subdirectory
> +	 */
> +	if (resctrl_arch_alloc_capable() && parent_kn == rdtgroup_default.kn)
> +		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
> +
> +	/*
> +	 * If RDT monitoring is supported and the parent directory is a valid
> +	 * "mon_groups" directory, add a monitoring subdirectory.
> +	 */
> +	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
> +		return rdtgroup_mkdir_mon(parent_kn, name, mode);
> +
> +	return -EPERM;
> +}
> +
> +static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> +{
> +	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +	u32 closid, rmid;
> +	int cpu;
> +
> +	/* Give any tasks back to the parent group */
> +	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
> +
> +	/* Update per cpu rmid of the moved CPUs first */
> +	closid = rdtgrp->closid;
> +	rmid = prdtgrp->mon.rmid;
> +	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> +		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
> +
> +	/*
> +	 * Update the MSR on moved CPUs and CPUs which have moved
> +	 * task running on them.
> +	 */
> +	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> +	update_closid_rmid(tmpmask, NULL);
> +
> +	rdtgrp->flags = RDT_DELETED;
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +
> +	/*
> +	 * Remove the rdtgrp from the parent ctrl_mon group's list
> +	 */
> +	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> +	list_del(&rdtgrp->mon.crdtgrp_list);
> +
> +	kernfs_remove(rdtgrp->kn);
> +
> +	return 0;
> +}
> +
> +static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
> +{
> +	rdtgrp->flags = RDT_DELETED;
> +	list_del(&rdtgrp->rdtgroup_list);
> +
> +	kernfs_remove(rdtgrp->kn);
> +	return 0;
> +}
> +
> +static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> +{
> +	u32 closid, rmid;
> +	int cpu;
> +
> +	/* Give any tasks back to the default group */
> +	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
> +
> +	/* Give any CPUs back to the default group */
> +	cpumask_or(&rdtgroup_default.cpu_mask,
> +		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
> +
> +	/* Update per cpu closid and rmid of the moved CPUs first */
> +	closid = rdtgroup_default.closid;
> +	rmid = rdtgroup_default.mon.rmid;
> +	for_each_cpu(cpu, &rdtgrp->cpu_mask)
> +		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
> +
> +	/*
> +	 * Update the MSR on moved CPUs and CPUs which have moved
> +	 * task running on them.
> +	 */
> +	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> +	update_closid_rmid(tmpmask, NULL);
> +
> +	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
> +	closid_free(rdtgrp->closid);
> +
> +	rdtgroup_ctrl_remove(rdtgrp);
> +
> +	/*
> +	 * Free all the child monitor group rmids.
> +	 */
> +	free_all_child_rdtgrp(rdtgrp);
> +
> +	return 0;
> +}
> +
> +static int rdtgroup_rmdir(struct kernfs_node *kn)
> +{
> +	struct kernfs_node *parent_kn = kn->parent;
> +	struct rdtgroup *rdtgrp;
> +	cpumask_var_t tmpmask;
> +	int ret = 0;
> +
> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(kn);
> +	if (!rdtgrp) {
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If the rdtgroup is a ctrl_mon group and parent directory
> +	 * is the root directory, remove the ctrl_mon group.
> +	 *
> +	 * If the rdtgroup is a mon group and parent directory
> +	 * is a valid "mon_groups" directory, remove the mon group.
> +	 */
> +	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn &&
> +	    rdtgrp != &rdtgroup_default) {
> +		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
> +		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
> +			ret = rdtgroup_ctrl_remove(rdtgrp);
> +		} else {
> +			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
> +		}
> +	} else if (rdtgrp->type == RDTMON_GROUP &&
> +		 is_mon_groups(parent_kn, kn->name)) {
> +		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
> +	} else {
> +		ret = -EPERM;
> +	}
> +
> +out:
> +	rdtgroup_kn_unlock(kn);
> +	free_cpumask_var(tmpmask);
> +	return ret;
> +}
> +
> +/**
> + * mongrp_reparent() - replace parent CTRL_MON group of a MON group
> + * @rdtgrp:		the MON group whose parent should be replaced
> + * @new_prdtgrp:	replacement parent CTRL_MON group for @rdtgrp
> + * @cpus:		cpumask provided by the caller for use during this call
> + *
> + * Replaces the parent CTRL_MON group for a MON group, resulting in all member
> + * tasks' CLOSID immediately changing to that of the new parent group.
> + * Monitoring data for the group is unaffected by this operation.
> + */
> +static void mongrp_reparent(struct rdtgroup *rdtgrp,
> +			    struct rdtgroup *new_prdtgrp,
> +			    cpumask_var_t cpus)
> +{
> +	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +
> +	WARN_ON(rdtgrp->type != RDTMON_GROUP);
> +	WARN_ON(new_prdtgrp->type != RDTCTRL_GROUP);
> +
> +	/* Nothing to do when simply renaming a MON group. */
> +	if (prdtgrp == new_prdtgrp)
> +		return;
> +
> +	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> +	list_move_tail(&rdtgrp->mon.crdtgrp_list,
> +		       &new_prdtgrp->mon.crdtgrp_list);
> +
> +	rdtgrp->mon.parent = new_prdtgrp;
> +	rdtgrp->closid = new_prdtgrp->closid;
> +
> +	/* Propagate updated closid to all tasks in this group. */
> +	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
> +
> +	update_closid_rmid(cpus, NULL);
> +}
> +
> +static int rdtgroup_rename(struct kernfs_node *kn,
> +			   struct kernfs_node *new_parent, const char *new_name)
> +{
> +	struct rdtgroup *new_prdtgrp;
> +	struct rdtgroup *rdtgrp;
> +	cpumask_var_t tmpmask;
> +	int ret;
> +
> +	rdtgrp = kernfs_to_rdtgroup(kn);
> +	new_prdtgrp = kernfs_to_rdtgroup(new_parent);
> +	if (!rdtgrp || !new_prdtgrp)
> +		return -ENOENT;
> +
> +	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
> +	rdtgroup_kn_get(rdtgrp, kn);
> +	rdtgroup_kn_get(new_prdtgrp, new_parent);
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	/*
> +	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
> +	 * either kernfs_node is a file.
> +	 */
> +	if (kernfs_type(kn) != KERNFS_DIR ||
> +	    kernfs_type(new_parent) != KERNFS_DIR) {
> +		rdt_last_cmd_puts("Source and destination must be directories");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (rdtgrp->type != RDTMON_GROUP || !kn->parent ||
> +	    !is_mon_groups(kn->parent, kn->name)) {
> +		rdt_last_cmd_puts("Source must be a MON group\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	if (!is_mon_groups(new_parent, new_name)) {
> +		rdt_last_cmd_puts("Destination must be a mon_groups subdirectory\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
> +	 * current parent CTRL_MON group and therefore cannot be assigned to
> +	 * the new parent, making the move illegal.
> +	 */
> +	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
> +	    rdtgrp->mon.parent != new_prdtgrp) {
> +		rdt_last_cmd_puts("Cannot move a MON group that monitors CPUs\n");
> +		ret = -EPERM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
> +	 * possibility of failing to allocate it after kernfs_rename() has
> +	 * succeeded.
> +	 */
> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Perform all input validation and allocations needed to ensure
> +	 * mongrp_reparent() will succeed before calling kernfs_rename(),
> +	 * otherwise it would be necessary to revert this call if
> +	 * mongrp_reparent() failed.
> +	 */
> +	ret = kernfs_rename(kn, new_parent, new_name);
> +	if (!ret)
> +		mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
> +
> +	free_cpumask_var(tmpmask);
> +
> +out:
> +	mutex_unlock(&rdtgroup_mutex);
> +	rdtgroup_kn_put(rdtgrp, kn);
> +	rdtgroup_kn_put(new_prdtgrp, new_parent);
> +	return ret;
> +}
> +
> +static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
> +{
> +	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> +		seq_puts(seq, ",cdp");
> +
> +	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
> +		seq_puts(seq, ",cdpl2");
> +
> +	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
> +		seq_puts(seq, ",mba_MBps");
> +
> +	if (resctrl_debug)
> +		seq_puts(seq, ",debug");
> +
> +	return 0;
> +}
> +
> +static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
> +	.mkdir		= rdtgroup_mkdir,
> +	.rmdir		= rdtgroup_rmdir,
> +	.rename		= rdtgroup_rename,
> +	.show_options	= rdtgroup_show_options,
> +};
> +
> +static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
> +{
> +	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
> +				      KERNFS_ROOT_CREATE_DEACTIVATED |
> +				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
> +				      &rdtgroup_default);
> +	if (IS_ERR(rdt_root))
> +		return PTR_ERR(rdt_root);
> +
> +	ctx->kfc.root = rdt_root;
> +	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> +
> +	return 0;
> +}
> +
> +static void rdtgroup_destroy_root(void)
> +{
> +	kernfs_destroy_root(rdt_root);
> +	rdtgroup_default.kn = NULL;
> +}
> +
> +static void rdtgroup_setup_default(void)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
> +	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
> +	rdtgroup_default.type = RDTCTRL_GROUP;
> +	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
> +
> +	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
> +static void domain_destroy_mon_state(struct rdt_domain *d)
> +{
> +	bitmap_free(d->rmid_busy_llc);
> +	kfree(d->mbm_total);
> +	kfree(d->mbm_local);
> +}
> +
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
> +		mba_sc_domain_destroy(r, d);
> +
> +	if (!r->mon_capable)
> +		goto out_unlock;
> +
> +	/*
> +	 * If resctrl is mounted, remove all the
> +	 * per domain monitor data directories.
> +	 */
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
> +		rmdir_mondata_subdir_allrdtgrp(r, d->id);
> +
> +	if (resctrl_is_mbm_enabled())
> +		cancel_delayed_work(&d->mbm_over);
> +	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
> +		/*
> +		 * When a package is going down, forcefully
> +		 * decrement rmid->ebusy. There is no way to know
> +		 * that the L3 was flushed and hence may lead to
> +		 * incorrect counts in rare scenarios, but leaving
> +		 * the RMID as busy creates RMID leaks if the
> +		 * package never comes back.
> +		 */
> +		__check_limbo(d, true);
> +		cancel_delayed_work(&d->cqm_limbo);
> +	}
> +
> +	domain_destroy_mon_state(d);
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
> +static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> +	size_t tsize;
> +
> +	if (resctrl_arch_is_llc_occupancy_enabled()) {
> +		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
> +		if (!d->rmid_busy_llc)
> +			return -ENOMEM;
> +	}
> +	if (resctrl_arch_is_mbm_total_enabled()) {
> +		tsize = sizeof(*d->mbm_total);
> +		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
> +		if (!d->mbm_total) {
> +			bitmap_free(d->rmid_busy_llc);
> +			return -ENOMEM;
> +		}
> +	}
> +	if (resctrl_arch_is_mbm_local_enabled()) {
> +		tsize = sizeof(*d->mbm_local);
> +		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
> +		if (!d->mbm_local) {
> +			bitmap_free(d->rmid_busy_llc);
> +			kfree(d->mbm_total);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	int err = 0;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA) {
> +		/* RDT_RESOURCE_MBA is never mon_capable */
> +		err = mba_sc_domain_allocate(r, d);
> +		goto out_unlock;
> +	}
> +
> +	if (!r->mon_capable)
> +		goto out_unlock;
> +
> +	err = domain_setup_mon_state(r, d);
> +	if (err)
> +		goto out_unlock;
> +
> +	if (resctrl_is_mbm_enabled()) {
> +		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> +		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
> +					   RESCTRL_PICK_ANY_CPU);
> +	}
> +
> +	if (resctrl_arch_is_llc_occupancy_enabled())
> +		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
> +
> +	/*
> +	 * If the filesystem is not mounted then only the default resource group
> +	 * exists. Creation of its directories is deferred until mount time
> +	 * by rdt_get_tree() calling mkdir_mondata_all().
> +	 * If resctrl is mounted, add per domain monitor data directories.
> +	 */
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
> +		mkdir_mondata_subdir_allrdtgrp(r, d);
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return err;
> +}
> +
> +void resctrl_online_cpu(unsigned int cpu)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +	/* The CPU is set in default rdtgroup after online. */
> +	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
> +static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> +{
> +	struct rdtgroup *cr;
> +
> +	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
> +		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
> +			break;
> +	}
> +}
> +
> +void resctrl_offline_cpu(unsigned int cpu)
> +{
> +	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_domain *d;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
> +			clear_childcpus(rdtgrp, cpu);
> +			break;
> +		}
> +	}
> +
> +	if (!l3->mon_capable)
> +		goto out_unlock;
> +
> +	d = resctrl_get_domain_from_cpu(cpu, l3);
> +	if (d) {
> +		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> +			cancel_delayed_work(&d->mbm_over);
> +			mbm_setup_overflow_handler(d, 0, cpu);
> +		}
> +		if (resctrl_arch_is_llc_occupancy_enabled() &&
> +		    cpu == d->cqm_work_cpu && has_busy_rmid(d)) {
> +			cancel_delayed_work(&d->cqm_limbo);
> +			cqm_setup_limbo_handler(d, 0, cpu);
> +		}
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
> +/*
> + * resctrl_init - resctrl filesystem initialization
> + *
> + * Setup resctrl file system including set up root, create mount point,
> + * register resctrl filesystem, and initialize files under root directory.
> + *
> + * Return: 0 on success or -errno
> + */
> +int resctrl_init(void)
> +{
> +	int ret = 0;
> +
> +	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
> +		     sizeof(last_cmd_status_buf));
> +
> +	rdtgroup_setup_default();
> +
> +	thread_throttle_mode_init();
> +
> +	ret = resctrl_mon_resource_init();
> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
> +	if (ret)
> +		return ret;
> +
> +	ret = register_filesystem(&rdt_fs_type);
> +	if (ret)
> +		goto cleanup_mountpoint;
> +
> +	/*
> +	 * Adding the resctrl debugfs directory here may not be ideal since
> +	 * it would let the resctrl debugfs directory appear on the debugfs
> +	 * filesystem before the resctrl filesystem is mounted.
> +	 * It may also be ok since that would enable debugging of RDT before
> +	 * resctrl is mounted.
> +	 * The reason why the debugfs directory is created here and not in
> +	 * rdt_get_tree() is because rdt_get_tree() takes rdtgroup_mutex and
> +	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
> +	 * (the lockdep class of inode->i_rwsem). Other filesystem
> +	 * interactions (eg. SyS_getdents) have the lock ordering:
> +	 * &sb->s_type->i_mutex_key --> &mm->mmap_lock
> +	 * During mmap(), called with &mm->mmap_lock, the rdtgroup_mutex
> +	 * is taken, thus creating dependency:
> +	 * &mm->mmap_lock --> rdtgroup_mutex for the latter that can cause
> +	 * issues considering the other two lock dependencies.
> +	 * By creating the debugfs directory here we avoid a dependency
> +	 * that may cause deadlock (even though file operations cannot
> +	 * occur until the filesystem is mounted, but I do not know how to
> +	 * tell lockdep that).
> +	 */
> +	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
> +
> +	return 0;
> +
> +cleanup_mountpoint:
> +	sysfs_remove_mount_point(fs_kobj, "resctrl");
> +
> +	return ret;
> +}
> +
> +void resctrl_exit(void)
> +{
> +	debugfs_remove_recursive(debugfs_resctrl);
> +	unregister_filesystem(&rdt_fs_type);
> +	sysfs_remove_mount_point(fs_kobj, "resctrl");
> +
> +	resctrl_mon_resource_exit();
> +}

-- 
Thanks
Babu Moger

