Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA067EC984
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjKORRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjKORRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:25 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F871BE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:16 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-547c18fce15so804734a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068635; x=1700673435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTRruPNWl9dydwy1RolnY7MN//AZ8WOLTxliFM7mi1c=;
        b=Ee4aX3M0Cz10ArioXTmvE8wNns63vmFuKJ/gPkllXdcBGxkbLd1QQJG2HGxEIpHWxg
         DOj/0+3mUGT4SWnJRIg7ZoTJOoXlofm0+HCkkkstmXJ3Wx8pkm1PYRbgemSvs8nyxYqY
         v6S39B3wXFOoh11qvG/k7hRMHckt3iEv6asthjBkZRX3IiGHbKHeQ/gUcvM/kdW9lGRz
         IMIkIpyzsUfkt/K0rF5XtpstMkDogZntS8WNP62n55aODy6r0qVd+pm+gaVBQvIiUu5n
         11Zi64X0sPjSckPp/d8emfJlWTEQT3LTBr5VODcuvaisIRLIdt+8SS0jTpoWj0V7kNW/
         pV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068635; x=1700673435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTRruPNWl9dydwy1RolnY7MN//AZ8WOLTxliFM7mi1c=;
        b=XAKkMdwRmHHjH8BIu0pNzHD52FyHD0I4GTKXP2gn+aEU9lZhrJ1GzDip+ABtdrf7io
         oRTKEHFO+jFXMKyJCfdIZUaDVmnuJnojsvuLUravP3TOOy8LPTO+qGiKYZK2Tc6iq+tR
         gaxuajJ+7yLqKxHf1+eK1BW6Z8MpsF0WV1z5etwg0q7pnmBGVHh3oMCFAm1HLXqA7r8N
         FzSf5UrVQqx9AkLlVifbiNrcbf3HnQOwJaykT/ezi2pHtM01tx1xrBzX5+P19exvbxhs
         KdBXiBVxfhLJJO0+jLpHHfVEuJqxRGVkjVtG6j7d3NWCAJYVxTS+CvAXfXjC7gjihL6X
         PK5w==
X-Gm-Message-State: AOJu0Yz5AP8ILNPNsxK5EBF/YeLcrl5TROR+aIkg0eYj1mcIgRjs2pkg
        PyeIuTiJ7Cm1H9AdZ5enmzoEa6pyXLhUFp63lbs=
X-Google-Smtp-Source: AGHT+IGsNbGDrA60Xa1dYe9ILtVmHQ514rV3j3OHq1AV69tXNThGqDwNIJ6SRVp7ouHANt4Icfonac0rBfGADpZZyaY=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a17:906:6bc9:b0:9c4:1dfa:de9 with
 SMTP id t9-20020a1709066bc900b009c41dfa0de9mr121012ejs.10.1700068635336; Wed,
 15 Nov 2023 09:17:15 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:39 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-11-sebastianene@google.com>
Subject: [PATCH v3 09/10] arm64: ptdump: Interpret pKVM ownership annotations
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com,
        Sebastian Ene <sebastianene@google.com>
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
index ec7f6430f6d7..ffb87237078b 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -273,6 +273,16 @@ static const struct prot_bits stage2_pte_bits[] = {
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
2.43.0.rc0.421.g78406f8d94-goog

