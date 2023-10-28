Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF64F7DA6AD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjJ1LRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1LRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:17:01 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD54B4;
        Sat, 28 Oct 2023 04:16:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E928660174;
        Sat, 28 Oct 2023 13:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698491815; bh=FrXB/LHnbGAnPVwfKI/FaITv0a9eM9TZWJRNdyxJhB8=;
        h=From:To:Cc:Subject:Date:From;
        b=Bbw57A1uuIRSZH2SxxHbLofOUtdfoH3HVmkuRLSHt/Wkq6IGtVVInRu0BLKRHGbEg
         B90AJZn+XzgeQNODuJq8QHRJ4LqHMqs66ylOEVdqz61tz7mCfYPgZOudgYnyvp6876
         vUQs1/Xr1+2c2Jy7TYHd1PGxMdm4H9ZcDwrOSHDIGFCb1rLU8yT7zr8WDc2X31dh1Q
         6aKuuyMCSalsL3yVaja9MCmIe+QhtHnbwt/rHqKRe7Kz/q2/1D+q5ByWY+r4hZLPom
         TnrBRoRTPFLItZsZ1+JjzMNflBo/9UewGWwPAEPiRd8DiDrcXdBGmXfuU+O3GiMJYS
         93Tr0InqPCZZA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vOUtgNkbX3nQ; Sat, 28 Oct 2023 13:16:52 +0200 (CEST)
Received: from defiant.home (78-3-40-253.adsl.net.t-com.hr [78.3.40.253])
        by domac.alu.hr (Postfix) with ESMTPSA id 3BE8960173;
        Sat, 28 Oct 2023 13:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698491812; bh=FrXB/LHnbGAnPVwfKI/FaITv0a9eM9TZWJRNdyxJhB8=;
        h=From:To:Cc:Subject:Date:From;
        b=LKB/sXQA1gqNtIy2ND7kUyUjERc0ir8g11wj8F/azdQaPnAqTQOnIJSQgKipTX8mC
         CKtC0qsog8UPRiXSQtdqD7Qv2XpulBVWEoE0jbsZoPL1LeL2ogE3gU9dZdGkeY+mGh
         ob891KEvuEsLW38F+/UQdMwb2Lxpt08Vw3qKtBzkGS9JnjfRZprFzvcW28MUy8470u
         HyMoBb6PyVuaav068MplMpb7S3qHHFvAWNQ9PX1pXzF4XSnxXONtWw7T54N9t4pmQs
         Y/BU7PbJtsNt3ZKCaHWCBOcziIB4TycVSaQUmr9YE/R0TrSmhhDqfUI51cd4vupIRY
         uyZKpwVJjSBNg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nic_swsd@realtek.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Subject: [PATCH v3 1/1] r8169: Coalesce RTL8411b PHY power-down recovery programming instructions to reduce spinlock stalls
Date:   Sat, 28 Oct 2023 13:05:00 +0200
Message-Id: <20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

r8168_mac_ocp_write() expands to this code:

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

        #define RTL_W32(tp, reg, val32) writel((val32), tp->mmio_addr + (reg))

which is further (on Alpha):

        extern inline void writel(u32 b, volatile void __iomem *addr)
        {
                mb();
                __raw_writel(b, addr);
        }

or on i386/x86_64:

    #define build_mmio_write(name, size, type, reg, barrier) \
    static inline void name(type val, volatile void __iomem *addr) \
    { asm volatile("mov" size " %0,%1": :reg (val), \
    "m" (*(volatile type __force *)addr) barrier); }

    build_mmio_write(writel, "l", unsigned int, "r", :"memory")

This obviously involves iat least a compiler barrier.

mb() expands into something like this i.e. on x86_64:

        #define mb()    asm volatile("lock; addl $0,0(%%esp)" ::: "memory")

This means a whole lot of memory bus barriers: for spin_lock_irqsave(),
memory barrier, writel(), and spin_unlock_irqrestore().

With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
a LOCK storm that will thunder all of the cores and CPUs on the same memory controller
for certain time that locked memory read-modify-write cyclo or I/O takes to finish.

