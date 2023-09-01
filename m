Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61B79027E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbjIATdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIATdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:33:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4DC10E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693596818; x=1725132818;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5CElTFvJWEY9c2OYJIO4Y6q/zTg9pxdup+PsOhDI8Vo=;
  b=ZX01XkEQn58a0AQG5BECz7Hmya7QZsRARMvk6Q1HMGjwy2VLNYt1uZvK
   wZE5c5+ysaeNZU4lf2jTYDLKCo3vPCIl2ewwJPUukU45GVh4HVw6DrrYk
   RwkrMI0R3Q+kSMK3XOzLCvV3SkxAvg0IcTIJX32ULgmznuOuDN6bftgz5
   Mwvoz5tZF12Enamj51g3eqfsyTd8Zzy8/H+w6I+e5EPFsGPVjW0o47c93
   S73B8/ox/17gcixXaUZlUlat9Gju0EMvUEhgWLisHV2oHA4I0uYmYjcEN
   FvopFHeEL/JdhKrYfgG315g6Yj+eZghk8Mwg5sJ2TZc9SO9Jb5fK+rL5g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="380078257"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="380078257"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 12:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805548213"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="805548213"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 12:33:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 12:33:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 12:33:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 12:33:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 12:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nB9hV4sZpCZueHYA5tl9kjBdG3nSSUNZlQjFgrtpaJrkhwVH8du+czSrlT6sZ8qXeeRGdhediSO4TeVLpNwluLMQ3com9tmFEF6EkFY/WV2upHxAdhwvqKO+eIMaWU9XaoTzGGyHmBtLmwMvoGOXTG85INDKgIOmTvxqC0uM1PTCj8v6w4q5HBUNuz+A1vzVbsBKynFskESyDNCuPxfOCZHt/brIonr8lBSmHvv4ugG9YEeWVWSh1CFNKJ9t6uxnmQ2pmDbjYg7l5NPMx+BP4Rf2kGIR/RB807jfwz/8nvzZnXsrYH1jwsX9KGD6mzK9LWMM3q8iJe1AB3jW1acf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLeE3E5EHWDx2UtVSCXFIjxV0JTQ7WdHHjwohxi/kS4=;
 b=P8s/rW/TySVD4f+dzag1VrWzPypqxCrKfZDnycT3SgENV/kZf0zX6WsJpFHXAPvrHC3/F/9gNl57r6ukC0UYpVLCIwRpI/QJ8xdjF+aLGePOq0oSMS32mjS7QDLmCXf9X6Tc2ZF7f4ZVyrEG0TtcxUz254H4jaIh5lIgQsmfggzEkqtM9bruPAgNOEicozW4yHNaaAKYKr8vaZd3ZSBu/aEEOVJIbh4c6WoCkob6/TZkJ2amjQCAE2LFgm7Rex6lOz+EBMYOsey+PznsXqpd5ZiKEBdtr8PnRnIzba4te6dOKqWpZ7a8V0ZB+sBoC85J+tI6VRXlpTJMSzJveJbNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27; Fri, 1 Sep
 2023 19:33:30 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0%7]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 19:33:30 +0000
