Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE275D585
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGUUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGUUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:19:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95083A8C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583994e0bc5so12901007b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689970760; x=1690575560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kp8wKDt0eMxNmmgxbfIQ59HsgNC9pjZ5TgTeqdMxU/I=;
        b=AAcenZvw756VBG7/uWjvcLB2GB6SaD9rHsGVP1ovtfQ7g3P1/K5Es/5cP7bQX4Cett
         TXIqUcFS8rwOAQTdffRrYdTVUeGqUN4Pk1zQVEpgyHZgM5CU4q7BAddWItw5Q7B/HUFX
         dm9BEq62JHh36Dyv0YCxgBb//gvHCL44aM4hNFvAWv9IYaRXhunR1CtejhbcQSL/3BKu
         jhhLx9apEs7AWteNUlsHKFY1npg1EGGfPoIogyCbJDG+NVcTCP8a4KpbcRzwBW7l7aEc
         fnDXtssi6A7cJBIy/mxf0JRinHLH1Q1C9G7n2rTaBE2AVxXbRmy7Sib5y3L9HVmp9h0H
         1bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970760; x=1690575560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp8wKDt0eMxNmmgxbfIQ59HsgNC9pjZ5TgTeqdMxU/I=;
        b=jrwqRpOghM2r0mFoDborV9a9yuYvhTDdkiW68QJ6YHB04/z8nJ02oeBhqiAWznPmYE
         Uccj+Q4mVSzRf2A/5riwDi/8TnZqDL9p4Wjb5dEvPQNdvrp3GgvaCTe2+VNu89Xfuzlu
         b5nQYsN8Jm4nclM4vTz5eJvmxqt85eInm4/hPv4UQsvMifYB3AeqfBE+Q0SKR8hV3W2x
         0n5rHXDkMvjC/NiQmrwBbUeq2HooFhJgzT4NUt5NGDrnuyk2VnhOeyzMev2OOmbYJQN/
         Pza+NfgEaWV6BWuwcIx6welwiTmdzZDGlJ+OBptThOCvoz6A3js+HGiP8FGGmQr4I0wj
         9aQQ==
X-Gm-Message-State: ABy/qLbg8EfWdYR7UShtk6j/bNzGVq9IJCwFFmuvmg2di8iJ5jcDViCp
        DmDHkhgkW/qrm0GyXwNFPFHWzMKI0xk=
X-Google-Smtp-Source: APBJJlGTfQ3Re85Ub4mDu2d7yq7yFxRBK4TrexqrcdueUqc8FNScDCwWwNnAZeh/fkd/oR5J515PtlELu78=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ac14:0:b0:581:3899:91bc with SMTP id
 k20-20020a81ac14000000b00581389991bcmr9159ywh.6.1689970760558; Fri, 21 Jul
 2023 13:19:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 13:18:48 -0700
In-Reply-To: <20230721201859.2307736-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721201859.2307736-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721201859.2307736-9-seanjc@google.com>
Subject: [PATCH v4 08/19] x86/reboot: Expose VMCS crash hooks if and only if
 KVM_{INTEL,AMD} is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the crash/reboot hooks used by KVM to disable virtualization in
hardware and unblock INIT only if there's a potential in-tree user,
i.e. either KVM_INTEL or KVM_AMD is enabled.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/reboot.h | 4 ++++
 arch/x86/kernel/reboot.c      | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 74c6a624d166..6536873f8fc0 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,10 +25,14 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 typedef void (cpu_emergency_virt_cb)(void);
 void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *callback);
 void cpu_emergency_disable_virtualization(void);
+#else
+static inline void cpu_emergency_disable_virtualization(void) {}
+#endif /* CONFIG_KVM_INTEL || CONFIG_KVM_AMD */
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 98e5db3fd7f4..830425e6d38e 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -529,6 +529,7 @@ static inline void kb_wait(void)
 
 static inline void nmi_shootdown_cpus_on_restart(void);
 
+#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
 /* RCU-protected callback to disable virtualization prior to reboot. */
 static cpu_emergency_virt_cb __rcu *cpu_emergency_virt_callback;
 
@@ -596,7 +597,9 @@ static void emergency_reboot_disable_virtualization(void)
 		nmi_shootdown_cpus_on_restart();
 	}
 }
-
+#else
+static void emergency_reboot_disable_virtualization(void) { }
+#endif /* CONFIG_KVM_INTEL || CONFIG_KVM_AMD */
 
 void __attribute__((weak)) mach_reboot_fixups(void)
 {
-- 
2.41.0.487.g6d72f3e995-goog

