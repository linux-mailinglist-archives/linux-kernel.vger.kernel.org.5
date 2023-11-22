Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF17F475A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbjKVNGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbjKVNGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:06:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E28100
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:06:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5384C433C7;
        Wed, 22 Nov 2023 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700658386;
        bh=Y6xAGgfADYxboftFlWMmXrKJq8g9fEh88y/hP5ytW28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiolzToIV2impMQAaxb7yDqAn3vPNl/yoxsqC+2IbN2PLfSh3yfPFFgnN0n03xTJn
         //w92GX9G6xFva1ZalRObUZX3XJ4h35TTWIk3nh3zqM/p5+fMfGZDkdesZCHmrdr0n
         9cIn9htqUVk7XBbUQkvQGb29mpXVP2AlbDoge+opS44NJx4KCaWijcBDffU/TjbBJS
         l8cccNqYC5PEDJTCbS2oIlcx9mpwybS0xmQIHz+OCMX4QERb1uqmCm3PFA5PuHZp9/
         TAkQ/8I1AeNTjayd8/cXvC3vcp95deOT5Iv+XISZD8VC2G/HInWusci1ToGgr0HMHW
         F1fOVOEaV7iEQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 40CCB40094; Wed, 22 Nov 2023 10:06:23 -0300 (-03)
Date:   Wed, 22 Nov 2023 10:06:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZV38z3+p2S2ETtzG@kernel.org>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org>
 <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 22, 2023 at 12:23:27PM +0900, Hector Martin escreveu:
> On 2023/11/22 1:38, Ian Rogers wrote:
> > On Tue, Nov 21, 2023 at 8:15 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >> On Tue, Nov 21, 2023 at 08:09:37AM -0800, Ian Rogers wrote:
> >>> On Tue, Nov 21, 2023 at 8:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >>>> On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> >>>>> On Tue, Nov 21, 2023 at 7:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >>>>>> On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> >>>>>>> On Tue, 21 Nov 2023 13:40:31 +0000,
> >>>>>>> Marc Zyngier <maz@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> [Adding key people on Cc]
> >>>>>>>>
> >>>>>>>> On Tue, 21 Nov 2023 12:08:48 +0000,
> >>>>>>>> Hector Martin <marcan@marcan.st> wrote:
> >>>>>>>>>
> >>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
> >>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
> >>>>>>>>
> >>>>>>>> I can confirm that at least on 6.7-rc2, perf is pretty busted on any
> >>>>>>>> asymmetric ARM platform. It isn't clear what criteria is used to pick
> >>>>>>>> the PMU, but nothing works anymore.
> >>>>>>>>
> >>>>>>>> The saving grace in my case is that Debian still ships a 6.1 perftool
> >>>>>>>> package, but that's obviously not going to last.
> >>>>>>>>
> >>>>>>>> I'm happy to test potential fixes.
> >>>>>>>
> >>>>>>> At Mark's request, I've dumped a couple of perf (as of -rc2) runs with
> >>>>>>> -vvv.  And it is quite entertaining (this is taskset to an 'icestorm'
> >>>>>>> CPU):
> >>>>>>
> >>>>>> IIUC the tool is doing the wrong thing here and overriding explicit
> >>>>>> ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather than events using
> >>>>>> that ${pmu}'s type and event namespace.
> >>>>>>
> >>>>>> Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE events to be
> >>>>>> targetted to a specific PMU, it's semantically wrong to rewrite events like
> >>>>>> this since ${pmu}/${event}/ is not necessarily equivalent to a similarly-named
> >>>>>> PERF_COUNT_HW_${EVENT}.
> >>>>>
> >>>>> If you name a PMU and an event then the event should only be opened on
> >>>>> that PMU, 100% agree. There's a bunch of output, but when the legacy
> >>>>> cycles event is opened it appears to be because it was explicitly
> >>>>> requested.
> >>>>
> >>>> I think you've missed that the named PMU events are being erreously transformed
> >>>> into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.
> >>>>
> >>>>   Opening: apple_firestorm_pmu/cycles/
> >>>>   ------------------------------------------------------------
> >>>>   perf_event_attr:
> >>>>     type                             0 (PERF_TYPE_HARDWARE)
> >>>>     size                             136
> >>>>     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> >>>>     sample_type                      IDENTIFIER
> >>>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >>>>     disabled                         1
> >>>>     inherit                          1
> >>>>     enable_on_exec                   1
> >>>>     exclude_guest                    1
> >>>>   ------------------------------------------------------------
> >>>>   sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 4
> >>>>
> >>>> ... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_CYCLES.
> >>>>
> >>>> Marc said that he bisected the issue down to commit:
> >>>>
> >>>>   5ea8f2ccffb23983 ("perf parse-events: Support hardware events as terms")
> >>>>
> >>>> ... so it looks like something is going wrong when the events are being parsed,
> >>>> e.g. losing the HW PMU information?
> >>>
> >>> Ok, I think I'm getting confused by other things. This looks like the issue.
> >>>
> >>> I think it may be working as intended, but not how you intended :-) If
> >>> a core PMU is listed and then a legacy event, the legacy event should

