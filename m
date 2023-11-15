Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22857EBF22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjKOJHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjKOJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:07:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC0114
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:07:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CFEC433C8;
        Wed, 15 Nov 2023 09:07:43 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>
Cc:     kvm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: KVM: Fix build due to API changes
Date:   Wed, 15 Nov 2023 17:07:35 +0800
Message-Id: <20231115090735.2404866-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8569992d64b8f750e34b7858eac ("KVM: Use gfn instead of hva for
mmu_notifier_retry") replaces mmu_invalidate_retry_hva() usage with
mmu_invalidate_retry_gfn() for X86, LoongArch also need similar changes
to fix build.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kvm/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 80480df5f550..9463ebecd39b 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -627,7 +627,7 @@ static bool fault_supports_huge_mapping(struct kvm_memory_slot *memslot,
  *
  * There are several ways to safely use this helper:
  *
- * - Check mmu_invalidate_retry_hva() after grabbing the mapping level, before
+ * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
  *   consuming it.  In this case, mmu_lock doesn't need to be held during the
  *   lookup, but it does need to be held while checking the MMU notifier.
  *
@@ -807,7 +807,7 @@ static int kvm_map_page(struct kvm_vcpu *vcpu, unsigned long gpa, bool write)
 
 	/* Check if an invalidation has taken place since we got pfn */
 	spin_lock(&kvm->mmu_lock);
-	if (mmu_invalidate_retry_hva(kvm, mmu_seq, hva)) {
+	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
 		/*
 		 * This can happen when mappings are changed asynchronously, but
 		 * also synchronously if a COW is triggered by
-- 
2.39.3

