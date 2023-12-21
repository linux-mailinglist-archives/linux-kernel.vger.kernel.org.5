Return-Path: <linux-kernel+bounces-8408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4181B6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9011C23B32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBA78E9C;
	Thu, 21 Dec 2023 12:54:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1987319C;
	Thu, 21 Dec 2023 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=alpha.franken.de
Received: from hutton.arch.nue2.suse.org (unknown [10.168.144.140])
	by smtp-out1.suse.de (Postfix) with ESMTP id 881EF21E29;
	Thu, 21 Dec 2023 12:54:25 +0000 (UTC)
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: Remove unused shadow GPR support from vector irq setup
Date: Thu, 21 Dec 2023 13:54:04 +0100
Message-Id: <20231221125405.229100-2-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221125405.229100-1-tsbogend@alpha.franken.de>
References: <20231221125405.229100-1-tsbogend@alpha.franken.de>
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

Using shadow GPRs for vectored interrupts has never been used,
time to remove it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/kernel/traps.c | 94 +++++++++++++---------------------------
 1 file changed, 30 insertions(+), 64 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d90b18908692..c1b2b18b0505 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2055,105 +2055,71 @@ static void do_default_vi(void)
 	panic("Caught unexpected vectored interrupt.");
 }
 
-static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
+void *set_vi_handler(int n, vi_handler_t addr)
 {
+	extern const u8 except_vec_vi[];
+	extern const u8 except_vec_vi_ori[], except_vec_vi_end[];
+	extern const u8 rollback_except_vec_vi[];
 	unsigned long handler;
 	unsigned long old_handler = vi_handlers[n];
 	int srssets = current_cpu_data.srsets;
 	u16 *h;
 	unsigned char *b;
+	const u8 *vec_start;
+	int ori_offset;
+	int handler_len;
 
 	BUG_ON(!cpu_has_veic && !cpu_has_vint);
 
 	if (addr == NULL) {
 		handler = (unsigned long) do_default_vi;
-		srs = 0;
 	} else
 		handler = (unsigned long) addr;
 	vi_handlers[n] = handler;
 
 	b = (unsigned char *)(ebase + 0x200 + n*VECTORSPACING);
 
-	if (srs >= srssets)
-		panic("Shadow register set %d not supported", srs);
-
 	if (cpu_has_veic) {
 		if (board_bind_eic_interrupt)
-			board_bind_eic_interrupt(n, srs);
+			board_bind_eic_interrupt(n, 0);
 	} else if (cpu_has_vint) {
 		/* SRSMap is only defined if shadow sets are implemented */
 		if (srssets > 1)
-			change_c0_srsmap(0xf << n*4, srs << n*4);
+			change_c0_srsmap(0xf << n*4, 0 << n*4);
 	}
 
-	if (srs == 0) {
-		/*
-		 * If no shadow set is selected then use the default handler
-		 * that does normal register saving and standard interrupt exit
-		 */
-		extern const u8 except_vec_vi[];
-		extern const u8 except_vec_vi_ori[], except_vec_vi_end[];
-		extern const u8 rollback_except_vec_vi[];
-		const u8 *vec_start = using_rollback_handler() ?
-				      rollback_except_vec_vi : except_vec_vi;
+	vec_start = using_rollback_handler() ? rollback_except_vec_vi :
+					       except_vec_vi;
 #if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
-		const int ori_offset = except_vec_vi_ori - vec_start + 2;
+	ori_offset = except_vec_vi_ori - vec_start + 2;
 #else
-		const int ori_offset = except_vec_vi_ori - vec_start;
+	ori_offset = except_vec_vi_ori - vec_start;
 #endif
-		const int handler_len = except_vec_vi_end - vec_start;
+	handler_len = except_vec_vi_end - vec_start;
 
-		if (handler_len > VECTORSPACING) {
-			/*
-			 * Sigh... panicing won't help as the console
-			 * is probably not configured :(
-			 */
-			panic("VECTORSPACING too small");
-		}
-
-		set_handler(((unsigned long)b - ebase), vec_start,
-#ifdef CONFIG_CPU_MICROMIPS
-				(handler_len - 1));
-#else
-				handler_len);
-#endif
-		/* insert offset into vi_handlers[] */
-		h = (u16 *)(b + ori_offset);
-		*h = n * sizeof(handler);
-		local_flush_icache_range((unsigned long)b,
-					 (unsigned long)(b+handler_len));
-	}
-	else {
+	if (handler_len > VECTORSPACING) {
 		/*
-		 * In other cases jump directly to the interrupt handler. It
-		 * is the handler's responsibility to save registers if required
-		 * (eg hi/lo) and return from the exception using "eret".
+		 * Sigh... panicing won't help as the console
+		 * is probably not configured :(
 		 */
-		u32 insn;
-
-		h = (u16 *)b;
-		/* j handler */
-#ifdef CONFIG_CPU_MICROMIPS
-		insn = 0xd4000000 | (((u32)handler & 0x07ffffff) >> 1);
-#else
-		insn = 0x08000000 | (((u32)handler & 0x0fffffff) >> 2);
-#endif
-		h[0] = (insn >> 16) & 0xffff;
-		h[1] = insn & 0xffff;
-		h[2] = 0;
-		h[3] = 0;
-		local_flush_icache_range((unsigned long)b,
-					 (unsigned long)(b+8));
+		panic("VECTORSPACING too small");
 	}
 
+	set_handler(((unsigned long)b - ebase), vec_start,
+#ifdef CONFIG_CPU_MICROMIPS
+			(handler_len - 1));
+#else
+			handler_len);
+#endif
+	/* insert offset into vi_handlers[] */
+	h = (u16 *)(b + ori_offset);
+	*h = n * sizeof(handler);
+	local_flush_icache_range((unsigned long)b,
+				 (unsigned long)(b+handler_len));
+
 	return (void *)old_handler;
 }
 
-void *set_vi_handler(int n, vi_handler_t addr)
-{
-	return set_vi_srs_handler(n, addr, 0);
-}
-
 extern void tlb_init(void);
 
 /*
-- 
2.35.3


