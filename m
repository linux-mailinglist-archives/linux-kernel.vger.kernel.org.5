Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64E17F3C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbjKVDXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:23:41 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173612C;
        Tue, 21 Nov 2023 19:23:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 39644447AA;
        Wed, 22 Nov 2023 03:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1700623413; bh=rtXVApGwa8ftTxbLhp+YfRE6O5FW8Zz5eF4VEvMHC5w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZRYkYaiIHUbIJ6O90RUA0KkCuAmWaQP464BlJsC0N4EznUZQ5rmsemsbMdAjpqkup
         xhHEchuTe1dwBUuEUUBwfj87J8bI4w/hIKoWI2N+DBDP9Uu4oBlZL2pFJMH9mR5+j8
         l2/7tjaVCVI/k3mAaRgcQVnfBdSOy8p6EN8nKQI9QtEqTboNUHuaJGR1l1n6sabB11
         B0pFlys3mHd605Nq5KNFYmnnO3c1eOA6T6lFUONraGzWWqOfhEGTIUbskwilmlxTJY
         xs9j7PmqjCnZaXDezsaK62PdpM4wlDrL2YyOPLuvhwsmTL8UNiNCh4bWD5HCFRZhdZ
         dZ2kg0HxQJtew==
Message-ID: <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st>
Date:   Wed, 22 Nov 2023 12:23:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org> <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/22 1:38, Ian Rogers wrote:
> On Tue, Nov 21, 2023 at 8:15 AM Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
>>> On Tue, Nov 21, 2023 at 8:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
>>>>
>>>> On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
>>>>> On Tue, Nov 21, 2023 at 7:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>>
>>>>>> On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
>>>>>>> On Tue, 21 Nov 2023 13:40:31 +0000,
>>>>>>> Marc Zyngier <maz@kernel.org> wrote:
>>>>>>>>
>>>>>>>> [Adding key people on Cc]
>>>>>>>>
>>>>>>>> On Tue, 21 Nov 2023 12:08:48 +0000,
>>>>>>>> Hector Martin <marcan@marcan.st> wrote:
>>>>>>>>>
>>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
>>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
>>>>>>>>
>>>>>>>> I can confirm that at least on 6.7-rc2, perf is pretty busted on any
>>>>>>>> asymmetric ARM platform. It isn't clear what criteria is used to pick
>>>>>>>> the PMU, but nothing works anymore.
>>>>>>>>
>>>>>>>> The saving grace in my case is that Debian still ships a 6.1 perftool
>>>>>>>> package, but that's obviously not going to last.
>>>>>>>>
>>>>>>>> I'm happy to test potential fixes.
>>>>>>>
>>>>>>> At Mark's request, I've dumped a couple of perf (as of -rc2) runs with
>>>>>>> -vvv.  And it is quite entertaining (this is taskset to an 'icestorm'
>>>>>>> CPU):
>>>>>>
>>>>>> IIUC the tool is doing the wrong thing here and overriding explicit
>>>>>> ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather than events using
>>>>>> that ${pmu}'s type and event namespace.
>>>>>>
>>>>>> Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE events to be
>>>>>> targetted to a specific PMU, it's semantically wrong to rewrite events like
>>>>>> this since ${pmu}/${event}/ is not necessarily equivalent to a similarly-named
>>>>>> PERF_COUNT_HW_${EVENT}.
>>>>>
>>>>> If you name a PMU and an event then the event should only be opened on
>>>>> that PMU, 100% agree. There's a bunch of output, but when the legacy
>>>>> cycles event is opened it appears to be because it was explicitly
>>>>> requested.
>>>>
>>>> I think you've missed that the named PMU events are being erreously transformed
>>>> into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
>>>>
>>>>   Opening: apple_firestorm_pmu/cycles/
>>>>   ------------------------------------------------------------
>>>>   perf_event_attr:
>>>>     type                             0 (PERF_TYPE_HARDWARE)
>>>>     size                             136
>>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>>>>     sample_type                      IDENTIFIER
>>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>>>     disabled                         1
>>>>     inherit                          1
>>>>     enable_on_exec                   1
>>>>     exclude_guest                    1
>>>>   ------------------------------------------------------------
>>>>   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 4
>>>>
>>>> ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_CYCLES.
>>>>
>>>> Marc said that he bisected the issue down to commit:
>>>>
>>>>   5ea8f2ccffb23983 ("perf parse-events: Support hardware events as terms")
>>>>
>>>> ... so it looks like something is going wrong when the events are being parsed,
>>>> e.g. losing the HW PMU information?
>>>
>>> Ok, I think I'm getting confused by other things. This looks like the issue.
>>>
>>> I think it may be working as intended, but not how you intended :-) If
>>> a core PMU is listed and then a legacy event, the legacy event should
>>> be opened on the core PMU as a legacy event with the extended type
>>> set. This is to allow things like legacy cache events to be opened on
>>> a specified PMU. Legacy event names match with a higher priority than
>>> those in sysfs or json as they are hard coded.
>>
>> That has never been the case previously, so this is user-visible breakage, and
>> it prevents users from being able to do the right thing, so I think that's a
>> broken design.
> 
> So the problem was caused by ARM and Intel doing two different things.
> Intel did at least contribute to the perf tool in support for their
> BIG.little/hybrid, so that's why the semantics match their approach.
> 
>>> Presumably the expectation was that by advertising a cycles event, presumably
>>> in sysfs, then this is what would be matched.
>>
>> I expect that if I ask for ${pmu}/${event}/, that PMU is used, and the event
>> *in that PMU's namespace* is used. Overriding that breaks long-established
>> practice and provides users with no recourse to get the behavioru they expect
>> (and previosuly had).
> 
> On ARM but not Intel.
> 
>> I do think that (regardless of whther this was the sematnic you intended)
>> silently overriding events with legacy events is a bug, and one we should fix.
>> As I mentioned in another reply, just because the events have the same name
>> does not mean that they are semantically the same, so we're liable to give
>> people the wrong numbers anyhow.
>>
>> Can we fix this?
> 
> So I'd like to fix this, some things from various conversations:
> 
> 1) we lack testing. Our testing relies on the sysfs of the machine
> being run on, which is better than nothing. I think ideally we'd have
> a collection of zipped up sysfs directories and then we could have a
> test that asserts on ARM you get the behavior you want.
> 
> 2) for RISC-V they want to make the legacy event matching something in
> user land to simplify the PMU driver.
> 
> 3) I'd like to get rid of the PMU json interface. My idea is to
> convert json events/metrics into sysfs style files, zip these up and
> then link them into the perf binary. On Intel the json is 70% of the
> binary (7MB out of 10MB) and we may get this down to 3MB with this
> approach. The json lookup would need to incorporate the cpuid matching
> that currently exists. When we look up an event I'd like the approach
> to be like unionfs with a specified but configurable order. Users
> could provide directories of their own events/metrics for various
> PMUs, and then this approach could be used to help with (1).
> 
> Those proposals are not something to add as a -rc fix, so what I think
> you're asking for here is a "if ARM" fix somewhere in the event
> parsing. That's of course possible but it will cause problems if you
> did say:
> 
> perf stat -e arm_pmu/LLC-load-misses/ ...
> 
> as I doubt the PMU driver is advertising this legacy event in sysfs
> and the "if ARM" logic would presumably be trying to disable legacy
> events in the term list for the ARM PMU.
> 
> Given all of this, is anything actually broken and needing a fix for 6.7?

You literally cannot use perf correctly on ARM big.LITTLE systems since
6.5, while it worked fine on 6.4. So, yes, it's broken and it needs
fixing. This is a major regression.

$ taskset -c 0 perf stat -e apple_icestorm_pmu/cycles/ echo


 Performance counter stats for 'echo':

     <not counted>      apple_icestorm_pmu/cycles/u
                       (0.00%)

       0.001385544 seconds time elapsed

       0.001375000 seconds user
       0.000000000 seconds sys


$ taskset -c 2 perf stat -e apple_firestorm_pmu/cycles/ echo


 Performance counter stats for 'echo':

           169,965      apple_firestorm_pmu/cycles/u


       0.000466667 seconds time elapsed

       0.000475000 seconds user
       0.000000000 seconds sys


Both of those should return counts. One does not, and it doesn't even
seem to be predictable which one you get. *On my particular system, it
is currently impossible to get any performance counter data from the E
cores, as far as I can tell, no matter how you invoke perf*.

Feel free to argue semantics as to what went wrong or how it should be
fixed, but there is no question that this is a regression that requires
a fix. Perf is currently simply broken here, where it wasn't in 6.4.

- Hector
