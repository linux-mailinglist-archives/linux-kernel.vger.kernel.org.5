Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31397CA0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjJPHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjJPHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:35:52 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4724E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:35:50 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457c7177a42so1065089137.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697441750; x=1698046550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZWxgydpZppRV3uFhpO46+mr4KRDGo1ndeXPvO+3cY4=;
        b=MC5DhabGSH3oNOgExQJVgI1sPVP5qpfD7NY/IpKxbNnUp9VZZIZAf96WKcVhgJ26RW
         L55yvsjepwpLl2D6P1DU+wUnshNjUaCX+1FJ/YlRHsRExZbYRKzz4Qujzs6IaarKMSkX
         HVIs7raJSDtmPkrRmboeXb6nraf6IowVNqRK3ZT0UT9Sd2LG41mgS1QgMgS8mz+nXXAk
         CEteDF2eoNtnt9ITBEtKKtbk1wffbwkKHCOpgmHv9DeqMoTof88ZFrDXX88Z/0UzO8FY
         JZB8fAin8owLw0H8Drxt57dnhVm8BtjWWlYYED9qGMBs8H8gfccCQFeQd6wpq6YHOGtX
         Nxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697441750; x=1698046550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZWxgydpZppRV3uFhpO46+mr4KRDGo1ndeXPvO+3cY4=;
        b=aJuTe4lGFhvqkDS8/0R0lNdq/Z6XPren6iZ5G28EH54G8BVbH5D5n6Z37ehdgtDXHH
         kGULj2lSuvD6usUnD2Sl48YqESa90t6U2aNWI70g3NSsQxQm6Rc1bScF0LYtf7ymu2gt
         livaEt9Hxbzy41CBWFDUJKjfZbO7P38YZKYO9uvxB34s2QQI0udW4ABPHgcLRxDcAJUb
         m1PAvkHkRODpEobC8YhMHTtwGFP9wkXlOraInsAdtjAhtyfq9FFljOqVAQk064MqiMdF
         8NnW0Shq3JrVcY4gYLRc5wMycbAZ7+c9Y+WBJjJDlAY13YPxeUjkptdEYnB30wFF6+Zw
         w2bQ==
X-Gm-Message-State: AOJu0Yz3owcHTkbES4DrQEJ5XipwUrXBEiC9auL9h3lcVA89h2qgDONW
        tqA1jlpUaS4gTo0vZNt996ZbT5mpt1lPTqh00dihWA==
X-Google-Smtp-Source: AGHT+IGtxtcQ/DwbOjZOxe+vSiZxL2yoStxDTOGDWY6AK+7ZzeunATAPpwfYQKkogueWZsUdGJzM3OxpCtnI+gmEk3U=
X-Received: by 2002:a67:a64b:0:b0:457:d207:4328 with SMTP id
 r11-20020a67a64b000000b00457d2074328mr3902554vsh.23.1697441749420; Mon, 16
 Oct 2023 00:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231014031257.178630-1-mirsad.todorovac@alu.unizg.hr> <20231014031257.178630-2-mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20231014031257.178630-2-mirsad.todorovac@alu.unizg.hr>
