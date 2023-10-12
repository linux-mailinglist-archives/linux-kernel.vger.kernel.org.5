Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD27C64D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjJLFq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377335AbjJLFqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:46:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082410D;
        Wed, 11 Oct 2023 22:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697089585; x=1728625585;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gb7iLTK9u2HfvT9ntd2edYg8ZPQdGk7OMs3eF7PBVMM=;
  b=EbPoeQUU+7RdKRnGVG+aJqWwjTxyKHfe3vohByd5AcTQqX2zONqAAUkH
   xIRvSwC2FKvP/DHeYOMKmdaWTm+n/ZIPkLjS3OlPNFFgeYlYy/lqh9rE2
   8M7qhcO+RSdlcFjMG06luQSNX0OV5yyLdj28cmWQaxpktok61DKmq0r4d
   o5JmhFpg8ORaSR15e8kd24JA29jJmArp1UBJSawYXRXdd1L2L89jZwBYl
   /UYklUcZ/MkIBc/gKmrmdfCKWwGfEqmNYErJMzy0UcyhDnHnNf3m5KdCs
   wSe4c10POskQ1InbjPI8dUBsRDmL/OQDwRInrb86WYIIa0XWK0ye41V8f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388700827"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="388700827"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="877981779"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="877981779"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 22:46:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 22:46:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 22:46:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 22:46:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 22:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpElPUKwoDYehjQn0icKEnyMJ06wo9/X+aGADadI4+ek7uOkVVup9lVuDusViBI7M9NpsaAg1wufXEa2wZIg1GVkH4A6dCGmOqZnGe6uGI4w78iiu+fXGZ83LXqbATqL/qxQg1J9Y+WsU4iM0x+wm4kCFymV8si3PC9w/SJWwYey7XS6XlNujLQC+Jo9L04ADZBegdSxkfDvN9Yzu0dYUurSikR67bC4Po3S8UGIRN0okM6R0tNhSAeGCaX6LKq9fLsEvLmkS+klZCewmYaa5+OPOZF/9o37V7nPpJLkXeOizDR2vmkMe2AGftjKuXsA8H5rqviuIS46Ilaf0E4kFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5et6fqLDCVZTj4jTHhSDnEdjYPCo3/StVgWFzff1ugg=;
 b=d5ar1eTqyD96slFVKZr5d85zw1bZjg9vB7CcULjAroTbUqvCw0VQXHJs3aPqUU/hKQn0pTBUAHqhLCfbbTs2M1ngvMAfpTHKVQvPCvPF+Vm1TqzZi1CJGneZ4JYybSfKyXhaxt2UsiAVfDMkEl7VxveU7JK7nJSEXYbmbQrsXti0PtkLpSpYxKqnK2dH7ohZQkp4jxt1kWJXQ1cDTaL7B41aow4oghvUEgH8gFcI8F4QswbCM3jiN43SQDjsmvZWmA+O/r1ufZ525j3eP4REsBT1+agRPG/BEzHIU6BUY6zZrhq4UIqDS7PY1S9PKlsa87u4kR1JyxLR6Q3IssyH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 05:46:03 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 05:46:03 +0000
