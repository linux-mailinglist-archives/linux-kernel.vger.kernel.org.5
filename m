Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC227E498B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjKGUFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjKGUFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:05:37 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD2D79;
        Tue,  7 Nov 2023 12:05:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C67FB1BF203;
        Tue,  7 Nov 2023 20:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699387531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=up5G4JkOGGZoc69qm3iAEp8guw6jmtg55oaRWOq/JG0=;
        b=o55PrWbSYwa7R6zU1dDymzJkIH34CmW4j8vKvin99gE+ZoOWlRe1W51/GziAxiD7MHLhGM
        hdctrdjoQP6lX81RIjRgUC2M+rV9rGFSczQlg6GvYEz0gRjge9SH9TP0kUr2b1nfenLb1Z
        onhZE5MVfVjLuGfCQf+eOFxEh6Lf6w7EwpQTJ0dbn8ymvfLPBKP/3LLdqMl4XWtIfWDfFf
        lE/TmUgIIpYEy34iwiDjvFYyq8ndsaMADqoT0T4Z27XB29oRze/pzdZjoV54fBeyJg7yUe
        JvA1z6ivvE8mvO9Ew7zjjmGioCcQiOHJ8mAYLCJKciVt1kKO+DCoQs77pVLgLg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] media: v4l2-dev: Check that g/s_selection are valid before selecting crop
Date:   Tue,  7 Nov 2023 21:05:09 +0100
Message-ID: <20231107200509.485071-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cropcap and g/s_crop ioctls are automatically marked as valid whenever the
g/s_selection ops are filled. The rationale is to auto-enable these legacy
cropcap and g/s_crop ioctls that rely on g/s_selection.

However it's possible that the ops are filled but explicitly disabled with
calls to v4l2_disable_ioctl. In this situation the legacy ioctls should not
be enabled.

Add a check on the video device's valid ioctls field before auto-selecting
them to honor the driver's choice. Note that the meaning of the bitfield
stored in the video device is the opposite of what the name suggests as
v4l2_disable_ioctl will set the bits. Their meaning will be reversed at
the end of the function.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/v4l2-core/v4l2-dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index f81279492682..d13954bd31fd 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -642,11 +642,13 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		SET_VALID_IOCTL(ops, VIDIOC_TRY_DECODER_CMD, vidioc_try_decoder_cmd);
 		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FRAMESIZES, vidioc_enum_framesizes);
 		SET_VALID_IOCTL(ops, VIDIOC_ENUM_FRAMEINTERVALS, vidioc_enum_frameintervals);
-		if (ops->vidioc_g_selection) {
+		if (ops->vidioc_g_selection &&
+		    !test_bit(_IOC_NR(VIDIOC_G_SELECTION), vdev->valid_ioctls)) {
 			__set_bit(_IOC_NR(VIDIOC_G_CROP), valid_ioctls);
 			__set_bit(_IOC_NR(VIDIOC_CROPCAP), valid_ioctls);
 		}
-		if (ops->vidioc_s_selection)
+		if (ops->vidioc_s_selection &&
+		    !test_bit(_IOC_NR(VIDIOC_S_SELECTION), vdev->valid_ioctls))
 			__set_bit(_IOC_NR(VIDIOC_S_CROP), valid_ioctls);
 		SET_VALID_IOCTL(ops, VIDIOC_G_SELECTION, vidioc_g_selection);
 		SET_VALID_IOCTL(ops, VIDIOC_S_SELECTION, vidioc_s_selection);
-- 
2.42.0

