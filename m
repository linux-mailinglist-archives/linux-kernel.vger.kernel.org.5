Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A47277ED99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbjHPXDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347087AbjHPXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:02:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD426B7;
        Wed, 16 Aug 2023 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692226948; x=1723762948;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WltHIO6NafcEaFaQlphQCbFleZHDTiQT03vDDkRM0bo=;
  b=WhY6FnWW5PoEl9Fieb4WeBt9OTa8V9Aqj+WvN/eWsa7J5jYbGxZVopqD
   FWrDzmTspz2gPaU6JOKoLPC6liKVzaM6ql2IHwsgxCNbDZ+lrOnr+lyDS
   gXeFX5sM9yA2AMj9jNbwHF+kujisJrvTz79lhhLJLXpMc8T8TBTkAvSqN
   KY5RruWM8zTEomPWtUMeAkx/Tc3Gmpzo92xW572Y9zwhnLJj2MyTqF2GA
   Z1TdAagTsRYds/AZKrudZpEmQaL5UFl9E3qwfQiFucvBPrfXqtoCpTekS
   Aaj+0LW+qHQcyNkM9zrkXLdttCZlUKhnGehAdakg6DOiH6pypE7yr/JGB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="459018494"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="459018494"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 16:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1065017074"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="1065017074"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2023 16:02:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 16:02:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 16:02:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 16:02:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 16:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aotUIjdZTIILq1TAEZj7OGxiSlzknlAClvzB/tR5ofECA9O/MsYJJhRXS9uIfm///59z42bTqCWxcWmFqkyWPa2is0GmNRuESboDS6pVGPCll1EByRdOwAO+dnhcm9XYVdhzpRnFSMXIwDlze1BBMAKsVoPJ1fpq0WPONKOCcwcVIbZrndBI0bq6pa25UMkdyRmaD/VmJFG3YMo2cbQUspfFNuikfb8fvD8xUn0Hx8iC9RW4PynWS0uzJ+FBDh1+k/9jZYGpzS3y52wWVfqyWtMpOKlyMDmVzt/oD17qCsFltfYMswnOnOxDjSVfrWGqLcsniib1CREr0Y3bvwDKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt707UkNmC1JoJhtjd9Vhj3oAGOE2CtlTXmOLGmFE4w=;
 b=V7dV7LYNivoi5iqdruGx2ziuckxC9tpPCymD7Hswmy3AD/WoAYrgIOHNPstW8oz2c9/LBn6eBZWIiAbqvRPz8yiGzJYvl8/+fl/k7dzb//721OdaihqLJXPBets5Ng6bBfKzgZ7Ys0A+lTe5idrDahzsmwKv/g7uRy+GhyzgKiDJBXfRCvkYaMjrKxR/1/uvkOG1Hvk8WNzeipWsx8lMNQ8RNJw1VXw4Mu1K64S/ntBGSDS2E34+nzCyPMtZM1zazFl1nG6M8CRB9xaCM73NGbxAGp6E9G8CZeGHL5AVLafLnDld4R4ypHibJbQsDBaJriJtKdiEfI0gwLd6vjlZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6233.namprd11.prod.outlook.com (2603:10b6:930:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 23:02:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 23:02:20 +0000
