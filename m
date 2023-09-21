Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82E87A9117
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjIUCvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjIUCu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:50:59 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55304EA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:50:50 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38L2oi9T059298;
        Thu, 21 Sep 2023 10:50:44 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Sep 2023
 10:50:39 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <conor.dooley@microchip.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v4 3/3] riscv: Introduce NAPOT field to PTDUMP
Date:   Thu, 21 Sep 2023 10:50:22 +0800
Message-ID: <20230921025022.3989723-4-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025022.3989723-1-peterlin@andestech.com>
References: <20230921025022.3989723-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38L2oi9T059298
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the NAPOT field to PTDUMP, allowing it
to display the letter "N" for pages that have the 63rd bit set.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Changes v1 -> v3
- no change
Changes v3 -> v4
- Include Alexandre's RB/TB-tags
---
 arch/riscv/mm/ptdump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 13997cf3fe36..b71f08b91e53 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -136,6 +136,10 @@ struct prot_bits {
 static const struct prot_bits pte_bits[] = {
 	{
 #ifdef CONFIG_64BIT
+		.mask = _PAGE_NAPOT,
+		.set = "N",
+		.clear = ".",
+	}, {
 		.mask = _PAGE_MTMASK_SVPBMT,
 		.set = "MT(%s)",
 		.clear = "  ..  ",
-- 
2.34.1

