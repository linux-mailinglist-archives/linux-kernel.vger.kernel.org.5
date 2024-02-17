Return-Path: <linux-kernel+bounces-70097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C0859300
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C6282236
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E480021;
	Sat, 17 Feb 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzfNmUxy"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E79657BE;
	Sat, 17 Feb 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205611; cv=none; b=XuiBpSQ4p9djO9uI1XTlAfBXdJSkPoENHmH5YCzh8pp1q+DraLrbfIhAkYzmRGqHGIWhoF6OJwiuAmWXOXa+s7RDl00PTxG3FHPgGCQeQ/fkM3jNNo9XPyQM3Ytbg4WrwL7fLfpJEOMrzadG/lzGi7+fpRt8YQoakf8mCzb038Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205611; c=relaxed/simple;
	bh=W7WDBdpI0W1SD+DUh8i2uivgdmTI+eJzbEwcUhLeIDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YVxBmgxmSuonIOZl2OBDKuCMB3wecqrfKoKdlDlapV7JxIHOUdITjzJVMrw0O9g+0c8KNyJ2yubWhB4hHv2vYVKQQq9HsZim/07Vj74v2tuEDX9KHMvWM/4wa5IdJbOLf0uv7cTu7Yov9YH7mQqTw0HKofp4GzioLCqPvdgEwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzfNmUxy; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2edb28554so630327a34.2;
        Sat, 17 Feb 2024 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708205608; x=1708810408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6OdQvfZWPkCPP6IxZ3j0oYw7gQEDMaRU3Htku/TCcA=;
        b=TzfNmUxyFhDH8l9Ad7OnWf2sv7jyWE6BJs9sfTFbK950j8KFTC6kyF49ANEp9/9JU1
         LqIZrGDqRqCOpmD/TaE2usn1IBJHnskxlCbiKKbrPp3mjal0M56fpCgUS3LnNvqNuW6f
         xph3poz43yvM6vo56wZEBHTksFcwbDWfSAK0OoqRtVJl4cObYOFCj7FRxCsN6Tig0Nzr
         M2N4Hd4jQq0CPiEZBIJu9NKMK1R2Inn4TrIDF99ONYLLe4MD0IKQSF2tCxFWA0EY7/Yu
         JDbzs3nZTx4M2xRI/nlkfFVK6PFzL9684jZe2FuSj/r5NY3PqppyQsWv8cWDHNl1oznD
         E/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708205608; x=1708810408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6OdQvfZWPkCPP6IxZ3j0oYw7gQEDMaRU3Htku/TCcA=;
        b=jTcyhYrCTLcANKXoP24skGCeJu7Iug/Q9L63RRSdCJYhQ8U+HTXXyqRsF+zgtqYtdC
         LT/g0GwqeC00SIXgjHE1w7gSp5t7bS26WDoUKBwMk3/DrONPQE/yKQ265WbV/jZSejBS
         DC21fwVtm+E0+33B8Dhk12dsovTwiuyuXdo8qo3lvi4cDgQgHy2pGgjhpmO43ywrInFJ
         zxm1sf89hSTaJ0oev47Lkk7TfyuuNfANmEZiMPZzFmd6ohG3oHIvGzhuTQcBUCBOMSuq
         gzRp1CvUW+iSZH93igFi+odbe6MTgCHZkvmd5yrZSmVs9VDP3FyFYc2XV23IZiGpbAel
         N/rg==
X-Forwarded-Encrypted: i=1; AJvYcCX6QknI81FTcNlVyMTRxC58AVrJhDBEnm9K7OMdNY8P3P37s6VYu08TvRQbESIamdTrbpWwanlHYT0oGVXU974QHcN4Su5f
X-Gm-Message-State: AOJu0Yzs7miu5ZajCCPBIJebIEeRp9HdfsROhX2aR3ScMPKGdIsjLtab
	hZCEYxuWUkbE8OAh1zopDIz7F0OMhKIpJu890Y8ff0Zw2s94ToKKD8Frz6pG
X-Google-Smtp-Source: AGHT+IGaiBV3UvQI3znupXLC5ZscoeRUTtm7pifKkLtuHGEth2LvY30khil6qI/QSWNaHQADisx+Ng==
X-Received: by 2002:a05:6830:104e:b0:6e2:f115:7d9e with SMTP id b14-20020a056830104e00b006e2f1157d9emr8042491otp.15.1708205608099;
        Sat, 17 Feb 2024 13:33:28 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a200:bbd0:b4db:67e4:beea:e21e])
        by smtp.gmail.com with ESMTPSA id b26-20020aa78eda000000b006e06b8548c3sm2034261pfr.139.2024.02.17.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:33:27 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xtensa: fix MAKE_PC_FROM_RA second argument
