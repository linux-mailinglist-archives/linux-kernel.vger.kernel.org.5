Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B17625B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGYWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjGYWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA9F3A9C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:02:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583da2ac09fso37502737b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322558; x=1690927358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8vBrFCkVPWmU+M7A3ccxaHSTsC04IRp9XhTTjvg0yU=;
        b=CiMAFXwnQXd4K7bn3PEXHvnIrqbHtd/zOIRLZNrhntouC770HmuD5pbMgsXLDu/jrm
         QS+6tgpD59U56JY4WBD8HGNoQjWQupFNSqSwTaDqWNrcLF4rKQSFW7OBcn8ZgKTEs+DU
         FAMF6k+RvFTtneh0IUQ6znu0LkpKPOnUQZbmKUS9zpnU0NGTgifAvlwWn73DyMePr0TD
         Wp+bJKP3DeH2Q2/fvXiVuwqIf9ggkVbaOUgAX0h98fmm6kRud7m/GgP0Mg2PttGSY/mp
         PGVVr4Muw0OL/v4ZZ9Qsyt+InpePObR17lDhoCfM4ksQjOTJV23ZORKyoI6Go37Pwfn4
         ENEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322558; x=1690927358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8vBrFCkVPWmU+M7A3ccxaHSTsC04IRp9XhTTjvg0yU=;
        b=W7WLvvnZyFEoapDWTVC1xqG7Pjh17JklsAGY51/c+57dWbiZr0vqbx0nY1OoAyQIqN
         niA9f5I93qrAwRqvqNTzAKRGQ4M1EFDB8CRZ1HKNuiZCwGlNjuXPIdmy9Yjy+v7iyMd3
         wBSJOTtksqdT67cXgZXBlrVXGVp+1PYYbP+IB58sJvZiw2/TdHgEpiRqEEhQQGX0vmRe
         LOPNOXfPO9hz6ZIU1m2+VcR+7xeW4ylOYB26vSSO6COJnQHx2Anl1/OCV48xVj7q/eBH
         bl+Si11bw8rAxyMpvJ8IyplFu7RsOwgVlbQ+wJFcgB6iM+W9SVapr52C3uM/tyhdv4jD
         Lyxg==
X-Gm-Message-State: ABy/qLb6moM13Bei/nad4/HpnDI/FlYLgPA0WxFj9CftqgYezhbAwPH0
        O4FInegHA6UmB0QFzxf2Is7ZaClAl4lb
X-Google-Smtp-Source: APBJJlGrIzd+2OghRSxPRIy46lHVWi3hHjIbtoGsIEDC8v+CC3KMafEjpzAYct7tIANcxiuKA6iO4/EbM1l0
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:42c4:0:b0:bc0:bfa7:7647 with SMTP id
 p187-20020a2542c4000000b00bc0bfa77647mr2089yba.0.1690322558638; Tue, 25 Jul
 2023 15:02:38 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:19 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-27-afranji@google.com>
Subject: [PATCH v4 26/28] KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I1eca6f65d627678c50b847b073041c61e71cdf0e
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    | 21 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index b71bcea40b5c..12863a8beaae 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -6,6 +6,7 @@
 #include "kvm_util_base.h"
 
 #define TDG_VP_INFO 1
+#define TDG_VP_VEINFO_GET 3
 #define TDG_MEM_PAGE_ACCEPT 6
 
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
@@ -41,4 +42,24 @@ uint64_t tdg_vp_info(uint64_t *rcx, uint64_t *rdx,
 uint64_t tdg_vp_vmcall_map_gpa(uint64_t address, uint64_t size, uint64_t *data_out);
 uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level);
 
+/*
+ * Used by the #VE exception handler to gather the #VE exception
+ * info from the TDX module. This is a software only structure
+ * and not part of the TDX module/VMM ABI.
+ *
+ * Adapted from arch/x86/include/asm/tdx.h
+ */
+struct ve_info {
+	uint64_t exit_reason;
+	uint64_t exit_qual;
+	/* Guest Linear (virtual) Address */
+	uint64_t gla;
+	/* Guest Physical Address */
+	uint64_t gpa;
+	uint32_t instr_len;
+	uint32_t instr_info;
+};
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve);
+
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index d8c4ab635c06..71d9f55007f7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -241,3 +241,22 @@ uint64_t tdg_mem_page_accept(uint64_t gpa, uint8_t level)
 {
 	return __tdx_module_call(TDG_MEM_PAGE_ACCEPT, gpa | level, 0, 0, 0, NULL);
 }
+
+uint64_t tdg_vp_veinfo_get(struct ve_info *ve)
+{
+	uint64_t ret;
+	struct tdx_module_output out;
+
+	memset(&out, 0, sizeof(struct tdx_module_output));
+
+	ret = __tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+
+	ve->exit_reason = out.rcx;
+	ve->exit_qual   = out.rdx;
+	ve->gla         = out.r8;
+	ve->gpa         = out.r9;
+	ve->instr_len   = out.r10 & 0xffffffff;
+	ve->instr_info  = out.r10 >> 32;
+
+	return ret;
+}
-- 
2.41.0.487.g6d72f3e995-goog

