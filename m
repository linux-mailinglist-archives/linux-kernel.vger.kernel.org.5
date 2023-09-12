Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4E79C131
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjILAnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjILAnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:43:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB7B2F8DB;
        Mon, 11 Sep 2023 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694478650; x=1726014650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P6aSw8Is7RAGGaHzgqtzz8Glx5EKeJbVQPOjs9s6ppE=;
  b=DO1//5mkqIfdn/Xal/kNSzjBvWjdpt3+ZLWVhne32+X5T3FeTgPCtA0y
   VQU88c7oTNOitc3GQBEocqbisTGUWeN4Hy9xLw8lpxGahhkcUZk8o5S7b
   Xi6i/z6mJ1EBxOB0lyEvAM2i+IE2vBcrzKi0mlaxQoeCDtwUukR/H9YN3
   fCdtlyoKoDRVrMjcFMK6I0iuAryHaP3bDjKsCcKVNK2gCm1eXt9u5hkUV
   oR5H4lQCqP20EuTQwxVcW+YAtmZYSb2bdklJH3M84Yw59VvwH2ze8TVau
   WPwVTun0r1dZu1vZnqqZ+7lcbkqzJ3h5Q0jWTFLDGZYTk/tmSRx8/zNFh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442255222"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="442255222"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772789070"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="772789070"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:28:29 -0700
Date:   Mon, 11 Sep 2023 17:30:47 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Radu Rendec <rrendec@redhat.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
        Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] cacheinfo: Allocate memory for memory if not done
 from the primary CPU
Message-ID: <20230912003047.GA16425@ranerica-svr.sc.intel.com>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
 <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
 <20230830114918.be4mvwfogdqmsxk6@bogus>
 <23a1677c3df233c220df68ea429a2d0fec52e1d4.camel@redhat.com>
 <20230830154707.dyeihenolc5nwmi2@bogus>
 <03e51c6072d80931a6b532ce1d4d7388a6f84d32.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03e51c6072d80931a6b532ce1d4d7388a6f84d32.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:45:22PM -0400, Radu Rendec wrote:
> On Wed, 2023-08-30 at 16:47 +0100, Sudeep Holla wrote:
> > On Wed, Aug 30, 2023 at 08:13:09AM -0400, Radu Rendec wrote:
> > > On Wed, 2023-08-30 at 12:49 +0100, Sudeep Holla wrote:
> > > > On Fri, Aug 04, 2023 at 06:24:19PM -0700, Ricardo Neri wrote:
> > > > > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> > > > > adds functionality that architectures can use to optionally allocate and
> > > > > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> > > > > arch specific early level initializer") lets secondary CPUs correct (and
> > > > > reallocate memory) cacheinfo data if needed.
> > > > > 
> > > > > If the early build functionality is not used and cacheinfo does not need
> > > > > correction, memory for cacheinfo is never allocated. x86 does not use the
> > > > > early build functionality. Consequently, during the cacheinfo CPU hotplug
> > > > > callback, last_level_cache_is_valid() attempts to dereference a NULL
> > > > > pointer:
> > > > > 
> > > > >      BUG: kernel NULL pointer dereference, address: 0000000000000100
> > > > >      #PF: supervisor read access in kernel mode
> > > > >      #PF: error_code(0x0000) - not present page
> > > > >      PGD 0 P4D 0
> > > > >      Oops: 0000 [#1] PREEPMT SMP NOPTI
> > > > >      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
> > > > >      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> > > > > 
> > > > > Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> > > > > not done earlier.
> > > > > 
> > > > > Cc: Andreas Herrmann <aherrmann@suse.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Chen Yu <yu.c.chen@intel.com>
> > > > > Cc: Len Brown <len.brown@intel.com>
> > > > > Cc: Radu Rendec <rrendec@redhat.com>
> > > > > Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> > > > > Cc: Pu Wen <puwen@hygon.cn>
> > > > > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > Cc: stable@vger.kernel.org
> > > > > Acked-by: Len Brown <len.brown@intel.com>
> > > > > Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")
> > > > 
> > > > Not sure if we strictly need this(details below), but I am fine either way.
> > > > 
> > > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > > ---
> > > > > The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> > > > > PREEMPT_RT kernels during memory allocation. This splat is not observed on
> > > > > x86 because the memory allocation for cacheinfo happens in
> > > > > detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> > > > > 
> > > > > The dereference of a NULL pointer is not observed today because
> > > > > cache_leaves(cpu) is zero until after init_cache_level() is called (also
> > > > > during the CPU hotplug callback). Patch2 will set it earlier and the NULL-
> > > > > pointer dereference will be observed.
> > > > 
> > > > Right, this is the information I have been asking in the previous versions.
> > > > This clarifies a lot. The trigger is in the patch 2/3 which is why it didn't
> > > > make complete sense to me without it when you posted this patch independently.
> > > > Thanks for posting it together and sorry for the delay(both reviewing this
> > > > and in understanding the issue).
> > > > 
> > > > Given the trigger for NULL pointer dereference is in 2/3, I am not sure
> > > > if it is really worth applying this to all the stable kernels with the
> > > > commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
> > > > That is the reason why I asked to drop fixes tag if you agree with me.
> > > > It is simple fix, so I am OK if you prefer to see that in the stable kernels
> > > > as well.
> > > 
> > > Thanks for reviewing, Sudeep. Since my previous commit 6539cffa9495
> > > ("cacheinfo: Add arch specific early level initializer") opens a door
> > > for the NULL pointer dereference, I would sleep better at night if the
> > > fix was included in the stable kernels :) But seriously, I am concerned
> > > that with the fix applied in mainline and not in stable, something else
> > > could be backported to the stable in the future, that could trigger the
> > > NULL pointer dereference there. Ricardo's patch 2/3 is one way to
> > > trigger it, but you never know what other patch lands in mainline in
> > > the future that assumes it's safe to set the cache leaves earlier.
> > > 
> > 
> > Fair enough. I agree with you, so please retain the fixes tag as is.
> > Please work with x86 maintainers to get it merged along with other patches.
> > Let me know if you have other plans.
> 
> Thanks, Sudeep. Technically, these are Ricardo's patches, so I will let
> him engage with the x86 maintainers and drive the integration work. But
> the plan looks good to me, and I will stand by and offer any support
> may be needed for the fix patch.

Thank you very much Sudeep and Radu for your feedback and review! The x86
maintainers are in the To: field of this patchset.

The patches apply cleanly on top of the latest tip/master, but not on the
latest rework of the topology evaluation from Thomas. Then I am not sure
when/if this patchset will be merged.

Thanks and BR,
Ricardo
