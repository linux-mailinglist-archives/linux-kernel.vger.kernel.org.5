Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D878CD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbjH2UPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbjH2UOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:14:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC9CE9;
        Tue, 29 Aug 2023 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693340071; x=1724876071;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dUmhsTW6h5rm08bImfLtUn1EqnD85AtoHTRNl5+TaoQ=;
  b=QXamyxbTarj0qUmzZ5cht3qpE4CX8Ng48d/7+DPD59Yl1tZ6ruEdAL70
   STiTZukzjWm6cMToaqHay+oXk5HZGMruYuODfkTNrsFkS9C09uzLlew40
   BPVzJJqMJibQWpRUzZgBblsr8uX9Wprs87189OD3jNIpAqUtYM9DG3xrL
   iYjpeX+UTSaMxg4cH5JJVQsKs4t/xOXlkmIc748vXF3JZipAS9OIJ5cUe
   uUnCyeKK+wp4lhE+FmP0qP+veLgYnoVa41a3upNfOG8FzeICTO8aBxiig
   xmepQHP9OUjomxIV26Bjp+G2PHeNtRvW4Gt4uwTo195E4bY57tUhuzzzJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365671300"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="365671300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853423340"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="853423340"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 13:14:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:14:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 13:14:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 13:14:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 13:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW/bs6pByaDmmysSgX9n/Wty0wt0YcF9O2hp8XSP6sU/tTfSOD0KYSFjji4QShOXN+IVZiVAb6NVS7EbJM23Th8OGcgAqkXyebxLjQkFGpn3mHE16lWF3Ao4oFsHtP5o9aFn7s+LwmQBZltrKk+Zu55UnimtIWYwQISESOHrDQq1Cqlo4U2BpXEIghSbW4t03IAcKpsrc9aXFFpBSLyUoJXCHZ/ZDpG2mLBN/RF555ALV/iBh26BVhtSKeEBHLS6W8nGRI7NqhV2aDRSOrNZcU1o9iq9dEUOYy0UIBS4uQHhWQnj03DbS9KZE8Gs8inKZhgOktcknTKF53DwJdicaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WStfg4jXl9OyqTzwPMUNxja5ZV3xHWXhtI2cF2N+KRo=;
 b=XblDApUi9U3nE1EbCT/hLtVNAydJNeIZz+y2W8Bh9ruQi7n/UmkjKIsegRCt7RQZ6Pp2h1LB6ihGKbsDLQcSjkL39X8IVnZ0NOB/68jpKYlNsle0tj6WvJeT7RIBAUBWPFWvCWe9k4b/agOTRogdHMr2spqR9wF0S8GHXJKYc+Jf2Kt73IFzlUVC5s3cKtGvb3e+goRs2c+cum6EdkORWmBXIKhISsCtK/tpJiTrTw84TKYWB7UVjchAgwwmpcVmqp0F5C2YHMPlt5Yy1r1E9NPZgHzkwuOvcDDMfFtF946UvIh+jHrAh65L+3djov1EbXZo02keE4XRf69ed6UQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 20:14:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 20:14:21 +0000
