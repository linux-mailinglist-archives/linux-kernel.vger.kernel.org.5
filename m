Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D879F17A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjIMSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjIMSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:55:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143B170F;
        Wed, 13 Sep 2023 11:55:50 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E394741;
        Wed, 13 Sep 2023 20:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694631256;
        bh=Jjr5Hcv5bYkQu+hmewDlyYLwn+E8cyoRvnJeJ7b6OO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnZrnImT94VQjd3K9pw1z0aFvGZSz9eqKN8novRSuvWkDpWS68DUYYC/Qq72eD0cM
         vxXlGcR1n8ONu8XGyC6xkEt/7EuphLIn09QRSLW2Vy5uaJzftLaQbjtmNkVDFoUTZ8
         hIbCgp8bL1ZHdjhhVeeQ7xj0HpsCQz5Q+B0Lxw4o=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [RFC PATCH v2 2/4] staging: vc04: Convert vchiq_log_warning() to use dynamic debug
Date:   Thu, 14 Sep 2023 00:25:26 +0530
Message-Id: <20230913185528.770634-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913185528.770634-1-umang.jain@ideasonboard.com>
References: <20230913185528.770634-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of ongoing series i.e. moving away from printk
based logging to dynamic debug logging mechanism, this patch
converts vchiq_log_warning() wrapper to use dynamic debug.
The log category is dictated by enum vchiq_log_category
which will become the part of the warning string format that
will be logged to dynamic debug (for grep).

All the vchiq_log_warning() calls are adjusted to use the
modified wrapper.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c             | 17 ++++++++++-------
 .../interface/vchiq_arm/vchiq_core.c            |  8 ++++----
 .../interface/vchiq_arm/vchiq_core.h            |  5 ++---
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6e3cf05d7f6b..bac3c324b6be 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -687,7 +687,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 		ret = -ENOTCONN;
 		goto failed;
 	} else if (i > 0) {
-		vchiq_log_warning(vchiq_core_log_level,
+		vchiq_log_warning(state->dev, VCHIQ_CORE,
 				  "%s: videocore initialized after %d retries\n", __func__, i);
 	}
 
@@ -1688,17 +1688,20 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (only_nonzero)
-		vchiq_log_warning(vchiq_susp_log_level, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
+		vchiq_log_warning(state->dev, VCHIQ_SUSPEND,
+				  "Too many active services (%d). Only dumping up to first %d \
+				   services with non-zero use-count",
 				  active_services, found);
 
 	for (i = 0; i < found; i++) {
-		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
+		vchiq_log_warning(state->dev,VCHIQ_SUSPEND,
+				  "----- %c%c%c%c:%d service count %d %s",
 				  VCHIQ_FOURCC_AS_4CHARS(service_data[i].fourcc),
 				  service_data[i].clientid, service_data[i].use_count,
 				  service_data[i].use_count ? nz : "");
 	}
-	vchiq_log_warning(vchiq_susp_log_level, "----- VCHIQ use count %d", peer_count);
-	vchiq_log_warning(vchiq_susp_log_level, "--- Overall vchiq instance use count %d",
+	vchiq_log_warning(state->dev, VCHIQ_SUSPEND, "----- VCHIQ use count %d", peer_count);
+	vchiq_log_warning(state->dev, VCHIQ_SUSPEND, "--- Overall vchiq instance use count %d",
 			  vc_use_count);
 
 	kfree(service_data);
@@ -1836,7 +1839,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	 */
 	err = vchiq_register_chrdev(&pdev->dev);
 	if (err) {
-		vchiq_log_warning(vchiq_arm_log_level,
+		vchiq_log_warning(&pdev->dev, VCHIQ_ARM,
 				  "Failed to initialize vchiq cdev");
 		goto error_exit;
 	}
@@ -1847,7 +1850,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	return 0;
 
 failed_platform_init:
-	vchiq_log_warning(vchiq_arm_log_level, "could not initialize vchiq platform");
+	vchiq_log_warning(&pdev->dev, VCHIQ_ARM, "could not initialize vchiq platform");
 error_exit:
 	return err;
 }
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index add4a1ccd918..d25733fa296d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -475,7 +475,7 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 	status = service->base.callback(service->instance, reason, header, service->handle,
 					bulk_userdata);
 	if (status && (status != -EAGAIN)) {
-		vchiq_log_warning(vchiq_core_log_level,
+		vchiq_log_warning(service->state->dev, VCHIQ_CORE,
 				  "%d: ignoring ERROR from callback to service %x",
 				  service->state->id, service->handle);
 		status = 0;
@@ -1622,7 +1622,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				vchiq_service_put(service);
 			service = get_connected_service(state, remoteport);
 			if (service)
-				vchiq_log_warning(vchiq_core_log_level,
+				vchiq_log_warning(state->dev, VCHIQ_CORE,
 						  "%d: prs %s@%pK (%d->%d) - found connected service %d",
 						  state->id, msg_type_str(type), header,
 						  remoteport, localport, service->localport);
@@ -2921,7 +2921,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN))
 			break;
 
-		vchiq_log_warning(vchiq_core_log_level,
+		vchiq_log_warning(service->state->dev, VCHIQ_CORE,
 				  "%d: close_service:%d - waiting in state %s",
 				  service->state->id, service->localport,
 				  srvstate_names[service->srvstate]);
@@ -2982,7 +2982,7 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 		    (service->srvstate == VCHIQ_SRVSTATE_OPEN))
 			break;
 
-		vchiq_log_warning(vchiq_core_log_level,
+		vchiq_log_warning(service->state->dev, VCHIQ_CORE,
 				  "%d: remove_service:%d - waiting in state %s",
 				  service->state->id, service->localport,
 				  srvstate_names[service->srvstate]);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 4e531a066e67..c7ae2efc33eb 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -65,9 +65,8 @@ static inline const char *log_category_str(enum vchiq_log_category c)
        dev_dbg(dev, "%s error: " fmt, log_category_str(cat), ##__VA_ARGS__);
 #endif
 #ifndef vchiq_log_warning
-#define vchiq_log_warning(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_WARNING) \
-		 printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
+#define vchiq_log_warning(dev, cat, fmt, ...) \
+       dev_dbg(dev, "%s warning: " fmt, log_category_str(cat), ##__VA_ARGS__);
 #endif
 #ifndef vchiq_log_info
 #define vchiq_log_info(cat, fmt, ...) \
-- 
2.40.1

