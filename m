Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF53976CBEA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjHBLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjHBLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:41:12 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD113E;
        Wed,  2 Aug 2023 04:41:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 153453FF30;
        Wed,  2 Aug 2023 13:41:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.998
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aIr3gQCPTGKz; Wed,  2 Aug 2023 13:41:07 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 93BDF3FAE4;
        Wed,  2 Aug 2023 13:41:06 +0200 (CEST)
Received: from [192.168.0.122] (port=54924)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <forza@tnonline.net>)
        id 1qRADx-0004U2-1a;
        Wed, 02 Aug 2023 13:41:06 +0200
Message-ID: <def244e8-d15e-359b-d3e1-1af892cfc483@tnonline.net>
Date:   Wed, 2 Aug 2023 13:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: default_enter_idle leaked IRQ state
Content-Language: sv-SE, en-GB
From:   Forza <forza@tnonline.net>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, a1bert@atlas.cz
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
 <fcf1d04.faed4a1a.18844d8e78f@tnonline.net> <ZGwcVTpQNBoJHBB+@debian.me>
 <ZGyVVQxnw6Tn7Xb8@pc636> <c9db92d.faed4a1c.1884c5550fb@tnonline.net>
 <20230524091357.GH32559@suse.cz> <ZHClGA9szxSqzDf8@pc636>
 <cf07f03.70397026.18918ef7f95@tnonline.net>
 <2063d59.8f9f4a3a.1892a3ec50f@tnonline.net>
 <7336b8ea-64bd-d08d-1d85-bf942d5660e2@leemhuis.info>
 <1d6d0b69-b243-d1a4-d538-d1be778a516a@tnonline.net>
In-Reply-To: <1d6d0b69-b243-d1a4-d538-d1be778a516a@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-07-07 12:13, Forza wrote:
> 
> 
> On 2023-07-06 12:54, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 06.07.23 10:08, Forza wrote:
>>>>> On Wed, May 24, 2023 at 11:13:57AM +0200, David Sterba wrote:
>>> [...]
>>> A small update.
>>
>> Thx for this.
>>
>>> I have been able test 6.2.16, all 6.3.x and 6.4.1 and they all show
>>> the same issue.
>>>
>>> I am now trying 6.1.37 since two days and have not been able to
>>> reproduce this issue on any of my virtual qemu/kvm machines. Perhaps
>>> this information is helpful in finding the root cause?
>>
>> That means it's most likely a regression between v6.1..v6.2 (or
>> v6.1..v6.2.16 if we are unlucky) somewhere (from earlier in the thread
>> it sounds like it might not be Btrfs).
> 
> Agreed, I do not think this specific bug (cpuidle /  default_enter_idle 
> leaked IRQ state) is Btrfs related. Some of the virtual machines I test 
> on do not use Btrfs.
>>
>> Which makes we wonder: how long do you usually need to reproduce the
>> issue? If it's not too long it might mean that a bisection is the best
>> way forward, unless some developer sits down and looks closely at the
>> logs. With a bit of luck some dev will do that; but if we are unlucky we
>> likely will need a bisection.
>>
> 
> It has varied. Sometimes immediately upon boot, but can take several 
> hours or a day before showing up.
> 
> 
> Also, I forgot to say I was basing my kernels on gentoo-kernels, which 
> has some patches against vanilla. Therefore I will I will compile a set 
> of vanilla kernels from 6.1.37 until 6.4.2 and run them in my testing 
> machines to see where the problem is happening.
> 
> This is not a fast system, so it will likely take several days. But I 
> will keep you posted.
> 
> Meanwhile, if you think of any specific kernel debug options, tracing, 
> etc, that I should enable, let me know
> 
> Should we change the Subject line of this email thread?

Have been running for a few weeks now. The earliest vanilla-kernel I 
have ben able to reproduce the issue with is 6.2.16, it only happened 
once over two weeks.

The issue still happens frequently on 6.4.x kernels. Here is the output 
from 6.4.7, and as you see happened only a few seconds after booting. 
This VM has only a minimal system installed:

