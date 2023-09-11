Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5697F79B688
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbjIKWWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbjIKR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:58:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57ADE0;
        Mon, 11 Sep 2023 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455106; x=1725991106;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kC/vBkk3eTWW5McEjiiuPdirLljZAi6W1e8KlhZbA0o=;
  b=H20z29iRVe0IaC+6Hl8RPsRyTZout1gkEoDZOF/lPwxfrRYBxW/SHl1z
   Ng04qiIp9M3rTD+Fo8/LAAZtPVIioA5n5naaq5y0YmiGreIqOvTo2M+iO
   ukwl9WSbqq+qlV6TM4Qe9OM/I1tWUwriPSE0Upk4eWw9pqU7kdOCVgrHj
   SNEboUTW+Ltyv1Jr8zUQFGwmTBPzoP57w/6hfeMH+Mjc+SQgd+P2jxntu
   vr8y4eGO34kadqg64matzD0cL7hM/WPseS8Y0aDe/+YL6Pi/00b7FByW5
   mt3WPreABHtPgrV3R/ay2vDP9m72cNQ7KOLXZ/q2wUOVtomj2SkPE0wV7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378070731"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378070731"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 10:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990198940"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990198940"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 10:58:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 10:58:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 10:58:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 10:58:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 10:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/i/7UniAK36Y4yic1Y6J2L1N8KEpxJABAZ21op08hsbSBkqenc/UigSFJMXlA5vdimU7uEIedjlLLZclksk4JsEd2DwLHsFrz6a/WdR0qEVAujEvGQsGXR/kqyhUZbZ7lvP+Ryb/hEZnJ8bGVhVdeh2n+UuXgS8mOdwvYaOuvANv+PkVlfhTJ6EXCXtP4UzeeJ3Fn66ETij/OdJjYkYox1bFjeGtpct4IxmO6NrZ1jKixLP9tn+8md0MvUM0FoLYt9gGZo9TJJRGmKsN9RZlIRkn3mAYsd3eeFTEJ5nkX4aLHxyIhH0h2kb6ZwZftUpAHCj2akLF2bD4rNxmLtC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSrNFS0FqM9N8SfnAsCFZ6eyE685aq4iZWrqfA4LGdk=;
 b=HKu02+2Y2mXhpADb0DhkuEiE5S98G6jzU3Gh3/2GqxiV77bhg2SJCeMfNEjNhIQDFfH0yETqtUdOdupsqOEDHa//151Aq9muBhUiIjnEJvmsu7MKD9sNwPG+YDb4teB+FB24bLb1EA7s96Xp+X7t8eW0jQzEGA7rXiGFTmajUTxaKwaRHB89B17OSzYDItNxD5o5SPSwQcXS7iZg2d6Z0yLxcaje5Ysn6sH2Sck+aJV88YE+F7n0wtPUBgk1JS19ye86Y7WniTxEeEZUrYiMOAx9+KhzO7jMuF4F+2WXTKy10pV9yX9PzIQjq4lxLU42qfO3PXRRmTHm/Os+gn8L+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 17:58:16 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6768.036; Mon, 11 Sep 2023
 17:58:16 +0000
