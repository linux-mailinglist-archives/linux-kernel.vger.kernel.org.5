Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98A977962C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjHKRd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjHKRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:33:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156430D7;
        Fri, 11 Aug 2023 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691775234; x=1723311234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7PB3GbX+jahSms2Rk+cMV1dlOw5SMcTiBxJoyIS0ezA=;
  b=nRZD0vJbIFH/ofdxRKYVtI/+8XS1yCCFDWNwN/zlJ7v2BirHI5xFTVnU
   sFQ2+SCIfqrywz5edDquN+JH4F3Bn45Yq63KvXfpMsMcs1D0ITmSOaeJP
   bdI2KLW1w0whoj+Yp0+zXilGgBcz8YIRYR/wQVwOIoLUZw2auhF9JnzO+
   +JBU7MD0jEhoZid9AAyQ069WoroEn/bcgmNXmlV7fmKxACFcEmwDjRQ2y
   wGVrMUMN2fpy8p9clg83tBUTetwVw2++bS1J7bhAwy6BOyirX++a5zXvs
   EMrF/qpy5eGlai9dtAMaMGOwnDvqZ7wZJV+oLQpDJVaAXQUwiWWPc3LlE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="361867353"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="361867353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="767737273"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="767737273"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2023 10:33:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:33:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:33:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 10:33:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 10:33:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwUIrwLR3TggEuimS/FEXY6v6dWEif027Wu9zyrvDTHHPZ/z6tzkFkd9MUbVlZwzRTOYMj0/9KrSsETw56DuT0Mc6/6URVK9ry908O6oZHh/1zSlASqCjPTQf3NcaidvWqSk5OwMLLzMba6QrgT8Syo4O18ZigK8DVSQsRM/M6tCaa0WFSW3GwiQ77Ja9qWbogs0JwtfSw8u+rHADj9o4YeGyHMwOGBxBhbc78lMijuPxQ82wYGiXxaJgpCoTCTdXtrW0U6IvkS6o0KYl9MLM4crtFrYNf4sndkn1PcjYfWzjzpE296Y/bo6A95kg3g0Jmnj/62GSWYIgJhgNjzNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayjGD2QEKfzQDKZW8DXeIf1hXm0zptl1r7g+ARd8dAQ=;
 b=UbWwCIbljXsnoAxSrltpukXBNWnSUIc0L4uZY2S6oXRYigTbCkiboE1/kvl4ZRVJWGbXF/JZe7iXD2WulSa7XZRGAlKnYSCWQTifsxCQBFHnExV+MI5Tx/24lOMnUWUdXqc3vltwtyUpeq1qulPybfqTaBlx0EMhYU0Ugj9GbPE+M60rZydw+0aEig5bJEqLy2NJkTbFshWM2z1MaHrFnaRp4DGAJ4gqXzmRwyhJUBVv17n1hNO7/MHxAIydgSvD/r+Twgz56VQPnUOtTkbHS9aS1hsPslD0g/5+wILLkLpR8336cEGBaCosx+Gm0vI6SwSjm5Ok9mKk/qv9LoIDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:33:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:33:46 +0000
