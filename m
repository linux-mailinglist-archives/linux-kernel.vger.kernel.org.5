Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC17B217F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjI1Pjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjI1Pjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:39:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6ADDD6;
        Thu, 28 Sep 2023 08:39:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1551FB;
        Thu, 28 Sep 2023 08:40:18 -0700 (PDT)
Received: from e127619.cambridge.arm.com (e127619.arm.com [10.1.36.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 498863F59C;
        Thu, 28 Sep 2023 08:39:39 -0700 (PDT)
From:   Divin Raj <divin.raj@arm.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 1/1] rpmsg: virtio: Make buffer size and number configurable
Date:   Thu, 28 Sep 2023 16:38:25 +0100
Message-Id: <20230928153825.151948-2-divin.raj@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928153825.151948-1-divin.raj@arm.com>
References: <20230928153825.151948-1-divin.raj@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hoyes <Peter.Hoyes@arm.com>

Replace the MAX_RPMSG_BUF_SIZE and MAX_RPMSG_NUM_BUFS #define in
virtio_rpmsg_bus.c with the Kconfig parameters CONFIG_RPMSG_VIRTIO_BUF_SIZE
and CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS, allowing user-provided customization.

Making both the number of buffers and size configurable facilitates aligning
memory requirements between vdev-buffer and vdev-vrings for client drivers
that require larger buffer sizes, for example.

Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
Signed-off-by: Divin Raj <divin.raj@arm.com>
---
 drivers/rpmsg/Kconfig            | 23 +++++++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 27 +++------------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d3795860f5c0..677f4a1ac8bb 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -81,4 +81,27 @@ config RPMSG_VIRTIO
 	select RPMSG_NS
 	select VIRTIO
 
+config RPMSG_VIRTIO_MAX_BUF_SIZE
+	int "Virtio RPMSG max buffer size (in bytes)"
+	default 512
+	depends on RPMSG_VIRTIO
+	help
+	  This option allows you to configure the maximum buffer size (in bytes)
+	  for Virtio RPMSG communications. The number of buffers will be computed
+	  based on the number of buffers (CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS)
+	  supported by the vring. By default, it supports up to a maximum of 512
+	  buffers (256 in each direction). Each buffer consists of 16 bytes for the
+	  message header and the remaining bytes for the payload.The default values
+	  will utilize a maximum total space of 256KB for the buffers.
+
+config RPMSG_VIRTIO_MAX_NUM_BUFS
+	int "Virtio RPMSG max buffer count (even number for TX and Rx)"
+	default 512
+	depends on RPMSG_VIRTIO
+	help
+	  This option allows you to configure the maximum number of buffers used
+	  for Virtio RPMSG communication. By default, it supports up to a maximum
+	  of 512 buffers (256 in each direction). Please note that this value
+	  should be an even number, as it accounts for both transmit (TX) and
+	  receive (Rx) buffers.
 endmenu
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 905ac7910c98..87a9a4fa30e0 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -109,27 +109,6 @@ struct virtio_rpmsg_channel {
 #define to_virtio_rpmsg_channel(_rpdev) \
 	container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
 
-/*
- * We're allocating buffers of 512 bytes each for communications. The
- * number of buffers will be computed from the number of buffers supported
- * by the vring, upto a maximum of 512 buffers (256 in each direction).
- *
- * Each buffer will have 16 bytes for the msg header and 496 bytes for
- * the payload.
- *
- * This will utilize a maximum total space of 256KB for the buffers.
- *
- * We might also want to add support for user-provided buffers in time.
- * This will allow bigger buffer size flexibility, and can also be used
- * to achieve zero-copy messaging.
- *
- * Note that these numbers are purely a decision of this driver - we
- * can change this without changing anything in the firmware of the remote
- * processor.
- */
-#define MAX_RPMSG_NUM_BUFS	(512)
-#define MAX_RPMSG_BUF_SIZE	(512)
-
 /*
  * Local addresses are dynamically allocated on-demand.
  * We do not dynamically assign addresses from the low 1024 range,
@@ -902,12 +881,12 @@ static int rpmsg_probe(struct virtio_device *vdev)
 		virtqueue_get_vring_size(vrp->svq));
 
 	/* we need less buffers if vrings are small */
-	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
+	if (virtqueue_get_vring_size(vrp->rvq) < CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS / 2)
 		vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
 	else
-		vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
+		vrp->num_bufs = CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS;
 
-	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
+	vrp->buf_size = CONFIG_RPMSG_VIRTIO_MAX_BUF_SIZE;
 
 	total_buf_space = vrp->num_bufs * vrp->buf_size;
 
-- 
2.25.1

