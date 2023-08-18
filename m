Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D76780E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377733AbjHROcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377092AbjHRObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:31:50 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F57E2D70
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:31:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BB95660174;
        Fri, 18 Aug 2023 16:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692369107; bh=BMp7xRUWzvDehMOJ5qB0S8iUMadN3FakGzbF7poFR1k=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Rk3SjFAN7CojbVRslxwPgeiriictbJmh9aw/Bkik5MyiJ423WgDrueHg5bsXbjX0w
         bcRJ7Xwh9mUWsuId7KlEPanKIAcCDFdDoNp+SLpCsPU8/dbZDDRzVGmHxAoDLw7bKN
         tMhaz1wAd5Ogzq39plQ/v7Q2OvzfUMwl/sMZXAItS9XRsr20Zs7+seEAVCx/Se9uCm
         voHd8kl+BSYnDGZASdskYSkq3KsafCk+eNsOZDjbJIDcseJTEclnWJ1Pg1wqNj8sh8
         TIKF/x64rn+9fjlwhNZyDz/thONbLJ9sn2ZqEWTMi9X46lpv/UvbNoiUnzwmeVtTDu
         b/5cySk8twRgQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g11RhbmIk3vJ; Fri, 18 Aug 2023 16:31:44 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 0F3586015E;
        Fri, 18 Aug 2023 16:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692369104; bh=BMp7xRUWzvDehMOJ5qB0S8iUMadN3FakGzbF7poFR1k=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Ag667nQ+QgXOHZzsAwrzAflK804Wpp2lpxWXMEcqlo6XumARZzC2Udrw1PTHaTxJx
         wOjMXD+7pm0pQOmgLSlD8UMRGao8SOEdnmI+JMI+PtwD69tKYhKqvxwf4t5xpMTdaq
         0e4qY6YiBUXMA95Gs64h1RQAiUXMUqgpU72XtxtCnykETzTn/QJtMB+Wjx2dM8LA0N
         YPWn2iLdvF52uMyEITFihXnuSLSMRoJsEkCePQjyPQ/yU1vDkjb29nTkE5e1cW4AQX
         Ft5IJPGatJq55Wo+NxljkiPpTHkgtcGjvSK0CC2qlXTgefiPOt0fPStG7vhYxyMqc8
         uiSG+ZU0gJ4RA==
Message-ID: <7ecf5316-44b8-e4ce-55d5-a5bec38f4c8a@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 16:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in _find_next_bit+0x42/0xf0
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <451b3195-0f5b-f4bd-ce14-8b66c834b18b@alu.unizg.hr>
In-Reply-To: <451b3195-0f5b-f4bd-ce14-8b66c834b18b@alu.unizg.hr>
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



On 8/17/23 22:29, Mirsad Todorovac wrote:
> Hi,
> 
> This is your friendly bug reporter :-)
> 
> This is probably the last one for today from the KCSAN series.
> 
> The setup is vanilla torvalds kernel, Ubuntu 22.04 LTS and a Ryzen 7950X box.
> 
> NOTE: There are no proprietary modules to my knowledge, the Canonical Livepatch did not work for this
> kernel, but I suspect the taint was turned on by the previous instances of bugs.
> 
> Please find complete dmesg output and lshw output attached.
> 
> dmesg output except:
> 
> [10026.864497] ==================================================================
> [10026.864516] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0
> 
> [10026.864544] race at unknown origin, with read to 0xffff9b7440075408 of 8 bytes by interrupt on cpu 0:
> [10026.864562]  _find_next_bit+0x42/0xf0
> [10026.864577]  _nohz_idle_balance.isra.0+0x1ff/0x3f0
> [10026.864594]  run_rebalance_domains+0x75/0x90
> [10026.864610]  __do_softirq+0xda/0x330
> [10026.864626]  __irq_exit_rcu+0x75/0xa0
> [10026.864640]  irq_exit_rcu+0xe/0x20
> [10026.864654]  sysvec_call_function_single+0x96/0xb0
> [10026.864671]  asm_sysvec_call_function_single+0x1b/0x20
> [10026.864690]  cpuidle_enter_state+0x1df/0x520
> [10026.864709]  cpuidle_enter+0x41/0x70
> [10026.864725]  call_cpuidle+0x23/0x60
> [10026.864742]  do_idle+0x1f1/0x250
> [10026.864754]  cpu_startup_entry+0x20/0x30
> [10026.864767]  rest_init+0x121/0x140
> [10026.864786]  arch_call_rest_init+0xe/0x30
> [10026.864803]  start_kernel+0x8e3/0xd70
> [10026.864819]  x86_64_start_reservations+0x18/0x30
> [10026.864835]  x86_64_start_kernel+0xc0/0x110
> [10026.864848]  secondary_startup_64_no_verify+0x17e/0x18b
> 
> [10026.864876] value changed: 0x00000000ffffffcf -> 0x00000000ffffffff
> 
> [10026.864897] Reported by Kernel Concurrency Sanitizer on:
> [10026.864908] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G             L     6.5.0-rc6-net-cfg-kcsan-00038-g16931859a650 #35
> [10026.864926] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [10026.864936] ==================================================================

P.S.

By Mr. Heo's instructions, I am adding the decoded stacktrace to this bug report, which ought to have been
done in the first place.

Apology for the inconvenience.

[ 1092.112020] ==================================================================
[ 1092.112039] BUG: KCSAN: data-race in _find_next_bit (lib/find_bit.c:133 (discriminator 2))

[ 1092.112068] race at unknown origin, with read to 0xffff963d80075a38 of 8 bytes by interrupt on cpu 0:
[ 1092.112086] _find_next_bit (lib/find_bit.c:133 (discriminator 2))
[ 1092.112102] _nohz_idle_balance.isra.0 (./include/linux/find.h:430 kernel/sched/fair.c:11676)
[ 1092.112119] run_rebalance_domains (kernel/sched/fair.c:11969)
[ 1092.112136] __do_softirq (kernel/softirq.c:553)
[ 1092.112152] __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
[ 1092.112167] irq_exit_rcu (kernel/softirq.c:647)
[ 1092.112181] sysvec_call_function_single (arch/x86/kernel/smp.c:287 (discriminator 14))
[ 1092.112198] asm_sysvec_call_function_single (./arch/x86/include/asm/idtentry.h:653)
[ 1092.112218] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
[ 1092.112238] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
[ 1092.112254] call_cpuidle (kernel/sched/idle.c:135)
[ 1092.112271] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
[ 1092.112284] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
[ 1092.112298] rest_init (./include/linux/cpumask.h:1058 init/main.c:700)
[ 1092.112311] arch_call_rest_init+0xe/0x30
[ 1092.112326] start_kernel (init/main.c:833 init/main.c:909)
[ 1092.112340] x86_64_start_reservations (arch/x86/kernel/head64.c:544)
[ 1092.112356] x86_64_start_kernel (arch/x86/kernel/head64.c:486 (discriminator 17))
[ 1092.112368] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:441)

[ 1092.112388] value changed: 0x00000000fbffffff -> 0x00000000fbfffffd

[ 1092.112402] Reported by Kernel Concurrency Sanitizer on:
[ 1092.112410] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G             L     6.5.0-rc6+ #44
[ 1092.112422] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 1092.112429] ==================================================================

I should probably take a break while this is being investigated.

Best regards,
Mirsad Todorovac
