Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC47FC19F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346425AbjK1QAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbjK1P76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:59:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 426A395;
        Tue, 28 Nov 2023 08:00:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5472A169E;
        Tue, 28 Nov 2023 08:00:52 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1E43F6C4;
        Tue, 28 Nov 2023 08:00:04 -0800 (PST)
Date:   Tue, 28 Nov 2023 16:00:03 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, pierre.gondois@arm.com,
        beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 1/7] topology: Add a new arch_scale_freq_reference
Message-ID: <ZWYOg1gIIgI1qXn7@arm.com>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-2-vincent.guittot@linaro.org>
 <ZWYM0hn28RHjAalh@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYM0hn28RHjAalh@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 Nov 2023 at 15:52:52 (+0000), Ionela Voinescu wrote:
> Hi Vincent,
> 
> I have a small request on this patch, which is useful for [1].
> I'll detail what is needed lower in the code.
> 
> [1] https://lore.kernel.org/lkml/ZWYDr6JJJzBvsqf0@arm.com/
> 
> On Thursday 09 Nov 2023 at 11:14:32 (+0100), Vincent Guittot wrote:
> > @@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
> >  
> >  	capacity_scale = 1;
> >  	for_each_possible_cpu(cpu) {
> > -		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > +		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> 
> The only affected code that I could find is here and below.
> 
> The above line would have to change to:
> capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> 
> >  		capacity_scale = max(capacity, capacity_scale);
> >  	}
> >  
> >  	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
> >  	for_each_possible_cpu(cpu) {
> > -		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > +		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> 
> and here:
> capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> 
> I think it's nicer to start with capacity_freq_ref as 0 and compensate here
> for uninitialized capacity_freq_ref.
> 
> Let me know if this is alright of if you'd prefer us to make this change
> in a separate patch.
> 
> Thanks,
> Ionela.
> 

Correction - both will need to be:
capacity = raw_capacity[cpu] * (per_cpu(capacity_freq_ref, cpu) ?: 1);

Thanks,
Ionela.
