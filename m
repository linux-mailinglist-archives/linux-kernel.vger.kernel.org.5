Return-Path: <linux-kernel+bounces-30022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6BD8317D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A21C212B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE4C25551;
	Thu, 18 Jan 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcAmgP3B"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C823762
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575637; cv=none; b=jsAFyfM5R+jVVcIgwavWmMLJmHymIpGWHGkZg3WLXsy5em0Xl8BcF+HDK/OBOK5EQgBcHbS8C+FFErJjxX9zYeXqtQBPL84q3mGrsiahVp0mVarXJn+2W7V0jVFww35N3CKjJ73ZvzLjY4WXnSe96fnVovfAgEkFLmi64bIgAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575637; c=relaxed/simple;
	bh=9uRuOPnLrdJcJhWP8ED+28EUo5/SEOBarbn2AVCEczA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=qSYWWt2L2uDACdVz/wSZpQjlPr4d6+J6HVkYlNgjcsE14bFFMGAGNnPrTGixuU/V6ltKF55s3NGvovOJiBa8tRd3jAwy9oXfAPzOMCbJVZ42sYhgp8c1lvFT4gU1PlvrMMkYtN8o+LEpjCRK69gzbJWH7z8GZyhfNHndvTRYoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcAmgP3B; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a2e1630853eso162383466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705575633; x=1706180433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6RrXGrowsStE9nemPJC0cN0IXJkwkJ+pwI0mRPXiexU=;
        b=wcAmgP3Bb0S9qvlKkucNqzQ6nWbdlRqVb5wL8olmnNFkzqROSaxQc/GOP3m2iegDzp
         T5T5KUoJVqXt9Jx0tMVLw7iL8XbBUU1l9BK1rVGiOURN/LHjWJpWt37t/Rr0oeBBsiPd
         alkrU3bmGew4lOVZFaT4cLCGn7/X7NwOTqeeFkMxbDP7Z7OF8rrTyoaFg2lleIbvncoL
         uZ79WXwDk9Xx+899oebJo3jgaVZ/RglcZjvXvYIuk+S+G/PZue80RuqLBTjMfctRP7Dn
         llJ8ncEOLVNn5NPCGLqhnT4k24dv4tIfy2DnOIs5SLZCMNrzALi3QkczwnXFf0ehqXqx
         l6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705575633; x=1706180433;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RrXGrowsStE9nemPJC0cN0IXJkwkJ+pwI0mRPXiexU=;
        b=f5iUYPTvV0ItpI6tmnxvk4PlhDZ89aZDlSBzZUQzqMD3JOy5bS+yyiswx5nlqfOAn8
         KVMA+u7I2rTdmLO1ai2OCzpXaN3dhGufcStfxuguA3Lhhd8ARQLCq4tGSPDyKfYlSue4
         OHdCidHBcD7WyuJnJq24SvyecjyGM6e2y8PWPmJPtGDOniaMgjWNf424MNgjKg+tEGwL
         eCee9GyMRosZzk8+l0B+CI3CmMp/oChH5HX0caOPzddSGdKXnkL1uOxkghuiEn4C3EZq
         04HyuKDcyYFYBAliWCas8dGRbY+jQxSHM/gfxi3tFi/WFOgNM3TOwRr7avdW0KmxNNzN
         IIKw==
X-Gm-Message-State: AOJu0YyeyWnLt5naASwGudjIVL6Kjt1023ORKhViBbrd6Jj64/IxXVIx
	HNnH66LnWaB9XwrivN0VBx6M5MPnEqCg8FgO3sFLhwLbTjO1uHdg/99E4qzJ0O4xXgAHdU/FMg=
	=
X-Google-Smtp-Source: AGHT+IFa7FQxY4lu1mD59CzjOMD/gCR8C9dFGiq1Jl93adEZmgb2tdPkH71clHTN05oD3miarDKNgZ6Y0A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:9d7e:25fb:9605:2bef])
 (user=elver job=sendgmr) by 2002:a17:907:788f:b0:a2d:51d4:9ddc with SMTP id
 ku15-20020a170907788f00b00a2d51d49ddcmr1361ejc.14.1705575633222; Thu, 18 Jan
 2024 03:00:33 -0800 (PST)
Date: Thu, 18 Jan 2024 11:59:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118110022.2538350-1-elver@google.com>
Subject: [PATCH] mm, kmsan: fix infinite recursion due to RCU critical section
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com, 
	Charan Teja Kalla <quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Alexander Potapenko writes in [1]: "For every memory access in the code
