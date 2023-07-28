Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7D7671D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjG1QcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG1QcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:32:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A34063ABA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:32:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EABA2F4;
        Fri, 28 Jul 2023 09:33:04 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ABDE3F67D;
        Fri, 28 Jul 2023 09:32:17 -0700 (PDT)
Message-ID: <ba114d34-b460-8e73-302b-9f621c1fb8a1@arm.com>
Date:   Fri, 28 Jul 2023 17:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 24/24] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-GB
To:     Peter Newman <peternewman@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-25-james.morse@arm.com>
 <CALPaoCjxUMy_yW0+4MgssiisoDpeP8m62fP9nhTcse9nKiXM+A@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CALPaoCjxUMy_yW0+4MgssiisoDpeP8m62fP9nhTcse9nKiXM+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 13/06/2023 10:15, Peter Newman wrote:
> On Thu, May 25, 2023 at 8:03 PM James Morse <james.morse@arm.com> wrote:
>>
>> resctrl has one mutex that is taken by the architecture specific code,
>> and the filesystem parts. The two interact via cpuhp, where the
>> architecture code updates the domain list. Filesystem handlers that
>> walk the domains list should not run concurrently with the cpuhp
>> callback modifying the list.
>>
>> Exposing a lock from the filesystem code means the interface is not
>> cleanly defined, and creates the possibility of cross-architecture
>> lock ordering headaches. The interaction only exists so that certain
>> filesystem paths are serialised against cpu hotplug. The cpu hotplug
>> code already has a mechanism to do this using cpus_read_lock().
>>
>> MPAM's monitors have an overflow interrupt, so it needs to be possible
>> to walk the domains list in irq context. RCU is ideal for this,
>> but some paths need to be able to sleep to allocate memory.
> 
> I noticed there's also a call to get_domain_from_cpu() in
> rdt_ctrl_update(), which is invoked by IPI when updating a schemata
> file, but at least it's a blocking IPI and the caller holds the
> rdtgroup_mutex, so the handler is serialized with CPU hotplug.

resctrl_arch_update_domains()? This also has lockdep_assert_cpus_held(), which is taken by
rdtgroup_kn_lock_live() - this pattern covers all the user-space filesystem operations.

I'd really like to get all the resctrl_arch_* helpers away from depending on
rdtgroup_mutex. Part of this is to allow perf/kvm/etc to use this interface without having
to expose more things from resctrl.


> Taking a step back, I'm concerned about the scalability of searching
> these linked-lists of domains in atomic contexts. We already have
> machines where the list is 32 entries deep in L3, and much larger in
> L2 CAT.

(Isn't this an existing problem? All I'm doing here is making it something explicitly
supported).


> Will the overflow interrupt target a CPU in the correct domain? The
> existing domain list search in rdt_ctrl_update() is for the current
> CPU's domain, so an alternative there would be to store each CPU's
> interrupt-relevant domain pointers in percpu data for quick lookup.

For the overflow interrupt, the irqchip code passes the device to the irq handler, which
corresponds to the MSC and via some intermediate structure, the resctrl domain. So this is
cheap to look up.

The need to 'walk the list in IRQ context' really comes from perf, regardless of whether
the overflow interrupt is supported. The domain_id is cached, but the domain may go
offline before the PMU driver is next called, hence the need to search the list and check
the CPU each time. If this proves to be a bottleneck, we can look for a better data structure.
The domain list is sorted, so a bisect search would improve matters.
A hash table may work for x86, as far as I can see the cache-ids are where the domain-id
always comes from, and those values are picked by the kernel to be contiguous. (on arm64
they come from a firmware table, all we know is they should be unique).

resctrl_arch_find_domain() is a per-arch thing, so we can do whatever is best for each
architecture.


For your resctrl_arch_update_domains() example, x86 could dispatch an IPI to each CPU,
passing the necessary domain in msr_param as part of the main loop. This would be slower
for the caller as you'd have to wait for each one to complete, but it would avoid a CPU in
each domain having to search the domain list with interrupts masked. (possibly all at the
same time)
I figure schema updates are rare, and it doesn't matter how long they take, provided it
doesn't impact other tasks.


> Also, how quickly does the overflow condition need to be serviced? On
> Intel, overflow handling deadlines aren't even tight enough to warrant
> an interrupt handler.

Ultimately, I don't know. It's something the architecture supports, I think its most
useful for use with perf-record. I've not had anyone ask for this support yet.

MPAM can have bandwidth counters as small as 32bit and can count in bytes. If someone
builds this configuration, they may find the overflow interrupt goes off more frequently
than the overflow thread runs to scrub the counters.

MPAM also has options to scale the counters by some implementation specific size, as well
as 44 and 63 bit counters - all of which should overflow less frequently.

As with everything in the arm world, its very much "chose your own adventure".


Thanks,

James
