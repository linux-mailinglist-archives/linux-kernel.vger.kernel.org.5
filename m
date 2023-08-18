Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0E780DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377709AbjHROQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377703AbjHROP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:15:58 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4344202
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:15:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5D0D560174;
        Fri, 18 Aug 2023 16:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692368153; bh=Xbc6XW4VWVtR9wErQmGFD6fByVw59afmAS8OjaUawv8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=M54xmUdyxJav2DjXDa5nY/BTvKN6HEiOdVhBwDWedSek/CUGyHLRZgbWSzuDN7FxG
         SULgPa6niSG7KalYUw12mkdJI7JPd7Aab00Qj9/FA2zRceUlPmh1fbU6/KCUnLhi48
         Ab6tQFvwDp2QMOxk/obDdaq10jmjvSKdCrDfT5a4UtIik0dQm6fOd91+9twN1qg9cp
         o+lBoWIb5CjuO4HA7oSUhty2FPJuiCt0xUFq89LkB5D0cx6nObM0cLQ6e2afk53MEv
         lrFYWFeVizQEoBrFUMuDWCxEUGLRccHcALp0f7hls8+JW4gp62ZoTVgsfq7YdOu2EO
         p9F/c+9wgzoZA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l-Q4M1i5kcVy; Fri, 18 Aug 2023 16:15:50 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id D1DCC6015E;
        Fri, 18 Aug 2023 16:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692368149; bh=Xbc6XW4VWVtR9wErQmGFD6fByVw59afmAS8OjaUawv8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=sRYXzmKTQBzyA1jzCsvb4G7pva4D3kxwe19L3V8jTDjPuM1OVYZN3IbQcRQadzzWe
         tVI7m+XHgJ42Mt9cD30OlhN1gh8cslNJ+X2t1V4KZgcubsMcCHtSx9YGQj5G6d8Qs0
         QhXRMTckn0DPA0JKv1Md+O0Y16Godm2cgCTomOePwxpGu39n2Ypq8puCqt5afvYuvK
         XWZRNfjl/ucj/19EJtcb4gTErQORO1QfrgDIetl68utvG0msN1HpI3nZ9pCeOxGBNr
         Oc75q1shqP/sM4J8x3KZCWOIsOCR7q7ZV+ALLVxdVFH8lyP1i1EI3thcw7f2Q3IyJd
         32Usonyi4WZpw==
Message-ID: <3993c468-fdac-2ff2-c3ee-9784c098694c@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 16:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in tick_nohz_idle_stop_tick /
 tick_nohz_next_event
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
References: <40ac9903-469a-b1ea-4339-8b06f855450e@alu.unizg.hr>
In-Reply-To: <40ac9903-469a-b1ea-4339-8b06f855450e@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 21:32, Mirsad Todorovac wrote:
> Hi,
> 
> This is your friendly bug reporter. :-)
> 
> The environment is the vanilla torvalds kernel on Ubuntu 22.04 LTS and a Ryzen 7950X assembled box.
> 
> [ 7145.500079] ==================================================================
> [ 7145.500109] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event
> 
> [ 7145.500139] write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 26:
> [ 7145.500155]  tick_nohz_idle_stop_tick+0x3b1/0x4a0
> [ 7145.500173]  do_idle+0x1e3/0x250
> [ 7145.500186]  cpu_startup_entry+0x20/0x30
> [ 7145.500199]  start_secondary+0x129/0x160
> [ 7145.500216]  secondary_startup_64_no_verify+0x17e/0x18b
> 
> [ 7145.500245] read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16:
> [ 7145.500261]  tick_nohz_next_event+0xe7/0x1e0
> [ 7145.500277]  tick_nohz_get_sleep_length+0xa7/0xe0
> [ 7145.500293]  menu_select+0x82/0xb90
> [ 7145.500309]  cpuidle_select+0x44/0x60
> [ 7145.500324]  do_idle+0x1c2/0x250
> [ 7145.500336]  cpu_startup_entry+0x20/0x30
> [ 7145.500350]  start_secondary+0x129/0x160
> [ 7145.500367]  secondary_startup_64_no_verify+0x17e/0x18b
> 
> [ 7145.500392] value changed: 0x0000001a -> 0xffffffff
> 
> [ 7145.500411] Reported by Kernel Concurrency Sanitizer on:
> [ 7145.500421] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
> [ 7145.500439] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [ 7145.500449] ==================================================================
> 
> Please find dmesg log (what was available in the ring buffer) and the lshw output attached.
> 
> NOTE: There are no proprietary drivers loaded and Canonical livepatch isn't working for this kernel,
> probably previous ACPI KCSAN BUGs turn this taint on.
> 
> Thank you very much for your time evaluating this report.

P.S.

According to Mr. Heo, I will add the decoded stacktrace to this bug report, which ought to have been done
in the first place :-/

[ 7145.500079] ==================================================================
[ 7145.500109] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event

[ 7145.500139] write to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 26:
[ 7145.500155] tick_nohz_idle_stop_tick (kernel/time/tick-sched.c:904 kernel/time/tick-sched.c:1130)
[ 7145.500173] do_idle (kernel/sched/idle.c:215 kernel/sched/idle.c:282)
[ 7145.500186] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
[ 7145.500199] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
[ 7145.500216] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:441)

[ 7145.500245] read to 0xffffffff8a2bda30 of 4 bytes by task 0 on cpu 16:
[ 7145.500261] tick_nohz_next_event (kernel/time/tick-sched.c:868)
[ 7145.500277] tick_nohz_get_sleep_length (kernel/time/tick-sched.c:1250)
[ 7145.500293] menu_select (drivers/cpuidle/governors/menu.c:283)
[ 7145.500309] cpuidle_select (drivers/cpuidle/cpuidle.c:359)
[ 7145.500324] do_idle (kernel/sched/idle.c:208 kernel/sched/idle.c:282)
[ 7145.500336] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
[ 7145.500350] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
[ 7145.500367] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:441)

[ 7145.500392] value changed: 0x0000001a -> 0xffffffff

[ 7145.500411] Reported by Kernel Concurrency Sanitizer on:
[ 7145.500421] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
[ 7145.500439] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 7145.500449] ==================================================================

The code seems to be:


	/*
	 * If this CPU is the one which updates jiffies, then give up
	 * the assignment and let it be taken by the CPU which runs
	 * the tick timer next, which might be this CPU as well. If we
	 * don't drop this here the jiffies might be stale and
	 * do_timer() never invoked. Keep track of the fact that it
	 * was the one which had the do_timer() duty last.
	 */
	if (cpu == tick_do_timer_cpu) {
		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
→		ts->do_timer_last = 1;
	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
		ts->do_timer_last = 0;
	
	}

but I am not sure why this happens.

Maybe a WRITE_ONCE(ts->do_timer_last, 1) is required?

Or is it another KCSAN false positive ...

Thank you very much for investigating.

Best regards,
Mirsad Todorovac
