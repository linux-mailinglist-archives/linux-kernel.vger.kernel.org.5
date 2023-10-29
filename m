Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE27DADBA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJ2Sm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2SmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:42:23 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BDBC;
        Sun, 29 Oct 2023 11:42:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5843560187;
        Sun, 29 Oct 2023 19:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698604937; bh=aGnuUMcaiZKyu6bxd0gchGWjjPRuLHhYcfTW+nYpD4s=;
        h=From:To:Cc:Subject:Date:From;
        b=y877EDNJQzI9JIXiUlWCazdj+b4MMqsdq0bFqrO2rUhZ03UL4zD7xLuJhC1O8qrLs
         nch/gc7UfcU7LnuAJA6glsXD+vQS/jYEGDFOo6SJxrQ957REI6/NcD3S3F5qhQxcgT
         fbvclOGxQhpH2+Ut8LfTHIa1HA5dSx6o+AfGWPTFQVO1BWaNlf5P+tFfzhGU3UXN2r
         Cny24dOrz96lGwnGEgXD+gT2W2WoEugXWiNC4Da9vlVSwv0lrSSOsQrf42vNLlQxkg
         PzX6/xNjvqp4bL86aISd3ZrY4ymNlQazFQuxOBu6zc3WLUcFC+cYdHpeso+awcVkS6
         orZpeMMpeaA5w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b2ku-x8BoIkh; Sun, 29 Oct 2023 19:42:14 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
        by domac.alu.hr (Postfix) with ESMTPSA id 7982E60173;
        Sun, 29 Oct 2023 19:42:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698604934; bh=aGnuUMcaiZKyu6bxd0gchGWjjPRuLHhYcfTW+nYpD4s=;
        h=From:To:Cc:Subject:Date:From;
        b=HsvHeQ7yq9Szwl4hvaxE8a4VLqpAv0B+NaVAGWA11ZuW2w7Bmg0Dy5rZBa3R+jyxn
         zC2u7Pglbh1aMUD5V5hNWPbIa+4kICgNACg8fKUiVYloqyf/zfkXLn+imEsT4/ZRoH
         k2c+ZjIR5hUO1AbAuFfZpB2OpM3wJA7bgZNiXEITVGXgFcue3488iO6KrZKK+CLBle
         5WVh3ewa0gtEGUAncXgQVip5tU8acc9ZlBliH2TwOKtRSU9DxX2mIdNUFBXZSTVVyd
         +X3OlgYYSpsRbmmxsed4/+VPgKKYGO5QK1iPF+xR5zEtE+dEt58+l3Yic5o/wGlX04
         l3RDk8wdD5Ogw==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>
Subject: [PATCH v5 1/7] r8169: Add r8169_mac_ocp_(write|modify)_seq helpers to reduce spinlock contention
Date:   Sun, 29 Oct 2023 19:35:55 +0100
Message-Id: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
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

A pair of new helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq()
are introduced.

The motivation for these helpers was the locking overhead of 130 consecutive
r8168_mac_ocp_write() calls in the RTL8411b reset after the NIC gets confused
if the PHY is powered-down.

To quote Heiner:

    On RTL8411b the RX unit gets confused if the PHY is powered-down.
    This was reported in [0] and confirmed by Realtek. Realtek provided
    a sequence to fix the RX unit after PHY wakeup.

A series of about 130 r8168_mac_ocp_write() calls is performed to program the
RTL registers for recovery, each doing an expensive spin_lock_irqsave() and
spin_unlock_irqrestore().

Each mac ocp write is made of:

    static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
		      u32 data)
    {
	if (rtl_ocp_reg_failure(reg))
	    return;

	RTL_W32(tp, OCPDR, OCPAR_FLAG | (reg << 15) | data);
    }

    static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg,
		    u32 data)
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

This means a whole lot of memory bus stalls: for spin_lock_irqsave(),
memory barrier, writel(), and spin_unlock_irqrestore().

With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
a lock storm that will stall all of the cores and CPUs on the same memory controller
for certain time I/O takes to finish.

In a sequential case of RTL register programming, the writes to RTL registers
can be coalesced under a same raw spinlock. This can dramatically decrease the
number of bus stalls in a multicore or multi-CPU system.

Macro helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq() are
provided to reduce lock contention:

    static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
    {

	...

	/* The following Realtek-provided magic fixes an issue with the RX unit
	 * getting confused after the PHY having been powered-down.
	 */

	static const struct recover_8411b_info init_zero_seq[] = {
	    { 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 },
	    ...
	};

	...

	r8168_mac_ocp_write_seq(tp, init_zero_seq);

	...

    }

