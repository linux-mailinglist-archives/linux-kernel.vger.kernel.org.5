Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CEC7E7336
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbjKIVDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbjKIVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:03:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655403A8D;
        Thu,  9 Nov 2023 13:03:32 -0800 (PST)
Received: from umang.jain (unknown [103.251.226.64])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CA3DE1B87;
        Thu,  9 Nov 2023 22:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699563789;
        bh=h/4THN0QIgY78h8lFDTN6nK4kKFVQKeu9FsL8ajD6KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1moi+Pwn5SPdmN+GsMGaL8NHsWvLV+sB4RjJQsW7zeB8Zd7rzMF/5pw6BBw1VdPV
         6+7aT6opN836uex7Vli3Q+kotqsao1ebBJcLpoR4VGK02Rh4Sn4OsfQLWBWZGtVQus
         dvgiYNxNnPYsXRPfdC+uZOVc+wC6Dn6kaDLwI3Ho=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 05/15] staging: mmal-vchiq: Use vc-sm-cma to support zero copy
Date:   Thu,  9 Nov 2023 16:02:57 -0500
Message-ID: <20231109210309.638594-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109210309.638594-1-umang.jain@ideasonboard.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

With the vc-sm-cma driver we can support zero copy of buffers between
the kernel and VPU. Add this support to mmal-vchiq.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/vchiq-mmal/Kconfig  |  1 +
 .../vc04_services/vchiq-mmal/mmal-common.h    |  4 +
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 84 +++++++++++++++++--
 .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  1 +
 4 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
index c99525a0bb45..a7c1a7bf516e 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/Kconfig
+++ b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
@@ -1,6 +1,7 @@
 config BCM2835_VCHIQ_MMAL
 	tristate "BCM2835 MMAL VCHIQ service"
 	depends on BCM2835_VCHIQ
