Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96D2776C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjHIWdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjHIWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:33:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE5D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620384; x=1723156384;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ihAhY50I8K4CQpkOlxQ6zi635It/vBgg7KDsjUKvXNU=;
  b=Cn3Sy8tcJyguRooHQXUtFv3CEMu1Ee4igGAUbMYnYsYyo6swPEt41Mzw
   5XrjnYpFmu/KqPQ/JPJYClLJaL59c954VxEf+pGPXJA2/L1V3No8bNJ2R
   ZsCyul1A62Hvrtqr7+3jRF5HAFp+FhZOcFpwo9z/yo2hnydtfl9TzAatG
   LtjRBenkaOsMtg4CCLud8QUEdb98wWgxQN4qdmBkZRDny3wiJerS75hVA
   gHYLpWN/TM44f/jlIsr/8BgCdzpvlAXkyLn6zkjjo4HXvwmu5EcnCygUd
   nYabo6gIzih34pG3wNJGSgA6qxu/V4k+CvjL10vU7ramuZ/APVxrhpDIL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374961034"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="374961034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875460511"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 15:33:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:33:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:33:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:33:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSfYlXZY/rYW6jzbSl9U40qmrdiolmhfXEL/Uls3EoyEv2sodtd1fLZOxecQv3IJ4KoR1krYS+qY34z0U0WmKUKqRAVguNmHD347nNESxPzYtyQ41HpIS1cw3+MPfNOE3FRJqqnfgj+eEq0F3T8HVSDtPbA1y7R9Dl+0ni9/Ze1CzdkzfbYk7wuXuJ7SFF2jynpO0hL9pt6V+Tm7sT+G3pp65l36WtIPXhmpN4C5fGcVD0t4tDPUppy8TEvGPoLv56eoqUitbuLUxoxJATINlr2VG/7uWZYgXqoPOkpdKag3m49oZuIiW+xd11oH6pbU0cbgFbkgFY5kJwCWrxWExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxPXCvEAnrb88wKc6CBG0TbuwrK3R4QEjZja55Fm/P8=;
 b=jFvt3FDlWK6uSUjX8Uk+nrFtHKL0f03b9Fb9maGaQYMmdc/IxRcZ5hImYKB37rKiCUSKZ+qk5/rwuid7YHEnC5Bj6ssMLWcKrnIH2HuvIRNncLqhCZnQ4fU8NQVIIWdAtFTiqGWn2zkLDSR2AYkNPGcMGIB0VJospykPMpkT7kcUY0quz/rzB/SLjx8KLml/L9/jB87wxv+u06ppxWRNsVm8qGCfx3lOlSjPMBI3j7krWcRSJtQPnAP6IXhW1sKXxaC6NB3kZLcn0y/o53KrnULL1TEjlLOyfRADvhAkJKLZ87AJVKHYsMYR7oq04pwrdxjSqLnLIpTQKXdD8nXFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:33:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:33:00 +0000
