Return-Path: <linux-kernel+bounces-59535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C975A84F887
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0001C22818
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00B745C6;
	Fri,  9 Feb 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DUkkmIfH"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD171B34;
	Fri,  9 Feb 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492520; cv=fail; b=OBNfM0s7c9D1raZeUCaQFqNsMwlfFNGtpcgVcWjrtY89tfOyjV4ZZpRmNgGwLUVfzwZpnmp7btkdbLhaE0uto4F6E/+xFMtU8gRmA8DUM3CE8RGO6PH4YojjEYJJmY3ofmnVd9MYr2VabhL6hE92gEWAxNdC+zxh32mxLylrFQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492520; c=relaxed/simple;
	bh=bRZeIWH8tpO20Pp8vSFHi0RGZoHgalg7AOStb/VGfc4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qxL9zHo0koT7Wug+1WPnJKwKywc77ARrFTGsVGUQ0TT7f/50eVRbbnwP7bgmK5t1nrVmYrvsWZCwDV/ZKvfhacAdBzvQ7a9MHid8XEdlli/ZDcNuE2VaImnP0U5mJxc1kEMAitP8Z0yg69vF9vFSwCVqXQCzXOMfzD5NT1fE3fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DUkkmIfH; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O55OOnEfm1jqYDmOoWLQIw25AcRyYPThUiY6ebhLGDmYSFt5DAjVrEiBR6nxHXg9/kcYr0jzIxS+EggUzFevJPMwtghOdUafi13qQql9JYmXrh2WL5FN3o7YlHt6GSH2wGvKcj2Bo34+KhVakuGeSt/dJpcxPKkgwut/RYWYlPu2oln+b3NWRi/jHYPUrX7ymmzSOizX0X1ufsHDsF8aCyjUHW5TWFsyfXnFKBucR8CoecPZ4sCnIi3wkf1JL3XmED4eank6JW1HylxeNgiM70edF+dKObFTh6JCIjye8KXCTfRNRo3c0lpPJZorGRuDSV45uJ6f9n7DNhRT6JrHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hWRCHB6z2utbr9zoclG0Zhw8BuocHdXe8uvT1qKjtc=;
 b=adABLAOcBSuTHo8RapJa7g120lvpD7ELo/5F/+QOt+0vJBNgq1dcrjwbjZpA42RsiUfKXBQNhy4ACSb9VuUwZPWh+2XdJC2FZP9aBlXBygB0bcco1NT84mQy0oLX+8yBwHOUUrZ+KMbuRRQGTCAB8l9xEM4orRocDQlZLdUGJ+5B/C+QzwZ2piKHb30TU+XMbWimtOFnMj0/nU9bltX+WOWNE7CbThDlY8IM9OA+cm6A1udNOwKcAPekil1JYTNL8VlPQWWOVzUk6jatqTr35KFIntXmePm0ZCBe2EDD1MTa0X/jDaKkHMhEr/I+wDlmjVl6f9FQQP+dof6R7efFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hWRCHB6z2utbr9zoclG0Zhw8BuocHdXe8uvT1qKjtc=;
 b=DUkkmIfH/epZagrROhUfldGISFDbTFINImTw/NMCh1JSx0/FfO4dJEI7O6G0iqf04qkzkWlg+n40Enc9GfBEZs+rSSlRX6TBwOTB/3vZkN0xiN9e7+EiquwNpwor7/fx4kgZDZsqE3rA6IBh8cWlYtZXQ48bfHoVTbXI1fwVVYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:28:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:28:37 +0000
