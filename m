Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02B7679CF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjG2AjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbjG2Aih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:38:37 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F414688
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:37:46 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bba9a0da10so18216235ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591042; x=1691195842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4KUkVA9WMnyLxYGz79SDCJn7ve+A3Wf1F6DPB0+B89Y=;
        b=m1lnc4WNUUb4LhX1UCRMwTzJ/kua4mNB+cCI2zAZJDw/YuWyBNC/mjTXyBnbABdSwK
         XlTEeooUTC/+KEnZs8SdsD7KD4D5QT2j61EexSFXezqGR/jmMDfqT8QirXCkaEUchBzC
         yQnQHpQKSbauSGLL1v1IXcHYKGUzNuLGMNkFvyI4TcWFeI2ssuz9YaMH0Oei27k/Nyon
         5p7fEQS3naCoN6/hzKKe7XVSJuuPLuc5vpk+ZhrcR46/7R1M/CvlAIb/SNLlgSZcRNvd
         /rG6QtBHZYxac3GXVkkOzTpCaNB7ZTUbXG+aooqbeSQfPP1kS8AIrJeT4F/CLnedG0IS
         LNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591042; x=1691195842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KUkVA9WMnyLxYGz79SDCJn7ve+A3Wf1F6DPB0+B89Y=;
        b=ftj50c/TzgJeLrjYxI3nC/UaholO2sUo36Zt7L9zo+nu1sx1ck4rLStJ4ctbQUvgGJ
         87ZCuTQ98wYCKNN0ZD0k9nIaz1vG6UJ5VYAcg0LdLknBNguMiez7fNgO15pkAr2EX8Ob
         hTFFpfuclQ92msIYAN9RYDlpVW2ezPGPS8QR+jGANCFpJXi7qsSR7uVDkOpBcDetOz39
         VfJ7SLgW4/GlkobU2DDG4o4bkbyDRAGVps3nmWZ9nkycsHNw4X4R9cTVC2GacCdZKj9U
         hHEp463UHeeOqZPWD1NrWXvxBMFp1q/43N7MCR+n3vcxAi5H46nncOiB29V40tDzLMiK
         BBfQ==
X-Gm-Message-State: ABy/qLYJ1CiZqfZiJwXD8kEG98AmZpT6tZHqGV+fIMR6vfCWMODNxWyu
        vf0j1r9d/sKXkyCSu7oMAYp1bPQmhgM=
X-Google-Smtp-Source: APBJJlGuA7vi3U6gzhB6JqQWicL1WyEr3IUOwMBH5vFB9eArqoqzqemY3es1drglI/28nECd76urnf6xTrY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c9:b0:1bb:8c42:79f4 with SMTP id
 o9-20020a170902d4c900b001bb8c4279f4mr11146plg.2.1690591042672; Fri, 28 Jul
 2023 17:37:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:36:28 -0700
In-Reply-To: <20230729003643.1053367-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729003643.1053367-20-seanjc@google.com>
Subject: [PATCH v4 19/34] KVM: selftests: Convert steal_time test to printf
 style GUEST_ASSERT
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

Convert the steal_time test to use printf-based GUEST_ASERT.
Opportunistically use GUEST_ASSERT_EQ() and GUEST_ASSERT_NE() so that the
test spits out debug information on failure.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/steal_time.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index c87f38712073..8649c8545882 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -4,6 +4,8 @@
  *
  * Copyright (C) 2020, Red Hat, Inc.
  */
+#define USE_GUEST_ASSERT_PRINTF 1
+
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <time.h>
@@ -31,8 +33,8 @@ static uint64_t guest_stolen_time[NR_VCPUS];
 static void check_status(struct kvm_steal_time *st)
 {
 	GUEST_ASSERT(!(READ_ONCE(st->version) & 1));
-	GUEST_ASSERT(READ_ONCE(st->flags) == 0);
-	GUEST_ASSERT(READ_ONCE(st->preempted) == 0);
+	GUEST_ASSERT_EQ(READ_ONCE(st->flags), 0);
+	GUEST_ASSERT_EQ(READ_ONCE(st->preempted), 0);
 }
 
 static void guest_code(int cpu)
@@ -40,7 +42,7 @@ static void guest_code(int cpu)
 	struct kvm_steal_time *st = st_gva[cpu];
 	uint32_t version;
 
-	GUEST_ASSERT(rdmsr(MSR_KVM_STEAL_TIME) == ((uint64_t)st_gva[cpu] | KVM_MSR_ENABLED));
+	GUEST_ASSERT_EQ(rdmsr(MSR_KVM_STEAL_TIME), ((uint64_t)st_gva[cpu] | KVM_MSR_ENABLED));
 
 	memset(st, 0, sizeof(*st));
 	GUEST_SYNC(0);
@@ -122,8 +124,8 @@ static int64_t smccc(uint32_t func, uint64_t arg)
 
 static void check_status(struct st_time *st)
 {
-	GUEST_ASSERT(READ_ONCE(st->rev) == 0);
-	GUEST_ASSERT(READ_ONCE(st->attr) == 0);
+	GUEST_ASSERT_EQ(READ_ONCE(st->rev), 0);
+	GUEST_ASSERT_EQ(READ_ONCE(st->attr), 0);
 }
 
 static void guest_code(int cpu)
@@ -132,15 +134,15 @@ static void guest_code(int cpu)
 	int64_t status;
 
 	status = smccc(SMCCC_ARCH_FEATURES, PV_TIME_FEATURES);
-	GUEST_ASSERT(status == 0);
+	GUEST_ASSERT_EQ(status, 0);
 	status = smccc(PV_TIME_FEATURES, PV_TIME_FEATURES);
-	GUEST_ASSERT(status == 0);
+	GUEST_ASSERT_EQ(status, 0);
 	status = smccc(PV_TIME_FEATURES, PV_TIME_ST);
-	GUEST_ASSERT(status == 0);
+	GUEST_ASSERT_EQ(status, 0);
 
 	status = smccc(PV_TIME_ST, 0);
-	GUEST_ASSERT(status != -1);
-	GUEST_ASSERT(status == (ulong)st_gva[cpu]);
+	GUEST_ASSERT_NE(status, -1);
+	GUEST_ASSERT_EQ(status, (ulong)st_gva[cpu]);
 
 	st = (struct st_time *)status;
 	GUEST_SYNC(0);
-- 
2.41.0.487.g6d72f3e995-goog

