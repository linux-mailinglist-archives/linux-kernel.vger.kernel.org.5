Return-Path: <linux-kernel+bounces-152053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90358AB807
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0CD281D39
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98161846B;
	Sat, 20 Apr 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jzCIeCR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8B320A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713571567; cv=none; b=Iz2Y21UWm+7MrVELqNoaDeNpfNyfJsjqk/kXGYrW37SM46qn2TSSyvuOd2xFesa87L3TUHnmeGOaoGARtDf8iTs3anomQpC8GFj0ErGtizzCtZlVVIQ8+qz0ktcXLOjliG87lrqN1a7p2jHWu0evf5aq5jAMELQQ5NFku/leEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713571567; c=relaxed/simple;
	bh=hQsIpaNlyBty75DD7t5jIwQA87JdgxVtOi6IDRwsKy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CUfSvohAf1d4fsjkEBEL8Vfo5gBgAfAsAU/AiFFJ9Gqt3XYZZVLdx/qy0HuUgORo0QKDcpM7LKDexOqbM5doJeyvyhwosedtcZ66fZYJQFI8TgGFfN8Qq32hg+JNYvsyEPfLm70N2LIvKh8FHVXGjeTVvLjnS4cOstfb2fwU21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1jzCIeCR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d36b049so4289098276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713571565; x=1714176365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=so8727EOvkSPZlRuAoZTn7r1JdCzB1JDrFmlKMuMW0M=;
        b=1jzCIeCRpfd+WI0zdHODEm0B1SdpfOKT5yd5ZnLLLx1abPTcQ8vGn+dhyvP32XCjl2
         pIUOonDCNoj86ox4gS+IA87GXaOIjRaw2HVpEsnHK2ULiMvpjFRg6X/USfq3pMJuN3aB
         hyZU8Symy9Mw0hZwqOULirL/gRG/QxemgpjhSUqgIGWjpvald1ZvKw2yRQAF7CnaV7QL
         5m1H8G73XFfr/zCYX6a3mWELPFu3kJO0150CdtCO2nzkKDkljJLAyNmX8zo7CETUOWPv
         jZAJqoxbiv9BkaiO1k21fm2OdNr71wrj/EI18CsjpYB16i4qmp77LOAcpeqcuxgS2FGw
         7QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713571565; x=1714176365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=so8727EOvkSPZlRuAoZTn7r1JdCzB1JDrFmlKMuMW0M=;
        b=TbFXXGZqh4v6bdVCRuygvL57vW6aZ5aaSo3atANXBbPHNMVwt0+Z26buA1zvqog94e
         ujfCKTBlLxs7eKuuf8oz9ELLyE90wcgH/fwGwmpxFme/sE1lv+2lYmKFJ9rnpELJaV5X
         +h7WEfQO7v0UBI+Tc/fTrXQ3xoQ7GUKZewyYGUjN6ypRwWwbkReK2NL8uhZH+p4Tc9Ct
         t7x+fDLYeY1KSzGvYy24mJH2XKVdH7MJZx9AOIXKKwU+gqmflj/686WabCfKDpx0fwEM
         69bfCJVvZaniS40rDddy3ISNdoFHXlKkz+H+otGFX7kKhF+YJB4dmkdX6XcDNPEkmOz3
         CNIg==
X-Gm-Message-State: AOJu0YyYKkp9mk4ML2o7bmK6edw2YJo6nD5ldS+KnU7RFGQ5M9113zgv
	/i7HpslH0ZHKQ5RKePYnaQ5YSv/Qrrm0u1EsEPjJCPb1da4PuxLVcF5Eq6P+vLBMMaIyIEkL70T
	PDA==
X-Google-Smtp-Source: AGHT+IFgLX8xvAEMDGPH8AnOUBpUl1qkxujuj6ddKlxpGhWPlfU76CDq07UHgTgXIVvSFL3qIhW2wLJ5JI8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1883:b0:de0:ecc6:4681 with SMTP id
 cj3-20020a056902188300b00de0ecc64681mr332829ybb.1.1713571565367; Fri, 19 Apr
 2024 17:06:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Apr 2024 17:05:55 -0700
In-Reply-To: <20240420000556.2645001-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240420000556.2645001-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240420000556.2645001-3-seanjc@google.com>
Subject: [PATCH v2 2/2] cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly disallow enabling mitigations at runtime for kernels that were
built with CONFIG_CPU_MITIGATIONS=n, as some architectures may omit code
entirely if mitigations are disabled at compile time.

E.g. on x86, a large pile of Kconfigs are buried behind CPU_MITIGATIONS,
and trying to provide sane behavior for retroactively enabling mitigations
is extremely difficult, bordering on impossible.  E.g. page table isolation
and call depth tracking requrie build-time support, BHI mitigations will
still be off without additional kernel parameters, etc.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/Kconfig                                |  8 ++++++--
 include/linux/cpu.h                             | 11 +++++++++++
 kernel/cpu.c                                    | 13 ++++++++++---
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 902ecd92a29f..213d0719e2b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3423,6 +3423,9 @@
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
 
+			Note, "mitigations" is supported if and only if the
+			kernel was built with CPU_MITIGATIONS=y.
+
 			off
 				Disable all optional CPU mitigations.  This
 				improves system performance, but it may also
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 619a04d5c131..928820e61cb5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2495,9 +2495,13 @@ menuconfig CPU_MITIGATIONS
 	help
 	  Say Y here to enable options which enable mitigations for hardware
 	  vulnerabilities (usually related to speculative execution).
+	  Mitigations can be disabled or restricted to SMT systems at runtime
+	  via the "mitigations" kernel parameter.
 
-	  If you say N, all mitigations will be disabled. You really
-	  should know what you are doing to say so.
+	  If you say N, all mitigations will be disabled.  This CANNOT be
+	  overridden at runtime.
+
+	  Say 'Y', unless you really know what you are doing.
 
 if CPU_MITIGATIONS
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 272e4e79e15c..ee0a3b4e0769 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -221,7 +221,18 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_CPU_MITIGATIONS
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
+#else
+static inline bool cpu_mitigations_off(void)
+{
+	return false;
+}
+static inline bool cpu_mitigations_auto_nosmt(void)
+{
+	return false;
+}
+#endif
 
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bb0ff275fb46..24235c1d6e82 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3196,6 +3196,7 @@ void __init boot_cpu_hotplug_init(void)
 	this_cpu_write(cpuhp_state.target, CPUHP_ONLINE);
 }
 
+#ifdef CONFIG_CPU_MITIGATIONS
 /*
  * These are used for a global "mitigations=" cmdline option for toggling
  * optional CPU mitigations.
@@ -3207,8 +3208,7 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-					     CPU_MITIGATIONS_OFF;
+	CPU_MITIGATIONS_AUTO;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
@@ -3224,7 +3224,6 @@ static int __init mitigations_parse_cmdline(char *arg)
 
 	return 0;
 }
-early_param("mitigations", mitigations_parse_cmdline);
 
 /* mitigations=off */
 bool cpu_mitigations_off(void)
@@ -3239,3 +3238,11 @@ bool cpu_mitigations_auto_nosmt(void)
 	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
+#else
+static int __init mitigations_parse_cmdline(char *arg)
+{
+	pr_crit("Kernel compiled without mitigations, ignoring 'mitigations'; system may still be vulnerable\n");
+	return 0;
+}
+#endif
+early_param("mitigations", mitigations_parse_cmdline);
-- 
2.44.0.769.g3c40516874-goog


