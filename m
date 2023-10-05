Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42C7BA238
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjJEPVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJEPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:21:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52F8C21342
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C90EC1650;
        Thu,  5 Oct 2023 07:46:04 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A87D53F641;
        Thu,  5 Oct 2023 07:45:24 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:07 +0100
Subject: [PATCH v4 14/17] KVM: arm64: FFA: Remove access of endpoint memory
 access descriptor array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-14-cddd3237809c@arm.com>
References: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
In-Reply-To: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=SS6JRBjjCJQqFwvnNz13s81gsvYnAl3iEKszag6Pbtw=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvydd/+94+47JnCF7cTSk3FzmX9PSPrdF9Ly
 GN4PBA5oLqJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8gAKCRAAQbq8MX7i
 mLjxEADBX6incMiMnSXjh5fzCkWAWrvI9bfk0iqevZkcvD1/rbY6wqo3eJMbTL8rhsCA9DphjKX
 wscGHUig6QHtuR6KFqbQVId6lgMAPFL8yCfALoAp1RbZtNe0FKoFN6YoPtGM42ckpNthk+9XA7j
 ohxfcrgBkmGYRAChnxFguIvAk8FXHWS81BY6XGhacN1OnSfUNhmhZvs/MAqdeDh5TO3mEQ2ckA/
 nYWRc1JBvLGg6tpYzyZiAh5tV3gDSqUehDjjTqZMn9bMQrsFaxYg+psry4m3jdNoDf+Wkg+D4Pm
 qA11X7O6BdsBI8mD+Hg7l3u/vkzJ3026jUUPUVtTaMWxxMX3VlrWtqcWSENBoPIPwopVECspfQ0
 yBGGZhhA3fOL5gZQ23newDuhWt+cuJlXtwGzFdRGtC2idSBQd0Cnm2BPbBX9uc7u2kkyOIAkkdt
 NQuIpW5Ib8xcMhJcStZ8lj73YiQsWf1BoXROHcljTWTFyEJrV5AJBC9e1gPPMReQMLlRPMyQ/gD
 eJlreACercAiLNVQk8uCf3RfGBNoB6bIBmbh/C5T6iDWi7EU8mpzPJkpHOZildEw450NjWCqzpS
 I9o4IfUm5LWPwOfuh4H+Na+Xiz2z4v2Jbw8o4K+3carzaVhIRM91dw/oAjgK2o4TScC8WIfi7ot
 x1XvkKUx7I2W/kw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FF-A v1.1 removes the fixed location of endpoint memory access descriptor
array within the memory transaction descriptor structure. In preparation
to remove the ep_mem_access member from the ffa_mem_region structure,
provide the accessor to fetch the offset and use the same in FF-A proxy
implementation.

The accessor take the FF-A version as the argument from which the memory
access descriptor format can be determined. v1.0 uses the old format while
v1.1 onwards use the new format specified in the v1.1 specification.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 10 ++++++++--
 include/linux/arm_ffa.h       |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 6e4dba9eadef..320f2eaa14a9 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -423,6 +423,7 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	DECLARE_REG(u32, fraglen, ctxt, 2);
 	DECLARE_REG(u64, addr_mbz, ctxt, 3);
 	DECLARE_REG(u32, npages_mbz, ctxt, 4);
+	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
 	u32 offset, nr_ranges;
@@ -452,7 +453,9 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
-	offset = buf->ep_mem_access[0].composite_off;
+	ep_mem_access = (void *)buf +
+			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+	offset = ep_mem_access->composite_off;
 	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out_unlock;
@@ -504,6 +507,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	DECLARE_REG(u32, handle_lo, ctxt, 1);
 	DECLARE_REG(u32, handle_hi, ctxt, 2);
 	DECLARE_REG(u32, flags, ctxt, 3);
+	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	u32 offset, len, fraglen, fragoff;
 	struct ffa_mem_region *buf;
@@ -528,7 +532,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	len = res->a1;
 	fraglen = res->a2;
 
-	offset = buf->ep_mem_access[0].composite_off;
+	ep_mem_access = (void *)buf +
+			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+	offset = ep_mem_access->composite_off;
 	/*
 	 * We can trust the SPMD to get this right, but let's at least
 	 * check that we end up with something that doesn't look _completely_
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 748d0a83a4bc..2444d596b703 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -357,6 +357,12 @@ struct ffa_mem_region {
 #define CONSTITUENTS_OFFSET(x)	\
 	(offsetof(struct ffa_composite_mem_region, constituents[x]))
 
+static inline u32
+ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, u32 ffa_version)
+{
+	return COMPOSITE_OFFSET(0);
+}
+
 struct ffa_mem_ops_args {
 	bool use_txbuf;
 	u32 nattrs;

-- 
2.42.0