The hex data is preserved intact through s/r8168_mac_ocp_write[(]tp,/{ / and s/[)];/ },/
functions that only changed the function names and the ending of the line, so the actual
hex data is unchanged.

To repeat, the reason for the introduction of the original commit
was to enable recovery of the RX unit on the RTL8411b which was confused by the
powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
into a series of about 500+ memory bus locks, most waiting for the main memory read,
modify and write under a LOCK. The memory barrier in RTL_W32 should suffice for
the programming sequence to reach RTL NIC registers.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1692075

Fixes: fe4e8db0392a6 ("r8169: fix issue with confused RX unit after PHY power-down on RTL8411b")
Fixes: 91c8643578a21 ("r8169: use spinlock to protect mac ocp register access")
Fixes: d6c36cbc5e533 ("r8169: Use a raw_spinlock_t for the register locks.")
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
Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v5:
 added unlocked primitives to allow mac ocs modify grouping
 applied coalescing of mac ocp writes/modifies for 8168ep and 8117
 some formatting fixes to please checkpatch.pl

v4:
 fixed complaints as advised by Heiner and checkpatch.pl
 split the patch into five sections to be more easily manipulated and reviewed
 introduced r8168_mac_ocp_write_seq()
 applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B

v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 71 +++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 361b90007148..da1f5d1b4fd5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -888,7 +888,7 @@ static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
 }
 
-static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
+static inline void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 {
 	if (rtl_ocp_reg_failure(reg))
 		return;
@@ -905,7 +905,7 @@ static void r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 }
 
-static u16 __r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
+static inline u16 __r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
 {
 	if (rtl_ocp_reg_failure(reg))
 		return 0;
@@ -927,18 +927,79 @@ static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
 	return val;
 }
 
+static inline void __r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
+					  u16 set)
+{
+	u16 data;
+
+	data = __r8168_mac_ocp_read(tp, reg);
+	__r8168_mac_ocp_write(tp, reg, (data & ~mask) | set);
+}
+
 static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
 				 u16 set)
 {
 	unsigned long flags;
-	u16 data;
 
 	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
-	data = __r8168_mac_ocp_read(tp, reg);
-	__r8168_mac_ocp_write(tp, reg, (data & ~mask) | set);
+	__r8168_mac_ocp_modify(tp, reg, mask, set);
 	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
 }
 
+struct e_info_regdata {
+	u32	reg;
+	u32	data;
+};
+
+struct e_info_regmaskset {
+	u32	reg;
+	u16	mask;
+	u16	set;
+};
+
+static void __r8168_mac_ocp_write_seqlen(struct rtl8169_private *tp,
+					 const struct e_info_regdata *array, int len)
+{
+	struct e_info_regdata const *p;
+
+	for (p = array; len--; p++)
+		__r8168_mac_ocp_write(tp, p->reg, p->data);
+}
+
+static void r8168_mac_ocp_write_seqlen(struct rtl8169_private *tp,
+				       const struct e_info_regdata *array, int len)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_write_seqlen(tp, array, len);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
+}
+
+static void __r8168_mac_ocp_modify_seqlen(struct rtl8169_private *tp,
+					  const struct e_info_regmaskset *array, int len)
+{
+	struct e_info_regmaskset const *p;
+
+	for (p = array; len--; p++)
+		__r8168_mac_ocp_modify(tp, p->reg, p->mask, p->set);
+}
+
+static void r8168_mac_ocp_modify_seqlen(struct rtl8169_private *tp,
+					const struct e_info_regmaskset *array, int len)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
+	__r8168_mac_ocp_modify_seqlen(tp, array, len);
+	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
+}
+
+#define r8168_mac_ocp_write_seq(tp, a) r8168_mac_ocp_write_seqlen(tp, a, ARRAY_SIZE(a))
+#define r8168_mac_ocp_modify_seq(tp, a) r8168_mac_ocp_modify_seqlen(tp, a, ARRAY_SIZE(a))
+#define __r8168_mac_ocp_write_seq(tp, a) __r8168_mac_ocp_write_seqlen(tp, a, ARRAY_SIZE(a))
+#define __r8168_mac_ocp_modify_seq(tp, a) __r8168_mac_ocp_modify_seqlen(tp, a, ARRAY_SIZE(a))
+
 /* Work around a hw issue with RTL8168g PHY, the quirk disables
  * PHY MCU interrupts before PHY power-down.
  */
-- 
2.34.1

