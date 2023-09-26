Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6347AEECA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjIZObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIZObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:31:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0BFB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695738670; x=1727274670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7sCCN4J16x8f/9tCKeir/IbKhIaRezs8r9LREEHNpIs=;
  b=TMwPoy/481iG0gI0HVMB3ayvs5r91tH87XmT8c2e3Bi++DIH/YKxeZ9Y
   30vVD9GvRH8yrNtx2SmAeOqAGa2WxSdfTm2Q1kwIwKjR8blvLkylBk6TO
   QYs03H2Ymsb2gXV3ii96N3dDkFO4AQV0LRXG2UxyeURvu/UByGexI+PxL
   POiVlpxbvrJeFbv7QeEETqoOIw4f9aPjsOPq8myBY7+20DJfqtmuPRo6p
   glBTYjeu3kCWCx373Yoy+2cHp9Z3BlZ6rXKJTdE54+8RBXAVDYbcc17e9
   Wv1HEGexEa5JIITrRZjabY3ZaemlaPo+6uRFnqfvoHV48Fb92ydd6x2jh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445707412"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445707412"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:31:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="178694"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 07:31:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 07:31:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 07:31:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 07:31:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 07:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQyC4YSPaJTfH3dS4hyGMAp6/VzNiReKUquTKnlrHrBCqk7rXBJSzNpUlB4Q8KT91Ix+e2837E91rlTyutfLJyMGzZ4OAZVNLBZS46CQ3wQsM5Zv1xpAPSXiRrzFh/LQau0EFYGQ7bD71azFbARf/J1X62QEpi6MlE2KDvzv+RfC/rmryp8NlSM4EJ5m2FotASLdUp20R3+UxplAHk0ZyZbSUNLgEOyKVQ2uUyU2tx/HSnymT4KqiiUcxcORaDBWEukkUR3FD44brUQI9phRe2ishC5d5xdZH70Qqo6hE05yCh6MImFExc4nKaaZahSvzkYw5UbVLFg7rPZlSqt6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ekene0eoKFOortwR4z7CibxptuFG+y1OIYS7JXgzsfg=;
 b=TLwEZQxKXUMWk+IkMQvNh2n2J96dJsLcqCP9QjOOjgZMDN75ziULl0kBSR2fqIFMVsZk8/LK8FWS00N3vw5n7JA0UPo5q2b7Y8tb+ecmbWU6hZrpggDFXX72wQwarPsXAsC6FOmNOqTIvokT0kbF80LHHsVpY+urcE9sdjnvau0Eka5UvaZshm8CKZF5Lvs6/LPvpb/kkDN8yS+jxZ/Q/zM3cTwGv87DU1sJ7zwNS1GMr83WWZfT+2srPWt82frfP4ZdLscwmNIF1qesYAhApMqn7MzmbILJgjWhDq2/+It5qvN82BKWG2cHTzoiIrX+uvNcjN6N4u2cL6phUiLQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 14:31:03 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Tue, 26 Sep 2023
 14:31:03 +0000
