Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09337E323C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjKGAbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:31:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3F1BC;
        Mon,  6 Nov 2023 16:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699317108; x=1730853108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3FMC1RtLp0ZPK8mTXj6abySWrGdIKa1PRt+JzLRUY4=;
  b=msgB/yDZrlD0cVz7jbZsFpmj14jwFVWLuQSAGTa7uo5oYG+TBAI25/GK
   9uHPClmhZ+//yIvCS2EA1TzJLNMBJCzeb8qieLF+Q8mb/yfF7ib/1uM6N
   MDh3upFvitxhYLlcCL3d/z5afeK4ql6oapEDw2/NJSq04Jukr583sZ0EL
   GVMstx8J2zrTpayWQ8+EEL1r5l17+aDQhN9ZrLSWRlFZsHSWfn813MyZU
   ig5IaxvfKK7YQa63sVhEX9MBune1AxiT9LkM9ZYk87e7k00aIGueQhhWe
   EOyiJ4qqqyB6pmHUC2FD1JHDL5qTSRMILjOVpB1rU+4GYKyJK/CeQSNvT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393289697"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="393289697"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3799661"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 16:31:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:31:47 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:31:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 16:31:46 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 16:31:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9AyUcGutWQqSATmGSD7ph3W4oW70vYO9aHo3ZmygnTO2RvA0B7B3FBCFOa2Jm3QqM6JKIu8gCgJUrobuQKH4HtiXoswuBsa8FweBhBMeBQLiyw6T7OkD1ZJwunF6xBaf2z7r/zMCdnWS1YIYRv203ouTYrrWebaMLz3yQu8EZjKwOufe1WL9/xuC2aGbL/rbDaEUxZA5ejxhktBmstfRDbJRsGBTfH/P5H9IVQ216eX+aGdUYvUfgrvqp+eOljVANkWRyXa/eCPnd8GZ0+l6Uj0+optiKrs312MKj00hgpinRV1/TbtpIbhNdHJTP3YrfA0iarVysC6Jc9awRWDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EdzMhgb77oCCWKGEVGrBGLEI0D/TbtupJFcefheExU=;
 b=C3ufRAV9np92b8k/Fl1VAQm4Q94vI7BzVoSWHtmjsUSMRgo/nzAYBIv9bvbJfsY1xZhh3wpBPA6hSnZXSAszAicEfnR+Utx4ktiO1usOP98SOjq3GIAVDg+FqUhnow3iP+uVBr5HTIOqfrsi3V7kKd/0+twhjnX7io3/cwbi3f7uJILpBRwBOVW1Cqpn6FbbLTSoOXvc/vhhxSWiEuGbd+V4Ar1r0VI9tlldUiGaExZAD0uLYY625Ut8tZfJWPNMlFQzlMXiiM70/5ZWM2ki+n2qQHfuPS02cxe0sXcApyEoANb1XHomd0Mn1PUupAUU6CWGMMa2OKP615rC6Sv+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 00:31:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 00:31:44 +0000
