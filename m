Return-Path: <linux-kernel+bounces-59533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A784F883
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294BDB23327
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F23745E7;
	Fri,  9 Feb 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5oxEgI4N"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4569DE5;
	Fri,  9 Feb 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492502; cv=fail; b=hfm0NDdj2Qlk+P7BkHwsBXar5r8nsI6HUObeJAHGm3GNx2geE5QbHcUdKro8jBiyq+Ytf8zaU1aZEX1uRPgSV8ZxqGJnvJ3FLDMTYZBbt+KtBOGI0azUn9cGNx9YoNxZ+aLzymdmNaDNoMPKfK6ojMs1LhpC2tPltWLfJxTiQ1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492502; c=relaxed/simple;
	bh=GCee6RcFJm89G315j7As7tmKXw902saIadXIn80fcm0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPFgHMYVdfFru7RbhVHyYzPbxJLGTXbI5nkwEjfbqWmpihVRBzYMEy/oG5PY6MpNmdD+r7s6+eqPq6dKZOdOc0rT0WRwrsGtdzeTSqBBxOBUnlEiApvqDNboR1vQzfFZ6wMNXSsN3M6QxSGfU2a6ArcgPysd6XB1ZS/z3TsDuTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5oxEgI4N; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcZ7nX9uzTta2FeKHGJNK2fj8Vcpk0ZrI42yiM2EYEGwyglg6YCvu4sVWDXcxcR82uiBAibsXKsjTmfjVNubpNMfdoNV6Pv7JU0amQJwlaoDmXllMedfdBpS6bf/4nJ8v9Lta8OgetltSWTCjqUYsmJw1PiIrGZ4LtUAio370RJRQRmqejCe7sbj0UK81ejZr9N7oZl0WYiQiOS1z1vQw3GbYQgdBtZTM0BHJQVJMLGHWX0RSuR6ISXrreMWiAQXCWv4n37oS6D7TWA8ACmHraI5DsIXnjkXJX1ZZPd5MRygmBZOuCEa4gKZaKvSbQGrUF5GE1ZNHAuY3wLESQ+Uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7/BM7sWcaWIpp2Ku8uiIWgjVig9VY8J+RJd0qX3Ifw=;
 b=XHf0RRpSQVJ0M4W85nesO3QHTPPdc9qiRM/97OkJON6nxbBjjoY1buKEzQqtl9NUwASMctRhHxQOnPKz1VX4tVcfLjuPzPGkm5d1t90ZwSHC+7g/+GzJBLr5MpjV+4eQIIoKJTURtuHcd16g+26bV+xYKb6sBXuZRZkLgYpAsnfinUQ+cmZcKXYVP36wl1YrnwY7jXj4P2bIfOdDH5LdBciAZpEbUpXEXkV7pM4Y2ZL3j6tYquMKrbPXbw6XQFg8Hd5dbm8wgnfkJldN/bX15+QfBNw9OhowAJgb8L6lsK18fJ34d9mhS67eqMInXt4uorlTL/Pc3AffhZfIGsbtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7/BM7sWcaWIpp2Ku8uiIWgjVig9VY8J+RJd0qX3Ifw=;
 b=5oxEgI4NeKbprVX32HGb1W3LlOjQ94JknRLxlizB1yYkZ+b9Y0pgCeUf61eQyTwxh0asVJb1BFOVmRHHlHjODoK21zN6ZuIjFRVcCGGcYo8N5kcJwC5hVL/rM4l4m+TveKGvLrJlcDDm5x41mgFvuef3qxmtSWTfIZ5UarNolX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:28:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:28:17 +0000
Message-ID: <c9629380-c97c-4797-b6b3-5044d5beeb97@amd.com>
Date: Fri, 9 Feb 2024 09:28:16 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v15-RFC 1/8] x86/resctrl: Split the RDT_RESOURCE_L3
 resource
