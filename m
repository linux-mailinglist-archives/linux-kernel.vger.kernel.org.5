Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29179D82E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbjILR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjILR6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:58:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F0C1;
        Tue, 12 Sep 2023 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694541500; x=1726077500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJB7PjshuKldnnr8mvJYYIlpXf5eMG8Fa61oGlijMfo=;
  b=AWW36XiCrfdZMktQhpYZ3zH2uoUI0+tvILSkqIro46JsZ+ogrtrsJ6J6
   7SHfcTYEzC31QngMrFLfpWNLLSg7KcaEVw6JZgbD2pKe46+eB9lVEIEBj
   J/Js39yGhnBr9Nypp2NXK98VCDOc0m2+x/dr+Nb3WY2dwXMnYawoMdPll
   nU2h/ybQDt7bxSnEuYaSEbaDVy7Eb5HaYzF6vM0dQlsPePGuJ50GqFeGk
   CsMeyVxTtIvM3MmXqAlPAmQ61Q10p87I4olWxkSmMxnZlno0+tKSPcyxw
   bdL9BOVq0ktk0ATNNYrwCXJA+lbL++dUOPoUX+xqJfvbvCYJ/yB5T8AHr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357883391"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="357883391"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858911991"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858911991"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 10:58:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 10:58:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 10:57:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 10:57:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 10:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il5GfL9f5yE1GVE78IqaqRNqyVSj8FO+EuVP2VmWBm0Ocb61fQaz41D4CUr/MG6eS+rhWujbpE9rS49+X5QbUmXopP5/Bg6wxlaG4WmerNK3Z1gGMMfyA3nfgRQ7hB5QOjW+t37EEfx0PXCLQTzOZVu4uXOqR9lHBGpA68lmdjRFbyZLEhh3VPejq76kQhFEK6AKxvMiv8WerrPCADZEbKkXcn3LDESYqTsPX3SmdfCj+Wtv5ZsVZPFJT4aBOnvlzvf2Qna4mqFhqwH+h/viZgmXtlUixzBVxdkT798s47Ehcz+bulpFqlFEobuLyT4cXPPVAiO2JcCGXPwX5TWolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB+atCSmvWaNTlv+KT/HjEj19r5CZb9lkdImQ1xVd1w=;
 b=fOvR4l4zx+fBFituPs64BZ6h+aqL4l7vtf2390NmQSveG89v60NXHjwu0lEgKhbUT/9rdp03f0LjC0s1BrLUvBxDLyKr9pMMr7BffFGL99B8vUKiKXB0OSVVnlUCqvLyc4hQ0UUszKVLy00wDnNzD5dNQGyIdMtgJqHdcCIwDWunxwMKpaGXLHlx7bXCcsnEXiMAIE4N0b+jOy2mP6CmWZ+YA4LF6gfOnneBke6k1/qRwk1hpMc8ilPdKgtzYWmDuy7Cptol9W+KNTlTJOl6rsjSgGvgxyTLBmFEtlw0b9jV5pEBg0JBLOr0y+bamn78NtSLvuT9ErbP+HZ9hwmfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4738.namprd11.prod.outlook.com (2603:10b6:5:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 17:57:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 17:57:55 +0000
Message-ID: <902ae38f-fbd5-2686-0467-ca440e9a7a50@intel.com>
Date:   Tue, 12 Sep 2023 10:57:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v9 9/9] x86/resctrl: Display RMID of resource group
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-10-babu.moger@amd.com>
 <fbf1f7e5-1a82-303c-3802-2f246505c8a4@intel.com>
 <1b6d1121-00a8-5f30-26fd-d5137fe9d9c1@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1b6d1121-00a8-5f30-26fd-d5137fe9d9c1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:303:6b::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4738:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bc519e-5380-4799-c7f3-08dbb3b9ca48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LE+cHHlZc6w35/QXtlBmDBxc7TUNsPFsyJTuJjHxnUroufxSF2XCJEYz69mCKvyVCuhlJ5zalHCz8tmnB27mILkN9AOPlnLsmnVXEKpSIFk2DdD8bb0c2GZTUpODMmbl892cBHwsuqbfQmWVe5jmULQ+zA1galVi6oQwR3BGGatZQISTshPfjFUO2vXPw8uC7NsA5yn0JFfzfGsQPjxtEn1NlDVsOllV04ngBzEDVcZkLxGuTDT/Ie/pBZsLxF7DMHBFSwAQHCG2vD4VNxFmyhSHcNZBPe85zfqTqox2LP9sm/jk+rSiHk2jAljpymMrqXuzKU8/hpAnLkZuKdsvyUDkLm4qIAfOK5MSjcJZuhGq/c57IGhp4ZH88oMs9pSE+X6wq3wsjRr2HjnZl3JAia/WW3EDgDKVt1BvJvGqdYmZy7dVPxnCvEfruFZ8SIfZMwoe1PyOMEhNHOMau8nwwwA2U+4ewgyFf9S2oM6YxIFkpX5Y46pmEFGEEgVVB/hSn8S3Oy+8TO74J/gxfhivgZIYZM0A8m7IUPDd2XvtI4ptl7PRQ9GSup47193obBE8YJ08Q6Jg1Jv/Te4g69SQMwsJsgs0WwtGaMx5Z9109LX7dRx2W6BURag9LzCo5Yv8IhxWhZL2+OmpJvqk8aLSXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199024)(186009)(1800799009)(31686004)(53546011)(6666004)(6486002)(6506007)(41300700001)(36756003)(31696002)(86362001)(82960400001)(38100700002)(2906002)(2616005)(6512007)(26005)(478600001)(5660300002)(8676002)(7416002)(316002)(4326008)(8936002)(66476007)(7406005)(66946007)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFLZjhiYkpOd0FSdENNY3Y4WHlHdjR5c29JdTJDcGkyYlFFMmdQazVPN0ts?=
 =?utf-8?B?bmRNMm5IYkl3L3ZaMHhrTE01VXZ2eS93MG9QZ0dhVCtWR09zQ1FIRENOQlU0?=
 =?utf-8?B?ZkNhWG5IMCsySURFM2NhWjBoTlArVGJtUyt2SU91NVpER3RDd0RVNURTTDVr?=
 =?utf-8?B?WER4aEJwMXNFdUk4YmdPVjdKWVpiN0w5TXhodk1MaWRUSlZzSEJLcUlFS0hI?=
 =?utf-8?B?WkFDeDB5SE1ZM1ZYV0M5RFlid0RBcXd3b2I5RXFnQjNNUmNBYkZ6TjcyRnlp?=
 =?utf-8?B?NCtqODFPbFdad1EwdDJPNFBqaTRZczFrMzh5OE5lU09pQ25mT2FMa0lHVENx?=
 =?utf-8?B?YjYzV05TTTN3Z0s5TnlUVE83SXZJMlVEamtXaHJmRnZxZXFvYzNETkMwQ3Zn?=
 =?utf-8?B?ajYyWFZYR0ZuSG5VYTZUemxoTjh2ZFBJZ0JGNTg2RGR0SGhyMERaYTE4aFJK?=
 =?utf-8?B?KzJjbXBFMzdTNHZtRmRZdzNoODQ2TGxDMCtNbGpkV1c2eWV1dEZBTWNoaHhR?=
 =?utf-8?B?UWxXT2hPcWhlYzNBZE43eTBBdUF1NS9YYk5wZ3MzYUxVUGdPN0VDam0rTVU2?=
 =?utf-8?B?Z2NkVXJrbzQxdFRzU1gzdFljKy9LZlI0WHNQVXVPYzhXVktMd21qNFdCMVAx?=
 =?utf-8?B?YVNueTUxbEg5U3ZWUU1Sd2E1QjU3UlN3dUNWV3NjdHhRdzd5RXplQ1BoQmJt?=
 =?utf-8?B?VHRoUS90YjR6MzhvY0Q2c3c2MllpYXJwTk5LNUIydlpCbGhjRTEzckNMcXRC?=
 =?utf-8?B?RHh0Z2RiaUhIdE5TcW1IeGNCbTF4TjJlQk1xRVMvTmZGSEpsUlY0bHB1SmNr?=
 =?utf-8?B?WmVFWWJXNEhqb3RCM3RZbzQ0d2RXamFUZGg5MGVyRUVtdUpnV2VWZVNiWC9H?=
 =?utf-8?B?ekplaG84NTE5cFp0OUY5VHVNY2ZJMGhFUmREbmwyRzdUVkxZbUdEUHNjaWl6?=
 =?utf-8?B?d0N2aGVjRHkxSnhKc1RTcUxDV053WWNxUEhKLzUzd2FFN1haZ1dwaU9TaVN0?=
 =?utf-8?B?YUJ2dUhucHZ1Tk8xZjVpa1V1MUEzZWl5dk9TRWhrWGxmalpDZDZYZVpZdVBy?=
 =?utf-8?B?RXpScXhicFVGUGRTUlVUakl0ODBBQUpBbktuTjV1bFd3NVByNURsSm1LcHpE?=
 =?utf-8?B?NHRMZkI0Y2JVVm4yc2dhWHgvQTNrd2txQ3ZCazZKZU5VOWZ3Vk5kc1krbUht?=
 =?utf-8?B?dGtENVp4YUNucUtOK0xMYWdPZmZyTGEyd0dSL1hmcUkwaWtLbjRtYSt4dGto?=
 =?utf-8?B?ZlNLRG9abm9ZOXN4Q3NkbGNrU1dCZmkrTjh2a2pjbDdKaVp3NzcwRTdWY1J4?=
 =?utf-8?B?WkdmTnhLbjJQWmxSakpFd0VxdTlxZFVJYmplYmN5d2ZoRU1aQ2hvUG9FVHRy?=
 =?utf-8?B?SlZJZjR4eVpqSHhTZ29KeXkrY1JFVHZCMTBVUDczbCtCa0xwQkRQaUs3UlZR?=
 =?utf-8?B?NWlMaGR4eldzRG04eU1rSlArM3NtMkY5Q2VENVJXT25oc0FZRE93dkdWL3lK?=
 =?utf-8?B?NVNNS2FBZ2tjTE1iTG40L25QYlhndDJhT1E4OFBoOEVRN2hWTFpJaW02a1pk?=
 =?utf-8?B?ZkxUN0tsUUw5QmFpZ1hjNTVTQkZUQnFQSVJqMm5ab1JYOTQxdW9GUmRWQjlm?=
 =?utf-8?B?a1lUZmFYZjRMRG5ET3RXUUcxM1hHL3JuTDRYd3RpUFNKQTZVaEV2TzBiOUdj?=
 =?utf-8?B?Um9EOTZUZWd4QXY4N3pNVXQzNU5BNmtLNC9EWlRjT0Nia1VBZVhJSEhqZE9R?=
 =?utf-8?B?WENtdmUvYkV4SktlMW51M1Y5ZnZIbXJ4MCtsWFlNNFBRWkVVMTIwSWhHTmdH?=
 =?utf-8?B?M0V1ek5tbkVUejd0djhTTnF1Sm9WT29rcVk0MEVyTUduL3g2ekpWbnMrUTNP?=
 =?utf-8?B?dmJTbFpjL3ZXaWdUSnpoYk11UU53Zmc2MkNKanc4djdlMmNjY3IwQnprSEJp?=
 =?utf-8?B?N3BiVEFybkNJWFpqbFM4anNqWmhmT2h2b2gvSThsY2tMZ2cwQ3JvOFhJY0Y2?=
 =?utf-8?B?ZlJlcjVJZHFjSVd4eDBpR3U0N0JxemNnalowQUtNcUEyeVFWUDlYWllKUGxX?=
 =?utf-8?B?Y0lLK3FSMTdyTmpjc2pTZ1FRUVAveXFsMU5JaDFNWHJWRTBiSlZHdWdFUkhL?=
 =?utf-8?B?TVFOVzhueVBtVXloYzFTdlZZZm43Z1ZxWW5mMlNUU1p0Wm1yNWxON3ptejBq?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bc519e-5380-4799-c7f3-08dbb3b9ca48
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:57:54.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nK+jXJFMJhpefsNZpjSf9Z+9iRdRh0f+XMYGt67FDYlLN47B2vz6HsqWlQWN9nY74WaAueWVq+BPZgaYVY9+HV8bFMt800ItS9jPB49akxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4738
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/12/2023 10:39 AM, Moger, Babu wrote:
> On 9/11/23 18:08, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/7/2023 4:51 PM, Babu Moger wrote:
>>> In x86, hardware uses RMID to identify a a monitoring group. When a
>>> user creates a monitor group these details are not visible. These details
>>> can help resctrl debugging.
>>>
>>> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
>>> Users can see these details when resctrl is mounted with "-o debug" option.
>>>
>>> Other architectures do not use "RMID". Use the name mon_hw_id to refer
>>> to "RMID" in an effort to keep the naming generic.
>>>
>>> Add the flag RFTYPE_MON_BASE, which contains the files required only
>>> for the MON group.
>>
>> As I mentioned in [1] I believe adding support for files with RFTYPE_MON flag
>> to resctrl needs to be in a separate patch. With the core support added a file
>> with this flag can be introduced separately. 
> 
> Yes. We discussed it. Thought it may not fit as a separate patch on its
> own. So, i combined it.
> 
> Now, I split patch 9 into two. Let me know if it looks ok.
> 
> ==========================================================================
> 
> Author: Babu Moger <babu.moger@amd.com>
> Date:   Thu Sep 7 18:51:28 2023 -0500
> 
>     x86/resctrl: Add RFTYPE_MON_BASE for MON groups
> 
>     Add the flag RFTYPE_MON_BASE, which contains the files required only
>     for the MON group. Files with these flags are only visible when
>     monitoring is enabled.
> 
>     Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index ccdbed615d41..72988e5c52a7 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -296,6 +296,8 @@ struct rdtgroup {
>   *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>   *         Files: cpus, cpus_list, tasks
>   *
> + *             --> RFTYPE_MON (Files only for MON group)
> + *
>   *             --> RFTYPE_CTRL (Files only for CTRL group)
>   *                 Files: mode, schemata, size
>   *

I think it would be ok to add above hunk as part of the patch
that adds mon_hw_id, similar to what you did in patch 8.

> @@ -315,6 +317,7 @@ struct rdtgroup {
>  #define RFTYPE_MON_INFO                        (RFTYPE_INFO | RFTYPE_MON)
>  #define RFTYPE_TOP_INFO                        (RFTYPE_INFO | RFTYPE_TOP)
>  #define RFTYPE_CTRL_BASE               (RFTYPE_BASE | RFTYPE_CTRL)
> +#define RFTYPE_MON_BASE                        (RFTYPE_BASE | RFTYPE_MON)
> 

This hunk may be appropriate for patch 3.

>  /* List of all resource groups */
>  extern struct list_head rdt_all_groups;
> 

This is not how I expected it to look. There is currently an issue
in resctrl where files with RFTYPE_MON are not created for CTRL_MON
groups. This has not actually been a problem because there are
no files with the RFTYPE_MON flag. This series introduces the first
file with RFTYPE_MON flag and thus this resctrl issue needs to be fixed
before this new file can be supported.

Considering this I expected to see the changes in rdt_get_tree()
and mkdir_rdt_prepare() done as a separate patch. This will add
support for RFTYPE_MON files to resctrl. After this change
a separate patch can add the file that has this flag.

Reinette
