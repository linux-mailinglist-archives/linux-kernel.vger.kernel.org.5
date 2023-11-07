Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805687E4825
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbjKGSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjKGSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:22:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551EA183
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:22:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so5985303276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699381321; x=1699986121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF19+OXVW5UGsHvBJEM1Rd3K8EFj2d9Zm0BTvFFwkOQ=;
        b=iDLrIUwp0Ijph4F3Az7lVjSHowRY4OUyYh2DU1g+ztoDpy3vYqHsAopDKg6Iz5AY/Q
         1ixMOCTp18Cwu8LkaawJyZThs6812KUqudT3jwQkb+xtOXx0F1msW0veZ9exnGI5E7iW
         5MiTZ8lvNH4aUqff85s9DNsZLrEvGayqZYKJlnuxGLnswPh52gxSSWSFvPSAfncMHpnI
         NVAboraXOtYGpuAVuvJKW0Fyb30VVN537ocaXmvdw+kdYRdOxteQkltsFnokIIa4Xko+
         VwvPorGoCJ/mZnt8eVonKO/PP2oQIiFYQJnNoB6RI4jCnV4e6p4MmF4z1kjkxS99YCro
         1kgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381321; x=1699986121;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pF19+OXVW5UGsHvBJEM1Rd3K8EFj2d9Zm0BTvFFwkOQ=;
        b=vnzFaDU2OL8q0Syz28xid6TFlLb+ZmjJW88FN98eg4v+o+7hAvobLxx1A5e2lS01Vj
         KItO2R6KBYOMSVvvy1Po6aLRzhavjkKKjBdgKe/lBxjLid6BoWzkYnzDIXwHr6qIs3hL
         cYlzEhjvcuCajBz0KCpx/nlFtdlhXKB+B12FKgpe8kS+qTT5zpbzDrYPlxtT55FwzJ1J
         QZF67MWWLjR2Z7Y43bh8KPiixcCS+hYpj092YiiVUmr2Gt0TncMnIT8WGXzjeUisNpIz
         oq7UbdPBVIGTeP66GyvjEj0aoftN37c5csjYbuX8DWlmK4FuLVdBGIxbCrUaWWNTCIRO
         fbZA==
X-Gm-Message-State: AOJu0YwIGgJCTFAbjl/QVhtuujwxvDYE9aZAidY4uFfi5Gw1+BatQhdN
        edJZkquPZBKenZDBiyMXV+kCeEwEvwU=
X-Google-Smtp-Source: AGHT+IEDf6RUwUXmKQRccOF/Lx6Rlskhqqt2UmcBCDHA+7KXiu9sCsGdSay6ypnVQLil31O2Iq9zsbVpkVM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:9d2:0:b0:d9a:bce6:acf3 with SMTP id
 y18-20020a5b09d2000000b00d9abce6acf3mr672242ybq.0.1699381321569; Tue, 07 Nov
 2023 10:22:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 10:21:59 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107182159.404770-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Fix MWAIT error message when guest assertion fails
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print out the test and vector as intended when a guest assert fails an
assertion regarding MONITOR/MWAIT faulting.  Unfortunately, the guest
printf support doesn't detect such issues at compile-time, so the bug
manifests as a confusing error message, e.g. in the most confusing case,
the test complains that it got vector "0" instead of expected vector "0".

Fixes: 0f52e4aaa614 ("KVM: selftests: Convert the MONITOR/MWAIT test to use printf guest asserts")
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

base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
-- 
2.42.0.869.gea05f2083d-goog

