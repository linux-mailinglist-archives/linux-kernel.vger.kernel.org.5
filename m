Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF6678E211
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbjH3WHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244011AbjH3WHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:07:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56714EE;
        Wed, 30 Aug 2023 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693433204; x=1724969204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z87SrEOHw8yEmxIHeet3h483sSPJ/UDXLSOVLSQvspg=;
  b=MxsabqY0C49lr8oMn7zeG3RzF7MsPGyqaU59WB79ZnxBCVb+ettGn0RH
   P31FnTA75hsaxgjYuvjbqPmwBSZgXfl2qO8W8OGJJpUSXTIt7AZsfZgIT
   dw6WVymI4q2OAx+hu8W2FgmsW2ID1oc9N/NVVZJQBjgbZ3YzOeIORs6d2
   gF6qLFNryUdDzbrGRkVgRBcgrHvnbycjQeLPHq/XsR0Gdr5LjbxfzNa8n
   ViYxVDiKDifddGSljSfrRyWFKSmae0hSfob5kFBMQYwfCOoFeGfLJ1QYr
   w4iQ8U/MPq3XGR7HBJL7UlfBRnQjPNf2gfb/Z9oM80brNVi8dNH8tcOS0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373160110"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="373160110"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="985931410"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="985931410"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2023 15:05:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 15:05:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 15:05:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 15:05:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 15:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR4QLSNCaVaa1ulJGNBdQWx94jOE8xWyVwTQXNBlqv2T+BNHJlWvCuE95GzfffjGYW3k6JX7n/7K7zTVDfFVS9H+NgiFTVQmO2dz0ujAi1dPc/xwsJO3Om8rzAiY2DuRLDxvoB0GMluvnQ+UhGT4bbMN+Ctewb4DLIl+DkKrNbSdjFHAJialQqPQEpA9CC3usH0P1ZcBNmvd+Llb0/TX8uTpHsVZ2aRPXKDDLEijGHY2RiKeCKOoJcye46yvDN5TZcM+62VXlHEPd8+f7b77uxix4oKOhAHjjG6dh7qY7TvAAE4x0lvki98VRJJkQwB7tynjrA3x79OEsDFVrTOs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyCUhJhlQV3ktEWowRrDlt0kGOh8WplIl7340yYFfec=;
 b=Hp/Li83VNiPJ/BqnJ18Uy5TNUCyp1H5tmkLL0oBSfewmfkdE+IQ3O5HupP1/uBJbGQEUNriaGyzLqN99agHyALoF/GFuP7CSfr/sE5vp03IRa6XnIKuAojz4O0Mftk4FUS7iRGWqPLyG3oreptn5ZkZasnqJ4w9XjHhSDgpO9tqOxuZaqyEQiLu7qlMmnX6rkGqihfdxskQVmJDgXekKxGwPZI8E+BtfUBv8kEvgUoABB8ljytHZVhfwswkOLTdKJT50/gzhf1V1um0tTfNvxhuC9WUU7XIFTbCQxCe9bt1INpkwAk1TNgMmmW+2eHDU4fSgMvACiXCc3whDp/PQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 22:05:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 22:05:20 +0000