Message-ID: <b3e77817-e070-48a7-a92b-630603c81556@amd.com>
Date: Fri, 9 Feb 2024 09:28:35 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v15-RFC 3/8] x86/resctrl: Prepare for non-cache-scoped
 resources
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
 <20240130222034.37181-4-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20240130222034.37181-4-tony.luck@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8dc49a2b-4abf-4814-bf30-08dc2983c8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jKAIOC1ZEzMncjjZSLrDBUdcmrdXzrOAteaN/dsU88WhibyKD1NOTLz7G8xtES1OE0iRtKSzvJs+RKixDPeWjxLNnyoYIV8djrYDg+g4ac6TvRCXUFV0VEt23rVn1fljp2gWoTsUvZ6xM6LTpPqI4UPJt8EqUUXdQQMMFrOgtgEzibo/kikwoMy7W69m/bCrjD6XtFdI56zsV2pRippIjjv1BScyDkJQjKrmgNOHHjpV4//znNp822aG1B8pNdQMfNryVwhWlRap6LMv/Ew8jWdABu6tm4muZXY6Zq4Ehrtov98eEA4d+OL7CGycoRTbOxoDKX6feoawrkfkY6nvBIOSopXh2HB3FL04OAfmwZIQc22/IeBdFyg29qK3i82D0SIDZNvsrLV3emK4qjjX2SjMQg/YoMf9eWGRcb4J2t2DNOiDkVT+C+I8t4tC5u9ct4nBhx7jDNXPVBpGGl8rZaDjrpqp31jQqk6oZZfM7Z1k48UpwxgFVXwNaoZxbugO2zu9zOxfvyAsTiv50632W56yWZpjvCAS1azMG/zUyqtfvY5Ul5xImYKAfK+O9pWq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8936002)(3450700001)(4326008)(31686004)(8676002)(2906002)(41300700001)(7416002)(5660300002)(83380400001)(31696002)(86362001)(36756003)(2616005)(54906003)(316002)(6506007)(26005)(6512007)(66946007)(66556008)(66476007)(6486002)(478600001)(110136005)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDF6ZXBGcGUzdHRISTd0VlppVDQ1NWRiaXpLYk9nWjdSWGZNK28xazBxMmFI?=
 =?utf-8?B?S1VDTDlmeVZURFdHVlR1eEk2d0dWem1TYVRHVkg5L3ZxZ0FsNXZpYkNyNUY3?=
 =?utf-8?B?Yk02K2drSEs4ZTBWZm1BcDZBWnhOWFp4eTVLblRxUWdKUStOcy9jeVkxb01z?=
 =?utf-8?B?VndQNFU4R0xEdGlMM1h4cFRmbStiZkFlSHBCdklpVXQ3RmFFYmJaaXhjVFdO?=
 =?utf-8?B?NXkydHVKMXJiNjdNUFg4TjRuUU5oM3U3UERtYTBBbjBtRG56dzA3TVdRZmpX?=
 =?utf-8?B?eHplaC8rbWUzd21xRThDeUtoZ1Q5WER3aTZDbElOVUZ0V3F3bk94ZFlicXZs?=
 =?utf-8?B?eXVMcjFCWHkzejRMMUdld3NURzQ0dmpsak9OL0hFQWpRbEVRek1hUmgwNS9O?=
 =?utf-8?B?MHF2aDZtNHhDbUlZZTk5MDgveE9qa0NTa3o4S2d5TlQyT0Nuc2wycER0dmVl?=
 =?utf-8?B?emFvUzlua0xuTklRZFVqTURjckpMSmoyR3RxOVZQOXhnYWlaNCtESGlINkI5?=
 =?utf-8?B?T0VMT0Y4WFB3UCtudnhHeFN3UEg1cEYxNkgrUGZQc1V5MGFHQnRoS091TlNx?=
 =?utf-8?B?RmRBcENad0FXQUlNREtFU0tYaDFaUGJKWGRlUzZ3OEZKVnlHc3NNUC9VSXpz?=
 =?utf-8?B?VkhOYmZnMjc2bCtmWGFkb2xnckNwYXlWR3RJaVdvVlpkSnVVUEw4MjVMUWJF?=
 =?utf-8?B?S0wxNTI0a2Y0UXZaL0g5L0ZlOE1uT3I1UjAxSERiQk44LzIrakkwdSt5VmlT?=
 =?utf-8?B?c291QkNaaHZwblhsUGV0UjFYYmlnVEY4U1VvTXRDQnhrVGE1dTc5dkVqekhj?=
 =?utf-8?B?d0VEVkFXVGhQUThxaDZYQVpmbjhjNGxhRjFQR05BNUtLTVMzTUZnZXR1c2U5?=
 =?utf-8?B?YUJFQXJmZUg5WjZyeExLR3VxNFNYWmYwNXRVNWZJcEhXQ1cwZzRDVVZTbVph?=
 =?utf-8?B?a2p3RXgwanBseTA4Z01KYWNLYXQyMXlOYVRoU0NMUnZsOXg2bytKQ044QjlW?=
 =?utf-8?B?Umd1MzdmV0V5UE56SVUrU0dOQ3JyN3ZtaEJNQVBJSlA1NHVvVmFGRmFnWmV2?=
 =?utf-8?B?b0VFZHk3bTB4MkRGZ0o4VE94ZTBuL01FNjRydkFBRThLSVdKRGpkYVF3UXM0?=
 =?utf-8?B?UkN5OUcvMzQwWVN0aEJQemh2Zmdwa1JDWk82cEY1VWdTVTk4TVBWQkZOOUk3?=
 =?utf-8?B?VnpsNjlQdFo3NEVIeW5aOEVrdjdlejA2SWJmOGdQQ0pteGZlbTZZTWo4c2VP?=
 =?utf-8?B?VCtBYy9JNFMxd3crdjV3Ui94cG5Ha3YreVhvQXl1ZGh2REtGU2M0dlBORmlZ?=
 =?utf-8?B?bllCSC9DbFA4a3JPeHpoTXh6c2dha3ZwaXVCWmdCaFl3SHFVS2NoNVBET2hP?=
 =?utf-8?B?NUkxeDFXUjZZY0RnWWNSTTUxclNWSDBZYUJ2eGNJcVBSTGVnbEtra04zS3JO?=
 =?utf-8?B?NExjZ0padCt4clB2OUlWaVhnUVovNEhFOTArcDdIdXc1elBqa2NrTnZybXRL?=
 =?utf-8?B?cGJZU1ZDK3gzMUxKZ3dPSzF4N2J2bmJySldTZ2RzSno3WDNJdXZRQWZjWk1w?=
 =?utf-8?B?MThLMzZHNWpucUo0SzNNcjFpQU9hempFd1JGTElqYlVrOUZuMmttWURrS0lB?=
 =?utf-8?B?U1ZTNE9YK01KUDhMaFduR1ZmSkhmRVFKTUQxUFRySTM2MzB1V3dZYlVzZENz?=
 =?utf-8?B?bS9VNFNCSlM2c1hVOEZybU13R2x3cDFtQmhtcDlGek0vSXptcVRaVEdmOUZY?=
 =?utf-8?B?NllNL0JGb0JBTEl6WmZmczVrK0NsVVdaY1FwdDNUd1gyd2hsYjlPaVdOSmJ3?=
 =?utf-8?B?aEppNDNrdWFxUmF6R1o0dXVUNFU4M2JkTjQwdmowdkFSY2NrRktWb3p4MHQ3?=
 =?utf-8?B?ck90YWxJQVRUODdMdzB5ZDYrT1pYdVF3NktQRmJ4Mlp0US9xQnBQalV5MEZB?=
 =?utf-8?B?Z3FzQkZ2UmtmNkxhd1RJL09qdFVpb3B5My91UG1NQlVFL0xndEVtd1ROaFNa?=
 =?utf-8?B?c2xYeXdiSjZHdkltb2xSU2FTbFBVamtNdWhEa0ExTkhuVkJ4R1Jud09YSWo4?=
 =?utf-8?B?eVZWNUpiL0FNeitaWjhvQVZLTDJKdmdhUEZTcm9JQU8rUEZQc2U4RXUveEFW?=
 =?utf-8?Q?oers=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc49a2b-4abf-4814-bf30-08dc2983c8fb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:28:37.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDLu3txWGW+l0M3N6AG3ie795Pv5IH7yxV/5qZuwugGxoWGjvI03p4OaGARLV+yX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Tony,

