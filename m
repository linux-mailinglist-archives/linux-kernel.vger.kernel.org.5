Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0397B3648
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjI2PEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjI2PDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40FA1CC6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830451063;
        Fri, 29 Sep 2023 08:04:08 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C19E3F5A1;
        Fri, 29 Sep 2023 08:03:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:03:02 +0100
Subject: [PATCH v3 13/17] firmware: arm_ffa: Simplify the computation of
 transmit and fragment length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-13-c8e4f15190c8@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3428; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=Rg2XKzRPf8SFjG3ZX7rctW9KFXN9uruVnGqowukr10g=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucwynFFqxvHjHWr3fQpCjnPEZhI6MOOZvWa3
 Vu9DXT+PxuJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnMAAKCRAAQbq8MX7i
 mH0vD/9TOnvx/MRuf4JrzUDS0qYwarst+XtR3YA98cDVMU8SMMO++DDxeULkEmoW+QL2OvtpWCZ
 8d3lTmNKbLFKIYuhEzURoXfKBUF35MeyPXSz76xnHUEQeFVMkZIAESgR36OsOMQLTzrzc7nN9d7
 tcgtQD9modOPd0+6UzVfiVtrSykcD40pt5WHe2T6VHzFTK55owf95LIU7KvC/RC2X5cEW2rmzJn
 oY6Ja/kPJwEG95nzOKNGthIvx1TVkUeAE8Ddmvg8OQhCxVia1W155fGXV5awZjMQsI57RhafAWt
 9ddvScF4rANyVsDwrNNgs5riRWtRr0puMtoSie1jLyYKrFkCdGDnLgITtlqseAFogwpb0qgy1uD
 6CmbM8mZwNS9WRr++ufKCa6Ynmvott+IWrhJ3T9HCzV//d9dTlrngYy1lyM22EBDtc84xGEVtAi
 Cmao8jTeECdfRKgwaQjU2Bi7+iWI46p0qKrgfJahOtmn28QGaaFq2reFTUuHqpZL6e3hrZfzuSq
 mB+5RROSIdq8xfLzNtuBb2VuSIIseDUEPPgsI/Vba+/SaRcmjv0VNrnzwIcXQ60nRyMDTfHF9Mh
 g24xJTfJaxOVji9fNnczaH9U54X4vGsenurTg3yzOhRgawrk0kpbxeTbgUGv3uRwi3J+3YMU3Pu
 g0MMyU22hszKPMw==
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

The computation of endpoint memory access descriptor's composite memory
region descriptor offset is using COMPOSITE_CONSTITUENTS_OFFSET which is
unnecessary complicated. Composite memory region descriptor always follow
the endpoint memory access descriptor array and hence it is computed
accordingly. COMPOSITE_CONSTITUENTS_OFFSET is useless and wrong for any
input other than endpoint memory access descriptor count.

Let us drop the usage of COMPOSITE_CONSTITUENTS_OFFSET to simplify the
computation of total transmit and fragment length in the memory
transactions.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 14 ++++++++------
 include/linux/arm_ffa.h           |  2 --
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 28bf345862d9..d9ff3ec4f1eb 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -443,23 +443,25 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 {
 	int rc = 0;
 	bool first = true;
+	u32 composite_offset;
 	phys_addr_t addr = 0;
+	struct ffa_mem_region *mem_region = buffer;
 	struct ffa_composite_mem_region *composite;
 	struct ffa_mem_region_addr_range *constituents;
 	struct ffa_mem_region_attributes *ep_mem_access;
-	struct ffa_mem_region *mem_region = buffer;
 	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg);
 
 	mem_region->tag = args->tag;
 	mem_region->flags = args->flags;
 	mem_region->sender_id = drv_info->vm_id;
 	mem_region->attributes = ffa_memory_attributes_get(func_id);
-	ep_mem_access = &mem_region->ep_mem_access[0];
+	ep_mem_access = buffer + COMPOSITE_OFFSET(0);
+	composite_offset = COMPOSITE_OFFSET(args->nattrs);
 
 	for (idx = 0; idx < args->nattrs; idx++, ep_mem_access++) {
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
-		ep_mem_access->composite_off = COMPOSITE_OFFSET(args->nattrs);
+		ep_mem_access->composite_off = composite_offset;
 		ep_mem_access->flag = 0;
 		ep_mem_access->reserved = 0;
 	}
@@ -468,13 +470,13 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
 
-	composite = buffer + COMPOSITE_OFFSET(args->nattrs);
+	composite = buffer + composite_offset;
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
 	composite->addr_range_cnt = num_entries;
 	composite->reserved = 0;
 
-	length = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, num_entries);
-	frag_len = COMPOSITE_CONSTITUENTS_OFFSET(args->nattrs, 0);
+	length = composite_offset + CONSTITUENTS_OFFSET(num_entries);
+	frag_len = composite_offset + CONSTITUENTS_OFFSET(0);
 	if (frag_len > max_fragsize)
 		return -ENXIO;
 
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index f6df81f14b6d..748d0a83a4bc 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -356,8 +356,6 @@ struct ffa_mem_region {
 	(offsetof(struct ffa_mem_region, ep_mem_access[x]))
 #define CONSTITUENTS_OFFSET(x)	\
 	(offsetof(struct ffa_composite_mem_region, constituents[x]))
-#define COMPOSITE_CONSTITUENTS_OFFSET(x, y)	\
-	(COMPOSITE_OFFSET(x) + CONSTITUENTS_OFFSET(y))
 
 struct ffa_mem_ops_args {
 	bool use_txbuf;

-- 
2.42.0

