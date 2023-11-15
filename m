Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985EF7EBCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 06:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjKOFo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 00:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOFo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 00:44:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C04FD1;
        Tue, 14 Nov 2023 21:44:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71AF1DA7;
        Tue, 14 Nov 2023 21:45:09 -0800 (PST)
Received: from [10.163.37.87] (unknown [10.163.37.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60603F6C4;
        Tue, 14 Nov 2023 21:44:16 -0800 (PST)
Message-ID: <5bf73672-4094-490b-b0a9-b983d512c904@arm.com>
Date:   Wed, 15 Nov 2023 11:14:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V14 3/8] drivers: perf: arm_pmuv3: Enable branch stack sampling
 framework
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
 <20231114051329.327572-4-anshuman.khandual@arm.com>
 <0020aa0d-e9a5-aef6-f33d-817da56411a3@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <0020aa0d-e9a5-aef6-f33d-817da56411a3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 15:28, James Clark wrote:
> 
> 
> On 14/11/2023 05:13, Anshuman Khandual wrote:
>> Branch stack sampling support i.e capturing branch records during execution
>> in core perf, rides along with normal HW events being scheduled on the PMU.
>> This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
>> with required HW implementation.
>>
> 
> [...]
> 
>> - All armv8pmu_branch_xxxx() stub definitions have been moved inside
>>   include/linux/perf/arm_pmuv3.h for easy access from both arm32 and
>>   arm64 platforms
>>
> 
> This causes lots of W=1 build errors because the prototypes are in
> arm_pmuv3.h, but arm_brbe.c doesn't include it.

I guess these are the W=1 warnings you mentioned above.

drivers/perf/arm_brbe.c:11:6: warning: no previous prototype for ‘armv8pmu_branch_reset’ [-Wmissing-prototypes]
   11 | void armv8pmu_branch_reset(void)                                                                                                                                                                   
      |      ^~~~~~~~~~~~~~~~~~~~~                                                                                                                                                                         
drivers/perf/arm_brbe.c:190:6: warning: no previous prototype for ‘armv8pmu_branch_save’ [-Wmissing-prototypes]      
  190 | void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)                      
      |      ^~~~~~~~~~~~~~~~~~~~                                                                                                                                                                          
drivers/perf/arm_brbe.c:236:6: warning: no previous prototype for ‘armv8pmu_branch_attr_valid’ [-Wmissing-prototypes]
  236 | bool armv8pmu_branch_attr_valid(struct perf_event *event)                                                                                                                                          
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~                                                                                                                                                                    
drivers/perf/arm_brbe.c:269:5: warning: no previous prototype for ‘armv8pmu_task_ctx_cache_alloc’ [-Wmissing-prototypes]
  269 | int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu)                            
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                            
drivers/perf/arm_brbe.c:279:6: warning: no previous prototype for ‘armv8pmu_task_ctx_cache_free’ [-Wmissing-prototypes]
  279 | void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu)                       
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                            
drivers/perf/arm_brbe.c:303:6: warning: no previous prototype for ‘armv8pmu_branch_probe’ [-Wmissing-prototypes]
  303 | void armv8pmu_branch_probe(struct arm_pmu *armpmu)                                
      |      ^~~~~~~~~~~~~~~~~~~~~                                                                   
drivers/perf/arm_brbe.c:449:6: warning: no previous prototype for ‘armv8pmu_branch_enable’ [-Wmissing-prototypes]
  449 | void armv8pmu_branch_enable(struct arm_pmu *arm_pmu)                             
      |      ^~~~~~~~~~~~~~~~~~~~~~                                                                  
drivers/perf/arm_brbe.c:474:6: warning: no previous prototype for ‘armv8pmu_branch_disable’ [-Wmissing-prototypes]
  474 | void armv8pmu_branch_disable(void)                                                           
      |      ^~~~~~~~~~~~~~~~~~~~~~~                                                                 
drivers/perf/arm_brbe.c:717:6: warning: no previous prototype for ‘armv8pmu_branch_read’ [-Wmissing-prototypes]
  717 | void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)

Branch helpers are used in ARM PMU V3 driver i.e drivers/perf/arm_pmuv3.c.
Whether the actual BRBE helper definitions, or their fallback stubs (when
CONFIG_ARM64_BRBE is not enabled), need to be accessible from arm_pmuv3.c
driver not from brbe.c implementations itself.

> 
> It seems like the main reason you can't include arm_brbe.h in arm32 code
> is because there are a load of inline functions and references to
> registers in there. But these are only used in arm_brbe.c, so they don't

Right, arm32 should not be exposed to BRBE internals via arm_brbe.h header.

> need to be in the header anyway.

Right, these are only used in arm_brbe.c

> 
> If you removed the code from the header and moved it to the source file
> you could move the brbe prototypes to the brbe header and it would be a
> bit cleaner and more idiomatic.

Alight, how about the following changes - build tested on arm32 and arm64.

- Move BRBE helpers from arm_brbe.h into arm_brbe.c
- Move armv8_pmu_xxx() declaration inside arm_brbe.h for arm64 (CONFIG_ARM64_BRBE)
- Move armv8_pmu_xxx() stub definitions inside arm_pmuv3.c for arm32 (!CONFIG_ARM64_BRBE)
- Include arm_brbe.h header both in arm_pmuv3.c and arm_brbe.c
