Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720F812572
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443048AbjLNCrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjLNCri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:47:38 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22197115
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:47:41 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4259c7dfb63so39672151cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1702522060; x=1703126860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntiXZyzgAfw7DEiUwC2cla+1/r+Z91Px9imV7BJfm4E=;
        b=eQccfhVk7nDYWuJiaMHSFst/2lfRIsQ5LcVGGPwzOro5E4IPE1jJq+4zmfiTV9fW1/
         JGLtODe28w1wrfnlDnMMAx73YW5V20GAbAKmbOsqSH4llz/cO0+ogVRiKpPYI4RKn5yw
         ZPJHR51ztl6mJQ+an3niXS8WJ9Au7nx8IKJ4Z7hAiae2xd7Flwme1gN9ZC18Jvv8hH/c
         pQlyqj+lvOVz8ZCFRV2lXN+WWu1QQE6sw88b+COl0DZL0SLEOn6wPpvy4xJGXE0/gccq
         4cmLLsGp5h89B3YKsmHKHPKcrMHQ/eMYQAbYVRtP9iDyseLKoe8sB4rv9KIBZz0Pkp+/
         6hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702522060; x=1703126860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntiXZyzgAfw7DEiUwC2cla+1/r+Z91Px9imV7BJfm4E=;
        b=pwpchAxIP8zKb096PvMepcX756w3ZRuyBGNGS62hIZ/0LHxTxGlMI9aUvgnTzePz9y
         Wb+ek5DVg3g4w5yrskQ/QA3PJRDiyX6ZTpI7eRcQJ0RiAq3Vi3MKgQZBwyrlpsPb5Opx
         j8NcFUjYCtztqFXbnrAZvwpwz1dnqbFyx5CtjX33SRLvMXtNpZd1kJ9qTUnUROoxVoT6
         nI9fk8T5h92K3IKnsK2BPEfNCIjHewTGVl+VKJi4JmW4bV3LGjdi4Z5Q7iTh0S4l7rBC
         wl4oaChEDz0lED3SrHQABo/2FN6OCFr7eAu2C8WCkX+jcQReulUGvr+lJpmC0a2ex8+m
         Ssxw==
X-Gm-Message-State: AOJu0Yw+cRu/as4xrF82XAu6ItsKsd3zCMwaTfMV+DHjMrhyhe811Py0
        j703H5hCl272OinPka+BcDIi2w==
X-Google-Smtp-Source: AGHT+IFp1ZD52g4ymlbxazKG1B37Keyo6/4q8bj6M6rVdCJFfpmlC4GJ0ji/8pgJ8q6GEwLUiO0XHA==
X-Received: by 2002:ac8:4e52:0:b0:425:9ab0:467a with SMTP id e18-20020ac84e52000000b004259ab0467amr10005951qtw.19.1702522060183;
        Wed, 13 Dec 2023 18:47:40 -0800 (PST)
Received: from vinp3lin.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id fh3-20020a05622a588300b00425b356b919sm4240208qtb.55.2023.12.13.18.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 18:47:39 -0800 (PST)
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
Subject: [RFC PATCH 5/8] kvm: x86: upper bound for preemption based boost duration
Date:   Wed, 13 Dec 2023 21:47:22 -0500
Message-ID: <20231214024727.3503870-6-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214024727.3503870-1-vineeth@bitbyteword.org>
References: <20231214024727.3503870-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest requests boost on preempt disable but doesn't request unboost on
preempt enable. This may cause the guest vcpu to be boosted for longer
than what it deserves. Also, there are lots of preemption disabled paths
in kernel and some could be quite long.

This patch sets a bound on the maximum time a vcpu is boosted due to
preemption disabled in guest. Default is 3000us, and could be changed
via kvm module parameter.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/x86.c              | 49 ++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 474fe2d6d3e0..6a8326baa6a0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -994,6 +994,8 @@ struct kvm_vcpu_arch {
 	 */
 	struct {
 		enum kvm_vcpu_boost_state boost_status;
+		bool preempt_disabled;
+		ktime_t preempt_disabled_ts;
 		int boost_policy;
 		int boost_prio;
 		u64 msr_val;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2577e1083f91..8c15c6ff352e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -199,6 +199,15 @@ module_param(eager_page_split, bool, 0644);
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
+#ifdef CONFIG_PARAVIRT_SCHED_KVM
+/*
+ * Maximum time in micro seconds a guest vcpu can stay boosted due
+ * to preemption disabled.
+ */
+unsigned int pvsched_max_preempt_disabled_us = 3000;
+module_param(pvsched_max_preempt_disabled_us, uint, 0644);
+#endif
+
 /*
  * Restoring the host value for MSRs that are only consumed when running in
  * usermode, e.g. SYSCALL MSRs and TSC_AUX, can be deferred until the CPU
@@ -2149,17 +2158,47 @@ static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_PARAVIRT_SCHED_KVM
+static inline void kvm_vcpu_update_preempt_disabled(struct kvm_vcpu_arch *arch,
+		bool preempt_disabled)
+{
+	if (arch->pv_sched.preempt_disabled != preempt_disabled) {
+		arch->pv_sched.preempt_disabled = preempt_disabled;
+		if (preempt_disabled)
+			arch->pv_sched.preempt_disabled_ts = ktime_get();
+		else
+			arch->pv_sched.preempt_disabled_ts = 0;
+	}
+}
+
+static inline bool kvm_vcpu_exceeds_preempt_disabled_duration(struct kvm_vcpu_arch *arch)
+{
+	s64 max_delta = pvsched_max_preempt_disabled_us * NSEC_PER_USEC;
+
+	if (max_delta && arch->pv_sched.preempt_disabled) {
+		s64 delta;
+
+		WARN_ON_ONCE(arch->pv_sched.preempt_disabled_ts == 0);
+		delta = ktime_to_ns(ktime_sub(ktime_get(),
+					arch->pv_sched.preempt_disabled_ts));
+
+		if (delta >= max_delta)
+			return true;
+	}
+
+	return false;
+}
+
 static inline bool __vcpu_needs_boost(struct kvm_vcpu *vcpu, union guest_schedinfo schedinfo)
 {
 	bool pending_event = kvm_cpu_has_pending_timer(vcpu) || kvm_cpu_has_interrupt(vcpu);
 
 	/*
 	 * vcpu needs a boost if
-	 * - A lazy boost request active, or
-	 * - Pending latency sensitive event, or
-	 * - Preemption disabled in this vcpu.
+	 * - A lazy boost request active or a pending latency sensitive event, and
+	 * - Preemption disabled duration on this vcpu has not crossed the threshold.
 	 */
-	return (schedinfo.boost_req == VCPU_REQ_BOOST || pending_event || schedinfo.preempt_disabled);
+	return ((schedinfo.boost_req == VCPU_REQ_BOOST || pending_event) &&
+			!kvm_vcpu_exceeds_preempt_disabled_duration(&vcpu->arch));
 }
 
 static inline void kvm_vcpu_do_pv_sched(struct kvm_vcpu *vcpu)
@@ -2173,6 +2212,8 @@ static inline void kvm_vcpu_do_pv_sched(struct kvm_vcpu *vcpu)
 		&schedinfo, offsetof(struct pv_sched_data, schedinfo), sizeof(schedinfo)))
 		return;
 
+	kvm_vcpu_update_preempt_disabled(&vcpu->arch, schedinfo.preempt_disabled);
+
 	kvm_vcpu_set_sched(vcpu, __vcpu_needs_boost(vcpu, schedinfo));
 }
 #else
-- 
2.43.0

