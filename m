Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E684678B8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjH1T5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjH1T4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:56:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7418D;
        Mon, 28 Aug 2023 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693252597; x=1724788597;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8X99Aw4m2qvERfvLZ5nTsuE77fnpThZ2uU0pZ04bess=;
  b=AGDi9jWA1UBwdnQ01pqimPmWBN3yZ/jlV4M4/zCQcy2N6i8lnn0u8gNf
   7ZKNpYYiRxepcr1LofF0xwF6QRecEQ28mdIUO9Vxgu+qYnFtET8J7i4rn
   IqXHOAJGN+UijWF7nUrCo+QbV+BsNxCaRuUdBUB+RfWJteQEMeJif4kh5
   X2+iNB6T8sVVbZUIheVKrzvTY6sxIo/K3Tt0uDScogkxlasX9Pn0aZq5Y
   cguKSacKTw8KqjG7kR5VMcIVdeuxYR385xfrJMiRdJ7z/ADOHc3h9ukc9
   n9zLqVm6gxkrcnZcI6hE7ksbImwt+CES0/IhNrBIOMcdU+bASioi9XRFU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="365395301"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="365395301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 12:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="852995699"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="852995699"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2023 12:56:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 12:56:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 12:56:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 12:56:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 12:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Icu7s/XB97ZNfzApei9pc7EFqYEPx2UZUEeuy5bLj/hZpYPSDqUfyFMslZnfEUEdsaPZVpp7RZ/NZgmC73liyT2qZiWCHnW/t+lNx6v7EK+pkJv+S+fCHONMuT8f9fD09U5qYnfGhZ4lFWajVXNpjM1ApQZusWXx8n9OjZlVTisbJ/p3QE6rY6YXgPSp5SAT+OFFLP4UGRiUBcBAXxuGwX22JlceqQABjQ7pFi7IKUY0vgbvVtkA6U16TkNGyHiLNXAjrkvhNE9dZBbalpk8fhkDO3/ez/wA03HpIhrJbwfZ2MffvIKyBYilOX/mT4k1ZKEc/zTDjZe8VZFoasklUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyNJWGUJOIgfcqtcsgoTgw3Jwk9y5apVW4ByhubXo5g=;
 b=iZ1QkcbpKlHO4PTF+A8zbaIkshJPPAWHd5kU4cvbpn2iCtofivwhYNTfLy+ZcQMhBiqDbBtrWUgGr/XLQnyV2MOJCp0m02oFiVTBChJTMS8n7CCS1ygTGUxl2UqNCqB6RYxeJ1/fvTnV+LWdEadUfleD5us/eAFuJqUwbCMg7R5LTfu5oklTwr6pUEvwjY4GKMCUGpc+2/y+BrfE5gyARVgoAJOvHqwmhzUhjv1p6h1AnANMb6nhkL4L8jcI2WOiLUB5O6cJthUqHdGgvxTAbxJks+2zWUssdcWbrjyRDpToQE2lwUMEChvMcR0Pkm0wJTGSO3CnEYlc5ENGl0pjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 19:56:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 19:56:31 +0000
