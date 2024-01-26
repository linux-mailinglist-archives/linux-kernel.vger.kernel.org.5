Return-Path: <linux-kernel+bounces-40300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E483DDEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC1128652A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCD91D52D;
	Fri, 26 Jan 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cmwp/gGJ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D81D526;
	Fri, 26 Jan 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284033; cv=fail; b=F+Xz4JL/yn/SNVY9mgGreow7HxvBkeqSpv/j7xYwCjLl505UXSv5Z7YzKvAPtLfeo4HEOzq6L0ziMtIIwsR+t8AA30USox9fHlEintps03dQj/fKmuR13jW1Q5CSVsA60bmv2AR3fhJAY1AkGO/CEH0cvq5s2/LnTGqVoXihTbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284033; c=relaxed/simple;
	bh=HuIwbWI5Hn1p73UIQLPeXb6UJClJvPAhG1jX0NARoxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D/m46M9Ko6iPP+WatLAtcfgnpv8a8YQHe16ocmap01H+8d3vKZzVMAJu+Ucx1QVR++Hh07pJOl/40ZxXDDQ5bw44W+7JyzrCdJBmBxQxm58oae6s+TReCt+BVtg0Hw3L2Ol5DrK71EW3OJLx737oURTXY+F8qWp5268ErFMfc/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cmwp/gGJ; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tofv78n6Fh18d6HIQ6HVOvi79fZgLADZ0XmsNzThJQnG8lxdUuqBTN1ZayOy4HktH5FjxufnYKYqAAdZbzY18Nkyh1LMhk3vgHcpuWYfguo/ES1C7ZVZ5g+nVPSabJDRprrHdk9XKtGWMCTGoYNhQV9aZE3pHyL09ihYmgNAO2fsEw5SXejZmOpTsI6ZUqZlsBVet3nksQaJ+bokhKWZ6NAXewkBl4tqNcdN3GVMlEwM3PQ03g9a+LLweIQpV4p4fajqXgNhAOBm1Kxv2TaSExEyh7Fsi1QMnynXLC6oplM/C0tgUnvUTIPjS0Rxgua0aX+y+9N/gkONRpPIz5h1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGk7Dji3aBiW3D7d1l5+hqHSvKp55xq2H4pHwoAON5Y=;
 b=jhQ+EDOcxRL9BIklo6icdFc/YWY2LqPhovP1geV2JIBYatzzY3TSq/gZCpso+HHtrHB5yTiGE01Yfcv7P1yQpv38vbGtY8QdJwA4Qffb88jatBEeMdVB1aU+J3HS75ySXkapo4prUyC1FU00QSRIfdoSvu0f8N+BUDFXNp+7r6fHUL/Mzd3mkWIAfwPNXafK16iaXRwPYCVx9X7WwEImbFCu0K30urGMTLQGjGEwONRGfYdUumycBawrkuZZSA8VrUoovEsPkQu7xIOVWNMQhYuaJ0ttymS3QpvpshWcAv72Xv9R29R7mmMRrehNVB7o9mhuXPSYssgAccSH85g2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGk7Dji3aBiW3D7d1l5+hqHSvKp55xq2H4pHwoAON5Y=;
 b=cmwp/gGJ+LV6nOFivB3mzJVvejrIjWjnniypHrJSzyoIx//LFwtghFCSyM042GYtCkfGT/y+T3v205vTvRaXF2kpEHghixT80hnVXpmyVyyC82b1HIjsRXScza0Xrojgd0KU5jQsOB8h4P1cT/LWvuJZc9hNn7icxxgelZfl3gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 15:47:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:47:05 +0000
Message-ID: <4dd2cf49-9fd1-4ad7-81ea-8de93e8b27d1@amd.com>
Date: Fri, 26 Jan 2024 09:47:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] Documentation: cpufreq: amd-pstate: introduce the new
 cpu boost control method
