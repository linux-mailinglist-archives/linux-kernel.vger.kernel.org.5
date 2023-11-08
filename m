Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732CB7E4E26
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjKHAdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344530AbjKHAdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:33:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1001725
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:16 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso84626827b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403535; x=1700008335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4fLduEULj/w/qTyuS7dxoyFHFX9Y3I4W7nZGJLTTI/Q=;
        b=l9AD/gMU0/dtCaF8qUbSXvV2aPJepf1/58uKDor2tIhCv1IbdVaUMJXMbVFzQIMQGF
         95iBpUqUHQamuWByMvjSEt+EbP4L9EJCGkArZC4pRfN1iIMYYZU9Xd1kS4NP5oY1WGjP
         IlcGCrKkWvCo/LLNFhtEG0191KKVvvJ5JwQPriLNlGilhqYVkSHE9DN1SCfThzSmL4mm
         C1AuoVn82gzSDajT9i59urcgMzsw6ERkQhuYn/jFp9oQdvy+iQ/NgvpMC0XVg7NRcf+l
         5DTYRs2/hM6zkeclGZ1LXbH1HrFFVmc1tW2xqLgYiDrgqApO7RVxd9RUY9D3SMTnbqVR
         HwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403535; x=1700008335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fLduEULj/w/qTyuS7dxoyFHFX9Y3I4W7nZGJLTTI/Q=;
        b=FyvIO8U2pllbxiu7AMjkWs4HDOOm2VeNfgcXZ2ekbY5IUybrU0EMHwV2elKi1W7/m2
         /2ictRahm56pcaSitMeU9uueCFf2iuI0gO9LOSO0/CGcHfaiA8OgEvGDkYGzi2l5jI+L
         YPfIAkdXZdvqk4nXdWsRhRpXTfBSY5TJrxUNWgW0X/bv+lU5IfQg4OoRmLtHRQBjZ+OF
         921tkz94adYLghoyMkpN6pxEfeNVQ8Kt/wu6I70Aefj9uqj+zkGvnzsMC+WGIb91IU4V
         x8jthISAobv6enfEYap3eJbhJ7fkpgtMxshqNhBGOGjIXmyYiu8ZyjMPpudmMD96hLDe
         /9jQ==
X-Gm-Message-State: AOJu0YzjR6rc4O+F/yeg3GrD2izu6Ap7laXDS3YtC1mEjpRYbyPikobu
        pX5fI4Q5pJfGEI1vLsYtv3vuFXpqHSI=
X-Google-Smtp-Source: AGHT+IF26YecZ3TkuT4mazJpI08/dC8kqyOxF3VyvF05ZDK0MFVW2garzyomUhDteSezExjmTaKoCiF/Qf8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:cb14:0:b0:5af:a9ab:e131 with SMTP id
 n20-20020a0dcb14000000b005afa9abe131mr4542ywd.1.1699403535389; Tue, 07 Nov
 2023 16:32:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:34 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-19-seanjc@google.com>
Subject: [PATCH v7 18/19] KVM: selftests: Move KVM_FEP macro into common
 library header
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the KVM_FEP definition, a.k.a. the KVM force emulation prefix, into
processor.h so that it can be used for other tests besides the MSR filter
test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h       | 3 +++
 tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 8a404faafb21..e5c383bd313b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -22,6 +22,9 @@
 extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
 
+/* Forced emulation prefix, used to invoke the emulator unconditionally. */
+#define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
+
 #define NMI_VECTOR		0x02
 
 #define X86_EFLAGS_FIXED	 (1u << 1)
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index 9e12dbc47a72..ab3a8c4f0b86 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -12,8 +12,6 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
-/* Forced emulation prefix, used to invoke the emulator unconditionally. */
-#define KVM_FEP "ud2; .byte 'k', 'v', 'm';"
 static bool fep_available;
 
 #define MSR_NON_EXISTENT 0x474f4f00
-- 
2.42.0.869.gea05f2083d-goog

