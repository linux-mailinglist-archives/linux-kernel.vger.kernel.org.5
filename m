Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB177DA258
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbjJ0VUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0VUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:20:21 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8957A1AA;
        Fri, 27 Oct 2023 14:20:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0A6DF60197;
        Fri, 27 Oct 2023 23:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698441615; bh=x2nsCMOA2aqqotqUxWmGIzp0ZhXlFsMbVvvqRMSeGrE=;
        h=From:To:Cc:Subject:Date:From;
        b=slFNV10orbsT/e1d171zZD6qlvFv6Ek639Y481GMXwafvMmY/ua7ikbSS7kZIO5aM
         jgUebpWJUVvRzUgqVbI4pSl/85FFSgrb0Orz6gkOTKg14OwtbQxanpxVahbzH4m0z5
         JOGkNqDAF8Us8XZAup3bUfJKPWy3M6D3jHBsNcD/Xrv2/UW50vejQCkLU6pQ9TExfq
         NXOUbicoD608FjaZHr3iQHk3f1tX8BangmCbU2ubYPalSNlIiA4WHo+ve+/CSYhFJJ
         9EfK0fzCujpkE6JEE5dFNI0a2ceocj1A9a52JvZ1doYvUX1IFhObndRVtgAY2e7rpj
         KxasyIwiB2y4g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YgvryUMb_Up7; Fri, 27 Oct 2023 23:20:11 +0200 (CEST)
Received: from defiant.home (78-0-114-144.adsl.net.t-com.hr [78.0.114.144])
        by domac.alu.hr (Postfix) with ESMTPSA id 5792860182;
        Fri, 27 Oct 2023 23:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698441611; bh=x2nsCMOA2aqqotqUxWmGIzp0ZhXlFsMbVvvqRMSeGrE=;
        h=From:To:Cc:Subject:Date:From;
        b=hkSbHf93BKhmIRPs9T1gIxDyU3nE00nZzsBVEriHztyFekl1phSulprvI8jQyHC34
         oI8Zpxtr7Wm3dlnKyitbVpAun4w0PzNl5UwyHlLRXCDqdoNTDoDyxxd75lCAQFFrNi
         pehDVDZvQpIdm3+4wg9wk9HotMoAK10EDoCQkUfjmRBWL1juo+9MDuIOIeJEAd+X4F
         LRj+xt7K3mEp1qA3OjShTq/Hcj+ynYs9RLZXRV7a5fY4otDX8+JIkYrCpm1sz0DwzE
         fCjYpzB2NiL+s+L9n73KiRkHs9qybUCMx9HXsXYmZk4r1gww0jKhvjiUSOo8455VGL
         B0te5tCrcWpIw==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Subject: [RFC PATCH v1 1/1] r8169: Coalesce RTL8411b register recovery programming instructions to reduce spinlock stalls
Date:   Fri, 27 Oct 2023 23:17:29 +0200
Message-Id: <20231027211728.680691-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RTL8411b the RX unit gets confused if the PHY is powered-down.
This was reported in [0] and confirmed by Realtek. Realtek provided
a sequence to fix the RX unit after PHY wakeup.

A series of about 130 r8168_mac_ocp_write() calls is performed to
program the RTL registers for recovery.

	static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
	{
		if (rtl_ocp_reg_failure(reg))
			return;

		RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
	}

	static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
	{
		unsigned long flags;

		raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
		__r8168_mac_ocp_write(tp, reg, data);
		raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
	}

Register programming is done through RTL_W32() macro which expands into

	#define RTL_W32(tp, reg, val32)	writel((val32), tp->mmio_addr + (reg))

which is further:

	extern inline void writel(u32 b, volatile void __iomem *addr)
	{
		mb();
		__raw_writel(b, addr);
	}

mb() expands into this on x86_64:

	#define mb()	asm volatile("lock; addl $0,0(%%esp)" ::: "memory")

This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
memory barrier, writel(), and spin_unlock_irqrestore().

With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
a lock storm that will stall all of the cores and CPUs on the same memory controller
for certain time I/O takes to finish.

In a sequential case of RTL register programming, the writes to RTL registers
can be coalesced under a same raw spinlock. This can dramatically decrease the
number of bus stalls in a multicore or multi-CPU system:

        unsigned long flags;
        raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
        __r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
        __r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
        __r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
        __r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
        __r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
        __r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
        __r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
        __r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
        raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);

We were using the raw version of the ocp write function __r8168_mac_ocp_write and
coalesced them under spinlocks.

Note that the original reason for the introduction of the commit fe4e8db0392a6
was to enable recovery of the RX unit on the RTL8411b which was confused by the
powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
into a series of about 520 memory bus locks, most waiting for the main memory read,
modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
the programming sequence to reach RTL NIC registers.

Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 drivers/net/ethernet/realtek/r8169_main.c | 260 +++++++++++-----------
 1 file changed, 134 insertions(+), 126 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 361b90007148..2c83d54320f2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3100,6 +3100,8 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 		{ 0x1d, 0x0000,	0x4000 },
 	};
 
+	unsigned long flags;
+
 	rtl_hw_start_8168g(tp);
 
 	rtl_ephy_init(tp, e_info_8411_2);
@@ -3107,138 +3109,144 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 	/* The following Realtek-provided magic fixes an issue with the RX unit
 	 * getting confused after the PHY having been powered-down.
 	 */
