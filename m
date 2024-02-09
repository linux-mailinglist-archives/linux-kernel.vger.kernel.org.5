Return-Path: <linux-kernel+bounces-59536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617684F88B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5652860EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE974E10;
	Fri,  9 Feb 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1zLS/nCO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A074E22;
	Fri,  9 Feb 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492537; cv=fail; b=rNPwg89u+GoE5YnuiQ6We9xLxD9bLM1ItZyo63SkM7zCh4t83cwb9WvglmDzsjMcOZa1F+xESbinZxLuA2jlANpOz5JVGZ9iEXko2upPG0WyIssNuVE0QywwZ/YAdh194CivKHJAnp31H8K18OCg5BYDM6VdJVfzED56EPVKH8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492537; c=relaxed/simple;
	bh=e8t6/79A11mrK6x8X59BYSAKrFJzmAqs5EkRa8HvN+g=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vDDulWIp/UOR230R1quasY5PzKgQ5by8lljP8z+zd01Kxx+jVyALPzsKq6A2DUJnjGtg4RlDnJMIc45uOlLVJAfan2VkMZC4O4+Rrh5cOCUGe+zVuBHos+cXrtviN7ftqbEf9tTdf3dvdm17kWOYIoXFIefj9lG4tvK4JUpElTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1zLS/nCO; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIO9NoWFY4usolLNH5IXGoV4HcANOgLbwEYDmIQZ/gSgaNuNuCLfh6w9jsclaD8Evb11BqgQ5PNBVKaxRB2XPcVqKk8AVgBiXhyFE/+PYiPnBGfunqfIpQzFfQChuvuy/M7LRtq/fEewqS8yQzE3dN59UtfpRKJ7u7sYAAaFl+YnVB/0ChMdyDKtchGLV2rr/dAGxltdSlp+x98CfQa2JHDaP5fhqHKhOVxrkeYhwLVTY2z5U+YOxkmpOqUEHtMS+m4TKJl3vJWT8cPKUDNcUO8OEF+0jhO4DMKrCH3KISKOcYTtArBFZLCIs/f8SEDrBEd3+FycskMKkV0YKDDxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xmj7B+zoWgIAVPIxqYa1Xf46h9su5NBQ+GLzHl+3pA=;
 b=ZbMcEsbHLyFQe3IWisDVQs2cEH1TfmyRipxkApq0Wmc6Y9Ak9K5rCXSSEn0MHcorax5K3IqDOH59qkqZa4Q86naWrQ6ewRXoe4r0G7hRo89RhGuaWMFKdRk9gRo17mLS7Bwh9+uzLycVqrvz1JcKfE+R6ag/tW8rzkR2IdReQiTZ+/+Bc873QNE/flyAVx3+i76xT3bEGb6/S0OX5VsYITTKTXvU3e6mO98NmduVbyqzzVnZ+Ai/JrwqwsBnJ3VK/fLVHxPxmS23KbJL92KK+7w7U7g3AznYlMq0b0OBb8Rl23diQ+rsg0H1SW6C3FbcZZzO9YlfB1CLFUaJ1t6uww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xmj7B+zoWgIAVPIxqYa1Xf46h9su5NBQ+GLzHl+3pA=;
 b=1zLS/nCOfHwQH3eTzCMq6QiMkx4GhHwX6K+UlLltWF0iw14lOiY/DBHxUjWry2PVx4y7yBCngqpg9N0Fk8ka8+2PGWA4Tc3XcJS0ZUmtJrPH1b+f9gopRhMsF2bWz4PvSmUO+F53uA0HEgaVELn7k/MQ2Du9EoWqI0K2kawjQ/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:28:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:28:53 +0000
