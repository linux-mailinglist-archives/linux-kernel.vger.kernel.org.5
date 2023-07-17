Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC0756562
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGQNrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGQNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:47:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2311CA3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689601632; x=1721137632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XdJkKasQ4gOJHa5pmfr/3PM44rIa05hNHI5QKmStGjk=;
  b=HKvK7MFLKo+jFAclAqDunf7NBtP8aQP1i5r0gbhWGgN2jRjawBAEzFuT
   bqd/PV4THGo7/eB+DhiMW1f4tPKLfezjuamdinNIMIdttY8EKQ/pCn6GA
   /kQaQQlARx+aeav3h5a0sjoMsTf67He9L39PLfq1Rrd3xLy1ZSZWe2QNC
   Kz9BjqV1kR9P1DSTzjXkY/pABa1Sucw6fK4kCaeJ1t7yVHTm1bwiOD2aL
   YgwvDbnSeAk2JbNkaa/8NTFR87IEofalrpzpZw4G4jBnkgRQnEn6gtnrl
   A4Q5lVvzWVXhINlOEGzUQ6j9dIpM5GArpt7KkLcNN+LLJfwI19THLBgPD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345524259"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345524259"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="1053911898"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053911898"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2023 06:46:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 06:46:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 06:46:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 06:46:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 06:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CweIsQ4Fh/Gwi2uqR2DzMc1rNHLfu97nTPoj9j9SXXzKHFLHKHK1fPTK/eTpcMZaZUpmxvTlFLlr58tZcBOOTsRDf6eSCNM8LEPDw4d+AVqg3m113PQssS5vJjDfbB6HDn7pE1opEPiI5qUKXYBSBwgcTCh6tGr51695G4o27LmMBAFUK6NT3AcobscRF0dW/nzXhbRq+dKHEefqrRav3PpHwVQjRMiPk08xEOTmJjcbLjsHrvsFFehiV/jabgXyAGb9fYMnDMaq2Mw72Wp5IrHBQZix3wmEXCf29CziTwe/HoXOgH4+Y1/zjYg4oGYhQO3oLzyWCO44ZkW/si1PDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MwZPhELmUSj8vusMceHfCb4YaTGrB4uAgdkbpSNqpY=;
 b=PvuqM5q9vQgTIVa6KDkEHVIaIt1KJCIJ2TDUdpbLfnsceOURaei1r8WIy6DrePKxItx9e+2UjTlifn2pC1/QSozmW42sxMMeqVKlR+3kZuPEsfqk6IMxIJl2/bQZHGBMWVM3nAVpDfJNIznewsMfna6Wz/wBEkHOvl9ZqLTc7VpB+UI22ei0moRy2xXiut9x1AJOGuDhl1LDhLK+w7XdWQhT29uGDjUHnt+OxO3HfQS9TCyH/EHvKekQZO9WsH2bCB/4oGUn1MNgpMlRpwdSsBzeh+fqzyxdPk8azz+sxMtpgm/kQdnw0p4Zvv96u+9L8kXv8NfMnCPreigaDxsXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 13:46:26 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:46:26 +0000
