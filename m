Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28875D59C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjGUUVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGUUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:20:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04883AA2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:20:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so2266429276.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689970783; x=1690575583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f1LNi9Sq5NIBXtzGJVGKttDHRo4VG7MGlit5nvyUtF0=;
        b=lupqznqfPScgKgAlsl68k2HwQOWYVzqFz7+e39gz+UVj6wvvC+ma4BNLkDyLgMbDCr
         sXcaIXufKIRqTjEo6kaASseH4LuovJPFo1FpnMySbHlymLZC8toxxIjvN2Aiw4ju6EAG
         VaD/mWdhEO8ur/DDeO9tEnMiMm8VItIJH8OP+EP+LpWzQ/NrR5L8c8s2LMhTcLypPS2U
         oBg+8IvkdXfhKuyTvHG3Xef0QbwUQ6ZzSvJM7Mo/H4jFrr/vFd5FgUJyl+qeE3dTtsH5
         MY6DHfpkgF/82Qh+aTdBRtINfnVpzFGxerBDIxZVXvcHDxqf5FZ0G6Srcd0y+VCH+a4h
         +9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970783; x=1690575583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1LNi9Sq5NIBXtzGJVGKttDHRo4VG7MGlit5nvyUtF0=;
        b=UE9jJl4FmdRBt8lVAb8J0GqHbC9FtiPMgkofkW2dh9ugrklT4sy1td/iXtfna/RJT6
         GjIIlvu9TU/QzVZjrCtQV0WWwWsJoW7OjVbg64Uo7lNcafxofTJSaV0iJOkiWCsKXyhA
         ADcT2SYT6+W5mMeExzrQaeFzsPU9aB5cBZNbUReCOuQy7hk78nQuLe5Bh1zm/R6nZse5
         9uZKmtqkXjtDI4Su8ShA6TvfBm3cUjhllE5bFq4ksGoXWvC+/sucbPauPpYaO6erEq/s
         ladM1OwD4Q1SJck+Pc8pU8p6WCQPHvnF/rY4oqd15+oCeE/vtHSqruVikiHbLxfUzjLI
         BR2w==
X-Gm-Message-State: ABy/qLYiejwXCdiKng84QDxgOLtaZUQFWEEVF3pGVngPUNnd8ijDShwK
        f4PlfqIVhNQARc8ZvT4EYh4LpbWwP4k=
X-Google-Smtp-Source: APBJJlGqCihblJf1jaycZ9unQQ6pi+gVUILg04BI7aSdWb1kqkXeAsB0DrslgKJ6+cdV8k8Utd5kIZ2tJk4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:bc2:0:b0:ce9:64b3:80dc with SMTP id
 c2-20020a5b0bc2000000b00ce964b380dcmr18891ybr.1.1689970783817; Fri, 21 Jul
 2023 13:19:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 13:18:59 -0700
In-Reply-To: <20230721201859.2307736-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721201859.2307736-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721201859.2307736-20-seanjc@google.com>
Subject: [PATCH v4 19/19] KVM: VMX: Skip VMCLEAR logic during emergency
 reboots if CR4.VMXE=0
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bail from vmx_emergency_disable() without processing the list of loaded
VMCSes if CR4.VMXE=0, i.e. if the CPU can't be post-VMXON.  It should be
impossible for the list to have entries if VMX is already disabled, and
even if that invariant doesn't hold, VMCLEAR will #UD anyways, i.e.
processing the list is pointless even if it somehow isn't empty.

Assuming no existing KVM bugs, this should be a glorified nop.  The
primary motivation for the change is to avoid having code that looks like
it does VMCLEAR, but then skips VMXON, which is nonsensical.

Suggested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5d21931842a5..0ef5ede9cb7c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -773,12 +773,20 @@ static void vmx_emergency_disable(void)
 
 	kvm_rebooting = true;
 
+	/*
+	 * Note, CR4.VMXE can be _cleared_ in NMI context, but it can only be
+	 * set in task context.  If this races with VMX is disabled by an NMI,
+	 * VMCLEAR and VMXOFF may #UD, but KVM will eat those faults due to
+	 * kvm_rebooting set.
+	 */
+	if (!(__read_cr4() & X86_CR4_VMXE))
+		return;
+
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
 			    loaded_vmcss_on_cpu_link)
 		vmcs_clear(v->vmcs);
 
-	if (__read_cr4() & X86_CR4_VMXE)
-		kvm_cpu_vmxoff();
+	kvm_cpu_vmxoff();
 }
 
 static void __loaded_vmcs_clear(void *arg)
-- 
2.41.0.487.g6d72f3e995-goog

