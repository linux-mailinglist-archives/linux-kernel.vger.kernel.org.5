Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0443478E054
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbjH3TNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbjH3Lu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:50:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9AB41B0;
        Wed, 30 Aug 2023 04:50:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118872F4;
        Wed, 30 Aug 2023 04:50:59 -0700 (PDT)
Received: from bogus (unknown [10.57.36.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29423F738;
        Wed, 30 Aug 2023 04:50:15 -0700 (PDT)
Date:   Wed, 30 Aug 2023 12:49:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
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
Message-ID: <20230830114918.be4mvwfogdqmsxk6@bogus>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
 <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805012421.7002-2-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:24:19PM -0700, Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
> 
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
> 
>      BUG: kernel NULL pointer dereference, address: 0000000000000100
>      #PF: supervisor read access in kernel mode
>      #PF: error_code(0x0000) - not present page
>      PGD 0 P4D 0
>      Oops: 0000 [#1] PREEPMT SMP NOPTI
>      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
>      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> 
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> not done earlier.
> 
> Cc: Andreas Herrmann <aherrmann@suse.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Radu Rendec <rrendec@redhat.com>
> Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@vger.kernel.org
> Acked-by: Len Brown <len.brown@intel.com>
> Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initializer")

Not sure if we strictly need this(details below), but I am fine either way.

> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> PREEMPT_RT kernels during memory allocation. This splat is not observed on
> x86 because the memory allocation for cacheinfo happens in
> detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> 
> The dereference of a NULL pointer is not observed today because
> cache_leaves(cpu) is zero until after init_cache_level() is called (also
> during the CPU hotplug callback). Patch2 will set it earlier and the NULL-
> pointer dereference will be observed.

Right, this is the information I have been asking in the previous versions.
This clarifies a lot. The trigger is in the patch 2/3 which is why it didn't
make complete sense to me without it when you posted this patch independently.
Thanks for posting it together and sorry for the delay(both reviewing this
and in understanding the issue).

Given the trigger for NULL pointer dereference is in 2/3, I am not sure
if it is really worth applying this to all the stable kernels with the
commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
That is the reason why I asked to drop fixes tag if you agree with me.
It is simple fix, so I am OK if you prefer to see that in the stable kernels
as well.

Since there are x86 changes and patch 2/3 triggers NULL pointer dereference
without this patch, I prefer you route all 3 via x86. So,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
