Return-Path: <linux-kernel+bounces-79951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB918628E5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F812821EA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2554B644;
	Sun, 25 Feb 2024 02:42:46 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232D944C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828966; cv=none; b=r9mHk7n4hNUVCV76EYy9sDsmKMSUiS/UR0igOyD377Ecr7Xz/DJv9V1k6Fybo7CFHXfhYUTpRS5VLk4h112LbsbauOmRzK3eUaukzpoPs3c1j5YX/IscvvFuMTRRlOt+LDQcSYxhlu8h8RVK3P2ryeDVC3ToeL5/BxqF2LlQw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828966; c=relaxed/simple;
	bh=AdOTLa6n8/xEXoBnyPxUclExl4y+f+HtJRkRlIgmNDw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OLAI1rGTfmRJJqOsDuhXiXQK6vVgkCCadpKz+Se5e2tvUkwd/beK2o9cBZpLP+D44Veil1m359jTqYwwKkJfFTL8LtZmydW8AJ9PFZxEtMY400GpsfGnolLfMLri2Ji3Far38IIgqQAiuSAi3lcJZTrRw1HaWxpeDelSTB1IQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c79b0aaa86so180045639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 18:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708828963; x=1709433763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qmbVFqRc1bT7FEfHid+/HYK9f07F0/h1BWUmErVMx8=;
        b=CDZrRW8/RJ/18hKZ1nwQX/uYpyDZUdRmlX5beiSeKTTIsTuNwuajz9gjdKTqi5RuA5
         kEdmmUjRbX/IysFn2yNov0vvz3ktvQLJJ8IyYwGlH+u8mRwr7SCIKoH//fAgpAKnGyWv
         mykO6IUzDkVvp43v70ua3wscz4XPeC0FruOPJBWZ9FHh8sEVESdQa1y52acPgcN9uWmO
         w2/g07q7Bp1j0JbtTus5K0qnRN70x3XPLotqHXIbI8Az4kw5JsOBmuysMge+V8ggUGof
         qXwR3nAgeDjrouSFS8nrne3G1zCe8RcYbzk7EjmOwCRTNc2ZbWKlOl0lbf/T2JZ4hOez
         +EpA==
X-Gm-Message-State: AOJu0YxHuj9NT2y1x7ED4D5O41pM7xgTEQive9qiOB4n5Sq0kkBdF+V5
	zFrZpUbc45LUpipTeP5v5+gEkMTNTeDcbDSd24cH3QrG/uOKlNOoh+5EECiqfCijBBhBH5nvwPC
	/ZCvazhgHRy62D8T6W7SDJ5w2qKoYhGAbhIRn21VvlFzT/iqjPVnfUbnBQQ==
X-Google-Smtp-Source: AGHT+IEbf/2H8CCfN8WQa6XlNiFOW026YcUkmwRV1xI+W0MpciI74D3j4mpYTF5+gZ+ue1I65VSsJ30lM+OGb5VnLiYXcKxgZ0Jb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:365:7607:3f6d with SMTP id
 a8-20020a056e02180800b0036576073f6dmr331211ilv.1.1708828963821; Sat, 24 Feb
 2024 18:42:43 -0800 (PST)
Date: Sat, 24 Feb 2024 18:42:43 -0800
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ee46906122bbf6d@google.com>
Subject: Re: [syzbot] Re: [syzbot] [virtualization?] KMSAN: uninit-value in
 virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
Author: penguin-kernel@i-love.sakura.ne.jp

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..f13bba3a9dab 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -58,7 +58,16 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+#ifdef CONFIG_KMSAN
+/* Use of non-instrumented assembly version confuses KMSAN. */
+void *memcpy(void *to, const void *from, __kernel_size_t len);
+static inline void copy_page(void *to, void *from)
+{
+	memcpy(to, from, PAGE_SIZE);
+}
+#else
 void copy_page(void *to, void *from);