Message-ID: <84f04d1e-0715-d765-4bb7-e1a1d8616fce@intel.com>
Date:   Mon, 11 Sep 2023 10:58:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 6/9] x86/resctrl: Move default group file creation to
 mount
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-7-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230907235128.19120-7-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:180::40) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CO1PR11MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 61103eda-e925-4f71-b5e1-08dbb2f0ac64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJaACevxzBva9vfa2bY9r52PD2qM6+sR53FJRiZwitKpitQsGIC4bo2+Z5QXt7QfbGKxfUzc7LcFC34xt1F2xiJ9gBLv9Yr8kO+GeK609O65bz17DHzfRVAyQ62hQsTTtdi52ZzPfT3N+w5q4fXnG0NfPMFjA9HM3zZ0uUAfMmBAP2Pr5EipoM8DxesnLg4WP2FvAT2WxEg4sYGrkcXVAux4UigRCyEIOkv7QyQj22icMSnQbwaVqgx75MWMjkNnnOLBejbuoyzReOIZOG94gujuTjyAvJFhUBEx0eda/6SYuLQK0L3ToUnF6YVgzLPDbTlv7UpG1K8yOtU2t1IItdehLNFn1QqQdZbq+IcUEFjIJWxzTWXl3Jr2gkeEE3qqJJ59tXkZbWb4fdbGx+y+8Cvyf/FlFFiBQBfBo0RUtw+2fLKotutY/TGIUGimrXvyx4mpExJP9cKNy5H4E+Kmu8RMEmO+6o8ot+Nr9OKyzCEfpIZulYbCgptHXK6YjtTcIS0Vy/RvitMrDqoB9wE1huxDj9e/d7iX/oY3enm5e3Bfl+lxYlOXem3GQhsvoNtEQdep/SarYMN9g/MR59A9SRCjep6ArBCp8KY1Bw9X1UtdKOErArDS/XADZ5D9sS9zpRhKiXIvrRY/CLQ/mmaw9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199024)(1800799009)(186009)(5660300002)(4326008)(41300700001)(66946007)(316002)(66476007)(44832011)(31686004)(8676002)(8936002)(66556008)(31696002)(36756003)(478600001)(53546011)(7406005)(6486002)(7416002)(4744005)(2906002)(86362001)(2616005)(83380400001)(6506007)(26005)(38100700002)(6512007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUovVFhpS0Q4UFNCSEVTQ0FUTEdFc0RtYmpMQW9qL09KdUF3VDZkeDlwdzlZ?=
 =?utf-8?B?SzhHclpKS2JGWFdXTmxZU0I1MGg4ZGc5cy9PamlKK1d4dTNoZUh5Yk5uNld2?=
 =?utf-8?B?bzdueWNMZnQ3UEJMZ1lxNnhWeHExUkNCeENNbWVXNGRDYzZkdGxlaEtMY1VO?=
 =?utf-8?B?OG13enAvNkM3YUxiOWQyTEN2MEpIeTdjZkJwN0U3K1hXdmNCdkhpRktvMVZa?=
 =?utf-8?B?ZWdiZ0RlR1ZDSFIyY1RkY0pUQTYyMGlvY0tIbEJ3YjRKalhyUEZLdnE3S2hm?=
 =?utf-8?B?S1Z2bEZhcWhMclh2TVIydFlCSDZkam44K05pb2pVWFlmcEYyd1VPTGZqaHVo?=
 =?utf-8?B?TnNpdXJCVDJBVVZIekxrbzY1SzNBUEFQVEdoUjNaenVaMHd6ei9hemxZSU1V?=
 =?utf-8?B?V0ZzV1RxV3Y4QzNhZlgrb1BHdWFPdTJxRVNoQUxXdHVXemJSNUJTQVFuZ1Rt?=
 =?utf-8?B?ZXErblQxVWZNL3pmNm1LR255dzBlUk51UGlCZFNsZ2tyWTlrd3dwRXF5ODB0?=
 =?utf-8?B?clpPcFp4V255NXAwREZaYllUUmNNOEJGZGt0SHNzTTUwb2JCQko4TC8wUGVk?=
 =?utf-8?B?cjhyaGJFdXpvQmROY2k5bDBhNzZwQ3cwd1pFV3ppYVRYNzN6Q3dmT09OUlVG?=
 =?utf-8?B?Nnh4Q1NYaFQxOHN3TEVCU1VKQ0IyK2wwTjR2MHdCSXVFUFRzVjZQcDl1djdh?=
 =?utf-8?B?YjQ5QzN3c3ZzeEJwa1huN3JESkZQWFhQdmExMG9tYWpBaEVaZzhsM2VmUzB4?=
 =?utf-8?B?RCtkSW52Zm5YKzNpczdreDNGYVQ5dlVjUVIrU09UYUNpNjF6eDMzMzROalFV?=
 =?utf-8?B?SEhMbkVlNCtTNjN2MTAvQjlqTkxxSVdNcndvblBnZHBsaDlDbllyQjRxZ3FL?=
 =?utf-8?B?cndFblI5WUhZdmVtVnVJcGlQbHR1UEdoWExDYXVycEFZaDE3OVZXbTRWK05u?=
 =?utf-8?B?UlFxS3ZkbWlnVnFabHpieG5yWW1sejZnOFY1WnRqbHJyMWZQRDV6bWZoVm8y?=
 =?utf-8?B?eFRDRTJac3NJTGJqMzNIaHNnWUMxZFNBVFQwbmNZK25OTStZc2dPS0dSakpk?=
 =?utf-8?B?Y0JBUlBTUVAvL0FOOTNZTjdia290bGJOam1OZDdhZlFMQlNQcU5wQW1qVlF5?=
 =?utf-8?B?YXdsME9lUThOQmVwbDlubnFmbklMeXNPRGlUTEdYNEhuRURlZDc4aFZJeXIx?=
 =?utf-8?B?ZnMvWEtNNmdVNTZQZWlETVZZVElMbTk0ZHlFclVtVzlPZHJjRnNiTEhnR3FG?=
 =?utf-8?B?Snh2NWQrb0NPQ2Vmdzg2NzFRNnJoZityQ3Y1aGpJMWFMSTF4RTVhZkQwR1ZF?=
 =?utf-8?B?M3E2NmRhTlZvOFF2QU1kenRvTkxFeHJNMGk4ZXlMb0tnajMwaWpVVUlBRy9X?=
 =?utf-8?B?VEtod09NaCtsd3NGbEpVYzVNSUtGWXVRenBSQXdEVUszUWtFRVdld3pyd1Aw?=
 =?utf-8?B?VmwxcjdvaEpUM2xkdzdZenI3aGJJUjIrVnJkek5uU3BIK280Z0Z0VVFOWWZF?=
 =?utf-8?B?OXE0TFB2NURsSDR4Vmxuc2N3aE53UXN0bGF0dVVtWmhHZWpQNFc2R1BjVkhh?=
 =?utf-8?B?c1BucGhrK1Jiem1uaTdteDhIc0hmanVtaFdLLzd4U1RFd1NlY3RXRFJOVm9q?=
 =?utf-8?B?UXpZOURna2Q0aEhOQ2U3clVneWFDcC90OUFISlBxQUY5ak5mSnUzRFMwdXZF?=
 =?utf-8?B?UTlHNFR3elBlb0FvYXZDL3VDQktDampyV3Y2MDFsSkVNaXdobEROWjhWRVZ0?=
 =?utf-8?B?MS9CV053UnEzTW9EWmYvYUk5RGVzc0JKb2tuT1hmcmVTeS9VdTB5b3VnRFV6?=
 =?utf-8?B?WHhKMTdXdmkwdXJOZmVMTy9qUTFZZ2d1TERNQjE4UC9qRitXczFTWFBrcHE4?=
 =?utf-8?B?THpVQ3E1QUFGVngybTlLNmwrbE1NR3ZqN01FSGozVjIxT1VpNU9EQys1ZmNT?=
 =?utf-8?B?azVuT2ovdkFENkhsemlQYlZmN1BBQmZXODFnS2lJMzNSZ2RwNXZQOEo0VTdB?=
 =?utf-8?B?YWFSK3BrTkRrNGZPRHpFdDB3MWlBSHhjYzd4bklMUVFwdzhVMGJNYTdvc1pw?=
 =?utf-8?B?RERKK0V2Nm5Id0tBVHB2ZSswMDBkNUFacC9oN0NkM1h0UUpEcVJ0Z0NWVlVr?=
 =?utf-8?Q?35ik94mzT9Fltd+xu31W90AAK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61103eda-e925-4f71-b5e1-08dbb2f0ac64
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:58:15.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd1PCRqh8OP9AZjGji9Kxrf7H/09sfc6sRkBIvjLbT/Yp31h7qToF85egCngcb8km57289Vqrd2Bq7MyctpxMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 16:51, Babu Moger wrote:
> The default resource group and its files are created during kernel
> init time. Upcoming changes will make some resctrl files optional
> based on a mount parameter. If optional files are to be added to the
> default group based on the mount option, then each new file needs to
> be created separately and call kernfs_activate() again.
> 
> Create all files of the default resource group during resctrl
> mount, destroyed during unmount, to avoid scattering resctrl
> file addition across two separate code flows.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