# pstree
init-+-acpid
      |-crond
      |-dropbear---dropbear---bash---pstree
      |-2*[getty]
      |-qemu-ga---{qemu-ga}
      |-supervise-daemo---tgtd---16*[{tgtd}]
      |-syslogd
      |-udhcpc
      `-watchdog

# dmesg

[    4.328170][    T1] Run /sbin/init as init process
[    4.329279][    T1]   with arguments:
[    4.329282][    T1]     /sbin/init
[    4.329284][    T1]   with environment:
[    4.329286][    T1]     HOME=/
[    4.329288][    T1]     TERM=linux
[   11.540637][ T1992] Adding 1048572k swap on /dev/vda.  Priority:-2 
extents:1 across:1048572k DscFS
[   12.917894][    T0] ------------[ cut here ]------------
[   12.917907][    T0] default_enter_idle leaked IRQ state
[   12.918001][    T0] WARNING: CPU: 2 PID: 0 at 
drivers/cpuidle/cpuidle.c:269 cpuidle_enter_state+0x35f/0x510
[   12.918052][    T0] Modules linked in:
[   12.918064][    T0] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 
6.4.7-ksan-ubsan #1
[   12.918070][    T0] Hardware name: QEMU Standard PC (Q35 + ICH9, 
2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
[   12.918074][    T0] RIP: 0010:cpuidle_enter_state+0x35f/0x510
[   12.918088][    T0] Code: 89 c2 83 e2 01 3c 01 0f 87 b1 01 00 00 84 
d2 75 1d c6 05 ac bf 1f 02 01 90 49 8b 76 50 48 c7 c7 60 23 b1 ba e8 82 
ef ed fc 90 <0f> 0b 90 90 fa e9 36 fd ff ff 83 c2 01 48 83 c1 40 41 39 
d0 0f 8e
[   12.918093][    T0] RSP: 0018:ffffc9000015fd98 EFLAGS: 00010246
[   12.918112][    T0] RAX: 0000000000000000 RBX: ffffe8ffffd08c00 RCX: 
0000000000000000
[   12.918116][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[   12.918119][    T0] RBP: ffffffffbc39ae40 R08: 0000000000000000 R09: 
0000000000000000
[   12.918123][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000001
[   12.918125][    T0] R13: 0000000000000001 R14: ffffffffbc39aec0 R15: 
0000000000000000
[   12.918130][    T0] FS:  0000000000000000(0000) 
GS:ffff88806d100000(0000) knlGS:0000000000000000
[   12.918146][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.918150][    T0] CR2: 00007f8dbf5bc000 CR3: 000000000f880000 CR4: 
00000000003506e0
[   12.918154][    T0] Call Trace:
[   12.918156][    T0]  <TASK>
[   12.918160][    T0]  ? __warn+0xc9/0x240
[   12.918198][    T0]  ? cpuidle_enter_state+0x35f/0x510
[   12.918203][    T0]  ? report_bug+0x261/0x2c0
[   12.918219][    T0]  ? __pfx_default_enter_idle+0x10/0x10
[   12.918226][    T0]  ? handle_bug+0x3d/0x80
[   12.918234][    T0]  ? exc_invalid_op+0x13/0x50
[   12.918238][    T0]  ? asm_exc_invalid_op+0x16/0x20
[   12.918251][    T0]  ? cpuidle_enter_state+0x35f/0x510
[   12.918255][    T0]  ? cpuidle_enter_state+0x35e/0x510
[   12.918269][    T0]  ? tick_nohz_stop_tick+0x22c/0x660
[   12.918288][    T0]  cpuidle_enter+0x4a/0xb0
[   12.918294][    T0]  do_idle+0x31c/0x400
[   12.918304][    T0]  ? __pfx_do_idle+0x10/0x10
[   12.918308][    T0]  cpu_startup_entry+0x19/0x20
[   12.918311][    T0]  start_secondary+0x241/0x2d0
[   12.918323][    T0]  ? __pfx_start_secondary+0x10/0x10
[   12.918328][    T0]  secondary_startup_64_no_verify+0xf4/0xfb
[   12.918338][    T0]  </TASK>
[   12.918339][    T0] ---[ end trace 0000000000000000 ]---


kernel-6.4.7-config: 
https://paste.tnonline.net/files/A1IHEUjgCh8Y_config-6.4.7.txt
kernel-6.4.7-dmesg: 
https://paste.tnonline.net/files/YP11KEMpKXAI_dmesg-6.4.7.txt

~Forza

>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> -- 
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
