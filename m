Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4853B7AB082
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjIVLWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:22:13 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E24AC;
        Fri, 22 Sep 2023 04:22:03 -0700 (PDT)
Received: from [192.168.1.215] (unknown [122.172.83.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 15E33161CB4;
        Fri, 22 Sep 2023 13:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1695381720; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ojj9etzDaC5EV1Z4YZ0pUkwqSiZRleEiS16sMRmYFpM=;
        b=e94AlDA0DDtl9tfN8qv7+o85cWHA9Y3eJwGIxAvh47xgSV11AZPJxLCnc2ZET77BZm6qYv
        xlrhZt6E5c2yqednC60JhaKBtBWmJijyOkojhzhJlRr+/Z9OqZuyNnQOdrNPeMBBEqphZw
        7CaDNGZDYXHO2/58vV++WvscGPpg4M4=
Message-ID: <2467f0fa-94ec-4449-8d7d-765e996dece7@ixit.cz>
Date:   Fri, 22 Sep 2023 16:51:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     paulmck@kernel.org
Cc:     ardb@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com, jpoimboe@kernel.org, jstancek@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, ltp@lists.linux.it,
        mark.rutland@arm.com, peterz@infradead.org, rcu@vger.kernel.org,
        robin.murphy@arm.com, rostedt@goodmis.org, will@kernel.org
References: <6e2ee0ca-cf37-42ec-8dc6-593d831eb262@paulmck-laptop>
Subject: Re: [LTP] arm64: Unable to handle kernel execute from non-executable
 memory at virtual address ffff8000834c13a0
Content-Language: en-US
Reply-To: 6e2ee0ca-cf37-42ec-8dc6-593d831eb262@paulmck-laptop
From:   David <david@ixit.cz>
In-Reply-To: <6e2ee0ca-cf37-42ec-8dc6-593d831eb262@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On sdm845 cheza board, with 6.5.4 (before running 6.4.x), I saw this 
issue too. Happened only once, but I can try stress-test it how often it 
pops up.
Whole log is here [1]. Used kernel is referenced from full log, kernel 
extra patches [2].

...
23-09-22 10:48:53 R SERIAL-CPU> deviceName: Turnip Adreno (TM) 630
23-09-22 10:48:55 R SERIAL-CPU> Running dEQP on 8 threads in 500-test groups
23-09-22 10:48:57 R SERIAL-CPU> Running dEQP on 8 threads in 500-test groups
23-09-22 10:49:00 R SERIAL-CPU> Running dEQP on 8 threads in 500-test groups
23-09-22 10:49:03 R SERIAL-CPU> Running dEQP on 8 threads in 188-test groups
23-09-22 10:49:05 R SERIAL-CPU> Running dEQP on 8 threads in 10-test groups
23-09-22 10:49:08 R SERIAL-CPU> Running dEQP on 8 threads in 378-test groups
23-09-22 10:49:10 R SERIAL-CPU> Running dEQP on 8 threads in 500-test groups
23-09-22 10:49:10 R SERIAL-CPU> Pass: 0, Duration: 0
23-09-22 10:49:28 R SERIAL-CPU> ERROR - dEQP error: SPIR-V WARNING:
23-09-22 10:49:28 R SERIAL-CPU> ERROR - dEQP error:     In file 
../src/compiler/spirv/spirv_to_nir.c:1492
23-09-22 10:49:28 R SERIAL-CPU> ERROR - dEQP error:     Image Type 
operand of OpTypeSampledImage should not have a Dim of Buffer.
23-09-22 10:49:28 R SERIAL-CPU> ERROR - dEQP error:     456 bytes into 
the SPIR-V binary
23-09-22 10:49:28 R SERIAL-CPU> Pass: 222, Skip: 278, Duration: 17, 
Remaining: 46:28
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error: SPIR-V WARNING:
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error:     In file 
../src/compiler/spirv/spirv_to_nir.c:4772
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error: Unsupported SPIR-V 
capability: SpvCapabilityUniformAndStorageBuffer16BitAccess (4434)
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error:     36 bytes into 
the SPIR-V binary
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error: SPIR-V WARNING:
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error:     In file 
../src/compiler/spirv/spirv_to_nir.c:4772
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error: Unsupported SPIR-V 
capability: SpvCapabilityUniformAndStorageBuffer16BitAccess (4434)
23-09-22 10:49:43 R SERIAL-CPU> ERROR - dEQP error:     36 bytes into 
the SPIR-V binary
23-09-22 10:49:43 R SERIAL-CPU> Pass: 1949, Skip: 2551, Duration: 32, 
Remaining: 9:15
23-09-22 10:49:44 R SERIAL-CPU> [   73.300176] Unable to handle kernel 
execute from non-executable memory at virtual address ffffaa213674cd88
23-09-22 10:49:44 R SERIAL-CPU> [   73.310124] Mem abort info:
23-09-22 10:49:44 R SERIAL-CPU> [   73.313003]   ESR = 0x000000008600000f
23-09-22 10:49:44 R SERIAL-CPU> [   73.316859]   EC = 0x21: IABT 
(current EL), IL = 32 bits
23-09-22 10:49:44 R SERIAL-CPU> [   73.322318]   SET = 0, FnV = 0
23-09-22 10:49:44 R SERIAL-CPU> [   73.325464]   EA = 0, S1PTW = 0
23-09-22 10:49:44 R SERIAL-CPU> [   73.328703]   FSC = 0x0f: level 3 
permission fault
23-09-22 10:49:44 R SERIAL-CPU> [   73.333628] swapper pgtable: 4k 
pages, 48-bit VAs, pgdp=0000000081b1c000
23-09-22 10:49:44 R SERIAL-CPU> [   73.340513] [ffffaa213674cd88] 
pgd=100000027ffff003, p4d=100000027ffff003, pud=100000027fffe003, 
pmd=100000027fff9003, pte=007800008274cf03
23-09-22 10:49:44 R SERIAL-CPU> [   73.353372] Internal error: Oops: 
000000008600000f [#1] PREEMPT SMP
23-09-22 10:49:44 R SERIAL-CPU> [   73.359808] Modules linked in:
23-09-22 10:49:44 R SERIAL-CPU> [   73.362954] CPU: 1 PID: 0 Comm: 
swapper/1 Tainted: G        W          6.5.4-g8a16969a8434 #1
23-09-22 10:49:44 R SERIAL-CPU> [   73.371705] Hardware name: Google 
Cheza (rev3+) (DT)
23-09-22 10:49:44 R SERIAL-CPU> [   73.376801] pstate: 20400009 (nzCv 
daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
23-09-22 10:49:44 R SERIAL-CPU> [   73.383944] pc : 
in_lookup_hashtable+0x538/0x2000
23-09-22 10:49:44 R SERIAL-CPU> [   73.388787] lr : rcu_core+0x250/0x640
23-09-22 10:49:44 R SERIAL-CPU> [   73.392559] sp : ffff80008000bec0
23-09-22 10:49:44 R SERIAL-CPU> [   73.395962] x29: ffff80008000bec0 
x28: ffffaa2134116b28 x27: ffffaa2136381840
23-09-22 10:49:44 R SERIAL-CPU> [   73.403289] x26: 000000000000000a 
x25: ffff266077371b38 x24: 0000000000000000
23-09-22 10:49:44 R SERIAL-CPU> [   73.410614] x23: 0000000000000003 
x22: ffff80008000bf30 x21: ffff266077371ac0
23-09-22 10:49:44 R SERIAL-CPU> [   73.417940] x20: ffff265f00190000 
x19: 0000000000000004 x18: 0000000000000000
23-09-22 10:49:44 R SERIAL-CPU> [   73.425266] x17: ffff7c3f416ea000 
x16: ffff800080008000 x15: 0000000000000000
23-09-22 10:49:44 R SERIAL-CPU> [   73.432593] x14: 0000000000000000 
x13: 0000000000000078 x12: 0000000000000000
23-09-22 10:49:44 R SERIAL-CPU> [   73.439920] x11: 0000000000000000 
x10: 0000000000000001 x9 : 0000000000000000
23-09-22 10:49:44 R SERIAL-CPU> [   73.447245] x8 : ffff80008000be50 x7 
: 0000000000000000 x6 : ffff266077371b48
23-09-22 10:49:44 R SERIAL-CPU> [   73.454571] x5 : ffffaa2134216444 x4 
: fffffc99800bcb20 x3 : ffffaa2135c8be78
23-09-22 10:49:45 R SERIAL-CPU> [   73.461902] x2 : ffff265f5d7ca700 x1 
: ffffaa213674cd88 x0 : ffff265f0773e3b0
23-09-22 10:49:45 R SERIAL-CPU> [   73.469231] Call trace:
23-09-22 10:49:45 R SERIAL-CPU> [   73.471751] 
in_lookup_hashtable+0x538/0x2000
23-09-22 10:49:45 R SERIAL-CPU> [   73.476235] rcu_core_si+0x10/0x1c
23-09-22 10:49:45 R SERIAL-CPU> [   73.479739] __do_softirq+0x10c/0x284
23-09-22 10:49:45 R SERIAL-CPU> [   73.483508] ____do_softirq+0x10/0x1c
23-09-22 10:49:45 R SERIAL-CPU> [   73.487276] call_on_irq_stack+0x24/0x4c
23-09-22 10:49:45 R SERIAL-CPU> [   73.491310] 
do_softirq_own_stack+0x1c/0x28
23-09-22 10:49:45 R SERIAL-CPU> [   73.495609] irq_exit_rcu+0xd8/0xf4
23-09-22 10:49:45 R SERIAL-CPU> [   73.499197] el1_interrupt+0x38/0x68
23-09-22 10:49:45 R SERIAL-CPU> [   73.502871] el1h_64_irq_handler+0x18/0x24
23-09-22 10:49:45 R SERIAL-CPU> [   73.507086] el1h_64_irq+0x64/0x68
23-09-22 10:49:45 R SERIAL-CPU> [   73.510587] 
cpuidle_enter_state+0x134/0x2e0
23-09-22 10:49:45 R SERIAL-CPU> [   73.514973] cpuidle_enter+0x38/0x50
23-09-22 10:49:45 R SERIAL-CPU> [   73.518648] do_idle+0x1f4/0x264
23-09-22 10:49:45 R SERIAL-CPU> [   73.521970] cpu_startup_entry+0x28/0x2c
23-09-22 10:49:45 R SERIAL-CPU> [   73.526005] 
secondary_start_kernel+0x130/0x150
23-09-22 10:49:45 R SERIAL-CPU> [   73.530660] 
__secondary_switched+0xb8/0xbc
23-09-22 10:49:45 R SERIAL-CPU> [   73.534965] Code: 00000000 00000000 
00000000 00000000 (0773e3b0)
23-09-22 10:49:45 R SERIAL-CPU> [   73.541226] ---[ end trace 
0000000000000000 ]---
23-09-22 10:49:45 R SERIAL-CPU> [   73.545975] Kernel panic - not 
syncing: Oops: Fatal exception in interrupt
23-09-22 10:49:45 R SERIAL-CPU> [   73.553032] SMP: stopping secondary CPUs
23-09-22 10:49:45 R SERIAL-CPU> [   73.557142] Kernel Offset: 
0x2a20b4000000 from 0xffff800080000000
23-09-22 10:49:45 R SERIAL-CPU> [   73.563396] PHYS_OFFSET: 
0xffffd9a200000000
23-09-22 10:49:45 R SERIAL-CPU> [   73.567687] CPU features: 
0x00000000,800140a1,8800721b
23-09-22 10:49:45 R SERIAL-CPU> [   73.572962] Memory Limit: none
23-09-22 10:49:45 R SERIAL-CPU> [   73.576106] ---[ end Kernel panic - 
not syncing: Oops: Fatal exception in interrupt ]---

David

[1] https://gitlab.freedesktop.org/mesa/mesa/-/jobs/49333832

[2] https://gitlab.freedesktop.org/gfx-ci/linux/-/commits/v6.5-for-mesa-ci/

