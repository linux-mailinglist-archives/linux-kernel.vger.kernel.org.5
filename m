Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC17CF427
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjJSJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJSJhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:37:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10410F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:37:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fb85afef4so6426697b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697708234; x=1698313034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awj7wMe6gx6IwxWOpFiO1v5L8v3ns3k0pq59JgIeOXY=;
        b=ktmpFYtFY3ltB401rGn6J3UGiJB27snYBoVy8DyoA+tvBOcsj8m2orgmmNDrHxBAg3
         1bacx/ruy+Y2NGbcc8NahJ0yH8MHFzGVjz4jReOd34C9st/u5ssQKkS8WpevrJ4VKYBz
         4zPZXHmq6a1tOoRIFpQUQyfwyZFOuK/hn998fwgz38q/v9EN2BgmZW4YfodWLS9cel8z
         Qn4c8fudulCUSDTSCAHeZA+oCraoDNgcduF0/Chg6s7PkR8f/vzzt2f6qEL+TYq9C5R8
         YOISq/8/8+7CLdH91Yn58rnxrbbrlY2xIY6norlf9En3/PHn7iXT2maWPzXbgs8in8Sz
         EtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697708234; x=1698313034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awj7wMe6gx6IwxWOpFiO1v5L8v3ns3k0pq59JgIeOXY=;
        b=weKwEk6eMWxXECfdFw8Q1FnOIkOd5GqJ7bEJjaI1gSNIe1Hvcg9eI1mb2XtGQ/+xNH
         wYu+0redappSFKCblS8b+Qlpwloa4WaytVDIfmd6y2u1V/Xi2HjIpeCZUIO4IZjoydVS
         /A9kCygZ2d4dv4gnrSQNoiZx5ha+iR0n9iu1XEBlJF5UxWLkpuMYEefi1M/76gVACMSK
         icJlUwnYJovgFyfq1mkuXxkTyRZu5JiCoWDBrDdJHY9GU/3cC2YURe+XViRFpVplZSR3
         HBsQ48re0mv5GcvjTTA3PBRnAH1ndK28beAsNWA7hpgzVDTHOWeFXtuymMuzCfulIkRr
         Whnw==
X-Gm-Message-State: AOJu0Yz+9lV+Qwzz1Eoy6Tr5W4/aBaSDhv7MQobsrbv81T3KRBWCLqgW
        2YXFlxcOGY46RGhAYww9pncxomkjiYvK0A==
X-Google-Smtp-Source: AGHT+IHFdFbUTFON3kz2eEWhODXINGlc0ClXxAhBZ2DAhSnf+HnzzxhxGgiqKoVZTZ+PO8kwZGv3DA==
X-Received: by 2002:a05:6a00:1a90:b0:69b:5395:59a8 with SMTP id e16-20020a056a001a9000b0069b539559a8mr1693771pfv.34.1697708233903;
        Thu, 19 Oct 2023 02:37:13 -0700 (PDT)
Received: from MacBook-Pro-3.local ([111.108.111.134])
        by smtp.gmail.com with ESMTPSA id g23-20020aa796b7000000b006b73af176c7sm4695148pfk.157.2023.10.19.02.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 02:37:12 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:37:05 +0800
From:   Wei Gong <gongwei833x@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] genirq: avoid long loops in handle_edge_irq
Message-ID: <ZTD4wYKQeCtme00C@MacBook-Pro-3.local>
References: <20230928100638.42116-1-gongwei833x@gmail.com>
 <87r0m3q32t.ffs@tglx>
 <ZSf3KrAk8fpyNEZr@MacBook-Pro-3.local>
 <877cnqlxmz.ffs@tglx>
 <ZTDUiXnb_Sn-5bT2@MacBook-Pro-3.local>
 <87zg0f2eyd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg0f2eyd.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Thu, Oct 19, 2023 at 10:28:58AM +0200, Thomas Gleixner wrote:
