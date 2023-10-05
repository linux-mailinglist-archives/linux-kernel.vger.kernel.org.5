Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637E27BA239
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjJEPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjJEPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:21:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 759FD21345
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB7015DB;
        Thu,  5 Oct 2023 07:46:03 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76BCC3F8A4;
        Thu,  5 Oct 2023 07:45:23 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:06 +0100
Subject: [PATCH v4 13/17] firmware: arm_ffa: Simplify the computation of
 transmit and fragment length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-13-cddd3237809c@arm.com>
References: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
In-Reply-To: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3428; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=Bk/KguDz+Pa9YD44dR4bVtd5OHjZzTqIACMhi/OAstc=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvy54FhXD9M3/xGz2SYo5UUiWjBKhS/CrOYm
 DIteIRcWumJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8gAKCRAAQbq8MX7i
 mJxdD/9iwVr+502At7oyF6Lgr+0lSTlhDAKQPpxK5BQ3baVM+bFBNobUFInNlj4NHXerZu82j3u
 ErROcKLWnk9PtI4ZeGC7Lr6vWIHhPPlsQjXVc2RoZhtJh5pVTyixbZwLDNeshdpAlgs3f0Fd9EK
 uK4oJAsfkM6R7uqO1BqUVv1B2xPk257JdObrqFBe1mY7lBmw+IqM+0CmFsCFia6P2jdK8NeDxxo
 ETqyQEn//VvVBATcDvvneF6jQfgaTiwU6U81lmkLOJpB0n1k6aYRqbAnhWNdwOByUWKIY9uNJKU
 GmSjN3IAPeGmqLaOTvZlXeLP6lgTIss3G6PNJ1lJChuyaHGhGWBE5BGT2mWtKzSPpXajXWrYKEP
 Um/zAnMG1FByBEGqopm0WfTI0XzJk3+w9KmnKPwsJxERVNcZwBZVifBHo4xuZpY79zHo2IZuIPS
 86omoq3ypaNfWSJepmqd5DDWM/jP6/eCRvwVkB2qx4iGjCYz6Do0+ERW/AtwYI3/Lj+nnc98wWy
 2incga0kZXWdQad2zcil4HEd5OrT7t2CNfLc6SG+pK4baDf7hwgca3ZMUpKCcRp3MZKaT3DJw7H
 S8g6D1fojvvMJSQBIuYqs57qtiOrt9P90hVO4p6ARwna608lqxgqOHpB8Ls2foVseWQLDkVaypN
 A7hJTpnH2aldgpw==
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
index 9dd5335001ee..45ad704734a2 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -442,23 +442,25 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
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
@@ -467,13 +469,13 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
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

