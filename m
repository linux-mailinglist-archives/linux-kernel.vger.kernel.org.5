Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA78278B5FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjH1RHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjH1RHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:07:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AE51B8;
        Mon, 28 Aug 2023 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693242413; x=1724778413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gk3RBt/40WLVh4PtY4xAwwPk8iRZkXSRyAq3A6qTRK4=;
  b=L0XbZ5LAe30riHuDIZCQkOJu4KhBxVC42vgCJiBh8bkOgB2BinlEcTni
   OYSzUzw0lR2OFUr2GkY5z0zLL4qaFbonbpO1ahEWMNOUoIRGYdfw8UTP5
   Qnk2E4zcn75k9Pbg1NfinO0ZLFAYZb+ax9Jx8OS7efJgg2SFCOglEnpkj
   N7IefJXvL606t+d3u8J1p4y+1PrfVMMPPNZKVgJIyznvubfoTbJxJFfvb
   64J0zI3TeJLLb3fFOuyKcrgFlVM3CTtIwPkWb4EEkzTV3JgUNPl7IAe5y
   aR5I3wpsOqJaB3UxyZg4V2dUYfmA0hlXfn3Ba+xsbVmpgTRNOVTSVriqL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441502264"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441502264"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 10:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="741476124"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="741476124"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2023 10:06:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 10:06:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 10:06:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 10:06:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 10:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmNpeczjMkOKarXhuXZATnwgZ8GG7a/Rn9A8WeNC36z8fiaMGpST/PGcraEUd/Qv5ub/Yfk8CFNSQa93EhJZPe02iv/mXaFAPS2oFEMYP5GMYkxw6EqGfu9DG01PTwjryw2ATYwFY+X/0tl7laRc89jeHx2L7snoMTGIKKjkKjXvAaEMmX9IGyQPtMV/0i4x1AjRQYI/iVqNMDBpe8p5mJmDn4xcoonv5VeeuOAVFCqdAuvFHSRV+KqcrJdlNsRb/5uqEidlzSV1iaMWZlCGDBi91NFtkJJ40F78MSyzPN/uOt+yKBqguo/HOGDsn8HUJKDdfAvhByeCcsBDHxRKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wzahat8xY9NyuFQuCAjNmmLBHGfON2WQgZW0KnwDRZY=;
 b=IBkRJfJo/Bfe90Xu5jcyb2o4KxSWuxo+8ri4cBheENbwLwdUVw6p86jHNbnlQabRAt4HsSmubdNSVkEBsbnl8yJLowqpArJJNbX9cR/qiIS+xhD1ZcFF/BfvtoJE49uu4QgaMqFAg7vzQF0bTv6RvRsj/0y0MkCZI5lS9KFqpyUQo1QXj+2oa8Z4ah+Mu5w1TGjRBAji//TnR5gLmDsBsjugRyAXsQRLqJqmZzk+myizLopt0ZK79KQ5fX5zPw0Wlc/GhhMRaBBUyuTy3wC3POEC8CXo44AuTQCSEyibrGcOUFCVDG0PKilknuFwohlsFdme4X5jsXkb0CIITXS9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 17:06:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 17:06:35 +0000
