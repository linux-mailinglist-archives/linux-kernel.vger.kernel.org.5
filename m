Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4F7A69BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjISRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjISRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B159197
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0770C15;
        Tue, 19 Sep 2023 10:42:12 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 551533F5A1;
        Tue, 19 Sep 2023 10:41:34 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:41:02 +0100
Subject: [PATCH RFT v2 14/18] firmware: arm_ffa: Simplify the computation
 of transmit and fragment length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-14-6f3a3ca3923c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3428; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=PHZUUrZvOCnNHDI+i/Plgq+A2R5oHmSmqrncoEkZxGs=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd0811YapzFopiMGNcOkCEDvNWtWDiwYdXrG3
 kWMD0B7SwaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndPAAKCRAAQbq8MX7i
 mHA2D/9/hF3VaKABoZURL5PKUaLFVp4zmlY7MYesN4/HMnZgVyMesjmml5nF7p+NmU4bnmnlpeZ
 UwWEcZDjOrOsjw3HdtcCnYGUM/KfbefJ2BY5ZGCH+GSFDpARZUQc8mduZRjMi0AUdJCIMCzyEQo
 U65ki8FOQ3rx3LQdy+Z5hGX8QCnYp8moaUXIDEzlcQ2QWa5wJt01zOyPzzHG6ukiYth6jVU1uMN
 +fir+ORoT4ubFBBbMp1i5ZiIB4hmBx4FgziIeqNycD7x0z4wwA0lScBKVeolSwSpb1eFNMRXelZ
 Wn2gIDcMRL+iA2PLa6SsRbR0/HLVXiVQbYHAhAVqVJhgWLIglZF8sNlVVGlvydUXoNxpcZphc3b
 scodmQN0np1fqydWw3CqQKw7p5vvx3YlcqPa1mcc5hv0MoH5z9wCX0iF+vyUlg84LKEKupp9lI8
 b9/nTJ+1VJvIfUDufNn1ZHBSKbv7t3kK0aFAVK8oQna3qtOB5XzPKIazmtxwmwGg33SeMFcSwcJ
 cA/uB6F9YxRy3h7bVeoglf9zZpncg2EJMh3dgBSzMG4NOQGbgLlw5PQspzg4Y2jA4Qpg4BPSFNP
 DrnnjTTKXSK9w5yq6tdmuJm434Fg43PhYgRbrXnYKwMRRuSktX/+PDLIVAhg4puIm5EAasb37OL
 nhMLLL13zDzsCbA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 6312a7807d37..dadd56d17c20 100644
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