Reply-To: babu.moger@amd.com
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
 <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Randy Dunlap <rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-2-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20240130222034.37181-2-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:8:54::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: f088b744-349f-485d-3c2c-08dc2983bd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SAQBS6moKhUU1qJjw8BCmChC5/QbSdKMenIpm3xTIN+fDp2XpI0TIXS4xd/kO5gNFf/rITI2UGjCnwss7UdlvyGlT97v7gxD77Slv/PHTIbSZj1Pkeu1Zatz4wMFE5SFt4XLRePLUATO6SldvTLz7R3pMJ4BVLIcy7pA5tB/NnDzzwfJVEW+GFQkA03ORN6jLP8FfeG1yOR/bmgb/ngzWgstnfomo+aQ//rqj9nEE+73KppU9crv1MDBdEptQQhDPxVv2vRMWc8vpiHP9wI612Ss11a96CVZgRQZwIBjaBChzLfJ0/qp9MMZRtnd6Xs2okDh3ilpjkd8iZbsjtKX9/dczEflkc8kcArE6dzDHNfO/HuVpI039Lcyt3VzlHt7oyJyJ9tEpi0zWnghMSw47bHKQB1oENZGXO+A0nnYhWbMosEkkfRRVt3YWi7sxAfyeHJYhJrUZfZy4SjorAN1dYJrXfF4Ic+4MFrhyso2+b0ynIriVG6qT0cztcxs9b4svFH+xCFPNeEYZKSDfZT+1M2k+o8hRXfctn2VrWoppDEU9rJmP1f24t6pmkW7B/ZX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8936002)(3450700001)(4326008)(31686004)(8676002)(2906002)(41300700001)(7416002)(5660300002)(31696002)(86362001)(36756003)(2616005)(54906003)(316002)(6506007)(26005)(6512007)(66946007)(66556008)(66476007)(6486002)(478600001)(110136005)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkExaUkrOHlzaTBqNWI2QUt5WW1FcnRRUlZWcjdUdTZHMUNCY2RIN3BCaFVQ?=
 =?utf-8?B?Y0s4RmxDc3g4UXVyUE5SRW80WXJJSHA0K2RnSk1CVWtWZ2pqN29XSE9VOXZG?=
 =?utf-8?B?dzlCZUpENEs2bkk2eEhCRzdjZ25VbGJsYU9RQVRZNHJHQ3FKR3N6NUZkRTYr?=
 =?utf-8?B?a3h0MnRxa1VCaElqUFgvcnY5MWZCcksrczFzM1pWOUVydnZwdEkremNQY3Ja?=
 =?utf-8?B?VWovN1ZBMTcvaXo0N2trU0pDRzRxb2Z5ejZrUGs1NVpWWTBEV2s1WVF6cGFX?=
 =?utf-8?B?QW1GSEh3SW8rZ0tPU3NoNXFQMXVRQUxZR3E5R1VIWkRZOXh1eXlpSmZSeUti?=
 =?utf-8?B?bW1IMms1cEYvbStzY05oa3ovdkh3ZERzQnpWcmtTcmlNTyswYXhRaUpGWU1j?=
 =?utf-8?B?UVdDakJCZjZaQWIzKzRkWFppT3p1bVJPVDRDY09jYmc4SERSL3FIU3lZSjZi?=
 =?utf-8?B?Z1ZuZmxsT0QvK0JvbVZhalhzdHdGZktBalVqdmNjZDZqUnE2eFBWSlZvTGda?=
 =?utf-8?B?KzZVVk4zZFNORmtDdmxuWG5DaGd3SFVQeWlXU0tMeEJENmwyRk44bml5VTB3?=
 =?utf-8?B?bXRkcjY1TUU4QURiTVVTbjVVVW5nZ2tOeFdlM3NPdVdJdUdLS0FlUUpHTUhX?=
 =?utf-8?B?dlFZWnFINDRtYS9OQ00xaWtPeHZWK0Q3TjFiMHd2c2R6RnVhMVl5QXU1NkRJ?=
 =?utf-8?B?WTN3Mk1mT3p2TFNlZ1F0c09YYVRHb1RzRXF4dkFzQWpQem5FR3FTOHJRaCtn?=
 =?utf-8?B?WnBaOS9YUmcrUkJua2FrdEhuQ3FtN0JxN1c5UEozb2ltWEdneHJpaUhxU20z?=
 =?utf-8?B?cXRVTE9PZE00dTgydnF5U25ObnJiNTFWVGhaZC9sUUpudkN2NzNZQnhBN2pq?=
 =?utf-8?B?NUtseS96MTVZdk1oek5tTWNSOUNXbGxRRFNtbVlvb0JKMXVPMzBYN1BLSlp2?=
 =?utf-8?B?SlJkVDhqVmxFNE5LSDVSZFZVYTQ0ek1lVjdEcklCWWdKMDdrNkltRXZtaWhq?=
 =?utf-8?B?dnBsYWFQc214VUwxT1dieThUUEFVRDRyaHhETjQ5NVJrK0hLb1ZKdDA3S0xZ?=
 =?utf-8?B?YTVoQmtqRHd2djJvemd2QjJIRytSenlUSFk4bU9MaENRaGgzYlVwcCtTUkx6?=
 =?utf-8?B?ODcxVjg4ZllManNmaWNnSy92YXlOQXI3ZytWeTRQaEZ3eXVMU25UZFd2Y2E5?=
 =?utf-8?B?eGlvSUJrd2tBZHVJVGNkdHlzQlpPdUgyRnVKUlRYQmsrOEFzeHlFRVBFcEk0?=
 =?utf-8?B?M002cXBvdG5WczUxY3ZQUnhzQzhNNjcrVjI1U3BYRHpUT1RSczg0enA5VzlR?=
 =?utf-8?B?cVpReVdaM0oycFIrbm5yeFBpbDI2UmVwRENwMUtNMXNjMXU3YXp5ZEhZbmVx?=
 =?utf-8?B?L3hFMU1ldHBkTVZiK1pLTDdaNEQzQTJQdW1SL2MwdWNnejNNNDYyanRxeW13?=
 =?utf-8?B?U3lQM2pqS0VVcWt5RklSN3g4cVkwUGNoay8yWXdJRDlFQWxXYXhLajBQL1dI?=
 =?utf-8?B?aUsvMWJzcDdudktsWk9VOFpTV3ZoUmtaL25nU1pTU2lXSERWL3JvMzJNTDBm?=
 =?utf-8?B?UzVSZk5BYXpsSmFqdENNSkxxcERvOG9pYTkyMUY5aTRBL0FpbjBBamFobVhr?=
 =?utf-8?B?a0Z4RzAxdUQrTTg2NmpvdmR4R2pWc09FbXZVRFFGMXhjT1h3dVdWZm1SUEZK?=
 =?utf-8?B?VUJMWkx0bmx3QVJad2czaGZGdnpuS2o0encralYvOGpmeG94OFM5NXR1Y1N2?=
 =?utf-8?B?VDdMT1VaV00rTEdyMTA3dTJVWGE0UGZtMEJkaWJTZ1hkcE1kVEdIMTltVCtH?=
 =?utf-8?B?bXhiOHNPemF2M2RnZ2lkelIvK2d4c2xkSUlUOWdGb1VsT3hmdkM1NTY2SU91?=
 =?utf-8?B?cFJPYW92Nkk4N1Y1NjdEbEhKeG4zT2tpejRzRzZZSzVCNmlDTnBhcUFFOFZ6?=
 =?utf-8?B?MU1XWXIvOVNXZ3dhSERmM0FnQ2llUmU1WFlmcWtpanN5a2kyaGE1ODNjdE95?=
 =?utf-8?B?a0xNSERDVGZFTTIvTWhIeXVDM2tuZ1dadVVIZ2szWjdmcWZuazRPdGRrVDRX?=
 =?utf-8?B?cVBKY01rWjUwbXFSbEtiSkN1K051VnRQYW1qV2YwOU1HK2pheURvazQ1N0hS?=
 =?utf-8?Q?hjGk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f088b744-349f-485d-3c2c-08dc2983bd8e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:28:17.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1aHONjNC8NKeWJsLwjOFO1e5k3du8mRZh/1tjq5RwldpMJJWWLFAM4QSCotCS2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Tony,

