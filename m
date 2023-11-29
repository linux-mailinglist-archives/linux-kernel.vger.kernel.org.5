Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A97FE399
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbjK2WtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343567AbjK2WtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:49:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9280194
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5caf86963ecso4259417b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701298165; x=1701902965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=obqRJwrAc0R30oE9DQOo5RZu0y3Es0pUF6guVfZd4RE=;
        b=j01pUN2FfrLsdIdVuWQONS6o2QYDAtPibP9zZIe4jIeN5cS2kUhvpbzr7BF3hZjSet
         2ZkCXkWYDDb3LbvsCg6MNGp/uI3ZwWjvG3tB/NpKbth1cXF9xjFCY4IOkWXkyNsTMzdF
         cM44Fg6edusAbgN+/1twVIToLEu87QMLKubFhD3TyKwsu4VEiK9Be/rc25ZbGe7boCMG
         L7S3pTyB7sD3/nbhc26aKpXgbKsbslKIwSW3f69MdMyR/aGKMoK54MEgW+idjIXrMdv7
         +DCabK675yKPbgf1InOA1Ocogyl1FPlGVwNWmlKBUtG/uY4NvG+dMkkd18VNkfQdQSlJ
         aPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701298165; x=1701902965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obqRJwrAc0R30oE9DQOo5RZu0y3Es0pUF6guVfZd4RE=;
        b=kpZywE8TP02S0SUTHr8qEnubd+xuvg4zjH311AdmA1f1HKqT+lG+YN6gMp+zVRod8d
         L3YwyMS/0L06E5ZWu22d6o7U+e7nGORZD6X4sMT6W1D7aI4/JhdBXJJzK6ae1BsUW7MQ
         8cJaNRQVWJtWE4Hj+zjY6WVlwpC3VPDgYxhaDlG1u5k4LzzC2nt7jEw1B91RhJOr5hgT
         2XXwftF603CyxBclfDuoeeL8W0FQ5eI5MGeIuMWVTv0dES9rb7mV+4Jo9kX4xeI6YRtR
         CDbrpwwR0/Psjr7IaWZxI+o1W9b8EGGLdlRY8rXlgQ7+SkiRSbPvLXjajXALTMY8/6xM
         5GRw==
X-Gm-Message-State: AOJu0YzjBr9GBUfdhEz7SQES7JG9ecAxtyIaOFjmqnU3qzDgDTgvPISE
        3FrGfvmpeoLLax+0hl8V6ksDc4/0a5I=
X-Google-Smtp-Source: AGHT+IFiO/2Aj0FYANjdTLdz18AsCY+hgJd7gw2a7Qpd4J7gUjOl+TCyJnqhI0rjeJ5wx0LkoWDUuMe+l24=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:e19:b0:5ca:724d:9256 with SMTP id
 cp25-20020a05690c0e1900b005ca724d9256mr709697ywb.7.1701298165115; Wed, 29 Nov
 2023 14:49:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Nov 2023 14:49:15 -0800
In-Reply-To: <20231129224916.532431-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231129224916.532431-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129224916.532431-4-seanjc@google.com>
Subject: [PATCH v2 3/4] KVM: selftests: Fix broken assert messages in Hyper-V
 features test
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

Swap the ordering of parameters to guest asserts related to {RD,WR}MSR
success/failure in the Hyper-V features test.  As is, the output will
be mangled and broken due to passing an integer as a string and vice
versa.

Opportunistically fix a benign %u vs. %lu issue as well.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 4bb63b6ee4a0..29f6bdbce817 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -55,11 +55,11 @@ static void guest_msr(struct msr_data *msr)
 	if (msr->fault_expected)
 		__GUEST_ASSERT(vector == GP_VECTOR,
 			       "Expected #GP on %sMSR(0x%x), got vector '0x%x'",
-			       msr->idx, msr->write ? "WR" : "RD", vector);
+			       msr->write ? "WR" : "RD", msr->idx, vector);
 	else
 		__GUEST_ASSERT(!vector,
 			       "Expected success on %sMSR(0x%x), got vector '0x%x'",
-			       msr->idx, msr->write ? "WR" : "RD", vector);
+			       msr->write ? "WR" : "RD", msr->idx, vector);
 
 	if (vector || is_write_only_msr(msr->idx))
 		goto done;
@@ -102,11 +102,11 @@ static void guest_hcall(vm_vaddr_t pgs_gpa, struct hcall_data *hcall)
 	vector = __hyperv_hypercall(hcall->control, input, output, &res);
 	if (hcall->ud_expected) {
 		__GUEST_ASSERT(vector == UD_VECTOR,
-			       "Expected #UD for control '%u', got vector '0x%x'",
+			       "Expected #UD for control '%lu', got vector '0x%x'",
 			       hcall->control, vector);
 	} else {
 		__GUEST_ASSERT(!vector,
-			       "Expected no exception for control '%u', got vector '0x%x'",
+			       "Expected no exception for control '%lu', got vector '0x%x'",
 			       hcall->control, vector);
 		GUEST_ASSERT_EQ(res, hcall->expect);
 	}
-- 
2.43.0.rc1.413.gea7ed67945-goog

