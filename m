Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E948B7936EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjIFILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIFILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:11:45 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4CBF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:11:41 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 7CACD5875CAE9; Wed,  6 Sep 2023 10:11:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 41DD358730358;
        Wed,  6 Sep 2023 10:11:40 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     kbusch@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: allow deactivating the NVME menuconfig section at once
Date:   Wed,  6 Sep 2023 10:11:40 +0200
Message-ID: <20230906081140.22716-1-jengelh@inai.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, one needs to enter "NVME subsystem --->", then deselect all options
individually. Speed up that process by making the "--->" line be togglable in
its own right.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 drivers/nvme/Kconfig | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/Kconfig b/drivers/nvme/Kconfig
index 656e46d938da..58452973ac7a 100644
--- a/drivers/nvme/Kconfig
+++ b/drivers/nvme/Kconfig
@@ -1,8 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menu "NVME Support"
+menuconfig NVME_SUPPORT
+	bool "NVME Support"
+	default y
+	help
+	  Support for Non-Volatile Memory Express.
+
+	  The answer to this question will not directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about NVME.
+
+if NVME_SUPPORT
 
 source "drivers/nvme/common/Kconfig"
 source "drivers/nvme/host/Kconfig"
 source "drivers/nvme/target/Kconfig"
 
-endmenu
+endif
-- 
2.42.0

