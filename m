Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D775D59A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjGUUVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGUUUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:20:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD780359F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5839bad0ba7so11013217b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689970781; x=1690575581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vAOLLgTu+0QNT9Om4NpxWB91aAPEeSvRzwHwJVAa2Xs=;
        b=imhgBKzxrXtouuf5PfcKL7zBn0uz33+q5k8Z0nIhm6BNxLjvMukg2vArkkk5NgTFDM
         NCaOxaOau0vLfoyQRsInuw+KAa7AslkSTBn6yul+5eiPK0IjOxtTfZI+5BUlLIVKvaaf
         zctolS0OU9qe/eA0SfoB4J52oxFAqZ+fh+FLtJaIaIPFFG750jsFlZ2Mc9quoQp2Unyu
         4inyMQQxkm2n98I2kfK3YCgsPjNs4UlB9VWVghYk87tTe4jdkygy4sS2+Mqd1axuaOKZ
         Y80wBoNxrdfW0VnTAvlYpjVOt8tpfiwmBahTWl8/tfevz/dYYviEbtSr/R7buC1VS27v
         nuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970781; x=1690575581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAOLLgTu+0QNT9Om4NpxWB91aAPEeSvRzwHwJVAa2Xs=;
        b=DauQHLsbRiqO7ytJPcQtbJG8RaVZN73hfCe6Pj8jaohdtAVgsS+ma1FCpK8KAndWSc
         SWa/CHpGmWOGyfunjcGLHC6fmGW3OPnFoeLI4f7NqAnBH02ZtqPYrendrrexfgZ7MVu3
         WHdkYMtcJGpCGTXkgwE3O9lBx1dqfGQt/q6zve5RH65R++1TzH98wUdE1RTA6W08YPMF
         muVhRUgo1htmQrvk4bqKC30B+QbfV+PLEeW+zuFdwx5dTJznIo/vCiTHwlohPTXTFos3
         S6G648iV1bxBC2CFVsXDgmbcX31yWU+mHYfIMCPx1C6PZ6VcUvTjR1z0wzJ+J0fnHADq
         wNeg==
X-Gm-Message-State: ABy/qLZdBhwI1JNWVciQn8xZBklDUQaLNN56i7+/GmVKJ6ZRGynPhqZB
        MgbrefUPfvc6iBInBhJDz4ifXcvDx1o=
X-Google-Smtp-Source: APBJJlFg1G379oAP55UGHQ0zEE/xeGlSUtowvWP1iIaOgGSS++UyKOVvNLNpz7tVyRlxXJ14xmaMnRFherI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:81cf:0:b0:c5d:dac2:cb2a with SMTP id
 n15-20020a2581cf000000b00c5ddac2cb2amr18050ybm.13.1689970781205; Fri, 21 Jul
 2023 13:19:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 13:18:58 -0700
In-Reply-To: <20230721201859.2307736-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721201859.2307736-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721201859.2307736-19-seanjc@google.com>
Subject: [PATCH v4 18/19] KVM: SVM: Use "standard" stgi() helper when
 disabling SVM
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

Now that kvm_rebooting is guaranteed to be true prior to disabling SVM
in an emergency, use the existing stgi() helper instead of open coding
STGI.  In effect, eat faults on STGI if and only if kvm_rebooting==true.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8d1b3c801629..4785d780cce3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -588,17 +588,10 @@ static inline void kvm_cpu_svm_disable(void)
 	rdmsrl(MSR_EFER, efer);
 	if (efer & EFER_SVME) {
 		/*
-		 * Force GIF=1 prior to disabling SVM to ensure INIT and NMI
-		 * aren't blocked, e.g. if a fatal error occurred between CLGI
-		 * and STGI.  Note, STGI may #UD if SVM is disabled from NMI
-		 * context between reading EFER and executing STGI.  In that
-		 * case, GIF must already be set, otherwise the NMI would have
-		 * been blocked, so just eat the fault.
+		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
+		 * NMI aren't blocked.
 		 */
-		asm_volatile_goto("1: stgi\n\t"
-				  _ASM_EXTABLE(1b, %l[fault])
-				  ::: "memory" : fault);
-fault:
+		stgi();
 		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
 	}
 }
-- 
2.41.0.487.g6d72f3e995-goog

