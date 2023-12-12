Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5E80F857
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377402AbjLLUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377391AbjLLUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:48:52 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C271BEF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:44 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d08383e566so54491525ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414063; x=1703018863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=spishPpmYPggI3jrHmifejwbO19KNsurBr8OcADllgg=;
        b=AEo3KYgZ5i4SDTChjzjNMVNy33d2JI1HsAM93C7g2gSTWDWPhwfbWiB8PxD5l9Kw0W
         aUryWzAf7iYF+PLR5rzIWHfzcC/XYF6woNz6CJTUWVcpwa7HSwujY5Zxr50q/Xm82vUb
         Ub60azWqR4PIeT08pUtRasltsapmhsVQnMkZb1BpktQodsAbtDlCS/CkW4QlkeMKzuij
         UClgkq1wZfp0hsgR2MiNVBofEGKLAIyNV7u7xSku5HIzACXkNTIII2DVTaUmZEh0zOuh
         7J+491qVYITd/vnf23XhOAz1S9bNyczCyinHmdrSsL4dbS2/NB++8/9nzM02lrWk71xR
         OOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414063; x=1703018863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spishPpmYPggI3jrHmifejwbO19KNsurBr8OcADllgg=;
        b=jq3IRQmBlBlRMG083VzOkqq3fpqkLUmdL/EdJEFSZEdGqGGECfGYoLFg2rzgcrQDy/
         HH1+CCr3kSZ9i5ozg5QjSjYTGEHXgGMPKtIj1Egn6sioEdFSW99evn3b+pRBDdZW/VCM
         ensPE1meO0UmTMvM0p+RnAivI15t1RYB2pVNjP/H+E/G604o22KCUJvIfBjjvWDwBvSe
         BFlKMyiKyRkfN80gMYqkWZGlbp7Az8bS1GXOyKb500LmQkCkPhaOZETFQVvaAEIGJSUK
         X9jBqFD4stlsl6T0WxerJBj3wnXFCg+01LLYF01jq3une9aq8Org52jTraGXxuzGOsA3
         RPbA==
X-Gm-Message-State: AOJu0YxM+CNi2SvXrElAHKOtCx5jtvSC+G3CHaFf6JsiZaRKAFRTjWHc
        HN0b+SW4DYRAEW3wpdbh08fP5Yy27g==
X-Google-Smtp-Source: AGHT+IFlKWTN0Mjg+LZyGbYruNVICl9MYmL7i6+AqPcCDng1ipNePVkwIpMa5H+DBM6rjcGy9KpJR8EGiA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:903:234a:b0:1d0:6638:b9da with SMTP id
 c10-20020a170903234a00b001d06638b9damr52616plh.8.1702414063541; Tue, 12 Dec
 2023 12:47:43 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:40 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-26-sagis@google.com>
Subject: [RFC PATCH v5 25/29] KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>,
        Ryan Afranji <afranji@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Roger Wang <runanwang@google.com>,
        Vipin Sharma <vipinsh@google.com>, jmattson@google.com,
        dmatlack@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org
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

From: Ackerley Tng <ackerleytng@google.com>

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h | 2 ++
 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index db4cc62abb5d..b71bcea40b5c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -6,6 +6,7 @@
 #include "kvm_util_base.h"
 
 #define TDG_VP_INFO 1
+#define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_MAP_GPA 0x10001
@@ -38,5 +39,6 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 		     uint64_t *r8, uint64_t *r9,
 		     uint64_t *r10, uint64_t *r11);
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 061a5c0bef34..d8c4ab635c06 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -236,3 +236,8 @@ uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_o
 		*data_out = args.r11;
 	return ret;
 }
+
+uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
+{
+	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
+}
-- 
2.43.0.472.g3155946c3a-goog

