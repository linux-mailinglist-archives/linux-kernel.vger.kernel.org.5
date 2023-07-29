Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A87679D8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbjG2Ajw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjG2Aiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:38:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5580B49F1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:38:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so2497829276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591050; x=1691195850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=u2EIFWrBLGEnIiN/EFJ5XRmezLxqqm+61iiHmkdd9ak=;
        b=TIIFj9PRB7w7knxR4gGCXPFWprbCc6PSg9bZdqeQNgOIr8n4lBUcFDZnrj3QtXE6nu
         LT7OVvjwtMrAeu0gPoA5V4phKY1ayY/jFxjHHj4KHYmdKbTaWR+HVw5JhWp5QpmEHtPQ
         r3nOgYRipUN2H2CkKumNFOEEdfgGc8tndwAlLM5yNrUDmZRqDycA+OFsTczRw3p1Ixzt
         nCWPRmwKCpJHn4Y74RBkJqDY9ab5UY4rZLZaMcC4Ec12Wnh0ni/LvbvBdt0YaXmyhF15
         KHpSU49BiLispdDH9IcnQsp8yk8N5ZPxjboEL8tLmbT5z0ASXh3ruBWkK444oxHt16uX
         DsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591050; x=1691195850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2EIFWrBLGEnIiN/EFJ5XRmezLxqqm+61iiHmkdd9ak=;
        b=h7Xe38B1YCj3dj9x9jkfVXJSsD32QwUSKiqqI+4hBOPfvf3mD3za7bmFCwnVLuCCad
         B0a2mETza3ztr7Dt7qVznqpCPNZSKe5F3+sC+gGw6e4mn5n6mFyivP2uXlYfWoWGrV9L
         YXPx7uwggZEM2owl2F5viehEx4nI94KresgavO3ryXuy53cQgrvRQbuOeHq78oAgsAXQ
         HzlGxumTusPLthkkP27nfWEVo3hcjO7c7ElJ5u0qiUryg6S53iLXZ3w7EuUNCv8TYY1Y
         qwe7+uyTTNWDAHZH5As0biaJqDIZ4NQSoO5J8Xg7FAuVus3VT06sYn1GdEV0ycAGZV8b
         WGJQ==
X-Gm-Message-State: ABy/qLYHbNeQEn1VXJD7sA06hQhDGchmP4iZpmSOFXq9X5oz9MXDdfxr
        dMclwWXEliFshg1d8/8tJOpCljA+6Ps=
X-Google-Smtp-Source: APBJJlHE48bzeCyOTilENfSay/pSrMUoqERzzk5XcsIhTPUOx1NnLk0AtqS5bz6Uj5fvFPTyTHsRaarOSPo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ac48:0:b0:d15:d6da:7e97 with SMTP id
 r8-20020a25ac48000000b00d15d6da7e97mr16764ybd.3.1690591050399; Fri, 28 Jul
 2023 17:37:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:36:32 -0700
In-Reply-To: <20230729003643.1053367-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729003643.1053367-24-seanjc@google.com>
Subject: [PATCH v4 23/34] KVM: selftests: Convert x86's KVM paravirt test to
 printf style GUEST_ASSERT
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Thomas Huth <thuth@redhat.com>,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert x86's KVM paravirtualization test to use the printf-based
GUEST_ASSERT_EQ().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/kvm_pv_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index f774a9e62858..1c28b77ff3cd 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -4,6 +4,8 @@
  *
  * Tests for KVM paravirtual feature disablement
  */
+#define USE_GUEST_ASSERT_PRINTF 1
+
 #include <asm/kvm_para.h>
 #include <linux/kvm_para.h>
 #include <stdint.h>
@@ -46,10 +48,10 @@ static void test_msr(struct msr_data *msr)
 	PR_MSR(msr);
 
 	vector = rdmsr_safe(msr->idx, &ignored);
-	GUEST_ASSERT_1(vector == GP_VECTOR, vector);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
 
 	vector = wrmsr_safe(msr->idx, 0);
-	GUEST_ASSERT_1(vector == GP_VECTOR, vector);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
 }
 
 struct hcall_data {
@@ -77,7 +79,7 @@ static void test_hcall(struct hcall_data *hc)
 
 	PR_HCALL(hc);
 	r = kvm_hypercall(hc->nr, 0, 0, 0, 0);
-	GUEST_ASSERT(r == -KVM_ENOSYS);
+	GUEST_ASSERT_EQ(r, -KVM_ENOSYS);
 }
 
 static void guest_main(void)
@@ -125,7 +127,7 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 			pr_hcall(&uc);
 			break;
 		case UCALL_ABORT:
-			REPORT_GUEST_ASSERT_1(uc, "vector = %lu");
+			REPORT_GUEST_ASSERT(uc);
 			return;
 		case UCALL_DONE:
 			return;
-- 
2.41.0.487.g6d72f3e995-goog

