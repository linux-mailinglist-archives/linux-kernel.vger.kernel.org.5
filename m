Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D67B64DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjJCI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJCI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:59:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 352AFAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:59:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2061CC15;
        Tue,  3 Oct 2023 02:00:18 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A99E3F5A1;
        Tue,  3 Oct 2023 01:59:38 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA device
Date:   Tue,  3 Oct 2023 09:59:32 +0100
Message-ID: <20231003085932.3553985-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 19b8766459c4 ("firmware: arm_ffa: Fix FFA device names for logical
partitions") added an ID to the FFA device using ida_alloc() and append
the same to "arm-ffa" to make up a unique device name. However it missed
to stash the id value in ffa_dev to help freeing the ID later when the
device is destroyed.

Due to the missing/unassigned ID in FFA device, we get the following
warning when the FF-A device is unregistered. Fix the same by actually
assigning the ID in the FFA device this time for real.

Fixes: 19b8766459c4 ("firmware: arm_ffa: Fix FFA device names for logical partitions")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 2b8bfcd010f5..7865438b3696 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -193,6 +193,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
 	dev->release = ffa_release_device;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
+	ffa_dev->id = id;
 	ffa_dev->vm_id = vm_id;
 	ffa_dev->ops = ops;
 	uuid_copy(&ffa_dev->uuid, uuid);
-- 
2.42.0