Message-ID: <f791d0e5-43b2-8ec2-436b-c008d2ce7696@intel.com>
Date:   Mon, 28 Aug 2023 10:06:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 7/7] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-8-tony.luck@intel.com>
 <dc06f2ea-ed1e-60e5-f2d7-ccf7facde25b@intel.com>
 <ZOjrYB1UgtRchbXK@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZOjrYB1UgtRchbXK@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0373.namprd04.prod.outlook.com
 (2603:10b6:303:81::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d02b68f-8b12-4a6e-ff16-08dba7e92240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4jQIygCBR5JTkxOjUxGBTjr95Gv7A2GqZUp/BUwktPPnEX6yjRzrddg1Fm3eJFHgfaCNAKFW1P1O9xVrcihaVWP1+lsLSTAp+WvVoh6KTv0yr6GHSj9t6edMEgf0YDjS9JSShFw8QEKCIrUi2XkhIpy8Iy2MmElhLHcJ0IE98CxXG04uY8L2eV8tpgqcHMohA5maEnhrcPKoBtXIgvnDY7N7XjOi13MiYw9BUme+sff1/KxLc2RYnpELEgUQBTxf53H90j94ndFECe3VtVhHV5rAecz9Vfwb33Gv/j99qsFz0uxDjSd7/H7rczq9Y6ij0pWZD4sfiQodvYTvTv0JfIzY6ogh70XUp9BtqeUl/4Vg4ffnFBnX3XwVqB9D/ImO4qxOAPs+KSUqxDKe9psb2osPc2xFZywo6612622Pz5S4ZaUbnNe/BvtkrFjC6nmi8/i/4UuGSdgEozeYYuS6BwNxDqTRkpK+s29HHJ7sts1RmNUEN4IUYMWKX4W4R9JlRtx4g34ImXYbdF8ujuh1YoxA4/o7KoXqUeiQghg9KnZRkbJPGfSn0zxvJjQAND0owJwYnM44Lfdy9Nzr6//BYc6z0aXDnyhHN36rkymSQ9qPjO06jzTb7SQjfsH0k+rd0GhupMdlpP6Dxz/J9i60A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(186009)(1800799009)(451199024)(26005)(41300700001)(7416002)(38100700002)(31696002)(6666004)(86362001)(82960400001)(478600001)(83380400001)(2616005)(6512007)(6486002)(6506007)(53546011)(36756003)(54906003)(2906002)(37006003)(66476007)(6636002)(66556008)(316002)(66946007)(5660300002)(4326008)(8676002)(8936002)(6862004)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVrL2NlU0JKdVk2MVNLMkFxTWpHK081amt0L3NGTHJtQTRXYkpERm1HekxB?=
 =?utf-8?B?Zis5bU9vaUt1RE5ITW9yOVZTTzMxV0MzK2xHSlRvQ2FlWGR5WHAzRmpCSWx4?=
 =?utf-8?B?bDQ1UnJlbEI0VkxKTFJ1RTdZaXJQT3k4TWpvNWFSY2lhVzV6bHdQdTVNWUxF?=
 =?utf-8?B?a1hxNFZza1kzZUpoOHpFUFdyZFB3emhpdUMyWmR6NTBDdnZ5Y1d2NEhJcE9a?=
 =?utf-8?B?eWtvajNscERRblU5Y3FrdXF2eGptcnYydG44UXQ1RG1EWmFBL1gyYWwrb0FY?=
 =?utf-8?B?cm9VL05WNUp6eDBKazcyV3dYSXlYYW1EZHlKVHdyUDNYYVgrZVBURzRzR3ps?=
 =?utf-8?B?aUtzRlZ5Y01kZXBlYXNpRytpbHhnamhkbXJLTDlFT3huQTM4TzU5N2g0ZHFY?=
 =?utf-8?B?M3VETXZmSk5MZWxTSk42UDRFaWNWbE0xamQ3ckNKV1paRk94eEwrZzdFTDcw?=
 =?utf-8?B?QVFGeUVySUw2T1kzaG0zOERadmQ1Zm1NQTlnSkZnNEFoSmNZTmZnTXkvcEJV?=
 =?utf-8?B?R3paRytBc2V1cExva3Fwb0RiMU1LaDVieVgwOTJkekZCQ0I3bTNRcE1BYmdQ?=
 =?utf-8?B?anBpaUtZQzFVaW1pbFFYOUU4S1RHQisrcjllRlZKN2ZmcUwvcGNOT0F2Nm1O?=
 =?utf-8?B?UXcyM2ZXY2RCUGNhbkZxb1NCWmcxUXpJZUJ2dlNPbzhHajBGbFNXWUJMK3Yx?=
 =?utf-8?B?R0t0TUtNbjVCa0hnQVp3QmlPN0k1VTI2akhmV0JpbWJ4b2JyS3ViK0pwN2Nv?=
 =?utf-8?B?QmRrWGVrbHVkQkE5NHFjdDFOQ21vUWxqeHFwRzIyR2RZNUYwNXZLVHN5SUcw?=
 =?utf-8?B?RCsvQVJJNVQ0MWEzWW5oTEx1cXNEdmlDL3JXWjJtYmFwOCtkZGRsSkN6dFFq?=
 =?utf-8?B?VStNSTJsVUVmVExwQkNubGhKUTVpUjlad0Rwa0JxTHNSWmw2bnV2a3JhSFpj?=
 =?utf-8?B?U3huZmhmV0ZIa3poTHZuWmkyaUxIWW9PbExJcUJERU1pUndFRE5JTyttTGtt?=
 =?utf-8?B?Y2VDMnUra0M5aXpOaVVRUkRoaFpFOHp0Z1ZWMUtzR1pyWGE0MzhKSVhPSXZR?=
 =?utf-8?B?OUhwVWh0ekpSOXh2R2UxV1FEVkNXMEhRRHFpcDlTKzk0MDBJdXpTbTZFQXJS?=
 =?utf-8?B?M0RBK2Rtem40bTdZbTdCR3Frbi9pQk1DOXNyTHdqcW91RStUNVZYZE9uRzV6?=
 =?utf-8?B?UUwwMDlSQzBUR0cyYUVsRm91L215bEtReWIxWmlETjdRMzJmb2VxdHNxMmlx?=
 =?utf-8?B?UWhmUEdvazY4OVpyU1NYWGlYQkcrOXFXSEZHOVVEdWZnbXc2K0kzTW5qSWFw?=
 =?utf-8?B?Vlc5RWI4NTM2ZERQb0wzbjd2Vkk3L1Nxb1FuTFhwWUd6NEtrbkNKZ1RWWVB2?=
 =?utf-8?B?YjRTV0VIYWk3YmRrQkpjdTBwcGhHemMwRmxCcllUMXB4QkFVSUd4YlpOTkRC?=
 =?utf-8?B?dUQwNnM4N2lhN2p6blRSUlBBUURmOEJoTXNuSG1EdHJETE9wNG1oWEcwaG5K?=
 =?utf-8?B?RENaeHZTN1Z5UGJMN0V5elpZQ21RemlsekI0U25xRUtBTWNsNDJzc00xSFRJ?=
 =?utf-8?B?MnRFWjVnRVlXL3RZWmQ3Y2VpZHc1UDRDUTBVeVV5eVJKQVFWNlh0eDdLMU45?=
 =?utf-8?B?Q1FtV1Yyc2g2Vjg4YlBqb1ZDTDBxNGFSbHlzNUMxQjRNb2VBVDF1T1NydHlQ?=
 =?utf-8?B?TnVraDluYlppVlI0ZHc1R01YMWhKVGsvTXlvTENVQUsvbDNUSDlNTnE5eFhn?=
 =?utf-8?B?N3lMaGkwd0xpWUlEcThwWVhtWCsxWUtvOVIxcHZMVlBqZXRRbWNWOW5BVnh0?=
 =?utf-8?B?VDR5dHdORDk5aVlNZEZPdWJvemRjMlNqZnlvUHlIbVNsYUlwRkRrK2xqV1RP?=
 =?utf-8?B?aVVDUndEVDIzRllQa2w3M0dVM3RNZjVjNGRsVmV2VlNSdXh2Qmptd2prQ0E3?=
 =?utf-8?B?WkJ6a1N2dFZmWW01SzJXeHEvcTlrQmh0Sys0Tk4wR28wM0VtdVdyK1N0emk0?=
 =?utf-8?B?V3MrN0VuYTRwckR2YnpudHN6clhNYVNyZ2dqanB6dEQzNmQzamhKTWw3aHMx?=
 =?utf-8?B?TmpxUzBYaDNWd2twZW5lalFxRkh1Y0RYRHhZcjRxMVdEUXJaOEg1SGwrVTZq?=
 =?utf-8?B?RVJkV05rU0RjdTB3MGo0ejJTWjdjY0RoejJ6TjRRVXlGNGJDbVN3VHJ4ekds?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d02b68f-8b12-4a6e-ff16-08dba7e92240
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 17:06:34.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv9+0PMuuuB2m/O1Xqcj2vOZxL77Qf5n/5cA7w8cRfTwUceYNHHHKE6L7ZNxrDYn758V/0qvpl0nojPnvvW7FNsWlWxOHaifPaz4kxOsZ2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/25/2023 10:56 AM, Tony Luck wrote:
> On Fri, Aug 11, 2023 at 10:33:43AM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 7/22/2023 12:07 PM, Tony Luck wrote:

...

>>> @@ -190,6 +245,8 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
>>>  			break;
>>>  	}
>>>  
>>> +	if (cache_num == 3)
>>> +		*cache_size /= snc_ways();
>>>  	return 0;
>>>  }
>>>  
>>
>> I am surprised that this small change is sufficient. The resctrl
>> selftests are definitely not NUMA aware and the CAT and CMT tests
>> are not taking that into account when picking CPUs to run on. From
>> what I understand LLC occupancy counters need to be added in this
>> scenario but I do not see that done either.
> 
> This is a first step (the tests are definitely going to fail if
> they have incorrect information about the cache size).
> 
> For a fully reliable set of tests some major surgery will be required
> to bind to CPUs and memory to control allocation and access.
> 

What is the plan for making the tests more reliable? What is the
use of this patch if it is just the first step?

Reinette