Message-ID: <5b5962d3-6a7b-cc60-4221-8267bfbc3bfd@intel.com>
Date:   Mon, 28 Aug 2023 12:56:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/7] x86/resctrl: Create separate domains for control
 and monitoring
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
 <20230722190740.326190-2-tony.luck@intel.com>
 <cc1a144f-6667-18fb-7fe7-cd15ebfedd08@intel.com>
 <ZOjfPx8iwTULTqdg@agluck-desk3>
 <da2c0e45-56d0-e04d-774d-4292d156e1d0@intel.com>
 <ZOzroJqc22HFZOXq@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZOzroJqc22HFZOXq@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 144cd01b-d349-4115-bd47-08dba800dfa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzivSsN8iX5Hli9T0N0cquq+RKIwKcK6qM0+sModbvOKROdudU9hQ5z/pRLKQ9Q6sOMKHW31I2xOFdqyTJa/S4lpeHYhDMCMk5d6ZjfH2WJFM96/PZn77mBJeCH8msAiDiP/F7x/z5ZdETSoDvfCnSWOPpOV3bKiEibyIw1wfQTNyJHUfHtk0uRbegL4Fs/CJBJK24n06f6HoCvzLKPvjUuVgaqkRdiL7NJozMJjdta8Qw9HW/8D2kC4MHyzpWQ0EL7oZkGid+oOBLTmvRUkieZ8diArcOuzagY4JlUfItcII0hcxnQMWCgXrJmNkAW4Gm1pZU6FIQRQsWmoERDTzaUrVxQ9M5WQ4Nf9341YQ8YurcqHjPEo5WhiFkesdoS7Hjhgy24YMUzG3fMXsMB1zT4OTq1u8/l2SLy56BMBbkyiWiBZLaPUrco1XLW90/pSzdbCDYWSSpGI7F9Z7VdKps1NxZhk3C4b565JTKjIOOBUffbC31LS18R4oSbYe35sPNFsLjpgIB9gBc2zFbMUlu1W8+bBkwQFs4K7k4y4AAg8DPrg1M+IYf570eqRB6pxIRvG3WUT+rIYF8T+A1aoPnz/0g+nHUp6uWyQUV479yjdy5X39dcnp3P8ITo+G1LLx8HYnOiHkivgSG7UNv4wUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(186009)(1800799009)(451199024)(6512007)(6666004)(6506007)(6486002)(53546011)(83380400001)(966005)(478600001)(26005)(2906002)(7416002)(54906003)(316002)(6636002)(37006003)(66476007)(66946007)(41300700001)(66556008)(44832011)(5660300002)(4326008)(8936002)(6862004)(8676002)(2616005)(36756003)(82960400001)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZ0aEs5eFVZYmhIcG1pMEsvbjMzSEg3aWI4OTl4ZXhvdUt0RGJFcnIvblBB?=
 =?utf-8?B?dUowb29HZVBjSjhZN0pvaFBjNWxZbFRzY00zWjJ6Kys2SE1rZWx1RFR1bWRl?=
 =?utf-8?B?WkZiVG9BYVNmQUVhR0MrejFKZ2dSdnpqTElhRjdRV3gvZ1dwbnJUMU9sSU5I?=
 =?utf-8?B?cnlhK2trQlExWkM0MVJMWThLNlpjOWtKd0Z2cU1Za3BCNVFoUlNWWDRteVlk?=
 =?utf-8?B?TnRueDdCREJOM0hQV01ReDRudkJFZjBmZVlJK2l4RTVZbWRkdUhRTmszK1Fm?=
 =?utf-8?B?OWJFOWNDWmZ2MEZ4VWJCOWd3VzJFelVQZ1lTSkpBSkhNU1BQcmd0WlB1Ym9w?=
 =?utf-8?B?cTVRdWVTRW9BNnpsVjBoWEl2VWNMRnVobmd3RU1zUDBVR1YySzRVU1dJeVFI?=
 =?utf-8?B?cFhKU3dWTjhNeWFHbjNQUVJ4RDhaQStSRE9rMmJSWHUvak4wRW43VWtZVnE1?=
 =?utf-8?B?VG9JbWNnMThkcE1NdTRJcGxXYVdqZ21QOEI0YmVzQ2owSFcxODlobHBYQk0w?=
 =?utf-8?B?MDQyamp4T0NvdmkxZ1dYWEJWNVdHUVMwVm5qbHBFOWE5VjgyQXJlRVpzY1U0?=
 =?utf-8?B?VUgxMWk4b21OMFVmdU94UlRrYTZNN3BlKy9CS28vODByNUpDNlU4UVAvOXpW?=
 =?utf-8?B?cmhGVkNhZGN4SHZnajNpZ0NyNXpvNGZVSWFsLytOMjYvRHVUWm9DZUhaRG5J?=
 =?utf-8?B?UDNGOFFjSWhYNXJMbjlXUXVRTXZCRURublVGQUtLRVJLd24yTE1XN29KSG5j?=
 =?utf-8?B?dUxRQWlZdFc3dTkrb1grTTMzU2ZHTlFod1FpNDk2eFZUWHFRRHJoMVdGSFRq?=
 =?utf-8?B?azU2S2FCN0N6OTRBVkh1Y2xwVVY0dXAveHBadHUyVGlmQ2l6M1FGazdYeTBV?=
 =?utf-8?B?RUw0NDhFUnUzRUhVNW16MFRsenVrdVQyQVRKeUtFSUdmNElnWHY4MjU1YTNR?=
 =?utf-8?B?SXE0a3c5cG85cVpkT2NZdGx1dkF3NmF2V3g3UC8vQlEvUFJyWCt2T3dKSjJ2?=
 =?utf-8?B?SFRsZ2I1WWR2OHpXeS9HTUs4bklPcE1La3lyc3pPMmpJVW1iblZRWVRieTZm?=
 =?utf-8?B?bTRZY1lyeGdJb1A4QjFPSldnS2RhK2c0UXVIY1JLVFZCYWlBVWZLNjdvY3p0?=
 =?utf-8?B?OUphTVVaL1VDM0JVWUl4WmdDYkxHeW1lR1pYU2dsMmRrUjVRdXJIOTAyR1l5?=
 =?utf-8?B?QnFFZWxxSjNPNmdLOGhFbDEwZndzTlhDRENNSWF1Z2h3bmFlYkNsVVFPbHp0?=
 =?utf-8?B?Mzh6N21GMFFmQmNWSmpYL1l2SG1NR3hPZ25MWS9QVW85c3ByNTc1WGFQN3Vl?=
 =?utf-8?B?L3FSZkJnaEQrUjhQTnQyUjJ5U2luOTQ4MzdTdEUrSFlqNkVHL1hzTnNpTVh6?=
 =?utf-8?B?SlhWWnJxd2YzTC95NlRkTzd1WEIzVVg4WXhIZ2xyTVlZOVVIenNhQjFZQ1JF?=
 =?utf-8?B?aTM2UUMzazNVM3l1L09MSDJ4SGk0YVBJVWZ1WmZXS2RKVzhPMENnK2pVWVpU?=
 =?utf-8?B?ZFlVRnRBSDhyZWt2WGgyVjE5QW1MamlrUnRrMHlLYXVpR1ZKc3JXL3dCUXdu?=
 =?utf-8?B?ZHFLWks0dDFvWjRBSEtsbm5BMGhIcGl1azNYWXU0amN0dkEwWDdEYUJRbk4z?=
 =?utf-8?B?WmM1Q0xjQ3ozOWdJWTlSRFJad3I2NDhpUVp2dlhQd2hJSzN2NHFkMlBYUEtw?=
 =?utf-8?B?VEdtVUNtMEhmNkRMYmV0N3lSM0N5aGYwOGJGRlNsVUw5VXl6N1IyZnQ1U3p4?=
 =?utf-8?B?d2FycEdOWHYxbEE1UzFxTm14SnBreDBoWEgrbTA5K2UzS1FQYUg1TmhsUGlo?=
 =?utf-8?B?VkR3TEdYckxDaGFrMDR1a3VjQTJiU0dSeUJIUVZuSjBHSmNhVkdsc25oRFQ3?=
 =?utf-8?B?SFBsVUxjbnRwRXlTbXpoWi9PM1IxYThINGJ6RCt3NGV5SXRoSS9aLzJic0p3?=
 =?utf-8?B?RDNIWTU4NStaY3M5MjhUcWoxeUZTMkxvZ1ByT2s2SDhoQmNBTHVrY2xYVXJJ?=
 =?utf-8?B?Ykp2Q0UrYmFFV2xFU2pGR1diWU0weDlHN21qVXVXcW9PTU42NmVVa0MyVGlX?=
 =?utf-8?B?L0lVYUlkWE1wenVxSFNHR1ZmT3Y0MUlHb2Jnd2hYSy94RytjbGgvQU82elVC?=
 =?utf-8?B?ME5tMHNqZFpqTWdPdStGU3pxcERQbW1VZ1BEUXVlUU9SUS9hTWtLZk5Yb2cz?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 144cd01b-d349-4115-bd47-08dba800dfa4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 19:56:31.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqpRIs/Lhejl1OqGKu4lseuXUMjWZ5cUYxFGxHzDgQZtR0m4IG+QQSsg8hkwVk+AaZGHmHhalkQ076GTj7Q1p+MxbMWMxHfC6e9E81v5F7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/28/2023 11:46 AM, Tony Luck wrote:
