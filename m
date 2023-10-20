Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95747D101F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377212AbjJTNAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377401AbjJTNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E136D61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:00:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D351C433C8;
        Fri, 20 Oct 2023 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697806827;
        bh=FF6yIFgoZsRm6vs9OFR60yPujPa1CtpzINti2B/DlPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2SgyYv8aEte9ACMcLyW24NZiEiMTnJxONXzWhc9dOSd8nJdnNFhQrig3QpEAPWNh
         mUq2PIfl9TLdVBJehXxRX7Gu9nUwHEWel3hcEWH6cRl2R5aqi8jOkuR3kCpHH/Y40b
         4iC/D/qKtxlPVbSMargJ6wNfufPOQrbmZJw9j/9+8lMiHOaNtIstf35/EpFz3OaH22
         PnetrhLkJagA9y8fxIoKbPFCV2cL2BtodTdd6hBbwN0KkY5yX198rhh5dBY6gn3irs
         Kc9kVTF+MubqO1J//EkB5jTkkylD6qhcBB06r+N5axxqDlC5dwagWAUckF2FcdFEhi
         gOSvtfkafrtlw==
Date:   Fri, 20 Oct 2023 15:00:23 +0200
From:   Simon Horman <horms@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 3/3] r8169: fix the KCSAN reported data race in rtl_rx
 while reading desc->opts1
Message-ID: <20231020130023.GF2208164@kernel.org>
References: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
 <20231018193434.344176-3-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018193434.344176-3-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:34:38PM +0200, Mirsad Goran Todorovac wrote:
> KCSAN reported the following data-race bug:
> 
> ==================================================================
> BUG: KCSAN: data-race in rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
> 
> race at unknown origin, with read to 0xffff888117e43510 of 4 bytes by interrupt on cpu 21:
> rtl8169_poll (drivers/net/ethernet/realtek/r8169_main.c:4430 drivers/net/ethernet/realtek/r8169_main.c:4583) r8169
> __napi_poll (net/core/dev.c:6527)
> net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727)
> __do_softirq (kernel/softirq.c:553)
> __irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632)
> irq_exit_rcu (kernel/softirq.c:647)
> sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14))
> asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:645)
> cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
> cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
> call_cpuidle (kernel/sched/idle.c:135)
> do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
> cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
> start_secondary (arch/x86/kernel/smpboot.c:210 arch/x86/kernel/smpboot.c:294)
> secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433)
> 
> value changed: 0x80003fff -> 0x3402805f
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 21 PID: 0 Comm: swapper/21 Tainted: G             L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
> Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> ==================================================================
> 
> drivers/net/ethernet/realtek/r8169_main.c:
> ==========================================
>    4429
>  → 4430                 status = le32_to_cpu(desc->opts1);
>    4431                 if (status & DescOwn)
>    4432                         break;
>    4433
>    4434                 /* This barrier is needed to keep us from reading
>    4435                  * any other fields out of the Rx descriptor until
>    4436                  * we know the status of DescOwn
>    4437                  */
>    4438                 dma_rmb();
>    4439
>    4440                 if (unlikely(status & RxRES)) {
>    4441                         if (net_ratelimit())
>    4442                                 netdev_warn(dev, "Rx ERROR. status = %08x\n",
> 
> Marco Elver explained that dma_rmb() doesn't prevent the compiler to tear up the access to
> desc->opts1 which can be written to concurrently. READ_ONCE() should prevent that from
> happening:
> 
>    4429
>  → 4430                 status = le32_to_cpu(READ_ONCE(desc->opts1));
>    4431                 if (status & DescOwn)
>    4432                         break;
>    4433
> 
> As the consequence of this fix, this KCSAN warning was eliminated.
> 
> Fixes: 6202806e7c03a ("r8169: drop member opts1_mask from struct rtl8169_private")
> Suggested-by: Marco Elver <elver@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Link: https://lore.kernel.org/lkml/dc7fc8fa-4ea4-e9a9-30a6-7c83e6b53188@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Acked-by: Marco Elver <elver@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