Message-ID: <f7d99da2-7ba6-fafb-e90e-4164fda43f07@intel.com>
Date:   Wed, 16 Aug 2023 16:02:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 6/8] x86/resctrl: Move default control group creation
 during mount
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
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178463637.1147205.7411319721706077266.stgit@bmoger-ubuntu>
 <b84a9ec3-5b65-9334-becc-0d90bfbbccfa@intel.com>
 <b9eed930-1a8d-7cf7-0515-1f9d33089953@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b9eed930-1a8d-7cf7-0515-1f9d33089953@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f152d84-db00-47a9-549e-08db9eacd870
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFsKx112p0wzS4gLbznvjjkopU+XGXcF37g8wup/O5iRssUmrrm1Mo43IAk7s42ud+6wOMMCBKxubTUjO2aAnzYpWETflgbY2y1HykNX6TV1wHoYkPuveJtaiu7NMEnO1ZM0s7YAczbqkUGgH3nPepo37SEYiUM5uSgmgC86fYyPBRQ621tqBPK02MwOGY1ov5DhzwpGtuAQ6HE/6oWGbOddEWs2vZaPpMolD9HGR0RRUDFkjQcTOLsebu7nqreHP1RPJCIGG58OtxrOpKmpEv6gNe4d+M4pcgF8FEntSu7LbN6sdU/ZpuzPVBmU+X16RbAhR6du0DOlTXC6z1w/VDww8V3T/jG3ODl6B7lGBBCVLjVSvhdkFKnzW9tLCkSc9hhwTzcdSMar7FnqEPPhnm5dOGlmskN2ZsNw2ta+mdJvvkFacNd8W0HR6U+T1nuT46EcK2u/kWpK0aHi99FSXhxSEGXvQz8WWBuhut+7wbB2e1wNeAYECuxaeHzhCAbgUZaX8/ONed58H02c+Vzz9MhrcxZ0sM6RIRFULQrpshIqm9c2H0ZgEZ1jQiTVm86yhGTWWSKwvIlFq0HyzGL8Ba5J+fiJhiXPMl76avn6Ot2qG7yHLFzNmBI9erjI5VIP0bUWlv6VYUKFopag1d3tDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(316002)(66556008)(66946007)(66476007)(31686004)(5660300002)(41300700001)(44832011)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(4744005)(26005)(478600001)(7416002)(7406005)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUZWaEpCc2ZQM3ZlL21obTZ3SU05QmZvaHBDZWtIS2NPTU9oZmpVb29uUzlq?=
 =?utf-8?B?bzJIcURYUzV2Wkx3TEJkQnN2eGU2NmVTcXFRUHBTVXpLOURieDA0N05DdU93?=
 =?utf-8?B?aEtRSGJiYzl2amhBdldJQlBPSCtGMHhWM3VYMHlsUUErSEJqVmJ1NjlCYU9a?=
 =?utf-8?B?YUppMm82cjdJeW9pZDl1NjlZY25BZXNKZ1ZtVVg3MXJaK2N6TkU3djQwbnBm?=
 =?utf-8?B?dGp0NTFJSG1zWTZpMkoxNDQwOEt1VTUwQlNycFZadjhSTDQrQjdrVjRZUXJw?=
 =?utf-8?B?dW9mZ1ovS2JSTGdRbjJ5cGJocmpVaUhNeTdEdEdTTFQyN1NsTUliNGhvREFF?=
 =?utf-8?B?WXBmTnhhcW5kN05Ua1JnbS9RZVhWcTBOaDhaWjI2WEdFdTZnSTZOWEdTdWRz?=
 =?utf-8?B?WUlxZGN6VGlFU21WQUdUSlBlaUU1aG9JcTh3b2FFN0dscDFSUkFOVjFMVzBE?=
 =?utf-8?B?SjZUdGdYN0c3T004T3I0cW9tTTdUZDloL3FlcHBPZGM3OE9sS1A5eGZ5dWdy?=
 =?utf-8?B?UFZFVmF2UmJZZC9CRGxXOSt3WHp4K1cyU2pydlJHSnJLemRIWjQzcFphaFNU?=
 =?utf-8?B?YUxPTWoydFZYcVVXd20zRjN5aTVDcGw4c0FIb3pzRTY3SERDNHV4MUcyb0w0?=
 =?utf-8?B?Wk16Zm9LLzdJdVN5aElxTlo0bnplTkFQNzZKUHdNa0lBU3JucHdRRHZRS1ZV?=
 =?utf-8?B?T2NWYnBFQjd6YzNkMUFWVE8wZ1BXSmVWU3dsekIrYm1lMHQ3dUtISVdzWW1Z?=
 =?utf-8?B?cGFvMmc5V3pxL055cEQzVjdhUHlLOXpNcUlmQkF6WE1Ea0RvM2hKMllXQjdY?=
 =?utf-8?B?VFN0Wmk4cDBoa2FhVldWK3NNbmlwKzdjcEtvYnpSOUU1UzEyMW96YnpPSVQ1?=
 =?utf-8?B?Nk5zSFFlVDlqTXZhRnhIczdMeWJ2OHQrTTBOZW1wamppdVJqUnliWm1CNDJO?=
 =?utf-8?B?WHROYytyZitSb1J0eU1Db2NyUW5Jdnh1MzdVcjRybGFCcExOM1FsT2pRSlF1?=
 =?utf-8?B?TTdZdGtRTUxkbWZhRnNlbWlaYSt5Z29BekxJNkIvbkN6MjB0ajZzWjZHQVdm?=
 =?utf-8?B?eFFMZkQrOEQ1SUx0bWtaTUJjZzFDZ2lTNndwUkpocE4yMlVlZGQrQmFkTFBx?=
 =?utf-8?B?Wjl1ZVRqM3FYRmxtdG1tRlpzbU81R0ZhMklPZFpiZEhqSkdvblUzd0VuU2oy?=
 =?utf-8?B?OUlta2I3Z28reUQ4UFZObmkzbENQejQyM1BxOEt2eFI4VTQyWDJWenRpN1li?=
 =?utf-8?B?VDM3cUl1NURnQ0V3clVucnAzYXlvL1Nsc2ZYU1MxYW5OUkZSYUZIYkM3Rksw?=
 =?utf-8?B?UFg3U3lxZlRXV1JtQ2loOXJjZDlXWmxHQXRRa0VYZGlqeU45RGhVMGUzR1Js?=
 =?utf-8?B?L05iNWJPaitHWUt6M09NeWZrT3k1UnBPNTVNQ2FnQkNFZ2ppdFpSSXZJQ0N5?=
 =?utf-8?B?Qys3ZTRzUzBnNzJqai9sVE5UeW1yNVNwbVpwdHdPM2szQ1JRRjVvYllrS2t2?=
 =?utf-8?B?Q0oyWEJFWk1JVjRLS0kvZzZTMU9hVEhNQWhwMWNaMkVmemJGeG9wNmdtM2Zh?=
 =?utf-8?B?OHc0ZW5QWm9zdGlELzdGWVVzU0VPSTFNOXBTcEwzSWNFczAyRm9Kckt5aDZQ?=
 =?utf-8?B?NjN5VEpoSEY2MHd1ZzB3cE80SExJTGpqL0gwWFJ2V1ZNVmY3cHNTMXpCRWp5?=
 =?utf-8?B?SXdmMmo3YXBRbHhTZWF5c2xWUDQvZ0c2b2hLT04rR0FHVmx0Q0VPazR4ZzBB?=
 =?utf-8?B?QWM4WEhablJWYWFqOXRxZGpyRUptRDFRbERwQncyUHMwSFpDaWhMK1BQTGRX?=
 =?utf-8?B?M09lU2RBRThrbnZ3cFJkb2NLSTI1dkgydnlXck5oQWN5a2VjVjJDczc0S3kx?=
 =?utf-8?B?bXFTZm9sMjR4RjllcTk2NkdIRmdGU2ZPYnpZLzdsejZJUklvdWR0Z2RzejNJ?=
 =?utf-8?B?b0xhb0czN2FmREJNNmxXcnJuOHlkdWdUYURtZ2RQK3p4Rkl1V1lycFVFS1RF?=
 =?utf-8?B?eHhWMXJqZnBhQS9VUlVnVFJidWhoSUZNWnVtbzBQNjBDSno5RnVCcDlqRWY0?=
 =?utf-8?B?cFg5RUR4ekY0SFlWSHlNQk9nQXNjNlc0V0lqSmpVS0prVDJMUk0wdG9PNS9J?=
 =?utf-8?B?WGJPN2hkc3BWSWQxK1VtZHZjaVZCb21lT2QwL3p3Q3ZtampYL281TlZaclBk?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f152d84-db00-47a9-549e-08db9eacd870
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:02:20.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO+XIR+1KIoAR+uy+I1GnaPVYfmdJXC2XAAQgzNIsZMXsxvKEE/2bxcJBilw5eirLBaNUCCny5LN8lhtpRUz1ulNy9xA0u7J2cci1KHSQwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Babu,

On 8/16/2023 12:14 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/15/23 17:50, Reinette Chatre wrote:
>> Hi Babu,
>>
>> Please do note that the subject is no longer accurate.
> 
> Changing to
> 
> x86/resctrl: Move default group file creation during mount
> 

How about:
	x86/resctrl: Move default group file creation to mount

Reinette
