Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB17E72AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjKIUQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344991AbjKIUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:16:55 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594AD3AAC;
        Thu,  9 Nov 2023 12:16:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64E131C0007;
        Thu,  9 Nov 2023 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699561012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vohYVUqiHx/VJkZ5ChoIsoqSMZl/JxxjgWPaTNjl7Z8=;
        b=K7iX93iQAYkSIAOK6uA/pCnI4bQvim9546Ov6EY6ycp/Ugotz1C9pJiADg+nP+DZ+zL0Z9
        s7JvFag+jbUW2nxf8PiNVoFOqDCTkS1DUxHlVb7t5t3fmEXdVjmppAsqVOg5GtmWLar7yJ
        xXWBknp3TIkNEiTJ2IchXqb2TBZMA0bdWYC4r6NiwcPl4+wh2KotAuBhAtaas//kS6Y5S4
        TxyoKg/RRj/38UgVerobG/RJe7zrCKqCQlHFTRlY7J3WNwEHlrcqLQmCOv5abPnHb0m09D
        V9ndFOSboXhVpZXo+GUB7QukkF96TVlgciWbtUJe5lr7jF/1Tf/0PVWVITXK/A==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 3/4] media: verisilicon: Hook the (TRY_)DECODER_CMD stateless ioctls
Date:   Thu,  9 Nov 2023 21:16:39 +0100
Message-ID: <20231109201640.340556-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231109201640.340556-1-paul.kocialkowski@bootlin.com>
References: <20231109201640.340556-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (TRY_)DECODER_CMD ioctls are used to support flushing when holding capture
buffers is supported. This is the case of this driver but the ioctls were never
hooked to the ioctl ops.

Add them to correctly support flushing.

Fixes: 340ce50f75a6 ("media: hantro: Enable HOLD_CAPTURE_BUF for H.264")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c  | 2 ++
 drivers/media/platform/verisilicon/hantro_v4l2.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index a9fa05ac56a9..3a2a0f28cbfe 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -905,6 +905,8 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
 
 	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
 		vpu->encoder = func;
+		v4l2_disable_ioctl(vfd, VIDIOC_TRY_DECODER_CMD);
+		v4l2_disable_ioctl(vfd, VIDIOC_DECODER_CMD);
 	} else {
 		vpu->decoder = func;
 		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index b3ae037a50f6..db145519fc5d 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -785,6 +785,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_g_selection = vidioc_g_selection,
 	.vidioc_s_selection = vidioc_s_selection,
 
+	.vidioc_decoder_cmd = v4l2_m2m_ioctl_stateless_decoder_cmd,
+	.vidioc_try_decoder_cmd = v4l2_m2m_ioctl_stateless_try_decoder_cmd,
+
 	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
 	.vidioc_encoder_cmd = vidioc_encoder_cmd,
 };
-- 
2.42.1

