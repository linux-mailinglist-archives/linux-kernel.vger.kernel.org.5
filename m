Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9B7D5085
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjJXNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjJXNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:00:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC650CC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:00:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698152415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAs+dZhqviNwhuty5f5iZ2Rj518ZIbs/mK+zgASFkLI=;
        b=fPfLjZHP3lgNrAqpiCwbQCA9aZ17o0Nw9H9+JpmE06vfQQTlwg1Ay/zhQXFmELg+GOXxYH
        TWNuA4KfSXqvl5n8P1T6L/ox8aHRIgs6P2lQYBacf7kHjOtO0j9q//JX0k40cwfEkNMgX6
        Zj9TB7dK5+2dke1vfLfbiRDfPv/QrDOYlDpKbLFu0Fo4nHBuvBTUNsw8cXlzJFmyaXaEgD
        X6LwNSBygZb7TUVDGnQujc+7s1A2exxylkm4ks2rBDStFDf7zno85Sgqc+048EOXZFhZ+Z
        mWqq9yRHqkr+yvJ6UVShXCmTKO+k9G1S4VkYn5YmKR2oZgVvt14XVU4XyHdoww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698152415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAs+dZhqviNwhuty5f5iZ2Rj518ZIbs/mK+zgASFkLI=;
        b=wqPBT9yfQ9z3DxqK7excmvzPl7wk1x0IycFwqTawhbZl7gMoIq8HPPQpWdi1s88PFZi93e
        CGfHOaTlBH6qL4DA==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        paulmck@kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
In-Reply-To: <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
 <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
 <87r0lq3j2t.ffs@tglx>
 <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
Date:   Tue, 24 Oct 2023 15:00:15 +0200
Message-ID: <871qdkch0g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19 2023 at 23:26, Tetsuo Handa wrote:
> On 2023/10/19 21:14, Thomas Gleixner wrote:
>> Maybe because of this:
>>>>> (This environment is Oracle VM VirtualBox on Windows 11 host.)
>
> I don't think that I'm the only user running Linux on Oracle VM VirtualBox on Windows. ;-)
>
>> So you could boot with "nosmp clocksource=acpi_pm" on the command line
>> and compare that against a "nosmp" boot.
>
> This did not make much difference.

Interesting. Can you please tell what the replacement clocksource is
when the TSC is disabled?

> Just for testing, I booted several Fedora/Ubuntu kernels used by installation ISO image.
> 5.11 / 6.0 / 6.6 Fedora kernels all showed this problem. On the other hand, 5.15 Ubuntu
> kernel does not show this problem. Thus, I'd rather suspect kernel config dependent
> problem than platform dependent problem.
>
> Fedora-Everything-netinst-x86_64-Rawhide-20231018.n.0.iso
> [    0.000000] Linux version 6.6.0-0.rc6.47.fc40.x86_64 (mockbuild@65b4f242683a45f6bd4621fe8c018a9d) (gcc (GCC) 13.2.1 20231011 (Red Hat 13.2.1-4), GNU ld version 2.41-7.fc40) #1 SMP PREEMPT_DYNAMIC Mon Oct 16 13:34:35 UTC 2023
>
> Fedora-Server-netinst-x86_64-37-1.7.iso
> [    0.000000] Linux version 6.0.7-301.fc37.x86_64 (mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 12.2.1 20220819 (Red Hat 12.2.1-2), GNU ld version 2.38-24.fc37) #1 SMP PREEMPT_DYNAMIC Fri Nov 4 18:35:48 UTC 2022
>
> Fedora-Everything-netinst-x86_64-34-1.2.iso
> [    0.000000] Linux version 5.11.12-300.fc34.x86_64 (mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.0.1 20210324 (Red Hat 11.0.1-0), GNU ld version 2.35.1-41.fc34) #1 SMP Wed Apr 7 16:31:13 UTC 2021
>
> ubuntu-22.04.3-live-server-amd64.iso
> [    0.000001] kvm-clock: using sched offset of 33909880646 cycles
> [    0.000004] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns

Are the others using kvm-clock too? I haven't seen that in the snippets
you provided before.

Thanks,

        tglx