Date:   Mon, 17 Jul 2023 21:38:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <ZLVEVoZTbYi3LbjK@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx>
 <87h6qz7et0.ffs@tglx>
 <87edm36qqb.ffs@tglx>
 <ZJW0gi5oQQbxf8Df@feng-clx>
 <ZJhUiO+bdBoLU5WF@feng-clx>
 <87r0px40o5.ffs@tglx>
 <ZJ2Grrn7sq9Jdxf6@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJ2Grrn7sq9Jdxf6@feng-clx>
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: fb734537-e46b-4e5f-a62f-08db86cc373b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jnyET+5nZUYsAxLwEgEh3K97FN47Ej+QBCVl5Arzu6iXU8LZEBr9+SCMSKXTWzvgCU5fAh/1OZorPg/RM3I7ZxlFUlsoisPdAV6uD8lfm1Pxy1zh6sDTlzd6w5cVcXVMDgIftFucMBGRWHojm+k0iaHnlNFxGgfOe0NczNrG51YB31BGVxzCdZl17m3GgwDgoWm+kX3dP+CU10KyQNIkhzLTGZoM2CXYQ475otYLw2FycF2VxIm9Iw9sUvNB0c3tuXvwix9YNGeB8fYo1msSSoqwbPnJz4nLQxWuSCoC0UVRTK9rZa+69HSdBZPBffKPk6XoRTskc1vkpRvlrUrp+CB7rSdnUVyZJzEaEvLFXQSN8XaQRdQrCXzduZKgOEKYWpYUhIFF3xAqRNcIQ8DPPIVgvvhV5tnHvgyxodJkGRXORKtFrEi4UDWCRjbGEueUy+4tXFEgUHlQf0PJ2pnVF7NQtcksmzYLESdXWU/OtvaQU+AztcOziI7bO0yoEht9Dr2QSjyUBMHuqCqRQtGBFABLFTWbJouAFe4t4PbqIv9vy3u3th3Gh5N+IEiMySGvP0gRcPcvPHcrpbZxCG1U6K9Cnzx5HGQFtEgYkAltWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(54906003)(82960400001)(38100700002)(6666004)(6486002)(41300700001)(478600001)(8676002)(8936002)(5660300002)(66556008)(66476007)(6916009)(66946007)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(26005)(9686003)(86362001)(33716001)(44832011)(7416002)(2906002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVYkz9xjHscUNxaEa+lmAcGWVIuLE5cCF9IelAxOpU1itxIqZLFudbk2e3SF?=
 =?us-ascii?Q?XinPsT37S2YhEytDjXJcKRibGXndkCSnW7ZcxqpHmr3uIlKbG8AXIG3Avz96?=
 =?us-ascii?Q?2af6tfmjCkTZBJvUUTYSIvg98SWtaAujk+VEFa2RdjKIgZtIUqI+SX8/OGEc?=
 =?us-ascii?Q?Pgg2qcALGKbvs/TS/wavSimzxcEiLoLf4lOPFFeeD9XHSiTR1xUIugljV1PT?=
 =?us-ascii?Q?qU6xhOGGNdhZpGhaNFJg1xTDGqQfNXUToCv/KZsU92abs/Qq7oEwrhMvGED5?=
 =?us-ascii?Q?3zv/fM9WuJGXCRuq/XGXZwUTah+cr6ZiNkMYShfOYc8hSOenzM6qCSKBs2jL?=
 =?us-ascii?Q?lq5eqYOJiv5R3udoJQGrZOGv14bvbpQ87XcN5txv8e5h/7sUb0KttyFKw76l?=
 =?us-ascii?Q?p/ctPCMM72Q3jzjKnHVjNPk6X0mQtBMXmD8rFxMjeY1D2YSL9HIYmtqIcU+P?=
 =?us-ascii?Q?SqKkXTsSr9atRvyy0HMWuPKWqi4/Zhkaef33EBpi6ULu5lt+wjLgVXboJiNj?=
 =?us-ascii?Q?uYlWVMRiCG/jgE0s6w9ac8CCEJjfgnWkJX2B3M65muSiNIdES4SNmKyjNp62?=
 =?us-ascii?Q?4vWIF0IuXR63ROGEO27dNJSnXEN4bYrXLAu+2pEHPr56mIXZIWMgJa+TQWOY?=
 =?us-ascii?Q?A2nVVAVhMth5qd06moPAjfNL1VA/COlojcy/sp9XgIhnwVFmo2njLcCdNgsm?=
 =?us-ascii?Q?n//bchxGvU7sAyMAal5200dzrUU+xoFhZf8yEJgG6qNSlpB6ueC9QaBLCfk9?=
 =?us-ascii?Q?CliHVwnMiMVGVC2cK6KlC017Dt2XIQYGVPleGgNILxguEbBkLQl/jYSZv5SW?=
 =?us-ascii?Q?gHXfjB9HmWrFJmzXVUQtfipiD6ihwBATyCVSg+RII2SpzJBVsMp/KuWYAUeO?=
 =?us-ascii?Q?+AmK9AeC0gwt4PeQcdK9uo/BEZc7JHrQ3hNSd7b76K2Ek0fSl1R1IOiQqhwF?=
 =?us-ascii?Q?P3dUwZOaY2dZTQz8knJP/zKFKvcsFdTR/CNk5jc3Vrc1I/pojsNsMdYnnpLE?=
 =?us-ascii?Q?pAtO0/Y23Th9AHtCs/YTZQ1VooX8mG8m+PwROvypjMxm3+1PeAno2hjcBJAm?=
 =?us-ascii?Q?eh3EiG4WtqkN7UFZnyZMOnSS+RIEuCRL/3Jxhdkr2WS3uKXzpx/dj3rSPHtZ?=
 =?us-ascii?Q?8pA4hkRQMsWmVlUF6aH+M5gy8TsmUWFJsFAXlIIf+YfiJFwAK/IZlalI9Epi?=
 =?us-ascii?Q?OQ4WQVl+qz8WxQz+e1nlS4KPXMN00UehZYoey7ILwmopsSCuH11IVuSCVprl?=
 =?us-ascii?Q?nfXfYSC0uCMwcHmbGMlE2UAcM8nxtOp9dnVIjJh/H32k5UqxquaO7OPLb68K?=
 =?us-ascii?Q?nwic+TQS01T9LBbwMYz21SMN6cJmuc2EULLZgn7g5nAeaRwc150zC0htHHsO?=
 =?us-ascii?Q?WPd1J0h6M4TOUsMlGiTCYrZ381s+1KYhkqSso2LvjefKxwusoD6xRjaXZ9Oc?=
 =?us-ascii?Q?nAwLNHGpoKYLQYF9SRvM6WyypBKmL7thQvKqg1X16PjAwIRnkmyDcj2EMWHq?=
 =?us-ascii?Q?J8hBVf0PqLZ5zokwF3KF/YZdaRAbr1zttGylf0i8NLasfW3YfD6rCR2MMSB2?=
 =?us-ascii?Q?xSctclpjaY/1WabMbv2VdO3P2AYsFlGag/ZIMb0a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb734537-e46b-4e5f-a62f-08db86cc373b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:46:26.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PsDCMNQ/TGDqI3VQM6g2mZuOc9wS9AVVAh5T32mQ4akOwttHGt5AAwyq4HzcJGg051nsuAuTtzGL69k1I37Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:27:10PM +0800, Feng Tang wrote:
> On Tue, Jun 27, 2023 at 01:14:34PM +0200, Thomas Gleixner wrote:
> > On Sun, Jun 25 2023 at 22:51, Feng Tang wrote:
> > > From debug, the reason of the hung/stall is detect_extended_topology_early()
> > > is called by cpu hotplug after boot, where there is "maxcpus=XXX" setting,
> > > (#echo 1 > /sys/devices/system/cpu/cpuX/online).
> > >
> > > It could be fixed with below patch:
> > > ----------------------------------------------------------------
> > > diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> > > index 828c1f7edac1..1ff73c8c4972 100644
> > > --- a/arch/x86/kernel/cpu/topology.c
> > > +++ b/arch/x86/kernel/cpu/topology.c
> > > @@ -29,7 +29,7 @@ unsigned int __max_die_per_package __read_mostly = 1;
> > >  EXPORT_SYMBOL(__max_die_per_package);
> > >  
> > >  #ifdef CONFIG_SMP
> > > -unsigned int apic_to_pkg_shift __ro_after_init;
> > > +unsigned int apic_to_pkg_shift;
> > 
> > Bah, yes. I missed the early_init() call from init_intel(). I hate that
> > code with a passion.
>    
> I tested the patch on a 2S Icelake with Sub-NUMA-Cluster enabled, which
> shows 4 NUMA nodes, and this patch gave the right package number: 2
> 
> On a hybrid system Alderlake with 8 P-core and 8 E-core,
> '__max_logical_packages' is 1.
> 
> I also tried 'acpi=off' parameter. On a 2S Cascade Lake box, it only
> brought up one CPU due to no MP table, while on another single socket
> 18C/36T Cascade Lake box which has MP table, it brought up 18 CPUs.
> The '__max_logical_packages' is 1 for both of them.
> 
> The patch covers most of cases we have listed, so feel free to add:
> 
> Tested-by: Feng Tang <feng.tang@intel.com>

Hi Thomas,

I plan to put these together and resend. Can I use your Signed-off-by
for your code?  

Thanks,
Feng
