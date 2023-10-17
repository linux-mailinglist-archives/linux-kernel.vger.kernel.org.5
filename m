Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7168F7CCC01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJQTPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjJQTPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:15:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F3EAB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:15:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C2EF2F4;
        Tue, 17 Oct 2023 12:16:26 -0700 (PDT)
Received: from [172.27.42.216] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA8983F5A1;
        Tue, 17 Oct 2023 12:15:44 -0700 (PDT)
Message-ID: <f3fc7881-c965-2b1d-8430-b8c18783cb7b@arm.com>
Date:   Tue, 17 Oct 2023 14:15:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] arm64: cpufeature: Change 32-bit EL0 to display
 enabled cores
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, anshuman.khandual@arm.com,
        krisman@suse.de, broonie@kernel.org, james.morse@arm.com,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org
References: <20231017052322.1211099-1-jeremy.linton@arm.com>
 <20231017052322.1211099-4-jeremy.linton@arm.com>
 <86ttqpm8lg.wl-maz@kernel.org>
Content-Language: en-US
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <86ttqpm8lg.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/17/23 13:01, Marc Zyngier wrote:
> On Tue, 17 Oct 2023 06:23:22 +0100,
> Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> Now that we have the ability to display the list of cores
>> with a feature when it is selectivly enabled, lets display the
>> cores enabled for 32-bit use at EL0.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index b7b67bac0e60..512cbe446b41 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1533,8 +1533,17 @@ static bool has_32bit_el0(const struct arm64_cpu_capabilities *entry, int scope)
>>   	if (!has_cpuid_feature(entry, scope))
>>   		return allow_mismatched_32bit_el0;
>>   
>> -	if (scope == SCOPE_SYSTEM)
>> -		pr_info("detected: 32-bit EL0 Support\n");
>> +	if (scope == SCOPE_SYSTEM) {
>> +		struct arm64_cpu_capabilities *has_32bit;
>> +
>> +		has_32bit = (struct arm64_cpu_capabilities *)entry;
>> +
>> +		has_32bit->cpus = system_32bit_el0_cpumask();
> 
> This seems rather dodgy. 'entry' comes from a static const array which
> will, in all likelihood be mapped R/O pretty soon after the initial
> CPU bringup. Try offlining/onlining a CPU and you should see a
> firework similar to what I have below (I hacked the CnP property, but
> that's no different from what you are doing):

Yes, dodgy is a good word. The other choices, maintain a mask just for 
the print or dump the static key and always use the cpu_32bit_el0_mask 
or some combination, weren't much better in the "ick" category. If 
anyone sees a better way I'm open to suggestion, although simply 
dropping this last patch is fine too.

> 
> bash-5.1# echo 0 >/sys/devices/system/cpu/cpu2/online
> [   51.367137] psci: CPU2 killed (polled 0 ms)
> bash-5.1# echo 1 >/sys/devices/system/cpu/cpu2/online
> [   56.703092] Unable to handle kernel write to read-only memory at virtual address ffff800080d63db0
> [   56.703494] Mem abort info:
> [   56.703627]   ESR = 0x000000009600004f
> [   56.703799]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   56.704052]   SET = 0, FnV = 0
> [   56.704196]   EA = 0, S1PTW = 0
> [   56.704340]   FSC = 0x0f: level 3 permission fault
> [   56.704575] Data abort info:
> [   56.704715]   ISV = 0, ISS = 0x0000004f, ISS2 = 0x00000000
> [   56.704961]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> [   56.705195]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   56.705435] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000008142e000
> [   56.705742] [ffff800080d63db0] pgd=10000000dbfff003, p4d=10000000dbfff003, pud=10000000dbffe003, pmd=10000000dbffc003, pte=0060000080d63783
> [   56.706310] Internal error: Oops: 000000009600004f [#1] PREEMPT SMP
> [   56.706591] Modules linked in:
> [   56.706741] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.6.0-rc1-00007-g805cc7d30885-dirty #1702
> [   56.707145] Hardware name: linux,dummy-virt (DT)
> [   56.707359] pstate: 800001c5 (Nzcv dAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   56.707676] pc : cpu_enable_cnp+0x24/0x60
> [   56.707873] lr : verify_local_cpu_caps+0x6c/0x140
> [   56.708046] sp : ffff800082103e10
> [   56.708201] x29: ffff800082103e10 x28: 0000000000000000 x27: 0000000000000000
> [   56.708517] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> [   56.708837] x23: ffff800081eec540 x22: 0000000000000003 x21: ffff8000813945f0
> [   56.709166] x20: ffff800081394358 x19: ffff800080d63db0 x18: 0000000000000000
> [   56.709488] x17: 000000040044ffff x16: 00500073b5503510 x15: 0000000000000000
> [   56.709805] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   56.710100] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff8000800273ac
> [   56.710416] x8 : ffff80008003b640 x7 : 0000000000000000 x6 : 0000000000000000
> [   56.710738] x5 : 0000000000000000 x4 : ffff800081394000 x3 : ffff800081394000
> [   56.711070] x2 : ffff800081241ef8 x1 : ffff800080027218 x0 : ffff800080d63db0
> [   56.711396] Call trace:
> [   56.711512]  cpu_enable_cnp+0x24/0x60
> [   56.711684]  verify_local_cpu_caps+0x6c/0x140
> [   56.711885]  verify_local_cpu_capabilities+0x1c/0x198
> [   56.712112]  check_local_cpu_capabilities+0x28/0x50
> [   56.712337]  secondary_start_kernel+0xb4/0x1a0
> [   56.712546]  __secondary_switched+0xb8/0xc0
> [   56.712739] Code: 910003fd b0009b63 d00090c2 913be042 (f9000002)
> [   56.713013] ---[ end trace 0000000000000000 ]---
> [   56.713224] Kernel panic - not syncing: Attempted to kill the idle task!
> [   56.713518] SMP: stopping secondary CPUs
> [   56.713752] Kernel Offset: disabled
> [   56.713908] CPU features: 0x00000000,50024d43,1947f723
> [   56.714144] Memory Limit: none
> [   56.714292] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> Thanks,
> 
> 	M.
> 