> On Mon, Aug 28, 2023 at 10:05:31AM -0700, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 8/25/2023 10:05 AM, Tony Luck wrote:
>>> On Fri, Aug 11, 2023 at 10:29:25AM -0700, Reinette Chatre wrote:
>>>> On 7/22/2023 12:07 PM, Tony Luck wrote:
>>
>>>>> Change all places where monitoring functions walk the list of
>>>>> domains to use the new "mondomains" list instead of the old
>>>>> "domains" list.
>>>>
>>>> I would not refer to it as "the old domains list" as it creates
>>>> impression that this is being replaced. The changelog makes
>>>> no mention that domains list will remain and be dedicated to
>>>> control domains. I think this is important to include in description
>>>> of this change.
>>>
>>> I've rewritten the entire commit message incorporating your suggestions.
>>> V6 will be posted soon (after I get some time on an SNC SPR to check
>>> that it all works!)
>>
>> I seem to have missed v5.
> 
> I simply can't count. You are correct that next version to be posted
> will be v5.
> 
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>>>>> ---
>>>>>  include/linux/resctrl.h                   |  10 +-
>>>>>  arch/x86/kernel/cpu/resctrl/internal.h    |   2 +-
>>>>>  arch/x86/kernel/cpu/resctrl/core.c        | 195 +++++++++++++++-------
>>>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
>>>>>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
>>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  30 ++--
>>>>>  6 files changed, 167 insertions(+), 74 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>> index 8334eeacfec5..1267d56f9e76 100644
>>>>> --- a/include/linux/resctrl.h
>>>>> +++ b/include/linux/resctrl.h
>>>>> @@ -151,9 +151,11 @@ struct resctrl_schema;
>>>>>   * @mon_capable:	Is monitor feature available on this machine
>>>>>   * @num_rmid:		Number of RMIDs available
>>>>>   * @cache_level:	Which cache level defines scope of this resource
>>>>> + * @mon_scope:		Scope of this resource if different from cache_level
>>>>
>>>> I think this addition should be deferred. As it is here it the "if different
>>>> from cache_level" also creates many questions (when will it be different?
>>>> how will it be determined that the scope is different in order to know that
>>>> mon_scope should be used?)
>>>
>>> I've gone in a different direction. V6 renames "cache_level" to
>>> "ctrl_scope". I think this makes intent clear from step #1.
>>>
>>
>> This change is not clear to me. Previously you changed this name
>> but kept using it in code specific to cache levels. It is not clear
>> to me how this time's rename would be different.
> 
> The current "cache_level" field in the structure is describing
> the scope of each instance using the cache level (2 or 3) as the
> method to describe which CPUs are considered part of a group. Currently
> the scope is the same for both control and monitor resources.

