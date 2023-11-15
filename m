Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF717ECAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjKOSyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKOSyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:54:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E2CC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:54:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso881606b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700074489; x=1700679289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iiqeEd+SqdqCRIn1p4O2vFaLNnvzT4PHHcDNR7I1Uik=;
        b=TGzGmEvOg+fgFhQpFOPuDcaky5D4KXiWqT2Dpx/OXnDjwnt26bzKyE2p8fiaAp5ViD
         fybG0Sm3gKAvKoutcVTxr+YqIqvW2XkkKUt9GNlnEGPXyM1U2yOuH0CovgEO84CusHXJ
         XCupppJ3s2xeBpqzERiXYdFkb/u1nslEExagQTH2KA9KcTbhoCyrYa0xx9iY2O9gOwJm
         dJE7V7pgB2zd8jIsOdnrV8WMBJ2ajvztuZmnd+popyGp26GHQ4pZcziESNeNxpB69gsb
         q+HQLUsB/5t065pH/gAvXY+kMKlLk5eTMYfPARYr3jdxupbMcSSfH9mmgZiuCJh2a9hR
         3qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700074489; x=1700679289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiqeEd+SqdqCRIn1p4O2vFaLNnvzT4PHHcDNR7I1Uik=;
        b=ayZnPM00Nsv1//qvIPBqpF0pT7UHg57JQzuQqmbSv68bXETUJ1Y94z6ZigyLgtdnOi
         B+Pm8VnN1438ZfrX/1bCTRgLLRP1yOd1LmEL6V8EEldSAwN0PPl8hrZv+kTDuQbqD+fX
         3g5VkNw9qRnxkMJLvuZ8EY9TJcB4vhzMrAwCLZwBTxCgiqKzb52lU8WLuRAvaqU0atWA
         FnSIT9CTN2XuHzMKH/rfmM1o7zwM7ivuTXsk+SGupIonOYVp6NjXjesrLLVoqwdwPL+/
         u/DdgCZlHiH9gac0c3NIvSr6e9JumUxy28YVwYLot8ck3BuFRRHP082x1MOd91YYVWvw
         enug==
X-Gm-Message-State: AOJu0YxcdSanD+JTSruQtDIHqxdUFVLCZmuRuCSpCDZY39i/tKyeTvSI
        ocJ5fHZw3k8Gy4BxpXqhOB8NXQ==
X-Google-Smtp-Source: AGHT+IFrsJNWu2MFPbDjYv0LhdHK4l5b2SYr5UhYuqVcCzDEwqaElgEDRvuUN1Pjw2T0f7b/VS3Hrw==
X-Received: by 2002:a05:6a00:1f1a:b0:68c:44ed:fb6 with SMTP id be26-20020a056a001f1a00b0068c44ed0fb6mr9560276pfb.16.1700074488956;
        Wed, 15 Nov 2023 10:54:48 -0800 (PST)
Received: from dev-yzhong.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id e17-20020a056a001a9100b006c39efc97b3sm3099012pfv.113.2023.11.15.10.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 10:54:48 -0800 (PST)
From:   Yuanyuan Zhong <yzhong@purestorage.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com,
        Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH] nvme-core: remove head->effects to fix use-after-free
Date:   Wed, 15 Nov 2023 11:54:39 -0700
Message-Id: <20231115185439.2616073-1-yzhong@purestorage.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The head->effects stores a pointer to the controller's Command Sets
Supported and Effects log. When the namespace head is shared by multiple
controllers, if the particular controller is removed, dereferencing
head->effects causes use-after-free:

[  227.820066] ==================================================================
[  227.820069] BUG: KFENCE: use-after-free read in nvme_command_effects+0x1f/0x90 [nvme_core]