Message-ID: <8fae1e7c-30da-651c-5761-e2ab2b69eeaf@intel.com>
Date:   Wed, 30 Aug 2023 15:05:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-7-babu.moger@amd.com>
 <972db626-1d74-679d-72f2-3e122f95c314@intel.com>
 <5e1c084a-e224-a798-65c1-60f827634ee4@amd.com>
 <05b312d1-9873-f006-cf40-1db695b4603f@intel.com>
 <674d9d94-28a1-2468-b2d8-1bf784933d6e@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <674d9d94-28a1-2468-b2d8-1bf784933d6e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c2a02f-6f1b-4afb-652e-08dba9a53365
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eV0z3yfZgZx6BP7ptVnDJw3TDnuZPN/t8O1ArZoRhLQRx6EMvL2mqUukrNMu0cpKYY5UAzA/3Q7ubdMBXaJQ8vHwVj3IK78cLSFzy/C0HPuzEbgTEkGh5rL6gBcpHeaWlvuPszDUrtsa6z8q0udWvizRAfNzNIBt2lqx+cn/zCJ2PTyjEBiG3KGr6IyCvu6pwOlWQTQ/DXdpAsbH4jNuBQYyaiDqGu9teimcoCN/+pCiOiAGGizlS1s/FJMYOGVR8eFQFsMDh3mEkueoV9uyG+i9ceKl5smmn65v2z360FS3nf3Xvyk6ac8OHgQQNaPhVsbhIu0Yd+zkNTYACRxfZuBHpT0LQKmM9opfOClqYulG/rW706hfbCAGXuKLJ6SbyvgDgXjw/yrAtMo9EdvU0Hqcka/9B8pdf2Ltuu2akl999kyHpBaY6hOfLj7Xc0fWK4gf4qSJSZvU0Fo2F/MfWzgCMTF6n1bmxFpPkrRBBVTwTfnTlRqpAQh6gzUpIQNjds9FaOsupKaCDAvlvAxs8AMzBmdPUKtsu9tEfVc2Q9W+C8ZEETgIxQepIBk1xFI7c584i6HeVPOAvRRnQGintFrwgbmS4giL21J/HQ3EoGPeeEnfgAWJLk3pI5X0Ib2LLXjQoxMFc+G5ZtJL7LRCKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199024)(1800799009)(186009)(31686004)(7406005)(7416002)(2906002)(66556008)(4326008)(36756003)(66476007)(44832011)(316002)(5660300002)(8676002)(8936002)(66946007)(41300700001)(53546011)(38100700002)(31696002)(6666004)(6486002)(6512007)(2616005)(82960400001)(86362001)(26005)(6506007)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhmTTBMa2JPZmdESS9LcUp0eDhqb1lRU1lxSVJJbHNHZTVNRzIzczJHell5?=
 =?utf-8?B?RU1jZFVIaTRyZjhlNnFqaE5zTWtyMFRhb0s5ckRCY0VKYXFuOG5tRkxpTXJ0?=
 =?utf-8?B?ZjZrVktYTmNNQlFXTlNLMjk2MTIzZG1Ga2pDMUl1TVRlNTNiaitEMUx3eVVL?=
 =?utf-8?B?QnEvZnl1US9uL1ZBejJBVUlDaHEyeXIxVTd4dUd0SE9aQ25PMU9tSlVXSk5x?=
 =?utf-8?B?VWdOZ09ucGJUUkNtMmRoRmh3RFNhUXI4UU5qRytpeGdLeVBKaFp2Zi83NjIw?=
 =?utf-8?B?NENHa2xWNHIza28zejkxZFUwNEZnQmZLOStzL0ZHT2RJZk1OR3dRTkwvNml2?=
 =?utf-8?B?Y01BNDJSeThsaE1GTzJ3V21HSE93UDd6c3p6eVJGYjRlUlhwaFZ1RVZLR2hT?=
 =?utf-8?B?VXlPb0l1dFkveHVkQTF3NElmQ3daNEdESFBSUXRkQzliWEw0MkpZd0tBVWt5?=
 =?utf-8?B?UDVIL1c5OFIxMktxVlF5M1hDMG9kVE1wbW5rWjJ6M2kxZjVIeFdtTVFTaG04?=
 =?utf-8?B?VG5VRFRkZHdzeWx2V3lTOG9samtYdXlVL2lZbkh2MU5xSFRuNG5nWUoyS2RS?=
 =?utf-8?B?bkMwbnF3WitCQkVKelFieUZKaTN5VURHbWRSUUJXNXVCSzdYVmIzODBNa01u?=
 =?utf-8?B?NTZqb01taGxTTXEzNDk5WENCQkVVSmhiOGFoUlJYN3FrY1AyUi9QT3B0UUgz?=
 =?utf-8?B?TzFSK1FhaGdGMXNqeFBESDBSRWxwV1dVOEpTRWY5Q1FSYXMreWtxUmgvL05t?=
 =?utf-8?B?M0FieUFKb2l6bEVISENBcTNhMUM5bFd0K001ZSt2MjNZSGFUQXViQ2VaTC9m?=
 =?utf-8?B?ZEZjTm5EOWtvblBWWFFVemdOejBFcUtlY1RlbVBLMTFJa1diMHVvN2toNGNW?=
 =?utf-8?B?emM2MHpqMW5UWXYwRk0yY1hpWGJaWmZVMDg3MDJMQnI5NmJNbmplUS82cGVw?=
 =?utf-8?B?cXJwcGJ0cnIwWUZ4eVpweDdPOFVqdFJxWFZLYjRwazFBdWt2YlpNMUE0cCtO?=
 =?utf-8?B?eEhCcDQ0a2czNElQWlZ6TEQrak9XUWd2d3AxcUhOVGxEbmZKODBUZHVvRFNo?=
 =?utf-8?B?Qk50cEhWcW14OVJVQTJlY2ltVmE5aUtJYnJ5cGdtNGR1WHZoSjhuQ3dyeTlL?=
 =?utf-8?B?eW5HZ3dXcWZMNmM0dkI5dDVVKzZ4cTBWRGhJL05DZXA2d0l6UTlmckRTejN4?=
 =?utf-8?B?bmFjcUg3bklTZmwycStLa0dvOVRia0tzYzkrZFdSSE03RzluRmVOY0xsZzJ1?=
 =?utf-8?B?WFpHUkhqWWswNDkvdHpJd2JMKzIrU0FzbkFoYkZ2aEZKVGtGdERSUW1taitj?=
 =?utf-8?B?ZUF5NnVVYkMxa2FQbGtuM3grVGR0ckVIbzI3dGFwc2RLNGdDL1RFRDQ5aG5P?=
 =?utf-8?B?WGd5R0lqVFBQak1iZDM0NUNFOUNUQ2dXd2tUZWZ5c1puN0xEOU9JS2pQa3hR?=
 =?utf-8?B?VTBmZnppcUlTM3h3bS9XaENNb29xdVJVOTI0d1NBQTB6VTFaUkt2YWtZbWtP?=
 =?utf-8?B?aHY2VHA1OVN1MmswZnh4SW1qeVcwemkybHF1T081a2lFczd0am5OZ21aQURz?=
 =?utf-8?B?amRLd3prVS9qckhkYXlXKzFIVW4veGZsbzhnblhxTWFTc0pHSUU2bFkzZkZW?=
 =?utf-8?B?N21IV2lreTlMZlZmb2VtdXVyUmFmRXdlajF4aHZ6V3FyTjZZenJ4cmxER1Ir?=
 =?utf-8?B?b1I0akgyenVJUTl4a3E2OUZSeVJiZ3VqVnVNQ2ZPRndMU0lQNzNzYWdYcldY?=
 =?utf-8?B?VGhHQVFGMnJ0VHplb05LZjgxbE1vUVAzZUwwRGxSTUJ3Z0xGazRKRFF1MVZL?=
 =?utf-8?B?UTl6eDFHZEh4bS9tSFhPQ1hMWUJqakZQRGxXK1JRWEVKZlV2b0xBR2UrWFpn?=
 =?utf-8?B?Q2RYN0J1UVZQek0zUmp6VlNBR1BoMzdCNXp3RjBBQWZ5QWlhV2FPZjNJeVN2?=
 =?utf-8?B?U0ZqOVI2WGZRTmh1bVpnRytiQnhOVUErM2gxRStXQmtoTFI3MXBENXNJVFRY?=
 =?utf-8?B?YnkvR3JRZnBySDd0RE9SR0lsMkRNWlpIZkNLMHZPVnNxbGI0L2FsS1A4NGdh?=
 =?utf-8?B?WWZ4aVJMazhERFZnSjR4d0pDOXBiQXYvUWNaVGkxbkN6YmlaVWdqUlE1UGxY?=
 =?utf-8?B?TSs5TnFZRjVRZGpWTHlqTjhnWjVMcXNGQlU5M2JKUmhWNndsbURZMUU2L0Z5?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c2a02f-6f1b-4afb-652e-08dba9a53365
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 22:05:20.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28qp7z8qvygNIctpJuC+MhvUJ58KOMn5w1LQfteU0KKq7lAstAxg+P748tCEPD18fUqbh5BlovDfnCIgjCs8YdKCV/MXXgxZcA7fHQgJ6+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/30/2023 2:18 PM, Moger, Babu wrote:
> On 8/30/23 15:00, Reinette Chatre wrote:
>> On 8/30/2023 12:50 PM, Moger, Babu wrote:
>>> On 8/29/23 15:11, Reinette Chatre wrote:
>>>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>>> The default resource group and its files are created during kernel
>>>>> init time. Upcoming changes will make some resctrl files optional
>>>>> based on a mount parameter. If optional files are to be added to the
>>>>> default group based on the mount option, then each new file needs to
>>>>> be created separately and call kernfs_activate() again.
>>>>>
>>>>> Create all files of the default resource group during resctrl
>>>>> mount, destroyed during unmount, to avoid scattering resctrl
>>>>> file addition across two separate code flows.
>>>>>
>>>>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> ---
>>>>>  arch/x86/kernel/cpu/resctrl/internal.h |  2 +
>>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 +++++++++++++++-----------
>>>>>  2 files changed, 33 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> index b09e7abd1299..44ad98f8c7af 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> @@ -611,5 +611,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>>>>  void __init thread_throttle_mode_init(void);
>>>>>  void __init mbm_config_rftype_init(const char *config);
>>>>>  void rdt_staged_configs_clear(void);
>>>>> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>>>>> +void rdtgroup_destroy_root(void);
>>>>>  
>>>>
>>>> From what I can tell these functions are only used in rdtgroup.c.
>>>> Can this export be avoided by just moving these functions within
>>>> rdtgroup.c and making them static?
>>>
>>> Yes. It is used only in rdtgroup.c. We can make this static by adding the
>>> prototypes of these function in the beginning of rdtgroup.c file to avoid
>>> implicit declaration compiler errors.
>>
>> Why not just place the functions earlier in rdtgroup.c so that they are
>> located before all callers? 
> 
> Couple of problems with that.
> 1.  rdtgroup_setup_root needs the the definition of
> rdtgroup_kf_syscall_ops which is defined later in the file.
> 
> Static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>          .mkdir          = rdtgroup_mkdir,
>          .rmdir          = rdtgroup_rmdir,
>          .rename         = rdtgroup_rename,
>          .show_options   = rdtgroup_show_options,
> };
> 
> 2. rdtgroup_setup_root is called in rdt_get_tree which is defined earlier
> in the file.
> 
> So, this needs re-arrange of all these functions. That is reason I made
> these functions global. Thought it may be too much a change for this purpose.

I see, yes, to accomplish this would trigger a lot of churn and also seem
to cascade into other dependencies needing to be taken into account.
As you suggested the static declaration can be added to the top of rdtgroup.c
as proposal for the next stage.

Reinette
