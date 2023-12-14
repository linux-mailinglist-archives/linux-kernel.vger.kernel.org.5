Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636E81256C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442885AbjLNCrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjLNCra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:47:30 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F399F7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:47:36 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4258026a9fdso46758941cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1702522055; x=1703126855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIavbINZh5nYTp8Oo+UkDFK4yofTsKFYo/9aAWUfbh4=;
        b=pyaRSrZE9bUbL1v6wRSTh/KrGJhVI/H81tqlpUnSBayz57AhzMTxw5v7ZKAw2Qrbm4
         8/1K/8T10ZhhTHu4BcZqfttWcaylyFiHInRdINWJtnoaBoJDQW0DWkk8qS4enaJO5zZ3
         xrGMo4CskepCFD/mNh7c+6AZ961di3QTiuzBnAB41nTbCqr1sRfcXuNjYaMoK9t0VRd4
         JGq6CI6L7jmAIxKhMYJBFHL+Q/2lz2pKlI0tcAwsV+ds+HHJeo6EAjPxVaiIGp5F1+P9
         v5ONl1fej1S+bJWAAy84U2xfxD67IVTP+PHXvWufjaPiVLiEl+sCgzVANIX/MCs+vE1r
         Qj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702522055; x=1703126855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIavbINZh5nYTp8Oo+UkDFK4yofTsKFYo/9aAWUfbh4=;
        b=rEHqJM/M8MNU64I5ouMChREwUZazxLQr9jW3lAb6x4TDF5qe/PQ+V6tjy1ri1mgiyS
         AyQ1693vK1F0Vwgu7qMV9gVNtDpmCrPiDb0sp6ZqeD2+TMlwJWTkr7GWAc6+GpgBPWpX
         RvYKQuMUvtOs/WmQs45W+DLBsKVWo7hujuBzKTNQdxa/jo7wtTllqYhAc40Van8JN0n3
         UfR0CFFx6CEfXUUrGSXxvPbijq15FO/t1MoGZMqK3n8mc5NK8ky1fIcEfF3gEm7+DauJ
         bwhwoCgC8qpGsfWvyhSmxoPjKqnbfCK0LC2XjFM3ZZlas6yea1VDH+M+zbdLTtsHgpfO
         2ITg==
X-Gm-Message-State: AOJu0YzLBdydomF/xFMEltvT3BFLjgPOI/6aE5M5qfxT7QIHKVnBP7Dn
        a5Sy3NZUArJ5tfQoXLo4etTNTg==
X-Google-Smtp-Source: AGHT+IH6u1GHrME2lBmJJpVZSxUPVZ6fOdoMo5fRDVqA+ScERzhBmZ8B0kv7EEMH2wDjJzf7yiNE+g==
X-Received: by 2002:a05:622a:8d:b0:425:4043:29fc with SMTP id o13-20020a05622a008d00b00425404329fcmr12342292qtw.119.1702522055644;
        Wed, 13 Dec 2023 18:47:35 -0800 (PST)
Received: from vinp3lin.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id fh3-20020a05622a588300b00425b356b919sm4240208qtb.55.2023.12.13.18.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 18:47:35 -0800 (PST)
From:   "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To:     Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Cc:     "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Masami Hiramatsu <mhiramat@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH 2/8] sched/core: sched_setscheduler_pi_nocheck for interrupt context usage
Date:   Wed, 13 Dec 2023 21:47:19 -0500
Message-ID: <20231214024727.3503870-3-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214024727.3503870-1-vineeth@bitbyteword.org>
References: <20231214024727.3503870-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__sched_setscheduler takes an argument 'pi' so as to allow its usage in
interrupt context when PI is not used. But this is not exported and
cannot be used outside of scheduler code. sched_setscheduler_nocheck is
exported but it doesn't allow that flexibility.

Introduce sched_setscheduler_pi_nocheck to allow for the flexibility to
call from interrupt context

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..de7382f149cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1908,6 +1908,8 @@ extern int idle_cpu(int cpu);
 extern int available_idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
+extern int sched_setscheduler_pi_nocheck(struct task_struct *p, int policy,
+		const struct sched_param *sp, bool pi);
 extern void sched_set_fifo(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
 extern void sched_set_normal(struct task_struct *p, int nice);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8f73ff12126..b47f72b6595f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7850,8 +7850,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	return retval;
 }
 
-static int _sched_setscheduler(struct task_struct *p, int policy,
-			       const struct sched_param *param, bool check)
+static int _sched_setscheduler_pi(struct task_struct *p, int policy,
+			       const struct sched_param *param, bool check, bool pi)
 {
 	struct sched_attr attr = {
 		.sched_policy   = policy,
@@ -7866,8 +7866,15 @@ static int _sched_setscheduler(struct task_struct *p, int policy,
 		attr.sched_policy = policy;
 	}
 
-	return __sched_setscheduler(p, &attr, check, true);
+	return __sched_setscheduler(p, &attr, check, pi);
+}
+
+static inline int _sched_setscheduler(struct task_struct *p, int policy,
+			       const struct sched_param *param, bool check)
+{
+	return _sched_setscheduler_pi(p, policy, param, check, true);
 }
+
 /**
  * sched_setscheduler - change the scheduling policy and/or RT priority of a thread.
  * @p: the task in question.
@@ -7916,6 +7923,27 @@ int sched_setscheduler_nocheck(struct task_struct *p, int policy,
 	return _sched_setscheduler(p, policy, param, false);
 }
 
+/**
+ * sched_setscheduler_pi_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
+ * @p: the task in question.
+ * @policy: new policy.
+ * @param: structure containing the new RT priority.
+ * @pi: boolean flag stating if pi validation needs to be performed.
+ *
+ * A flexible version of sched_setcheduler_nocheck which allows for specifying
+ * whether PI context validation needs to be done or not. set_scheduler_nocheck
+ * is not allowed in interrupt context as it assumes that PI is used.
+ * This function allows interrupt context call by specifying pi = false.
+ *
+ * Return: 0 on success. An error code otherwise.
+ */
+int sched_setscheduler_pi_nocheck(struct task_struct *p, int policy,
+			       const struct sched_param *param, bool pi)
+{
+	return _sched_setscheduler_pi(p, policy, param, false, pi);
+}
+EXPORT_SYMBOL_GPL(sched_setscheduler_pi_nocheck);
+
 /*
  * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally
  * incapable of resource management, which is the one thing an OS really should
-- 
2.43.0

