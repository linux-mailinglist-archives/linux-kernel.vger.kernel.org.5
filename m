Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF07B364A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjI2PEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjI2PDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56A1CCDF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 521B612FC;
        Fri, 29 Sep 2023 08:04:11 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF78B3F5A1;
        Fri, 29 Sep 2023 08:03:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:03:04 +0100
Subject: [PATCH v3 15/17] firmware: arm_ffa: Switch to using
 ffa_mem_desc_offset() accessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-15-c8e4f15190c8@arm.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
In-Reply-To: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=WKIYZxRqRXASwTfRhZK26/hbt/X8NbiSbXFTeLJ2R0A=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucwmwQnsz2nnr94GhK0TUe/Jk8JcvkQITM0z
 Ety5uzdjVuJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnMAAKCRAAQbq8MX7i
 mPPID/9yCTj2U/sG/SGPGXZX1PRqK0TYhMUirlq7o4A+AUsh/+lnTThpYGVyeFIPhEbfEuwJ3r4
 xJZKlx/dAhwN/F5D9Yx9D11CaqffpLne3jbRUm/swWw9ZiwTxZy4vYdp3gavKxqmWZchb/+IZY5
 GvLHTwwmZs3tTmS8AO4vs6s9wAsr53vz044AqXOxcGBArDFSRVoDMq8GevIwwosL+KwolPqBD34
 NQ6PzM0VNF3JEsLAIB6aP14BTMuyg0b3SLIZuFof8jNXGV8t7v9joYR2KU4bIVpI6ovEe+3ZY9b
 x2jbLM3K99PaCKNOTWc/LzSIs8tjrRpGAtes85HZpZ9iRJb5q+kBVI68xH1UuM7C3ULi9bYKPQU
 XFfp2FqKzMU9mKNI2JyYDE1rX6OVQKn7bnQ1+ha8ZL0eOQB+Bj/XJ8plh+DsfgownGTs7oNyjIF
 knjtTxRZq0msn/kVdG5ohwumM3OAMhRRJsi48kLZLHLMEyv/HGHY8v8MeGn337swMn2MRUv4Epk
 s+cmPCIEkscIGZdteeJoEns6miKAcJjytJRUMJoTb9h3d7664+OwYhG4WBw1EnnuTyK757xV3DY
 7BBZnkc+2xVdd0QNPQy3Wk5+1a4qeQPDwsd9G6zVKUb04gYVHGDWeBvd97wmvklKWSIdBD6Ud4/
 QSorGiA03tjiZWA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index d9ff3ec4f1eb..ef7011c86d60 100644
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

