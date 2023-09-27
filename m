Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85357B0EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjI0WDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjI0WDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:03:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F12E102;
        Wed, 27 Sep 2023 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695852221; x=1727388221;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nP5KeBZ++GBFuUQwOi88B4EexeyffhuA4OkrcJgWkjQ=;
  b=MK6OonyNPZUAfFCEqyQoy60Depq0ggWc34LN4403zCMakYbtooI3aEKx
   S/2EFYKwRNoytfU9xghIHR/rOwkmgjqkjw+wlpbx2FWcdNCx67YHq+6o8
   8ZIASP8dDDQhiWFFmklpwjAaoMhtEiHSlrFszjk78SOKQdqKHdG0/IXAo
   BO8qztKMAuZWkp4gmtJyM++FKOTNIX5boDy2YSPBCkrV8M+Gx7S7iaNlu
   mIM/8W4TtnVM+n2Ei+MNlMUiYGkas+TCZ6PZeHvVRRsnUOZ0b7lYW+T6g
   MhGjqNKEz7vs2J+JXhuytHT2llJeNwrYA27KRYAvaAjn+8Sr/ETxhs1CJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="385800479"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="385800479"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 15:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="819612742"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="819612742"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 15:03:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:03:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:02:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 15:02:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 15:02:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+0Z+yZ09HlrcXHevXqBQhqgNs7m3ziLdfWzdIEhxPiYdL+n472flC59QosFZahTugJrqNAdPLNRtEMOEM92VUYW+p6KmmOlbSbfdIrDSRPuVXeSv4vl4K1hRQ7AeIjcWfA2Iv3OEAK8gQF/hs5F23kLnQhtpMdZiT+WXf3VaVAcwYevQX3b7s+pZye0/o/vyV/bFEYqGklXepzwftxWlcZC0DEd2Zn0FRA6IvsM6jEL/mzsuJw9PAIP6kNUX0Gp08eHYWtD93usPJfxdJfxnNhmRB89RDi+/KWcWJb95OYTizm70X8ElKUcKBMiSPuH5RDvlT2/apG4987r0cS2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LE9HBvmAL9Y7elD8YJLlZXfB7zPM4JAttFLLQo6Mbw=;
 b=Ptq2UKVCkee2FbzK9woYOCS9czlB/Ib6qlzII/Sc+9RFS/RDujEz+cX7jGDzo9smrvqvadJxiPWMNqUNyRxLG89l0Z8qyz1Vp5+prRPiXkRRDTj//v/ZJswDzZ9bWj/BnY47ycr1eU/oLGDWxafOR/IPOcljMtmgxpeNCnjrxfJXs+1iSrZ3IhkIzmNnSQ4U38/ucmKgO7MlVbvy9kgw/5tym9l0eIcWwYyhvN9aB6qbPzWiuV8YrGxsKcPRL1KC6j5+Iv6E/WYh1xqqBTxAkYqciRCbbaWpa0fwsaxSmhqVO3TEOChl4CA1MMZmpba8xDSPb5anvzCdC1zp4ysDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7915.namprd11.prod.outlook.com (2603:10b6:610:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 22:02:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 22:02:46 +0000