-	r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
-	r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_write(tp, 0xFC28, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xFC2A, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xFC2C, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xFC2E, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xFC30, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xFC32, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xFC34, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xFC36, 0x0000);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 	mdelay(3);
 	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
 
-	r8168_mac_ocp_write(tp, 0xF800, 0xE008);
-	r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
-	r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
-	r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
-	r8168_mac_ocp_write(tp, 0xF808, 0xE027);
-	r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
-	r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
-	r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
-	r8168_mac_ocp_write(tp, 0xF810, 0xC602);
-	r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF814, 0x0000);
-	r8168_mac_ocp_write(tp, 0xF816, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
-	r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
-	r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
-	r8168_mac_ocp_write(tp, 0xF820, 0x080A);
-	r8168_mac_ocp_write(tp, 0xF822, 0x6420);
-	r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
-	r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
-	r8168_mac_ocp_write(tp, 0xF828, 0xC516);
-	r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
-	r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
-	r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
-	r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
-	r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
-	r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
-	r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
-	r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
-	r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
-	r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
-	r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
-	r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
-	r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
-	r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
-	r8168_mac_ocp_write(tp, 0xF846, 0xC404);
-	r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
-	r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
-	r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
-	r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
-	r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
-	r8168_mac_ocp_write(tp, 0xF852, 0xE434);
-	r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
-	r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
-	r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
-	r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
-	r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
-	r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
-	r8168_mac_ocp_write(tp, 0xF860, 0xF007);
-	r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
-	r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
-	r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
-	r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
-	r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
-	r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
-	r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
-	r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
-	r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
-	r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
-	r8168_mac_ocp_write(tp, 0xF876, 0xC516);
-	r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
-	r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
-	r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
-	r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
-	r8168_mac_ocp_write(tp, 0xF880, 0xC512);
-	r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
-	r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
-	r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
-	r8168_mac_ocp_write(tp, 0xF888, 0x483F);
-	r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
-	r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
-	r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
-	r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
-	r8168_mac_ocp_write(tp, 0xF892, 0xC505);
-	r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF896, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
-	r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
-	r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
-	r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
-	r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
-	r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
-	r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
-	r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
-	r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
-	r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
-	r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
-	r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
-	r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
-	r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
-	r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
-	r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
-	r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
-	r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
-	r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
-	r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
-	r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
-	r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
-	r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
-	r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
-	r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
-	r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
-	r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
-	r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
-	r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
-	r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_write(tp, 0xF800, 0xE008);
+	__r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
+	__r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
+	__r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
+	__r8168_mac_ocp_write(tp, 0xF808, 0xE027);
+	__r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
+	__r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
+	__r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
+	__r8168_mac_ocp_write(tp, 0xF810, 0xC602);
+	__r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
+	__r8168_mac_ocp_write(tp, 0xF814, 0x0000);
+	__r8168_mac_ocp_write(tp, 0xF816, 0xC502);
+	__r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
+	__r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
+	__r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
+	__r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
+	__r8168_mac_ocp_write(tp, 0xF820, 0x080A);
+	__r8168_mac_ocp_write(tp, 0xF822, 0x6420);
+	__r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
+	__r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
+	__r8168_mac_ocp_write(tp, 0xF828, 0xC516);
+	__r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
+	__r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
+	__r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
+	__r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
+	__r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
+	__r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
+	__r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
+	__r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
+	__r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
+	__r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
+	__r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
+	__r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
+	__r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
+	__r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
+	__r8168_mac_ocp_write(tp, 0xF846, 0xC404);
+	__r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
+	__r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
+	__r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
+	__r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
+	__r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
+	__r8168_mac_ocp_write(tp, 0xF852, 0xE434);
+	__r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
+	__r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
+	__r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
+	__r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
+	__r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
+	__r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
+	__r8168_mac_ocp_write(tp, 0xF860, 0xF007);
+	__r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
+	__r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
+	__r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
+	__r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
+	__r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
+	__r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
+	__r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
+	__r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
+	__r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
+	__r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
+	__r8168_mac_ocp_write(tp, 0xF876, 0xC516);
+	__r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
+	__r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
+	__r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
+	__r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
+	__r8168_mac_ocp_write(tp, 0xF880, 0xC512);
+	__r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
+	__r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
+	__r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
+	__r8168_mac_ocp_write(tp, 0xF888, 0x483F);
+	__r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
+	__r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
+	__r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
+	__r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
+	__r8168_mac_ocp_write(tp, 0xF892, 0xC505);
+	__r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
+	__r8168_mac_ocp_write(tp, 0xF896, 0xC502);
+	__r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
+	__r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
+	__r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
+	__r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
+	__r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
+	__r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
+	__r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
+	__r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
+	__r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
+	__r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
+	__r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
+	__r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
+	__r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
+	__r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
+	__r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
+	__r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
+	__r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
+	__r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
+	__r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
+	__r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
+	__r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
+	__r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
+	__r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
+	__r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
+	__r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
+	__r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
+	__r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
+	__r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
+	__r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
+	__r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
+	__r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
+	__r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
+	__r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
+	__r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
+	__r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 
 	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
 
-	r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
-	r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
-	r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
-	r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
-	r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
-	r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
-	r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
+	__r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
+	__r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
+	__r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
+	__r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
+	__r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
+	__r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 }
 
 static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
-- 
2.34.1

