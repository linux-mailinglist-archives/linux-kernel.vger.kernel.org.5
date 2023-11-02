Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105577DFA48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377347AbjKBStq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377207AbjKBSto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:49:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07C133;
        Thu,  2 Nov 2023 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698950979; x=1730486979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jVCxNFpE5s9GzlwjWhsQ2cytRc6oZndK9J/AMrliLaQ=;
  b=FNMcyRuzAz7p8/qOpfpT46lKzDk7+2pmyYmS+gZMXZBC4l+OOPwEOC4d
   SWkiyxM+Fluy/ODjPbm/Oll1bqSilehfQD92/+/Jh9Wxos4kf31XYimJM
   7MQiTOm0i6GqX1Z2QrsqCFqnuy6iO20GSujS4zyf5JS02U9RhjtiHaN6d
   OMmB/5tGRiPaP9ftXdhZBJ/Etc0B0aexhNwHBqBbEvAiJj+uYmeA9uRkZ
   r6cXlGbC4+3wHAkB2E/roBq1koq/qD+6y2f62+Q5uu2GwwGkAEydB5PEg
   xhsQBYf6GzHDOijA/sCI5gSWI4SZy5O2mbUN5Jz4VhykV8jphHVrHya6d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="373826022"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="373826022"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9105936"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 11:49:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 11:49:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 11:49:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 11:49:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 11:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN/8BnFitCQ/podyG+7/f0En1hS6ZgPP1D0Y/KgnYWlc0zDWAmuWx7cvYzBOtuwn33ZNGSa52wg/QAyuusUxifwOULmMSsdqxsu9+xasJxEdo/6Wr04NLBj/h5Wa6lHHWSJd1DRF4P/OA30k+u5EHq+9qftunWXEyDYP5v8/YmaOxVQfVbBUIvkHrzDTCa9EGgCEmaRukawQ8IwclxtGyM1PlWIVKTPe8dSx6/zkMZvzd7hqnY0O/BaLHQ8UFmGRPeA9Y6DXdbjd+Cyb/BdP4+TRxTd1JqjIPUt8qBLBrL19HSz8Wb5VgriR+0mS1BQbP6FT4xnWHdKakk6RnGZ7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ETJi++XRSajJJnFyMIO9441hbclFa9y1ebkV4LhS2E=;
 b=AcXVHlltsVNdDDpR0eV5u06dDmv7BmhtfSpe1v84ebrvQFh35QkIkbbNIJJzHlDQD0/UMWH6rbS91MAehIvQbehfeogutGWNC/E9CiYYuySajR3/eHpn6CiYATbDbZEHozjWkuwGAvyaGUTvLUnCLA5fX0hlLhj3++da7ncl5gL6vmDcX2+dyqud8MwuRgyDlRGqcCGPqor4ragC0kqy77SbS4smtj9kMtMOHWYEr23FMO+zY660LFugVVsnfMLocsBh3YtR3sXn8wFC3Wm3LAQTCsfibce6Kt2XU/DUk0TT2sJRam5STLX7lF1FEtNYtt/svo8szYjVoHinj0mlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 18:49:32 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::43a1:419e:8835:cd4d]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::43a1:419e:8835:cd4d%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 18:49:32 +0000
Message-ID: <929f2e54-0778-4376-8cd7-8e1b906924fb@intel.com>
Date:   Thu, 2 Nov 2023 11:49:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] platform/x86: intel-wmi-sbl-fw-update: Use bus-based
 WMI interface
To:     Armin Wolf <W_Armin@gmx.de>, <maurice.ma@intel.com>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>
CC:     <Dell.Client.Kernel@dell.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231102042959.11816-1-W_Armin@gmx.de>
 <20231102042959.11816-3-W_Armin@gmx.de>