Message-ID: <ef4b6a21-a477-42f0-950c-246b5cc48f47@amd.com>
Date: Fri, 9 Feb 2024 09:28:52 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v15-RFC 4/8] x86/resctrl: Add helper function to look up
 domain_id from scope
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
 <20240130222034.37181-5-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20240130222034.37181-5-tony.luck@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98edcffe-db00-43e6-55da-08dc2983d2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bHynLTUJDXjLENq6enjcFrf/zfdbJeV0Nnbh3Yivsz7UFZPagQR2uHZFI1lAEYVDGgtemMy0e7Co+rSQPIq6ei3IeJT9fj3gMvXr/efei3K/9a8MFZi80jR5N4N6Gu/MQc+3Ahr44oyM47o5UvHtKWnfMQ+wqO1MkcKdH3IyZ7e6IzdfbornWjOjsmS0ZD7FqGgwffE8KuiosAyl2VOO1IsLbRrP6uLg3+P1CCBCQpmAtxytl78YDkrCLL8DBohT+S0F+u5oWvgO0YT3BIXIbE7ZIzZem3uPqX8c5sht6heEgmCUkTPgevF+lrI9QJhB/kewmBbus38KIJF0+gqSqdx4D0nhjOLJXPgri9ezYH7y1KzebfZ/XrKjRLioEkE8/DxJnF/XpzHbkpmpjcRqRGWcDq9NfUJyyBH14NZLXi1OtIu2r2EijlO2uwzfoJvu6r+q67CIqIRggVg80C7Ug/87xwvDgXbOImndD3Txo+TQx1EDOFLTygOQUyOeDOD2POHGvrkkXBuqMKyR4UkiAluc3hQ25Pl0jB5v1qEu4zK85/rHpp+LppCZCD8b2N3b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8936002)(3450700001)(4326008)(31686004)(8676002)(2906002)(41300700001)(7416002)(5660300002)(83380400001)(31696002)(86362001)(36756003)(2616005)(54906003)(316002)(6506007)(26005)(6512007)(66946007)(66556008)(66476007)(6486002)(478600001)(110136005)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eThId3Fzc0x3ek5Od09uK1lLTXRIUXVlQ1pJZjI0TDBLQjlzSjlPWkJjL1FJ?=
 =?utf-8?B?cTl1MnJpNnZtMmwrZy82aVhvWVRTdHJTa3VGNC8xSGtVK0VFMms0bCtkVUN5?=
 =?utf-8?B?cWhFTXpkZHY1eVlxVWNBa2h3OVY0QVdDcVE0ZTFFYWJMWE1uQ3RLSE81dnk5?=
 =?utf-8?B?K0lOVlBGbkcxZUJoa1ltUFl5Yk9zZW14RFFWTVRqc3FXVmtWRW5wWkE2MC9u?=
 =?utf-8?B?Y0NaU0g0VUdLekdOalFXOVhoSUpQdWFqTU5FSkxTRUp4QXNiNUFFMXJhNWVL?=
 =?utf-8?B?cmFFc0pwVm1RYngrSXVxVXNhSW9oWUpaeXh0VUhrWDN4Yzd4RHJ6eERINXIx?=
 =?utf-8?B?b3plc3UrZEFYNllsQUp0RHlBQ0JKNnNWL1ExSU1sallTanRKUG91Q1Mzbm9y?=
 =?utf-8?B?UURDWDFDc0pISVJjdW44L0Q3bE83aXM1UXZKU3I1eGlNRXRsV2k0MnN5VlR6?=
 =?utf-8?B?TjBDc1FiN3FEaWJ0bHFmejlGNVV5MDNmWXRCSVpJWERxNGpwdUpaQ1VZUjFJ?=
 =?utf-8?B?bUFkS1VnOEF4cmpJS0tOZ2tJaC9zUDFDdWRUUnc3NnIvVG1ESGo2TGNuTDdh?=
 =?utf-8?B?c0oyaG9zaDhhWHlmZjhLVVdRQUM4M0pjV0QzQ0NJbmlIMkJCRU5xRGdNdEhH?=
 =?utf-8?B?RHREenMxYVJkN1F0MWc1d2NYTjNnRHBOdU5YcUdMZFQ5NHpCNzBMd1FIMzVW?=
 =?utf-8?B?OWVESFVtSkZpTHpLeWQ0SHVZY0FITzFUQ0JwSGZ3b3cySGNWZFhmVjdUM2xE?=
 =?utf-8?B?YWpuUEVEeUJIRmNNM2JOK2NITHF3ZmdtcWtJa3lNOGU1aEZXbkppeHVxaXZH?=
 =?utf-8?B?ODNGU0dnTzdJVzJJSXNnNlN5ZlVUdHo0UHdxZFF4blJwYjExRFJYaGh5ZTJB?=
 =?utf-8?B?ZG54U1RpeHRwVUUrUDdUWmcvVnJNQnViWStWeUxFRFlpRDRSamtNc1JkbUZp?=
 =?utf-8?B?SkNScUZyaUFwQnU0eUVqZDVqbXU3RHV1NFV3M2ZoOWNtaFM5T3ZUaUNuajUz?=
 =?utf-8?B?cytJalJsVVV4NXB2ZllDbGpJeit6UkF0UzhENGhKYnpXdGlBMWY1V3dlZmtH?=
 =?utf-8?B?ZEZpMlNQR1VHcXdndEQwUkh4NEgvd01vU2s1OXEwcW1QV0tYWnI5U3oxOVRk?=
 =?utf-8?B?Rm5zZGttaU5WRSs4V1pLUmtLTEhUajltekF4KzNYZzkvZ0crdEw5b2ZFV29W?=
 =?utf-8?B?MGxJb2doSk1kVS92ZXZFYVpOeUI3b1lQMStaWGVZTkk4c0QrODhoejFxSXEx?=
 =?utf-8?B?YW8zQlpUUjNzUm8xNFdCNjRQRmkyeFpRVGx5eFFsZDFHSnVOM0NSb1VFSTQv?=
 =?utf-8?B?ckVrMXkxQ0t2R0dXc25Eb2hlYjQ1bzFnV3ZrbGRwcGZxTDE0czdWTER0aytX?=
 =?utf-8?B?Ty9qeWhhY1J4bEZqNTdYRVZqYTM1Wmw0K2IwM1ZGbWd1N2NMV0FaOWMrN1Bj?=
 =?utf-8?B?RzlWNVF4VGtTMkJpYVJhSm8wV3dYNkEzNlgwSDczNFdlT2JRRzU5bXloNmt5?=
 =?utf-8?B?YUpPWkVBSHdoNU1WdXN4clVDYURvU1hGMWdkWXN4N2k2MGJZV0s5UjF2d1hW?=
 =?utf-8?B?ZjhhVGQ0TVlnK3pILzhvaVRIOWgxalhncmZRS2c2MHdqVmUvaEQ2UmVjRFFp?=
 =?utf-8?B?bTN0N1JmQkVFZEN4QnJ3UGY0WElBaUhyeUJxZkdad256a3lDaUpYcllKdXU4?=
 =?utf-8?B?QUVKdXlOS0U1ZTQydXlMaFVOTnZFWFZkVjhKZnpWa2V2c0xDem5sQWRKQXFN?=
 =?utf-8?B?bFUwZXNxRXZOVnZrSkd2QWcxdWdUVEdPMUplNTk2Q1loMHNkNndwTC9yRUdx?=
 =?utf-8?B?cWtEbDRqNm5XT0l4OFpqS2k1QjhBMHA4RHZTRHh3QmRWcHVmTGl6bEQ4Y3A3?=
 =?utf-8?B?c3RBYzljRWlaSndPZFRubHJpUy9tWDdsSUI1Q2lYTjRPUFQwTXZMS0FTVXRy?=
 =?utf-8?B?dHFGTzJTMTF1UGlBakc0bWlhUmxYZjl4VWxxeFNWQUtCcUZicjhMTVhOUFZs?=
 =?utf-8?B?dW03Tkg1VlF0MnVTVnNzckE5cytjWEtQR1FNU1lMQUMvbk5veUpPa1AxN2w5?=
 =?utf-8?B?Wko4WThZa3FqeUlpL24zM0NEV0tVcWxJZmNSWVNja014TWlZR3BFMVY1ZkpU?=
 =?utf-8?Q?G5E8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98edcffe-db00-43e6-55da-08dc2983d2dd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:28:53.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Gw29coTdT7Tx+z7QRybZwJ0GilwGBDYp03VuXZRzYP36GNJ5+4cCDEHbfk3e54K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Tony,

On 1/30/24 16:20, Tony Luck wrote:
> Prepare for more options for scope of resources. Add some diagnostic
> messages if lookup fails.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index d89dce63397b..59e6aa7abef5 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -499,6 +499,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
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
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -514,12 +527,18 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  	int err;
>  
> +	if (id < 0) {
> +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->scope, r->name);

Will it be good to move pr_warn_once inside get_domain_id_from_scope
instead of repeating during every call?

> +		return;
> +	}
> +
>  	d = rdt_find_domain(r, id, &add_pos);
>  	if (IS_ERR(d)) {
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> @@ -564,10 +583,16 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> +	if (id < 0) {
> +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->scope, r->name);

Same comment as above. Will it be good to move pr_warn_once inside
get_domain_id_from_scope ?

> +		return;
> +	}
> +
>  	d = rdt_find_domain(r, id, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);

-- 
Thanks
Babu Moger

