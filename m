Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82687EA3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKMTgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKMTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:36:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA86D79;
        Mon, 13 Nov 2023 11:36:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHDzdED6/ysbPsiNOXV7WY+r3kM1hHyDvW/WCm4tWp39zrY7NyQpMWAv6Z9gxamFpACZ1gqWsDeRmUEhE3bHivAPvP4n3t5LuVkmW0ipiJy6sLT77nigohg1mKk27IJhB/OR1GRi/aajxvIc4xGbqhtduQqmJpqzBmnK+2QyBy6dsgaE8sIVGLX+xtYnAqYphvMLw6Zzi6IMyK0I6ld7AGVWklr7yyckyPIIlBZuZeh+hkst2hzIIjwApiqdOF9wMfADgxhB6zEHWNITHMqxwtVOFO328IE2FvmTJ8Hjdq+SKs+5ngZaNI+Zlbjv5zrv1PK8FV+xlNnq1um2WmsVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f75L2qp6bAvYzgPrBSSTQtAqLASOPuUu5mBVBPvBpU=;
 b=kQuZmh0wzcEHNBkzJNTHkz0CcnWtlf22BmvUKpIbTD/GdZw/Gp6XEWW5sxghUt010xy6JvHidH5rInKSIr/oR1ZLBvwRr9sWd+noI4LwJoOuU9UZSMM1cvRX3hCXZlCSNwlDkS6g1JhM+I14JZRhAEjkLxtBa9hhHi5MJMzPJhfNgsg3m5eCsZ4W++Mnu7JCSLCuh8aDt31qr+eQypPew6CR9bPg1sUF8t0q4liFeaOEJNqTVYHJ+UC92k24Tjr6rJBhBYGPHAoGMYn1DxT7um50BnFp3YWv7O0/fcLTJzyzqf+HzazTMolQEQmUWu3IgXfIPtDfcIUeVyeFYZb22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f75L2qp6bAvYzgPrBSSTQtAqLASOPuUu5mBVBPvBpU=;
 b=Yze7ee34hptW0FAXvjudJ3JnmCxOpaMyF/wtpurIVmJ52nYH/dom+1HeD1oSuKCUzAn5kYQO2vVUM3CuS+9qiHiG9DM8tHU2ruESnaOIVIuHLC3irZQXNvjaJmSqLhmczccC61PGFpYGJR2117373VTEeqiNkZ9gheMxj0LDGoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.22; Mon, 13 Nov
 2023 19:36:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%4]) with mapi id 15.20.6977.026; Mon, 13 Nov 2023
 19:36:10 +0000
