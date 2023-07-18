Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A475862E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGRUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGRUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:40:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DCBD;
        Tue, 18 Jul 2023 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689712840; x=1721248840;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UFEabBq7/X/GQR06UnTpyoiFwPJ4AQQiGgJq3FoxWj0=;
  b=PtIQC+Wt4/v15xMCoN5DlRZO3E02ve9Mg4db09jLoog975paUWKooAbM
   jGWPxmtgOQ2MzsTTXGPG8GsXMEeWZqb8nzJAzMqkhfuKJFc0O0cwUXoEH
   DZ+LmpMx+2WR+vGSAboS7fglRRVgjKexHi9Uc5ZA8Q/54aO9omMhX2d9O
   CcwVSphDjpY18pG45g9+rNvFRt6hG7C4toSst94weiED/U5HrrOa3SGwr
   EMQ/VnVE/5+morZZjxR1Z9xTN9JOiI5uRVDT8r/XldNY72NtKJXBiLn7F
   HvQ8OgLWqAmneAL/VfaD5Fif3IyqSiaexYp87i1NpCIEZoJGMxxXK6Bx5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356255914"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="356255914"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:40:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867229203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2023 13:40:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:40:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:40:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 13:40:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 13:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/P8t29ISttYHAYr/qszeGk1hdhiZnQISmresmszZcsnMp6hxGDo6oni6rpP0wyR5Usj3+DgRwZzwl0UdXsAjgCgFw4VXriMOwFMtIMuE6J2haidSg5Eg8B7EvrU+o3whJ4eFWUJpfyeXQl9fk9n85VwuFNENRzVOqPmBqmLjz7btJn3RItF9x0pWSUyy82R03fIX1T++20ikErei+h4THvDZBzIQ4vXGabS0C8bhf7ItI+GiP6FjibOTUTebzM/VAO5gUHl8izR/fBDYBpKxTlmOpwkwq+Z7LfrSmTXpar9J81YhzVR1vex65fxPF6YUgaXH5QtbvYDlykMREn/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1iYUtRSN9cAOkeI7L0GYt8yI9fYitPU7hdO627GTss=;
 b=jnspaINouXoCd3pGcw1yXJyzeoBRAF+hO5469lGJP8bBdt9eMG6TgOYbqAJjV7KCIeTdfPEC6myJVZ9haiOBio+zsoGySScjIkEhUxAx1qxw3JGSjLoWf0dt33irY27PQ8zBNALlOvAKwvoqaTGCbmTk5k2+T8WtAxR5QQtMu3JAz51yjYtCB4sATbZOJdji5hf0WSCLtiJmlkYLmd8gRcYKlKXsrBGp8KVr8T0yBiZevTGwQdZYK2w2R6IZY3tLwpzKuMM62ThytmG7wZnurZgolIi04OGjeq8MHA+EAlkv61YYhDLmza+oDd3S9Ph3bhs7aKDq+plhG8zb2/LAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 20:40:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 20:40:35 +0000