instrumented by KMSAN we call kmsan_get_metadata() to obtain the
metadata for the memory being accessed. For virtual memory the metadata
pointers are stored in the corresponding `struct page`, therefore we
need to call virt_to_page() to get them.

According to the comment in arch/x86/include/asm/page.h,
virt_to_page(kaddr) returns a valid pointer iff virt_addr_valid(kaddr)
is true, so KMSAN needs to call virt_addr_valid() as well.

To avoid recursion, kmsan_get_metadata() must not call instrumented
code, therefore ./arch/x86/include/asm/kmsan.h forks parts of
arch/x86/mm/physaddr.c to check whether a virtual address is valid or
not.

But the introduction of rcu_read_lock() to pfn_valid() added
instrumented RCU API calls to virt_to_page_or_null(), which is called by
kmsan_get_metadata(), so there is an infinite recursion now.  I do not
think it is correct to stop that recursion by doing
kmsan_enter_runtime()/kmsan_exit_runtime() in kmsan_get_metadata(): that
would prevent instrumented functions called from within the runtime from
tracking the shadow values, which might introduce false positives."

Fix the issue by switching pfn_valid() to the _sched() variant of
rcu_read_lock/unlock(), which does not require calling into RCU. Given
the critical section in pfn_valid() is very small, this is a reasonable
trade-off (with preemptible RCU).

KMSAN further needs to be careful to suppress calls into the scheduler,
which would be another source of recursion. This can be done by wrapping
the call to pfn_valid() into preempt_disable/enable_no_resched(). The
downside is that this sacrifices breaking scheduling guarantees;
however, a kernel compiled with KMSAN has already given up any
performance guarantees due to being heavily instrumented.

Note, KMSAN code already disables tracing via Makefile, and since
mmzone.h is included, it is not necessary to use the notrace variant,
which is generally preferred in all other cases.

Link: https://lkml.kernel.org/r/20240115184430.2710652-1-glider@google.com [1]
Reported-by: Alexander Potapenko <glider@google.com>
Reported-by: syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
---
 arch/x86/include/asm/kmsan.h | 17 ++++++++++++++++-
 include/linux/mmzone.h       |  6 +++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
index 8fa6ac0e2d76..d91b37f5b4bb 100644
--- a/arch/x86/include/asm/kmsan.h
+++ b/arch/x86/include/asm/kmsan.h
@@ -64,6 +64,7 @@ static inline bool kmsan_virt_addr_valid(void *addr)
 {
 	unsigned long x = (unsigned long)addr;
 	unsigned long y = x - __START_KERNEL_map;
+	bool ret;
 
 	/* use the carry flag to determine if x was < __START_KERNEL_map */
 	if (unlikely(x > y)) {
@@ -79,7 +80,21 @@ static inline bool kmsan_virt_addr_valid(void *addr)
 			return false;
 	}
 
-	return pfn_valid(x >> PAGE_SHIFT);
+	/*
+	 * pfn_valid() relies on RCU, and may call into the scheduler on exiting
+	 * the critical section. However, this would result in recursion with
+	 * KMSAN. Therefore, disable preemption here, and re-enable preemption
+	 * below while suppressing reschedules to avoid recursion.
+	 *
+	 * Note, this sacrifices occasionally breaking scheduling guarantees.
+	 * Although, a kernel compiled with KMSAN has already given up on any
+	 * performance guarantees due to being heavily instrumented.
+	 */
+	preempt_disable();
+	ret = pfn_valid(x >> PAGE_SHIFT);
+	preempt_enable_no_resched();
+
+	return ret;
 }
 
 #endif /* !MODULE */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4ed33b127821..a497f189d988 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2013,9 +2013,9 @@ static inline int pfn_valid(unsigned long pfn)
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	ms = __pfn_to_section(pfn);
-	rcu_read_lock();
+	rcu_read_lock_sched();
 	if (!valid_section(ms)) {
-		rcu_read_unlock();
+		rcu_read_unlock_sched();
 		return 0;
 	}
 	/*
@@ -2023,7 +2023,7 @@ static inline int pfn_valid(unsigned long pfn)
 	 * the entire section-sized span.
 	 */
 	ret = early_section(ms) || pfn_section_valid(ms, pfn);
-	rcu_read_unlock();
+	rcu_read_unlock_sched();
 
 	return ret;
 }
-- 
2.43.0.381.gb435a96ce8-goog


