Return-Path: <linux-kernel+bounces-100716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD98879C54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8991F23402
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53921428FD;
	Tue, 12 Mar 2024 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9v2jRF6"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034014264F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272366; cv=none; b=Tb/V5yWMePs+UIpjCjizh6IHC6S+b18IDsekvmmeGbLN2FtXgxGC5gzPrbXuKJyq4T0s284cSU+sCRmumq/qqycB0P4UO15yGet3gvgVU2Lpcg28Ndfm/+YNo/Pudglsi2zZM4QEODkg/+q+Kozy8kjUdEX7rKGDQWvssSzfDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272366; c=relaxed/simple;
	bh=bXN6LpucX8g1IPBaUvL4KJPwl6tCjlllO1SSWPVol+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cvD92CGw2XhgUQHNKyoatHWeu9B0+jTIdtvX+btkGTfn4+GHvB+s9loWXvquNP7UXKnbk8LYKtxMUskxdkaz76CGtYLATOXQ0j5JsLCw5vhcmtPLDwhXtaAO1JtvnAQVwDii9phNlD14L3zP5IkWbxE7SoETn/A3yHBTy1kJnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9v2jRF6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso128807a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710272364; x=1710877164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KtuhoJjlc6aLRLXbBM6dO4klGCHwBSsnzlu9NVynTBU=;
        b=t9v2jRF6DE9PLyL2F8yxOJkcD9emTER3LDRWrC6VLuvMooQNVLoYkT8WV8zPlmMBG0
         tyWHs8xY+1Q9WDmxKVCXxPwSpOQUygYMjq3XATZEghHi81zEJLHLlXsHXpmIHb0kQcoE
         WlDjVzNMerH7j4YIcyn6ifV+zp1wSq2rYVA8uXpp3t/0RDe/D1D1GfS0mI0sPN9daWFK
         wTeeIE11PcFMSpgiaBlw1quaHiUQ4aGxA6lGRc+4nV/wo2g+9DJbK/1Q0257+Fe8wfeF
         b3dvlvVeJGoJs74BS2HxlcY11hIpivWTuU+ErARRLW7ROS8cweyhzShOpQe+5Khj7rvt
         sOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710272364; x=1710877164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtuhoJjlc6aLRLXbBM6dO4klGCHwBSsnzlu9NVynTBU=;
        b=tH5w2oos1NQhO00zlhisMik+7l6WcwnCQDnlKiMHO4F/Szz+Nz8f7DmpUH+JNoKMnW
         eEPAlPWr8mbSUuUj1Tmh8cKN2xIv/SweZ5MjRWxb9iaeO7PiZDpzG/q2NQpYp11Zy+Im
         /tHBwx9x1t4B8DpMOAJ6EpwbtwV1oYF0A7+rR3PTVhcLeawlsa/C/bFaC7ok0lG1UvoK
         veye2eIuWWPZ7j402xVzvm7pKVyncS0FDizHGsnGejRVbEzqtocrTXz0JPYFiUeSolD9
         hVr0SbYsQyVCT3+XZNI19g6BqZP+NtRphHnUc9pxUl3TGhgZiufiXct9QnZcUBkncsjX
         G0gg==
X-Forwarded-Encrypted: i=1; AJvYcCVADqzYy9zYQMXthfpGnghhbGPwuBTKSPPFB5F+eUY1Nz0odqof8uFIRN0MLJuw+S3U0lexkh3pgqlxQTOODY49SwQGyekkTWmWYBIS
X-Gm-Message-State: AOJu0YygjqICC19u9Zyk952yqzFjPP89rAh04tDQRuzLXgD+lndG1Vgw
	6tLzr91Wg1c/14oHE09yCfyZpaWud7XnaftFySVQ9m8r+RN0zAu3yCuqFJxeJDG1vhd/mNlaKYd
	WKQ==
X-Google-Smtp-Source: AGHT+IHsa9gDpy8/PdSR11Pa+j9cL56mibi/uiU75NrIWPWyexGCLR0qj9UL3IZemnedxqaGh3LUTydlAtE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:e647:0:b0:5dc:2a75:9a19 with SMTP id
 p7-20020a63e647000000b005dc2a759a19mr1193pgj.2.1710272364469; Tue, 12 Mar
 2024 12:39:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Mar 2024 12:39:10 -0700
In-Reply-To: <20240312193911.1796717-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312193911.1796717-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312193911.1796717-2-seanjc@google.com>
Subject: [PATCH v2 1/2] sched/core: Move preempt_model_*() helpers from
 sched.h to preempt.h
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

Move the declarations and inlined implementations of the preempt_model_*()
helpers to preempt.h so that they can be referenced in spinlock.h without
creating a potential circular dependency between spinlock.h and sched.h.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/preempt.h | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/sched.h   | 41 -----------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7233e9cf1bab..ce76f1a45722 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -481,4 +481,45 @@ DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enable_notrace())
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+extern bool preempt_model_none(void);
+extern bool preempt_model_voluntary(void);
+extern bool preempt_model_full(void);
+
+#else
+
+static inline bool preempt_model_none(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_NONE);
+}
+static inline bool preempt_model_voluntary(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
+}
+static inline bool preempt_model_full(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT);
+}
+
+#endif
+
+static inline bool preempt_model_rt(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_RT);
+}
+
+/*
+ * Does the preemption model allow non-cooperative preemption?
+ *
+ * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
+ * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
+ * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
+ * PREEMPT_NONE model.
+ */
+static inline bool preempt_model_preemptible(void)
+{
+	return preempt_model_full() || preempt_model_rt();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 17cb0761ff65..e9dc10f7a463 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2058,47 +2058,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-extern bool preempt_model_none(void);
-extern bool preempt_model_voluntary(void);
-extern bool preempt_model_full(void);
-
-#else
-
-static inline bool preempt_model_none(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_NONE);
-}
-static inline bool preempt_model_voluntary(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY);
-}
-static inline bool preempt_model_full(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT);
-}
-
-#endif
-
-static inline bool preempt_model_rt(void)
-{
-	return IS_ENABLED(CONFIG_PREEMPT_RT);
-}
-
-/*
- * Does the preemption model allow non-cooperative preemption?
- *
- * For !CONFIG_PREEMPT_DYNAMIC kernels this is an exact match with
- * CONFIG_PREEMPTION; for CONFIG_PREEMPT_DYNAMIC this doesn't work as the
- * kernel is *built* with CONFIG_PREEMPTION=y but may run with e.g. the
- * PREEMPT_NONE model.
- */
-static inline bool preempt_model_preemptible(void)
-{
-	return preempt_model_full() || preempt_model_rt();
-}
-
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
-- 
2.44.0.278.ge034bb2e1d-goog