In a sequential case of RTL register programming, the writes to RTL registers
can be coalesced under a same raw spinlock. This can dramatically decrease the
number of bus stalls in a multicore or multi-CPU system:

        static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
                                              const struct recover_8411b_info *array)
        {
                struct recover_8411b_info const *p = array;

                while (p->reg) {
                        if (!rtl_ocp_reg_failure(p->reg))
                                RTL_W32(tp, OCPDR, OCPAR_FLAG | (p->reg << 15) | p->data);
                        p++;
                }
        }

        static void r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
                                            const struct recover_8411b_info *array)
        {
                unsigned long flags;

                raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
                __r8168_mac_ocp_write_seq(tp, array);
                raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
        }

        static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
        {

                ...

                /* The following Realtek-provided magic fixes an issue with the RX unit
                 * getting confused after the PHY having been powered-down.
                 */

                static const struct recover_8411b_info init_zero_seq[] = {
                        { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
			...
                };

                static const struct recover_8411b_info recover_seq[] = {
                        { 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
			...
                };

                static const struct recover_8411b_info final_seq[] = {
                        { 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
			...
                };

                r8168_mac_ocp_write_seq(tp, init_zero_seq);
                mdelay(3);
                r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
                r8168_mac_ocp_write_seq(tp, recover_seq);
                r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
                r8168_mac_ocp_write_seq(tp, final_seq);
        }

The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
functions that only changed the function names and the ending of the line, so the actual
hex data is unchanged.

Note that the original reason for the introduction of the commit fe4e8db0392a6
was to enable recovery of the RX unit on the RTL8411b which was confused by the
powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
into a series of about 500+ memory bus locks, most waiting for the main memory read,
modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
the programming sequence to reach RTL NIC registers.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075

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
Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 198 ++++++++--------------
 1 file changed, 72 insertions(+), 126 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 361b90007148..3b28bec7098b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -939,6 +939,32 @@ static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
 	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 }
 
+struct e_info_regmask_pair {
+	u32	reg;
+	u32	data;
+};
+
+static void __r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
+				      const struct e_info_regmask_pair *array, int len)
+{
+	struct e_info_regmask_pair const *p;
+
+	for (p = array; len--; p++)
+		__r8168_mac_ocp_write(tp, p->reg, p->data);
+}
+
+static void _r8168_mac_ocp_write_seq(struct rtl8169_private *tp,
+				     const struct e_info_regmask_pair *array, int len)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_write_seq(tp, array, len);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
+}
+
+#define r8168_mac_ocp_write_seq(tp, a) _r8168_mac_ocp_write_seq(tp, a, ARRAY_SIZE(a))
+
 /* Work around a hw issue with RTL8168g PHY, the quirk disables
  * PHY MCU interrupts before PHY power-down.
  */