Message-ID: <f5993dda-7540-a43e-acee-85054c4a22c7@intel.com>
Date:   Wed, 9 Aug 2023 15:32:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 03/24] x86/resctrl: Create helper for RMID allocation
 and mondata dir creation
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c82d67-057f-40be-9211-08db99289665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjzaFPgxWosGUyedvc3pJ5CS1maI/wLRsFqDnhYU1DP/KGhGz/zICDMyA/pjBMmd9JwSJCtbRuTkxcBgZre51jyko8KK9d9EnO5AZgO/TpAjNb+i05E80myFZ5LUb1wer8RDnseJrBc8UAP3qFeY1HKee8d4YiXxxSnLRpmpNDqZdP81EM0D1yg/HtZ2betELwgUpBfLQqjxpLjXQUS/nOTNPqdpIGKrH0RFgDPyuikaOYPeC5U2PXdgGztgpy6orHkVd5MvHvW3j7PO3NQtKt5kuQvzhH5+vj2gNIwr1tesIoM1Vnp9YXcOLR8mvrQ4aIPXneL1XZCns6cQa3zcxwnsQIzF5Eh1Zok9VlhOaS3uHOVImqXzpt6Ja+cltyu43GtbLS00rVV89DRb5TzRg4lxBlkg9kbEUsgVYPFlKVjoyYze1y9XpX5Nx3rAwou9FA0Yr+ZMwJBCX6MLiRdcVEMuEvn+lXxl+pjDTPJjqMetVk9Uro+PkrK2a+ufaZaTSbZnR2buRvw5D2RmQ3CVeWPMY53zudkZZA5epPxL2B8wHFhlhfi1yKSAoxZ4GmUGm/L+Q1imYUv0u4xLyvTQJr22xFhKqXcgMtvkjmiaa9fNw/RICbg0C+UFQ0HHywRTW3+duDVoH5ZdQk34LwLEkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(4744005)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVraGJNSmxaZlZDWklMT2dHalFlV3NLT2FLWXV1YW0rRHNDVkprOUZWUCs0?=
 =?utf-8?B?L1dIb3BnTmdLQ1g2MHNOWU9KTm1PV0ViVnJ5anVMNVJDMjFKOWZnY01OMHVp?=
 =?utf-8?B?d3JTbVB0UzBvc0tHWDlEdXF1NDRJNjJMMDIyLzdYUi8rVzdCM0ZIOXpJYjlI?=
 =?utf-8?B?NmJGTUlPajQzb0NSWHdSOEVTUTMrWFhVcVVlSGZDODNNejloWmc3ai94VE9t?=
 =?utf-8?B?WjBQdk5yQmVQMmZ5cTBnTzI2ekV1djBSVUpiZ29UekRsWmFuenNkUlBEcUJL?=
 =?utf-8?B?SCtRdGZqb3RHWnl1NitLRjVXdWNlTVAvTUNxUGtEQlI5L1ZSR3czRW13SFRG?=
 =?utf-8?B?WDFEZFIwaVMxU3BXUjVlZmIvZ1JLTm9RVktTVWw5elcwQVpha3ZDSkw5WVdr?=
 =?utf-8?B?UFliMk55WWpiQW00QnlpME1VY3RlY0FNWVVBa1JsNkorc08xYVNOUHlIemU1?=
 =?utf-8?B?Z2Jnb0pzL1dCaE1POWl6V0N0SmtlaDhnb1dzY1FNYlNqN0hUM1FvdSs5NXVw?=
 =?utf-8?B?cDRlYkxpM3puZE9xdVdaMjBYcUN6aW1yeGdsVXFJRWdRWG1uZDdBazV3TjMr?=
 =?utf-8?B?UWR5K0MvditCR2RURWRJOXR2ZnBEMGhwNmdiWG5XZ0h6b2d2YitIV2FKNWNh?=
 =?utf-8?B?Sm84QXRMeDFYQjNHV1E5b3dkZjlxT0lWOFNRWlVEWU5ueU12Yk4vM3J2dG5o?=
 =?utf-8?B?cUlUc3BEeGxtb3BvVE1kYnZjbmZkdnJiWUhoZVFHSjZ0Q0lVYU02emZGY1Va?=
 =?utf-8?B?c2JuQW1zMWtYNXpCQmpzMGdaN1NXejdPMDVuRTlreWV3Z24yclYxVjJmSTBI?=
 =?utf-8?B?U2xUQTdUczMrM29XTTdqbzBvNmF0c0N0dS9yNGVxNVFTd000OFBCMlRyZmNI?=
 =?utf-8?B?UGdLeDYzcE90eXJYNU4yOEtpQVdEVUtzOFRBSW1SdEpSTTJCWlpDYnk1eHZN?=
 =?utf-8?B?KzJaUThCSXEzb09EaDBRR01sbEhSYXVFNW4yRmFTMCt4dWU0SWxXSWZhLzhD?=
 =?utf-8?B?YnFNdzdrcU91YmI2MGtPT0JIdzA2UDAvdm02WU53N1d6Z0E3SXRDVk84OGp6?=
 =?utf-8?B?bzB3elFkMjMxUmZma3Z1VzQyN3F4YmI3Q3N2SmlRWC95eHFaS2o3elU0ZXY2?=
 =?utf-8?B?dFd0dVNxODdVREJKQXdTaExuZ28zQTlmNGJzdjBqbFZ4MFRiWWl2RDZnSmdk?=
 =?utf-8?B?UnU5UTRpMVUyMVZFYmw5YXNESmpINnZlSFpLUFdHKzdFNnRCWjZkRmRiL0xv?=
 =?utf-8?B?VDg3TjU5bWd1Vm5XV3ExSGQ3dUZXS3JNa294TUdFT2NNWnV1bVlDSkJPRXV0?=
 =?utf-8?B?YVBXOUpOQ1ZiOGJ0SDYwV0FsQjdXMHpVcjBKazNJVktlV2E0TG9TMzRTTWZM?=
 =?utf-8?B?aE1hOThzaU9oUlp0YW1GL2VkMEM0bUFQTWNhYkd3SXBRUXBsWDYwekZVeHpn?=
 =?utf-8?B?UE5ZL3FDVEFPb2tCalBuQjVUeGprNWdLM0Fsd0J1Z0xwTFgxQ2xJNDZjeEpt?=
 =?utf-8?B?RWZRVE1yYXpNOWJSbDJnbTduMTZvZzVPRVhPajIvUHVCTWlWOXI2a0dJY081?=
 =?utf-8?B?NHNxRWFxZmRseEhPR2NBcjhRVzg5ZmFlaFJNcHBLUExWbjczZ3RXYnVpSVBU?=
 =?utf-8?B?OW1pdWtQZjBxWHpCUHp2Y3gzMjVBTkxqUzJUbzhtUlQ5a0xYV21YQ2Zram41?=
 =?utf-8?B?dzVBU0cvTWhiUHRCUWZmV0IrR3YrOGJEcU9kaHZOY3ZsUklWdU9ET3RQb3h5?=
 =?utf-8?B?Lzkxbjc4cno5VDJLd0VzTE53TmR4ZlRNOS9WeHE0TVBtVWVKbTUxS2tXeGtk?=
 =?utf-8?B?ZGhIK0pDZ3NBOEJlYmpTb3V1aEdFKzBrKzlYanlRLzdiRXZKOGMrcUdjbkd3?=
 =?utf-8?B?VkFNaHBwcE91VTR1SmFUNDdtdDZpQ3MrdTEwS2F1MUJmMzl5aGN5MFlna3lO?=
 =?utf-8?B?TXBPbVFFb1VOWlFnOC9oSi9yV0Y2OFF5ZVR6ZUJLWGJVaHVHa0QzUGlTemJO?=
 =?utf-8?B?cGxGSFJFNnpKUWxwTTFSQWFialQrYTFWR1VtUCtzdFJicVhENGVKam9rSWVw?=
 =?utf-8?B?elcvT2FaSFhCVjFXTDRycUZvWjZWaFRNZUZuZ1FRUUdWalJUODVIZ3YzT3dp?=
 =?utf-8?B?Q095by9zbEVtSjJESkY0bW5MRVFEK0hIK0YzMVZBdzdpYnFVd0FFbFhJblhw?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c82d67-057f-40be-9211-08db99289665
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:33:00.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUc/PbRmYzBQYRy4JMeowlskqyoz0fKBEGOnEi64vhS0F5VmFmdTdpQ4fw/ryiJ9m1lXZjv525MDGCU6rLIv2qZC7lSq3xEsg2juCmimzj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:
> When monitoring is support, each monitor and control group is allocated

"When monitoring is support" -> "When monitoring is supported"

> an RMID. For control groups, rdtgroup_mkdir_ctrl_mon() later goes on to
> allocate the CLOSID.
> 
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> Move the RMID allocation and mondata dir creation to a helper, this
> makes a subsequent change easier to read.

Reinette