Message-ID: <e2ae1d89-9abf-338e-e56a-dc4be19b9bfc@intel.com>
Date:   Fri, 1 Sep 2023 12:33:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, <x86@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: b18ace04-c511-4a1e-b64a-08dbab2252af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gJPFKnesXV2t/g74Wk+sbg+oMqUROrCD/Z6vnPpc5Es2Dy4pmHlGHkyNRi/hpFbFwG+MtqGRtw1d61fjQFKYkovSkpwFkl+7jLILMs/2vgOmq4CssT6CzYO5teyKI03a/F4CisIQtepvMZNF4wUjVPxOQIcvDlUbKbnOld+W8HSIndz3eXW3k4fKKTBeMPRNaBoAgRiUDF0opqCqPt0dEaWSmfi51yFuvKegiYjKU7uIPz794IjEeKesu9tehCC8B1wlpRXC+I6RXtu/5SHqPcmO1PeNVs1jlDVFwIP54/38Dy/JVjZ/zu+9vvR/7iMSHGWGDGlXkqQvR+SWdrY0K41tjE+1L1jtb9TS8y5AayWp8NYjiL2lGn5YnIyFtKATAqwgb+AQmGLCpBTr0Q5PhzeUeAb8psZhlvXY3BO41exVNBI4EGrdUdhnk2ttLYoCeDC9KEx5Tl3qtVAJ2nvJb9JHZS2jTxwbtTo7clgf6ggA14Jm+c3fnCbRevQfyNlwQdMb1ZNjzYx/4cRQ+tJx51vxd+Lx/Y1n4LQzBrTl6zxWTS3P+SQyX0DvliyHVjhPQlm55uyLNq17EBVxgZFb79KPf4n0jWO6Bz6JYvP7A/yWt8fpuRo3FzO57oT7FwWhje58PboTExAvTl9g8jPsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(83380400001)(36756003)(316002)(53546011)(2906002)(82960400001)(2616005)(15650500001)(26005)(38100700002)(921005)(5660300002)(8936002)(44832011)(8676002)(6512007)(966005)(478600001)(110136005)(6506007)(6486002)(31696002)(86362001)(31686004)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhXUk5qZUdOSElPTE5CYkRRMjY4WllIQ01uaVJJYUx5YXlkOWxqL3Z3bWRQ?=
 =?utf-8?B?SVdCSVRrdUFKT3dLQlV4MFVmNTJ6dlFTMWl4MCs2SmRpdERuR0oreE9tbDBz?=
 =?utf-8?B?WGtNQk9lQlBsVW93L0tCdWx2c0s0V0hhS0x2WGlFUWdtcXgvQlkzOGNtcGpK?=
 =?utf-8?B?blpCbWZoSVp6SWZ2S2IvZi90QlVmblNKckhBUkQ1dEdIK3BzM0phOTd1MzA0?=
 =?utf-8?B?TzJvRlRPcmcvMFFBVm01dGgwMjU0cUZETm4zSnBrNFVnM1N1a2hZaVUyNmlG?=
 =?utf-8?B?aFJGQkFPNDd4eUZrWGJLSm9TQzYyRzQ5WExybkxjUnlqeUIvelloMXgyRUpT?=
 =?utf-8?B?eS9VS2UvQkxOOWxvMXBsWnRhUzVkZXhORElCSmV0VFlRbE92Z2xLZE9qK0Vi?=
 =?utf-8?B?RmFyV3Z6L2lsRDFkWmlLRWhEQmVVNW4ybDN6T0h5T1dMSnhWVWRjT0NRRTRw?=
 =?utf-8?B?VlF4ajJXZnpHKzRhM2dxTndyOGR1UzhIYVVMcysrdkpGeFd5OVZ1dzU1dWlW?=
 =?utf-8?B?aXBxcTdtV1NQNnNaYko2MGZxUEJmT0VPTldpbjRWRjRMQmxVMEVDQS8wTjY5?=
 =?utf-8?B?cDJZVGRXYkRRRk81MmlBSmRrOEY2UFh6SEZVOTl4MGpRVG1lTTFlaUFQTkhD?=
 =?utf-8?B?MTVGKzRITmduekpyaStFOXM4eXplcjVhRlJQeXUyU1JoU0J4eEZwd1RoeXFC?=
 =?utf-8?B?NXVONFRGbUkwNGVvU3c3QThaUUdBcDJVK1lzY0dQT2FyUTIrMnRwcTdzTWYw?=
 =?utf-8?B?dktvR3dFc2o4K3UxVFl5TS9aelZtbllkTTRza05oRjdEM1VPaXhrVmR2aTJp?=
 =?utf-8?B?SGxhejBHZnBoUDc4aE5uZVUxTlRnV3VnNGFhM0dZR0xFM09xTDVwOGpSWWtH?=
 =?utf-8?B?cDBsbDAvZFRoUWdOU3VlRUpjUW5jRnJxckN3NUk4TXJZZGVDN0YzelE5Z1lK?=
 =?utf-8?B?QVlIYWFpdVpBTlJ0Y1pDNFlLQllrbjFqNzRhSEhIb3V0Sjl6bEx5TFcwb0U4?=
 =?utf-8?B?b0R3aE5HN01GOEZHWWxQOUxUVHpiRVlmblZNYWwrMDZLN0VhMGNQR2xaQ2lv?=
 =?utf-8?B?NVo5RGJBYXlIbHpCTmVUdkJhRHZydHF5aXA1cGlseFY0c21ta0NEckh1bnNi?=
 =?utf-8?B?WFVOcWhtNmJJdy8xNVh4ZUowZjlMQjZhcEFEMlZOSlpVTVY5TmVYVzNJT1Zj?=
 =?utf-8?B?SDBTZlg2eVNyZERJUk5uS0xLRVZEelM3bWFXZFFDajFQTW5WelJvR2tBcGVS?=
 =?utf-8?B?UWZDaUxTWjJrWFR5N2kwblcrWC92SGd6dVJta0gyZkRTN1VVRkZ6WnNnKzZs?=
 =?utf-8?B?WFBYZnNNNW5GS1R0QWVFRUVJYTJkTnlTZWZUc2FoTUlGV3ZqWDYyaFBwajBy?=
 =?utf-8?B?Qk1LMDdEVU1ldkU2TUp6ajV0TW9CaHRTTTNIbjJKMjE2VnFYMHFRZlJiWjBa?=
 =?utf-8?B?d29uV090OHR6Q0h5NnRsb0dGUUM1aEJCQnl5UWdCY0lQNnpFblRlSmtJaHVN?=
 =?utf-8?B?Mk9VRE5YelFzN0xLOUVnTVptcmoweWdEekNoVGtzVFVMVFlvaUJGK1lFVlVV?=
 =?utf-8?B?VmhpMFJaU0thUEhRQmI1Q3RQckNUU1FHRXNhRXpvTldJcTJaS0hJWkJxTVJC?=
 =?utf-8?B?RXJkR2pJeW01NEpoSC9tamFlRTU3WW9VcUJSdTZwU1orOFF0R0FVb0t2aFZL?=
 =?utf-8?B?YXFxWkdJSk41ZnpEelRWM2ppdjRaUThMWFAwa2RjUkxzS0lKR04yZ3lsZzdL?=
 =?utf-8?B?VXlxS2dBMUZMdENmMGRQeE4vc3BVcSs4YzI4M0hET25OUS8xQ2M5MHFmb0Yr?=
 =?utf-8?B?aEhTa2lwZ2hMbVNqdUJhSVJpemNpNVo4Wm94cHQ3K3VqMDRUQldFc2V5TnNv?=
 =?utf-8?B?aTNFU0dUVUtLbXdIVVdQUkN4Tmx1eXdMN2dOemxoZWtmcUcyeTNqeDk2RW1F?=
 =?utf-8?B?dkY5S0hmNkNzejF1WU9sN0dQVjZ1ZnVhNUlwVGkrUlZjNnlzMzNIOXgxNEJa?=
 =?utf-8?B?TjBvUklVTkVSR1h2RGh6WTNMaXhsSDNkYzlWMVNDUkNRcjhyNkVjTFpwZVR3?=
 =?utf-8?B?WWYzZWdQZExkMWhUSnZkK2lxQjYxY1ZuWmpTNDhZbGNHTEVOMEwrelBlcmdH?=
 =?utf-8?Q?ndr7Sga3nAlJGx6TOQRJxtz6G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b18ace04-c511-4a1e-b64a-08dbab2252af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 19:33:30.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mcYPFMUqwqs8ZV+0/DlUnRvqvdeR0Acnv3JGCmSlS3LslNvduizh6ymgEmYFEBtL9I4KdIh67VVsZOFQiM7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

