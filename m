Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F136802C13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjLDHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:32:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629FDD7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:32:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592E1C433C8;
        Mon,  4 Dec 2023 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701675158;
        bh=9hl2sop5ZT4amnXOtIjTHzdm3Zn4QZwIyXAyL/yWEsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=FFsiU+7oMtiyy5BCm6J9eBs/i2GCEb1D7k4bvpF/43a78mGeagTz8grpZVEQoZYz5
         TSj9Y1fNQmGIEtXtGpa4txjCgiSgmrewKFzpLD5QMJCra+uaHUsf0Fqu3BNNqPfAM9
         OoEust+e7v++8M2pn8lSpSCzDdnuJ4/dViJdhqhk4OI1OFdulyegEV/exAjlGkbb6v
         e1yJqX8994rgQQqtoGA3vXp0Iv1+XGXR9+hhVbBeBNNPxUDgL1D5enYWvQcy4BNuS8
         J4EbCxXngweR9Z+KjkksznfzjnpQ6UqfaIXwnqXF3h/u3VLPUXItqgSUxz2GXyHM3I
         ogZzxkUL1PXHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sarah Walker <sarah.walker@imgtec.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imagination: move update_logtype() into ifdef section
Date:   Mon,  4 Dec 2023 08:32:10 +0100
Message-Id: <20231204073231.1164163-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is only used when debugfs is enabled, and otherwise
causes a build warning:

drivers/gpu/drm/imagination/pvr_fw_trace.c:135:1: error: 'update_logtype' defined but not used [-Werror=unused-function]

Move the #ifdef check to include this function as well.

Fixes: cb56cd610866 ("drm/imagination: Add firmware trace to debugfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 87a42fb6ace6..8261fa4f7f83 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -121,6 +121,8 @@ void pvr_fw_trace_fini(struct pvr_device *pvr_dev)
 	pvr_fw_object_unmap_and_destroy(fw_trace->tracebuf_ctrl_obj);
 }
 
+#if defined(CONFIG_DEBUG_FS)
+
 /**
  * update_logtype() - Send KCCB command to trigger FW to update logtype
  * @pvr_dev: Target PowerVR device
@@ -165,8 +167,6 @@ update_logtype(struct pvr_device *pvr_dev, u32 group_mask)
 	return err;
 }
 
-#if defined(CONFIG_DEBUG_FS)
-
 static int fw_trace_group_mask_show(struct seq_file *m, void *data)
 {
 	struct pvr_device *pvr_dev = m->private;
-- 
2.39.2