> On Thu, Oct 19 2023 at 15:02, Wei Gong wrote:
> > O Fri, Oct 13, 2023 at 10:44:36AM +0200, Thomas Gleixner wrote:
> >> > By maintaining the original loop exit condition, if a mask mismatch is 
> >> > detected within the loop, we will not perform the unmask_irq operation. 
> >> > Instead, we will wait until the loop exits before executing unmask_irq.
> >> > Could this approach potentially solve the issue of lost interrupts?
> >> 
> >> How so exactly?
> >> 
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index 8f8f1d62f..b846659ce 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -823,7 +823,9 @@ void handle_edge_irq(struct irq_desc *desc)
> >  		 */
> >  		if (unlikely(desc->istate & IRQS_PENDING)) {
> >  			if (!irqd_irq_disabled(&desc->irq_data) &&
> > -			    irqd_irq_masked(&desc->irq_data))
> > +			    irqd_irq_masked(&desc->irq_data) &&
> > +			    cpumask_test_cpu(smp_processor_id(),
> > +				    irq_data_get_effective_affinity_mask(&desc->irq_data)))
> >  				unmask_irq(desc);
> >  		}
> >  
> > @@ -832,6 +834,10 @@ void handle_edge_irq(struct irq_desc *desc)
> >  	} while ((desc->istate & IRQS_PENDING) &&
> >  		 !irqd_irq_disabled(&desc->irq_data));
> >  
> > +if (!irqd_irq_disabled(&desc->irq_data) &&
> > +    irqd_irq_masked(&desc->irq_data))
> > +	unmask_irq(desc);
> 
> What is this supposed to solve? The last interrupt has been delivered
> already. It's the one which sets the PENDING bit.
> 
> Again:
> 
>     CPU 0                                CPU 1
> 
>     interrupt #1
> 	 set IN_PROGRESS
> 	 do {
> 					 change_affinity_to(CPU1);
> 	    handle_irq_event()
> 		 ack_in_device(interrupt #1)
> 
> 					 interrupt #2
> 					    set PENDING
>                                             mask();
> 	 } while (COND)
> 
>          unmask();
> 
> The unmask does not make the interrupt #2 magically reappear. This is
> edge, which is a fire and forget mechanism. That's why we have the
> PENDING bit logic for edge to ensure that no interrupt is lost.
> 
> With your change interrupt #2 is lost forever.
> 
> So if the device depends on ack_in_device() for being able to send the
> next interrupt, then the lack of ack_in_device() for interrupt #2 makes
> it stale.
> 
> It may well be that your particular device does not need the
> ack_in_device() sequence, but this is generic core code which has to
> work for everything.
> 
> I'm still having a hard time to understand why this is such a big
> issue at all. What's the practical impact of processing a bunch of
> interrupts on CPU0 after changing the affinity to CPU1?
> 
>   It's obviously suboptimal in terms of locality, but that's a temporary
>   problem which resolves itself. It's suboptimal, but correct behaviour.
> 
> Your attempts of "fixing" it at the core edge handler level result in a
> fundamental correctness problem.
> 
> There are certainly ways to solve it at that level, but for that you
> have to fully understand and accept the fundamental properties and
> intricacies of edge triggered interrupts in the first place.
> 
> Whether the resulting complexity is worth it, is a different
> question. As long as there is not a compelling reason to do so, the
> answer is simply no.
> 
> Thanks,
> 
>         tglx

I wholeheartedly concur with your viewpoint. 

The problem I'm facing is that when a multitude of interrupts are 
processed on CPU0, it results in CPU0 being extensively occupied.
This prevents it from addressing other tasks, thereby leading to a softlockup.

92266.035199] NMI backtrace for cpu 1
[92266.035200] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G
[92266.035201] RIP: 0010:native_queued_spin_lock_slowpath+0x5b/0x1d0
[92266.035203] Code: 6d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 
09 d0 a9 00 01 ff ff 75 47 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8
b8 01 00 00 00 66 89 07 c3 8b 37 81 fe 00 01 00
[92266.035203] RSP: 0018:ff6012b446364e78 EFLAGS: 00000002
[92266.035204] RAX: 0000000000000101 RBX: ff41817bd9738e00 RCX: 00000000ffffffff
[92266.035204] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff41817bd9738ea4
[92266.035205] RBP: ff41817bd9738ea4 R08: 00006cd77aeca1ca R09: 0000000000000000
[92266.035205] R10: 0000000000000000 R11: 0000000000000000 R12: ff41817bd9738e00
[92266.035206] R13: 0000000000000028 R14: 0000000000000000 R15: 0000000000000000
[92266.035206] FS:  0000000000000000(0000) GS:ff41818a49640000(0000) knlGS:0000000000000000
[92266.035206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[92266.035207] CR2: 00007f9592422220 CR3: 0000000dc3010006 CR4: 0000000000771ee0
[92266.035207] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[92266.035208] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[92266.035208] PKRU: 55555554
[92266.035208] Call Trace:
[92266.035208]  <IRQ>
[92266.035209]  _raw_spin_lock+0x1c/0x20
[92266.035209]  handle_edge_irq+0x19/0x190
[92266.035209]  handle_irq+0x1c/0x30
[92266.035210]  do_IRQ+0x49/0xd0
[92266.035210]  common_interrupt+0xf/0xf
[92266.035210] RIP: 0010:__do_softirq+0x72/0x2d6
[92266.035211] Code: 12 52 ff 65 81 05 b2 5b 81 75 00 01 00 00 c7 44 24 10 0a 00
00 00 48 c7 c0 80 99 02 00 65 66 c7 00 00 00 fb 66 0f 1f 44 00 00 <b8> ff ff ff
ff 48 c7 c3 00 61 20 8b 41 0f bc c7 89 c6 83 c6 01 89
[92266.035212] RSP: 0018:ff6012b446364f98 EFLAGS: 00000286 ORIG_RAX: ffffffffffffffd7
[92266.035212] RAX: 0000000000029980 RBX: 0000000000000000 RCX: 00000000ffffffff
[92266.035213] RDX: 00000000000000ed RSI: 0000000000000254 RDI: ffffffff8c601040
[92266.035213] RBP: 0000000000000000 R08: 00006cd740f1f9b6 R09: 0000000000000000
[92266.035214] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[92266.035214] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000080
[92266.035215]  ? common_interrupt+0xa/0xf
[92266.035215]  ? __do_softirq+0x4b/0x2d6
[92266.035215]  irq_exit+0xf7/0x100
[92266.035216]  reschedule_interrupt+0xf/0x20
[92266.035216]  </IRQ>
[92266.035216] RIP: 0010:native_safe_halt+0xe/0x10
[92266.035217] Code: ff ff 7f c3 65 48 8b 04 25 40 5c 01 00 f0 80 48 02 20 48 8b 00 a8
08 75 c4 eb 80 90 e9 07 00 00 00 0f 00 2d 76 9c 48 00 fb f4 <c3> 90 e9 07 00 00 00 0f
00 2d 66 9c 48 00 f4 c3 90 90 0f 1f 44 00
[92266.035217] RSP: 0018:ff6012b4462b7ea0 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff02
[92266.035218] RAX: ffffffff8a57fd80 RBX: 0000000000000001 RCX: 0000000000000000
[92266.035218] RDX: 000000000ab164e2 RSI: 0000000000000087 RDI: 0000000000000001
[92266.035219] RBP: 0000000000000001 R08: ff41818a4965d8a0 R09: 0000000000000000
[92266.035219] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffffffffff
[92266.035220] R13: 0000000000000000 R14: 0000000000000000 R15: ff41817bc6855ac0
[92266.035220]  ? __sched_text_end+0x7/0x7
[92266.035220]  default_idle+0xa/0x10
[92266.035221]  default_idle_call+0x40/0xf0
[92266.035221]  do_idle+0x1f4/0x260
[92266.035221]  cpu_startup_entry+0x6f/0x80
[92266.035221]  start_secondary+0x19b/0x1e0
[92266.035222]  secondary_startup_64_no_verify+0xc2/0xcb
[92266.035223] NMI backtrace for cpu 0
[92266.035223] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Tainted: G
[92266.035224] RIP: 0010:__pci_msix_desc_mask_irq+0x3b/0x40
[92266.035225] Code: f6 47 55 02 75 24 0f b7 57 56 c1 e2 04 48 63 d2 48 03 57 60
74 14 8b 47 50 83 e0 fe 89 c1 83 c9 01 83 e6 01 0f 45 c1 89 42 0c <c3> 0f 1f 40
00 0f 1f 44 00 00 53 48 8b 47 10 48 8b 58 10 f6 43 54
[92266.035225] RSP: 0018:ff6012b440003f80 EFLAGS: 00000046
[92266.035226] RAX: 0000000000000000 RBX: ff41817bc6ca3c00 RCX: 0000000000000001
[92266.035226] RDX: ff6012b4464a5020 RSI: 0000000000000000 RDI: ff41817bc6ca3c00
[92266.035226] RBP: ff41817bd9738ea4 R08: 000000000000da73 R09: 0000000000007ffe
[92266.035226] R10: 0000000000000068 R11: 000000000000004c R12: ff41817bd9738e00
[92266.035227] R13: 0000000000000024 R14: 0000000000000000 R15: 0000000000000000
[92266.035227] FS:  0000000000000000(0000) GS:ff41818a49600000(0000) knlGS:0000000000000000
[92266.035227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[92266.035227] CR2: 00007fcfde8a40c0 CR3: 0000000dc3010004 CR4: 0000000000771ef0
[92266.035228] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[92266.035228] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[92266.035228] PKRU: 55555554
[92266.035228] Call Trace:
[92266.035229]  <IRQ>
[92266.035229]  msi_set_mask_bit+0x1c/0x50
[92266.035229]  unmask_irq.part.42+0x1f/0x30
[92266.035229]  handle_edge_irq+0xdb/0x190
[92266.035229]  handle_irq+0x1c/0x30
[92266.035230]  do_IRQ+0x49/0xd0
[92266.035230]  common_interrupt+0xf/0xf
[92266.035230]  </IRQ>
[92266.035230] RIP: 0010:native_safe_halt+0xe/0x10
[92266.035231] Code: ff ff 7f c3 65 48 8b 04 25 40 5c 01 00 f0 80 48 02 20 48 8b 00
a8 08 75 c4 eb 80 90 e9 07 00 00 00 0f 00 2d 76 9c 48 00 fb f4 <c3> 90 e9 07 00 00
00 0f 00 2d 66 9c 48 00 f4 c3 90 90 0f 1f 44 00
[92266.035231] RSP: 0018:ffffffff8b203e80 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffdb
[92266.035231] RAX: ffffffff8a57fd80 RBX: 0000000000000000 RCX: ff41817bfb4f5058
[92266.035232] RDX: 000000005a65557a RSI: 0000000000000000 RDI: 000053e53530b240
[92266.035232] RBP: 0000000000000000 R08: 00006cce9cd00c88 R09: ff41817d0c085b40
[92266.035232] R10: 0000000000000007 R11: ff41817d9ad7505b R12: ffffffffffffffff
[92266.035233] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8b218840
[92266.035233]  ? __sched_text_end+0x7/0x7
[92266.035233]  default_idle+0xa/0x10
[92266.035233]  default_idle_call+0x40/0xf0
[92266.035234]  do_idle+0x1f4/0x260
[92266.035234]  cpu_startup_entry+0x6f/0x80
[92266.035234]  start_kernel+0x51d/0x53d
[92266.035234]  secondary_startup_64_no_verify+0xc2/0xcb
[92292.771711] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [swapper/1:0]

Thanks,

Wei Gong
