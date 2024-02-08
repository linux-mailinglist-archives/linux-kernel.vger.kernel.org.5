Return-Path: <linux-kernel+bounces-58639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADB84E934
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C85C1C226C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45338FA3;
	Thu,  8 Feb 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bDgbDMeD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E438DEC;
	Thu,  8 Feb 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422204; cv=none; b=pM3hLnWWQNMjogXo6/eiu9YMB6UC0jB9F1OsEdfpE55kYzQ1L6+PzBNjR2S7BakRCF1RSqeFigIOCk2Af4sKvIYfGI+CbB59Yme/4YfZbjhTUi9WYrEJHTUlh8Jxc5UtZqLfLIG5nYlDwSouroBmbH/nNQkHSFXhtgMJ6qinYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422204; c=relaxed/simple;
	bh=j1I5kpWwSWg548d9NXswfDfkER7xMeQtY2gApAk2QCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N9sVfSc0FoqeiUYqlGxxiL2ESnt+8EDiA3v0UBE+nJu+g0SkZ4kL+q0JxEXJhEgbqZpOBaIY8f8NS0FV8+IOBI/zTsIZ9p1jJUVQTbqJhNLpMWZBwhSzdAjcmI4oP2Mg0UsFUaTNQY83CB9fL07eeuxmYo3UhbI1rpLpxFTdx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bDgbDMeD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7393de183so1391935ad.3;
        Thu, 08 Feb 2024 11:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422202; x=1708027002;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bops73Z10So2AancqU77nOPuYiQN552BbpikpAwJez4=;
        b=TMFn6yswzmh5Milm0WewGcxoB4aUL59nsEPtqy8L9JdM1i82HuKcd/yCWrrCNNhRTK
         qfoO/YTZy7PR2eEWqFEQlyvgGtt/2TxDialGUbRWCVCH3B3f+YWK+EKzntGYgjmdH8as
         2pwBmyU0gsbB2TpC6KD4iVwKBpzbcOZYhsRl4wia+RxROIPSS3efyk2RxpcY8LJjweFG
         A4BoiQB+2H3Dxpv0BaWSW4YTWTLi7ivcRorGEnFnX2FfLJKF8qiQcHoWw9xnzknWWKB3
         JPXw6tl8FOEuFu9IOpSsudgL3+VoZj6oSo4VOR3Q0DL0VbhlKortF6/0EvS+4L981d0K
         +jUg==
X-Forwarded-Encrypted: i=1; AJvYcCVUtM1JzpaoYosDrn9cb47vy4jVFZjKmKvtFcUEUyx/wks+XSCHKKpGIoSVZ++u6pQr+0P83SE5lNc5B0a+p1GBHXy+F1y4KUmlbH0I
X-Gm-Message-State: AOJu0Yzyt2dVqEkx3KAfuEk1xN4idOEM4/0l0Wdp3FxZ3hWTm4RQQekL
	0OXCxvsUhyDHyNQh25eDv88WZ/vD2qG2TqVB2ahDifVe+BmqgPRcmQusQB4d9SG7xg==
X-Google-Smtp-Source: AGHT+IEE1/GRuOqtZJRs291P5vgM2puJndryr9Yh03TdEuIZLPJJVzSD4ftxCFYOkVF/3Lk5glsqtg==
X-Received: by 2002:a17:902:7842:b0:1d9:40f3:ada8 with SMTP id e2-20020a170902784200b001d940f3ada8mr226054pln.3.1707422202446;
        Thu, 08 Feb 2024 11:56:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWJCZdWVhQ30TqcijCf5gcx1CPwe75RLwOuaInQj3+BpMdNZd6hvAZYxmLVp+XwZPDWdxgIt8+9nWECjJB5MqOu4cSM7a5JIhChOovo8SyCSNzYU8BHd06SVc5/4DWABs1wW1Fi+C4Dbuh70P6rDSl/RE0+8zwtgXA9PnHTSG+fxCKikc/dHJmY2j6UL1P3cdrG8NJO9SZGxEcxb6ZkTV0HtoQoqMwdWle01I=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001d9f1b293dcsm148333plb.88.2024.02.08.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:56:41 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707422200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bops73Z10So2AancqU77nOPuYiQN552BbpikpAwJez4=;
	b=bDgbDMeDaz9laUJrZ/gnlXSKMIibtmdflZBrmWnvlwel3vFAnf228pexmkGf7XKGCvSVnZ
	dM0VfEZWJXJST2SrvYFrNH3TQZbQeUg56KGlr2GFdphV3e3H7cTmgOasQ9ca/cgU3v5gIO
	XHr999QGBcpr9HV9LAze+qhdWIbsjBAp+xweyTNTwes/wge8Ln4mhwvN4VPt6KZyiTixG+
	w3/WP+7DUn2y8nnYXpCrpghPUYmSd3LpnKRX9DlCiB5r854bkn8GAXexnWo3KijmK+KtId
	YUxmfSMdKfBbb3UfRbBpnqoOBGarV7VdriEr3dhVK/Jv5lqokW3MxurazOFerw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 08 Feb 2024 16:56:52 -0300
