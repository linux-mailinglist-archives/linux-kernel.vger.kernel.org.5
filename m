Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD97BA47F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbjJEQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbjJEQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2265BD4B6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C691655;
        Thu,  5 Oct 2023 07:46:06 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A843F641;
        Thu,  5 Oct 2023 07:45:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:45:08 +0100
Subject: [PATCH v4 15/17] firmware: arm_ffa: Switch to using
 ffa_mem_desc_offset() accessor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-ffa_v1-1_notif-v4-15-cddd3237809c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1380; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=dftsGeY1DJoCwWfBKEb8lal/PjiIATpRlO3OUrofRCc=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvyU+xRMy3zAAPz5EmrKB/zbOi8MBAJRtWAu
 gSJrAtP0TqJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8gAKCRAAQbq8MX7i
 mMzlEADC7lH5pUpEzXnZb9aFQtnhTnJ0WRHy3P6aG27izufZJSrmsAlykpGuUcdyhfN6mWSDcTK
 I/CeMK17mZBbJw2pnGfJp2WHYOfcbY3nPP5xcoi1Arem8t8y7YfgceVxaATJpaiBF7mOfZHuOPL
 bvonNJg5hali/lX5uyKbGTqmO12QjHHCtmCFtS/+79nTqpILkF9QcnLbEU7tUukbplE7YH4o4KS
 UxllLl9c3KNRsENtPP3cNt1swBdF2CLRwNmgHVW+fBEJ6mvmoIYJhSJEWx0zQHKULWYIavUqaNT
 Inh4L3sY/6YmhRaIrY7goieuI1zdz4ZYsDxTI0r076/fWqb6Lj+sB/SVr1ia/+wsYpg/PtHTzXh
 tOaBu0oyRh6BqHXFM49GlQKozWKV/advFhy25KTuryCQcbSR2skEJe/b/EhuxHx8/LJGCtLOeFX
 PQ05NvrMMXQLkApitInDB1kKifye9pwk2XkfsyLkZMsKIY45qD8Lkmy/17JWvgx2+VeAwD+eR2V
 WL6+M8fUOUJe0mXNmR2KibP46sIizy/1a9luMSMC1s1IdPZpWjSTk2e0WBthrco8Uw5JIqZRroC
 7fTMxSBJ4YwKDAB5wTK2dv1jJ1MN5Z7hdpHVranN7qMUpaAWVBDUaok7CFxyEfqKv87OsKNttSt
 l2IZL/v5JzMvXpg==
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
 drivers/firmware/arm_ffa/driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 45ad704734a2..4de08ffce599 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -454,8 +454,10 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	mem_region->flags = args->flags;
 	mem_region->sender_id = drv_info->vm_id;
 	mem_region->attributes = ffa_memory_attributes_get(func_id);
-	ep_mem_access = buffer + COMPOSITE_OFFSET(0);
-	composite_offset = COMPOSITE_OFFSET(args->nattrs);
+	ep_mem_access = buffer +
+			ffa_mem_desc_offset(buffer, 0, drv_info->version);
+	composite_offset = ffa_mem_desc_offset(buffer, args->nattrs,
+					       drv_info->version);
 
 	for (idx = 0; idx < args->nattrs; idx++, ep_mem_access++) {
 		ep_mem_access->receiver = args->attrs[idx].receiver;

-- 
2.42.0

