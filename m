Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ACA7E0C97
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjKDAEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjKDADk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:03:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5411728
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:03:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b0c27d504fso20296597b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056197; x=1699660997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ivj987AddR8Owbgd5+Jve951XXZrxlCEMaI81HO/fho=;
        b=vB8uk2rachPlU9IgHAvpB3Hex6MGK3TRc2L9isZdLll/Fr2xUopomBfabgLbdmkMt5
         91EPG9deV9taAczbA/Y8BNhdKPfuata77syMBR4C152f5AK6DVxSOESXBJPmbtQjzhDl
         dOgvwwi9GmZwq+P+FQrSpRMZIi03x5MBt5ga0s1KA3YCFl6L5hIHD8hN7d6nUWDyF6d3
         TIOkNf+noq6k30PDhvpxRCrfIqUJ8zYYUZZc4y3D2DYxVbvCYMclNXkIYicJBEKr/yVA
         urW+2xo+qqL/tDA6WuMdaL2mxadjQ+vhERKIbgGm5mWDKwi8LxXTKdhUzcqhcTr0n6v7
         x84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056197; x=1699660997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivj987AddR8Owbgd5+Jve951XXZrxlCEMaI81HO/fho=;
        b=GOf4a3B9vTIoLcRQDMRn3UZC7cYzQneCKU1oxgNDlJeimIRE7/PqKHakkWsSwJVG/c
         O0WusxQPqLfnrMUc0mq6UJUOhf7LGArnaC8DV34xpHXQNgZKtAwicsP80wDpvvqau4um
         XqSd2/TTmGsGPeYEtS+S/x1p8zdamFIr6jNc/XKXiKLL23Bi0LMKNEmAT3rG00hnuINc
         dMDY4Lqj71SRoanxcZEjEQlT5xy+tmPg9UG6IDVcJ1D7eef5iOhWG7K5MuQ0Qu4cegdy
         Fyhnm8y5WYKuSq9fEbgqgTiENAs67vRrwl7OKHFWuoK3xWK5DAbkMiRlZWNs5egxlVrB
         /hBA==
X-Gm-Message-State: AOJu0Yx1HOHGKhZnXkIAIlWeaBJgUzTqfZQIh05NiCjkEec4+WtMPO1R
        CTTilY396WQmj/gl7qI3rNhaIfQkuD0=
X-Google-Smtp-Source: AGHT+IE/fyh2EC7KV93wZTxCRE6YJwWbGaND7lBPBJsISEAlzdVjQRVpH2PkEEXxHztcKHoC8cQnXECLu8M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3690:b0:5ae:75db:92c5 with SMTP id
 fu16-20020a05690c369000b005ae75db92c5mr114654ywb.2.1699056197083; Fri, 03 Nov
 2023 17:03:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:37 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-20-seanjc@google.com>
Subject: [PATCH v6 19/20] KVM: selftests: Move KVM_FEP macro into common
 library header
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
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
index 47612742968d..764e7c58a518 100644
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

