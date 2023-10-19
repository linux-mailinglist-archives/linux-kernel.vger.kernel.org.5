Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9465B7CFD18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346204AbjJSOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbjJSOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:18 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE0D5A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:07 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-402cd372b8bso61292325e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726465; x=1698331265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvJdm3IKmCA+/1ICly/hVREi8jIoDHSAqzssbPm75pQ=;
        b=dDAIq8h/+/3ho6ZC27ZoaLy0jU9a/H5HL5xtg5uQd3lRos/+61yuivhjWSBkH3TN4o
         pVOSkfITXJ0OD9aZZVhew2L77Y3kDWySsFTPPg2A9QLJP9l1UYQGfZPyHlDSOazuOhfl
         8a6qk/jvsCWfSkOHCTOnqDhiRCc3qGqRZ7TbMtSoITeq2ziYcdtQ7UXjMSvGJEqzOwSJ
         B4FKWdjzHx3ldcQKxG0EBlTGx9J/tN5W2NUt5Olo0q7jqTHdZUYRzp8anOoq4G5GXdcI
         D7V+Ztn660SDAMB2CKrRmPhCAvvrtMdWjDSbpThrDRUFAf+sa7OuSBReUTRgMZ89g1pX
         4TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726465; x=1698331265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvJdm3IKmCA+/1ICly/hVREi8jIoDHSAqzssbPm75pQ=;
        b=uHdchPccjsYF54WE+jbIxL+30iVZIK+J7pQAsLETL9hT8s5UdlqFhSpOAvrDetF134
         xctEwY3tXnHJPugr3C+nUZ704ViADWENUeL31LHTfqnriOJuPCOPzSFhnPahRQuSrSPP
         33ri/WIab0hy5BGeSNE0s2nR8am8vMHsEASmBVVWnmS1B2DvUDtwYc/RBkZviKiPl9+n
         5berMbk0X/pKijWEuADdV23nOgpl3hVyGdi/PbzvN3sMJxN6rn26bzWq2Y242nsnuvcI
         s0WoTKlsLE6+yLyYi7dArRtCxPIPUwkur8ljI0Ry79QDNOF8sjXiiS8qVo4spXrYth2e
         nwZg==
X-Gm-Message-State: AOJu0YyWuAbGtdNVANpBwh5OA6amvlXHnPKceTjTmIQ9CIL0aX4CtYjN
        oDMguEkxKeDz3cczvRCTSI7ZDGsNeSgEJ48NQWU=
X-Google-Smtp-Source: AGHT+IHd3XOdzZVQWrUJjDNXs2PGDHCNNjcdi3ZWTk5PP9acOL/8DnwH2AUd6D9476w0yP3WM6aezjeueor84uThLIA=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a5d:69c8:0:b0:32d:8188:6221 with SMTP
 id s8-20020a5d69c8000000b0032d81886221mr22460wrw.0.1697726465577; Thu, 19 Oct
 2023 07:41:05 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:31 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-11-sebastianene@google.com>
Subject: [PATCH v2 09/11] arm64: ptdump: Interpret memory attributes based on
 runtime configuration
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

When FWB is used the memory attributes stored in the descriptors have a
different bitfield layout. Introduce two callbacks that verify the current
runtime configuration before parsing the attribute fields.
Add support for parsing the memory attribute fields from the page table
descriptors.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 3ba4848272df..5f9a334b0f0c 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -85,13 +85,22 @@ struct pg_state {
 	bool check_wx;
 	unsigned long wx_pages;
 	unsigned long uxn_pages;
+	struct ptdump_info *info;
 };
 
+/*
+ * This callback checks the runtime configuration before interpreting the
+ * attributes defined in the prot_bits.
+ */
+typedef bool (*is_feature_cb)(const void *ctx);
+
 struct prot_bits {
 	u64		mask;
 	u64		val;
 	const char	*set;
 	const char	*clear;
+	is_feature_cb   feature_on;  /* bit ignored if the callback returns false */
+	is_feature_cb   feature_off; /* bit ignored if the callback returns true */
 };
 
 static const struct prot_bits pte_bits[] = {
@@ -173,6 +182,34 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
+static bool is_fwb_enabled(const void *ctx)
+{
+	const struct pg_state *st = ctx;
+	const struct ptdump_info *info = st->info;
+	struct kvm_pgtable_snapshot *snapshot = info->priv;
+	struct kvm_pgtable *pgtable = &snapshot->pgtable;
+
+	bool fwb_enabled = false;
+
+	if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+		fwb_enabled = !(pgtable->flags & KVM_PGTABLE_S2_NOFWB);
+
+	return fwb_enabled;
+}
+
+static bool is_table_bit_ignored(const void *ctx)
+{
+	const struct pg_state *st = ctx;
+
+	if (!(st->current_prot & PTE_VALID))
+		return true;
+
+	if (st->level == CONFIG_PGTABLE_LEVELS)
+		return true;
+
+	return false;
+}
+
 static const struct prot_bits stage2_pte_bits[] = {
 	{
 		.mask	= PTE_VALID,
@@ -214,6 +251,27 @@ static const struct prot_bits stage2_pte_bits[] = {
 		.val	= PTE_TABLE_BIT,
 		.set	= "   ",
 		.clear	= "BLK",
+		.feature_off	= is_table_bit_ignored,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_VALID,
+		.set	= "DEVICE/nGnRE",
+		.feature_off	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_FWB_DEVICE_nGnRE) | PTE_VALID,
+		.set	= "DEVICE/nGnRE FWB",
+		.feature_on	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_VALID,
+		.set	= "MEM/NORMAL",
+		.feature_off	= is_fwb_enabled,
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR | PTE_VALID,
+		.val	= PTE_S2_MEMATTR(MT_S2_FWB_NORMAL) | PTE_VALID,
+		.set	= "MEM/NORMAL FWB",
+		.feature_on	= is_fwb_enabled,
 	}, {
 		.mask	= KVM_PGTABLE_PROT_SW0,
 		.val	= KVM_PGTABLE_PROT_SW0,
@@ -285,13 +343,19 @@ static struct pg_level stage2_pg_level[] = {
 };
 
 static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
-			size_t num)
+		      size_t num)
 {
 	unsigned i;
 
 	for (i = 0; i < num; i++, bits++) {
 		const char *s;
 
+		if (bits->feature_on && !bits->feature_on(st))
+			continue;
+
+		if (bits->feature_off && bits->feature_off(st))
+			continue;
+
 		if ((st->current_prot & bits->mask) == bits->val)
 			s = bits->set;
 		else
-- 
2.42.0.655.g421f12c284-goog

