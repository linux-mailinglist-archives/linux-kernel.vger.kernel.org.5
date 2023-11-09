Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151C47E72B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjKIURB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKIUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:16:57 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E8644B0;
        Thu,  9 Nov 2023 12:16:54 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93FD01C0006;
        Thu,  9 Nov 2023 20:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699561011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zbTVYuvmRUaQtmj4VIv+6MHR+6X+gUKoXAkYu3nSfeI=;
        b=ZK5e/wDc09qPgtZXCY6x5stZszvLgejTsenovmCcTYYN//u7hv//TDM2gA3Jw3bYHIHuF+
        rjIHacq6EC/gtVzTHzcGpbb8DKHjRTnFlQunL08hd+GiWHKs9ezS4SISbT9Qjnnai2DIVN
        7RAf7X40ynDSQreWM5dcNUTA2skN5UkEGkyj4Ayi75H/irUJ5uqyCSkJ0ZF0DpKYPiaTL0
        oPjp205T8rEmqMUAZ/MOpudemsoEW1oW85DlbLW2pOWo81VHoxr6yUL/0DMc3HA4viHbCG
        tYOi0Hy8p3grRakL3cCTKL6Aqx+9LYhVnYD15zmD7rjAB2Z1ci+X0W8CwD9LIQ==
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
Subject: [PATCH 2/4] media: visl: Hook the (TRY_)DECODER_CMD stateless ioctls
Date:   Thu,  9 Nov 2023 21:16:38 +0100
Message-ID: <20231109201640.340556-2-paul.kocialkowski@bootlin.com>
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

Fixes: 0c078e310b6d ("media: visl: add virtual stateless decoder driver")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/test-drivers/visl/visl-video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/test-drivers/visl/visl-video.c b/drivers/media/test-drivers/visl/visl-video.c
index 7cac6a6456eb..9303a3e118d7 100644
--- a/drivers/media/test-drivers/visl/visl-video.c
+++ b/drivers/media/test-drivers/visl/visl-video.c
@@ -525,6 +525,9 @@ const struct v4l2_ioctl_ops visl_ioctl_ops = {
 	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
 
+	.vidioc_decoder_cmd		= v4l2_m2m_ioctl_stateless_decoder_cmd,
+	.vidioc_try_decoder_cmd		= v4l2_m2m_ioctl_stateless_try_decoder_cmd,
+
 	.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
 };
-- 
2.42.1