Subject: [PATCH] sh: intc: make intc_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-bus_cleanup-sh2-v1-1-729277400893@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAMyxWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwML3aTS4vjknNTEvNIC3eIMI13jtGRjQzNTiyRLw0QloK6CotS0zAq
 widGxtbUAjFvvG2EAAAA=
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6092; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=j1I5kpWwSWg548d9NXswfDfkER7xMeQtY2gApAk2QCM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxTIZLpqjaahZCe6xU3ErdEH7WfyS6ZdcPuPH2
 B2Q3HrFvjGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcUyGQAKCRDJC4p8Y4ZY
 pnxREACSs63FbHmNFyJHjXk2GZNhbPiENhjm+6NEp7uMXVqo3caexxT0Vx9yu1HSAFNaK5EVO+A
 LrT6gS0rurOor7wFLeiblOXfsx0Q/VIcTK/StATwowAFzHELW0TGpxMFFQWXrljdDlOM3aPmyvM
 jpkMm3eR4OAsQQJ2MXwPkdjrFnOPrwfsAasqseb18jEmPNaneB4VDKNGS0ggm4jyMzVEMqgoJtf
 s1ZCetvGSVhlMJy6OQusIMfcLnh4+wLQcTOPZdHA5Lsbx2dMANM84gZQXdB7U4F1gqZDURZlu3m
 Z5vp+C2d7cQVPqO4Lv8wZdoL7DEKtAWiy/Uw3JC0shgMYt5Douo/jBW+YRR5vKL1ISjZt0s0DFG
 RWiYz5o+1hD7aarUP/7iOfYMt6gQnLZSrtP8iEUNXu42w1Ggq5ZNIzTLErqEFaQe+kKmARnI89C
 N/KtS+OCtUjuQ26fzxXePpAOKwhyZGWxuUhIkBMqrmTflavhDVqgxucPkGxoFWZ2j0/rL2qqKV4
 1eMApvGzCvjQ8PiB2KBiUV/ZMJaIFDw8TwE+SMh3xwcnKxYvMPWzD/JkHrW/C2JMuZXEPAGXRlu
 utF/BZOs39qhJIr1q4iFcYqAsEI3C79NplnsE7a8zYkt9BwlrBeEantwX0qiT6G8Px/rMHRSUCY
 WzklF4J0jjDZhjg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the make intc_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Built using sh-sh4 glibc stable toolchain from bootlin, with config:

CONFIG_SH_INTC=y
CONFIG_INTC_USERIMASK=y
CONFIG_INTC_BALANCING=y

Yielded unrelated warnings:

<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
arch/sh/kernel/cpu/sh4/fpu.c:389:6: warning: no previous prototype for 'float_raise' [-Wmissing-prototypes]
arch/sh/kernel/cpu/sh4/fpu.c:394:5: warning: no previous prototype for 'float_rounding_mode' [-Wmissing-prototypes]
arch/sh/mm/cache-sh4.c:384:13: warning: no previous prototype for 'sh4_cache_init' [-Wmissing-prototypes]
arch/sh/mm/flush-sh4.c:106:13: warning: no previous prototype for 'sh4__flush_region_init' [-Wmissing-prototypes]
arch/sh/mm/cache-shx3.c:18:13: warning: no previous prototype for 'shx3_cache_init' [-Wmissing-prototypes]
kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]
arch/sh/kernel/cpu/init.c:99:29: warning: no previous prototype for 'l2_cache_init' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:10:6: warning: no previous prototype for 'pgd_ctor' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:32:8: warning: no previous prototype for 'pgd_alloc' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:37:6: warning: no previous prototype for 'pgd_free' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:43:6: warning: no previous prototype for 'pud_populate' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:48:8: warning: no previous prototype for 'pmd_alloc_one' [-Wmissing-prototypes]
arch/sh/mm/pgtable.c:53:6: warning: no previous prototype for 'pmd_free' [-Wmissing-prototypes]
arch/sh/mm/tlbex_32.c:22:1: warning: no previous prototype for 'handle_tlbmiss' [-Wmissing-prototypes]
arch/sh/kernel/return_address.c:49:7: warning: no previous prototype for 'return_address' [-Wmissing-prototypes]
arch/sh/kernel/sys_sh.c:58:16: warning: no previous prototype for 'sys_cacheflush' [-Wmissing-prototypes]
arch/sh/kernel/traps_32.c:735:6: warning: no previous prototype for 'per_cpu_trap_init' [-Wmissing-prototypes]
arch/sh/kernel/smp.c:173:17: warning: no previous prototype for 'start_secondary' [-Wmissing-prototypes]
arch/sh/kernel/smp.c:324:5: warning: no previous prototype for 'setup_profiling_timer' [-Wmissing-prototypes]
arch/sh/kernel/kprobes.c:52:16: warning: no previous prototype for 'arch_copy_kprobe' [-Wmissing-prototypes]
arch/sh/kernel/kprobes.c:304:15: warning: no previous prototype for 'trampoline_probe_handler' [-Wmissing-prototypes]
arch/sh/kernel/hw_breakpoint.c:135:5: warning: no previous prototype for 'arch_bp_generic_fields' [-Wmissing-prototypes]
fs/ext4/readpage.c:392:1: warning: the frame size of 1124 bytes is larger than 1024 bytes [-Wframe-larger-than=]
arch/sh/boot/compressed/cache.c:2:5: warning: no previous prototype for 'cache_control' [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]
arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
---
 drivers/sh/intc/core.c      | 2 +-
 drivers/sh/intc/internals.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index ca4f4ca413f1..74350b5871dc 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -455,7 +455,7 @@ struct syscore_ops intc_syscore_ops = {
 	.resume		= intc_resume,
 };
 
-struct bus_type intc_subsys = {
+const struct bus_type intc_subsys = {
 	.name		= "intc",
 	.dev_name	= "intc",
 };
diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index fa73c173b56a..9b6cd1bebb4e 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -160,7 +160,7 @@ void _intc_enable(struct irq_data *data, unsigned long handle);
 /* core.c */
 extern struct list_head intc_list;
 extern raw_spinlock_t intc_big_lock;
-extern struct bus_type intc_subsys;
+extern const struct bus_type intc_subsys;
 
 unsigned int intc_get_dfl_prio_level(void);
 unsigned int intc_get_prio_level(unsigned int irq);

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240208-bus_cleanup-sh2-3fc31658b91a

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