On 9/1/2023 11:16 AM, Rick Edgecombe wrote:
> Shadow stack's selftest utilizes the map_shadow_stack syscall. The
> syscall is new with the feature, but the selftests cannot automatically
> find the headers for the kernel source tree they are located in. This
> resulted in the shadow stack test failing to build until the brand new
> headers were installed.
> 

I am wondering why a definition for __NR_map_shadow_stack is missing in
include/uapi/asm-generic/unistd.h?

Wouldn't this mean that even if someone were to install the headers they
still wouldn't get the syscall number definition. Am I missing something?

> To avoid this, a copy of the new uapi defines needed by the test were
> included in the selftest (see link for discussion). When shadow stack was
> merged the syscall number was changed, but the copy in the selftest was
> not updated.
> 
> So update the copy of the syscall number define used when the required
> headers are not installed, to have the final syscall number from the
> merge.
> 

How about adding a fixes tag to make it a tiny bit easier for someone
who backports the shstk series?

Fixes: 81f30337ef4f ("selftests/x86: Add shadow stack test")

> Link: https://lore.kernel.org/lkml/Y%2FijdXoTAATt0+Ct@zn.tnic/
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  tools/testing/selftests/x86/test_shadow_stack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
> index 2188968674cb..757e6527f67e 100644
> --- a/tools/testing/selftests/x86/test_shadow_stack.c
> +++ b/tools/testing/selftests/x86/test_shadow_stack.c
> @@ -40,7 +40,7 @@
>   * without building the headers.
>   */
>  #ifndef __NR_map_shadow_stack
> -#define __NR_map_shadow_stack	452
> +#define __NR_map_shadow_stack	453
>  
>  #define SHADOW_STACK_SET_TOKEN	(1ULL << 0)
>  

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Apart from this patch, I think we also need something like commit
78252deb023c ("arch: Register fchmodat2, usually as syscall 452") to
reserve the 453 syscall number for the rest of the architectures.

Should I send one out if you don't have something prepared already?

Thanks,
Sohil


