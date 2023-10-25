Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E27D76D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjJYV24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjJYV2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:28:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CF13A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:28:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698269329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHFdWMwG0XVuYrxA+jwJ42IxuazTn1f6p7yKyhmvV24=;
        b=3lO5enIHh8k7pYmLbb0kY3fdO8UO2uTxi2yln4VPdF/8yfLHarDilrkmpMHraOYDMluPzt
        uyoV+762mykRmE8+ujAK5GXAZEBvXkY/cbN9bVziCcVoucQY15DwlBW7yAyfU5VsbZG52N
        tPhWQ9/O0w6l3mfd5L1FjT15HmztPXZaMW0aD6tlsSsUncVb+q/VlWGXZ05l8ER0ys7Ewy
        Cbi6Mh2dDdRoiSWdnbgWkyb1ErOOAj10P7CP/UMVCBCNqwPfZHE9wdvFUHC9bhQvCb8n6t
        nNMU402hLRLtP0NciTrM+zpjwiJkb7VTFpaU9x242TPz2k76z7TTQ7zjES9wBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698269329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHFdWMwG0XVuYrxA+jwJ42IxuazTn1f6p7yKyhmvV24=;
        b=TTrjR1pUB0hW+MQqaw9ASgeFw0FupXbsY1VWK9SHLasLeMqxISdb8daC54ZB9ouvV+ujdJ
        7aIMRE5YqY1ck0DQ==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        paulmck@kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
In-Reply-To: <a1f1ec27-169a-4853-84d0-7d67d62a7741@I-love.SAKURA.ne.jp>
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
Date:   Wed, 25 Oct 2023 23:28:49 +0200
Message-ID: <8734xy5r3i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24 2023 at 23:52, Tetsuo Handa wrote:

> On 2023/10/24 22:00, Thomas Gleixner wrote:
>> Interesting. Can you please tell what the replacement clocksource is
>> when the TSC is disabled?
>
> Where can I find the replacement clocksource from?

/sys/kernel/devices/system/clocksource/clocksource0/active_clocksource

but I already figured it out. It selects kvm_clock as fallback, but that
happens way later. At that point during AP bringup timekeeping is still
based on jiffies. So that TSC unstable marking is not an issue
vs. timekeeping.

I have no idea what the kernel, VirtualPox or Windoze are doing during
that time. I fear you need to add some debug on your own or if
VirtualPox has a monitor/debugger you might use that to inspect what the
guest is doing.

Thanks,

        tglx
