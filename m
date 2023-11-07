Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC67E3241
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjKGAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjKGAcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:32:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319EA1BC;
        Mon,  6 Nov 2023 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699317163; x=1730853163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+6izPPR3FPmUb9s77ifz7xMKbnBNqp8m1Sva3mRxXHs=;
  b=RQElwJm5RdIe0mgz1S5FH0tHaabosNumocUSyHqNPinzXV46cZ687drd
   trcDTzBNG6CMUZrRKBsJOuiidNX4eeEvRdz3fNpkCsfRM9HzI+HKor4GR
   1H3AP7Oog1kbs0e7iww7vW1Ayu4XpK2UieIAJnqZIOo5/Fbca5p8WaQ4H
   q5afPiuIy3HqrqGJM48qHA+pf7/Fgr5qK5lGLv3L9OPXGzkcLShLwEBxl
   JiJaq3dRxgieSwiT6uTgZAQ+tii45TXg6CQSeNnpypvMMO/v3O4NZFjnt
   xSudAh3oRtHEANFqppkzArsyIBbA+drFFi2guK/8U9rMzxTk0A0HvRPLR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="453706873"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="453706873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:32:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="10625023"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 16:32:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:32:40 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 16:32:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 16:32:39 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 16:32:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwLIhRBmgGVMQC4fZFY1Cknt8HGQ2qKPg4PrfTX3STGlhM4+tZEvnhJM+fWY/HFk/IiOPNHJ64zue/EOedpoeyOaz8xS22Lq8oKGPWBYl1uVUHjniCU70O4+i9hfSXpw+WfZzqDHflNkFIynnUnT+jg5Sk0wFDwDfQNMtJNcZONi8XhmTJ/AihdvkSyWuScKmbHEYtdLzAfWr5KRWiGiKagjB0LCp5ji2vUohtzsiJkPIWxvm2ru+CBAZu6tPQWuwEiAtjEbbJ+ytJUYYvn6bPeDhuIFMOHicEACJX30IE/JQ0nPd7w1LZ5LAo0MgPfmChYfsZYV+DJf8NbNSocH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a2BFTBqDQGKznCupR+q4OgGkodd/92E+nc4EPfbf7c=;
 b=m8mYjCSMRkjeV0L1fJvjrNRHXaVbmZLUVL3XnzRVZ95DBfimykVFytEBfc/YAmzBl2Dt+L7nmSIBz6soHXJerUfx8Dcxqm6wiI2KeYNStfoEchSvYqq4REW5VcHtgvweqDe6Ri5E20gVAR+3byH2acGlBpEPOqIDSgrRJ9PYpQnRb6dPqx9AwqWiBkD6HQryUlGku/MJ0UdsX8X+JJwMHIwBtYH4vagKyw04Z/EYdBa18RdwNB/Q8vRQYIH7oJ8kPlEBQ9KbgCf2+ohFjcoLR991Cje4POZVjTAw2kWccBcIj+9xiyKRwLUDv0mvnX0SKryRUiKgO1hHwZ8HYIm5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7614.namprd11.prod.outlook.com (2603:10b6:510:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 00:32:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 00:32:36 +0000
Message-ID: <92821089-ced7-4c15-a7d2-39383eff86cc@intel.com>
Date:   Mon, 6 Nov 2023 16:32:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
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
 <20231031211708.37390-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231031211708.37390-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: be241fab-a158-4e39-4eea-08dbdf290a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Is1wDEqnRo9AT3mni5bZTZy2CKjunm8mH3TuL8iyI1U2Sw54H9i1zaiphIuL3cRlLaFxcTd8HRuUGRB1ldbGhRIurm3c0elSsKCkMR56KJiGP4F+zOrpsACWvUZvHK6OTIPFo/HQraqhWqrTAQ6RV+9b8/Wo6V/z3/PY8Us3odJsRIdCKnQV9fcxajz9i4U7KGBQM58b8Cp5ssEyciuZ9SkRaTfUF7MBkxQJ+lCwhAfwhkBQCoyBDbLz4Dvqwza+htJtIkRQ4LUssR99e0V6qziXySxNYfAKX8yaKI571fttgkTkqVyu9g8pdGfCtNsMv0lN7xOwpOoypgB4ObSyAj1Qb1bH5M2ubP0ZxE3QCe/d4/65TI3TtKmPp8CqzOkjdQhAtboYkX1pyzO+7ppZ8HMhKxHFn+WHOMxYHp+hWuNHFPhmt/MFRdYL3/DdHTD0rbkMyL4F7kft5200Z2lExGQ+YIq6GxlJxre8NNvaVs8PeeB+OEXr1ZCrXpQ8J70lAo6jZW19wIvQ1iKGj9WU6rg+sEAEQhE3ugkPhQDahwSLpezKYyraedfxVGy+LiOIorijS/bSV/KBUFfVVlRVj3jE0xsKis+4VRXU1/uMPkN3mWc3ZxL9XH7jqB9ryQ/Dv2NXpSafFuGOza2CGIczA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(6506007)(6486002)(478600001)(2616005)(53546011)(2906002)(41300700001)(30864003)(38100700002)(36756003)(86362001)(82960400001)(31696002)(5660300002)(54906003)(66556008)(66476007)(83380400001)(66946007)(26005)(7416002)(8936002)(44832011)(110136005)(8676002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1N3WC80SDFENXhVRUY0c3E5NC9aTnBGK1ZMUGN3eFhlUE1adGxYYUNONmI5?=
 =?utf-8?B?eXVWZVlqZGlkckg1S01FeDdxd0luajZhTXZFY2x1R3JXODcwa3MzUVZQTEZ5?=
 =?utf-8?B?bkFWN1l5R3BwY0RJNlZpSXE5VGNNM1ZWbUt6dkJLNkcyQ3JKNGJ3aE4xaXZD?=
 =?utf-8?B?SHdub0hRSmZyT1h4ZldmSko0NEhIRTJ4TDlVUkxiOWR2WnppMWZsZnpaSzc1?=
 =?utf-8?B?bURuVXhPMFlTMmZFTlUxdXlFdW9xYWg5ckVrcncxaTVaajFFeSttbTN0bE9Q?=
 =?utf-8?B?OHU5dWxIZzVXZ1RGR08xRnY1RklBczRMMUhyLzNMcWxid29UUjNXTEovOXRr?=
 =?utf-8?B?Mk82Wk5lWmxkelhLUGJKYXlUV3c1VTdaOFpvK0xWaDZoUXRDN2VtcCtyQjBZ?=
 =?utf-8?B?eVp3OExKUDFLbVpoZmlrTHBOQUhDTWZKYkpIODhZVW9vYXc5YW8yN0d4K1Bk?=
 =?utf-8?B?RUVUNDRPYlZwek9YVmJWUnNnSEEwOE9IUUZ2OTg3T0NyRFo1L3hXTEZveXFs?=
 =?utf-8?B?S2trNmtaZEFCRWlwU0dFRk53QkJ6R0pBN1VyOVJWRHpHYVRlNWw5K21Gdkhz?=
 =?utf-8?B?V1BEVm1rT0pMdjF6NTR1ck9kR1l2VC8yOVp5NXZldzNqeUVHKzIzWGJNSkFQ?=
 =?utf-8?B?RGVaUWJuR3NwL3l0WndGRlBpRmR3cll1QVVuRksxMmdxb1k4Zml1RUorSmRH?=
 =?utf-8?B?cmJtaS8rVkpTWTdCSG9mY1habllvdkUybUIvRURYRWFuOWJLU0x6NVBqYkth?=
 =?utf-8?B?bGYreFhNVkFNQlJSSWhHKzMyVWE5Z21VV2g2ZTMyTk01aGl3bjBDbDNwbGpF?=
 =?utf-8?B?UlIwQTc3dDFlb2plM3A3QXFMQm9xcUU1VmhqSGJsRmdTSEtOblVZV0ZlTFlO?=
 =?utf-8?B?cmtHQTBmcGtXaHdNbVliU21IRGJKOGNlYTU4Z2JBbEFuOVo0eVdpSlg5cUR0?=
 =?utf-8?B?THZvSXlqYWMvT2tsZTdIZ2Y2V3hoaGp4bmJLMjNUakdsVjRlZ1FaU2hERXRm?=
 =?utf-8?B?YmVZT2FzUkpYUG4yR3l5c2c5SGdLYldSYVJtM0lLL3pNSGUxR0E2ZUp2OExp?=
 =?utf-8?B?bVFsZTM1TmtzdnBUclZMa1gyTGRQenRrUFkwamd1MHJtaDgwSXorZm5mWG9u?=
 =?utf-8?B?R3ZjY1FIeWxHbU15MFgxUzNhSHJOb2o2dEhFVHhJaXZKOHBFb083a3E4R2FE?=
 =?utf-8?B?TUdZNW8rTTJSdDM5aFp0QUxvL0w3eGYvcjlRenFwWDhrd09RejQyVk9jdWV6?=
 =?utf-8?B?c3JJVHN1UVZnK1hJZjdLTWZXclA3NnpvNS96TVI2V2laT2NSZng1T0gxeFpk?=
 =?utf-8?B?NWVHNlpMVnFxWFBpcElMMlduQTZNRzNNRzBjb0IyMHlNUUhtTHZnblI4N3BB?=
 =?utf-8?B?OWRGQWNCMVU1NEVTSmdvOVBMWkYrOGFuSjV5QWlrWCtPMTFyRDZmQ1pEOUVx?=
 =?utf-8?B?cEdPZWdDYjN2bEFtN1NZQ09KbjVwTDN4MTBQUk5pYU9JekFrNXlJZi90Mlc3?=
 =?utf-8?B?UmhvNzUvcGc4UjJtZFRsczZNRGFzSjF4azE5ZC8rRDIrNGZnRjJyMWYreDJX?=
 =?utf-8?B?c3NaTnNCdkZlcmFuTk1WSDkydW1JaVlaUy83SXo0YlE1MXZ1UjBSaS8rZFZI?=
 =?utf-8?B?TGFKalRFdEtJOUZmd05rUEZBMENJZldHRVhCb2FMUk1ER2hYMy9LVzJ6Tlgw?=
 =?utf-8?B?VU5PeEhlVVE1R1BvYktUVlhXK202OWNFc09aaE8xbmpML3lFMXdHSnRvdER6?=
 =?utf-8?B?VE5VVWdQZkNhQnNWckJONjd3N0kybTVsQ2NkQVA0Sk1RY01mbC9hYWlCWFRD?=
 =?utf-8?B?ckpNUFNxaTRobTZ3VXozNys5WXhYc2VIaU94d3B1Z1ZXS3hmbldLdWRZSjZQ?=
 =?utf-8?B?bFYxUjl3amkzL0VhODFERVlFSXNNL3grV0tJMTkwOTE4S0pZL3pQc1FQR29Y?=
 =?utf-8?B?Sm5mM1d1cTJxdER4eEFZdDVZR3FLZGJBQ01HSGtlVFUxRXpEWnB2ZjgwT2xn?=
 =?utf-8?B?SWlPV3VNQ0UyTnEvZHZLdktmVVYySUxUbXhodElyUFo1NU9kc0JKMEdQQnYv?=
 =?utf-8?B?MWFxWFNaUTJvekgrTG80LzVZQVBNL0ZzeHZOVzhyelZvZ3VZak5uRFFwaXN3?=
 =?utf-8?B?aEhhem5IL2tlVExBT3J1VlY0ZU1ESTR6YWpIVHB2Nmo0SkdLZHB0MVhvQzJU?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be241fab-a158-4e39-4eea-08dbdf290a83
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 00:32:36.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4lJfC/3qAZt6dekskAKuG0gjGOrG24pfKbyNttTtZT/qGCvupp5CZT3cAuiZ7/+xQRPxlPLNEHbU93p33DDjPRDBsYZ4NtpffZILCPYhQ8=
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
> Resctrl assumes that control and monitor operations on a resource are
> performed at the same scope.
> 
> Prepare for systems that use different scope (specifically Intel needs
> to split the RDT_RESOURCE_L3 resource to use L3 scope for cache control
> and NODE scope for cache occupancy and memory bandwidth monitoring).
> 
> Create separate domain lists for control and monitor operations.
> 
> Note that errors during initialization of either control or monitor
> functions on a domain would previously result in that domain being
> excluded from both control and monitor operations. Now the domains are
> allocated independently it is no longer required to disable both control
> and monitor operations if either fail.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v9
> Fix commit to be specific the only the RDT_RESOURCE_L3 resource is going
> to have different monitor and control scope.
> Rename get_domain_from_cpu() -> get_ctrl_domain_from_cpu()
> Rewrite comment for rdt_find_domains().
> Add "type" field to rdt_domain_hdr structure.
> Delete the /* RDT_RESOURCE_MBA is never mon_capable */ comment.
> 
>  include/linux/resctrl.h                   |  25 ++-
>  arch/x86/kernel/cpu/resctrl/internal.h    |   6 +-
>  arch/x86/kernel/cpu/resctrl/core.c        | 206 ++++++++++++++++------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  12 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     |   4 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  55 +++---
>  7 files changed, 218 insertions(+), 94 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index c4067150a6b7..35e700edc6e6 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -52,15 +52,22 @@ struct resctrl_staged_config {
>  	bool			have_new_ctrl;
>  };
>  
> +enum resctrl_domain_type {
> +	RESCTRL_CTRL_DOMAIN,
> +	RESCTRL_MON_DOMAIN,
> +};
> +
>  /**
>   * struct rdt_domain_hdr - common header for different domain types
>   * @list:		all instances of this resource
>   * @id:			unique id for this instance
> + * @type:		type of this instance
>   * @cpu_mask:		which CPUs share this resource
>   */
>  struct rdt_domain_hdr {
>  	struct list_head		list;
>  	int				id;
> +	enum resctrl_domain_type	type;
>  	struct cpumask			cpu_mask;
>  };
>  
> @@ -163,10 +170,12 @@ enum resctrl_scope {
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> - * @scope:		Scope of this resource
> + * @ctrl_scope:		Scope of this resource for control functions
> + * @mon_scope:		Scope of this resource for monitor functions
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
> - * @domains:		All domains for this resource
> + * @ctrl_domains:	Control domains for this resource
> + * @mon_domains:	Monitor domains for this resource
>   * @name:		Name to use in "schemata" file.
>   * @data_width:		Character width of data when displaying
>   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> @@ -181,10 +190,12 @@ struct rdt_resource {
>  	bool			alloc_capable;
>  	bool			mon_capable;
>  	int			num_rmid;
> -	enum resctrl_scope	scope;
> +	enum resctrl_scope	ctrl_scope;
> +	enum resctrl_scope	mon_scope;
>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
> -	struct list_head	domains;
> +	struct list_head	ctrl_domains;
> +	struct list_head	mon_domains;
>  	char			*name;
>  	int			data_width;
>  	u32			default_ctrl;
> @@ -230,8 +241,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>  
>  u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type);
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
>  
>  /**
>   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..24bf9d7989a9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -520,8 +520,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
>  int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
>  int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
>  			     umode_t mask);
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos);
> +struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
> +				       struct list_head **pos);
>  ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  				char *buf, size_t nbytes, loff_t off);
>  int rdtgroup_schemata_show(struct kernfs_open_file *of,
> @@ -540,7 +540,7 @@ int rdt_pseudo_lock_init(void);
>  void rdt_pseudo_lock_release(void);
>  int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
>  void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
> -struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
> +struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
>  int closids_supported(void);
>  void closid_free(int closid);
>  int alloc_rmid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index c26ecb2e415f..8dc2cb49358e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -57,7 +57,8 @@ static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
>  	      struct rdt_resource *r);
>  
> -#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
> +#define ctrl_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.ctrl_domains)
> +#define mon_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.mon_domains)
>  
>  struct rdt_hw_resource rdt_resources_all[] = {
>  	[RDT_RESOURCE_L3] =
> @@ -65,8 +66,10 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L3),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.mon_scope		= RESCTRL_L3_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
> +			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
>  			.fflags			= RFTYPE_RES_CACHE,
> @@ -79,8 +82,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.scope			= RESCTRL_L2_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L2),
> +			.ctrl_scope		= RESCTRL_L2_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
>  			.fflags			= RFTYPE_RES_CACHE,
> @@ -93,8 +96,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_MBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
>  			.fflags			= RFTYPE_RES_MB,
> @@ -105,8 +108,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_SMBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
>  			.fflags			= RFTYPE_RES_MB,
> @@ -352,11 +355,11 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>  		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
>  }
>  
> -struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
> +struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
>  {
>  	struct rdt_domain *d;
>  
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>  		/* Find the domain that contains this CPU */
>  		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>  			return d;
> @@ -378,7 +381,7 @@ void rdt_ctrl_update(void *arg)
>  	int cpu = smp_processor_id();
>  	struct rdt_domain *d;
>  
> -	d = get_domain_from_cpu(cpu, r);
> +	d = get_ctrl_domain_from_cpu(cpu, r);
>  	if (d) {
>  		hw_res->msr_update(d, m, r);
>  		return;
> @@ -388,26 +391,26 @@ void rdt_ctrl_update(void *arg)
>  }
>  
>  /*
> - * rdt_find_domain - Find a domain in a resource that matches input resource id
> + * rdt_find_domain - Search for a domain id in a resource domain list.
>   *> - * Search resource r's domain list to find the resource id. If the resource
> - * id is found in a domain, return the domain. Otherwise, if requested by
> - * caller, return the first domain whose id is bigger than the input id.
> + * Search the list to find the resource id. If the domain id is found

This still talks about searching for a "resource id". And the "otherwise"
is not accurate ... it returns NULL if domain id cannot be found. The
"otherwise" refers to a value returned in a parameter, not the function
return value.

How about:
	Search the domain list to find the domain id. If the domain id
	is found, return the domain. NULL otherwise.
	If the domain id is not found (and NULL returned) then the first
	domain with id bigger than the input id can be returned to the
	caller via @pos.

Please feel free to improve.

> + * in a domain, return the domain. Otherwise, if requested by caller,
> + * return the first domain whose id is bigger than the input id.
>   * The domain list is sorted by id in ascending order.
>   */
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos)
> +struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
> +				       struct list_head **pos)
>  {
> -	struct rdt_domain *d;
> +	struct rdt_domain_hdr *d;
>  	struct list_head *l;
>  
> -	list_for_each(l, &r->domains) {
> -		d = list_entry(l, struct rdt_domain, hdr.list);
> +	list_for_each(l, h) {
> +		d = list_entry(l, struct rdt_domain_hdr, list);
>  		/* When id is found, return its domain. */
> -		if (id == d->hdr.id)
> +		if (id == d->id)
>  			return d;
>  		/* Stop searching when finding id's position in sorted list. */
> -		if (id < d->hdr.id)
> +		if (id < d->id)
>  			break;
>  	}
>  
> @@ -501,35 +504,29 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>  	return -EINVAL;
>  }
>  
> -/*
> - * domain_add_cpu - Add a cpu to a resource's domain list.
> - *
> - * If an existing domain in the resource r's domain list matches the cpu's
> - * resource id, add the cpu in the domain.
> - *
> - * Otherwise, a new domain is allocated and inserted into the right position
> - * in the domain list sorted by id in ascending order.
> - *
> - * The order in the domain list is visible to users when we print entries
> - * in the schemata file and schemata input is validated to have the same order
> - * as this list.
> - */
> -static void domain_add_cpu(int cpu, struct rdt_resource *r)
> +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
>  	struct rdt_domain *d;
>  	int err;
>  
>  	if (id < 0) {
> -		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> -			     cpu, r->scope, r->name);
> +		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->ctrl_scope, r->name);
>  		return;
>  	}
> -	d = rdt_find_domain(r, id, &add_pos);
>  
> -	if (d) {
> +	hdr = rdt_find_domain(&r->ctrl_domains, id, &add_pos);
> +

Please remove empty line.

> +	if (hdr) {
> +		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
> +			return;
> +
> +		d = container_of(hdr, struct rdt_domain, hdr);
> +
>  		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>  		if (r->cache.arch_has_per_cpu_cfg)
>  			rdt_domain_reconfigure_cdp(r);
> @@ -542,48 +539,115 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  	d = &hw_dom->d_resctrl;
>  	d->hdr.id = id;
> +	d->hdr.type = RESCTRL_CTRL_DOMAIN;
>  	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>  
>  	rdt_domain_reconfigure_cdp(r);
>  
> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> +	if (domain_setup_ctrlval(r, d)) {
>  		domain_free(hw_dom);
>  		return;
>  	}
>  
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +	list_add_tail(&d->hdr.list, add_pos);
> +
> +	err = resctrl_online_ctrl_domain(r, d);
> +	if (err) {
> +		list_del(&d->hdr.list);
> +		domain_free(hw_dom);
> +	}
> +}
> +
> +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	if (id < 0) {
> +		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->mon_scope, r->name);
> +		return;
> +	}
> +
> +	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
> +	if (IS_ERR(hdr)) {

Can this happen with rdt_find_domain() no longer returning an error?

It does not seem as though changes were made consistently to this series.

> +		pr_warn("Couldn't find monitor scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}
> +
> +	if (hdr) {
> +		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
> +			return;
> +
> +		d = container_of(hdr, struct rdt_domain, hdr);
> +
> +		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +		return;
> +	}
> +
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
> +		return;
> +
> +	d = &hw_dom->d_resctrl;
> +	d->hdr.id = id;
> +	d->hdr.type = RESCTRL_MON_DOMAIN;
> +	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +
> +	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>  		domain_free(hw_dom);
>  		return;
>  	}
>  
>  	list_add_tail(&d->hdr.list, add_pos);
>  
> -	err = resctrl_online_domain(r, d);
> +	err = resctrl_online_mon_domain(r, d);
>  	if (err) {
>  		list_del(&d->hdr.list);
>  		domain_free(hw_dom);
>  	}
>  }
>  
> -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +/*
> + * domain_add_cpu - Add a cpu to either/both resource's domain lists.
> + */
> +static void domain_add_cpu(int cpu, struct rdt_resource *r)
> +{
> +	if (r->alloc_capable)
> +		domain_add_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_add_cpu_mon(cpu, r);
> +}
> +
> +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>  	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
>  	struct rdt_domain *d;
>  
>  	if (id < 0)
>  		return;
>  
> -	d = rdt_find_domain(r, id, NULL);
> -	if (!d) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +	hdr = rdt_find_domain(&r->ctrl_domains, id, NULL);
> +	if (IS_ERR_OR_NULL(hdr)) {
> +		pr_warn("Couldn't find control scope id=%d for CPU %d\n", id, cpu);

Why did the !d error checking transition to IS_ERR_OR_NULL() here?

Also, the error message does not sound reasonable for what can be encountered
at this point.

>  		return;
>  	}
> +
> +	if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
> +		return;
> +
> +	d = container_of(hdr, struct rdt_domain, hdr);
>  	hw_dom = resctrl_to_arch_dom(d);
>  
>  	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
>  	if (cpumask_empty(&d->hdr.cpu_mask)) {
> -		resctrl_offline_domain(r, d);
> +		resctrl_offline_ctrl_domain(r, d);
>  		list_del(&d->hdr.list);
>  
>  		/*
> @@ -596,6 +660,38 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> +}
> +
> +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
> +	struct rdt_domain *d;
> +
> +	if (id < 0)
> +		return;
> +
> +	hdr = rdt_find_domain(&r->mon_domains, id, NULL);
> +	if (IS_ERR_OR_NULL(hdr)) {
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);

same here

> +		return;
> +	}
> +
> +	if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
> +		return;
> +
> +	d = container_of(hdr, struct rdt_domain, hdr);
> +	hw_dom = resctrl_to_arch_dom(d);
> +
> +	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
> +	if (cpumask_empty(&d->hdr.cpu_mask)) {
> +		resctrl_offline_mon_domain(r, d);
> +		list_del(&d->hdr.list);
> +		domain_free(hw_dom);
> +
> +		return;
> +	}
>  
>  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {


Reinette