From:   Marco Elver <elver@google.com>
Date:   Mon, 16 Oct 2023 09:35:13 +0200
Message-ID: <CANpmjNOphxEYnw41tc+WisidgHOpqVDajtXj_m8-TfYevObQ=g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] r8169: fix the KCSAN reported data-race in rtl_tx
 while reading TxDescArray[entry].opts1
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023 at 05:16, Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> KCSAN reported the following data-race:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169=
_main.c:4368 drivers/net/ethernet/realtek/r8169_main.c:4581) r8169
>
> race at unknown origin, with read to 0xffff888140d37570 of 4 bytes by int=
errupt on cpu 21:
> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4368 drivers/net/=
ethernet/realtek/r8169_main.c:4581) r8169
> __napi_poll (net/core/dev.c:6527)
> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> __do_softirq (kernel/softirq.c:553)
> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
> irq_exit_rcu (kernel/softirq.c:647)
> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discrimina=
tor 14))
> asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> call_cpuidle (kernel/sched/idle.c:135)
> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:=
294)
> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
>
> value changed: 0xb0000042 -> 0x00000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kc=
san-00143-gb5cbe7c00aa0 #41
> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04=
/26/2023
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The read side is in
>
> drivers/net/ethernet/realtek/r8169_main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    4355 static void rtl_tx(struct net_device *dev, struct rtl8169_private=
 *tp,
>    4356                    int budget)
>    4357 {
>    4358         unsigned int dirty_tx, bytes_compl =3D 0, pkts_compl =3D =
0;
>    4359         struct sk_buff *skb;
>    4360
>    4361         dirty_tx =3D tp->dirty_tx;
>    4362
>    4363         while (READ_ONCE(tp->cur_tx) !=3D dirty_tx) {
>    4364                 unsigned int entry =3D dirty_tx % NUM_TX_DESC;
>    4365                 u32 status;
>    4366
>  =E2=86=92 4367                 status =3D le32_to_cpu(tp->TxDescArray[en=
try].opts1);
>    4368                 if (status & DescOwn)
>    4369                         break;
>    4370
>    4371                 skb =3D tp->tx_skb[entry].skb;
>    4372                 rtl8169_unmap_tx_skb(tp, entry);
>    4373
>    4374                 if (skb) {
>    4375                         pkts_compl++;
>    4376                         bytes_compl +=3D skb->len;
>    4377                         napi_consume_skb(skb, budget);
>    4378                 }
>    4379                 dirty_tx++;
>    4380         }
>    4381
>    4382         if (tp->dirty_tx !=3D dirty_tx) {
>    4383                 dev_sw_netstats_tx_add(dev, pkts_compl, bytes_com=
pl);
>    4384                 WRITE_ONCE(tp->dirty_tx, dirty_tx);
>    4385
>    4386                 netif_subqueue_completed_wake(dev, 0, pkts_compl,=
 bytes_compl,
>    4387                                               rtl_tx_slots_avail(=
tp),
>    4388                                               R8169_TX_START_THRS=
);
>    4389                 /*
>    4390                  * 8168 hack: TxPoll requests are lost when the T=
x packets are
>    4391                  * too close. Let's kick an extra TxPoll request =
when a burst
>    4392                  * of start_xmit activity is detected (if it is n=
ot detected,
>    4393                  * it is slow enough). -- FR
>    4394                  * If skb is NULL then we come here again once a =
tx irq is
>    4395                  * triggered after the last fragment is marked tr=
ansmitted.
>    4396                  */
>    4397                 if (READ_ONCE(tp->cur_tx) !=3D dirty_tx && skb)
>    4398                         rtl8169_doorbell(tp);
>    4399         }
>    4400 }
>
> tp->TxDescArray[entry].opts1 is reported to have a data-race and READ_ONC=
E() fixes
> this KCSAN warning.
>
>    4366
>  =E2=86=92 4367                 status =3D le32_to_cpu(READ_ONCE(tp->TxDe=
scArray[entry].opts1));
>    4368                 if (status & DescOwn)
>    4369                         break;
>    4370
>
> Fixes: ^1da177e4c3f4 ("initial git repository build")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Marco Elver <elver@google.com>
> Cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@a=
lu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Acked-by: Marco Elver <elver@google.com>

> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 81be6085a480..361b90007148 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4364,7 +4364,7 @@ static void rtl_tx(struct net_device *dev, struct r=
tl8169_private *tp,
>                 unsigned int entry =3D dirty_tx % NUM_TX_DESC;
>                 u32 status;
>
> -               status =3D le32_to_cpu(tp->TxDescArray[entry].opts1);
> +               status =3D le32_to_cpu(READ_ONCE(tp->TxDescArray[entry].o=
pts1));
>                 if (status & DescOwn)
>                         break;
>
> --
> 2.34.1
>