Message-ID: <dc06f2ea-ed1e-60e5-f2d7-ccf7facde25b@intel.com>
Date:   Fri, 11 Aug 2023 10:33:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 7/7] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
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
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-8-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230722190740.326190-8-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:303:8e::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4d728a-cb21-4dd8-57dc-08db9a911d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OsAaS2xFiS6Q7j1SD2ylDqvcALNPb3os2iph2njbpGpJOoyH9YlHbS5G5eg3yL8DAejyluFkft6JBClk38XZR1fA/2Oxd5R+dNE7k+ImXJ59hiEZSQoS+9tqtX+3UDJyj5We9g+x2voTHN54KvjZnkHO+yjDd2N0+zdZj/qBaOTOzwaASJHNa3R2SrBJTjo87Dfbu8qUI2GSXdkq7mnqzsNTEbfuf9+mbxkgr9UHK69Vovw9bTWz/uOUenetA6CUft0JZt7eUBF6HxI2VYuDdzNQERlgZmmdIjhKcqF93xCjcCFzwnXGy8CJax8UCRPSC7GZ7LhwdI+XKZ3d2GLhXuoP6Ern9KCOJhxLbWFxWx4lwIJQJx1R/EGt1BWdBdmYkbd3lujW1JADyDwOak9YSvIgoBRbD1oF/XuA5jKETVgQ4/QIV7Xh4AmciG9iNEWHYltOU8vA4TrwN6az4Gua81RlwRskHQk7YR41JrZlXXrkKDQsz08eYXIVmyir/PUzZqEtRRnSqvd9azos+atSmKNrW3MwD9DzvkJUjbBbE6VjtumOPv83rNmrut+BvXXt7/WF+rClps2G2N677DfqLw5z/uPxHI8vDtEQASwmrB/LzqVBzB8/P2PfPkRdwPWVIotiPRfJayyj6805eC4D+k1JCdr/4Ur9awSBDo0J0TCQV4v+nZEewt1+FWifi+n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(396003)(346002)(186006)(1800799006)(451199021)(2616005)(45080400002)(86362001)(31696002)(44832011)(83380400001)(966005)(6512007)(7416002)(478600001)(36756003)(2906002)(6666004)(53546011)(6486002)(6506007)(26005)(38100700002)(41300700001)(82960400001)(316002)(66476007)(31686004)(66556008)(4326008)(66946007)(5660300002)(110136005)(8676002)(54906003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlg1R2FxbVM5UldyNHdzUm42dk9jUU9CV3UyTnBZQ3c3WEZncVcyd1plZXQ4?=
 =?utf-8?B?aGpmY0NTQVZPVUZNMHBRMi8yNTVXblhXY2tTeS94b3pyLytFeUQ0MC9aUTdS?=
 =?utf-8?B?c1V5QXhta3pHZzE1UHBTeFRTTzExVHVTRkgxMjhsbGpSamg3TjdGZVlDcW5C?=
 =?utf-8?B?ZGhqWXJXb1pOZjhOeVZXNldtVWFCeGw4TkdyQjJjd1crd2hvSkpvcmxjYmw1?=
 =?utf-8?B?c2Z3L2xrNjdyTTg2QWd1d2pWUW9pWGtBZ2l1YWkvejJCRFk5eVVBbSt1K3R4?=
 =?utf-8?B?V0paVnJCMExWVU5JeW1UY3JCVFg0UDZVZDh3aDZ5QXZRNWxBZjd5NFVMbVl4?=
 =?utf-8?B?cFRUSE5XZWNOTWZrL3RzSy9RaFpqVUZ6WjFHNEl0b1dZSGxyd3gwaGxWa1VE?=
 =?utf-8?B?SFh6SGxncmlqMmRLeUxoaFpWMm13YTJzWUR5OHUvNVZFSFpmS3lwZnBXNmRO?=
 =?utf-8?B?ck4zbUN4SEo2aGxURnJ4Wm1mSWtYeVIrWUJrZlFBSjFYNjdEa1FQVktNSVdS?=
 =?utf-8?B?SS8zYnVLR3ZWUmIvb0t0NDB3dndOc25nd3hzMDRDV1pDSWJxZFZlSWFUSzdu?=
 =?utf-8?B?ZG1iUVNMZXBoc0pRU2Q1TXlpYk1RaURVSmpTaVlxZ0Y1Vmc5OGhxeWdYWnll?=
 =?utf-8?B?dDVuQzFvVlZFRUFtQlBDL05vWkM2RUxUTnE1YXV1akVEMjBnNXpXWEFpR0dS?=
 =?utf-8?B?c0hhc1lON1VvQUZEN0NRUnFtUVRyRko4VTJnbWpSV0VVanNnQUY3UUFkVGVv?=
 =?utf-8?B?cGxpL3ZIZDZYa3g0b1U0bUxsY1lta2lGb3VwRjFxZnM5aVI3aElKZ2ZzdExI?=
 =?utf-8?B?ZlZzZzZVZ21CSHF3eG8rQVoydWd6bW9UNlpBYW9qZDN6bm53SkhSbVBMQnhp?=
 =?utf-8?B?LzQycW1nM3hVeTJaZm9kQU1kSU4rV3FTc0loWGJpTGdoZXQyUHVubE5kMWpo?=
 =?utf-8?B?SFgwMEN2Z01VZnN1RGRSeXM3bWVLWTN5VllJT1NiaXd4aktnT0dlYlJ0d3RM?=
 =?utf-8?B?ZzBQTGxxc0NkWDE4WWZqV2lnUkJ1ZW1aN2ZORy9ZdlNoaUZBRGNZd29lWmNR?=
 =?utf-8?B?MC9XY0NNR0tnaXZnbEQ0Zjh1czROZ2RqRWtROXREc1VzakxGV2l1d0ZLakZM?=
 =?utf-8?B?bEFwV0JDY29RQTE5QUg1SVE3U0piZUM0Q2NzWWdvWlhReHVXYmdmQnY2Ymo5?=
 =?utf-8?B?K2pQbjQzVFlqVXFNYzExb3pORHFRQlZ6SEZMT1BEYVkvMDNSTDZobUdJemZk?=
 =?utf-8?B?ZGRXM0h6ZTVFL2lXV0l2NW1xaTlzQm5MZ2VxSE5qZGVleXBiNWhCOGd2S1p2?=
 =?utf-8?B?a1BSVllUNzFWSlREYS9BNTJEdzRiOWEwYzJBZHNmaVZDVS9sODgxRmJoYTBl?=
 =?utf-8?B?ZlhZOWdMelhIVGk0bXF5K0gyNlJjbllkMnI1a0NwUVVnblBHTkxvaHREd2Yx?=
 =?utf-8?B?VmMyY05NcWIzdzZpZkNZdGg5bFhHL0xkSTBSUXR2a2xjcndSa3VSa3dPZmto?=
 =?utf-8?B?VUNyNXVCNyszdVJBcjhtcGkvdVY0dWYyY241aGtweHZGcFAxK29SWXNsU29x?=
 =?utf-8?B?WkNXc29qTnlOR0VnS3pyZDdpUmI0NndhTHMvSWd1WXpaWm5iYlNZV3pPQVVz?=
 =?utf-8?B?N0VzR0dhMjVVdkpIOERMenA1S2tJMHVNWFJGU2E5VmRZSGVWNGN5VlZaTTE4?=
 =?utf-8?B?YmZQZk0yc0ZiLy9hWnhsVm1hVGR1M25CMEk2dWdLRXlyL1k0cVBTd3UxL2dr?=
 =?utf-8?B?Qk9XeTMrMEZaTXNJTGk1Mm1HYUNTK2syM3h1ZkhBVkMrckROUVJYdGZjVy9S?=
 =?utf-8?B?anJXbGdGZHFiZWZEUGgvU0N2cEpoYTR1T2c3RzlGNkdCN3dQVktxQjA1b1Mz?=
 =?utf-8?B?aTBTTFEwcTh5TWJnMnY5dm1oa1dmMnVUQ1ZGa3dXVjQ0bEkyS1pFR2NsRXpY?=
 =?utf-8?B?WWwvT0ZzR01hV3E1ckV4cVRNalZNcGVlSlovMCtLRUJZQ0lGaFlwNTdEbGxp?=
 =?utf-8?B?RDM2ODB1YkF3TFc1bTl6NDR4VnpYenpUWWwwQkwrWGs3aDIzY3RBeVh0T1NU?=
 =?utf-8?B?WDJDeGNhTTJoUHV2N2tNaGQ1WENORjFiZlp3M0lxZzdwUW5OdVFadHRhQ1JR?=
 =?utf-8?B?R0tVT3VONEhrMUZmZkxxeGJJYkRPbzVoYzZPTnlTUDVsZFkwZk4weVFaUzc2?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4d728a-cb21-4dd8-57dc-08db9a911d7b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:33:46.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xFXjzR+g9bg3B4IFgHwCqaHnpZ5Nnihki6KsnYaPiWwP/iBslqMk04CFLXSyp3Dn2SXG24VDiUfLFK563Ha789n7EWFoEwR9z3QnKwuaH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/22/2023 12:07 PM, Tony Luck wrote:
> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> nodes. Systems may support splitting into either two or four nodes.
> 
> When SNC mode is enabled the effective amount of L3 cache available
> for allocation is divided by the number of nodes per L3.
> 
> Detect which SNC mode is active by comparing the number of CPUs
> that share a cache with CPU0, with the number of CPUs on node0.
> 
> Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
> Closes: https://lore.kernel.org/r/TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com

This does not seem to be the case when looking at
https://lore.kernel.org/all/TYAPR01MB6330A4EB3633B791939EA45E8B39A@TYAPR01MB6330.jpnprd01.prod.outlook.com/

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 57 +++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 87e39456dee0..a8b43210b573 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -13,6 +13,7 @@
>  #include <signal.h>
>  #include <dirent.h>
>  #include <stdbool.h>
> +#include <ctype.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index fb00245dee92..79eecbf9f863 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -130,6 +130,61 @@ int get_resource_id(int cpu_no, int *resource_id)
>  	return 0;
>  }
>  
> +/*
> + * Count number of CPUs in a /sys bit map
> + */
> +static int count_sys_bitmap_bits(char *name)
> +{
> +	FILE *fp = fopen(name, "r");
> +	int count = 0, c;
> +
> +	if (!fp)
> +		return 0;
> +
> +	while ((c = fgetc(fp)) != EOF) {
> +		if (!isxdigit(c))
> +			continue;
> +		switch (c) {
> +		case 'f':
> +			count++;
> +		case '7': case 'b': case 'd': case 'e':
> +			count++;
> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
> +			count++;
> +		case '1': case '2': case '4': case '8':
> +			count++;
> +		}
> +	}
> +	fclose(fp);
> +
> +	return count;
> +}
> +
> +/*
> + * Detect SNC by compating #CPUs in node0 with #CPUs sharing LLC with CPU0
> + * Try to get this right, even if a few CPUs are offline so that the number
> + * of CPUs in node0 is not exactly half or a quarter of the CPUs sharing the
> + * LLC of CPU0.
> + */
> +static int snc_ways(void)
> +{
> +	int node_cpus, cache_cpus;
> +
> +	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> +	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
> +
> +	if (!node_cpus || !cache_cpus) {
> +		fprintf(stderr, "Warning could not determine Sub-NUMA Cluster mode\n");
> +		return 1;
> +	}
> +
> +	if (4 * node_cpus >= cache_cpus)
> +		return 4;
> +	else if (2 * node_cpus >= cache_cpus)
> +		return 2;
> +	return 1;
> +}
> +
>  /*
>   * get_cache_size - Get cache size for a specified CPU
>   * @cpu_no:	CPU number
> @@ -190,6 +245,8 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
>  			break;
>  	}
>  
> +	if (cache_num == 3)
> +		*cache_size /= snc_ways();
>  	return 0;
>  }
>  

I am surprised that this small change is sufficient. The resctrl
selftests are definitely not NUMA aware and the CAT and CMT tests
are not taking that into account when picking CPUs to run on. From
what I understand LLC occupancy counters need to be added in this
scenario but I do not see that done either.

Reinette
