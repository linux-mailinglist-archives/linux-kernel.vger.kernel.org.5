Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BAD7CFD19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbjJSOlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346306AbjJSOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F694D64
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a541b720aso10723683276.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726468; x=1698331268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xftGt32Kc2uJsZHB8ze2page16/hOUtIzMgZlEPPmoQ=;
        b=cniTmtkYJaLmH8pQJm+fcRprTpm/i6WMp3vQldgSG4jStMn+UFXEdJLYhSQj98pAP1
         QQIxui+VmuyQGW4vURV+xTLy152T5sCDljuJD2L9+cF+LbSokfWPZvsQMn6owxr+VoHi
         5VOWJB8IwXxPwYaovkzab+Zbdpt0hn/ZFzf96vlfHfPqBbY9an+y5fHQ+/D3sSyoyF5l
         onrle18wjchofwHE8RJBbWg9DgepCyLk/i8KbjhKHlkcNB0agtfjkWlOu9W64UHwZNeJ
         BprTo7nVpZ07W0vgV1B03Ct0lHKZOvWNNWt50ibfieKeb2lAZUb7Od+g1f3eNaN3v3Up
         yIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726468; x=1698331268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xftGt32Kc2uJsZHB8ze2page16/hOUtIzMgZlEPPmoQ=;
        b=QyDzWGED+JglXOWK0Od44QO2FaSywaiXooWiZrKluanWufZJ9QAzh+ei6OyBwGErl9
         dSzvZZGZ2YbEpnY3FzfjptyjivGRoy2QRPy8lr9Oyn4iLDaQfgt6pZioRmCsWjyvBhnQ
         XhPf9ENbON+0MricVAd7ZRPeQ7ms9AoQWccC2aACTECFCFbXdqwCtSLMRNg9BRDEhytl
         aYqJMbZA0u+SW3k5cR1GYFomJETHDNaYR3XLpp7If1afs4ybeoHaRhEQa2ldg7mh/geE
         XGZ8pmD0RLuUv8zvtS7jy4w/5NqRY5xKE74FJg9qDHy9bhYdQZyxQne3AXJ3x5kQJ8V3
         uigA==
X-Gm-Message-State: AOJu0YxeZ3hGTua/dCOgvCuCZTsily0Gd1ZCLUb0iQ4jWI5W4ABNFJC2
        N7IVI9VGMLs+MsR21TKxnVtfXmIw9IgClt2dLXI=
X-Google-Smtp-Source: AGHT+IFtSjr7T40BzHDbdRv4+sctKo6cAFEpgYFv+HjP7AsCbv5VJzDwEJP06mRqUCkT5ofH/tqCU9ngOoHkCJ7VGcE=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:1825:b0:d9a:d272:ee58 with
 SMTP id cf37-20020a056902182500b00d9ad272ee58mr55549ybb.9.1697726467984; Thu,
 19 Oct 2023 07:41:07 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:32 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-12-sebastianene@google.com>
Subject: [PATCH v2 10/11] arm64: ptdump: Interpret pKVM ownership annotations
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vdonnefort@google.com, qperret@google.com,
        smostafa@google.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for interpretting pKVM invalid stage-2 descriptors that hold
ownership information. We use these descriptors to keep track of the
memory donations from the host side.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h          |  7 +++++++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  7 -------
 arch/arm64/mm/ptdump.c                        | 10 ++++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 913f34d75b29..938baffa7d4d 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -87,6 +87,13 @@ typedef u64 kvm_pte_t;
  */
 #define KVM_INVALID_PTE_LOCKED		BIT(10)
 
+/* This corresponds to page-table locking order */
+enum pkvm_component_id {
+	PKVM_ID_HOST,
+	PKVM_ID_HYP,
+	PKVM_ID_FFA,
+};
+
 static inline bool kvm_pte_valid(kvm_pte_t pte)
 {
 	return pte & KVM_PTE_VALID;
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9cfb35d68850..cc2c439ffe75 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -53,13 +53,6 @@ struct host_mmu {
 };
 extern struct host_mmu host_mmu;
 
-/* This corresponds to page-table locking order */
-enum pkvm_component_id {
-	PKVM_ID_HOST,
-	PKVM_ID_HYP,
-	PKVM_ID_FFA,
-};
-
 extern unsigned long hyp_nr_cpus;
 
 int __pkvm_prot_finalize(void);
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 5f9a334b0f0c..4687840dcb69 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -272,6 +272,16 @@ static const struct prot_bits stage2_pte_bits[] = {
 		.val	= PTE_S2_MEMATTR(MT_S2_FWB_NORMAL) | PTE_VALID,
 		.set	= "MEM/NORMAL FWB",
 		.feature_on	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_INVALID_PTE_OWNER_MASK | PTE_VALID,
+		.val	= FIELD_PREP_CONST(KVM_INVALID_PTE_OWNER_MASK,
+					   PKVM_ID_HYP),
+		.set	= "HYP",
+	}, {
+		.mask	= KVM_INVALID_PTE_OWNER_MASK | PTE_VALID,
+		.val	= FIELD_PREP_CONST(KVM_INVALID_PTE_OWNER_MASK,
+					   PKVM_ID_FFA),
+		.set	= "FF-A",
 	}, {
 		.mask	= KVM_PGTABLE_PROT_SW0,
 		.val	= KVM_PGTABLE_PROT_SW0,
-- 
2.42.0.655.g421f12c284-goog