The point is that "cycles" when prefixed with "pmu/" shouldn't be
considered "cycles" as HW/0, in that setting it is "cycles" for that
PMU. (but we only have "cpu_cycles" for at least the a53 and a72 PMUs I
have access in a Libre Computer rockchip 3399-pc hybrid board, if we use
it, then we get what we want/had before, see below):

And there is an attempt at using the specified PMU, see the first
perf_event_open:

root@roc-rk3399-pc:~# strace -e perf_event_open perf stat -vv -e cycles,armv8_cortex_a53/cycles/,armv8_cortex_a72/cycles/ echo
Using CPUID 0x00000000410fd082
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  config                           0x700000000
  disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0x7<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
                                                   
//// HERE: it tries config=0x7<<32|PERF_COUNT_HW_CPU_CYCLES taking into
//account the PMU number 0x7

root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a53/type
7
root@roc-rk3399-pc:~#

But then we don't have "cycles" in that PMU:

root@roc-rk3399-pc:~# ls -la /sys/devices/armv8_cortex_a53/events/cycles
ls: cannot access '/sys/devices/armv8_cortex_a53/events/cycles': No such file or directory
root@roc-rk3399-pc:~#

Maybe:

root@roc-rk3399-pc:~# taskset -c 5,6 perf stat -v -e armv8_cortex_a53/cpu_cycles/,armv8_cortex_a72/cpu_cycles/ echo
Using CPUID 0x00000000410fd034
Control descriptor is not initialized

armv8_cortex_a53/cpu_cycles/: 0 2079000 0
armv8_cortex_a72/cpu_cycles/: 2488961 2079000 2079000

 Performance counter stats for 'echo':

     <not counted>      armv8_cortex_a53/cpu_cycles/                                            (0.00%)
           2488961      armv8_cortex_a72/cpu_cycles/

       0.003449266 seconds time elapsed

       0.003502000 seconds user
       0.000000000 seconds sys


root@roc-rk3399-pc:~# taskset -c 0,1,2,3,4 perf stat -v -e armv8_cortex_a53/cpu_cycles/,armv8_cortex_a72/cpu_cycles/ echo
Using CPUID 0x00000000410fd034
Control descriptor is not initialized

armv8_cortex_a53/cpu_cycles/: 2986601 6999416 6999416
armv8_cortex_a72/cpu_cycles/: 0 6999416 0

 Performance counter stats for 'echo':

           2986601      armv8_cortex_a53/cpu_cycles/
     <not counted>      armv8_cortex_a72/cpu_cycles/                                            (0.00%)

       0.011434508 seconds time elapsed

       0.003911000 seconds user
       0.007454000 seconds sys


root@roc-rk3399-pc:~#

root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a53/events/cpu_cycles
event=0x0011
root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a72/events/cpu_cycles
event=0x0011
root@roc-rk3399-pc:~#

And the syscalls seem sane:

root@roc-rk3399-pc:~# strace -e perf_event_open taskset -c 0,1,2,3,4 perf stat -v -e armv8_cortex_a53/cpu_cycles/,armv8_cortex_a72/cpu_cycles/ echo
Using CPUID 0x00000000410fd034
Control descriptor is not initialized
perf_event_open({type=0x7 /* PERF_TYPE_??? */, size=0x88 /* PERF_ATTR_SIZE_??? */, config=0x11, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, 14573, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
perf_event_open({type=0x8 /* PERF_TYPE_??? */, size=0x88 /* PERF_ATTR_SIZE_??? */, config=0x11, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, exclude_guest=1, ...}, 14573, -1, -1, PERF_FLAG_FD_CLOEXEC) = 4

--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=14573, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
armv8_cortex_a53/cpu_cycles/: 3227098 4480875 4480875
armv8_cortex_a72/cpu_cycles/: 0 4480875 0

 Performance counter stats for 'echo':

           3227098      armv8_cortex_a53/cpu_cycles/
     <not counted>      armv8_cortex_a72/cpu_cycles/                                            (0.00%)

       0.008381759 seconds time elapsed

       0.004064000 seconds user
       0.004121000 seconds sys


--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=14572, si_uid=0} ---
+++ exited with 0 +++
root@roc-rk3399-pc:~#

As:

root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a53/type
7
root@roc-rk3399-pc:~# cat /sys/devices/armv8_cortex_a72/type
8
root@roc-rk3399-pc:~#

See the type=0x7 and type=0x8.

So what we need here seems to be to translate the generic term "cycles"
to "cpu_cycles" when a PMU is explicitely passed in the event name and
it doesn't have "cycles" and then just retry.

- Arnaldo
