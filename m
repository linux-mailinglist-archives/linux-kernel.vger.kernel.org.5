Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0779A7D6EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbjJYNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjJYNKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:10:54 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAC3130
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:10:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBCA11C000D;
        Wed, 25 Oct 2023 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698239448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sq/7jbI//tPSUdJ8eoGURH5pS4j1r+AIB4XYpbcVvmU=;
        b=cZvK9ybagNGJ5x27CZPb5DKTSJsJ1Gfn/y1eO8ofA5QCvz7vY5PfiPr9dcxyvQuaBq3QZf
        BuGiailwe4f+lxc7K2yfuXEZlfLhLZyLLKR1yljcxxF7PFp3gfK4ixinp7xELv4luvrkpp
        hlijvM3HcgbzhprIoT+Jcpgx6MfnN5KBcdPqHfWxDBreDiAXFq0Oct8/oW2MYcDIGaK75x
        B77omtU7lf9bRzW8ortwSy+fH9mE64XREkFokLyY5zp3YuH43hGfX2Bk+rMilinSSMVIyP
        Jx1vpB/WzGQrf5EtE8TOjDG/4osdygMNIYGEsn/CfSt7THXeaB3kLmqRA4Jpog==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] drm/logicvc: Avoid possible overflow in layer buffer setup variables
Date:   Wed, 25 Oct 2023 15:09:45 +0200
Message-ID: <20231025130946.119957-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer_sel, voffset and hoffset values are calculated from u32
values and might overflow under certain conditions.

Move them to u32 definitions instead of u8/u16 to avoid the issue.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
---
 drivers/gpu/drm/logicvc/logicvc_layer.c | 6 +++---
 drivers/gpu/drm/logicvc/logicvc_layer.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index 464000aea765..eea22379d042 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -268,9 +268,9 @@ int logicvc_layer_buffer_find_setup(struct logicvc_drm *logicvc,
 	u32 layer_stride = layer_bytespp * logicvc->config.row_stride;
 	u32 base_offset = layer->config.base_offset * layer_stride;
 	u32 buffer_offset = layer->config.buffer_offset * layer_stride;
-	u8 buffer_sel = 0;
-	u16 voffset = 0;
-	u16 hoffset = 0;
+	u32 buffer_sel = 0;
+	u32 voffset = 0;
+	u32 hoffset = 0;
 	phys_addr_t fb_addr;
 	u32 fb_offset;
 	u32 gap;
diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.h b/drivers/gpu/drm/logicvc/logicvc_layer.h
index 4a4b02e9b819..a06feeda3abf 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.h
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.h
@@ -18,9 +18,9 @@
 #define LOGICVC_LAYER_ALPHA_PIXEL		1
 
 struct logicvc_layer_buffer_setup {
-	u8 buffer_sel;
-	u16 voffset;
-	u16 hoffset;
+	u32 buffer_sel;
+	u32 voffset;
+	u32 hoffset;
 };
 
 struct logicvc_layer_config {
-- 
2.42.0