+#endif
 
 #ifdef CONFIG_X86_5LEVEL
 /*
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 6e8b7e600def..bc701dcbb133 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -61,9 +61,9 @@ unsigned long copy_mc_enhanced_fast_string(void *dst, const void *src, unsigned
  */
 unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)
 {
-	if (copy_mc_fragile_enabled)
+	if (0 && copy_mc_fragile_enabled)
 		return copy_mc_fragile(dst, src, len);
-	if (static_cpu_has(X86_FEATURE_ERMS))
+	if (0 && static_cpu_has(X86_FEATURE_ERMS))
 		return copy_mc_enhanced_fast_string(dst, src, len);
 	memcpy(dst, src, len);
 	return 0;
@@ -74,14 +74,14 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 {
 	unsigned long ret;
 
-	if (copy_mc_fragile_enabled) {
+	if (0 && copy_mc_fragile_enabled) {
 		__uaccess_begin();
 		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
-	if (static_cpu_has(X86_FEATURE_ERMS)) {
+	if (0 && static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
 		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..039ffa49f324 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -253,11 +253,16 @@ size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
 
 static size_t __copy_from_iter_mc(void *addr, size_t bytes, struct iov_iter *i)
 {
+	size_t ret;
+
 	if (unlikely(i->count < bytes))
 		bytes = i->count;
 	if (unlikely(!bytes))
 		return 0;
-	return iterate_bvec(i, bytes, addr, NULL, memcpy_from_iter_mc);
+	ret = iterate_bvec(i, bytes, addr, NULL, memcpy_from_iter_mc);
+	if (bytes != ret)
+		printk("addr=%px bytes=%d ret=%d\n", addr, bytes, ret);
+	return ret;
 }
 
 static __always_inline
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5d6e2dee5692..0b09daa188ef 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -359,6 +359,12 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 }
 
 /* Functions from kmsan-checks.h follow. */
+
+/*
+ * To create an origin, kmsan_poison_memory() unwinds the stacks and stores it
+ * into the stack depot. This may cause deadlocks if done from within KMSAN
+ * runtime, therefore we bail out if kmsan_in_runtime().
+ */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {
 	if (!kmsan_enabled || kmsan_in_runtime())
@@ -371,47 +377,31 @@ void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(kmsan_poison_memory);
 
+/*
+ * Unlike kmsan_poison_memory(), this function can be used from within KMSAN
+ * runtime, because it does not trigger allocations or call instrumented code.
+ */
 void kmsan_unpoison_memory(const void *address, size_t size)
 {
 	unsigned long ua_flags;
 
-	if (!kmsan_enabled || kmsan_in_runtime())
+	if (!kmsan_enabled)
 		return;
 
 	ua_flags = user_access_save();
-	kmsan_enter_runtime();
 	/* The users may want to poison/unpoison random memory. */
 	kmsan_internal_unpoison_memory((void *)address, size,
 				       KMSAN_POISON_NOCHECK);
-	kmsan_leave_runtime();
 	user_access_restore(ua_flags);
 }
 EXPORT_SYMBOL(kmsan_unpoison_memory);
 
 /*
- * Version of kmsan_unpoison_memory() that can be called from within the KMSAN
- * runtime.
- *
- * Non-instrumented IRQ entry functions receive struct pt_regs from assembly
- * code. Those regs need to be unpoisoned, otherwise using them will result in
- * false positives.
- * Using kmsan_unpoison_memory() is not an option in entry code, because the
- * return value of in_task() is inconsistent - as a result, certain calls to
- * kmsan_unpoison_memory() are ignored. kmsan_unpoison_entry_regs() ensures that
- * the registers are unpoisoned even if kmsan_in_runtime() is true in the early
- * entry code.
+ * Version of kmsan_unpoison_memory() called from IRQ entry functions.
  */
 void kmsan_unpoison_entry_regs(const struct pt_regs *regs)
 {
-	unsigned long ua_flags;
-
-	if (!kmsan_enabled)
-		return;
-
-	ua_flags = user_access_save();
-	kmsan_internal_unpoison_memory((void *)regs, sizeof(*regs),
-				       KMSAN_POISON_NOCHECK);
-	user_access_restore(ua_flags);
+	kmsan_unpoison_memory((void *)regs, sizeof(*regs));
 }
 
 void kmsan_check_memory(const void *addr, size_t size)