Message-ID: <908ce024-db79-ecb0-c47a-626227038411@intel.com>
Date:   Tue, 26 Sep 2023 07:31:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v6 01/24] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-2-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230914172138.11977-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|IA0PR11MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ad075d-55b9-495e-8c24-08dbbe9d3610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoizhBbLKDvLjIgOPK3hfo47bUvjz0g2VxvVWq+x+onA1XWn9s/UoKszxW90SuELecuFKC7qzkA/se/cH1GWPnZLKBBpvu7qqOsPJd2hr2BIGDmZoX2bC3KIKE7GGFG/xxguVDEwodJlYjP4UpYVpBq8g9/iTwqMKYnEXUTe8zD1DtzQ2aZWV0Z11PlOHO3edky7p6UUjAI8oNsYJajwUdVQWW/jLJ8Qt2pgO2qlOky4f40jSDMsM+eC/0qJdyvBRLDCl9+MHJqBpsqAJHV1ehj+RuRCLuQKHv4hlTTp8oRhbwBF3QashWIavi4pPOqNOu9IcOsrgQqMVI3lzNJx/be+iyCWN2P8ITvuKn6/KTkqM7HsrxTrkDMbzHawrNB5E+DA91OOsqiNq+NewlWZZUjIvmPVD30vtnWTe9nD3HYCeumqiR573g5/yYbMTtAU9bnzfPetddJ4QzkxdU+46D6zJ7/rDCf0lwh78JI6l2si6RDyXT0zHUD32q7ro/MohSKtCIhoktOeLmg7zf1WHfSLr5k7LE4orohsL8+y+950KcsHQWjKquh/2v/cPNJFEVg2FV2Do9zBsfrGxXkm6xeruatWYr+WorBW4CpIqQpVc+BdbqO+cWtoIG1gFfJa1Fx2NETNBen+OqO0yqIckw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(83380400001)(2616005)(26005)(66476007)(54906003)(316002)(66556008)(7416002)(41300700001)(44832011)(5660300002)(4326008)(8936002)(6512007)(8676002)(53546011)(6506007)(2906002)(478600001)(6486002)(66946007)(31696002)(86362001)(36756003)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFlLSmJhMXE3Z3BaUDJXZEEySWhLbHZPdmt0Tmd3WGFMOGZxeTJKZWoxU0lV?=
 =?utf-8?B?NmFuUkxDMjFGM0lpMEZvTWlnSnRxTnBLdmFLeHJ1UFBZc2IvMVZuSjl1Z2cz?=
 =?utf-8?B?VE5LdzJNeG5zSm01WEl0aUJCZmY1ZlhMVVgrOHU4azkrci9hSGlqZ1JCYXVW?=
 =?utf-8?B?ZFI4MEhFQ0NaMWFUZlpicjZtdDVlZmlJeXd1dUNlZFh4R1Yvek5Zclp5bUd4?=
 =?utf-8?B?Zlk2c29rNVhSd1lmSFNwZi9ScEVBOVJZeUFMbUxqclBRczJGOThvRzFYcmJm?=
 =?utf-8?B?dm4za1BuVnVoVkZwUmZDMUE4UDBmWGF4ZzdTSEdaNFRoaDNqNm5PWHQ3VzVo?=
 =?utf-8?B?SUh0Z2xMUStmZXBBT2FreHo2TjRaNURSWlJFT0JpQkV5SkpDOURDSjdjaHRU?=
 =?utf-8?B?K2ZEZTJtemhEM0lEUVM0UkFEeE9ESTFkcUtkbUNwZFhQNGRQYzdLRWNzOGVF?=
 =?utf-8?B?Yi9aMUxyUWFRNjB0YUZBOVBzYStIdlBnNzJveHJ2TE1mTGFhaWZDNDRTdEpW?=
 =?utf-8?B?Y25RMUVzWE5uOFhOdlViSTh2NnAxd3JiaFRWemhzV0p4OXUyMnNHc2hrK0E3?=
 =?utf-8?B?WWJMWXI1MUJFOXN5M2pOVG84OUJzV083WHNscUx4VFFISVAweGJLQXhoWGNS?=
 =?utf-8?B?K1hSRzVuNDdZSWp3QkNvZWhMMzZ4cmZhcUlFcG5FRUZxdnpBcUNsWHE3QzBH?=
 =?utf-8?B?V0JXaHV0VnJRVzFIL2EwMjI4TmFwTTEyVk4ycWxyTTBMRzNOSE5NUnlYRlhw?=
 =?utf-8?B?RVhqaVJQQmRyenovMDNJVUJodGwySFlYWERLeUNZaGRjQzhtWU1ScmtFb0hH?=
 =?utf-8?B?K0NLZUsvOExSZE1FVlYvWmdmK1dLYURSTmdCd2dhdUMyQzJHcjhRUDhLMkRY?=
 =?utf-8?B?YlJDTHg5b3lhSityMklDMHMvcEpMekNnTW90NFR1bzlxbm54THlrWmQzQzhC?=
 =?utf-8?B?Y2ppeGhSc0tGWlpyd1FFdnBRcTBqSHJ1Zm41YjJBeUVBODRCM25QSTV1aXhO?=
 =?utf-8?B?TmFnenBGTlZFZTQzSlFoK3hpdERLcDVzRkcwZ0Z1K0R0YzBpUHBOUDZFeEVM?=
 =?utf-8?B?eFlKcDBMakpoUUtsaEVFVHF0ZUpUVGQzRDJNb1hXRDZFdS9CV1VzVXBQM2Jt?=
 =?utf-8?B?TXVEeG1CWmlyT0lWdi83S1lqdU85MnFMaWVQZHJrY2thNStoRy83dUExR21y?=
 =?utf-8?B?MkNkSml6NnJUQ1ZhcG9TQklhWkx5SndMQThJS0drV1hubUEvbnZ0R2hJRGtm?=
 =?utf-8?B?VzFGcldTR3ZNLzNVSmdPQTQvRlVwamdDZDl5d2VSWjg5U3V6cG1nbXJYRlgx?=
 =?utf-8?B?TnBKTzlSbHZFeEozNzhNOTdBRExxUVY4MmIwUGFCQnltYXFFUmlSMTEzUEpV?=
 =?utf-8?B?bXdHVUNzdUtKTkQzZmtRa2tXS3BBQUN0c2w2TGVzcW9BSTlGaXlrZ1pTZ0Y0?=
 =?utf-8?B?MEJ0NWxlaG84dFVMTGJjNlNnVytXTG05aDk1SXEvdE1mWjZHWlh4VGxjYVhJ?=
 =?utf-8?B?SDEyZW9vN3gyMy9pUXJ1QU9ady8ySUJ4czkzRnJPeTltK3ZEMlVCeGFYeHls?=
 =?utf-8?B?TXkvaHM4dmk3cjRxQk9xVHpONGNjQktrb1o1UjdSTlc0NGJQVUFHWnZLRTNV?=
 =?utf-8?B?U3pMTlYwa1ZpTE13WVpxdEc5aHRsTVpJRHhGU05xRzFROXZ2cmc1U25jc3Va?=
 =?utf-8?B?S0ZNS1A4Y3B2Zjd3NmJOT0VqM3hPS21jcTYyMU0vTnYxeFQrUXIxOHA0ZzRH?=
 =?utf-8?B?cXNLWjRNanhncld3Uy80OXIvT2pveFJScTRnUlVaTUcvSkJTeVZ0aE04YVNF?=
 =?utf-8?B?TDdEd3RCRmFKYjhhMFMxYWJoWHVFMUc1YUxZaFNDUVFXMmw5UVR6QmhrWlR2?=
 =?utf-8?B?ZGRGK294Nnk0eE5Uenc1NzRQWmZFc2p5R29yZzA5WTAzMEx4NHVweSt5bEgv?=
 =?utf-8?B?azB0OWhVeHlrNGdhZE5ZdXNYUE9ZMFN6Uk80c0grM2pBeFBIU21NNjFUKzdz?=
 =?utf-8?B?ODV3QnBxcFlnNlI3aGdleFZwV1lBMENDZXNyNGVOQjNYSmVsTzJDL08zKyt4?=
 =?utf-8?B?VFlMU3RCeEpycm85bnhxL2o5VHZoMGp2eGtqZ0F2ZUNlNUwyOG1PNW9QelFh?=
 =?utf-8?Q?9CkhMcRWrOHysPVlTSni4zD/7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ad075d-55b9-495e-8c24-08dbbe9d3610
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 14:31:03.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35+D7yVB9+RYXH7kz1bOw29Isy/nTu6hYNm+QcFBeSOVQZbWfYD5c3NzLDKXO4AJJBiO5+CC6su3i+EqrkOpCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7838
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter and James,

On 9/14/23 10:21, James Morse wrote:
> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
> a specific CPU to be tested against the mask, and evaluates to false
> when CONFIG_NO_HZ_FULL is not defined.
> 
> The resctrl code needs to pick a CPU to run some work on, a new helper
> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
> be behind an ifdef too.
> 
> Move the tick_nohz_full_mask declaration, this lets callers drop the
> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
> something like tick_nohz_full_cpu().
> 
> The definition does not need to be moved as any callers should be
> removed at compile time unless CONFIG_NO_HZ_FULL is defined.
> 
> CC: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>

checkpatch.pl reports warning:
WARNING: 'Tested-by:' is the preferred signature form
#27:
Tested-By: Peter Newman <peternewman@google.com>

The same warning is reported on all following patches in this series.

According to Documentation/process/submitting-patches.rst, "Tested-by" 
(instead of "Tested-By") is used.

Could you please fix the warnings?

Thanks.

-Fenghua
