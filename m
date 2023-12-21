Return-Path: <linux-kernel+bounces-8406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644D81B6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDB4281987
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D62278E70;
	Thu, 21 Dec 2023 12:54:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F078E69;
	Thu, 21 Dec 2023 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=alpha.franken.de
Received: from hutton.arch.nue2.suse.org (unknown [10.168.144.140])
	by smtp-out1.suse.de (Postfix) with ESMTP id F40F421E19;
	Thu, 21 Dec 2023 12:54:04 +0000 (UTC)
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: Allow vectored interrupt handler to reside everywhere for 64bit
Date: Thu, 21 Dec 2023 13:54:03 +0100
Message-Id: <20231221125405.229100-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.90
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ****
X-Spam-Flag: NO

Setting up vector interrupts worked only with handlers, which resided
in CKSEG0 space. This limits the kernel placement for 64bit platforms.
By patching in the offset into vi_handlers[] instead of the full
handler address, the vectored exception handler can load the
address by itself and jump to it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/kernel/genex.S | 8 ++++----
 arch/mips/kernel/traps.c | 9 +++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index b6de8e88c1bd..a572ce36a24f 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -272,18 +272,17 @@ NESTED(except_vec_vi, 0, sp)
 	.set	push
 	.set	noreorder
 	PTR_LA	v1, except_vec_vi_handler
-FEXPORT(except_vec_vi_lui)
-	lui	v0, 0		/* Patched */
 	jr	v1
 FEXPORT(except_vec_vi_ori)
-	 ori	v0, 0		/* Patched */
+	 ori	v0, zero, 0		/* Offset in vi_handlers[] */
 	.set	pop
 	END(except_vec_vi)
 EXPORT(except_vec_vi_end)
 
 /*
  * Common Vectored Interrupt code
- * Complete the register saves and invoke the handler which is passed in $v0
+ * Complete the register saves and invoke the handler, $v0 holds
+ * offset into vi_handlers[]
  */
 NESTED(except_vec_vi_handler, 0, sp)
 	SAVE_TEMP
@@ -331,6 +330,7 @@ NESTED(except_vec_vi_handler, 0, sp)
 	/* Save task's sp on IRQ stack so that unwinding can follow it */
 	LONG_S	s1, 0(sp)
 2:
+	PTR_L	v0, vi_handlers(v0)
 	jalr	v0
 
 	/* Restore sp */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 246c6a6b0261..d90b18908692 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2091,16 +2091,14 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		 * If no shadow set is selected then use the default handler
 		 * that does normal register saving and standard interrupt exit
 		 */
-		extern const u8 except_vec_vi[], except_vec_vi_lui[];
+		extern const u8 except_vec_vi[];
 		extern const u8 except_vec_vi_ori[], except_vec_vi_end[];
 		extern const u8 rollback_except_vec_vi[];
 		const u8 *vec_start = using_rollback_handler() ?
 				      rollback_except_vec_vi : except_vec_vi;
 #if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
-		const int lui_offset = except_vec_vi_lui - vec_start + 2;
 		const int ori_offset = except_vec_vi_ori - vec_start + 2;
 #else
-		const int lui_offset = except_vec_vi_lui - vec_start;
 		const int ori_offset = except_vec_vi_ori - vec_start;
 #endif
 		const int handler_len = except_vec_vi_end - vec_start;
@@ -2119,10 +2117,9 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 #else
 				handler_len);
 #endif
-		h = (u16 *)(b + lui_offset);
-		*h = (handler >> 16) & 0xffff;
+		/* insert offset into vi_handlers[] */
 		h = (u16 *)(b + ori_offset);
-		*h = (handler & 0xffff);
+		*h = n * sizeof(handler);
 		local_flush_icache_range((unsigned long)b,
 					 (unsigned long)(b+handler_len));
 	}
-- 
2.35.3


