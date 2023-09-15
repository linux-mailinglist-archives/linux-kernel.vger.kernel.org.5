Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C887A2913
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjIOVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjIOVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:11:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF0EA1;
        Fri, 15 Sep 2023 14:11:53 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A149466072F6;
        Fri, 15 Sep 2023 22:11:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694812312;
        bh=bfjXNTEUGOV/V9xi2T+58cboEq+YPmOFqHLsOLFZbPw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BNrhrDp8xDg1sOY0ZzZSw0/z+hUHhX32F5Km6n2Q/2J8jTNIBATFr0RqgBYO3Kf5/
         j/FQ88xSWFyYi637zcWtKz/0I7s0ibi8H/6yy+bEbX61pR5Q9FYmU0SsP73lTs0mAI
         zjDojvchHDN1c+t3vz3bZfP8VHHLsRtX99U/uRqrCLuZ1NaXy7EHnJAGZ9VYtAeDbt
         L6s1bF7aoN4N4Qqwmi02QbgIpAZb8RZ5M61mQ8NEPioykwX9jU7NJ6XXryitmfdzp8
         BtfAjGoJgNUQog0/x/R3T8tqPziDTsA5MUK1qxZdiZIJAwRObvPN8Cppxh1MRLzBlf
         7tUXYngQxluhQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Fri, 15 Sep 2023 23:11:30 +0200
Subject: [PATCH v12 1/7] media: v4l2: Add ignore_streaming flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-wave5_v12_on_media_master-v12-1-92fc66cd685d@collabora.com>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
In-Reply-To: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694812307; l=2295;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=bfjXNTEUGOV/V9xi2T+58cboEq+YPmOFqHLsOLFZbPw=;
 b=VbAFE35JG3ToaRlhTlsQQfjMPC3TontsrKvcvUyDnHfCVp53Y08nftaFNUIlpaVT9Q2ZOn9XQpjG
 DO/9V4kyAbx025A/fEK2RLlocnBrmDQV2PBOE3EtYKX8h/TamVMl
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag to the `struct v4l2_m2m_dev` to toggle whether a queue
must be streaming in order to allow queuing jobs to the ready queue.
Currently, both queues (CAPTURE & OUTPUT) must be streaming in order to
allow adding new jobs. This behavior limits the usability of M2M for
some drivers, as these have to be able, to perform analysis of the
sequence to ensure, that userspace prepares the CAPTURE queue correctly.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 include/media/v4l2-mem2mem.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index d6c8eb2b5201..97a48e61e358 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -57,6 +57,16 @@ struct v4l2_m2m_dev;
  * @rdy_spinlock: spin lock to protect the struct usage
  * @num_rdy:	number of buffers ready to be processed
  * @buffered:	is the queue buffered?
+ * @ignore_streaming: Dictates whether the queue must be streaming for a job to
+ *		      be queued.
+ *		      This is useful, for example, when the driver requires to
+ *		      initialize the sequence with a firmware, where only a
+ *		      queued OUTPUT queue buffer and STREAMON on the OUTPUT
+ *		      queue is required to perform the anlysis of the bitstream
+ *		      header.
+ *		      This means the driver is responsible for implementing the
+ *		      job_ready callback correctly to make sure that requirements
+ *		      for actual decoding are met.
  *
  * Queue for buffers ready to be processed as soon as this
  * instance receives access to the device.
@@ -69,6 +79,7 @@ struct v4l2_m2m_queue_ctx {
 	spinlock_t		rdy_spinlock;
 	u8			num_rdy;
 	bool			buffered;
+	bool			ignore_streaming;
 };
 
 /**
@@ -564,6 +575,12 @@ static inline void v4l2_m2m_set_dst_buffered(struct v4l2_m2m_ctx *m2m_ctx,
 	m2m_ctx->cap_q_ctx.buffered = buffered;
 }
 
+static inline void v4l2_m2m_set_dst_ignore_streaming(struct v4l2_m2m_ctx *m2m_ctx,
+						     bool ignore_streaming)
+{
+	m2m_ctx->cap_q_ctx.ignore_streaming = ignore_streaming;
+}
+
 /**
  * v4l2_m2m_ctx_release() - release m2m context
  *

-- 
2.25.1
