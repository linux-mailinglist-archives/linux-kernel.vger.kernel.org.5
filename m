Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FBE7EC983
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjKORRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjKORRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1326AD6D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:13 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa071d100so148844227b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068633; x=1700673433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy3zX0s6ALtK+DaG4wUXBjQ8F6aHRpWpiFcWV1cr/U0=;
        b=nR6PK/+008SAq1seEfnKT0/2+xngpAiBhIDUKWLk9c1hrMWjUTVQYqYRgJPk4tVW2X
         izvzNx860G2ZjZzxR0ovojefWBqeKkw/Xb38sxkommQqbLg0oLn1R6Pe4ktjQ0igd5ny
         X9iSg79JjqQII7PDb8NorG8pxLRsl/ieLWAtGaetNLzdyiLB+55rUvJyH7GRZCjkD1wG
         J3U+DHc2ngwQ5MHrTmAu+z1qGuMymab3Bni8qMG0Lm376qooO7uV/cOps0YK90h0KXUi
         FJSkFrS5qM3jXwktXZORAD8rzUAV7KhHNFoT/IXxBvWM+nydqE5Ozcn8w5zZEnBXQbly
         VYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068633; x=1700673433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy3zX0s6ALtK+DaG4wUXBjQ8F6aHRpWpiFcWV1cr/U0=;
        b=LCqowOE5zxCwDybV+7YiLP6yQr7fyMdepqrmRImy75iQYxiz66mgXA8DDid2/JqYER
         w2BZCtYArvj0Ed3gycXbuceR6lpvF6a5uxfqKo/2+zOUGp9KERFYvw4hqpHfM/5dMqCd
         pZm2x8cozquyDU4r4Z0paXoZRqmkv7fq/lv20y7OXOcvYfO7B/e9jXcEncJa25gvWsMi
         OLqW8md3dN7m5wKuo92qR3D1VPM+wGCACnntEtKUsQHJ5qt3In6Pgz9VuEj9wRvGXafJ
         cGBs8jaZtkMoc0EfU46Ke/TM9/Qa+5bV9hkCfHtk/LpQwPfNmEVgrAziAVSPLaC4yB6l
         0KFw==
X-Gm-Message-State: AOJu0YxoQZ7ElQGQ6IW1XEF+/WagcK1h/Q83A21friVyG4SXYfrC95Tq
        0g/G+3NL3A2XvprZ6FF6vQtKq7E/FSHk+2fpb7w=
X-Google-Smtp-Source: AGHT+IH15zotRvXqa3gGL+erJN8kJ8qtR4AedLWdqyhduoqwJwWiS5LNpUVQnjgpQUblW7SZJCRmmCsMHRZC6boVABk=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a0d:d7c3:0:b0:5a7:b672:4d88 with SMTP
 id z186-20020a0dd7c3000000b005a7b6724d88mr356731ywd.0.1700068633096; Wed, 15
 Nov 2023 09:17:13 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:38 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-10-sebastianene@google.com>
Subject: [PATCH v3 08/10] arm64: ptdump: Interpret memory attributes based on
 runtime configuration
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

When FWB is used the memory attributes stored in the descriptors have a
different bitfield layout. Introduce two callbacks that verify the current
runtime configuration before parsing the attribute fields.
Add support for parsing the memory attribute fields from the page table
descriptors.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 65 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 9f88542d5312..ec7f6430f6d7 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -89,11 +89,19 @@ struct pg_state {
 	struct ptdump_info_file_priv *f_priv;
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
@@ -175,6 +183,34 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
+static bool is_fwb_enabled(const void *ctx)
+{
+	const struct pg_state *st = ctx;
+	struct ptdump_info_file_priv *f_priv = st->f_priv;
+	struct kvm_pgtable_snapshot *snapshot = f_priv->file_priv;
+	struct kvm_pgtable *pgtable = &snapshot->pgtable;
+
+	bool fwb_enabled = false;
+
+	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
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
@@ -216,6 +252,27 @@ static const struct prot_bits stage2_pte_bits[] = {
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
@@ -267,13 +324,19 @@ static struct pg_level pg_level[] = {
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
2.43.0.rc0.421.g78406f8d94-goog

