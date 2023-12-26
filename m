Return-Path: <linux-kernel+bounces-11699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2637981EA30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253E71C21271
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27AC522A;
	Tue, 26 Dec 2023 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qYR6ENIW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A824C98
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5d064f9e2a1so59712547b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 13:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703627174; x=1704231974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMjOi6FiRyRmKbg6dFlezaHitoPpTFUdgOKhuK4Mldc=;
        b=qYR6ENIWSEGn9jbr+rAJ0kKjhy7hHgfmVmsCdeIfdSzGtFcg3D5d8zVoG0nI2/buJt
         6oZu4QLQoKcGQWiPPUGOQEjSXtfOGXj2PEEicDsR0BrnWpa1gPbnpfLfS0TrcXUFs9kK
         QRCd/xS2aJu3QRrajYL2wkIM934BpDC1A7VgHuD58pYnvv5p463TZr2O3StxGiitGuMa
         xKEqy88wP+3R6uvpzogYjkSTds9kL0ryB8xpgwwfmGnqDuR0OBVUD4OCRG1hgc5iy5nQ
         HILqM2bWsdMQnsg/+50vvsEgFX2VvEuxxDvA2veR0oN5ccFfnOe55lW6Om6IMVMASoke
         Q6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703627174; x=1704231974;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMjOi6FiRyRmKbg6dFlezaHitoPpTFUdgOKhuK4Mldc=;
        b=hcHO6EffXZi3+SezAQY8hYnhi1rmJl2maI3Wvla4gAM6p0ueF2fgoL+MAX8OVzGlm8
         zYjiMXeZIMneHmV4JLRyTA0tYgB1yEu234jukaMaAG6yVfw0FTlVbU9pSgGCAlFrq5H/
         ETrIwBmHqYbbLPi27+WSN53GUAG5BhChE0/nCbDMhLf+XuHf9gONN07wm2X81LLejrJN
         MzGm7gOZyyL6L6IxOF31x7Z4TRv7HfjvJuni4/T+V5DyltVqyexEBM3LvAN5HtzBIdnB
         GhfhMRaLd6DEXPhPXybB18qTuxPd57aCsTHqfEf/x0tpCKA479DPmMpoT5Q/BKjV5I1V
         DvEg==
X-Gm-Message-State: AOJu0YxaSIe1i3kRDfcSJXxn1Ity7/kGsNHXtmURCSmSPAfqYipomnk8
	JUVuKtKK75qUex1h70Y+qH0nkfIfGiJvjt2k/Q==
X-Google-Smtp-Source: AGHT+IEwN5ZopzHJIGGQGpit5mUuOLFU32rRNfgvV8zD7G1zJhrTDdVwgrA0i89ppBRhVWOedmhks73ZIg4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:158e:a76f:5745:9194])
 (user=surenb job=sendgmr) by 2002:a05:690c:d1e:b0:5e7:12cc:a60f with SMTP id
 cn30-20020a05690c0d1e00b005e712cca60fmr3151383ywb.6.1703627174107; Tue, 26
 Dec 2023 13:46:14 -0800 (PST)
Date: Tue, 26 Dec 2023 13:46:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231226214610.109282-1-surenb@google.com>
Subject: [PATCH 1/1] arch/mm/fault: fix major fault accounting when retrying
 under per-VMA lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, will@kernel.org, catalin.marinas@arm.com, 
	palmer@dabbelt.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	surenb@google.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A test [1] in Android test suite started failing after [2] was merged.
It turns out that after handling a major fault under per-VMA lock, the
process major fault counter does not register that fault as major.
Before [2] read faults would be done under mmap_lock, in which case
FAULT_FLAG_TRIED flag is set before retrying. That in turn causes
mm_account_fault() to account the fault as major once retry completes.
With per-VMA locks we often retry because a fault can't be handled
without locking the whole mm using mmap_lock. Therefore such retries
do not set FAULT_FLAG_TRIED flag. This logic does not work after [2]
because we can now handle read major faults under per-VMA lock and
upon retry the fact there was a major fault gets lost. Fix this by
setting FAULT_FLAG_TRIED after retrying under per-VMA lock if
VM_FAULT_MAJOR was returned. Ideally we would use an additional
VM_FAULT bit to indicate the reason for the retry (could not handle
under per-VMA lock vs other reason) but this simpler solution seems
to work, so keeping it simple.

[1] https://cs.android.com/android/platform/superproject/+/master:test/vts-testcase/kernel/api/drop_caches_prop/drop_caches_test.cpp
[2] https://lore.kernel.org/all/20231006195318.4087158-6-willy@infradead.org/

Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/mm/fault.c   | 2 ++
 arch/powerpc/mm/fault.c | 2 ++
 arch/riscv/mm/fault.c   | 2 ++
 arch/s390/mm/fault.c    | 3 +++
 arch/x86/mm/fault.c     | 2 ++
 5 files changed, 11 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 460d799e1296..55f6455a8284 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -607,6 +607,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		mm_flags |= FAULT_FLAG_TRIED;
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 9e49ede2bc1c..53335ae21a40 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -497,6 +497,8 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
 
 	if (fault_signal_pending(fault, regs))
 		return user_mode(regs) ? 0 : SIGBUS;
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 90d4ba36d1d0..081339ddf47e 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -304,6 +304,8 @@ void handle_page_fault(struct pt_regs *regs)
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
 
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 249aefcf7c4e..ab4098886e56 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -337,6 +337,9 @@ static void do_exception(struct pt_regs *regs, int access)
 		return;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
+
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ab778eac1952..679b09cfe241 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1370,6 +1370,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
-- 
2.43.0.472.g3155946c3a-goog


