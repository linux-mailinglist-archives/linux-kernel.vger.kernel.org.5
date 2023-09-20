Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFEC7A8CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjITT2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjITT2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:28:07 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B5E94;
        Wed, 20 Sep 2023 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695238082; x=1726774082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EuVlNZSA5R6HEGbmtLno+CIP17KRWTgo1O4bolnZTY=;
  b=ip5VqVdLhZuYX53rRCE6DDQOpbdRgo1G+9hlihL/fjJ1FVYAIEIjL054
   NNEaXfVS301Ys+elL43Ral0JQqZCCYevZ4/0TbzFhmo5nI7g0xnzPxukA
   HUoY0reM9vbWeqxDt4O0aqsUbXewrVtOJvJAbqiaAbn9wIG4hHjhIfHGF
   k=;
X-IronPort-AV: E=Sophos;i="6.03,162,1694736000"; 
   d="scan'208";a="364769464"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 19:28:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-5eae960a.us-west-2.amazon.com (Postfix) with ESMTPS id A2EDA40E6A;
        Wed, 20 Sep 2023 19:28:00 +0000 (UTC)
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 20 Sep 2023 19:27:47 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.111.86.147) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 20 Sep 2023 19:27:47 +0000
From:   Suraj Jitindar Singh <surajjs@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <james.morse@arm.com>, <alexandru.elisei@arm.com>,
        <suzuki.poulose@arm.com>, <oliver.upton@linux.dev>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.linux.dev>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>, <sjitindarsingh@gmail.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH stable 6.1.y 2/2] KVM: arm64: Prevent unconditional donation of unmapped regions from the host
Date:   Wed, 20 Sep 2023 12:27:29 -0700
Message-ID: <20230920192729.694309-2-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920192729.694309-1-surajjs@amazon.com>
References: <20230920192729.694309-1-surajjs@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.111.86.147]
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 09cce60bddd6461a93a5bf434265a47827d1bc6f upstream.

Since host stage-2 mappings are created lazily, we cannot rely solely on
the pte in order to recover the target physical address when checking a
host-initiated memory transition as this permits donation of unmapped
regions corresponding to MMIO or "no-map" memory.

Instead of inspecting the pte, move the addr_is_allowed_memory() check
into the host callback function where it is passed the physical address
directly from the walker.

Cc: Quentin Perret <qperret@google.com>
Fixes: e82edcc75c4e ("KVM: arm64: Implement do_share() helper for sharing memory")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230518095844.1178-1-will@kernel.org
[ bp: s/ctx->addr/addr in __check_page_state_visitor due to missing commit
      "KVM: arm64: Combine visitor arguments into a context structure"
      in stable.
]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 0f6c053686c7..0faa330a41ed 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -424,7 +424,7 @@ struct pkvm_mem_share {
 
 struct check_walk_data {
 	enum pkvm_page_state	desired;
-	enum pkvm_page_state	(*get_page_state)(kvm_pte_t pte);
+	enum pkvm_page_state	(*get_page_state)(kvm_pte_t pte, u64 addr);
 };
 
 static int __check_page_state_visitor(u64 addr, u64 end, u32 level,
@@ -435,10 +435,7 @@ static int __check_page_state_visitor(u64 addr, u64 end, u32 level,
 	struct check_walk_data *d = arg;
 	kvm_pte_t pte = *ptep;
 
-	if (kvm_pte_valid(pte) && !addr_is_allowed_memory(kvm_pte_to_phys(pte)))
-		return -EINVAL;
-
-	return d->get_page_state(pte) == d->desired ? 0 : -EPERM;
+	return d->get_page_state(pte, addr) == d->desired ? 0 : -EPERM;
 }
 
 static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
@@ -453,8 +450,11 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	return kvm_pgtable_walk(pgt, addr, size, &walker);
 }
 
-static enum pkvm_page_state host_get_page_state(kvm_pte_t pte)
+static enum pkvm_page_state host_get_page_state(kvm_pte_t pte, u64 addr)
 {
+	if (!addr_is_allowed_memory(addr))
+		return PKVM_NOPAGE;
+
 	if (!kvm_pte_valid(pte) && pte)
 		return PKVM_NOPAGE;
 
@@ -521,7 +521,7 @@ static int host_initiate_unshare(u64 *completer_addr,
 	return __host_set_page_state_range(addr, size, PKVM_PAGE_OWNED);
 }
 
-static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
+static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte, u64 addr)
 {
 	if (!kvm_pte_valid(pte))
 		return PKVM_NOPAGE;
-- 
2.34.1