On 1/30/24 16:20, Tony Luck wrote:
> The RDT_RESOURCE_L3 is unique in that it is used for both monitoring
> an control functions. This made sense while both uses had the same

an/and

> scope. But systems with Sub-NUMA clustering enabled do not follow this
> pattern.
> 
> Create a new resource: RDT_RESOURCE_L3_MON ready to take over the
> monitoring functions.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/core.c     | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 52e7e7deee10..c6051bc70e96 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -429,6 +429,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  extern struct dentry *debugfs_resctrl;
>  
>  enum resctrl_res_level {
> +	RDT_RESOURCE_L3_MON,
>  	RDT_RESOURCE_L3,

How about?
RDT_RESOURCE_L3,
RDT_RESOURCE_L3_MON,

>  	RDT_RESOURCE_L2,
>  	RDT_RESOURCE_MBA,
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index aa9810a64258..c50f55d7790e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -60,6 +60,16 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
>  #define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
>  
>  struct rdt_hw_resource rdt_resources_all[] = {
> +	[RDT_RESOURCE_L3_MON] =
> +	{
> +		.r_resctrl = {
> +			.rid			= RDT_RESOURCE_L3_MON,
> +			.name			= "L3",

L3_MON ?

> +			.cache_level		= 3,
> +			.domains		= domain_init(RDT_RESOURCE_L3_MON),
> +			.fflags			= RFTYPE_RES_CACHE,
> +		},
> +	},
>  	[RDT_RESOURCE_L3] =
>  	{
>  		.r_resctrl = {

-- 
Thanks
Babu Moger

