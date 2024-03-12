Return-Path: <linux-kernel+bounces-100717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16848879C56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82A5B207A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961FF142906;
	Tue, 12 Mar 2024 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Np2mpj5m"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F88A1428F7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272368; cv=none; b=mrk5ak+ZEsvO3HB3PVu0WzVJnX27v3WQ2fFBeUf7hEbg2iFL1cmLODK8LMch7nnyR/enlE9ArK/lg83rVTXUDHOOW4nPB7KGN5V0Vn8GgAB0JbPUs//tUoanaOAVP14Ywnb9oKXT4aEzNaiAtA7A+mZ+dFm+PC02ngQNo47i1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272368; c=relaxed/simple;
	bh=7F4aenK3C8j4SGFBioKeFeh7bXOjOVxZfo8KHxdPG24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUNu0xlku65AKMA9RwdxoQp8oT2kYsKawz2yasBegZAlH9LhxTUt4sx2C3PKiZeefGPePomuxHrWjX5+AjmXXQcT0PNpJUcU57ydvAnFbCmSuY0Kvnup3LqEvvELJ6SClqj1vFpqWjcAWNq4Mu07qA4YwZ+AIPbbPP6PbYwzsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Np2mpj5m; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4f312a995so182109a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710272366; x=1710877166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=y37QTRRCaOyhTss07/2XbpFXeVVO9uDT6HFjFeJL8cA=;
        b=Np2mpj5mDgAsX3zwczEbvWJa1bO9R+/asoE3YdhmN7PWnVNjMe1p23BLatbw5YTc+V
         4x314HooLgaNYgtEDo1Qb2ees9lxeW7q6V043OyNv/Nsaz0pAGNjtgqlPRdM+MqEfg7L
         zN55OXSszluXqVGQXNFDbkOzB0PR/BlzoXfIYPrWmPOFwWRmdiS7Lpv4O6kr38RSXXJy
         Y9LCye8ek3vA1GEgfjOfd7vfZy+6eRPmQ6wSrPFIcfueH2UAhol/QDUr631IJIMfqAa7
         nxJvuwkIIWQ0Q75Es05fpd5I3vcOqF6lstMNl/RzGI95IyLcXZj/1SVG5zxRhQFGdpRt
         pFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710272366; x=1710877166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y37QTRRCaOyhTss07/2XbpFXeVVO9uDT6HFjFeJL8cA=;
        b=SgJZI2MY6WUPFR+vAPgzA2lQtdm0MjIVx3dQRkEFuTh/jiwca9+zQPPkC9PoijE22E
         P37oXZhCt/7cQtU2x2k0RNV8Lfh11cFLo4HKXOAxyUHutOXmYHatZGUY3OrsUJJwxrmy
         caoP8RAU8kuMv/YHspwdTcBM5s1ATpAnZa5JoZvpC9EvzV40klJCS1UM+7GG16NRQn2/
         5aFoNUffSe6eVbnLBjsV5QLTr0PkJZ/n1MR19Umh72BgHuCFwg007D5vp2xrkxasVGHg
         OCqYftQ0XiKEcybIUHIny7fPr4+SeP4xTLTDOrKsp1ZvNIFbd2NZVKRPwRGx/7pDbLtb
         IH2g==
X-Forwarded-Encrypted: i=1; AJvYcCV7NNU9a6ZteR3IfaSP90IqwngQjOjGQWEspgV5vK6fAQjiDliNmKVvDYCVt8zVRTR74NlsO8sp2GeH+bz8ofhb1MoJx9axnlaCQKHJ
X-Gm-Message-State: AOJu0YzgdnRSC+MM1thUloIFLNY28U+bduAOyaJ77K/EI6m9YJY4h639
	ouPXqB3aQ9RAV/pie/i8+XPzZRiyIZFey48F2vg0OhAxWecUytgH/hoO2rdjFPLGNsfu6S1+w7q
	2bQ==
X-Google-Smtp-Source: AGHT+IGI7dHHFkEz/HTwu1O+HPjj3k60ryUQ+qwg4B5aW7wTMmFk2zSK0bYqYkStNTwT9sTditr0+hkTqZ4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:714:b0:5dc:8f95:3d with SMTP id
 cb20-20020a056a02071400b005dc8f95003dmr2886pgb.2.1710272366615; Tue, 12 Mar
 2024 12:39:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Mar 2024 12:39:11 -0700
In-Reply-To: <20240312193911.1796717-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312193911.1796717-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312193911.1796717-3-seanjc@google.com>
Subject: [PATCH v2 2/2] sched/core: Drop spinlocks on contention iff kernel is preemptible
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Valentin Schneider <valentin.schneider@arm.com>, 
	Marco Elver <elver@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	David Matlack <dmatlack@google.com>, Friedrich Weber <f.weber@proxmox.com>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Use preempt_model_preemptible() to detect a preemptible kernel when
deciding whether or not to reschedule in order to drop a contended
spinlock or rwlock.  Because PREEMPT_DYNAMIC selects PREEMPTION, kernels
built with PREEMPT_DYNAMIC=y will yield contended locks even if the live
preemption model is "none" or "voluntary".  In short, make kernels with
dynamically selected models behave the same as kernels with statically
selected models.

Somewhat counter-intuitively, NOT yielding a lock can provide better
latency for the relevant tasks/processes.  E.g. KVM x86's mmu_lock, a
rwlock, is often contended between an invalidation event (takes mmu_lock
for write) and a vCPU servicing a guest page fault (takes mmu_lock for
read).  For _some_ setups, letting the invalidation task complete even
if there is mmu_lock contention provides lower latency for *all* tasks,
i.e. the invalidation completes sooner *and* the vCPU services the guest
page fault sooner.

But even KVM's mmu_lock behavior isn't uniform, e.g. the "best" behavior
can vary depending on the host VMM, the guest workload, the number of
vCPUs, the number of pCPUs in the host, why there is lock contention, etc.

In other words, simply deleting the CONFIG_PREEMPTION guard (or doing the
opposite and removing contention yielding entirely) needs to come with a
big pile of data proving that changing the status quo is a net positive.

Opportunistically document this side effect of preempt=full, as yielding
contended spinlocks can have significant, user-visible impact.

Fixes: c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic preempt mode")
Link: https://lore.kernel.org/kvm/ef81ff36-64bb-4cfe-ae9b-e3acf47bff24@proxmox.com
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: David Matlack <dmatlack@google.com>
Cc: Friedrich Weber <f.weber@proxmox.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +++-
 include/linux/spinlock.h                        | 14 ++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 825398d66c69..fdeddb066439 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4689,7 +4689,9 @@
 			none - Limited to cond_resched() calls
 			voluntary - Limited to cond_resched() and might_sleep() calls
 			full - Any section that isn't explicitly preempt disabled
-			       can be preempted anytime.
+			       can be preempted anytime.  Tasks will also yield
+			       contended spinlocks (if the critical section isn't
+			       explicitly preempt disabled beyond the lock itself).
 
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3fcd20de6ca8..63dd8cf3c3c2 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -462,11 +462,10 @@ static __always_inline int spin_is_contended(spinlock_t *lock)
  */
 static inline int spin_needbreak(spinlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return spin_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*
@@ -479,11 +478,10 @@ static inline int spin_needbreak(spinlock_t *lock)
  */
 static inline int rwlock_needbreak(rwlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
+	if (!preempt_model_preemptible())
+		return 0;
+
 	return rwlock_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*
-- 
2.44.0.278.ge034bb2e1d-goog


