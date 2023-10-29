Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF37DADBC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjJ2SnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjJ2SnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:43:00 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B8F1;
        Sun, 29 Oct 2023 11:42:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 67A5660182;
        Sun, 29 Oct 2023 19:42:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698604972; bh=B8EyPD13t0g4ymcG9S08wKsseiSx/0aDmoV19bBvwDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKsg9u6NH2Iai9IcC6r9Yw5jWWhcb6csGeQafdHi/p1i1+/nimcnyYMCFSiVYJL+J
         4Yr5BwZe3Lx3hEKXzQmjlY8AtDLWBOt8j7N7W6zQ7mkjf1qb2hLG3fnUlPyU3WjIVg
         9FzK1bJFNzgfuLHYhYH1IHrgGo6mo2Focv/f/jE1wNYy8PfnKxroO6QMyxZvFrTidA
         HU8L2QiN703KC72OB9M/03mEvG0hOy6ziqlSgRim1mhJTDpdk3RC51j+RLNUX8DPS2
         9k0XiR9j6zPjEy9sloumBNIa1V84UpOZq264iwTlPIFlqZHzngFIF6GlTofKA4hglW
         pquFESRDYFhVA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wLjCM5r6q6f3; Sun, 29 Oct 2023 19:42:49 +0100 (CET)
Received: from defiant.home (78-3-40-247.adsl.net.t-com.hr [78.3.40.247])
        by domac.alu.hr (Postfix) with ESMTPSA id 5C64C60173;
        Sun, 29 Oct 2023 19:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698604969; bh=B8EyPD13t0g4ymcG9S08wKsseiSx/0aDmoV19bBvwDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yttPFTlD3pLdXVG2omdqsYw0aZSZioMM62UzKHraLYmh0CDCkpex9C9kMfh63gory
         wy8RHw4ROSL3+DlO+u5jfOgrVikc5dNdY/jp5naOBFVai3kUVnZ3OO+d/EmxvPqkBQ
         UhApBSkc7S84pSWlw5xh4w53tvZvy0mR8LMPKifaXUts/d9J2bu5dOKwn9oTNOQi8N
         fG00ZLbBM5/yWYvXYnt2zj/rs6wNoNlc81iSQDE6cNd9+qvSPEd8xvmA6nsESBK/sX
         WhhQt521Nny2hvT6PWVu365n/jOr6Bz+pU/M8XiyyTMvaZ5wNHFkAXN+69POERhkyM
         /zxRHxc7LMX2Q==
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
Subject: [PATCH v5 2/7] r8169: Coalesce RTL8411b PHY power-down recovery calls to reduce spinlock contention
Date:   Sun, 29 Oct 2023 19:35:57 +0100
Message-Id: <20231029183600.451694-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
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

With about 130 of these sequential calls to r8168_mac_ocp_write() this looks like
a lock storm that will stall all of the cores and CPUs on the same memory controller
for certain time I/O takes to finish.

In a sequential case of RTL register programming, a sequence of writes to the RTL
registers can be coalesced under a same raw spinlock. This can dramatically decrease
the number of bus stalls in a multicore or multi-CPU system:

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

    static const struct recover_8411b_info recover_seq[] = {
	{ 0xF800, 0xE008 }, { 0xF802, 0xE00A }, { 0xF804, 0xE00C },
	...
    };

    static const struct recover_8411b_info final_seq[] = {
	{ 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 },
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

Note that the reason for the introduction of the original commit
was to enable recovery of the RX unit on the RTL8411b which was confused by the
powered-down PHY. This sequence of r8168_mac_ocp_write() calls amplifies the problem
into a series of about 500+ memory bus locks, most waiting for the main MMIO memory
read-modify-write under a LOCK. The memory barrier in RTL_W32 should suffice for
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

 drivers/net/ethernet/realtek/r8169_main.c | 173 ++++++----------------
 1 file changed, 46 insertions(+), 127 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index da1f5d1b4fd5..f4a1d1a74b8b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3161,145 +3161,64 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
 		{ 0x1d, 0x0000,	0x4000 },
 	};
 
-	rtl_hw_start_8168g(tp);
+	static const struct e_info_regdata init_zero_seq[] = {
+		{ 0xFC28, 0x0000 }, { 0xFC2A, 0x0000 }, { 0xFC2C, 0x0000 }, { 0xFC2E, 0x0000 },
+		{ 0xFC30, 0x0000 }, { 0xFC32, 0x0000 }, { 0xFC34, 0x0000 }, { 0xFC36, 0x0000 },
+	};
 
+	static const struct e_info_regdata recover_seq[] = {
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
+	static const struct e_info_regdata final_seq[] = {
+		{ 0xFC2A, 0x0743 }, { 0xFC2C, 0x0801 }, { 0xFC2E, 0x0BE9 }, { 0xFC30, 0x02FD },
+		{ 0xFC32, 0x0C25 }, { 0xFC34, 0x00A9 }, { 0xFC36, 0x012D },
+	};
+
+	rtl_hw_start_8168g(tp);
 	rtl_ephy_init(tp, e_info_8411_2);
 
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