Content-Language: en-US
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <20231102042959.11816-3-W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c54c6b-b760-4d7a-1ee4-08dbdbd473a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eD9nyClBr+cNzOYepsXLzvUv5seGHWL6f7Yivd2KWoggj83Sz7fZTNK8G7lip4z42vpfZB/8KntJNLlKvONrKeTJyfmwSuyWNW0Wb+TFNWZ9vkkpKu49sr+3aDfWNXMA3ji2DKd1f+1gt0RlAdiwGxPod03VLiAsU8XXYOPS4pZi0XMWWEUtWPaTixvq0oZKGD76U+LtuZayQ0oDyjEL/CMAaYh71hS6I6Xv5O4ob7PYaTPShs3A0/gbI1+ZyaGMqRySJX1R22wIal26+HMe6+KRsukqangyXDWrr0KcmRBQRLWkGGluXF21JZLrOnKJhgqpGBX28HAKxDerSJYYo7AZev/XNlzlHkgx/KfG+sPpdweU/aA+sEU1t9Vlgi22wvjxDQKv/d/nE1y/o/Ki1ewdKS8lBH+Jn9IOzkzrfi3N1K05LswIPS9YSOWmF24TMLg/2pk9iTUaXXnlPHmpCK68tV8/aWPyRwSU35sS37yNZ2ggcd5I7qV2oguGv03YUbW/e5aWcMvgEOHcz+4mwVGSjHaY+GZSZi2gzWOABLYDyLptU5Jf1eiCJjb1iNZil2mCjlb5ivZI1/LjPsjodEUqty0/No74Aydcupg9rhG4nQkj6OaC0DHSNgJEC+2jveb44ArP01NXdQxZilMdWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66946007)(66556008)(66476007)(6666004)(82960400001)(6512007)(86362001)(31696002)(6506007)(53546011)(6486002)(2906002)(478600001)(15650500001)(36756003)(83380400001)(38100700002)(41300700001)(2616005)(26005)(5660300002)(8936002)(316002)(31686004)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckVJdlYzSGh4eTRxRjVuWjZVVjR3MW4zQUR1bGRSYnlVWjByTE96STd4UkFG?=
 =?utf-8?B?bTBMeWhsTUtmK3psYW1sQ2l3NmJGRkduRzRIZmd3d0NCK0xrclNpNUhEK0NI?=
 =?utf-8?B?MGN5YU9YNzhlUjY0bzZhVkdmTW5hWEtnMmozTUtQYVFFSTB6Q21NQUlCQnRx?=
 =?utf-8?B?SzFIRWwvTnBOV3VwVU00WWJleStzYnFHSE1uanM0eTVSbG1wa3NxdkRMQW00?=
 =?utf-8?B?Unl2czFja3dRdU41OWc2NlJtaVRHak5NS3VLWk9tY3Rzam1nd3JBdzZ2OVhr?=
 =?utf-8?B?V3VlWWNyeGpOaS9rNUpSaGtDZ3Q0bkx1Vk9qNGNxb2pUK01CNjN5SFBReU1E?=
 =?utf-8?B?VnZYQnZvNmp6YytiSzRvR0hDMmlRWlJ4RFB5MWFGbGJCeE5uSS9qMDZlS2Zm?=
 =?utf-8?B?UEVZY00zUlBhMWFoSTh3d21IMFllbTJpRUFpMzdydkx6WUU5a015Vzk4Z2Vr?=
 =?utf-8?B?Vk1BeUwvWU9DdnliK0hOZ0hla1ROUDlZUVFJd3I3WXA4UWJKajNualdBdkZN?=
 =?utf-8?B?Y1hkL05BNmpzdDZ6dWlmQTlIYm1vRi9hME16OGp0cEFFRW5zSWVvWnRaYXI3?=
 =?utf-8?B?OS94T041YUtKekYxcEdDK2RaVjA1MGNZUUptUnZaTmpUS09TVjVqMkxXN1Nk?=
 =?utf-8?B?d1VnRlRDRTZLSk1zcHdkaVVXL052b0NWekJ0WTJkZzYwdU9TeTVYbkpLbnNi?=
 =?utf-8?B?UTQwVENuaFZqbEJGMjJJMHdTSTNDREdWbU9kd3F4UmhXRXo3TmhKVkNWTE9Q?=
 =?utf-8?B?WDRSQzZoUWI1SVFpaFJoZ0ZXeWI4ZGJKQUpJYWgvTVVaNWxTQXlnWThVR3Rv?=
 =?utf-8?B?NXRuREI0cFZ5bEVZYU5JUWx1bjE5enQwcHlRbEQ3ZzRQQndJRFlxOEtXc0RU?=
 =?utf-8?B?Zjd4VmlvQ3B2T25tUVJYSXUrUTNGb0Y5SXkzbldLNndsSTFobHRNUUlvSGpI?=
 =?utf-8?B?dkNvajlJSXNTUTlxQzFEZDdSM3c2NWRQK0hpK3d4b3V0NmlWRnl2cnNOK2p1?=
 =?utf-8?B?c3BEUWlBSTJQSVlqZGFYZzQwWkJybnB3K0RhMWp6dVFrYjRKODFSYlFpZi8z?=
 =?utf-8?B?RGE0VUZadzNnWUlySCtXVGUxVC8zUmFLYkRHcm1kMHVJOGM5ZFRVcnhyeWhX?=
 =?utf-8?B?SGkyRk04RVA1OUdzb0NTS1FsNkVlQXBsWHRPYWE0M0I2R3FFTW9wOS94K1Ey?=
 =?utf-8?B?VVF0REx5TkpCZTV3OUdXdzhJc2ErRjlPUWtuSmcwZUxIN1NCcTdNT1d3V1F2?=
 =?utf-8?B?SnA5SEV3UFRtK1dPQWthdW9HL04wUHR6MUY5S3liZjRLdTMyZXRGUWJmWmNN?=
 =?utf-8?B?SFhrS2Q0NVZzZ0pwbjJKeVNkU2tQcllzL29rL1VnUGlpWUIzaWFOL2NjVWYw?=
 =?utf-8?B?WnA4QjRVQ1NXcTUxbTk0OWpqQTJoMGdhdzVjTmpQL09idEdrb3p0eWVEYTB0?=
 =?utf-8?B?QXdHcGhUZ2lRNEtLNGpWOWh1V0lDMnpSMG9JWXJBQUwxUEVmRjlHd2w1aXZw?=
 =?utf-8?B?NFlQekVBOXdpOThkWGkyS3RCL0VBUHFqS1JFZDVUOGo4dS9QbUUvSEw4RWhk?=
 =?utf-8?B?aG5YeWFtVmlmYjF3YlVKdHd2dWR6YVRqSC9jYmUrWS8yeVVpRFowZTJkeE5S?=
 =?utf-8?B?YVBKRFFvOXBxOTlydy9kWWI3NDY1VFJ3UU9ENktFM3FFb0hIek9jZkJTckZW?=
 =?utf-8?B?bzJqZkt6b1RXZkc2OVNyZDVLZXFtd2JVTXFKS1lrRWY3YkxPR1JaenAxTWZF?=
 =?utf-8?B?OFpQUC8vZ1cvVWZ1YjZIK1hkSjU2ak9IMnlEeGtVckxXZ2VIeUtDWDhRZVY1?=
 =?utf-8?B?VTZoM1V0RU16NXhJbGptS2I4K2ZtVlp0MzRxUnhycVYzUmVxYSt0SWRTTVJU?=
 =?utf-8?B?WGZNNVBXR0xid3BMYVBvZ3ZqS1NKbFVRYXExZjRPOHdoLzJFRlBFcC9PdG02?=
 =?utf-8?B?VG5JYWU5QnlqRWJsdGtPWk5TUTFqcVBiRVM3L3RxRGhhK2h6Z2RBTy9ucEwy?=
 =?utf-8?B?cG9uTjkwYTh4VUJjVDI0V1lCaUdIMDU4d0d1WXZhS3NmV1p4MFpOTVN1TXZa?=
 =?utf-8?B?UDdZL3VOcTB3U2tGQXM3TFpCVWhRZVNVZHJHaENUVmNYclp0Y0I5RmxoSEE3?=
 =?utf-8?B?WEFFQ2JsMkIyRlR2dytqUmhPdUxpamh0V3RCSzNMSWhWWHJ6WTVuUWtHeWFI?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c54c6b-b760-4d7a-1ee4-08dbdbd473a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 18:49:32.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f70TMxx6+ZioU67gj3kNXhuYMuEYGCfMFQUT0LuP+5j4nJWeQZWx0e5YrqgsbFqIlsN9fjO1rDoWxrO8PweX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2023 9:29 PM, Armin Wolf wrote:
> Currently, the driver was still using the deprecated GUID-based
> interface to query/set data blocks. Use the modern bus-based
> interface for this.
> 
> Tested with a custom SSDT from the Intel Slim Bootloader project.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/intel/wmi/sbl-fw-update.c | 13 ++++---------
>  drivers/platform/x86/wmi.c                     |  1 +
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/wmi/sbl-fw-update.c b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> index 3c86e0108a24..9cf5ed0f8dc2 100644
> --- a/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> +++ b/drivers/platform/x86/intel/wmi/sbl-fw-update.c
> @@ -25,18 +25,13 @@
> 
>  static int get_fwu_request(struct device *dev, u32 *out)
>  {
> -	struct acpi_buffer result = {ACPI_ALLOCATE_BUFFER, NULL};
>  	union acpi_object *obj;
> -	acpi_status status;
> 
> -	status = wmi_query_block(INTEL_WMI_SBL_GUID, 0, &result);
> -	if (ACPI_FAILURE(status)) {
> -		dev_err(dev, "wmi_query_block failed\n");
> +	obj = wmidev_block_query(to_wmi_device(dev), 0);
> +	if (!obj)
>  		return -ENODEV;
> -	}
> 
> -	obj = (union acpi_object *)result.pointer;
> -	if (!obj || obj->type != ACPI_TYPE_INTEGER) {
> +	if (obj->type != ACPI_TYPE_INTEGER) {
>  		dev_warn(dev, "wmi_query_block returned invalid value\n");
>  		kfree(obj);
>  		return -EINVAL;
> @@ -58,7 +53,7 @@ static int set_fwu_request(struct device *dev, u32 in)
>  	input.length = sizeof(u32);
>  	input.pointer = &value;
> 
> -	status = wmi_set_block(INTEL_WMI_SBL_GUID, 0, &input);
> +	status = wmidev_block_set(to_wmi_device(dev), 0, &input);
>  	if (ACPI_FAILURE(status)) {
>  		dev_err(dev, "wmi_set_block failed\n");
>  		return -ENODEV;
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 9d9a050e7086..4c4effc883ae 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -106,6 +106,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
>  static const char * const allow_duplicates[] = {
>  	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
>  	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
> +	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
>  	NULL
>  };
> 

sbl driver specific changes looks okay to me
Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>

Jithu
