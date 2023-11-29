Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF27FE39A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjK2Wt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjK2WtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:49:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD43D69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cddc35545dso4928307b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701298167; x=1701902967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bWMFxsne+gpl88lI6YduYGZQRPXK3Vk37mspokD2wHM=;
        b=ZENs0hs/af+xss6arfJvEJ5iNBhj5w5Tw0B5WLQ/ahBMHb7/kuDwrbb0l37y2gFMQ2
         IXHxvxwaTrC1GK+fm+Jwt5Iv8pBDepdDA4/JG3ymZVpq697ntXmm0ZM8fZRgYSUC7Cmt
         2CDbgAbsWRn2OFGktvMbrYV5jTQntahQ9cxHBg2wlDXxitdY0CCYZNiva8W98jWCXOxp
         FI8fjQ7klVKVPO9loK1bmfPzhRPTJ42nlgzkwWLSkxlSyOXXY+vEp+YzxfXzQOW0yCRX
         7Nt6NNsoG2FOwi3IK9rvHDmOiuKBnDDw1F/NmEYVSoD7MwpA/aj0sv7yLs3OikJqPrui
         CtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701298167; x=1701902967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWMFxsne+gpl88lI6YduYGZQRPXK3Vk37mspokD2wHM=;
        b=fVA295SmQCbtTvcS7IipV1rKKxKFxCfgufB6BzXyjcliKUtYy7amAX8l9RPvA65Em8
         pSRZb/sGJQTReA0Kj2nHEWlqLWCDV+lKdltmO7aJbP0LK6had3u+REPIM0itT0sUiRVZ
         emyAUaOirbVKY47nYtvarKGOI62CzcWh/clJ6dukqJuOrPlDyTtitSKnzSS6raxFql8V
         LpX36gJhdG4/ybDDImWw58QGeuzqki8pOcjCKdwH+MNyrMPbzx07uWiVh2Y+gfkfUPhb
         jwAn++gTIAH2xzpWXBsa+6G6y9Hb7TuTj2crGLSbWLCyaNKwDyVzyO6OB4j6T+soo2Qr
         kQrA==
X-Gm-Message-State: AOJu0YzUMLOslD/KvqMfscCl9BA1EoPeYUg/95fhq4fgS6rEBjp813h+
        RaFN4NkFAcVUTD5DnNedtfHhbWTDW+8=
X-Google-Smtp-Source: AGHT+IFfWN+UtOLGwzsyM0bGshSYC31E3NK9PtvRfmfe+lo2abmXbvWxKKN8xpuOIW7WpNfpdw1ylMe6zJM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:be15:0:b0:5d0:a744:719a with SMTP id
 i21-20020a81be15000000b005d0a744719amr342961ywn.2.1701298167236; Wed, 29 Nov
 2023 14:49:27 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 29 Nov 2023 14:49:16 -0800
In-Reply-To: <20231129224916.532431-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231129224916.532431-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129224916.532431-5-seanjc@google.com>
Subject: [PATCH v2 4/4] KVM: selftests: Annotate guest ucall, printf, and
 assert helpers with __printf()
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

Annotate guest printf helpers with __printf() so that the compiler will
warn about incorrect formatting at compile time (see git log for how easy
it is to screw up with the formatting).

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h    | 2 +-
 tools/testing/selftests/kvm/include/ucall_common.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a0c7dd3a5b30..71a41fa924b7 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -191,7 +191,7 @@ static inline uint32_t atoi_non_negative(const char *name, const char *num_str)
 }
 
 int guest_vsnprintf(char *buf, int n, const char *fmt, va_list args);
-int guest_snprintf(char *buf, int n, const char *fmt, ...);
+__printf(3, 4) int guest_snprintf(char *buf, int n, const char *fmt, ...);
 
 char *strdup_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2), nonnull(1)));
 
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 0fb472a5a058..d9d6581b8d4f 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -34,9 +34,10 @@ void ucall_arch_do_ucall(vm_vaddr_t uc);
 void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 
 void ucall(uint64_t cmd, int nargs, ...);
-void ucall_fmt(uint64_t cmd, const char *fmt, ...);
-void ucall_assert(uint64_t cmd, const char *exp, const char *file,
-		  unsigned int line, const char *fmt, ...);
+__printf(2, 3) void ucall_fmt(uint64_t cmd, const char *fmt, ...);
+__printf(5, 6) void ucall_assert(uint64_t cmd, const char *exp,
+				 const char *file, unsigned int line,
+				 const char *fmt, ...);
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
 int ucall_nr_pages_required(uint64_t page_size);
-- 
2.43.0.rc1.413.gea7ed67945-goog

