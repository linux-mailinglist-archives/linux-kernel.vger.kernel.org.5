Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803367E72B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbjKIURE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:16:57 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D643AAC;
        Thu,  9 Nov 2023 12:16:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21C8F1C0008;
        Thu,  9 Nov 2023 20:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699561012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g44nGM0ulGdPmsKjAGuOOVpTRwfyVkwDcA7l+uwsI6Y=;
        b=j4y3CJaxX8sR0enPCYnGV1fGz8oN1sM4XbJlVX4NqPWbVT5itq0mQqJKJ3qb65iombJ0Qg
        U0SBXeRsB0rdLBHMCcibN7qfOGH751/DVhyjiNW1uMYec8gaOW+PHWN30NQqUEGGd59Im4
        GeIuTsJVRL0xDEslefgltpHiis5nVxQAzQxWTYou9/IZQ2rww6Q2RLiSMBO8lgPjBSwEhT
        VxdQVRGUwuEcHjVwiAQBpKLAozY0L5Ehu0XshlsF11RN0z3Kvfm8dsILxjzK+E406YFmK4
        FI2GZEBO3R5WjEbx+CY0g3d6avWTlHAK2U63zjw6u81ikBCoAxHzX8unGdhzvQ==
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
Subject: [PATCH 4/4] media: rkvdec: Hook the (TRY_)DECODER_CMD stateless ioctls
Date:   Thu,  9 Nov 2023 21:16:40 +0100
Message-ID: <20231109201640.340556-4-paul.kocialkowski@bootlin.com>
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

Fixes: ed7bb87d3d03 ("media: rkvdec: Enable capture buffer holding for H264")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 84a41792cb4b..ac398b5a9736 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -461,6 +461,9 @@ static const struct v4l2_ioctl_ops rkvdec_ioctl_ops = {
 
 	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
+
+	.vidioc_decoder_cmd = v4l2_m2m_ioctl_stateless_decoder_cmd,
+	.vidioc_try_decoder_cmd = v4l2_m2m_ioctl_stateless_try_decoder_cmd,
 };
 
 static int rkvdec_queue_setup(struct vb2_queue *vq, unsigned int *num_buffers,
-- 
2.42.1