Right.

> 
> Would you like to see patches in this progrssion:
> 
> 1) Rename "cache_level" to "scope". With commit comment that future
> patches are going to base the scope on NUMA nodes in addtion to sharing
> caches at particular levels, and will split into separate control and
> monitor scope.
> 
> 2) Split the "scope" field from first patch into "ctrl_scope" and
> "mon_scope" (also with the addition of the new list for the mon_scope).
> 
> 3) Add "node" as a new option for scope in addtion to L3 and L2 cache.
> 

hmmm - my comment cannot be addressed through patch re-ordering.
If I understand correctly you plan to change the name of "cache_level"
to "ctrl_scope". My comment is that this obfuscates the code as long as
you use this variable to compare against data that can only represent cache
levels. This just repeats what I wrote in
https://lore.kernel.org/lkml/09847c37-66d7-c286-a313-308eaa338c64@intel.com/


>> ...
>>
>>>>> @@ -502,61 +593,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>>>>>   */
>>>>>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>>>>  {
>>>>> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>>>>> -	struct list_head *add_pos = NULL;
>>>>> -	struct rdt_hw_domain *hw_dom;
>>>>> -	struct rdt_domain *d;
>>>>> -	int err;
>>>>> -
>>>>> -	d = rdt_find_domain(r, id, &add_pos);
>>>>> -	if (IS_ERR(d)) {
>>>>> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
>>>>> -		return;
>>>>> -	}
>>>>> -
>>>>> -	if (d) {
>>>>> -		cpumask_set_cpu(cpu, &d->cpu_mask);
>>>>> -		if (r->cache.arch_has_per_cpu_cfg)
>>>>> -			rdt_domain_reconfigure_cdp(r);
>>>>> -		return;
>>>>> -	}
>>>>> -
>>>>> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
>>>>> -	if (!hw_dom)
>>>>> -		return;
>>>>> -
>>>>> -	d = &hw_dom->d_resctrl;
>>>>> -	d->id = id;
>>>>> -	cpumask_set_cpu(cpu, &d->cpu_mask);
>>>>> -
>>>>> -	rdt_domain_reconfigure_cdp(r);
>>>>> -
>>>>> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>>>>> -		domain_free(hw_dom);
>>>>> -		return;
>>>>> -	}
>>>>> -
>>>>> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>>>>> -		domain_free(hw_dom);
>>>>> -		return;
>>>>> -	}
>>>>> -
>>>>> -	list_add_tail(&d->list, add_pos);
>>>>> -
>>>>> -	err = resctrl_online_domain(r, d);
>>>>> -	if (err) {
>>>>> -		list_del(&d->list);
>>>>> -		domain_free(hw_dom);
>>>>> -	}
>>>>> +	if (r->alloc_capable)
>>>>> +		domain_add_cpu_ctrl(cpu, r);
>>>>> +	if (r->mon_capable)
>>>>> +		domain_add_cpu_mon(cpu, r);
>>>>>  }
>>>>
>>>> A resource could be both alloc and mon capable ... both
>>>> domain_add_cpu_ctrl() and domain_add_cpu_mon() can fail.
>>>> Should domain_add_cpu_mon() still be run for a CPU if
>>>> domain_add_cpu_ctrl() failed? 
>>>>
>>>> Looking ahead the CPU should probably also not be added
>>>> to the default groups mask if a failure occurred.
>>>
>>> Existing code doesn't do anything for the case where a CPU
>>> can't be added to a domain (probably the only real error case
>>> is failure to allocate memory for the domain structure).
>>
>> Is my statement about CPU being added to default group mask
>> incorrect? Seems like a potential issue related to domain's
>> CPU mask also.
>>
>> Please see my earlier question. Existing code does not proceed
>> with monitor initialization if control initialization fails and
>> undoes control initialization if monitor initialization fails. 
> 
> Existing code silently continues if a domain structure cannot
> be allocated to add a CPU to a domain:
> 
> 503 static void domain_add_cpu(int cpu, struct rdt_resource *r)
> 504 {
> 505         int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> 506         struct list_head *add_pos = NULL;
> 507         struct rdt_hw_domain *hw_dom;
> 508         struct rdt_domain *d;
> 509         int err;
> 
> ...
> 
> 523
> 524         hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> 525         if (!hw_dom)
> 526                 return;
> 527
> 


Right ... and if it returns silently as above it runs:

static int resctrl_online_cpu(unsigned int cpu)
{


	for_each_capable_rdt_resource(r)
		domain_add_cpu(cpu, r);
	>>>>> cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask); <<<<<<<<

}

Also, note within domain_add_cpu():

static void domain_add_cpu(int cpu, struct rdt_resource *r)
{


	...
	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
		domain_free(hw_dom);
		return;
	}

	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
		domain_free(hw_dom);
		return;
	}

	...
}

The above is the other item that I've been trying to discuss
with you. Note that existing resctrl will not initialize monitoring if
control could not be initialized.
Compare with this submission:

	if (r->alloc_capable)
		domain_add_cpu_ctrl(cpu, r);
	if (r->mon_capable)
		domain_add_cpu_mon(cpu, r);



>>
>>> May be something to tackle in a future series if anyone
>>> thinks this is a serious problem and has suggestions on
>>> what to do. It seems like a catastrophic problem to not
>>> have some CPUs in some/all domains of some resources.
>>> Maybe this should disable mounting resctrl filesystem
>>> completely?
>>
>> It is not clear to me how this is catastrophic but I
>> do not think resctrl should claim support for a resource
>> on a CPU if it was not able to complete initialization
> 
> That's the status quo. See above code snippet.

Could you please elaborate what you mean with status quo?

Reinette