@@ -3107,138 +3133,58 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
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
+
+	static const struct e_info_regmask_pair init_zero_seq[] = {
+		{ 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
+		{ 0xFC30, 0x0000 }, { 0xFC32, 0x0000 }, { 0xFC34, 0x0000 }, { 0xFC36, 0x0000 },
+	};
+
+	static const struct e_info_regmask_pair recover_seq[] = {
+		{ 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C }, { 0xF806, 0xE00E },
+		{ 0xF808, 0xE027 }, { 0xF80A, 0xE04F }, { 0xF80C, 0xE05E }, { 0xF80E, 0xE065 },
+		{ 0xF810, 0xC602 }, { 0xF812, 0xBE00 }, { 0xF814, 0x0000 }, { 0xF816, 0xC502 },
+		{ 0xF818, 0xBD00 }, { 0xF81A, 0x074C }, { 0xF81C, 0xC302 }, { 0xF81E, 0xBB00 },
+		{ 0xF820, 0x080A }, { 0xF822, 0x6420 }, { 0xF824, 0x48C2 }, { 0xF826, 0x8C20 },
+		{ 0xF828, 0xC516 }, { 0xF82A, 0x64A4 }, { 0xF82C, 0x49C0 }, { 0xF82E, 0xF009 },
+		{ 0xF830, 0x74A2 }, { 0xF832, 0x8CA5 }, { 0xF834, 0x74A0 }, { 0xF836, 0xC50E },
+		{ 0xF838, 0x9CA2 }, { 0xF83A, 0x1C11 }, { 0xF83C, 0x9CA0 }, { 0xF83E, 0xE006 },
+		{ 0xF840, 0x74F8 }, { 0xF842, 0x48C4 }, { 0xF844, 0x8CF8 }, { 0xF846, 0xC404 },
+		{ 0xF848, 0xBC00 }, { 0xF84A, 0xC403 }, { 0xF84C, 0xBC00 }, { 0xF84E, 0x0BF2 },
+		{ 0xF850, 0x0C0A }, { 0xF852, 0xE434 }, { 0xF854, 0xD3C0 }, { 0xF856, 0x49D9 },
+		{ 0xF858, 0xF01F }, { 0xF85A, 0xC526 }, { 0xF85C, 0x64A5 }, { 0xF85E, 0x1400 },
+		{ 0xF860, 0xF007 }, { 0xF862, 0x0C01 }, { 0xF864, 0x8CA5 }, { 0xF866, 0x1C15 },
+		{ 0xF868, 0xC51B }, { 0xF86A, 0x9CA0 }, { 0xF86C, 0xE013 }, { 0xF86E, 0xC519 },
+		{ 0xF870, 0x74A0 }, { 0xF872, 0x48C4 }, { 0xF874, 0x8CA0 }, { 0xF876, 0xC516 },
+		{ 0xF878, 0x74A4 }, { 0xF87A, 0x48C8 }, { 0xF87C, 0x48CA }, { 0xF87E, 0x9CA4 },
+		{ 0xF880, 0xC512 }, { 0xF882, 0x1B00 }, { 0xF884, 0x9BA0 }, { 0xF886, 0x1B1C },
+		{ 0xF888, 0x483F }, { 0xF88A, 0x9BA2 }, { 0xF88C, 0x1B04 }, { 0xF88E, 0xC508 },
+		{ 0xF890, 0x9BA0 }, { 0xF892, 0xC505 }, { 0xF894, 0xBD00 }, { 0xF896, 0xC502 },
+		{ 0xF898, 0xBD00 }, { 0xF89A, 0x0300 }, { 0xF89C, 0x051E }, { 0xF89E, 0xE434 },
+		{ 0xF8A0, 0xE018 }, { 0xF8A2, 0xE092 }, { 0xF8A4, 0xDE20 }, { 0xF8A6, 0xD3C0 },
+		{ 0xF8A8, 0xC50F }, { 0xF8AA, 0x76A4 }, { 0xF8AC, 0x49E3 }, { 0xF8AE, 0xF007 },
+		{ 0xF8B0, 0x49C0 }, { 0xF8B2, 0xF103 }, { 0xF8B4, 0xC607 }, { 0xF8B6, 0xBE00 },
+		{ 0xF8B8, 0xC606 }, { 0xF8BA, 0xBE00 }, { 0xF8BC, 0xC602 }, { 0xF8BE, 0xBE00 },
+		{ 0xF8C0, 0x0C4C }, { 0xF8C2, 0x0C28 }, { 0xF8C4, 0x0C2C }, { 0xF8C6, 0xDC00 },
+		{ 0xF8C8, 0xC707 }, { 0xF8CA, 0x1D00 }, { 0xF8CC, 0x8DE2 }, { 0xF8CE, 0x48C1 },
+		{ 0xF8D0, 0xC502 }, { 0xF8D2, 0xBD00 }, { 0xF8D4, 0x00AA }, { 0xF8D6, 0xE0C0 },
+		{ 0xF8D8, 0xC502 }, { 0xF8DA, 0xBD00 }, { 0xF8DC, 0x0132 },
+	};
+
+	static const struct e_info_regmask_pair final_seq[] = {
+		{ 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
+		{ 0xFC32, 0x0C25 }, { 0xFC34, 0x00A9 }, { 0xFC36, 0x012D },
+	};
+
+	r8168_mac_ocp_write_seq(tp, init_zero_seq);
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
+	r8168_mac_ocp_write_seq(tp, recover_seq);
 
 	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
 
-	r8168_mac_ocp_write(tp, 0xFC2A, 0x0743);
-	r8168_mac_ocp_write(tp, 0xFC2C, 0x0801);
-	r8168_mac_ocp_write(tp, 0xFC2E, 0x0BE9);
-	r8168_mac_ocp_write(tp, 0xFC30, 0x02FD);
-	r8168_mac_ocp_write(tp, 0xFC32, 0x0C25);
-	r8168_mac_ocp_write(tp, 0xFC34, 0x00A9);
-	r8168_mac_ocp_write(tp, 0xFC36, 0x012D);
+	r8168_mac_ocp_write_seq(tp, final_seq);
+
 }
 
 static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
-- 
2.34.1