Message-ID: <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
Date:   Tue, 18 Jul 2023 13:40:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
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
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713163207.219710-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac4d4e7-35b9-458b-3a38-08db87cf3ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGSDsafftuJi92cO9jvyugPZF3EVkdyenCqNtVlr0bcEAVxvwVud/F2ZyFpD5mXQlD1sR4r3ImZBH/R466cpLHY2rsC7fCYjKtN1xrS/pzV6jLSG0M9uJPJA1kiAuCljGKS5pH7I5xF9ieGReb3XxJQUajy8dHoNpe1M2YrQDFBLfAd2FeIa8ES1Ee3/hqXMQZtuJcGwMyRRbpvgTQcmxznFtlwtGp1l5I4r4lHRIsSIhq87gYm6iJVTlJhzL/jpuMQQy/yY9eVV798ziQdSd54mrhf3/cRw/W5V6yI7thFgbYSrLiue9WfGXAGafK/ak4epuXUp+HNSfU2/7jpVw+Ao9qbyfxnCVSowq1GQQqYHZQMJAZu3NSvKlndjA0G8SXMSSwIoZgo85hqqkSQbaxoqc84tZYM1Q9XANRl9ip5AD4kJ6W+c7g3rspozbbHlZQLLSgi4EarbRt6MZZRcZAa878+BEcRU7rsOS7KQsrgaPt69BD/MHdQ5RX8q+koP+6l/Je+Ga40jNoMMAgf3VlnfuyGHQw9xy6i7frHSW9oqjGkq9ID4TjfUNVQRzpWCC2I1BGGNIK/654NSIFD8a+wJ5jIYqAZn/QXR3bh0YBFOu33buPOZf/sg4JM6ExelbytN2qGGsNlwKzJlbB+2AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(2906002)(44832011)(7416002)(83380400001)(5660300002)(6512007)(26005)(2616005)(6486002)(186003)(53546011)(6666004)(6506007)(36756003)(82960400001)(110136005)(38100700002)(86362001)(8936002)(8676002)(31696002)(478600001)(54906003)(316002)(66556008)(66946007)(4326008)(31686004)(41300700001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE80R2VzOHhJT0hoWXJRSXhlMXFkRUovYkw4WjM5aFF3Y0pHaXFHRWxoZ3hR?=
 =?utf-8?B?YnV0OXBvVzU3bms2eVV1RjRFdndKZnNmYU1xNnllSS84eXpPRmhKY042d3FE?=
 =?utf-8?B?WEtKMFVmMmUxQ09lVXdUMGk4MnZFV2RmUUpVeXNPSWhXY0wvS2VYb3E2UHIr?=
 =?utf-8?B?RzNBb3NpZ2Q4aFVsMnprbnc0bWVFZDJRRFgvdVU5VjljVGNUK0lDRmM4RzdL?=
 =?utf-8?B?ZWQ5LzBWQVIyU0J4REtYZkNiZ3dnRFB5SVFZd0pLUWEwV2w2RE41WHprWUEz?=
 =?utf-8?B?ZHZLcFFwTUd0dTlHZnJHZURMTFZBV2NrSkRvZmZISERFSktUUDdBS3lBcVdo?=
 =?utf-8?B?SzdHbGd1RkVtRnVpaXBpN3hTQldCR2s5OXJZZHorR3RPWmdGc1JpclJPY05Z?=
 =?utf-8?B?alVQaW1xWk1DaDlDTzVnUlJwVnN4MndKL3JqVDJvVXNkdHVPRXpJdGhOLzRs?=
 =?utf-8?B?dC81L2w5YjVMUGQ2Ym5zWDhSa3BSMFNwSGtoSWc2WXRxb1M4V21lUVJQb1hi?=
 =?utf-8?B?WjcxU1p2a0hudWc2YkQ5WUUzZDUwR1Z1eWJuMDJQcytFaFB3UWxoSnB6Q0NO?=
 =?utf-8?B?UGJva1FpQ1RQNW9LYmFVOFdwZ1NNbUJqdHF4REhsTjBPR2dSZnNFT1phZG1W?=
 =?utf-8?B?OXFvdWpTTnd5OTVVQkVOeFlVeUhFUjA1czdhTnNGendpR3J2TWR3VXhWVldy?=
 =?utf-8?B?RXVIaGxtNkJrYllaT0M3cTh0MTh3ZXhYTk1IOTNlQmxQdUhhOXAvZXQ5RmhY?=
 =?utf-8?B?TDVib3BzNG1XbDRrYzh1Y3A3ejRTMkdjUDZCdWplSGJId2FrU3M3RGNyekh4?=
 =?utf-8?B?TnpKNzdRNDNMdW05dkVpQVh5bm9FcHF6M1lTWFVzWlV4aVlQUHJYOHNZQ1h5?=
 =?utf-8?B?c0l6MXcrQUhFQ0M2cUJ4NTRuMjNkRkRLdm1MNFdVTUV2QnZ6bWcxczV3c1ZT?=
 =?utf-8?B?cWxiUjY4SERGQUVvUlY0cDJyRVlKQktjWlRUaDdsS3hxTDg2WVd4TWh2MUZa?=
 =?utf-8?B?aDdtZUZnanB1Z3J3UUI3SG84dmRLYzI1TWVvK0ZhV0ZkaUVjbnVrc015WU5T?=
 =?utf-8?B?aVJsUWxhQW5DQ3A0RStvL05WN1ZWcFhHQ21BbmlwYnJobExGSHBjSVp2Zk1h?=
 =?utf-8?B?czNJdyswQ2JwSnlHYnVpRnZmYmV5dFRDcjh5YWNraG1xTytNbW9HdisxV0Jm?=
 =?utf-8?B?cVVwSkVDQldFWUVhcG1TV2I5YnVkSzFNRC9CR0ZqM2lIckR6RGphY0R3UzY1?=
 =?utf-8?B?ZzJ1c0FTSWhiM2tnMlZZWGZ3N0lJSXFoVmU4ak12TkpYaGpGRGJ3Y042R1FV?=
 =?utf-8?B?cldOMEx1aGwvTUFiTG1qYkhDWTlEZndSdzFaTmoydWtrQnBSSEpyVHBGK2cx?=
 =?utf-8?B?aTNucnppeFN2dUg5RDdCVU4raHpOWENDZ2N3dHJHL0ZveVFkM1pXTTFETHA5?=
 =?utf-8?B?UlgyT0tGZHBEQ1FnaUFjVXZoUmE3Tytwb1JUa0xiNmYzMWJJcHpDbEFrbklO?=
 =?utf-8?B?anFUWGpqRWlVMndHZzd6dTJCSGlFaVRDYitGL1NIR2t0cERmSjBLeWVmS1ov?=
 =?utf-8?B?S3hFeVVQTFNYOHMwRlFwQjRZNHMyOExqWTQ2azJ6Z3dmTDdXeU4rQVhMT2Fy?=
 =?utf-8?B?NVJYbUFITzEwMmVWVXhWTGdLT3BZQU9SRmY1SklXZ295UWlyRkEwQ2RLR3VL?=
 =?utf-8?B?ZXIyRGtER2RzL2JLN2drZ3pWS2lveE11aFJmY0tVaW54ODNja2ZtYmVOOHdk?=
 =?utf-8?B?eFZIQ0xCZ0Y3UzNFK2E5endrUFlpRkdETHgzdmliRnh3MWxQeDBCUi9GSnVk?=
 =?utf-8?B?eFcwTVdURklvZ2ZVTHJaR1dCdXBMS3ViL0srU2RmUkRoVEIyWmpDeE1pYWdY?=
 =?utf-8?B?am9LVjd1c0pXT2NKMlhqVGxtM1JwdGN0VXZSK1k1RDdabHpWTkd6M05tNlRu?=
 =?utf-8?B?MllnWTdJZmVSWGpQbUNtZFRDeS84MW95TFNEM1YrSG5ZNHROSEJzVS9xWFoz?=
 =?utf-8?B?c1FqMGxNbWR1ekptLzd5M2hHNXU0MmxPVTdzWjhoY0ltTlQxblVsa2lQTmRL?=
 =?utf-8?B?dElWUTMwaWRNWm45THhFRjJmRGY4SThFY1lkVjRXOXErbWdwN0MwSzJjZVQx?=
 =?utf-8?B?cnljVmI5clJJMnIrcDlUdWpUSWVJWXR3dnI1bWlQZm51K3pzLzdCbkdoMmJR?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac4d4e7-35b9-458b-3a38-08db87cf3ccc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 20:40:35.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHBSXRP84Uuwt2bJRSB/OmyU84hQRDxhuxm+zJ9K3yKX03uTvfXd3bOTwQ+Qxqg8exxt18KTrth4r0dD1zOY3MJQiZH9zPHt4h5n8DD+71Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/13/2023 9:32 AM, Tony Luck wrote:
> Add a placeholder in the array of struct rdt_hw_resource to be used
> for event monitoring of systems with Sub-NUMA Cluster enabled.

Could you please elaborate why a new resource is required?


> 
> Update get_domain_id() to handle SCOPE_NODE.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  4 +++-
>  arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 8275b8a74f7e..243017096ddf 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -435,6 +435,7 @@ enum resctrl_res_level {
>  	RDT_RESOURCE_L2,
>  	RDT_RESOURCE_MBA,
>  	RDT_RESOURCE_SMBA,
> +	RDT_RESOURCE_NODE,
>  
>  	/* Must be the last */
>  	RDT_NUM_RESOURCES,
> @@ -442,7 +443,8 @@ enum resctrl_res_level {
>  
>  enum resctrl_scope {
>  	SCOPE_L2_CACHE = 2,
> -	SCOPE_L3_CACHE = 3
> +	SCOPE_L3_CACHE = 3,
> +	SCOPE_NODE,
>  };

A new resource _and_ a new scope is added. Could changelog please
explain why this is required?

>  
>  static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6571514752f3..e4bd3072927c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -112,6 +112,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.fflags			= RFTYPE_RES_MB,
>  		},
>  	},
> +	[RDT_RESOURCE_NODE] =
> +	{
> +		.r_resctrl = {
> +			.rid			= RDT_RESOURCE_NODE,
> +			.name			= "L3",
> +			.scope			= SCOPE_NODE,
> +			.domains		= domain_init(RDT_RESOURCE_NODE),
> +			.fflags			= 0,
> +		},
> +	},
>  };

So the new resource has the same name, from user perspective,
as RDT_RESOURCE_L3. From this perspective it thus seems to be a
shadow of RDT_RESOURCE_L3 that is used as alternative for some properties
of the actual RDT_RESOURCE_L3? This is starting to look as though this
solution is wrenching itself into current architecture.

From what I can tell the monitoring in SNC environment needs a different
domain list because of the change in scope. What else is needed in the
resource that is different from the existing L3 resource? Could the
monitoring scope of a resource not instead be made distinct from its
allocation scope? By default monitoring and allocation scope will be
the same and thus use the same domain list but when SNC is enabled
then monitoring uses a different domain list.
  
>  /*
> @@ -489,6 +499,8 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>  
>  static int get_domain_id(int cpu, enum resctrl_scope scope)
>  {
> +	if (scope == SCOPE_NODE)
> +		return cpu_to_node(cpu);
>  	return get_cpu_cacheinfo_id(cpu, scope);
>  }
>  

Reinette