Message-ID: <f91ab4e9-726a-4c9b-b91f-6b419414f96c@intel.com>
Date:   Mon, 6 Nov 2023 16:31:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] x86/resctrl: Prepare for new domain scope
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231020213100.123598-1-tony.luck@intel.com>
 <20231031211708.37390-1-tony.luck@intel.com>
 <20231031211708.37390-2-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231031211708.37390-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6439fad4-5936-42bb-1f3b-08dbdf28eb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EQaQpRgm0TiUQhMrwSlxudbLsmLFyuiASsKZAWzrSDjFSbYGJEqunYLqVcWw0A0Epabila3faoqdeq9Nw5gdAzVxnUsCmcekPVd7chTDYuuKywfW+LgMkxVWjnTlGFBwhXhRGaajRo7h6YEUFTAjvzoiRe4QcI4nItTfiYIs7z5DpAW1LJEDvUew4X/qE/2fjVPFkR9panlYx3alhBI1xthbuh8UFx8UbXd+8ITvOr9fILi2wSRHOLar3xLcu8qTDG4ZMHCpgAHmJxcRAfaFRO2r4l63T6lB/dTFRi/zXzXNckBf+Eo1GNPIkofHxIRb3pXpdPFPIIVHrzTLq9GD6aCU/omq0F3gG/37rEbvlgRDHZ8/FdSDJXsG+OBQs0wDKuNrgmoKX4DFKRWl9RRAmcnUrU60VhGPEdBN8K/RmYh3nsIkHpVKuAc/wsELCOnxXeLsRsBDEJuFg5T70D0r/ZaRPgLLaj3QIWWMp5nmdAkbd9Z9/rnLOos8ZSS09cqA2O+wyiQNWWSTxjYCf/BWkFfBUxrquKxJw4VX+j6pBApKTFwKkZT4d/WAKU1nNvH8GLuLPu/cs+D16nkZkedVbO7M5OQ425MQuSdNtRMU2X3puTiGRApC7+yJ5XmJbSDHoH5SW/FqAW6Wple2aG6LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(6506007)(6486002)(478600001)(2616005)(53546011)(2906002)(41300700001)(38100700002)(36756003)(86362001)(82960400001)(31696002)(5660300002)(54906003)(66556008)(66476007)(83380400001)(66946007)(26005)(7416002)(8936002)(44832011)(110136005)(8676002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBNYWNyeE5DVnJnVzhhaCtwVlo5NmNPQ1BXeHJwaVhjaVNJZHBJZm43blBi?=
 =?utf-8?B?RUwzWHFqaGErSkRPMWNPSnFsOGcwZ2lJZm5nTnNhSEo1WFlVQTBubDlBRzFh?=
 =?utf-8?B?azlhWWdIY0pudDRrUFlqZi92dkdiUGNyRXQ5emM2RmYyN1BHMEpWS3h5WFJ3?=
 =?utf-8?B?RW93ekJZMkFjclJPanFCUDAxTTU1enQ2TkZXWmsvRStNaXZudlRNTWFhVUdI?=
 =?utf-8?B?d3ZRZFR1K3lSUXJnd0E5RjM2NGQvVGFORnh3Z21RcTVGbDg4KzZTWkVwT0Rm?=
 =?utf-8?B?cUMySzBPbFo3U0hCNnVaaHVJcHdiZWpoUlU1S1FYdlZNcU40azhhZ2h6WjRw?=
 =?utf-8?B?TW1nNUFDVm9rS090MkxweHROdkhJRzVDVWFQcExnV0JKMFFsTTdxQ2VOdFFO?=
 =?utf-8?B?dldIbm9VajlyWWM2TU1RY3dEbjRCMDMrK3A5WUhtcEp1cUN5WG5DZjBhWDA1?=
 =?utf-8?B?dDdoTmFhTHRUTVUxaG9DR3oyWUxIMmI3TzlSRjZ3dndJTk1JTkhJYVdUczNC?=
 =?utf-8?B?RDZqbUU3ckJLaFdwdkdXMDRObll0Rk1PQTJZbExQUVlJU3BOQXNXdzdrSm9j?=
 =?utf-8?B?ZW0wcUhtV29lWHlqNnhzQ0lXN3o1Tko0OG9kdlB4cDRYVUIyMzA2OTlrVDRl?=
 =?utf-8?B?cTdadDJEUnVYKzcvUGpKdTZIbzVCSTQ5MFE1a3p4Y0NoT3o1U0JDMTZyZzY1?=
 =?utf-8?B?VS9WcnRFdys2SzB0ZGpncnNvQ0hscGllSWk1am1HNFpKWXNSSjZLSWdxN3ox?=
 =?utf-8?B?ZFFNVUVFdkVNSU15NEt0TjlLZWJXWE1nVDVMSnFNODI4OHRFOW5xOUdGQlRp?=
 =?utf-8?B?dmRCNjU3Mkt3R2hNeHFzNmlWUVpGL2x3WWlWRGRUek9tNWpSWklJR1pjM3cy?=
 =?utf-8?B?R3hYYnY4ZTdmUXQyeWl6YUVQdEdoZDZ0eVhFS0tqNDlzWHFhSFM3d0tPZEs1?=
 =?utf-8?B?WlBkbmpNbVV6a3U2aXhZNTFLeXh4ZFhZOGxoV3JtMzl6Yi9NdDZFQ05XeFBq?=
 =?utf-8?B?V0JiUndjMUNEbzBqNmhKNzlnTW9VYS9CUGhJcFRFOHJ2UURQWmNFaytDaTlm?=
 =?utf-8?B?aWNwM2JsYkE5aGtsN2U3eWpSNFlxNDRmQ1ROYXRzZXZ6SnlUTDQvak94OFMy?=
 =?utf-8?B?aU5vVGRlVHBiZnZZTW52VHp1MTVVbVZyR0FzN2NPamljRUgvbTFBNmRXMXhQ?=
 =?utf-8?B?M21OaGt6bE1EWjlpSmRIU2NneHJlVG5tSjBCVXlvRFFTbGc0ekVVTDlXcFpR?=
 =?utf-8?B?ZnRDM0ErWVBxQ1lEeFFPTStkRW1zYlI2K3BGT1ZPRm5YL29yNkMyOEVMaDRk?=
 =?utf-8?B?Q0pSZkpVYW9ZR1JGV0xwMUpzbFFwWWtBRlFqRmVXbzl1S2Z5Kzl0K2t1Zm9u?=
 =?utf-8?B?Y2JpK21TNlRyUDNGTEIwKzdkdFBWR1FjK0d4WTZVRW1iZUxwRElqaVpHb0VI?=
 =?utf-8?B?OEJDN01ZMEpHdUZlcGNkQTB6MWp3NDdtOEZWNXRIUUVPRTY1bTlVWEdCblNE?=
 =?utf-8?B?bmREODdvUDFnZDVJQ2JlZ0g3VGsrM0N2MTA1WUYvakJvVXJZMWxEYXk1TUhU?=
 =?utf-8?B?eW92b1NrTXB0S0tPbUpEZldWcEtScFFhbVhQUGVad1dNTmtreVRNRHo1UUhY?=
 =?utf-8?B?UkFlc0JZMzlmZkJwVmRsNUI5S013bHE1b0ljMGNablhoZk1iUWJqcnBEVHFr?=
 =?utf-8?B?WUxOenIyUlRLeEZ1bmpBZGs1ZXBFZ3Q0eVYyMDRzMWh3Y3JBU1pvOElvNml0?=
 =?utf-8?B?THpubEdrcjZ2WFhBZE55TkVqL29UaGVzcFlJOE93dHpLQ1JpZi9sVFJwV2tT?=
 =?utf-8?B?YnQ3eGkyYklYYm85OE5LeDJUZUlrSnZqY3NOb0JuQXJOZEpkZkhrQUJGRFZU?=
 =?utf-8?B?RlVuNnlUVnBZN0k3N0c2S3E4OEFoQ04za2dQVDY3MnBPRTk0bDRZaC9QSCtQ?=
 =?utf-8?B?NVRBeTRkaDBXR20xcnord0ZmdGtVa0Q4dVhUbmZ6Y2kvS3R3eTJLclBrODRi?=
 =?utf-8?B?cEoxeEpaSm9GVWZvdlVRRkhXZk1yQmVYTk4xMjZldzk1cnpzY2JSQjNiVjNU?=
 =?utf-8?B?VkNuazRiR3lXMm91clJpVUQvb2IwSTIyRXVYa1I0VGVKb3BWeGVsQk9uazdL?=
 =?utf-8?B?VVJ3QXp6V25ZR09RcHB5Tjl0b0NUMGhrUVR2VC9GRkpzc0MvWjlXbHdPaVNY?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6439fad4-5936-42bb-1f3b-08dbdf28eb7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 00:31:44.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMxId5CPmCk7Bd3q4QNpGSz6tw+nsPqNaKcEdOLKFgW97N+V+JE1FVcZmC7MfL82F8bO6NeAaO6ro4hnWmVhSCSp7sjzde8CkCIbMLGazWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7614
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/31/2023 2:17 PM, Tony Luck wrote:
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
> Changes since v9
> New test for invalid domain id before calling rdt_find_domain() means that
> error handling in that function and at all call-sites can be simplified.

These changes do not appear to be consistent in this series. Simplifying the
call-sites is indeed done in this patch but this work seems to be undone in
patch 3 where it reverts back to the previous error handling in
domain_add_cpu_mon(), domain_remove_cpu_ctrl(), and domain_remove_cpu_mon().

> In pseudo_lock_region_init() use the new enum resctrl_scope for local variable.
> 
>  include/linux/resctrl.h                   |  9 +++--
>  arch/x86/kernel/cpu/resctrl/core.c        | 40 +++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 ++-
>  5 files changed, 44 insertions(+), 18 deletions(-)
> 

...

> @@ -506,17 +516,18 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
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

Please add empty line here ...

> +	d = rdt_find_domain(r, id, &add_pos);
>  

... and remove this empty line.

>  	if (d) {
>  		cpumask_set_cpu(cpu, &d->cpu_mask);
> @@ -556,12 +567,15 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
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
> +	if (!d) {
>  		pr_warn("Couldn't find cache id for CPU %d\n", cpu);

This error message is no longer accurate.

>  		return;
>  	}


Reinette
