Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31DF7A69C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjISRmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjISRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CCA61B4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C695FEC;
        Tue, 19 Sep 2023 10:42:15 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211EE3F5A1;
        Tue, 19 Sep 2023 10:41:37 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:41:04 +0100
Subject: [PATCH RFT v2 16/18] firmware: arm_ffa: Switch to using
 ffa_mem_desc_offset() accessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-16-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=/nzYxWrUxzHK+XjBQnZCak5Tu7ZPAtOKWE4ng7bZFvM=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd08+RU27qx9u4qlmHu5SskWVsSlzbICaDn0o
 3rd3FniYD2JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndPAAKCRAAQbq8MX7i
 mA4yD/9hjEpdMqMosmD8LUJdH4SJxBtddl7+/7uL6RU2cGhDKblyXWch/1gW2B0EKSDdU7FjHTb
 PmKWu8dIhpdbB4nToZJCsHkiaqblO8MmKaP4ICLvRqPSbii3UVjZf+780Zb6/UAmEtYk3PqFzcF
 XTL4wKwnqtCfuixxzssUi2SujyWB2Nril8gwOp4HRaI6n/nPpBgbb5Ve5JTmyA2otiFLMyOM3E7
 nBnfiuGQ92dAhfbpR/B77g2K8s9A/gNm9xaLKday0PFR1bJagGj3k3Apn8TkQ8Q41ei+eHs9QpZ
 MsvHi2mCLdI+LVxrHF6zj/2pwoc6aaxiKYLizCT+rP3CevVB2k9Einpw+g1tEdUxRchHnAunYeI
 rk1H9h+TsYWphTZdOy11JIn3HEwq/qDrUgaoBtwr+G5KoBWMxeVjmRyFQ3a0kIfUfUMoSqLfM8H
 bxAAK2yRt15MNn9fTRdtjcqPysD/c5Umyt2x6SP3zSg1Y+wHdwWWAi6yXzfan7t/+quoOQ4+UpL
 zFhOwZ5TyzEOSwrymIt6bkIKuIwtxQNJpkez/Yo0OIJ42v9m5KhlJ1dLnC6nxc0L8E9XD9XYgnU
 QMpmPqZeJ5KMcWJMMTmcO/L1k6cdVwOZtnv8rlHRyaI/Q++AGFnlLga9Te4/IzBfIBV5uywmXpf
 tTJNV2Ndw0vnNKg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add support to the new memory transaction descriptor,
the ep_mem_access member needs to be removed and hence even the macro
COMPOSITE_OFFSET(). Let us switch to using the new ffa_mem_desc_offset()
accessor in ffa_setup_and_transmit().

This will enable adding the support for new format transparently without
any changes here again.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index dadd56d17c20..e0a0c7cedd90 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -449,14 +449,15 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	struct ffa_composite_mem_region *composite;
 	struct ffa_mem_region_addr_range *constituents;
 	struct ffa_mem_region_attributes *ep_mem_access;
+	bool mdesc_v1 = drv_info->version <= FFA_VERSION_1_0;
 	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg);
 
 	mem_region->tag = args->tag;
 	mem_region->flags = args->flags;
 	mem_region->sender_id = drv_info->vm_id;
 	mem_region->attributes = ffa_memory_attributes_get(func_id);
-	ep_mem_access = buffer + COMPOSITE_OFFSET(0);
-	composite_offset = COMPOSITE_OFFSET(args->nattrs);
+	ep_mem_access = buffer + ffa_mem_desc_offset(buffer, 0, mdesc_v1);
+	composite_offset = ffa_mem_desc_offset(buffer, args->nattrs, mdesc_v1);
 
 	for (idx = 0; idx < args->nattrs; idx++, ep_mem_access++) {
 		ep_mem_access->receiver = args->attrs[idx].receiver;

-- 
2.42.0

