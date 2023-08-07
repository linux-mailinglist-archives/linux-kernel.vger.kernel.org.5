Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357F57734B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjHGXMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjHGXMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:12:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD21FF7;
        Mon,  7 Aug 2023 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691449847; x=1722985847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vi6hfPbn60L9k1Tr00fN5O9EH/H7aS97NxOK0jd1tMk=;
  b=hvnLvuri1D3kH/OU+fj/sxfvXdOgq6F089cYuu9UfzoqY1ggxQJ5mrK+
   uLYsB+AvhHlXT0lX2Wkf6nSOXap02n7ib8ffc7DSA3pTWWoZ6Fo28Qdju
   QZkCAHwYx1YyvuBWWsQAv0/97VfLlbrNaMVK0X24eQkGcrQfw5euGUVoE
   kHdpanYOyw/j9GYVUO7FCEBtkjkjKeSzwXutDl9ugT9M0m5srBRxpgEEf
   A+DI2kkdQgOzYTcIH1sv4533nfz8PSTcWqup34HBw8MFf91wSJ1MCkGDg
   uU4lieVfZezFSDEYe6HFlHe0dR3aWNLXRqEVhXdbeLYJfTX20rwuYysLQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373424071"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="373424071"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 16:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760679372"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="760679372"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 16:09:43 -0700
Date:   Mon, 7 Aug 2023 16:12:16 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] cacheinfo: Allocate memory for memory if not done
 from the primary CPU
Message-ID: <20230807231216.GA18573@ranerica-svr.sc.intel.com>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
 <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
 <b1452f78dc433a9cab4c94c9751e0e4a149cff01.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1452f78dc433a9cab4c94c9751e0e4a149cff01.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 10:28:30AM -0400, Radu Rendec wrote:
> On Fri, 2023-08-04 at 18:24 -0700, Ricardo Neri wrote:
> > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> > adds functionality that architectures can use to optionally allocate and
> > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> > arch specific early level initializer") lets secondary CPUs correct (and
> > reallocate memory) cacheinfo data if needed.
> > 
> > If the early build functionality is not used and cacheinfo does not need
> > correction, memory for cacheinfo is never allocated. x86 does not use the
> > early build functionality. Consequently, during the cacheinfo CPU hotplug
> > callback, last_level_cache_is_valid() attempts to dereference a NULL
> > pointer:
> > 
> >      BUG: kernel NULL pointer dereference, address: 0000000000000100
> >      #PF: supervisor read access in kernel mode
> >      #PF: error_code(0x0000) - not present page
> >      PGD 0 P4D 0
> >      Oops: 0000 [#1] PREEPMT SMP NOPTI
> >      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
> >      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> > 
> > Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> > not done earlier.
> > 
> > Cc: Andreas Herrmann <aherrmann@suse.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Radu Rendec <rrendec@redhat.com>
> > Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> > Cc: Pu Wen <puwen@hygon.cn>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@vger.kernel.org
> > Acked-by: Len Brown <len.brown@intel.com>
> > Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> > PREEMPT_RT kernels during memory allocation. This splat is not observed on
> > x86 because the memory allocation for cacheinfo happens in
> > detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> > 
> > The dereference of a NULL pointer is not observed today because
> > cache_leaves(cpu) is zero until after init_cache_level() is called (also
> > during the CPU hotplug callback). Patch2 will set it earlier and the NULL-
> > pointer dereference will be observed.
> > ---
> > Changes since v2:
> >  * Introduced this patch.
> > 
> > Changes since v1:
> >  * N/A
> > ---
> >  drivers/base/cacheinfo.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> > index cbae8be1fe52..461a77ece4b0 100644
> > --- a/drivers/base/cacheinfo.c
> > +++ b/drivers/base/cacheinfo.c
> > @@ -554,7 +554,11 @@ static inline int init_level_allocate_ci(unsigned int cpu)
> >          */
> >         ci_cacheinfo(cpu)->early_ci_levels = false;
> >  
> > -       if (cache_leaves(cpu) <= early_leaves)
> > +       /*
> > +        * Some architectures (e.g., x86) do not use early initialization.
> > +        * Allocate memory now in such case.
> > +        */
> > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> >                 return 0;
> >  
> >         kfree(per_cpu_cacheinfo(cpu));
> 
> For this patch only:
> 
> Reviewed-by: Radu Rendec <rrendec@redhat.com>
> 
> Thanks for submitting!

Thank you!