Date: Sat, 17 Feb 2024 13:33:18 -0800
Message-Id: <20240217213318.2122047-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xtensa has two-argument MAKE_PC_FROM_RA macro to convert a0 to an actual
return address because when windowed ABI is used call{,x}{4,8,12}
opcodes stuff encoded window size into the top 2 bits of the register
that becomes a return address in the called function. Second argument of
that macro is supposed to be an address having these 2 topmost bits set
correctly, but the comment suggested that that could be the stack
address. However the stack doesn't have to be in the same 1GByte region
as the code, especially in noMMU XIP configurations.

Fix the comment and use either _text or regs->pc as the second argument
for the MAKE_PC_FROM_RA macro.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/processor.h | 8 ++++----
 arch/xtensa/include/asm/ptrace.h    | 2 +-
 arch/xtensa/kernel/process.c        | 5 +++--
 arch/xtensa/kernel/stacktrace.c     | 3 ++-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index d008a153a2b9..7ed1a2085bd7 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -115,9 +115,9 @@
 #define MAKE_RA_FOR_CALL(ra,ws)   (((ra) & 0x3fffffff) | (ws) << 30)
 
 /* Convert return address to a valid pc
- * Note: We assume that the stack pointer is in the same 1GB ranges as the ra
+ * Note: 'text' is the address within the same 1GB range as the ra
  */
-#define MAKE_PC_FROM_RA(ra,sp)    (((ra) & 0x3fffffff) | ((sp) & 0xc0000000))
+#define MAKE_PC_FROM_RA(ra, text) (((ra) & 0x3fffffff) | ((unsigned long)(text) & 0xc0000000))
 
 #elif defined(__XTENSA_CALL0_ABI__)
 
@@ -127,9 +127,9 @@
 #define MAKE_RA_FOR_CALL(ra, ws)   (ra)
 
 /* Convert return address to a valid pc
- * Note: We assume that the stack pointer is in the same 1GB ranges as the ra
+ * Note: 'text' is not used as 'ra' is always the full address
  */
-#define MAKE_PC_FROM_RA(ra, sp)    (ra)
+#define MAKE_PC_FROM_RA(ra, text)  (ra)
 
 #else
 #error Unsupported Xtensa ABI
diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index a270467556dc..86c70117371b 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -87,7 +87,7 @@ struct pt_regs {
 # define user_mode(regs) (((regs)->ps & 0x00000020)!=0)
 # define instruction_pointer(regs) ((regs)->pc)
 # define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
-					       (regs)->areg[1]))
+					       (regs)->pc))
 
 # ifndef CONFIG_SMP
 #  define profile_pc(regs) instruction_pointer(regs)
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index a815577d25fd..7bd66677f7b6 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/regs.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/sections.h>
 #include <asm/traps.h>
 
 extern void ret_from_fork(void);
@@ -380,7 +381,7 @@ unsigned long __get_wchan(struct task_struct *p)
 	int count = 0;
 
 	sp = p->thread.sp;
-	pc = MAKE_PC_FROM_RA(p->thread.ra, p->thread.sp);
+	pc = MAKE_PC_FROM_RA(p->thread.ra, _text);
 
 	do {
 		if (sp < stack_page + sizeof(struct task_struct) ||
@@ -392,7 +393,7 @@ unsigned long __get_wchan(struct task_struct *p)
 
 		/* Stack layout: sp-4: ra, sp-3: sp' */
 
-		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), sp);
+		pc = MAKE_PC_FROM_RA(SPILL_SLOT(sp, 0), _text);
 		sp = SPILL_SLOT(sp, 1);
 	} while (count++ < 16);
 	return 0;
diff --git a/arch/xtensa/kernel/stacktrace.c b/arch/xtensa/kernel/stacktrace.c
index 831ffb648bda..ed324fdf2a2f 100644
--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/stacktrace.h>
 
 #include <asm/ftrace.h>
+#include <asm/sections.h>
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
 #include <linux/uaccess.h>
@@ -189,7 +190,7 @@ void walk_stackframe(unsigned long *sp,
 		if (a1 <= (unsigned long)sp)
 			break;
 
-		frame.pc = MAKE_PC_FROM_RA(a0, a1);
+		frame.pc = MAKE_PC_FROM_RA(a0, _text);
 		frame.sp = a1;
 
 		if (fn(&frame, data))
-- 
2.39.2