Content-Language: en-US
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1706255676.git.perry.yuan@amd.com>
 <1be9c97cafb1406a607184ea48dcdae883dc4cd0.1706255676.git.perry.yuan@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1be9c97cafb1406a607184ea48dcdae883dc4cd0.1706255676.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:510:174::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 395b010c-44b2-4291-6836-08dc1e860c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MIO5LUUe+dcC7HOWSK7SyoMFAB+uc/MKH04TdLvNVdeMo16KP9CcIeMv+qXhur3iun96314zekmlVWqvhog/2D19qqZpVJtxaVxiJVoXUK2kvPV1Bpu91i69QSYE83mFMfX4x/x7hvCfvfjVhOiwMJ1nBCIwotFwbPOW7QyHDgeGwAh67trkJlL5qIYrDxcbdSpWJYG+Oe9ZLGmqJDWBDnXB44yGmuzLdgGW6VSZLabAfMbTNPO3xf5e0oMtExLFYddJRMFa3sT5aBVzGxcJA0LC11jWtVeV0M4XWmsHL4KcJvBmuNwW6AUmAewoNGOGUCPXRlTRTvIAbXFHfROAb1vn4yT8o+P7hBfQmhL3jJAgCHfSIJeIoBU/4qUMl7zUlt4cBUIR0Fz8ryPAefxiJqnPV2sXsEQ7SkAL/7nKytESYlNUm4bptoHsXdyU178YHMz4lcTxlCWMTwfiKl68hTATtlu0hQkQgpxO6DGsgrNQvpupeitz49g3ovCWnAf1tvhzGkERPfl3yPcPS25M9HZ8EA5N6vP3e/XPNNqj7oMUIa0TZxhq2qjAullYb4g6gEt/IZvZzprlrsalsgfkwJ17yo7ZoOLOyULsDv3QBrhHRuY6gblmztx52mXRKT6iA8YxtCL0jcFAx9qPqua9fQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(6486002)(4326008)(8936002)(8676002)(83380400001)(44832011)(5660300002)(66946007)(6636002)(478600001)(53546011)(6512007)(66476007)(6506007)(66556008)(316002)(2616005)(26005)(31696002)(38100700002)(2906002)(36756003)(86362001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkZmSGxoc1RRbHdxOTF5dEpTVUtUUzVXUGlGMzBnNFkrZWUwSjRJdXRGTE92?=
 =?utf-8?B?WDN4VVZsWjVXR1JSYWlac2JVcU5CZXB0d1NaMm5XeWZ3Tk90Q1NVc2pFRHNm?=
 =?utf-8?B?SnM0L29VcDNEaUhNMVlqYWhNV2xOMUV5WUNyYWw2OEhNVm9sR0JKTi83ektQ?=
 =?utf-8?B?OWRqWU1WWEwzeFBhYUp3N2NGUE1MZTB3Q2Z5THZ2U0VYWlVQZlVsc1ExVGY2?=
 =?utf-8?B?a1NVdDM1ODdkWUFMU1QwOFd0WnpCTW94Y3RrU1lXQmI5ZGtNVEVPTlhhY2RV?=
 =?utf-8?B?U1V2aWF6WE4yelAveGh5cExjUHUzOXZRc1RwQ0VjNmhza29wU09aL2ExQ1Zs?=
 =?utf-8?B?UUtxZTV6ZWcwTXFCdlVKMHRBeWZaRXNNdnE4MWNLUmloQkVJRkZtREg4d1JC?=
 =?utf-8?B?dG9rZTIrcXI5VFRZN1pmcURNWEtTVUpKcHFTRkFmNTRFc1kyMndnMGc0VU9h?=
 =?utf-8?B?R2g1TWNWdHhTc1NCVVBPNEh5VnN6SnFxdTdqR0NOTGl0ZFBUbFMrZG5tQVhp?=
 =?utf-8?B?NGdxdnkrM0JnMVpBbWUwS1VpL0tYNVZrbEdqZWNveDQvVW9FMnRsNm5UNXNS?=
 =?utf-8?B?Z3o4c1N1VDNaWVNiQndvTHVNNGR1d3hYeFBUQWFjdTFwbWU5MEdCNXZtdlhu?=
 =?utf-8?B?NHk4RS9uSkV0NGMxTEEzUi9aK2d1aHlrbUtycHJQTHdlRWxJS3JUdExDaHNX?=
 =?utf-8?B?dHFaWFNNdUQ5dWJhZmZ1MS9yTzNueE5RcEVWZjRPcXo4bEMvYTFDSFg0VDVW?=
 =?utf-8?B?NzlGS2tBSWdodTFiWlZhdWQzTHJWQXYvU3ZYUVl5ZjZXdVdtODJpVmRwNjRV?=
 =?utf-8?B?S0hOSlR3b1RQNEorTWhBbytFckdqWEtKVGExTFdEOGV0bmQvQ0pQT0NTR1ZL?=
 =?utf-8?B?NlNmY2hmT0FibG9oL2w2OXlTTXh6YmdSeDRjZDlkVXl2S1JwUWlZdzNvUm5l?=
 =?utf-8?B?aEh2VjhZbzVEaHcwcXVPdFdwT0luZ0ZKdzRpcGpaV1I2Y2xSM3lzcmJDYUtu?=
 =?utf-8?B?R252L1BucjFuS2xtSnBYS3VuM0NPWGRQWkl5aWJkZDZhR1hZRm1xdkszUjNx?=
 =?utf-8?B?L0RVcGNIVE1WYm41eVVBUjgxUmVPSk9aRGp1NEdVcXk0S3pRUS92VjM1dUhY?=
 =?utf-8?B?MWFpaEZIenBlZTIyMVQxRFJ6blVRS2hDTkhGSW4vbjU2NzJGMlowU3JrTXEv?=
 =?utf-8?B?UUJIcTl6cWNLYTZnMjVMb1BXRTd1KzRiV00yUEo5TTdIWG5VYjh2ZytyK2VH?=
 =?utf-8?B?UEh3MWRFK0VYd3R6Vnl1ZHFsbXhJZ3ExN0xDZ0lBeVVwWXR2ZGh0SncxVXlY?=
 =?utf-8?B?a1pDT0JzK1F5UWZsOHJEZEN3RFBla0JVd2NBZEp5V3pSd0t3WWhIVXc5TGtq?=
 =?utf-8?B?VXMvVmRKUnhTaDY3UnVObnl3RUl5N2FYVlRSSnlBYzVUQmNnVFR5R09RYk1M?=
 =?utf-8?B?Z1N1a1VkWVB1SmhNdnBVVElpLzlzUllsd2lnT3o5b3NsTks3UTlFNnRMbnpp?=
 =?utf-8?B?RmhFNTRNeUJCUHBwbmdzWXJ6M0JsTlRkblBySlFrYmgvNE05RlcxZnQ5MDB4?=
 =?utf-8?B?RVJXWUtISlp3MGpueStWdGVPNWhuL2tWRUJqYWVRbEZyMTBuUnA1YmFRK2p4?=
 =?utf-8?B?cFBMODRXclpsdkc3WHN6cmFBV2plbzcxbnhnc1Y4c253bEdRZ3R6RlAwNHF4?=
 =?utf-8?B?c3l3Z1h4aXp3T2xmQmJYS2dMYTg5MDdoaGpQN1RzaTQ3emFkY0NQeStCZFNv?=
 =?utf-8?B?VUpvdS9UTW1GRWN6Tks5a0tvYmVKNU9pQ3YrOUx6U09oaWRsTzYyNTRFamJi?=
 =?utf-8?B?OFFpajd0Q3M0c3Q2TnJoa3MraHNmUitKRzYxeVBNNE5xVDYxS3QwYm8xUldx?=
 =?utf-8?B?OUFac0EyVjhIVXhkbElSQ0ErL0pmUWxja0haekg0eFhWZGs0eGROdTVCV0tZ?=
 =?utf-8?B?S3oxMExrRkF0RUJxeVprSDAzQzVXNHdYSXdFSytCbm15YWZzbGkvQzU5LzBr?=
 =?utf-8?B?S0ZSL0hNZU1DbitHSmQxVDVFQXI1OElUQlc4RTN5cnBYUTlJMXd1YnJqKzNN?=
 =?utf-8?B?YlZLY3NTK2dxd0xtT2VUWitEVVpxTWx6VnI5aEJyN2tyMXVZR1U4d0tCcUZD?=
 =?utf-8?Q?rR8SlroP0f9J+8QXQlb13LcU/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395b010c-44b2-4291-6836-08dc1e860c17
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:47:05.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxuvK2HcUYRdSSMf0VsmRu4sKMR0gBLwW/V8P8VZf7g6rLNhC2tA6OmjpmDn+MYS6yhQFQat6j/qldMePY6NKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048

On 1/26/2024 02:08, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduce AMD CPU frequency boosting control sysfs entry which userd for
> switching boost on and boost off.

Typo in this sentence.

> 
> If core performance boost is disabled while a core is in a boosted P-state,
> the core automatically transitions to the highest performance non-boosted P-state
> The highest perf and frequency will be limited by the setting value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 1cf40f69278c..d72dc407c4db 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -385,6 +385,17 @@ control its functionality at the system level.  They are located in the
>           to the operation mode represented by that string - or to be
>           unregistered in the "disable" case.
>   
> +``cpb_boost``
> +        Specifies whether core performance boost is requested to be enabled or disabled
> +        If core performance boost is disabled while a core is in a boosted P-state, the
> +        core automatically transitions to the highest performance non-boosted P-state.
> +        AMD Core Performance Boost(CPB) is controlled by this new attribute file which
> +        allow user to change all cores frequency boosting state. It supports both
> +        ``active mode`` and ``passive mode`` control with below value write to it.

Does it also support guided mode?

> +
> +        "0" Disable Core performance Boosting
> +        "1" Enable  Core performance Boosting
> +
>   ``cpupower`` tool support for ``amd-pstate``
>   ===============================================
>   


