Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777327A4335
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbjIRHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbjIRHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:43:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4AD10F6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:41:27 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34f1ffda46fso263475ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695022887; x=1695627687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNkk5tw8+ZeUT6acsmR+sIH8TSM7k361IgPmERCXDxo=;
        b=y7pYaf1HOQRiuEJhFPJmWpCygqPYZDC/MaVc3CYCbqbawW2mvGO1YmItBU9F7ODQ0L
         XvGGgD44P6VdlLmNvRgcJEYibSFFKGO97xYAJqSWk/n3PH+BZTrzWjwI923hRcF/6B0L
         NTAwwhVTx5SpsRx0TRrRNGhbjcC6dQHSoZIPDxieCxB2ZzemLngC+Cdf1e/1XMf+vyNT
         2eb4EU0R83e5QnpM19zCrMsFQZtDVMQcaGisWtOdHSir9jck0lWVQ99Dnw6tMd3cNajC
         CrFzEcClB18kum6JG2joXk+AafyQuIcLKGX7kFSngC2tMXHuhtfE4f+B2dtQSEofBj2R
         YgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695022887; x=1695627687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNkk5tw8+ZeUT6acsmR+sIH8TSM7k361IgPmERCXDxo=;
        b=IPVqsCtxgtRQ6GzUkJOwxJIxaMrZ8hFA05Lg6L7THm+agitUlRU2BWO910A5ye8d4D
         3uKIB5EbFpoqNvCDxJ4J5fVvtSVsde1IQD0S1UYH1XG2KExyzn6XpttSmsF4ZcCp2TfV
         PFcIOVD628z0b9KPkEwDArPsTnxeq7lhOQwKbx8tuY9jWw+nI4VBX70tQtuOxl80NSMu
         XzT5f+zOMSXHtG3LtzpohxyfCNtidMDHP+rB1NwFMXbASWpsqs0UIm5VmpzmWfeoeWBw
         i/h1HlSAYvHjfgcQOXUdn1iiSuc3XkylIRFNW4rboLfwsq4VDw/Z+ArGceWdZbE5TqrF
         hfBg==
X-Gm-Message-State: AOJu0Yz1aQVmOwcVU1LxKFBLOxwMO4Sy3wq6DNul7wE7jTsO8kQ6nS70
        hjxPs7KLWzMXv9DIK6Qyg393eANWa4KmMf4Quk5kcA==
X-Google-Smtp-Source: AGHT+IGnCfo6ZQHL0v62yc3npU7ge62Ej+b0BTHEIQ7MC4I3lEI8MnDvKk5e0s6nauZbWp650tRhfrJ8Kga4Sun2Kp4=
X-Received: by 2002:a05:6e02:12c1:b0:34f:8039:a3c5 with SMTP id
 i1-20020a056e0212c100b0034f8039a3c5mr339798ilm.15.1695022886434; Mon, 18 Sep
 2023 00:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <ed59c1b9-6c5c-4774-a871-a24564f3a270@alu.unizg.hr>
In-Reply-To: <ed59c1b9-6c5c-4774-a871-a24564f3a270@alu.unizg.hr>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 18 Sep 2023 09:41:15 +0200
Message-ID: <CANn89iJv8VRPwQBAE=5-oKHGMs9JVCvCiCBwL+3QW9sJDxo5cQ@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in rtl8169_poll
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     nic_swsd@realtek.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 8:15=E2=80=AFAM Mirsad Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
>
> Hi all,
>
> In the vanilla torvalds tree kernel on Ubuntu 22.04, commit 6.6.0-rc1-kcs=
an-00269-ge789286468a9,
> KCSAN discovered a data-race in rtl8169_poll():
>
> [ 9591.740976] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 9591.740990] BUG: KCSAN: data-race in rtl8169_poll (drivers/net/etherne=
t/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583)=
 r8169
>
> [ 9591.741060] race at unknown origin, with read to 0xffff888109773130 of=
 4 bytes by interrupt on cpu 21:
> [ 9591.741073] rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:44=
30 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
> [ 9591.741135] __napi_poll (net/core/dev.c:6527)
> [ 9591.741149] net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> [ 9591.741161] __do_softirq (kernel/softirq.c:553)
> [ 9591.741175] __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
> [ 9591.741185] irq_exit_rcu (kernel/softirq.c:647)
> [ 9591.741194] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator=
 14))
> [ 9591.741206] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:63=
6)
> [ 9591.741217] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> [ 9591.741227] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> [ 9591.741237] call_cpuidle (kernel/sched/idle.c:135)
> [ 9591.741249] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
> [ 9591.741259] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator =
1))
> [ 9591.741268] start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/ke=
rnel/smpboot.c:294)
> [ 9591.741281] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:=
433)
>
> [ 9591.741300] value changed: 0x80003fff -> 0x34044510
>
> [ 9591.741314] Reported by Kernel Concurrency Sanitizer on:
> [ 9591.741322] CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L  =
   6.6.0-rc1-kcsan-00269-ge789286468a9-dirty #4
> [ 9591.741334] Hardware name: ASRock X670E PG Lightning/X670E PG Lightnin=
g, BIOS 1.21 04/26/2023
> [ 9591.741343] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> (The taint is not from the proprietary module, but triggered from the pre=
vious reported and unfixed bug.)
>
> Apparently, it is this code:
>
> static int rtl8169_poll(struct napi_struct *napi, int budget)
> {
>         struct rtl8169_private *tp =3D container_of(napi, struct rtl8169_=
private, napi);
>         struct net_device *dev =3D tp->dev;
>         int work_done;
>
>         rtl_tx(dev, tp, budget);
>
> =E2=86=92       work_done =3D rtl_rx(dev, tp, budget);
>
>         if (work_done < budget && napi_complete_done(napi, work_done))
>                 rtl_irq_enable(tp);
>
>         return work_done;
> }
>
> and
>
> static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int=
 budget)
> {
>         struct device *d =3D tp_to_dev(tp);
>         int count;
>
>         for (count =3D 0; count < budget; count++, tp->cur_rx++) {
>                 unsigned int pkt_size, entry =3D tp->cur_rx % NUM_RX_DESC=
;
>                 struct RxDesc *desc =3D tp->RxDescArray + entry;
>                 struct sk_buff *skb;
>                 const void *rx_buf;
>                 dma_addr_t addr;
>                 u32 status;
>
> =E2=86=92               status =3D le32_to_cpu(desc->opts1);
>                 if (status & DescOwn)
>                         break;
>
>                 /* This barrier is needed to keep us from reading
>                  * any other fields out of the Rx descriptor until
>                  * we know the status of DescOwn
>                  */
>                 dma_rmb();
>
>                 if (unlikely(status & RxRES)) {
> .
> .
> .
>
> The reason isn't obvious, so it might be interesting if this is a valid r=
eport and whether it caused spurious corruption
> of the network data on Realtek 8169 compatible cards ...
>

I think this is pretty much expected.

Driver reads a piece of memory that the hardware can modify.

Adding data_race() annotations could avoid these false positives.

> Hope this helps.
>
> Best regards,
> Mirsad Todorovac
