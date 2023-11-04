Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FD97E1147
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjKDWQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKDWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:16:52 -0400
Received: from domac.alu.hr (unknown [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31436D7A;
        Sat,  4 Nov 2023 15:16:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 897D260171;
        Sat,  4 Nov 2023 23:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699136205; bh=CrbdyVCmCWG0SGlSA7DmmsOCMUXj24Dod3pLoTFHV+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDk/tLSzKjsNgWvSJujGdL/LZFR5s/YmxF22ShaJkgt3QiwlVTtbYdfLK4qa9v3ck
         UVdzd1p5HTVNkN0H1sOkuHJz8PALxrCOdXzBsx322uieJoEKDLgNWtk0IQra9C6HJr
         wmg1InP/PWqISh4MEk4TBTfb+vy4gUk1MAoD+MdfetzCsqIjeohf/yCVZNzuCMEsZJ
         5fCakIF/Wts1IQSFbT3WrmhGmxHnLRxhvpovSa0oZ79rfDUapxQtV2baUmefHmejLy
         C2bT0EhhAt4P9lFZ8JfJzGHZCinwhFkS/xeNw1nnhgwANqTehXSnmduS223aTrj/3g
         VLkp5Yhyg9paQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MrmrYUgvRO0w; Sat,  4 Nov 2023 23:16:43 +0100 (CET)
Received: from defiant.home (78-2-200-71.adsl.net.t-com.hr [78.2.200.71])
        by domac.alu.hr (Postfix) with ESMTPSA id 0A25B60177;
        Sat,  4 Nov 2023 23:16:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1699136203; bh=CrbdyVCmCWG0SGlSA7DmmsOCMUXj24Dod3pLoTFHV+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDvl9W8JRpFXRsATAG+BaoWQySFv52qDnjjlsHN4EJPSMLGyeGtzKKuN1EdbWyzp4
         es9eN+9ezHBdY/YVuXoRbVxcYDt01G8Gw8ClAgujgU6K1q581zbyzAHx/RWmhKdM/A
         eLMa7ncRK+J9hiajsa69zDDkiIWJyuQEwfQn175K/r4X6bcf86QO4m5zZMZEMlknFf
         MjA+/ZPEEOgF6H7OI5jsqWC+yh0QLszKj0dSF7KL4oNrUeGs3NS8DmVIR1yabMQX2I
         eGnelaBeg7ZxP1RBboSKGOUxO+PdWQrAMBCZbrYIH0djZWh6o8hDN8eKNgKCZnRnv+
         OWKvOi9pNjbfQ==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Marco Elver <elver@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 1/5] r8169: Coalesce r8169_mac_ocp_write/modify calls to reduce spinlock stalls
Date:   Sat,  4 Nov 2023 23:15:13 +0100
Message-Id: <20231104221514.45821-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pair of new helpers r8168_mac_ocp_write_seq() and r8168_mac_ocp_modify_seq()
are introduced.

They are meant to minimise the locking and unlocking overhead when just assuring
the sequential mac ocp register programming according to the Realtek specs would do.
The latter is assured by the compiler optimisation "barrier" in the writev() call
called by the low-level RTL_W32() primitive.

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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
v6:
 proceeded according to Jacob Keller's suggestions by creating a cover page and reducing
 the text within the commits. Applying to the net-next tree as Heiner Kallweit requested.

v5:
 attempted some new optimisations, which were rejected, but not all and not completely.

v4:
 fixed complaints as advised by Heiner and checkpatch.pl.
 split the patch into five sections to be more easily manipulated and reviewed
 introduced r8168_mac_ocp_write_seq()
 applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B

v3:
 removed register/mask pair array sentinels, so using ARRAY_SIZE().
 avoided duplication of RTL_W32() call code as advised by Heiner.

 drivers/net/ethernet/realtek/r8169_main.c | 57 +++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a987defb575c..e39b5777d67b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -939,6 +939,63 @@ static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
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
+	u16 data;
+
+	for (p = array; len--; p++) {
+		data = __r8168_mac_ocp_read(tp, p->reg);
+		__r8168_mac_ocp_write(tp, p->reg, (data & ~p->mask) | p->set);
+	}
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

