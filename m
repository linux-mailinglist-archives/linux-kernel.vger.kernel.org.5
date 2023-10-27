Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BAD7D9CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346317AbjJ0PSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346302AbjJ0PSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:18:47 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A065196
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:18:44 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39RFIfM4034570;
        Sat, 28 Oct 2023 00:18:41 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sat, 28 Oct 2023 00:18:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39RFIWlw034540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 28 Oct 2023 00:18:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d71643eb-9373-44ad-93ce-ecb42a62e074@I-love.SAKURA.ne.jp>
Date:   Sat, 28 Oct 2023 00:18:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
To:     Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
 <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
 <87r0lq3j2t.ffs@tglx>
 <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
 <871qdkch0g.ffs@tglx>
 <a1f1ec27-169a-4853-84d0-7d67d62a7741@I-love.SAKURA.ne.jp>
 <8734xy5r3i.ffs@tglx>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <8734xy5r3i.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/26 6:28, Thomas Gleixner wrote:
> I have no idea what the kernel, VirtualPox or Windoze are doing during
> that time. I fear you need to add some debug on your own or if
> VirtualPox has a monitor/debugger you might use that to inspect what the
> guest is doing.

Although VirtualBox has a debugger
( https://www.virtualbox.org/manual/ch12.html#ts_debugger ), I'm not familiar enough
to use it; I'd like to debug from the guest side.

I found a minimal kernel config.
Changing https://I-love.SAKURA.ne.jp/tmp/config-6.6-rc7-ok from CONFIG_HZ=250
to CONFIG_HZ=1000 likely reproduces this slowdown problem. This difference
explains that this problem is timing-dependent; something unexpected event is
happening while bringing up secondary CPUs.

Fedora kernels have CONFIG_HZ=1000 and Ubuntu kernels have CONFIG_HZ=250.
I guess that changing CONFIG_HZ value is nothing special from the point of
view of hypervisors and host OS.

Can somebody reproduce this problem using different hypervisors and host OS?
You can try whether booting e.g. Fedora-Everything-netinst-x86_64-Rawhide-20231018.n.0.iso ,
Fedora-Server-netinst-x86_64-37-1.7.iso , Fedora-Everything-netinst-x86_64-34-1.2.iso etc. with
"nosmp" option added reaches GUI installer screen much faster than booting these ISO images
without adding "nosmp" option. Alternatively, you can also build a vanilla kernel using
config-6.6-rc7-ok with CONFIG_HZ changed from 250 to 1000, and boot that kernel like
a bare kernel command line shown below.

Trying

  /usr/libexec/qemu-kvm -m 4096 -smp 8 -nographic -append 'console=ttyS0,115200n8 panic=1' -no-reboot -kernel /boot/vmlinuz-6.6.0-rc7+

using qemu-kvm 1.5.3-175.el7_9.6.x86_64 on kernel 3.10.0-1160.102.1.el7.x86_64
on a physical host PC cannot reproduce this problem.

But trying

  /usr/bin/qemu-system-x86_64 -m 4096 -smp 8 -nographic -append 'console=ttyS0,115200n8 panic=1' -no-reboot -kernel /boot/vmlinuz-6.6.0-rc7+

using qemu-system-x86 1:6.2+dfsg-2ubuntu6.15 on kernel 5.15.0-87-generic
on VirtualBox on Windows 11 reproduces similar slowdown (and 5.15.0-87-generic
kernel sometimes emits soft lockup messages).

Thus, someone might be able to reproduce this problem on a nested virtualization
environment.

