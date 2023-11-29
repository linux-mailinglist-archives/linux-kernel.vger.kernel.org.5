Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5E7FE395
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjK2WtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjK2WtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:49:15 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12B131
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:21 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab9cso326338b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701298161; x=1701902961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jcB+0ufG8RNDzGznsHxIgoB+eIgiTMrBs/Lse4iREj8=;
        b=SunDNM5+HWKgI2Dw6O6zLkHFzNp81SfN6D8k9EE84c+NY1ZS5HjuXZtaPFvZz2lXuw
         wZZuNYc57zBjtx/iht6V13qU4sjzldsOIMBWaFlNAdOZorjGo64oxGaojZETQH4zBT9u
         w6vyWR7Jl6rzdrl/FOTjCn16aYZPvduNZ4pgRfgMzJYjGMZu/Hd5BuBuL8NJWu4msnhK
         jiz2FJpMcZ8+wmzwliDsp52VzW9dHvLz9QekyZwCGJ33DeL31SD36Pygv2MhkUZfPW6a
         kZPtgfW+RD8jkPRQNxNbuHI1hZ+yC28pigQe9r4ra4hSUiSlNlR97wAsMCm/wQ6Z/O3K
         wZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701298161; x=1701902961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcB+0ufG8RNDzGznsHxIgoB+eIgiTMrBs/Lse4iREj8=;
        b=r156yOuFaO3lnU8OlKlVVlKxZpz81BS57fKuyn2P8QgJd8qhfl8zZxnd4ydTLOezjf
         bnfO7711fNXErOrAIOqz4Bs+effb6CA25E3tDfKCDxcjzY/VuTrz5/1HObBhp4WT3GUx
         mc/s69vLm8OyOrxo7jDTHnu+CfPN196SEblwW7eO46ev8GvgBlpsbE3SWkkxew7eaU5o
         K4vMcx5wCy25Cdh7N1oQNpUnlsgJ59ZGddsFRlvafMExHZXUXlDOEzxTSymGg+7Ly5VG
         uG1gMriMSSHL+mVgGuCAO5n4dzj4wuaVFeLXAIeLV/+vlrBAM84eq01VH6Fa6+zlR048
         77eQ==
X-Gm-Message-State: AOJu0YyYPM4h5yLOLlAAPZSvmr5HmEQioldLnA4KMWY6ttV6K+NqDN7z
        3Tc9U7YaKNw5kpcy46Vz2zjbYo6pq3I=
X-Google-Smtp-Source: AGHT+IGlptR+ACsn5xm5Y7kirHJtCxe5a03VMwEUdpXfliyZg3YTs1xMsjqpw1vLtzpj7r+7POud+dCpEzA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1389:b0:6cb:95ab:cf8d with SMTP id
 t9-20020a056a00138900b006cb95abcf8dmr5297305pfg.6.1701298161246; Wed, 29 Nov
 2023 14:49:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Nov 2023 14:49:13 -0800
In-Reply-To: <20231129224916.532431-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231129224916.532431-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129224916.532431-2-seanjc@google.com>
Subject: [PATCH v2 1/4] KVM: selftests: Fix MWAIT error message when guest
 assertion fails
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
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

Print out the test and vector as intended when a guest assert fails an
assertion regarding MONITOR/MWAIT faulting.  Unfortunately, the guest
printf support doesn't detect such issues at compile-time, so the bug
manifests as a confusing error message, e.g. in the most confusing case,
the test complains that it got vector "0" instead of expected vector "0".

Fixes: 0f52e4aaa614 ("KVM: selftests: Convert the MONITOR/MWAIT test to use printf guest asserts")
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Link: https://lore.kernel.org/r/20231107182159.404770-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
index 80aa3d8b18f8..853802641e1e 100644
--- a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
+++ b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
@@ -27,10 +27,12 @@ do {									\
 									\
 	if (fault_wanted)						\
 		__GUEST_ASSERT((vector) == UD_VECTOR,			\
-			       "Expected #UD on " insn " for testcase '0x%x', got '0x%x'", vector); \
+			       "Expected #UD on " insn " for testcase '0x%x', got '0x%x'", \
+			       testcase, vector);			\
 	else								\
 		__GUEST_ASSERT(!(vector),				\
-			       "Expected success on " insn " for testcase '0x%x', got '0x%x'", vector); \
+			       "Expected success on " insn " for testcase '0x%x', got '0x%x'", \
+			       testcase, vector);			\
 } while (0)
 
 static void guest_monitor_wait(int testcase)
-- 
2.43.0.rc1.413.gea7ed67945-goog

