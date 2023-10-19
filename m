Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846567CFD12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbjJSOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346244AbjJSOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:02 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D767819F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:58 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-32da47641b5so3245237f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726456; x=1698331256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=irFQ7vIeF55X7D9u5W+RRcx8opaM8C3jS63aHLA7bAc=;
        b=dw6M0l9Vn5e5um04nwj+TMG74kz79Jt3XloJl1liicKmNTg4H9BmhepT/fTpiEY2m9
         bM2cWQ4utXql0EGd5P6FP76FKn/6HjU7mtlZMwNPbARqBsR3Q/1HhmnbcoUwT+Kx7TqG
         L4WCyJFOIp7hNZYSyv12uLjYBPo5chFO0eemstPBzD9EKuHa+kR5uqrCllQgFSTYAVco
         BG1rryErxuVQRJBg2nl/eHFZA0nmE2ptzOAM5l3QKVVREHkd/M4+tO3fKswV7yaaFaOO
         7Cnb1Ot4Vnjwst8T5kSZE/ZM9q9PawZqVK+1xHWiGYidTFF4nJq6+B5VqJqpu/52eIRa
         iPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726456; x=1698331256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irFQ7vIeF55X7D9u5W+RRcx8opaM8C3jS63aHLA7bAc=;
        b=LTdER/fz5BgM/iIsoU4u2kL3he2XxsS+BYEj7KCefVPfogP+jrF8GG0nrDJDXXOOXG
         brV1/ZjQ6SQDXHJEvpLAQ6CBiDrDOjEPOXbBBv8Ja6NqLEDpkm/XEQ7oNbMgFptMSdRd
         dUfg92opHa2lJCUkhNaZyY8M1Du4t43GmuKFVQmcXagYNB8Spb4OWOSZQnuiI4XkJz7d
         3ca88+VTRnyL93OWqyX0P6ZXQHChcwV82J+G8rFuVHPh6H2RZRsJW910c0V4bItVHGTF
         /I7BlOWMAHs3pnpVhQo0XsnT5ryp3dGiNxc5AmrzjyR70daAsjuz9D6QmGcLV0w3UQEQ
         jARw==
X-Gm-Message-State: AOJu0Yxwh8KBbSEvCrjUjEGmJkXfDipwfzdyZBzEKEaCQI26wxvQzZTS
        IRmLNr1/W6b5lZnmzTcb1N0flnbxwqKYccHSnFE=
X-Google-Smtp-Source: AGHT+IF3GoLo/wBW4dX66SazO0VPZ6uH7fDzq+LUToDEwWy58v8WzEAJKiwN+7yzyFy+eCcQyInhEjV76d/RlRrkn68=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:6000:1372:b0:32d:a860:3257 with
 SMTP id q18-20020a056000137200b0032da8603257mr19560wrz.13.1697726456175; Thu,
 19 Oct 2023 07:40:56 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:27 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-7-sebastianene@google.com>
Subject: [PATCH v2 05/11] arm64: ptdump: Introduce stage-2 pagetables format description
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

Add an array which holds human readable information about the format of
a stage-2 descriptor. The array is then used by the descriptor parser
to extract information about the memory attributes.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index d531e24ea0b2..58a4ea975497 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,7 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/kvm_pgtable.h>
 
 
 enum address_markers_idx {
@@ -171,6 +172,66 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
+static const struct prot_bits stage2_pte_bits[] = {
+	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.set	= "XN",
+		.clear	= "  ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
+		.set	= "R",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
+		.set	= "W",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_NG,
+		.val	= PTE_NG,
+		.set	= "FnXS",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_CONT,
+		.val	= PTE_CONT,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PTE_TABLE_BIT,
+		.val	= PTE_TABLE_BIT,
+		.set	= "   ",
+		.clear	= "BLK",
+	}, {
+		.mask	= KVM_PGTABLE_PROT_SW0,
+		.val	= KVM_PGTABLE_PROT_SW0,
+		.set	= "SW0", /* PKVM_PAGE_SHARED_OWNED */
+	}, {
+		.mask   = KVM_PGTABLE_PROT_SW1,
+		.val	= KVM_PGTABLE_PROT_SW1,
+		.set	= "SW1", /* PKVM_PAGE_SHARED_BORROWED */
+	}, {
+		.mask	= KVM_PGTABLE_PROT_SW2,
+		.val	= KVM_PGTABLE_PROT_SW2,
+		.set	= "SW2",
+	}, {
+		.mask   = KVM_PGTABLE_PROT_SW3,
+		.val	= KVM_PGTABLE_PROT_SW3,
+		.set	= "SW3",
+	},
+};
+
 struct pg_level {
 	const struct prot_bits *bits;
 	const char *name;
@@ -202,6 +263,26 @@ static struct pg_level pg_level[] = {
 	},
 };
 
+static struct pg_level stage2_pg_level[] = {
+	{ /* pgd */
+		.name	= "PGD",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	}, { /* pud */
+		.name	= (CONFIG_PGTABLE_LEVELS > 3) ? "PUD" : "PGD",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	}, { /* pmd */
+		.name	= (CONFIG_PGTABLE_LEVELS > 2) ? "PMD" : "PGD",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	}, { /* pte */
+		.name	= "PTE",
+		.bits	= stage2_pte_bits,
+		.num	= ARRAY_SIZE(stage2_pte_bits),
+	},
+};
+
 static void dump_prot(struct pg_state *st, const struct prot_bits *bits,
 			size_t num)
 {
@@ -340,6 +421,12 @@ static void __init ptdump_initialize(void)
 		if (pg_level[i].bits)
 			for (j = 0; j < pg_level[i].num; j++)
 				pg_level[i].mask |= pg_level[i].bits[j].mask;
+
+	for (i = 0; i < ARRAY_SIZE(stage2_pg_level); i++)
+		if (stage2_pg_level[i].bits)
+			for (j = 0; j < stage2_pg_level[i].num; j++)
+				stage2_pg_level[i].mask |=
+					stage2_pg_level[i].bits[j].mask;
 }
 
 static struct ptdump_info kernel_ptdump_info = {
-- 
2.42.0.655.g421f12c284-goog

