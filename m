Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D37B1249
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjI1GDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjI1GDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:03:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E009F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:03:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50336768615so21395199e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695881016; x=1696485816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JTXwSgZvIedjVBLF/u7wxA0QR3Df5ehqpCs3rBkC+E=;
        b=TxN++rnXPMD/FF1r0MHzHHCT7vUzxWrHricbgADluxJbTkaVu/bxkizXhWIdfz5809
         Lfks+ecpcX2LKUhWBruJtOOtDyviRFh2bx/p3CrZ34E/seslVI9HNfoH9FNbyheUrJdq
         GvppFX3/+cBu4lPHFS0SRoO10y10lhs6u4amCtoYO1HyH29a8kxHbwhe5ZSgv0WAq7sT
         WLmrJ5xm3HbVAfo6Kur0DMyVVqqWhTqWjiWwqoIAUKlHW33tJCLx4HnjK44KBPFgPA7d
         i420ZX1ddETawTMfHrCh9JHM5tm/NT6Nz/OZkj4L7lkln339Vz8L5GRDpFVn1nD5KOZl
         Xu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881016; x=1696485816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JTXwSgZvIedjVBLF/u7wxA0QR3Df5ehqpCs3rBkC+E=;
        b=pXicrLM7nSmId9vFxjoTsNhjAb4PIWx0VfVvTQi6w6Xj65BNeqto9N6B7Bpfcr1oAw
         pIg/nwAnQlpvYjjpg4Ye3xcidU0Q/O9l6cLC5BBvOm2MPuYlzrEwtc9/3KOU2k72lQqU
         WHbgdjKzHrxh6NEPy7P/hSzQUyXEKGeuzptTqa7oYrLvsG6v2LTNtnf24skalYCfznk2
         ufBerCr3eGgP1EGnr5ENpIzFgOSYqby6lgAtTR31xdeE5VM7ODXQv8mdHjSu06ToVnOU
         iRextjp9rFOKVnbWOTQlrqwFoefQLKuOM+F0Yv0DLUUTmClETjE1briovk1q3EOxxgAw
         eDpQ==
X-Gm-Message-State: AOJu0YyX3A9/Y8KPI//bxH/rNQQ/laKHHALTqJX+82VvYQQYKhp+Q8hK
        /DD9xshNQOvHtxu71RBVdSQG2XDLDEXwJI/IgXAt4A==
X-Google-Smtp-Source: AGHT+IHDe6fuXAUuV8OfF80ElHjrfrITPUFG5cdNrEGvjRLF9yiy0kyKcnhPJ5isinZV2U3iAucmLJbqpMdQkuWpxp4=
X-Received: by 2002:ac2:4e81:0:b0:500:771f:4887 with SMTP id
 o1-20020ac24e81000000b00500771f4887mr224008lfr.55.1695881015922; Wed, 27 Sep
 2023 23:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230927184158.243575-1-mirsad.todorovac@alu.unizg.hr> <0a201a6f-90dd-403c-97d0-94372be1e3e6@gmail.com>