Message-ID: <fdfefd2b-28c0-4961-8bec-6bf5c5fe58a2@amd.com>
Date:   Mon, 13 Nov 2023 13:36:07 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 1/8] x86/resctrl: Prepare for new domain scope
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-2-tony.luck@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231109230915.73600-2-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcecaf1-cc6e-45d6-92a9-08dbe47fc9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuqZEfm0i31b1csS2yO1TwOqvI0FcFBvDdP5RpBUOqyw+xQD8/qzpByXkybE+9RWPMDiZBd+5/XgJVEmED06ajlkbyNkSMaPBWwCjNVTVrRIDRiW0TO7qm22Bva21OiKuxBJ/xUuugO9QiXBqN3id2qz3AoVVm4zG/peTxeXVorUxdg8FL79Dj4RZfK0rQvTt6mvxC5WY2uEAOfIff2yBtqo+9hhGqThB6uoOBcNdOZXWlSdLogfYPSQUN31HS7U/2dCGoKTEan31qLIRy5OfjOeWsTVKly+AkLyta2H6RgOqLTaDUAqc6gtvQATxSjD222rZKrRIG0ecEqTHChv8YQSPyrirsWbF0ugU1wBWtrTJoL9WQDnWY8+ciWepRlTZoJDcKeb0OxGHLRy1oJKjMLclSzKwiOResewePJZb3sqOwfYpUf9oGtsDQJqu0R9ZKZyIqYScWOLNyBze4KASHm95+5cUBB6H9BI4r5KIUASqCqICEn+obxo0bZ40MyAW0gMB/1Dr1+3kRMypWeMZzQTYVgUtLIemp1SVW4Rb0vlFaDMvYj2chhsLkJkfYW7Vph8JAfKub8U48e+eDG+B8XqliskiwBnzoxC1v3wpMHMrOu5i3rfjisx1jxymvcct2W+eC+tgP8XKl3NhZjfXSK803uQAs87fWVO/Q81k0r+cLBD5xu/dfdoROTFVkpu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(66476007)(54906003)(66946007)(110136005)(66556008)(86362001)(31696002)(36756003)(38100700002)(6512007)(83380400001)(26005)(6666004)(2616005)(53546011)(41300700001)(3450700001)(2906002)(316002)(478600001)(6486002)(6506007)(7416002)(4326008)(5660300002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RTUVpFVUFoZTF0UWJMekpvSC9YTmFxMnBGR1lFWFFTNVZOSHFURmE3eW1V?=
 =?utf-8?B?b1FYZHVjN1oyVXczWTE2dmNDaEhVNEkzRGdvT2U1Sm5SU01WaitPc0tEWXpx?=
 =?utf-8?B?ejBXT3dWNXFxOVZuQXJFbFBqMDNWejhtUlc2STZPd3VQdHdadVVFanVhMkJ5?=
 =?utf-8?B?ek5PL21JVkxuZ2RicDJDM3dia0hIOTR6aDZjRjNRZlhCMnZWQ2d2d0s4OGZj?=
 =?utf-8?B?WmRNSGFBc3J1TkUrdXNXRmwzdG4wYXlhRmNwelVlUWpIOUhTdXdLQndwVmM0?=
 =?utf-8?B?OXVXaDFxTGdXQVNwSHQwcEViYm5BUnVreEJLZEJZeWlYVG5uVXZ1aEM4VWZL?=
 =?utf-8?B?NzNUcGZLOC9va0lYd001ekVaNW5kV2FaSlYvVXZ3ZTJqN3JWYmdoQXE3L2d0?=
 =?utf-8?B?WllUM0liUUtSR2w0Mlo4K3FEVjhIdzN3WmtlQUZ2MDJ4Uld6QmdPK25hWVRR?=
 =?utf-8?B?YzVrN21lbWlKZElCYWpFcGpleFVFV3ZQYVQycEFEeHBOdDhLVVNNU0NwWHow?=
 =?utf-8?B?R0ZsWC9xdkIwam5Dc0xrRkFwdVNMeXJtREpod05zMm1FUnVEVWNUYndMNERo?=
 =?utf-8?B?ZFp1RVFNMm5jTVFQWFZ6VjBPdWZTOXhXL2Ivell1dTY2ckpneEN5cTNGeTFM?=
 =?utf-8?B?WnVXZllRV0RoL3ZBS1JjRmNmSTJRVlc2MWM4ZitsMDUvdGRhd3AyVEcwOElW?=
 =?utf-8?B?YTBoSGJIL2MrY21BUWZrcGxxVklMRmFYbHhpTktvSURrSDBySks0SktYdXVT?=
 =?utf-8?B?YmFRYlJVQnY1T0hTMTNUeEpvSkIyNEFXWDlBdW5sZkUzbVIyZFRKTk9QUkpR?=
 =?utf-8?B?azNRSGw3SEFOaHBmc1lwYWFDc1ZLODZnL1lqa3pUQUEvK2hERzIySVNtT3dt?=
 =?utf-8?B?RklyK1lyc2daNDBkSm9iWldKTXZIbDNXUnNTVEo4UUpINUtQaVlQU1BkRzg4?=
 =?utf-8?B?S0R4WUliRWRiT2dyT2prMk1IQmtSYUJCcjB5U2p0NTVsUTlVTUdYQ3MyTTY4?=
 =?utf-8?B?a29WL2x2elo1WkpsakEzalREdkZjTmJoemFkdzFZODhHT1RqVXVhdEdzRDFm?=
 =?utf-8?B?QVd3N3NSRzgxYlhPdStxWC9NSUZ3U1p2SUZmaHNITkNJUFVueHFIUFZTN0w0?=
 =?utf-8?B?MmhLb29QQ0FEN3p2KzVCR0d3MHdjeWtyMk5mVmRxVmowQjhpVlJ5VTc5UDFT?=
 =?utf-8?B?L3NpMjJ2QmlWQ3hOZTI4U0llZk1iSytkMFc3NEFNd3QwTmM0WTNOdDN2bzdE?=
 =?utf-8?B?UVBKMzhVWDcwR043Nm96RENTYXdvMHNzaUF3TkUyMk9ZejBkU2REQ3dnWUto?=
 =?utf-8?B?UkJRdWJJV2VuWG5TckFmenlyaDBSa0hDenl3OHExWEVvb1hNUTlKNWxoZ052?=
 =?utf-8?B?MG4yQ010MkxSWVRiOGNtQ0RXQURyL2hldXp0OUdiTVpLSlU3eFJCT2U4VTJB?=
 =?utf-8?B?ZkNOQjlHWWdmVUlHdEtnY0xTaFUyemRHMFpwaHR1SEdsWkdIQlRLQS9mT1h0?=
 =?utf-8?B?cVVKRmwrMzd3RFpVbUREOSs2S3lPeVBaczlydmwzQTJTL1pPT2NUd0FGK2Yy?=
 =?utf-8?B?NTI1WXU3WGE4c1BYOGo4WlVDM1V1SHZxcXovS3FidjBXZmY4OVRkWXkzMC9Y?=
 =?utf-8?B?OHpGbTlBUm9ac1dqb05MZlBGUWZ6dGNEbFBJSTBRQW9SSVZRTVRreGlEbDBS?=
 =?utf-8?B?cW1Wd0l6dm5HYzRVVGgraUpMdkpxUVVWQUlLWiticjZpakR6c1pJNWZyZ3hi?=
 =?utf-8?B?YWJTSG10RklISlYwSDV2NUxwQSt2QVhqcFhpaWRwSkV2WTlSeVBYNUNuUGNI?=
 =?utf-8?B?elNsODIzdkFlMzFIMTN6amRBTWNwazlDQzlsdU1wZVRHSWxBRkFQaXFDUnlB?=
 =?utf-8?B?Zm8yWExnSXF4d2FKM296MHZKbTMyM0RjUFR0YUNiU0ZMSzNJSkx4Wlh0OThs?=
 =?utf-8?B?ZEh2ZFJ5VFZuM0NGR2hOejM3S0RrajNOdjRaQ3NNMkt3NXRPNGFBWmNJM3o0?=
 =?utf-8?B?Zm5IQW95TzVlV1MzRmoxaGExQU1LMW9GTGdRWDRDcDUrQTRQSXpLTXA0cjZF?=
 =?utf-8?B?b0JFaEFmam02aEhCMHBSS3VXWUpkTjdldnR3MCtkWWdReWVoSnVLREhBYVlP?=
 =?utf-8?Q?QVFY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcecaf1-cc6e-45d6-92a9-08dbe47fc9ad
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 19:36:10.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zeXjRuoAiErR8lncsex7ALuAG5REtpki5BbNQ7yKYAWJhOXGXr3YukgO5CEaxCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/9/23 17:09, Tony Luck wrote:
> Resctrl resources operate on subsets of CPUs in the system with the
> defining attribute of each subset being an instance of a particular
> level of cache. E.g. all CPUs sharing an L3 cache would be part of the
> same domain.
> 
> In preparation for features that are scoped at the NUMA node level
> change the code from explicit references to "cache_level" to a more
> generic scope. At this point the only options for this scope are groups
> of CPUs that share an L2 cache or L3 cache.
> 
> Clean up the error handling when looking up domains. Report invalid id's
> before calling rdt_find_domain() in preparation for better messages when
> scope can be other than cache scope. This means that rdt_find_domain()
> will never return an error. So remove checks for error from the callsites.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v10:
> Reinette: Move a blank line in domain_add_cpu()
> Reniette: Fix warning message in domain_remove_cpu()
> 
>  include/linux/resctrl.h                   |  9 +++--
>  arch/x86/kernel/cpu/resctrl/core.c        | 42 +++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 ++-
>  5 files changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 66942d7fba7f..7d4eb7df611d 100644
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
> + * @scope:		Scope of this resource
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
> index 19e0681f0435..9f8d87abd751 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.cache_level		= 2,
> +			.scope			= RESCTRL_L2_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_SMBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -401,9 +401,6 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	struct rdt_domain *d;
>  	struct list_head *l;
>  
> -	if (id < 0)
> -		return ERR_PTR(-ENODEV);
> -
>  	list_for_each(l, &r->domains) {
>  		d = list_entry(l, struct rdt_domain, list);
>  		/* When id is found, return its domain. */
> @@ -491,6 +488,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>  	return 0;
>  }
>  
> +static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> +{
> +	switch (scope) {
> +	case RESCTRL_L2_CACHE:
> +	case RESCTRL_L3_CACHE:
> +		return get_cpu_cacheinfo_id(cpu, scope);
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}

This function is meanigfull when you introduce node scope RESCTRL_NODE.

Can you please move this to patch 5?

Thanks
Babu

> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -506,18 +516,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  	int err;
>  
> -	d = rdt_find_domain(r, id, &add_pos);
> -	if (IS_ERR(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +	if (id < 0) {
> +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->scope, r->name);
>  		return;
>  	}
>  
> +	d = rdt_find_domain(r, id, &add_pos);
>  	if (d) {
>  		cpumask_set_cpu(cpu, &d->cpu_mask);
>  		if (r->cache.arch_has_per_cpu_cfg)
> @@ -556,13 +567,16 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> +	if (id < 0)
> +		return;
> +
>  	d = rdt_find_domain(r, id, NULL);
> -	if (IS_ERR_OR_NULL(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +	if (!d) {
> +		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
>  		return;
>  	}
>  	hw_dom = resctrl_to_arch_dom(d);
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index beccb0e87ba7..3f8891d57fac 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -563,7 +563,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  
>  	r = &rdt_resources_all[resid].r_resctrl;
>  	d = rdt_find_domain(r, domid, NULL);
> -	if (IS_ERR_OR_NULL(d)) {
> +	if (!d) {
>  		ret = -ENOENT;
>  		goto out;
>  	}
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 8f559eeae08e..2a682da9f43a 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -292,10 +292,14 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>   */
>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  {
> +	enum resctrl_scope scope = plr->s->res->scope;
>  	struct cpu_cacheinfo *ci;
>  	int ret;
>  	int i;
>  
> +	if (WARN_ON_ONCE(scope != RESCTRL_L2_CACHE && scope != RESCTRL_L3_CACHE))
> +		return -ENODEV;
> +
>  	/* Pick the first cpu we find that is associated with the cache. */
>  	plr->cpu = cpumask_first(&plr->d->cpu_mask);
>  
> @@ -311,7 +315,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>  
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> +		if (ci->info_list[i].level == scope) {
>  			plr->line_size = ci->info_list[i].coherency_line_size;
>  			return 0;
>  		}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..c44be64d65ec 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1413,10 +1413,13 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  	unsigned int size = 0;
>  	int num_b, i;
>  
> +	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
> +		return size;
> +
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
