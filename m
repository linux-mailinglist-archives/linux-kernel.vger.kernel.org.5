Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14779F17F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjIMS5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIMS5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:57:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 503BB170F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:57:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 051831FB;
        Wed, 13 Sep 2023 11:58:09 -0700 (PDT)
Received: from [10.57.93.239] (unknown [10.57.93.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91C9F3F738;
        Wed, 13 Sep 2023 11:57:30 -0700 (PDT)
Message-ID: <ab420c93-5baa-a486-d21a-6a305d498687@arm.com>
Date:   Wed, 13 Sep 2023 19:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: cpufeature: Expose the real mpidr value to EL0
Content-Language: en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     guojinhui <guojinhui.liam@bytedance.com>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, will@kernel.org
References: <759c91b9-856e-a778-0e0a-e52240e5c8ce@arm.com>
 <20230913094426.2787-1-guojinhui.liam@bytedance.com>
 <381a2abc-1597-c179-99f2-477d7f41b91b@arm.com>
 <20230913140629.000052ad@Huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230913140629.000052ad@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-13 14:06, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 12:23:37 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2023-09-13 10:44, guojinhui wrote:
>>>>> In EL0, it can get the register midr's value to distinguish vendor.
>>>>> But it won't return real value of the register mpidr by using mrs
>>>>> in EL0. The register mpidr's value is useful to obtain the cpu
>>>>> topology information.
>>>>
>>>> ...except there's no guarantee that the MPIDR value is anything other
>>>> than a unique identifier. Proper topology information is already exposed
>>>> to userspace[1], as described by ACPI PPTT or Devicetree[2]. Userspace
>>>> should be using that.
>>>>
>>>> Not to mention that userspace fundamentally can't guarantee it won't be
>>>> migrated at just the wrong point and read the MPIDR of a different CPU
>>>> anyway. (This is why the MIDRs and REVIDRs are also reported via sysfs,
>>>> such that userspace has a stable and reliable source of information in
>>>> case it needs to consider potential errata.)
>>>>
>>>> Thanks,
>>>> Robin.
>>>>
>>>> [1] https://www.kernel.org/doc/html/latest/admin-guide/cputopology.html
>>>> [2]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/cpu/cpu-topology.txt
>>>
>>> 1. If we can get the infomation of the vendor (by MIDR), i think it possible to obtain
>>> the die infomation from the MPIDR value. Such as the kunpeng-920,
>>> 4 cores per cluster, 8 clusters per die, whose MPIDR value is as follow:
>>>
>>> ```
>>> <DIE>.<CLUSTER>.<CORE>.<HT>
>>>
>>> cpu = 0, 81080000
>>> cpu = 1, 81080100
>>> ...
>>> cpu = 3, 81080300
>>> cpu = 4, 81090000
>>> ...
>>> cpu = 7, 81090300
>>> cpu = 8, 810a0000
>>> ...
>>> cpu = 11, 810a0300
>>> cpu = 12, 810b0000
>>> ...
>>> cpu = 15, 810b0300
>>> cpu = 16, 810c0000
>>> ...
>>> cpu = 19, 810c0300
>>> cpu = 20, 810d0000
>>> ...
>>> cpu = 31, 810f0300
>>> cpu = 32, 81180000
>>> ...
>>> cpu = 63, 811f0300
>>> ```
>>>
>>> we can get the die infomation by 0x810, 0x811.
>>
>> This is very much a platform-specific assumption, though, and once
>> you're assuming enough to be able to derive anything meaningful from a
>> raw MPIDR, you could equally derive the same thing from existing sources
>> like NUMA topology (if you know the SoC, then for sure you can know how
>> nodes relate to dies).
>>
>>> 2. we can bind the task to the specific cpu to obtain the MPIDR value.
>>
>> ...unless that CPU then gets offlined, the task is forcibly migrated
>> elsewhere, and ends up obtaining the *wrong* MPIDR value :(
>>
>>> 3. I have checked the sysfs interface `/sys/devices/system/cpu/cpuN/topology/*`
>>> in Ampere and kunpeng-920 with the latest linux kernel before i submit the patch,
>>> but it doesn't provide the information of die.
>>>
>>> ```
>>> # ls /sys/devices/system/cpu/cpu0/topology/
>>> cluster_cpus  cluster_cpus_list  cluster_id  core_cpus  core_cpus_list  core_id  core_siblings  core_siblings_list  package_cpus  package_cpus_list  physical_package_id  thread_siblings  thread_siblings_list
>>> # cat /sys/devices/system/cpu/cpu0/topology/*
>>> 00000000,00000000,00000000,00000003
>>> 0-1
>>> 616
>>> 00000000,00000000,00000000,00000001
>>> 0
>>> 6656
>>> 00000000,00000000,ffffffff,ffffffff
>>> 0-63
>>> 00000000,00000000,ffffffff,ffffffff
>>> 0-63
>>> 0
>>> 00000000,00000000,00000000,00000001
>>> 0
>>>
>>> # uname -r
>>> 6.6.0-rc1
>>> ```
>>>
>>> Then I check the code which parses the cpu topology infomation from PPTT:
>>>
>>> ```
>>> int __init parse_acpi_topology(void)
>>> {
>>>           int cpu, topology_id;
>>>
>>>           if (acpi_disabled)
>>>                   return 0;
>>>
>>>           for_each_possible_cpu(cpu) {
>>>                   topology_id = find_acpi_cpu_topology(cpu, 0);
>>>                   if (topology_id < 0)
>>>                           return topology_id;
>>>
>>>                   if (acpi_cpu_is_threaded(cpu)) {
>>>                           cpu_topology[cpu].thread_id = topology_id;
>>>                           topology_id = find_acpi_cpu_topology(cpu, 1);
>>>                           cpu_topology[cpu].core_id   = topology_id;
>>>                   } else {
>>>                           cpu_topology[cpu].thread_id  = -1;
>>>                           cpu_topology[cpu].core_id    = topology_id;
>>>                   }
>>>                   topology_id = find_acpi_cpu_topology_cluster(cpu);
>>>                   cpu_topology[cpu].cluster_id = topology_id;
>>>                   topology_id = find_acpi_cpu_topology_package(cpu);
>>>                   cpu_topology[cpu].package_id = topology_id;
>>>           }
>>>
>>>           return 0;
>>> }
>>> ```
>>>
>>> Actually, it just gives the infomation of thread, cluster and package
>>> though the PPTT provides the dies infomation.
>>>
>>> May be we can implement some code to obtain die information from PPTT?
>>
>> I guess if any additional levels of hierarchy exist between the root
>> "package" level and what we infer to be the "cluster" level, then it
>> seems reasonable to me to infer the next level above "package" to be
>> "die". Then it looks like pretty much just a case of wiring up
>> topology_die_id() through the generic topology code.
> 
> Cluster was a vague enough concept that it was safe to define
> it as the layer above a core.  Die is a lot less obvious because it
> has more direct physical meaning.  There are interconnect and cache
> topologies where something is shared above the cluster where it
> doesn't correspond to a die (in the sense of a chiplet / one
> piece of silicon).  For those you'd have another level in PPTT before
> you reach the one that can be thought of as a die.

Oh, silly me; I was already assuming that there may be intermediate 
levels between cluster and die, but of course you could have that while 
still *not* having multiple dies, and thus no distinct "die" level in 
PPTT at all when that's already sufficiently implied by "package", so 
indeed it couldn't work in general.

> What about the die is of relevance for a userspace scheduler?
> Sharing of L3, NUMA proximity domain / DDR controller locations?
> 
> All that is visible either via the cache topology or the NUMA node
> topology.
> 
> If there is a strong reason (beyond 'x86 has it in a system register')
> for having die explicitly provided in PPTT, then file a code first ACPI
> proposal to add a flags, similar to the existing one that indicates
> Physical Package.  Note that a strong justification would be needed.

I'd agree with that. Thanks for the clarifications!

Cheers,
Robin.