[  227.820091] Use-after-free read at 0x00000000c02dadcf (in kfence-#0):
[  227.820094]  nvme_command_effects+0x1f/0x90 [nvme_core]
[  227.820107]  nvme_passthru_start+0x19/0x80 [nvme_core]
[  227.820121]  nvme_submit_user_cmd+0xc7/0x170 [nvme_core]
[  227.820136]  nvme_user_cmd.constprop.16+0x152/0x1d0 [nvme_core]
[  227.820149]  nvme_ns_head_ioctl+0x92/0x140 [nvme_core]
[  227.820162]  blkdev_ioctl+0x1c5/0x280
[  227.820169]  __x64_sys_ioctl+0x93/0xd0
[  227.820174]  do_syscall_64+0x45/0xf0
[  227.820177]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  227.820182] kfence-#0: 0x000000000fac1d5d-0x00000000a28a73c3, size=4096, cache=kmalloc-4k

[  227.820185] allocated by task 2559 on cpu 3 at 188.703118s:
[  227.820233]  __kmem_cache_alloc_node+0x3c9/0x410
[  227.820236]  kmalloc_trace+0x2a/0xa0
[  227.820238]  nvme_get_effects_log+0x68/0xd0 [nvme_core]
[  227.820251]  nvme_init_identify+0x5ef/0x640 [nvme_core]
[  227.820263]  nvme_init_ctrl_finish+0x8d/0x250 [nvme_core]
[  227.820275]  nvme_tcp_setup_ctrl+0x1ce/0x710 [nvme_tcp]
[  227.820281]  nvme_tcp_create_ctrl+0x359/0x450 [nvme_tcp]
[  227.820286]  nvmf_dev_write+0x203/0x3b0 [nvme_fabrics]
[  227.820292]  vfs_write+0xd2/0x3d0
[  227.820294]  ksys_write+0x5d/0xd0
[  227.820297]  do_syscall_64+0x45/0xf0
[  227.820298]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  227.820302] freed by task 2521 on cpu 28 at 220.115945s:
[  227.820329]  nvme_free_ctrl+0xa6/0x260 [nvme_core]
[  227.820342]  device_release+0x37/0x90
[  227.820345]  kobject_release+0x57/0x120
[  227.820347]  nvme_sysfs_delete+0x39/0x50 [nvme_core]
[  227.820360]  kernfs_fop_write_iter+0x144/0x1e0
[  227.820362]  vfs_write+0x25f/0x3d0
[  227.820364]  ksys_write+0x5d/0xd0
[  227.820366]  do_syscall_64+0x45/0xf0
[  227.820368]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

Fix this by removing head->effects. Use the Commands Supported and Effects log
in ctrl->cels directly.

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Signed-off-by: Yuanyuan Zhong <yzhong@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Reviewed-by: Hamilton Coutinho <hcoutinho@purestorage.com>
---
 drivers/nvme/host/core.c | 17 ++++++++---------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88b54cdcbd68..14fdc2de3a75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1085,7 +1085,9 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 	u32 effects = 0;
 
 	if (ns) {
-		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		struct nvme_effects_log	*cel = xa_load(&ctrl->cels, ns->head->ids.csi);
+
+		effects = le32_to_cpu(cel->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -2872,7 +2874,8 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 
 	xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
 out:
-	*log = cel;
+	if (log)
+		*log = cel;
 	return 0;
 }
 
@@ -3388,13 +3391,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->shared = info->is_shared;
 	kref_init(&head->ref);
 
-	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
-		if (ret)
-			goto out_cleanup_srcu;
-	} else
-		head->effects = ctrl->effects;
-
 	ret = nvme_mpath_alloc_disk(ctrl, head);
 	if (ret)
 		goto out_cleanup_srcu;
@@ -3779,6 +3775,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ret || !info.is_ready)
 		return;
 
+	if (info.ids.csi && nvme_get_effects_log(ctrl, info.ids.csi, NULL))
+		return;
+
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
 		nvme_validate_ns(ns, &info);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb125..38298c072ec3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,7 +445,6 @@ struct nvme_ns_head {
 	struct kref		ref;
 	bool			shared;
 	int			instance;
-	struct nvme_effects_log *effects;
 
 	struct cdev		cdev;
 	struct device		cdev_device;
-- 
2.34.1

