Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12C980189F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442113AbjLBAGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442060AbjLBAFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:05:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1192118
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:07 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c941936f7fso31679777b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475507; x=1702080307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IhZ3de9k1HjNH/Bu/XjK12LAbUtP2nz//8sjZrcxVFU=;
        b=yi3mtKeSyuMTg2ekZ+/+KHt6dGdM8458RVwREftQmbGtrJYq7406KdRABl9PcTb+CL
         BxDGHqeC1gn6RyA1uK6n92dx8yT844WisuaPX0XC3v0byK1djW/n+hIvhjq+z4CGh4ZP
         oKG6hErIloQ3LrBOiDqurHnpbbOy/Q5fmfvgJ6DbEu2DysHogYB5+A9NBkiYC0TG7F+K
         7CHKIpg9igtAgW1T2+NzZo2dPu5gTAamE5DaEzqQyWFB6gYxhSv9GRsfWhXi5sZ+G3gp
         Q6p9DDpr32sc0PTPe06Ra+TtDRrtQdi6OjXaIAnHab1Df1GufCC6HEGsGz5smCm+d1Hf
         rJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475507; x=1702080307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhZ3de9k1HjNH/Bu/XjK12LAbUtP2nz//8sjZrcxVFU=;
        b=GLqT2fZjEQwwubG1QYtxgDGPfqmc1O8qsLEdrvwkvFCZ7ojA6uNXlHf7vR6O41Ng6R
         f8r3stxdyGsbowya1UMAwYG8aT2/idmbHFvjQjaQPdsG/dnwq0VP7Et8ZyOr6sPzgFgL
         4IlcZcniVE7awv77teCf3c9QvjQRfkem0eGrDFON6QeVM5C03LslgP4H66oQJHwytKg1
         L4al8ByEF/kcS0Z5LxfD+1eDiSM2rhUWuHuKNCLSPtr+DhNkW7OoTL+2Nh8WZlO3ouWG
         AxTJzPGa8uT02zRY3u7ED+mKRoR3jqa7nJutH+CG3zgvODz+RnJjVmTFEWTCo/3yp1Gd
         lNOQ==
X-Gm-Message-State: AOJu0YwkFAYsCsBlmVktS0SoBK0Ntwh7ykqSSR+xzUc7gxd1hhWgRXZM
        okMLv4mYym7KjmvxJJS6/lV/cWRrFQg=
X-Google-Smtp-Source: AGHT+IF7EvbF+32/WpDow2GN0LC+RJVYaIxYrl/y8e1tQA4IoCLx/a9NVjw2ndyWlMFBlrsBZDrM/VqVii8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:33c2:0:b0:da0:6216:7990 with SMTP id
 z185-20020a2533c2000000b00da062167990mr1090050ybz.3.1701475507021; Fri, 01
 Dec 2023 16:05:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:04:13 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-25-seanjc@google.com>
Subject: [PATCH v9 24/28] KVM: selftests: Move KVM_FEP macro into common
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index d211cea188be..6be365ac2a85 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -23,6 +23,9 @@
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
2.43.0.rc2.451.g8631bc7472-goog

