Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AFD7CFD17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbjJSOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346287AbjJSOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:16 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664A189
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:04 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4084001846eso10849185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726463; x=1698331263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElJlMelae52OVNRK43EtmIQAIoa6GhddKrR2iq/azSI=;
        b=asgdwzoj6F8aCVnehYiJONbUZcey9CWQSdwYN22UB3GvoKR7giqGJuq2b/fLZyKLfU
         TcL+yUN3hrSq2ZrR0VzDwaZLlHaXJ+XGuXQ4fKQHehQoXTtU/ci6CXmBrBY/78JNOhvJ
         QB5Dtpu46gXJRLi2Sbt5lsUUs3zDTyZGtn000xirVylu5hxrIfQeQdX+rqcNkZ7NkAmo
         AztzYPfHADfNu1lpJpKksaBj7lkP/cc39WX9Qeqt9uA1gp4wz+zpGN+TBFvn61YO2hNu
         f+VwrvttLpq8DYgp7XNNbZlfNVDnb7eezeOtJqhhziF8TlfDALi9E84nfKNsnappMyPD
         7ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726463; x=1698331263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElJlMelae52OVNRK43EtmIQAIoa6GhddKrR2iq/azSI=;
        b=SdbPv04nbMaoLE/Irzi+IbICwp1U5RoU5xB/AyCK20jOqYREbi4E7HzewdyyelP+Li
         cBHJH4JUL9eW5Txw8p+TsSMl2s4WtjdjP8yQdzdrTAZYYaTSYqlhEOksvVVOoxxMMwrC
         Mx2i3iq4oc91/cbtqskL/bVqVymeLSovsbKe5SRo+NfszwZxvxmS0ZaGzIq14V4JfNsn
         oOsZBYzQdlySXLkiHf6spafTgOu3cpoWFtGspeIcKi1c+l/WoMpqFKZE6lTejPlC3sLt
         Db+hPq0lgZ82IsGPFRESSvu053xZGzlt+tSK2O124PxESK95MbQbZYWDU2oyXo/Hd6DI
         Cozw==
X-Gm-Message-State: AOJu0YxrHEbUztRTgVVfuHfGjG3bsJzIHPiNYw04BDZM1/leJsa4DP73
        El5VUXFcvSOOGio+CxfTe3j8cPVudsfrRbCSN5o=
X-Google-Smtp-Source: AGHT+IFElnKsIi5dp2Ye8EDvnioIdKetK6LFJeeZwO4G65IWaMiQONCNVsOjqqbZrwPzyvGEqMqVtHvUbDt0zDruZF8=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a5d:444f:0:b0:32d:83b1:338e with SMTP
 id x15-20020a5d444f000000b0032d83b1338emr19447wrr.4.1697726463195; Thu, 19
 Oct 2023 07:41:03 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:30 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-10-sebastianene@google.com>
Subject: [PATCH v2 08/11] arm64: ptdump: Parse the host stage-2 page-tables
 from the snapshot
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

Add a walker function which configures ptdump to parse the page-tables
from the snapshot. Convert the physical address of the pagetable's start
address to a host virtual address and use the ptdump walker to parse the
page-table descriptors.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 7c78b8994ca1..3ba4848272df 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -479,6 +479,11 @@ static void *ptdump_host_va(phys_addr_t phys)
 	return __va(phys);
 }
 
+static struct kvm_pgtable_mm_ops host_mmops = {
+	.phys_to_virt	=	ptdump_host_va,
+	.virt_to_phys	=	ptdump_host_pa,
+};
+
 static size_t stage2_get_pgd_len(void)
 {
 	u64 mmfr0, mmfr1, vtcr;
@@ -604,6 +609,63 @@ static void stage2_ptdump_end_walk(struct ptdump_info *info)
 	free_pages_exact(snapshot, PAGE_SIZE);
 	info->priv = NULL;
 }
+
+static int stage2_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
+				 enum kvm_pgtable_walk_flags visit)
+{
+	struct pg_state *st = ctx->arg;
+	struct ptdump_state *pt_st = &st->ptdump;
+
+	if (st->pg_level[ctx->level].mask & ctx->old)
+		pt_st->note_page(pt_st, ctx->addr, ctx->level, ctx->old);
+
+	return 0;
+}
+
+static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
+{
+	struct kvm_pgtable_snapshot *snapshot = info->priv;
+	struct pg_state st;
+	struct kvm_pgtable *pgtable;
+	u64 start_ipa = 0, end_ipa;
+	struct addr_marker ipa_address_markers[3];
+	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
+		.cb	= stage2_ptdump_visitor,
+		.arg	= &st,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	if (snapshot == NULL || !snapshot->pgtable.pgd)
+		return;
+
+	pgtable = &snapshot->pgtable;
+	pgtable->mm_ops = &host_mmops;
+	end_ipa = BIT(pgtable->ia_bits) - 1;
+
+	memset(&ipa_address_markers[0], 0, sizeof(ipa_address_markers));
+
+	ipa_address_markers[0].start_address = start_ipa;
+	ipa_address_markers[0].name = "IPA start";
+
+	ipa_address_markers[1].start_address = end_ipa;
+	ipa_address_markers[1].name = "IPA end";
+
+	st = (struct pg_state) {
+		.seq		= s,
+		.marker		= &ipa_address_markers[0],
+		.level		= pgtable->start_level - 1,
+		.pg_level	= &stage2_pg_level[0],
+		.ptdump		= {
+			.note_page	= note_page,
+			.range		= (struct ptdump_range[]) {
+				{start_ipa,	end_ipa},
+				{0,		0},
+			},
+		},
+	};
+
+	kvm_pgtable_walk(pgtable, start_ipa, end_ipa, &walker);
+}
 #endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
 
 static void __init ptdump_register_host_stage2(void)
@@ -616,6 +678,7 @@ static void __init ptdump_register_host_stage2(void)
 		.mc_len			= host_s2_pgtable_pages(),
 		.ptdump_prepare_walk	= stage2_ptdump_prepare_walk,
 		.ptdump_end_walk	= stage2_ptdump_end_walk,
+		.ptdump_walk		= stage2_ptdump_walk,
 	};
 
 	mutex_init(&stage2_kernel_ptdump_info.file_lock);
-- 
2.42.0.655.g421f12c284-goog