In-Reply-To: <0a201a6f-90dd-403c-97d0-94372be1e3e6@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 28 Sep 2023 08:02:58 +0200
Message-ID: <CANpmjNP=jY2NzrXX4mgY5cL5tqZeLb18gQkzVhg1OofNtJ1VSw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/3] r8169: fix the KCSAN reported data-race in
 rtl_tx() while reading tp->cur_tx
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sept 2023 at 21:52, Heiner Kallweit <hkallweit1@gmail.com> wrote=
:
>
> On 27.09.2023 20:41, Mirsad Goran Todorovac wrote:
> > KCSAN reported the following data-race:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in rtl8169_poll [r8169] / rtl8169_start_xmit [r81=
69]
> >
> > write (marked) to 0xffff888102474b74 of 4 bytes by task 5358 on cpu 29:
> > rtl8169_start_xmit (drivers/net/ethernet/realtek/r8169_main.c:4254) r81=
69
> > dev_hard_start_xmit (./include/linux/netdevice.h:4889 ./include/linux/n=
etdevice.h:4903 net/core/dev.c:3544 net/core/dev.c:3560)
> > sch_direct_xmit (net/sched/sch_generic.c:342)
> > __dev_queue_xmit (net/core/dev.c:3817 net/core/dev.c:4306)
> > ip_finish_output2 (./include/linux/netdevice.h:3082 ./include/net/neigh=
bour.h:526 ./include/net/neighbour.h:540 net/ipv4/ip_output.c:233)
> > __ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:293)
> > ip_finish_output (net/ipv4/ip_output.c:328)
> > ip_output (net/ipv4/ip_output.c:435)
> > ip_send_skb (./include/net/dst.h:458 net/ipv4/ip_output.c:127 net/ipv4/=
ip_output.c:1486)
> > udp_send_skb (net/ipv4/udp.c:963)
> > udp_sendmsg (net/ipv4/udp.c:1246)
> > inet_sendmsg (net/ipv4/af_inet.c:840 (discriminator 4))
> > sock_sendmsg (net/socket.c:730 net/socket.c:753)
> > __sys_sendto (net/socket.c:2177)
> > __x64_sys_sendto (net/socket.c:2185)
> > do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> >
> > read to 0xffff888102474b74 of 4 bytes by interrupt on cpu 21:
> > rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4397 drivers/ne=
t/ethernet/realtek/r8169_main.c:4581) r8169
> > __napi_poll (net/core/dev.c:6527)
> > net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> > __do_softirq (kernel/softirq.c:553)
> > __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
> > irq_exit_rcu (kernel/softirq.c:647)
> > common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
> > asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
> > cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> > cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> > call_cpuidle (kernel/sched/idle.c:135)
> > do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
> > cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
> > start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.=
c:294)
> > secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
> >
> > value changed: 0x002f4815 -> 0x002f4816
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-=
kcsan-00143-gb5cbe7c00aa0 #41
> > Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 =
04/26/2023
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The write side of drivers/net/ethernet/realtek/r8169_main.c is:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    4251         /* rtl_tx needs to see descriptor changes before update=
d tp->cur_tx */
> >    4252         smp_wmb();
> >    4253
> >  =E2=86=92 4254         WRITE_ONCE(tp->cur_tx, tp->cur_tx + frags + 1);
> >    4255
> >    4256         stop_queue =3D !netif_subqueue_maybe_stop(dev, 0, rtl_t=
x_slots_avail(tp),
> >    4257                                                 R8169_TX_STOP_T=
HRS,
> >    4258                                                 R8169_TX_START_=
THRS);
> >
> > The read side is the function rtl_tx():
> >
> >    4355 static void rtl_tx(struct net_device *dev, struct rtl8169_priva=
te *tp,
> >    4356                    int budget)
> >    4357 {
> >    4358         unsigned int dirty_tx, bytes_compl =3D 0, pkts_compl =
=3D 0;
> >    4359         struct sk_buff *skb;
> >    4360
> >    4361         dirty_tx =3D tp->dirty_tx;
> >    4362
> >    4363         while (READ_ONCE(tp->cur_tx) !=3D dirty_tx) {
> >    4364                 unsigned int entry =3D dirty_tx % NUM_TX_DESC;
> >    4365                 u32 status;
> >    4366
> >    4367                 status =3D le32_to_cpu(tp->TxDescArray[entry].o=
pts1);
> >    4368                 if (status & DescOwn)
> >    4369                         break;
> >    4370
> >    4371                 skb =3D tp->tx_skb[entry].skb;
> >    4372                 rtl8169_unmap_tx_skb(tp, entry);
> >    4373
> >    4374                 if (skb) {
> >    4375                         pkts_compl++;
> >    4376                         bytes_compl +=3D skb->len;
> >    4377                         napi_consume_skb(skb, budget);
> >    4378                 }
> >    4379                 dirty_tx++;
> >    4380         }
> >    4381
> >    4382         if (tp->dirty_tx !=3D dirty_tx) {
> >    4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_c=
ompl);
> >    4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
> >    4385
> >    4386                 netif_subqueue_completed_wake(dev, 0, pkts_comp=
l, bytes_compl,
> >    4387                                               rtl_tx_slots_avai=
l(tp),
> >    4388                                               R8169_TX_START_TH=
RS);
> >    4389                 /*
> >    4390                  * 8168 hack: TxPoll requests are lost when the=
 Tx packets are
> >    4391                  * too close. Let's kick an extra TxPoll reques=
t when a burst
> >    4392                  * of start_xmit activity is detected (if it is=
 not detected,
> >    4393                  * it is slow enough). -- FR
> >    4394                  * If skb is NULL then we come here again once =
a tx irq is
> >    4395                  * triggered after the last fragment is marked =
transmitted.
> >    4396                  */
> >  =E2=86=92 4397                 if (tp->cur_tx !=3D dirty_tx && skb)
> >    4398                         rtl8169_doorbell(tp);
> >    4399         }
> >    4400 }
> >
> > Obviously from the code, an earlier detected data-race for tp->cur_tx w=
as fixed in the
> > line 4363:
> >
> >    4363         while (READ_ONCE(tp->cur_tx) !=3D dirty_tx) {
> >
> > but the same solution is required for protecting the other access to tp=
->cur_tx:
> >
> >  =E2=86=92 4397                 if (READ_ONCE(tp->cur_tx) !=3D dirty_tx=
 && skb)
> >    4398                         rtl8169_doorbell(tp);
> >
> > The write in the line 4254 is protected with WRITE_ONCE(), but the read=
 in the line 4397
> > might have suffered read tearing under some compiler optimisations.
> >
> > The fix eliminated the KCSAN data-race report for this bug.
> >
> > It is yet to be evaluated what happens if tp->cur_tx changes between th=
e test in line 4363
> > and line 4397. This test should certainly not be cached by the compiler=
 in some register
> > for such a long time, while asynchronous writes to tp->cur_tx might hav=
e occurred in line
> > 4254 in the meantime.
> >
>
> netif_subqueue_completed_wake() has barriers ensuring that no cached valu=
e for tp->cur_tx
> is used in line 4397. I'm not aware of any reported issues with an obviou=
s link to the
> potentential issue you describe.
> I don't have a strong opinion on these patches. They shouldn't hurt, and =
if they make
> KCSAN happy, why not.

Barries don't protect unmarked accesses from being miscompiled. So the
use of barriers and marked accesses like READ_ONCE() is correct:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/memory-model/Documentation/access-marking.txt
That said, actually encountering a miscompilation depends on
architecture and compiler. Using the right marked accesses just
ensures things don't suddenly break because the compiler decided to be
a little more clever.

> > Fixes: 94d8a98e6235c ("r8169: reduce number of workaround doorbell ring=
s")
> > Cc: Heiner Kallweit <hkallweit1@gmail.com>
> > Cc: nic_swsd@realtek.com
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: netdev@vger.kernel.org
> > Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188=
@alu.unizg.hr/
> > Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Acked-by: Marco Elver <elver@google.com>

> > ---
> > v1:
> >  the initial patch proposal. fixes the KCSAN warning.
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index 6351a2dc13bc..281aaa851847 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -4394,7 +4394,7 @@ static void rtl_tx(struct net_device *dev, struct=
 rtl8169_private *tp,
> >                * If skb is NULL then we come here again once a tx irq i=
s
> >                * triggered after the last fragment is marked transmitte=
d.
> >                */
> > -             if (tp->cur_tx !=3D dirty_tx && skb)
> > +             if (READ_ONCE(tp->cur_tx) !=3D dirty_tx && skb)
> >                       rtl8169_doorbell(tp);
> >       }
> >  }
>