+	select BCM_VC_SM_CMA
 	help
 	  Enables the MMAL API over VCHIQ interface as used for the
 	  majority of the multimedia services on VideoCore.
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
index 0443be8198ea..809634924289 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-common.h
@@ -50,6 +50,10 @@ struct mmal_buffer {
 
 	struct mmal_msg_context *msg_context;
 
+	struct dma_buf *dma_buf;/* Exported dmabuf fd from videobuf2 */
+	void *vcsm_handle;      /* VCSM handle having imported the dmabuf */
+	u32 vc_handle;          /* VC handle to that dmabuf */
+
 	u32 cmd;		/* MMAL command. 0=data. */
 	unsigned long length;
 	u32 mmal_flags;
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 6a270f308cf7..890669f874d9 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -27,9 +27,12 @@
 
 #include "../include/linux/raspberrypi/vchiq.h"
 #include "mmal-common.h"
+#include "mmal-parameters.h"
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
 
+#include "../vc-sm-cma/vc_sm_knl.h"
+
 /*
  * maximum number of components supported.
  * This matches the maximum permitted by default on the VPU
@@ -416,14 +419,27 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 
 	/* buffer header */
 	m.u.buffer_from_host.buffer_header.cmd = 0;
-	m.u.buffer_from_host.buffer_header.data =
-		(u32)(unsigned long)buf->buffer;
+	if (port->zero_copy) {
+		m.u.buffer_from_host.buffer_header.data = buf->vc_handle;
+	} else {
+		m.u.buffer_from_host.buffer_header.data =
+				(u32)(unsigned long)buf->buffer;
+	}
+
 	m.u.buffer_from_host.buffer_header.alloc_size = buf->buffer_size;
-	m.u.buffer_from_host.buffer_header.length = 0;	/* nothing used yet */
-	m.u.buffer_from_host.buffer_header.offset = 0;	/* no offset */
-	m.u.buffer_from_host.buffer_header.flags = 0;	/* no flags */
-	m.u.buffer_from_host.buffer_header.pts = MMAL_TIME_UNKNOWN;
-	m.u.buffer_from_host.buffer_header.dts = MMAL_TIME_UNKNOWN;
+	if (port->type == MMAL_PORT_TYPE_OUTPUT) {
+		m.u.buffer_from_host.buffer_header.length = 0;
+		m.u.buffer_from_host.buffer_header.offset = 0;
+		m.u.buffer_from_host.buffer_header.flags = 0;
+		m.u.buffer_from_host.buffer_header.pts = MMAL_TIME_UNKNOWN;
+		m.u.buffer_from_host.buffer_header.dts = MMAL_TIME_UNKNOWN;
+	} else {
+		m.u.buffer_from_host.buffer_header.length = buf->length;
+		m.u.buffer_from_host.buffer_header.offset = 0;
+		m.u.buffer_from_host.buffer_header.flags = buf->mmal_flags;
+		m.u.buffer_from_host.buffer_header.pts = buf->pts;
+		m.u.buffer_from_host.buffer_header.dts = buf->dts;
+	}
 
 	/* clear buffer type specific data */
 	memset(&m.u.buffer_from_host.buffer_header_type_specific, 0,
@@ -574,6 +590,21 @@ static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 
 		msg_context->u.bulk.status = msg->h.status;
 
+	} else if (msg->u.buffer_from_host.is_zero_copy) {
+		/*
+		 * Zero copy buffer, so nothing to do.
+		 * Copy buffer info and make callback.
+		 */
+		msg_context->u.bulk.buffer_used =
+			msg->u.buffer_from_host.buffer_header.length;
+		msg_context->u.bulk.mmal_flags =
+			msg->u.buffer_from_host.buffer_header.flags;
+		msg_context->u.bulk.dts =
+			msg->u.buffer_from_host.buffer_header.dts;
+		msg_context->u.bulk.pts =
+			msg->u.buffer_from_host.buffer_header.pts;
+		msg_context->u.bulk.cmd =
+			msg->u.buffer_from_host.buffer_header.cmd;
 	} else if (msg->u.buffer_from_host.buffer_header.length == 0) {
 		/* empty buffer */
 		if (msg->u.buffer_from_host.buffer_header.flags &
@@ -1518,6 +1549,9 @@ int vchiq_mmal_port_parameter_set(struct vchiq_mmal_instance *instance,
 
 	mutex_unlock(&instance->vchiq_mutex);
 
+	if (parameter == MMAL_PARAMETER_ZERO_COPY && !ret)
+		port->zero_copy = !!(*(bool *)value);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vchiq_mmal_port_parameter_set);
@@ -1686,6 +1720,31 @@ int vchiq_mmal_submit_buffer(struct vchiq_mmal_instance *instance,
 	unsigned long flags = 0;
 	int ret;
 
+	/*
+	 * We really want to do this in mmal_vchi_buffer_init but can't as
+	 * videobuf2 won't let us have the dmabuf there.
+	 */
+	if (port->zero_copy && buffer->dma_buf && !buffer->vcsm_handle) {
+		pr_debug("%s: import dmabuf %p\n", __func__, buffer->dma_buf);
+		ret = vc_sm_cma_import_dmabuf(buffer->dma_buf,
+					      &buffer->vcsm_handle);
+		if (ret) {
+			pr_err("%s: vc_sm_import_dmabuf_fd failed, ret %d\n",
+			       __func__, ret);
+			return ret;
+		}
+
+		buffer->vc_handle = vc_sm_cma_int_handle(buffer->vcsm_handle);
+		if (!buffer->vc_handle) {
+			pr_err("%s: vc_sm_int_handle failed %d\n",
+			       __func__, ret);
+			vc_sm_cma_free(buffer->vcsm_handle);
+			return ret;
+		}
+		pr_debug("%s: import dmabuf %p - got vc handle %08X\n",
+			 __func__, buffer->dma_buf, buffer->vc_handle);
+	}
+
 	ret = buffer_from_host(instance, port, buffer);
 	if (ret == -EINVAL) {
 		/* Port is disabled. Queue for when it is enabled. */
@@ -1719,6 +1778,17 @@ int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf)
 		release_msg_context(msg_context);
 	buf->msg_context = NULL;
 
+	if (buf->vcsm_handle) {
+		int ret;
+
+		pr_debug("%s: vc_sm_cma_free on handle %p\n", __func__,
+			 buf->vcsm_handle);
+		ret = vc_sm_cma_free(buf->vcsm_handle);
+		if (ret)
+			pr_err("%s: vcsm_free failed, ret %d\n", __func__, ret);
+		buf->vcsm_handle = 0;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmal_vchi_buffer_cleanup);
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 7be26cb39165..7aeb38c0c94f 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -49,6 +49,7 @@ typedef void (*vchiq_mmal_buffer_cb)(
 
 struct vchiq_mmal_port {
 	bool enabled;
+	u32 zero_copy;
 	u32 handle;
 	u32 type; /* port type, cached to use on port info set */
 	u32 index; /* port index, cached to use on port info set */
-- 
2.41.0

