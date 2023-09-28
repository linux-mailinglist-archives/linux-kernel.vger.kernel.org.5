Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14E17B243B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjI1RmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1RmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:42:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262519F;
        Thu, 28 Sep 2023 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695922938; x=1727458938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZmWiv8koCdgEaKyqb2PP0KPJ/k/z0XH5u1RDsqv8y/s=;
  b=SjeLVCzs7x05eaVWcAhpFCMOFbdfKJ7uqK2O+A1BadCGSPiZOi0I9wjo
   LX4jZEgYmAcZcvhQ/Bu1YpIQMPAgBBpvGXFvphNmGlY0n+U6QAgSos5o2
   MS+fhrENHbDjUR7glXSgW3i1KdMt2o4EA16WPHdE2cgcu87j1LPQ0Gndv
   iPPibgVygrBzybVPRmYh8NrVyS0wLNj07ALxRrH3yvDILTdR+S5s8A7e2
   hfIbBVFilopdcr8LW52q9ZrHIgpLX71hXlTPrxrtPAV0Om1zILmhnHJDQ
   88bCjOQIDVMn9KIQFXBh+xlmA5mjzb6saLpYY0QESXYWooXep5rwd5f9o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446279420"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="446279420"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="815306493"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="815306493"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:42:16 -0700
Date:   Thu, 28 Sep 2023 10:42:14 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v5 4/8] x86/resctrl: Add node-scope to the options for
 feature scope
Message-ID: <ZRW69o0tNo2s8m+H@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-5-tony.luck@intel.com>
 <5d93f726-bd43-20ad-5057-1de575809cde@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d93f726-bd43-20ad-5057-1de575809cde@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:25:54PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> > Currently supported resctrl features are all domain scoped the same as the
> > scope of the L2 or L3 caches.
> 
> fyi ... this patch series seems to use the terms "resctrl feature"
> and "resctrl resource" interchangeably and it is not always clear
> if the terms mean something different.

I think a "resctrl feature" is a h/w control or monitor feature. A
"resctrl resource" is "struct rdt_resource" (which may have more than
one "resctrl feature" attached to it. E.g. the RDT_RESOURCE_L3 resource
has L3 CAT, MBM, CQM attached).

> 
> > 
> > Add "node" as a new option for domain scope.
> 
> Could the commit message please get a snippet about what "node"
> represents and why this new scope is needed?

Yes. I've added a note.

> 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  include/linux/resctrl.h            | 1 +
> >  arch/x86/kernel/cpu/resctrl/core.c | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 08382548571e..f55cf7afd4eb 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -163,6 +163,7 @@ struct resctrl_schema;
> >  enum resctrl_scope {
> >  	RESCTRL_L3_CACHE,
> >  	RESCTRL_L2_CACHE,
> > +	RESCTRL_NODE,
> >  };
> >  
> >  /**
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 3e08aa04a7ff..9fcc264fac6c 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -514,6 +514,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> >  		return get_cpu_cacheinfo_id(cpu, 3);
> >  	case RESCTRL_L2_CACHE:
> >  		return get_cpu_cacheinfo_id(cpu, 2);
> > +	case RESCTRL_NODE:
> > +		return cpu_to_node(cpu);
> >  	default:
> >  		WARN_ON_ONCE(1);
> >  		break;
> 
> 
> Reinette