Message-ID: <8e6fec2d-2262-1f62-8c4e-cedfa8459434@intel.com>
Date:   Wed, 27 Sep 2023 15:02:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v10 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-10-babu.moger@amd.com>
 <031ef099-a7d2-37ce-eb97-c4f7d76a12c4@intel.com>
 <7c6dcc06-0b6c-a346-c7ff-60da3fe59fbc@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7c6dcc06-0b6c-a346-c7ff-60da3fe59fbc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:303:2b::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edc0dde-fe38-4479-3985-08dbbfa57b9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9w6+FnRehqfWzJ50RX6woP/wNtRrVQ0c7Arkrgd9wWDbAUlGMGFF2QG3MHi0euveCqt0ur6ClYywYIg70x5bVITvoM1t91LkZuvj0UscB9HCczSpvJyivgg5Z2qw8qrptvOsAz/OYYNTzbWdkc0OzyBjD1Sc9Q73AJ7fmmcbTcTTUZBDLEp1u/YbTXOwhYAjfiDct1nszCwwMqqdgDN6ejf0/SZSDm2JmNtH8nyILWMiFq4nOSjSS+88599rzCw4z2YYyehO5kouDg4GvO6K5CXBN+FJ1VGYfreCp0/KQvqWX2D9EbtZzWH036ZYG6tMazbHAqi8LE0dfo23vFKIB1EFt/vO3yhBrufb++9wxrmHjmsiheA5IrbHGPeot3REou+pOxBxvjoF2e0m25KaS+rQvGYvkZ29F6DwMIeUhmmt+S2w1crAEr27YJxELQeDQHdG4UBUN1GGHcXs1S5KVBVZR7nUnCwCjDWryua9DNcVXb5uR6+Q48RFRymoxHujrD73cx7u+FOp/hUOdluKRNK0AAiITa2RIPxPQpd8R50G529l5V73RuyXFz5niCLj3ZPAvxmoWdZO/wBBBYVjarYdAn6ta1H2lzcm/UYV5OEJ8ldJW9xxtWj1hB6YsLsW2snd2Uh+j8aSYg23NBX1ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(66946007)(6506007)(6512007)(478600001)(26005)(2616005)(6486002)(6666004)(38100700002)(53546011)(41300700001)(316002)(82960400001)(66476007)(31686004)(83380400001)(7416002)(66556008)(2906002)(7406005)(86362001)(8936002)(31696002)(44832011)(5660300002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkp2NjZkM2dTS2ZqcysvRUVrOVBGaStEalViT3Ric3FMT0g5TlhhVXFNM2U3?=
 =?utf-8?B?aU94UURqOTNyQ3FpeTJYVElKYmg5R1RIRDdhWG51YXVlQ0pQMG5qNTFUY3Ro?=
 =?utf-8?B?NndRNjNQQWJrSmxPcDU2RC9iNW1oYVlDQlE1Y3RGYk9xNWxzZFFmdTdrblZz?=
 =?utf-8?B?YjdYSngxU1E0dmt0TFR0MTlHUzF5TlNlWnNlVHc1emIzbmdoZ1hLSUdnSmZV?=
 =?utf-8?B?NS9Oem1MTWE1d2dBRWxQY0JmSGE3OHpjVnpSaFJVczlzQ3JHYUJldW8xSmsy?=
 =?utf-8?B?OEJOTS9wcXFMWGNxdHVZVzF5ZkFjNy81RExpNzR5MjBtQ0dab1AwZDNLSlZW?=
 =?utf-8?B?ZFJ4R0tDU2ljY055K1RFUHFJdjRZSmt4MjVjcUJpM1NSeWNWNDNDMmFuWmE4?=
 =?utf-8?B?UUlDaXdqank0K00zVzFvV21zRkhNZ2JlbGMwbjVLUkVSSkRrSHduVjN3V1Qz?=
 =?utf-8?B?YUNsNTlSUktwN1Y3SHRoaG4waGo2bFRSUUhuWGFRUFp2akorZWVsWVNiN2U1?=
 =?utf-8?B?alB3MHFjOTFPWUFuaTN1L3RZTWJKTm9IczBjelVVRnZEUXF4NUlxdW9xeU83?=
 =?utf-8?B?TG1XeCtZSklKQlFSZm42VnB0NERvUEVQTEZTWVFkUisvYnRvUkp4Rkw5RHZn?=
 =?utf-8?B?eVpJM0ZYWnIyWlFXYTlqRVptUUlwUUhZY0RJY215bUFFek54aUFYQUZua0VW?=
 =?utf-8?B?c251MzluU1JoSHlRb1Vic1dTaHhKOHZlTnkzVVZJOXppd3NXZXhwS1FkaU9L?=
 =?utf-8?B?OUQxeE5aU3JtUDl4aFFGNlBYNlVGZTVBeWVhM3QvakFreWdabzRueUllcktD?=
 =?utf-8?B?Z29Nc3BrZzAzUHptazV6eVhKWHpRMTNXYk9Gd1Bic29iUUM2c01pRjM0Y3lk?=
 =?utf-8?B?eFJFZWxXRDQ5TkF6YzdTSEN2N2lVMHp5Y1VVV2JZV2hXdktERnF4Y0RVK01L?=
 =?utf-8?B?cXBkRGhrM2dPN3RUV3pZV3pyN0Q5WEV1MzJPcit6OTFORzFyUWdKM2lOK0tN?=
 =?utf-8?B?WDBTTFZ6ZjdBQzVLQ0xwY2lkYkYwR1RRclVXS1dqR1UyWXJ1MHYwa1F4c0hy?=
 =?utf-8?B?ZnE1cHU5aSt0Rkc1ZFpKdjJ1OWJQTlAxVWJGNlZ3SGgwZHM3M0diSzdsL2Zw?=
 =?utf-8?B?SWNiQzlvZ0JONHFSV2FrZ2dETjdoSVc4ZHJEWW9lei9YOFRhNTdKNnhyWnJX?=
 =?utf-8?B?TExIa3FmMTlLeHA0OFlsRFplc1R4KzJKb3pwM1VBQzFuSlBpTnRZL293UGd2?=
 =?utf-8?B?VkdZUVJRenhsK2QrL0RCUE1VUktrQmsvUHM3OXVIaSsxYjA4NlA3T1Vsd09l?=
 =?utf-8?B?ZjlVc1ZTSHVLTFp1MmY2c2hTbUhyd1ZmRzYwR20zQlhyWUNXNjFGRlhQdGRy?=
 =?utf-8?B?Sm5DT0RRYkpLcHduVFQ2Wm5WUk0wRnMwWXkzVlNQS1NLemJmWUJvNHNoczd2?=
 =?utf-8?B?UWo0dmo1Z0cxL1dkd0xlSXlIM2ttZkZROXJmWFpyZ0w2akc5ejZnUDZkVjRa?=
 =?utf-8?B?K0RLajFKZjdQVFVWR2dHU2lnNlNMV21NREM5WVdyS0xramczTmUyS0Yvb0Rz?=
 =?utf-8?B?SXA2dkRDWGk4b2J2Qmphcnp3c2dkeGxjS2h3WmpWcVBML0ZuRHhMck1IVity?=
 =?utf-8?B?THhJaElqMHpwYUYwY1NFQWEwbElOSm9pM3ROejJxdlUwUFp2cHNHQVJxRnZ4?=
 =?utf-8?B?amZDS1pMN3pFZGZWcXdVOXQwSGdMQms1bTBlWFRQNk5NdEliOTFiUDBwUHNZ?=
 =?utf-8?B?MmdPcGVHcDBMVmxKWFczQnIwK3h4V0I2TlpSWURyS01WcXRscHpQNlZucWxE?=
 =?utf-8?B?WWtoK3JpZUJuVXBaeURESEZZNmZCejBhL1llaDRYeEFOTlkvWHB4d3dSRjd2?=
 =?utf-8?B?MG14N0RhUFZ6cTFBRVhIaDVxWlc5V1pWMSsycmlzQzFBWXd1amdHWTdYM2VQ?=
 =?utf-8?B?SlhpV0EwV3RFcmpPR2pJcU9nbjI3dHNQckY4YThUZHRGaHcyMW4rTXNjZlhQ?=
 =?utf-8?B?aWpXWU1uanphQnljT01LSW9GWXFwMmMzbndVQ1lHbjJNdDIyNlZwckhuS2hm?=
 =?utf-8?B?c3hCUlBVSmpKL2IyLzlzZUtkYktsLzhiT0JOeUpSTUN5T1Q1NWp5SEZmNVJY?=
 =?utf-8?B?cTZuNC9aSmQ1VGV5YWQrazhSaXpqNXJKQU1OdjhXSjVqVkRsMWNHSEJkL3pH?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edc0dde-fe38-4479-3985-08dbbfa57b9c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:02:46.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkmROXm/IbqMMSFcasw3hZYxLOjh7wjE+vDtwFBlg3QCAU5coEf5jPg8w7OhIk7iQEutC4umpV/kXAunGgK2YGfeFYXSh07mT77ckFkuHX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7915
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

Hi Babu,

On 9/27/2023 2:34 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 9/27/2023 1:34 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/15/2023 3:42 PM, Babu Moger wrote:
>>> There are 3 types resctrl root files.
>> Considering patch #4, should this be "base"?
> Sure.
>>
>>> 1. RFTYPE_BASE : Files common for both MON and CTRL groups
>>> 2. RFTYPE_BASE | RFTYPE_CTRL : Files only for CTRL groups
>> If (1) is accurate then I cannot see how (2) can be accurate.
> 
> How about ?
> 
> 2. RFTYPE_BASE | RFTYPE_CTRL : Files for the CTRL groups

Yes, this is accurate. Even so, this snippet does not seem
necessary considering the changelog rewrite below.

> 
>>
>>> 3. RFTYPE_BASE | RFTYPE_MON : Files only for MON groups
>> Same here.
> 
> How bout?
> 
> 3. RFTYPE_BASE | RFTYPE_MON : Files for the MON groups

Same comment.

> 
>>
>>> Files only for the MON groups are not supported now. Add the
>>> support to create these files.
>> This is not accurate. Files "only for the MON groups" are
>> actually the only monitor files that *are* supported. The
>> problem being fixed here is that monitor files are
>> not supported for CTRL_MON groups.
>>
>> I made an attempt at rewriting this commit message but I am
>> doing it quite quickly so please do improve it:
>>
>>     Files unique to monitoring groups have the
>>     RFTYPE_MON flag. When a new monitoring group is created
>>     the resctrl files with flags RFTYPE_BASE (files common
>>     to all resource groups) and RFTYPE_MON (files unique
>>     to monitoring groups) are created to support interacting with
>>     the new monitoring group.
>>
>>     A resource group can support both monitoring and control,
>>     also termed a CTRL_MON resource group. CTRL_MON groups should
>>     get both monitoring and control resctrl files but that
>>     is not the case. Only the RFTYPE_BASE and RFTYPE_CTRL files
>>     are created for    CTRL_MON groups. This is not a problem
>>     because there are no monitoring specific files with the
>>     RFTYPE_MON flag associated with resource groups.
>>
>>     A later patch introduces the first RFTYPE_MON file for
>>     resource groups so fix resctrl file creation for CTRL_MON
>>     groups to ensure that monitoring files,    those with the
>>     RFTYPE_MON flag, are also created.
> 
> Looks good with slight change(only last para. Rest looks good). Just removed the "fix".
> 
> A later patch introduces the first RFTYPE_MON file for
> resource groups. Add the changes to create the files for CTRL_MON
> groups to ensure that monitoring files,    those with the RFTYPE_MON flag,
> are also created.
> 

"Add the changes to" is not necessary. With this and removing the "fix" it
can be summarized to:
	A later patch introduces the first monitoring specific (RFTYPE_MON)
	file for resource groups. Ensure that files with the RFTYPE_MON
	flag are created for CTRL_MON groups.

What do you think?

Reinette
