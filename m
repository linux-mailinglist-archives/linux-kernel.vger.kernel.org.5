Return-Path: <linux-kernel+bounces-22215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE889829AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED7A1C20D79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5C487A4;
	Wed, 10 Jan 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iUpM9xzc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iUpM9xzc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF448794;
	Wed, 10 Jan 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA0981F8AB;
	Wed, 10 Jan 2024 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704892280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+Z6GZnazkXvmT3ykqKVkZG08FG2RukNYcIfqOb3XcwI=;
	b=iUpM9xzct678dCYvhoRdWNBfjO7m2Bzrp9+ZOD36Q1MUfFwUDVkxxFWMKWm0wlcOJpODuE
	4+wwDdJgUKkiUHR+e7xwCpZtjgKr6XDLk+x7ONRW8hjQIST9T3VOsDNDhIhaAC98EI83GN
	Q0aXN/ZdgzJqMfLLx7WaqjAAzahQ/6k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704892280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+Z6GZnazkXvmT3ykqKVkZG08FG2RukNYcIfqOb3XcwI=;
	b=iUpM9xzct678dCYvhoRdWNBfjO7m2Bzrp9+ZOD36Q1MUfFwUDVkxxFWMKWm0wlcOJpODuE
	4+wwDdJgUKkiUHR+e7xwCpZtjgKr6XDLk+x7ONRW8hjQIST9T3VOsDNDhIhaAC98EI83GN
	Q0aXN/ZdgzJqMfLLx7WaqjAAzahQ/6k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4427713786;
	Wed, 10 Jan 2024 13:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5dbcDTaVnmVhcwAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 10 Jan 2024 13:01:42 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: arnd@arndb.de,
	linux-api@vger.kernel.org,
	Richard Palethorpe <rpalethorpe@suse.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH RESEND] x86/entry/ia32: Ensure s32 is sign extended to s64
Date: Wed, 10 Jan 2024 15:01:22 +0200
Message-Id: <20240110130122.3836513-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [4.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.51%]
X-Spam-Score: 4.68
X-Spam-Level: ****
Authentication-Results: smtp-out2.suse.de;
	none

From: Richard Palethorpe <rpalethorpe@suse.com>

Presently ia32 registers stored in ptregs are unconditionally cast to
unsigned int by the ia32 stub. They are then cast to long when passed
to __se_sys*, but will not be sign extended.

This takes the sign of the syscall argument into account in the ia32
stub. It still casts to unsigned int to avoid implementation specific
behavior. However then casts to int or unsigned int as necessary. So
that the following cast to long sign extends the value.

This fixes the io_pgetevents02 LTP test when compiled with
-m32. Presently the systemcall io_pgetevents_time64 unexpectedly
accepts -1 for the maximum number of events. It doesn't appear other
systemcalls with signed arguments are effected because they all have
compat variants defined and wired up. A less general solution is to
wire up the systemcall:
https://lore.kernel.org/ltp/20210921130127.24131-1-rpalethorpe@suse.com/

Fixes: ebeb8c82ffaf ("syscalls/x86: Use 'struct pt_regs' based syscall calling for IA32_EMULATION and x32")
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---

This patch has been sent previously by Richard back in 2021 [0]. However it
seems to have been dropped at some point and never merged. So I'm resending again
to consider it for merging given that io_pgetevents_time64 LTP test still fails.


[0] https://lore.kernel.org/all/20210927161955.28494-1-rpalethorpe@suse.com/

 arch/x86/include/asm/syscall_wrapper.h | 25 +++++++++++++++++++++----
 include/linux/syscalls.h               |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 21f9407be5d3..7e88705e907f 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -58,12 +58,29 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		,,regs->di,,regs->si,,regs->dx				\
 		,,regs->r10,,regs->r8,,regs->r9)			\

+
+/* SYSCALL_PT_ARGS is Adapted from s390x */
+#define SYSCALL_PT_ARG6(m, t1, t2, t3, t4, t5, t6)			\
+	SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5), m(t6, (regs->bp))
+#define SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5)				\
+	SYSCALL_PT_ARG4(m, t1, t2, t3, t4),  m(t5, (regs->di))
+#define SYSCALL_PT_ARG4(m, t1, t2, t3, t4)				\
+	SYSCALL_PT_ARG3(m, t1, t2, t3),  m(t4, (regs->si))
+#define SYSCALL_PT_ARG3(m, t1, t2, t3)					\
+	SYSCALL_PT_ARG2(m, t1, t2), m(t3, (regs->dx))
+#define SYSCALL_PT_ARG2(m, t1, t2)					\
+	SYSCALL_PT_ARG1(m, t1), m(t2, (regs->cx))
+#define SYSCALL_PT_ARG1(m, t1) m(t1, (regs->bx))
+#define SYSCALL_PT_ARGS(x, ...) SYSCALL_PT_ARG##x(__VA_ARGS__)
+
+#define __SC_COMPAT_CAST(t, a)						\
+	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
+	(unsigned int)a
+
 /* Mapping of registers to parameters for syscalls on i386 */
 #define SC_IA32_REGS_TO_ARGS(x, ...)					\
-	__MAP(x,__SC_ARGS						\
-	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
-	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
-	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+	SYSCALL_PT_ARGS(x, __SC_COMPAT_CAST,				\
+			__MAP(x, __SC_TYPE, __VA_ARGS__))		\

 #define __SYS_STUB0(abi, name)						\
 	long __##abi##_##name(const struct pt_regs *regs);		\
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5c0dbef55792..80a059cab260 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -128,6 +128,7 @@ struct mnt_id_req;
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
 #define __SC_CAST(t, a)	(__force t) a
+#define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))

--
2.34.1