Message-ID: <4019a73a-8478-f18b-7f34-b8d838dfc7fe@intel.com>
Date:   Tue, 29 Aug 2023 13:14:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-9-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230821233048.434531-9-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 913d4c5a-c331-4ded-049e-08dba8cc882b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIEhoT04ai8w+nOnHxjQ5TyOtUWhcyG//hNw4kIUzODmwf63dqAiDfsdW4uR2LTfFD17LGLeT+c7RJKFq6bUyc1MplxWpUHVmm8sMxNSTuy+EtZTfun2msBQpquSXrAp2C0l5HxHepHU895ytvZVTgw6WI+uiXMNHCsQExva/4T3ULBhg0jjVpVGT5exZ/jJQ5keqFzA2bxPirxOWfVmH/3r4W3UFqDg9BjQFfKtDpFBF7Q6RTL+/fShEOkpCOKiGTfpnyTqiR/kMxfXwQViPe9iCQd46HzoV4f+n/9FFJ0dkbCsU2cEoRHts6P4Ss7Q9NEf0QfT7+UtlgFNYLSBGTxYIC0lmbFF0e8pcoNqZkiR8iRbJdEI/0WWgiW7NgYX53TSFJDyoTaYhDmLrnY3gISPDLGGbQLBgxh5PBr2A5GXeebQpKQVG03PHJxwb9aku7OkuJCpFwXo6Gwx3MfmFbmxFlQB8EalhF3F9l6O3qDLiW1eIr4QMZNaSLTZdBcG8CA9YcRSvwnMpOZ7RM7+BjdTd9nKBRwt9yDi1At1xxOjKXp5+D9yu9rganwKUNBRqjTYs4FO9K03BFUS8seD48YfRQc+dWgJVcADSO5t9q/SzKH6QTV8zfnN+MLJbWxloWg9IRmXYRKvs/Sx+Rx9gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(7416002)(7406005)(5660300002)(2906002)(44832011)(4326008)(31696002)(38100700002)(478600001)(82960400001)(86362001)(83380400001)(2616005)(36756003)(26005)(53546011)(66476007)(6666004)(6506007)(6486002)(6512007)(41300700001)(316002)(66556008)(66946007)(31686004)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGkwNjRwOExOWjJ6Nk9saGVtM2ptZEpqNnMvSW4wVlBuMDRuRHpFRUZYSUt5?=
 =?utf-8?B?ZFhVdHRSSWVBbm1CU0t4aHpaelVRMWZFSTJjdGZNV1FUWGxEdFBRMUlsYTV2?=
 =?utf-8?B?NmtlZXdIZ2FtUDBXcUNrT1hLcjRRVXJhYTd3U2huWjhWWVF4eEFYNXZEZHVs?=
 =?utf-8?B?cC9RTWhjamdnVlh2NzRoeGZEMXlOWXlsa1BxSHdwMi96MHRUb20zNmxUODh5?=
 =?utf-8?B?cVBsekl5a1pxcU1sdFYwUU9PZmxZY0NUOTBvb0tnVlEyTDRXNU5DU3Q4S1F5?=
 =?utf-8?B?dCtlYmFRejRFZW0waDN3aHZTMk1mV1VNVzBKR3hFak8zUDNuT3dqc0ZCV2Z4?=
 =?utf-8?B?NnJtcUtZSjBWWG1IS3BlaUc4eUNDNitTcGhEVDZUS0hCZ2dtVTVzVVB2c0Rv?=
 =?utf-8?B?T2dDeFVUZTJwOUl3OGh1Y2d4S0xUQ3YwdnJHOUZ3YVNuSlI3c3g2bTVIWEVU?=
 =?utf-8?B?dHJJV3k1b1BBNzkwOERQL01xbjk5SmlFQ1lUMkpvZFVlSFVzRUZzNjFlQlZH?=
 =?utf-8?B?M0RpcFhRTC9CRzl5czdiNVY3Y0YxeFRuRU54K2hmcHhyeW43aWJVVW5PMGxT?=
 =?utf-8?B?MFV5SnBDTlFhMFQvZ2RITi9jdGlwd0srZ1VtOGlnL2dYMFZjVHljMzlDUURZ?=
 =?utf-8?B?a1ZxcktESnlzVWxlVzI0NlRaNllJWUpOS1lRa2hCYVMxYi9QaDh2VkplRFFw?=
 =?utf-8?B?Ukh5SmZPWDNRR1lBeW8rb3Y4eHl4UEV5WXlNc1l1SVBCZ3hDVEkrU1Fualdv?=
 =?utf-8?B?RnZsSnVHSHBwYXA1U2t3SjA2QTBZOWk4YWhNQ25JOTRRNWI4dzZ0QTl0SE8z?=
 =?utf-8?B?bG1oWFJmbWE5TzhabzV2NmV3ZkpYUTlCbElwSlRKM05FRXgyV0QrdWVCSGpS?=
 =?utf-8?B?M0MxYkM2aFVEamhZT05USUdVc0Zac2lpa3dVUTVKdWFHRjhuMDcySlppTXVy?=
 =?utf-8?B?b2xneUpUOEM2RTNXQy8vZXZXYTlhYmxabEpYK3dXb3o0Szk3eXF6SklaS1A4?=
 =?utf-8?B?Z1VJSmh6QS90SlZvMWtJTEhzZ2lIRjRUVElvNXJCaXVnMVVhSUZNbEZQaTE5?=
 =?utf-8?B?RGJlNlNTbGpFZUxJMDg0REZQMVhyaThiUXVvcUtHRGRSU2FlRUhJZThzQnBM?=
 =?utf-8?B?amNIZXU0SFhtdVVlUEI2YkVxNzJnRElFV0FWZlRuQUJTUDhWNjVYcW9UejZS?=
 =?utf-8?B?dGFLT2FIZi9leEZWQm1RcXJYQmt4K2txMFE1bG05aUxDVVZMWk9pM09OOWJz?=
 =?utf-8?B?WkUxRU5pdWdyWFBTMlVqdEp1Q20ybVlVMy9wRllYY3c5M2twRmVvbTZXZ2tq?=
 =?utf-8?B?SFhJQStFSkY4UGNISTlhemZkRUtnaEY0NzZ4SS9RbjlEdVhCY1oxLzZndUUy?=
 =?utf-8?B?VSswTEEyNTBqendVUjNlTjdKNkNDOTgzMHI5ZzgrTHdOREg0RXQySTdYTHNW?=
 =?utf-8?B?K203MVpsVkltQXc0WVZIUG5CR1B0ejIycStjTUJFdFJOQk9BRzVGaHBjWEIy?=
 =?utf-8?B?N0tnajMzSEdKMFZYWjlYRE4ybUdsMjk4S3lHcGJ4V29ydTBrQ2FvcDBQQnlM?=
 =?utf-8?B?UkkvNkhITGVhQk5FTkNWbnliaWFXUGV1MU9oRkFMV2hBQjFNeDNqeGZncnNy?=
 =?utf-8?B?QnNRT3JhUFU4M1dtZHV6WGdOR21SKzRyU05UQnA3Myt0c3lnd1A1c2tZQUN1?=
 =?utf-8?B?S0g0VUhZbVc4UUdWRjMvSlFGVW13cDlRYjZzVzYwclZBUFZkOUVPY3lGTzF4?=
 =?utf-8?B?MUt1allwaEtrQlpXTjNvTFFWQXEwN2dXTHZDTmlOa2lLTDdINmxRME1CdGpv?=
 =?utf-8?B?c3psckFFV0FnZnhFOUJlcFF0ZFNWSnhRcDRtMG0xVE9sekp4c0ZiZG16Vmt1?=
 =?utf-8?B?SXJZekRReElWdklFeXI1R1IvaVVsNjN0cGl2TE9oR0lqZEY4SklIcURKS0R0?=
 =?utf-8?B?eHkwVGtLZlFvWjFZd1ZlNllJRGc2ckY3Qkc3VC81cjNZNjl2ZzU5eVMyclZY?=
 =?utf-8?B?YXlrcXRWNU1FWkluamEvVFQrdVF0ZDZRVi82aTUwelZ3enRoYTY2Ykg2T3N6?=
 =?utf-8?B?bStLQ0pPcnpuYkdwdFcrSWhCRjBXU295citrZm41bCtGSDI3ZmFTZU53WGJn?=
 =?utf-8?B?TFBWL3VwSGVXUW5ZU2VWR05NMHdLbU02eWIyNzBxMUt1bFdhQUl2b2JoRDIw?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 913d4c5a-c331-4ded-049e-08dba8cc882b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 20:14:21.6550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDWeniwE5NtH8aJ6pu4Uhh0RFcsRldm9E6dSJqgrvT8ex5lXmL8x0YQNZfuwbgt/3r3ABRF1wrFXH0XZ8p5jco2CnWb+VKmtIqmbV+jJPSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/21/2023 4:30 PM, Babu Moger wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 2fae6d9e24d3..3fa32c1c2677 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -296,9 +296,15 @@ struct rdtgroup {
>   *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>   *	    Files: cpus, cpus_list, tasks
>   *
> + *		--> RFTYPE_DEBUG (Files to help resctrl debugging)
> + *		    File: mon_hw_id
> + *

This does not look right. I think mon_hw_id should have RFTYPE_MON
(more below).

>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>   *		    Files: mode, schemata, size
>   *
> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
> + *			    File: ctrl_hw_id
> + *
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 94bd69f9964c..e0c2479acf49 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
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
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  /*
> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_tasks_show,
>  		.fflags		= RFTYPE_BASE,
>  	},
> +	{
> +		.name		= "mon_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_rmid_show,
> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,

I missed this earlier but I think this also needs a RFTYPE_MON.
Perhaps patch 3 can introduce a new RFTYPE_MON_BASE to not
have the flags of the two new files look too different?

> +	},
>  	{
>  		.name		= "schemata",
>  		.mode		= 0644,
> @@ -1860,6 +1899,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_size_show,
>  		.fflags		= RFTYPE_CTRL_BASE,
>  	},
> +	{
> +		.name		= "ctrl_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_closid_show,
> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> +	},
>  
>  };
>  

Reinette
