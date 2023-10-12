Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172E7C6BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378039AbjJLLCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJLLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:02:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B191;
        Thu, 12 Oct 2023 04:02:28 -0700 (PDT)
Received: from localhost (dynamic-002-247-255-251.2.247.pool.telefonica.de [2.247.255.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD7F36607346;
        Thu, 12 Oct 2023 12:02:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697108547;
        bh=w/t+w6u/U3/SZ6HLVnBYGZYlIolHNvHDKuIuLzH9UCw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=df8FTbunD4FTinyxuAZxdLlgKcjWiVlxu9YmQISA9uqgNoXDGcOtkf4J0Qww59Tc8
         9PZPh8wfTiGrJBn9DXgiwGIZoklGxTwulvrLWGsOj9+LTiym/KfPXCdIW8QP5wYwIR
         tmONUUXqDzmRAz+TJweCiAfStu/DhRC1t+KdOV/9Qx7A9jCuAQbbDqbPg5H6KC8r8W
         qAmFxFOwGYeqiYM/yTwoE6GOHkmoua+7Kasf0YSGlwjudvjK7F2BrqVZjSMDl/gG34
         x9gxVtoVz/EmOxZPuNCVVUqjUpgPSreDK+W3/xazNh5V2FT36FRbm7JegWgnAR8UDy
         kpAWReYfOBRqA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Oct 2023 13:00:59 +0200
Subject: [PATCH v13 1/8] media: v4l2: Add ignore_cap_streaming flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-wave5_v13_media_master-v13-1-5ac60ccbf2ce@collabora.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
In-Reply-To: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697108536; l=1946;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=w/t+w6u/U3/SZ6HLVnBYGZYlIolHNvHDKuIuLzH9UCw=;
 b=D16V6519WF+94iLyTvlYo1i/smkP78HVY7aLAnOuUvwA9KhjwGWYZfGuLdScNK8ajJMV1Zf2Cb6W
 mD2QZww+ANJpavyIihiNIaZX5f/YD1gkUYqpOJOVmYlO/u3AHTBF
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

Add a new flag to 'struct v4l2_m2m_ctx' to toggle whether a CAPTURE queue
must be streaming in order to allow queuing OUTPUT jobs to the ready
queue. Currently, both queues (CAPTURE & OUTPUT) must be streaming in
order to add new jobs. This prevents firmware from analyzing the bitstream
header which arrives on the OUTPUT queue and performing an analysis of the
sequence to ensure that userspace prepares the CAPTURE queue correctly.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 include/media/v4l2-mem2mem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index d6c8eb2b5201..1288fe364fab 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -84,6 +84,12 @@ struct v4l2_m2m_queue_ctx {
  * @last_src_buf: indicate the last source buffer for draining
  * @next_buf_last: next capture queud buffer will be tagged as last
  * @has_stopped: indicate the device has been stopped
+ * @ignore_cap_streaming: If true, job_ready can be called even if the CAPTURE
+ *			  queue is not streaming. This allows firmware to
+ *			  analyze the bitstream header which arrives on the
+ *			  OUTPUT queue. The driver must implement the job_ready
+ *			  callback correctly to make sure that the requirements
+ *			  for actual decoding are met.
  * @m2m_dev: opaque pointer to the internal data to handle M2M context
  * @cap_q_ctx: Capture (output to memory) queue context
  * @out_q_ctx: Output (input from memory) queue context
@@ -106,6 +112,7 @@ struct v4l2_m2m_ctx {
 	struct vb2_v4l2_buffer		*last_src_buf;
 	bool				next_buf_last;
 	bool				has_stopped;
+	bool				ignore_cap_streaming;
 
 	/* internal use only */
 	struct v4l2_m2m_dev		*m2m_dev;

-- 
2.25.1