On 1/30/24 16:20, Tony Luck wrote:
> Not all resources are scoped in line with some level of hardware cache.

same level?

Thanks
Babu
> 
> Prepare by renaming the "cache_level" field to "scope" and change
> the type to an enum to ease adding new scopes.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   |  9 +++++++--
>  arch/x86/kernel/cpu/resctrl/core.c        | 14 +++++++-------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>  4 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 66942d7fba7f..2155dc15e636 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -144,13 +144,18 @@ struct resctrl_membw {
>  struct rdt_parse_data;
>  struct resctrl_schema;
>  
> +enum resctrl_scope {
> +	RESCTRL_L2_CACHE = 2,
> +	RESCTRL_L3_CACHE = 3,
> +};
> +
>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> - * @cache_level:	Which cache level defines scope of this resource
> + * @scope:		Hardware scope for this resource
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
>   * @domains:		All domains for this resource
> @@ -168,7 +173,7 @@ struct rdt_resource {
>  	bool			alloc_capable;
>  	bool			mon_capable;
>  	int			num_rmid;
> -	int			cache_level;
> +	enum resctrl_scope	scope;
>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
>  	struct list_head	domains;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 0828575c3e13..d89dce63397b 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3_MON,
>  			.name			= "L3",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L3_MON),
>  			.fflags			= RFTYPE_RES_CACHE,
>  		},
> @@ -75,7 +75,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -89,7 +89,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.cache_level		= 2,
> +			.scope			= RESCTRL_L2_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -103,7 +103,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -115,7 +115,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_SMBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -514,7 +514,7 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_cpu_cacheinfo_id(cpu, r->scope);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
> @@ -564,7 +564,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_cpu_cacheinfo_id(cpu, r->scope);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 8f559eeae08e..6a72fb627aa5 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -311,7 +311,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>  
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> +		if (ci->info_list[i].level == plr->s->res->scope) {
>  			plr->line_size = ci->info_list[i].coherency_line_size;
>  			return 0;
>  		}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9ee3a9906781..eff9d87547c9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1416,7 +1416,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>  	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == r->cache_level) {
> +		if (ci->info_list[i].level == r->scope) {
>  			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
>  			break;
>  		}

-- 
Thanks
Babu Moger

