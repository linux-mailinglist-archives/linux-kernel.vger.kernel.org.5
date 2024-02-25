Return-Path: <linux-kernel+bounces-79923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D028628BF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5465281FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554E2F5A;
	Sun, 25 Feb 2024 01:50:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416C8139D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708825832; cv=none; b=cnJCPSi+UpLPBnn6yPuCLjAZg+RrUrnfjhy6VNo8Y9BynYTkMhb38EyNQoJMmOM4UX6W1g431rB3u9t80inEsJPbtV3qZFvh7kSdXx4iZO7CFxrqoK2WsskURGIefDCd0UihyyMJs4pzrE5L3vKl84Ku9dL/rZq19GWC/Us5oDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708825832; c=relaxed/simple;
	bh=Rz+jTzPeC9WLQNhTavEN1Oc8VP0JIfOQuV7w/Py+Z+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LpJpcbAEvuZAz+iinKDtz/PA5A6Hk6ieT4HcidVNbRIxOWwkmX+Bt7lL73Gk9hnwhUCCOYbqfqgK7bOol/i4dRFUUvRPLEbra/Ch9dGdNz3A++yK0ApFweP66WImMS4JpJl+3X1t9WIeS2pR6Kw5cK6Ep65ikhQFPNakclagHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b161279aso19815975ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 17:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708825829; x=1709430629;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8WDBR/xUlcpd6GklJKTEb6zPyxzfXbVEJD4CBbyppY=;
        b=rUecpSg3BwnInDOGD6W48pRtVU+lBdUOlQzhTYKZ0A/EgvC+I8ypPRFJwGGpnHB6KY
         8zvrs1PQfRZdRPbat3o2UJ8nJWbXPwGBP7lUyaeH+5ZSp5q84Na9NFjjQdQXiBL6mN8d
         T0asGbNdHrZh5JefE8eGXOyS50FwmYNiUyIRAZ8YaKT+2VWzFPAOMVf+KcVwjfzOB6aB
         qyAc3Gp3OqV3F6tOzTfRrjN6+Qb1FEuEP/M4x6TNo/DTvq1CLkA+3dXmJpTsgSpcI09i
         QQhJReNHEAG1rOy4iPFYgFWBvRIdEOfMX89SJZdRtncM3Bf7A58wRvsH7bEwlTp+PIHM
         Sl1Q==
X-Gm-Message-State: AOJu0YxtbxdqLOPFmgZvqly9COUXpe+V3xdAB+LDGq2QPMlaXeYPeOQp
	q9TQ0vmJrR+N0U9xuPq9K/b/OEYSjkO6Ri8rRR3MD7Em+20S8h2QfkggqKRrAJMgYRAZ6SHBsut
	4Udl/7urBkbdp1mvGtrywhXLRjJs+XAZGzFyuji7fT0ozu/8VHmEJbqJPjA==
X-Google-Smtp-Source: AGHT+IGstkiZBVvC/Xqi0K434tLpOWB6QwC4pM0JsVcK9NwlX4NYOsSc7zY2T2kE+h5wD68Dw322R7ymfSAhXiWBUL7NWTXGS7MQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e05:b0:365:1846:bd5a with SMTP id
 g5-20020a056e021e0500b003651846bd5amr234676ila.5.1708825829418; Sat, 24 Feb
 2024 17:50:29 -0800 (PST)
Date: Sat, 24 Feb 2024 17:50:29 -0800
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bb08806122b04ca@google.com>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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




