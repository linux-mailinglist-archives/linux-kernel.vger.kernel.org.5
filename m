Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9E80ED1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376667AbjLLNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376616AbjLLNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:17:18 -0500
Received: from fzi-msx-e-02.fzi.de (fzi-msx-e-02.fzi.de [141.21.8.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A710D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:17:18 -0800 (PST)
From:   Frederik Haxel <haxel@fzi.de>
CC:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Frederik Haxel <haxel@fzi.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Sami Tolvanen" <samitolvanen@google.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Nam Cao <namcaov@gmail.com>, Guo Ren <guoren@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Baoquan He <bhe@redhat.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] riscv: Fixed wrong register in XIP_FIXUP_FLASH_OFFSET macro
Date:   Tue, 12 Dec 2023 14:01:13 +0100
Message-ID: <20231212130116.848530-3-haxel@fzi.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212130116.848530-1-haxel@fzi.de>
References: <20231212130116.848530-1-haxel@fzi.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [141.21.46.139]
X-ClientProxiedBy: fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45) To
 fzi-msx-05.fzi.de (2001:67c:2acc:8:141:21:17:45)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the refactoring, a bug was introduced in the rarly used
XIP_FIXUP_FLASH_OFFSET macro.

Fixes: bee7fbc38579 ("RISC-V CPU Idle Support")
Fixes: e7681beba992 ("RISC-V: Split out the XIP fixups into their own file")

Signed-off-by: Frederik Haxel <haxel@fzi.de>
---
 arch/riscv/include/asm/xip_fixup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
index d4ffc3c37649..b65bf6306f69 100644
--- a/arch/riscv/include/asm/xip_fixup.h
+++ b/arch/riscv/include/asm/xip_fixup.h
@@ -13,7 +13,7 @@
         add \reg, \reg, t0
 .endm
 .macro XIP_FIXUP_FLASH_OFFSET reg
-	la t1, __data_loc
+	la t0, __data_loc
 	REG_L t1, _xip_phys_offset
 	sub \reg, \reg, t1
 	add \reg, \reg, t0
-- 
2.34.1

