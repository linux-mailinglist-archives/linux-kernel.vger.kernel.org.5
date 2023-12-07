Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC51807CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441806AbjLGAMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjLGAL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:11:57 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2BD59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:12:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d053953954so2333355ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701907922; x=1702512722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3cjh/OicCbB8QyzwRWb0eXa967TdIfrySjWwl2ZooY=;
        b=AcJEwKRtnRhFdf9yERxlg2/bQjSarjJHqoSk7XjiA86DOSwJW98aocwUPyK6j++Q5i
         ERvBtbKngbATkTO1344e1Lgg9JwwXqRP/dBrrssHpca3FhfcHu1nFkBTTN8wnVPcx1xE
         /LspOhEOkrMYh9nxjdzeTX15c5FXINmIMT7x2Pa30q9spgOkeNf2YLAksyO0FNz0cCfh
         Xi8H409VKeXRyuJBf7EgiiJWK5CVbzrXhicH9nm8GDUrEGbL1dM8tGlkcIWf6tt7Ycd2
         jnuyySK0iCM7eR5q3KPz+QRUIK0qNsQL7gOfScEgKWonXlglCE1hAnOPilGWz6ICwLF5
         K3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907922; x=1702512722;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3cjh/OicCbB8QyzwRWb0eXa967TdIfrySjWwl2ZooY=;
        b=VfSYc1rPT6roi0Sl6eATBdL3vYJlsC3KRfNLFTQ7sMNLuD8jUUJNzwmiT8XRjHMKy4
         AXXrXrD8ERPT+5+eUjuwXp48ODLeELtTEUInf3ivpKlZJcRBuUfduKumcYU1wbLmskKM
         r2wj6twO0y3mhVIDT/UQAhA6sdHD5w4+D9tmDtxBZO7hO8kzPXqwz1LVS9Pgd2Sz2ScW
         KBJdKM+TqBddGZ3mD5y8PziKixZFNl942zOh7id/9CUEKsKCc/NA92PuVbbOAdkdb32V
         lq1N5R62pOSSNwtnNdVYtLqLziW8p+zBKqtIusEiBu7rK62mB06JbjRBc9OIiHUpibtk
         GWGw==
X-Gm-Message-State: AOJu0YwzrpDXAHjYIUlJUxtBmfrSnbZk3fijEpRIiDVzHID2N+6y1vBV
        KyhdIAu9uAiF4bSYRQ35zxvcg6Dr1b3FLmD0yA==
X-Google-Smtp-Source: AGHT+IFhH+WCd8DAawr4vLyQHCpqGtGc1HufViK0emU+lU7pKAr0bAQNvOdUDmWpsf2ekAPUQhaWWageB2FN+GwAog==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:eccd:b0:1d0:96b7:7f4 with SMTP
 id a13-20020a170902eccd00b001d096b707f4mr24174plh.12.1701907921779; Wed, 06
 Dec 2023 16:12:01 -0800 (PST)
Date:   Thu,  7 Dec 2023 00:11:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207001142.3617856-1-dionnaglaze@google.com>
Subject: [PATCH] kvm: x86: use a uapi-friendly macro for BIT
From:   Dionna Glaze <dionnaglaze@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        seanjc@google.com, pbonzini@redhat.com
Cc:     Dionna Glaze <dionnaglaze@google.com>
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

Change uapi header uses of BIT to instead use the uapi/linux/const.h bit
macros, since BIT is not defined in uapi headers.

The PMU mask uses _BITUL since it targets a 32 bit flag field, whereas
the longmode definition is meant for a 64 bit flag field.

Cc: Sean Christophersen <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/uapi/asm/kvm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 1a6a1f987949..a8955efeef09 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/const.h>
 #include <linux/types.h>
 #include <linux/ioctl.h>
 #include <linux/stddef.h>
@@ -526,7 +527,7 @@ struct kvm_pmu_event_filter {
 #define KVM_PMU_EVENT_ALLOW 0
 #define KVM_PMU_EVENT_DENY 1
 
-#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS BIT(0)
+#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS _BITUL(0)
 #define KVM_PMU_EVENT_FLAGS_VALID_MASK (KVM_PMU_EVENT_FLAG_MASKED_EVENTS)
 
 /*
@@ -560,6 +561,6 @@ struct kvm_pmu_event_filter {
 #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
 
 /* x86-specific KVM_EXIT_HYPERCALL flags. */
-#define KVM_EXIT_HYPERCALL_LONG_MODE	BIT(0)
+#define KVM_EXIT_HYPERCALL_LONG_MODE	_BITULL(0)
 
 #endif /* _ASM_X86_KVM_H */
-- 
2.43.0.rc2.451.g8631bc7472-goog