Date:   Thu, 12 Oct 2023 13:36:41 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZSeF6T0mkrH5pOgD@feng-clx>
References: <20231004183623.17067-3-tony.luck@intel.com>
 <202310111637.dee70328-oliver.sang@intel.com>
 <SJ1PR11MB6083D191286779302821A7EAFCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZSbCYt35j20ezT98@feng-clx>
 <SJ1PR11MB6083154D148B42B8B7BC48D9FCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083154D148B42B8B7BC48D9FCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS0PR11MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1c5fb5-aa90-4f0e-8221-08dbcae68540
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq61I7P4/uR0G+tr/5zE3zWIfJC2nl2ZIPHR6r6s+XEAmQM3vOZTNrAgUaudDKjoIiVYfgFL3aIb9eQgY2LodJrw1xnOkFPSWNjaTVd33Xx4iSFI/zu1Bq85js/ptjZCj+QlasgRjSn02BIW0FRnnLxl+j/4Pbd4QfQrP9ADpniaacYr0jmn6bIOj43BOuyvs7nJghSwl4JWESqeK107vapAqCR4zxMz+iDXyR1mCzXmyBZQ6Ge5wNp8XKi9dvPfquak9GEu7hM0z+wef1T0E/HwfDOBQJ3sE1MjXef34lcQW7rNRIcUoGjPXxqk60ZwS7M0/nU5EcjTcLvKUYOPjAp4HkGbFQcqnNY50FgSka3UbPBABHZI5R+xSi6c7XldQ4xdgPhBPMaxUvsNK0y/oclNCVpHZ1OXwmlBPJbh1EeFJ046oDda54D1pnO8MOEY8rVpjOwEgrMOsscHXl/G0RnbRt33zphev45nuPQqes7v0pLbnFGlhEDcCtSJM/+9JT6U5B2fOJ9WXC9STsnok4Mnq3oE1lzgnmH0L5YY+Nh42ni6P8Phtk980wJoUMc0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(15650500001)(6506007)(6666004)(33716001)(2906002)(6486002)(478600001)(6862004)(4326008)(8676002)(8936002)(44832011)(5660300002)(66556008)(66946007)(316002)(6636002)(54906003)(66476007)(41300700001)(83380400001)(26005)(82960400001)(9686003)(6512007)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7PIj0+yum5fxTfwqS/tN7M5L5FSKliTFV42dPeAEafwsRP7rcWzzxltBNTdp?=
 =?us-ascii?Q?j3+P0d+j0qsBnVmtHYC3tmLVV/lS+wKcIw8MURZweFU/COReMzbJIeAjlAPz?=
 =?us-ascii?Q?soBNvHwyoBshyFcl1LV+ptc5gaSmtXrvokOold1YVzVDre8uMP02y3GcAEiL?=
 =?us-ascii?Q?oMZ3/sBfI1X7MDUMlM7iBIxWepmgTMGEP48+lWSHSv5xOEEBEciDo3h4eXkp?=
 =?us-ascii?Q?O/uiAGB8+Vo+zxBg+i2FTGjkEvvLnBM2e57Go/YUeOJVPK/sxwvm8UkCoHmA?=
 =?us-ascii?Q?vSowfmCbpmmf0HaTLp6JFltvFgLC45kMwT/SdZBAkzqbnH/nar/jwOtEnmUD?=
 =?us-ascii?Q?+w4YvYNsPNdpGnf+WuLnQvF+bHpMErI0+KIr8qPnJyTgZ74dG63e2kEaOsuH?=
 =?us-ascii?Q?bs7nwycZiSRZJCKvk7VkMkOpcm77YtidlWDovVtA0qiW+KT5QYIv9+2VOECr?=
 =?us-ascii?Q?JXN1K+yufL1ZU3M2XC4W+PvdyrS/zgJUlVK/r4hCM/0wI4r37CrwcFcZCxrB?=
 =?us-ascii?Q?3uOUETXUjrrGPRj9heah0u2XbkXr6f+gN5vBKvHzBKak/mD2xjIrLYJOZfTq?=
 =?us-ascii?Q?NaCqSkrpIVy/wmvAyYi1wLZwKLTHjlJAbqvcHJvfddnbK9cqh+XyQQPNNDa1?=
 =?us-ascii?Q?sgXDXnLTPHyA5sXG0hFnq/922Pi2i2NQaXvc9Lven15HNcdgIM5alR6zRc5k?=
 =?us-ascii?Q?ncIDz0BxnfudlgVFLbUYUjPi45E9STR3lSbaK2cpHbuFHuKing7XFnmFeEaa?=
 =?us-ascii?Q?CfuCP361F5fP7OTBMzZBNTJ0Kxd1OrHOl1JxH6osSVjEQKOsPl0+nR8jBys4?=
 =?us-ascii?Q?FZgzKhRYHKEZ61YPOTVbg0nPnllL5sbtdbzhGbB+3tvhq9FeGn/MEbRFVnvb?=
 =?us-ascii?Q?qucIUtlkjlwbJoqAiVM9hsSO8nRujVjazVwO97zZm18zUq8rO2ZZKyAz+LvF?=
 =?us-ascii?Q?iCO5L07Q28CEZEv7/lTRe5wlamLEcA3+fO2rHitoRLVppOFzbWMoMviavEgg?=
 =?us-ascii?Q?M4BUUcXNX2IH4avugamX0aPHTlSmYikYCfWoZ4Y4yC64Zaq0mn8Ra+cP2F1n?=
 =?us-ascii?Q?PKECg+XENX7pA3sWRVEKZBwUku3G4/14BpKNJFKAEUX2H6+PebqXWT0VYYYA?=
 =?us-ascii?Q?auh64yEse310yp+sFEEw+9tEK6a0P9DEfvi30LLjhTDFzypGznUT0p5c2ZX9?=
 =?us-ascii?Q?UHXIN4acUW8AAvNTq3lofOd0etxcirOHLBjKe9d5G854U0AoPRhBwsMyQaO7?=
 =?us-ascii?Q?cR1Pup41aHiaQ3vx3ooXMxQuam1f1EPdDqtfgotfNUaiQ+P59f6vge16qdZd?=
 =?us-ascii?Q?VuYw688jmDiFC7ZvGECN4BQBlXTFQpEPrd6ZHrEUffyDC/uGlN0YjT6IyUm0?=
 =?us-ascii?Q?SS5SYNg+gF06Ny/0kepe9hggf6IjNZvyOBKuAGiEaKAFfSNAgyRgfRHcjlVO?=
 =?us-ascii?Q?yhF+z5nUY2ajASwyylpTxVnNKZUxBJ94JNGnAn8no0Ng+gXz1jxE1fwbWELP?=
 =?us-ascii?Q?6TGYn1Yu+GzNoT1oSbKEhIIAhaiFNdR/TvinlAF171V2A+5vzlWiynWq+1Is?=
 =?us-ascii?Q?CU59VJittLRfWCkcQWgZreC94rdl12OP4iYdv6pA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1c5fb5-aa90-4f0e-8221-08dbcae68540
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 05:46:03.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2S/THusb7bJrcYjUXytf7mKS+nXsU/G2Ax0cpGy+/mpsZy5nyX2qyErkVgO8gfWDgQPSW60gRVzJQgvspj7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:23:54AM +0800, Luck, Tony wrote:
> > IIRC, CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B was enabled in 0Day's
> > kernel config for quite a while, to force each funtion's start
> > address aligned on 64 bytes. Don't know if this has been changed
> > recently.
> >
> > Also I noticed the patch introduce a new per-cpu variable 'storm_desc",
> > if the function address is 64B aligned, then per-cpu data alignment
> > may be related.
> 
> If adding (removing, changing) per-cpu variables can cause 8% performance
> changes, then maybe there needs to be some way to insulate the builds
> from these side effects (as was done with the 64-byte function alignment).
> I've no ideas on how to achieve that :-(

Philip helped to clarify that 0Day kernel build does enable the 64 bytes
function address alignment.

> "storm_desc" is a largish per-cpu variable at 1568 bytes. But that doesn't
> quite get it into the top 20.
> 
> In the config used for my kernel build, it does appear just before a bunch
> of interrupt related per-cpu variables. Those might be sensitive to alignment?
> 
> 000000000001ff40 d smca_misc_banks_map
> 000000000001ff48 d bank_map
> 000000000001ff50 d threshold_banks
> 000000000001ff60 d storm_desc
> 0000000000020580 d tsc_adjust
> 00000000000205c0 d lapic_events
> 00000000000206c0 d vector_cleanup
> 0000000000020720 D __uv_cpu_info
> 0000000000020738 d ipi_mask

I did further check by putting 'storm_desc' into another section with
below patch, and the regression is restored, which indictes it is
related with these per-cpu data alignment change.

diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index ecdf13f1bb7d5..7f32126f216bc 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -41,7 +41,7 @@ struct mca_storm_desc {
 	bool			poll_mode;
 };
 
-static DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct mca_storm_desc, storm_desc);

Thanks,
Feng

> 
> -Tony
