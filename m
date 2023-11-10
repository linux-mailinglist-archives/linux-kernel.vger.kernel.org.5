Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB177E7743
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbjKJCPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345884AbjKJCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F34795
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5aecf6e30e9so22387827b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582435; x=1700187235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4fLduEULj/w/qTyuS7dxoyFHFX9Y3I4W7nZGJLTTI/Q=;
        b=jgep/4ESbx2q//xdJmZN0gH1c4O22bP02/cTi8dnKfkpKYV8DgjNvSJnJDFNu3j8Qf
         w/5naJFyjdrLyMXcYWgljl9FFuYDXFQX9LI2ccxn7AZBrf8zg+COLqsvZ2uTO4lpyCse
         D3+quN+0QtGsHXcT1R4mkwTa4B5nVNv/PX1W5v27bnObsDj66xIQbqe7vxPIVWHzsKVd
         l2Ewf9qfRoMRuZXJMKS10WQs5JV6nL3a2m5RPb1qpLq4/Vury2TjCKEadpHtNFrq0nhK
         p96mi6TsL210Z2AoseEfw9vNdXvMJiddN6PsCvVr8M2QqjEkG7Jdvg9YJaQ80icJVKZ6
         M3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582435; x=1700187235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fLduEULj/w/qTyuS7dxoyFHFX9Y3I4W7nZGJLTTI/Q=;
        b=UYVa6eqgtTDSpjtotODxUZj5V3uE9d/VCfMu07LQVTvqmlQM9fdLehrzwdmzydTDWv
         0RkcYDCdub/6lQH+JSn5WY25WM3bU7Oew5+JMkUdHO4VPAjnn7/2d/SvW8czixwCE1VR
         mqJPE+An3AIwRGYU+ANGzFOgdAuLzWb0UlkeuFUUd1LCRVM2QpMyOKrdwMdKfVvDaOcO
         ldni621S5pOSTgMHQJWZHUFfwgc/rJrpPRhgS6to/ZUryi0sHsNftSe+7jSnyHQpmjjP
         95edmU2EY5wFlsFtomgNK0LFtDPOSrgq5gUkyp0mV0/3f1/Qh1vjT2MmKDz+meX8KMZY
         0VQw==
X-Gm-Message-State: AOJu0Yx/M/WUETWz0Nehk5/45ehSf75sMZHpsEQaW8ac/jqM7Wk8O03A
        nO62gdhcWGXH9xD0duwFEWQS3atS/3o=
X-Google-Smtp-Source: AGHT+IFCCj3dYYPcyP4RKhTRYyIWOxqoaA83nLmEG6oKXFSqAV/Q/a0CLt7ZXM5r6z/FPR+5hNdBQ+VpRRE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d689:0:b0:da0:622b:553b with SMTP id
 n131-20020a25d689000000b00da0622b553bmr185399ybg.12.1699582435282; Thu, 09
 Nov 2023 18:13:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:13:02 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-23-seanjc@google.com>
Subject: [PATCH v8 22/26] KVM: selftests: Move KVM_FEP macro into common
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

