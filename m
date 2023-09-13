Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144EB79F179
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjIMSzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjIMSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:55:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D91986;
        Wed, 13 Sep 2023 11:55:46 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2AA4072E;
        Wed, 13 Sep 2023 20:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694631253;
        bh=MoczByXlLJn10DBFdDW59rtrSHSwn1brPhPIcvXPdPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsY+eCQMCB3gsn4MCnToc2Zuz/myns6WZQ3gCgVWLCJt1xNnWDEfcqiEr0WnG4fip
         PEZbGsiPtlTCpv8u5Q0kIZ8d4S9vRFROWp2QDgwjSpa0Bs4SZSLQmIdde52TnseHOA
         r76sT+n40OBNJSh2EkcGgX9FBkrzhlPmJbItCxQ4=
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
Subject: [RFC PATCH v2 1/4] staging: vc04: Convert vchiq_log_error() to use dynamic debug
Date:   Thu, 14 Sep 2023 00:25:25 +0530
Message-Id: <20230913185528.770634-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913185528.770634-1-umang.jain@ideasonboard.com>
References: <20230913185528.770634-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move custom logging based on printk to use dynamic debug.
To categorise, enum vchiq_log_category has been introduced,
which will become the part of the error string format that
will be logged to dynamic debug (for grep).

All the vchiq_log_error() calls are adjusted to use the
dynamic debug wrapper. vchiq_loud_error_*() has been removed
as a part of this patch and replaced with dev_err (so that
they directly end up in kernel log, even if dynamic debug
isn't enabled), which serves the purpose.

vchiq_init_slots() signature has been adjusted to include
a struct device pointer, to facililate vchiq_log_error().

vchiq_validate_params() signature has been adjusted to
include struct vchiq_state parameter to access the
struct device pointer.

Call to vchiq_log_error() in vchiq_connected.c does not fit here,
since lack of struct device pointer. For now, it has been changed
to use pr_err() directly (marked as TODO to take a look later).

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           |  37 ++++---
 .../interface/vchiq_arm/vchiq_connected.c     |   6 +-
 .../interface/vchiq_arm/vchiq_core.c          | 100 +++++++-----------
 .../interface/vchiq_arm/vchiq_core.h          |  31 ++++--
 .../interface/vchiq_arm/vchiq_dev.c           |  14 +--
 5 files changed, 90 insertions(+), 98 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index aa2313f3bcab..6e3cf05d7f6b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -499,7 +499,7 @@ static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state
 
 	WARN_ON(((unsigned long)slot_mem & (PAGE_SIZE - 1)) != 0);
 
-	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
+	vchiq_slot_zero = vchiq_init_slots(dev, slot_mem, slot_mem_size);
 	if (!vchiq_slot_zero)
 		return -ENOMEM;
 
@@ -683,7 +683,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 		usleep_range(500, 600);
 	}
 	if (i == VCHIQ_INIT_RETRIES) {
-		vchiq_log_error(vchiq_core_log_level, "%s: videocore not initialized\n", __func__);
+		vchiq_log_error(state->dev, VCHIQ_CORE, "%s: videocore not initialized\n", __func__);
 		ret = -ENOTCONN;
 		goto failed;
 	} else if (i > 0) {
@@ -693,7 +693,7 @@ int vchiq_initialise(struct vchiq_instance **instance_out)
 
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
 	if (!instance) {
-		vchiq_log_error(vchiq_core_log_level,
+		vchiq_log_error(state->dev, VCHIQ_CORE,
 				"%s: error allocating vchiq instance\n", __func__);
 		ret = -ENOMEM;
 		goto failed;
@@ -959,7 +959,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 	} else {
 		waiter = kzalloc(sizeof(*waiter), GFP_KERNEL);
 		if (!waiter) {
-			vchiq_log_error(vchiq_core_log_level, "%s - out of memory", __func__);
+			vchiq_log_error(service->state->dev, VCHIQ_CORE,
+					"%s - out of memory", __func__);
 			return -ENOMEM;
 		}
 	}
@@ -1326,7 +1327,8 @@ vchiq_keepalive_vchiq_callback(struct vchiq_instance *instance,
 			       struct vchiq_header *header,
 			       unsigned int service_user, void *bulk_user)
 {
-	vchiq_log_error(vchiq_susp_log_level, "%s callback reason %d", __func__, reason);
+	vchiq_log_error(instance->state->dev, VCHIQ_SUSPEND,
+			"%s callback reason %d", __func__, reason);
 	return 0;
 }
 
@@ -1350,22 +1352,22 @@ vchiq_keepalive_thread_func(void *v)
 
 	ret = vchiq_initialise(&instance);
 	if (ret) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_initialise failed %d", __func__,
-				ret);
+		vchiq_log_error(state->dev, VCHIQ_SUSPEND,
+				"%s vchiq_initialise failed %d", __func__, ret);
 		goto exit;
 	}
 
 	status = vchiq_connect(instance);
 	if (status) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_connect failed %d", __func__,
-				status);
+		vchiq_log_error(state->dev, VCHIQ_SUSPEND,
+				"%s vchiq_connect failed %d", __func__, status);
 		goto shutdown;
 	}
 
 	status = vchiq_add_service(instance, &params, &ka_handle);
 	if (status) {
-		vchiq_log_error(vchiq_susp_log_level, "%s vchiq_open_service failed %d", __func__,
-				status);
+		vchiq_log_error(state->dev, VCHIQ_SUSPEND,
+				"%s vchiq_open_service failed %d", __func__, status);
 		goto shutdown;
 	}
 
@@ -1373,7 +1375,8 @@ vchiq_keepalive_thread_func(void *v)
 		long rc = 0, uc = 0;
 
 		if (wait_for_completion_interruptible(&arm_state->ka_evt)) {
-			vchiq_log_error(vchiq_susp_log_level, "%s interrupted", __func__);
+			vchiq_log_error(state->dev, VCHIQ_SUSPEND,
+					"%s interrupted", __func__);
 			flush_signals(current);
 			continue;
 		}
@@ -1393,14 +1396,14 @@ vchiq_keepalive_thread_func(void *v)
 			atomic_inc(&arm_state->ka_use_ack_count);
 			status = vchiq_use_service(instance, ka_handle);
 			if (status) {
-				vchiq_log_error(vchiq_susp_log_level,
+				vchiq_log_error(state->dev, VCHIQ_SUSPEND,
 						"%s vchiq_use_service error %d", __func__, status);
 			}
 		}
 		while (rc--) {
 			status = vchiq_release_service(instance, ka_handle);
 			if (status) {
-				vchiq_log_error(vchiq_susp_log_level,
+				vchiq_log_error(state->dev, VCHIQ_SUSPEND,
 						"%s vchiq_release_service error %d", __func__,
 						status);
 			}
@@ -1437,7 +1440,7 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 			service->client_id);
 		entity_uc = &service->service_use_count;
 	} else {
-		vchiq_log_error(vchiq_susp_log_level, "%s null service ptr", __func__);
+		vchiq_log_error(state->dev, VCHIQ_SUSPEND, "%s null service ptr", __func__);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1718,7 +1721,7 @@ vchiq_check_service(struct vchiq_service *service)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (ret) {
-		vchiq_log_error(vchiq_susp_log_level,
+		vchiq_log_error(service->state->dev, VCHIQ_SUSPEND,
 				"%s ERROR - %c%c%c%c:%d service count %d, state count %d", __func__,
 				VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc), service->client_id,
 				service->service_use_count, arm_state->videocore_use_count);
@@ -1754,7 +1757,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 					      (void *)state,
 					      threadname);
 	if (IS_ERR(arm_state->ka_thread)) {
-		vchiq_log_error(vchiq_susp_log_level,
+		vchiq_log_error(state->dev, VCHIQ_SUSPEND,
 				"vchiq: FATAL: couldn't create thread %s",
 				threadname);
 	} else {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index bdb0ab617d8b..a154aebebb64 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -39,9 +39,9 @@ void vchiq_add_connected_callback(void (*callback)(void))
 		callback();
 	} else {
 		if (g_num_deferred_callbacks >= MAX_CALLBACKS) {
-			vchiq_log_error(vchiq_core_log_level,
-					"There already %d callback registered - please increase MAX_CALLBACKS",
-					g_num_deferred_callbacks);
+			/* TODO: Should be using vchiq_log_error() too? */
+			pr_err("There already %d callback registered - please increase MAX_CALLBACKS",
+			       g_num_deferred_callbacks);
 		} else {
 			g_deferred_callback[g_num_deferred_callbacks] =
 				callback;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 596894338cb4..add4a1ccd918 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -751,7 +751,7 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 		 */
 		complete(&quota->quota_event);
 	} else if (count == 0) {
-		vchiq_log_error(vchiq_core_log_level,
+		vchiq_log_error(state->dev, VCHIQ_CORE,
 				"service %d message_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
 				port, quota->message_use_count, header, msgid, header->msgid,
 				header->size);
@@ -776,7 +776,7 @@ process_free_data_message(struct vchiq_state *state, u32 *service_found,
 			vchiq_log_trace(vchiq_core_log_level, "%d: pfq:%d %x@%pK - slot_use->%d",
 					state->id, port, header->size, header, count - 1);
 		} else {
-			vchiq_log_error(vchiq_core_log_level,
+			vchiq_log_error(state->dev, VCHIQ_CORE,
 					"service %d slot_use_count=%d (header %pK, msgid %x, header->msgid %x, header->size %x)",
 					port, count, header, msgid, header->msgid, header->size);
 			WARN(1, "bad slot use count\n");
@@ -841,7 +841,7 @@ process_free_queue(struct vchiq_state *state, u32 *service_found,
 
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
-				vchiq_log_error(vchiq_core_log_level,
+				vchiq_log_error(state->dev, VCHIQ_CORE,
 						"pfq - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
 						pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
@@ -1178,7 +1178,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		int oldmsgid = header->msgid;
 
 		if (oldmsgid != VCHIQ_MSGID_PADDING)
-			vchiq_log_error(vchiq_core_log_level, "%d: qms - msgid %x, not PADDING",
+			vchiq_log_error(state->dev, VCHIQ_CORE, "%d: qms - msgid %x, not PADDING",
 					state->id, oldmsgid);
 	}
 
@@ -1512,11 +1512,9 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	if ((service->version < version_min) || (version < service->version_min)) {
 		/* Version mismatch */
-		vchiq_loud_error_header();
-		vchiq_loud_error("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
-				 state->id, service->localport, VCHIQ_FOURCC_AS_4CHARS(fourcc),
-				 service->version, service->version_min, version, version_min);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
+			state->id, service->localport, VCHIQ_FOURCC_AS_4CHARS(fourcc),
+			service->version, service->version_min, version, version_min);
 		vchiq_service_put(service);
 		service = NULL;
 		goto fail_open;
@@ -1631,7 +1629,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 
 		if (!service) {
-			vchiq_log_error(vchiq_core_log_level,
+			vchiq_log_error(state->dev, VCHIQ_CORE,
 					"%d: prs %s@%pK (%d->%d) - invalid/closed service %d",
 					state->id, msg_type_str(type), header, remoteport,
 					localport, localport);
@@ -1658,7 +1656,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 
 	if (((unsigned long)header & VCHIQ_SLOT_MASK) +
 	    calc_stride(size) > VCHIQ_SLOT_SIZE) {
-		vchiq_log_error(vchiq_core_log_level,
+		vchiq_log_error(state->dev, VCHIQ_CORE,
 				"header %pK (msgid %x) - size %x too big for slot",
 				header, (unsigned int)msgid, (unsigned int)size);
 		WARN(1, "oversized for slot\n");
@@ -1685,7 +1683,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			set_service_state(service, VCHIQ_SRVSTATE_OPEN);
 			complete(&service->remove_event);
 		} else {
-			vchiq_log_error(vchiq_core_log_level, "OPENACK received in state %s",
+			vchiq_log_error(state->dev, VCHIQ_CORE, "OPENACK received in state %s",
 					srvstate_names[service->srvstate]);
 		}
 		break;
@@ -1756,7 +1754,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			}
 			if ((int)(queue->remote_insert -
 				queue->local_insert) >= 0) {
-				vchiq_log_error(vchiq_core_log_level,
+				vchiq_log_error(state->dev, VCHIQ_CORE,
 						"%d: prs %s@%pK (%d->%d) unexpected (ri=%d,li=%d)",
 						state->id, msg_type_str(type), header, remoteport,
 						localport, queue->remote_insert,
@@ -1805,7 +1803,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		vchiq_log_trace(vchiq_core_log_level, "%d: prs PAUSE@%pK,%x",
 				state->id, header, size);
 		if (state->conn_state == VCHIQ_CONNSTATE_PAUSED) {
-			vchiq_log_error(vchiq_core_log_level, "%d: PAUSE received in state PAUSED",
+			vchiq_log_error(state->dev, VCHIQ_CORE, "%d: PAUSE received in state PAUSED",
 					state->id);
 			break;
 		}
@@ -1836,7 +1834,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%d: prs invalid msgid %x@%pK,%x",
+		vchiq_log_error(state->dev, VCHIQ_CORE, "%d: prs invalid msgid %x@%pK,%x",
 				state->id, msgid, header, size);
 		WARN(1, "invalid message\n");
 		break;
@@ -1947,7 +1945,7 @@ handle_poll(struct vchiq_state *state)
 			 * since the PAUSE should have flushed
 			 * through outstanding messages.
 			 */
-			vchiq_log_error(vchiq_core_log_level, "Failed to send RESUME message");
+			vchiq_log_error(state->dev, VCHIQ_CORE, "Failed to send RESUME message");
 		}
 		break;
 	default:
@@ -2046,7 +2044,7 @@ sync_func(void *v)
 		service = find_service_by_port(state, localport);
 
 		if (!service) {
-			vchiq_log_error(vchiq_sync_log_level,
+			vchiq_log_error(state->dev, VCHIQ_SYNC,
 					"%d: sf %s@%pK (%d->%d) - invalid/closed service %d",
 					state->id, msg_type_str(type), header,
 					remoteport, localport, localport);
@@ -2096,14 +2094,14 @@ sync_func(void *v)
 			    (service->srvstate == VCHIQ_SRVSTATE_OPENSYNC)) {
 				if (make_service_callback(service, VCHIQ_MESSAGE_AVAILABLE, header,
 							  NULL) == -EAGAIN)
-					vchiq_log_error(vchiq_sync_log_level,
+					vchiq_log_error(state->dev, VCHIQ_SYNC,
 							"synchronous callback to service %d returns -EAGAIN",
 							localport);
 			}
 			break;
 
 		default:
-			vchiq_log_error(vchiq_sync_log_level, "%d: sf unexpected msgid %x@%pK,%x",
+			vchiq_log_error(state->dev, VCHIQ_SYNC, "%d: sf unexpected msgid %x@%pK,%x",
 					state->id, msgid, header, size);
 			release_message_sync(state, header);
 			break;
@@ -2122,7 +2120,7 @@ get_conn_state_name(enum vchiq_connstate conn_state)
 }
 
 struct vchiq_slot_zero *
-vchiq_init_slots(void *mem_base, int mem_size)
+vchiq_init_slots(struct device *dev, void *mem_base, int mem_size)
 {
 	int mem_align =
 		(int)((VCHIQ_SLOT_SIZE - (long)mem_base) & VCHIQ_SLOT_MASK);
@@ -2137,7 +2135,7 @@ vchiq_init_slots(void *mem_base, int mem_size)
 	num_slots -= first_data_slot;
 
 	if (num_slots < 4) {
-		vchiq_log_error(vchiq_core_log_level, "%s - insufficient memory %x bytes",
+		vchiq_log_error(dev, VCHIQ_CORE, "%s - insufficient memory %x bytes",
 				__func__, mem_size);
 		return NULL;
 	}
@@ -2174,12 +2172,11 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	remote = &slot_zero->master;
 
 	if (local->initialised) {
-		vchiq_loud_error_header();
 		if (remote->initialised)
-			vchiq_loud_error("local state has already been initialised");
+			dev_err(dev, "local state has already been initialised\n");
 		else
-			vchiq_loud_error("master/slave mismatch two slaves");
-		vchiq_loud_error_footer();
+			dev_err(dev, "master/slave mismatch two slaves\n");
+
 		return -EINVAL;
 	}
 
@@ -2257,9 +2254,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	state->slot_handler_thread = kthread_create(&slot_handler_func, (void *)state, threadname);
 
 	if (IS_ERR(state->slot_handler_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "couldn't create thread %s\n", threadname);
 		return PTR_ERR(state->slot_handler_thread);
 	}
 	set_user_nice(state->slot_handler_thread, -19);
@@ -2267,9 +2262,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	snprintf(threadname, sizeof(threadname), "vchiq-recy/%d", state->id);
 	state->recycle_thread = kthread_create(&recycle_func, (void *)state, threadname);
 	if (IS_ERR(state->recycle_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "couldn't create thread %s\n", threadname);
 		ret = PTR_ERR(state->recycle_thread);
 		goto fail_free_handler_thread;
 	}
@@ -2278,9 +2271,7 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, s
 	snprintf(threadname, sizeof(threadname), "vchiq-sync/%d", state->id);
 	state->sync_thread = kthread_create(&sync_func, (void *)state, threadname);
 	if (IS_ERR(state->sync_thread)) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("couldn't create thread %s", threadname);
-		vchiq_loud_error_footer();
+		dev_err(state->dev, "couldn't create thread %s\n", threadname);
 		ret = PTR_ERR(state->sync_thread);
 		goto fail_free_recycle_thread;
 	}
@@ -2353,10 +2344,11 @@ struct vchiq_header *vchiq_msg_hold(struct vchiq_instance *instance, unsigned in
 }
 EXPORT_SYMBOL(vchiq_msg_hold);
 
-static int vchiq_validate_params(const struct vchiq_service_params_kernel *params)
+static int vchiq_validate_params(struct vchiq_state *state,
+				 const struct vchiq_service_params_kernel *params)
 {
 	if (!params->callback || !params->fourcc) {
-		vchiq_loud_error("Can't add service, invalid params\n");
+		dev_err(state->dev, "Can't add service, invalid params\n");
 		return -EINVAL;
 	}
 
@@ -2376,7 +2368,7 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	int ret;
 	int i;
 
-	ret = vchiq_validate_params(params);
+	ret = vchiq_validate_params(state, params);
 	if (ret)
 		return NULL;
 
@@ -2525,7 +2517,7 @@ vchiq_open_service_internal(struct vchiq_service *service, int client_id)
 	} else if ((service->srvstate != VCHIQ_SRVSTATE_OPEN) &&
 		   (service->srvstate != VCHIQ_SRVSTATE_OPENSYNC)) {
 		if (service->srvstate != VCHIQ_SRVSTATE_CLOSEWAIT)
-			vchiq_log_error(vchiq_core_log_level,
+			vchiq_log_error(service->state->dev, VCHIQ_CORE,
 					"%d: osi - srvstate = %s (ref %u)",
 					service->state->id,
 					srvstate_names[service->srvstate],
@@ -2589,7 +2581,7 @@ release_service_messages(struct vchiq_service *service)
 			}
 			pos += calc_stride(header->size);
 			if (pos > VCHIQ_SLOT_SIZE) {
-				vchiq_log_error(vchiq_core_log_level,
+				vchiq_log_error(state->dev, VCHIQ_CORE,
 						"fsi - pos %x: header %pK, msgid %x, header->msgid %x, header->size %x",
 						pos, header, msgid, header->msgid, header->size);
 				WARN(1, "invalid slot position\n");
@@ -2645,8 +2637,8 @@ close_service_complete(struct vchiq_service *service, int failstate)
 	case VCHIQ_SRVSTATE_LISTENING:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%s(%x) called in state %s", __func__,
-				service->handle, srvstate_names[service->srvstate]);
+		vchiq_log_error(service->state->dev, VCHIQ_CORE, "%s(%x) called in state %s",
+				__func__, service->handle, srvstate_names[service->srvstate]);
 		WARN(1, "%s in unexpected state\n", __func__);
 		return -EINVAL;
 	}
@@ -2701,7 +2693,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	case VCHIQ_SRVSTATE_LISTENING:
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		if (close_recvd) {
-			vchiq_log_error(vchiq_core_log_level, "%s(1) called in state %s",
+			vchiq_log_error(state->dev, VCHIQ_CORE, "%s(1) called in state %s",
 					__func__, srvstate_names[service->srvstate]);
 		} else if (is_server) {
 			if (service->srvstate == VCHIQ_SRVSTATE_LISTENING) {
@@ -2789,7 +2781,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 		break;
 
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%s(%d) called in state %s", __func__,
+		vchiq_log_error(state->dev, VCHIQ_CORE, "%s(%d) called in state %s", __func__,
 				close_recvd, srvstate_names[service->srvstate]);
 		break;
 	}
@@ -2828,7 +2820,7 @@ vchiq_free_service_internal(struct vchiq_service *service)
 	case VCHIQ_SRVSTATE_CLOSEWAIT:
 		break;
 	default:
-		vchiq_log_error(vchiq_core_log_level, "%d: fsi - (%d) in state %s", state->id,
+		vchiq_log_error(state->dev, VCHIQ_CORE, "%d: fsi - (%d) in state %s", state->id,
 				service->localport, srvstate_names[service->srvstate]);
 		return;
 	}
@@ -3628,26 +3620,6 @@ int vchiq_dump_service_state(void *dump_context, struct vchiq_service *service)
 	return err;
 }
 
-void
-vchiq_loud_error_header(void)
-{
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level, "=====");
-}
-
-void
-vchiq_loud_error_footer(void)
-{
-	vchiq_log_error(vchiq_core_log_level, "=====");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-	vchiq_log_error(vchiq_core_log_level,
-			"============================================================================");
-}
-
 int vchiq_send_remote_use(struct vchiq_state *state)
 {
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index ec1a3caefaea..4e531a066e67 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -39,10 +39,30 @@
 
 #define VCHIQ_LOG_PREFIX   KERN_INFO "vchiq: "
 
+enum vchiq_log_category {
+       VCHIQ_ARM,
+       VCHIQ_CORE,
+       VCHIQ_CORE_MSG,
+       VCHIQ_SYNC,
+       VCHIQ_SUSPEND,
+};
+
+static inline const char *log_category_str(enum vchiq_log_category c)
+{
+       static const char *strings[] = {
+               "vchiq_arm",
+               "vchiq_core",
+               "vchiq_core_msg",
+               "vchiq_sync",
+               "vchiq_suspend",
+       };
+
+       return strings[c];
+};
+
 #ifndef vchiq_log_error
-#define vchiq_log_error(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_ERROR) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
+#define vchiq_log_error(dev, cat, fmt, ...) \
+       dev_dbg(dev, "%s error: " fmt, log_category_str(cat), ##__VA_ARGS__);
 #endif
 #ifndef vchiq_log_warning
 #define vchiq_log_warning(cat, fmt, ...) \
@@ -60,9 +80,6 @@
 		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
 #endif
 
-#define vchiq_loud_error(...) \
-	vchiq_log_error(vchiq_core_log_level, "===== " __VA_ARGS__)
-
 #define VCHIQ_SLOT_MASK        (VCHIQ_SLOT_SIZE - 1)
 #define VCHIQ_SLOT_QUEUE_MASK  (VCHIQ_MAX_SLOTS_PER_SIDE - 1)
 #define VCHIQ_SLOT_ZERO_SLOTS  DIV_ROUND_UP(sizeof(struct vchiq_slot_zero), \
@@ -471,7 +488,7 @@ extern const char *
 get_conn_state_name(enum vchiq_connstate conn_state);
 
 extern struct vchiq_slot_zero *
-vchiq_init_slots(void *mem_base, int mem_size);
+vchiq_init_slots(struct device *dev, void *mem_base, int mem_size);
 
 extern int
 vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero, struct device *dev);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index 841e1a535642..c89dc6d82fd2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -271,7 +271,7 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 			ret = -EFAULT;
 		}
 	} else {
-		vchiq_log_error(vchiq_arm_log_level,
+		vchiq_log_error(service->state->dev, VCHIQ_ARM,
 				"header %pK: bufsize %x < size %x",
 				header, args->bufsize, header->size);
 		WARN(1, "invalid size\n");
@@ -318,7 +318,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		}
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
 		if (!waiter) {
-			vchiq_log_error(vchiq_arm_log_level,
+			vchiq_log_error(service->state->dev, VCHIQ_ARM,
 					"no bulk_waiter found for pid %d", current->pid);
 			ret = -ESRCH;
 			goto out;
@@ -501,7 +501,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 			msglen = header->size + sizeof(struct vchiq_header);
 			/* This must be a VCHIQ-style service */
 			if (args->msgbufsize < msglen) {
-				vchiq_log_error(vchiq_arm_log_level,
+				vchiq_log_error(service->state->dev, VCHIQ_ARM,
 						"header %pK: msgbufsize %x < msglen %x",
 						header, args->msgbufsize, msglen);
 						WARN(1, "invalid message size\n");
@@ -618,7 +618,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		rc = mutex_lock_killable(&instance->state->mutex);
 		if (rc) {
-			vchiq_log_error(vchiq_arm_log_level,
+			vchiq_log_error(instance->state->dev, VCHIQ_ARM,
 					"vchiq: connect: could not lock mutex for state %d: %d",
 					instance->state->id, rc);
 			ret = -EINTR;
@@ -630,7 +630,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (!status)
 			instance->connected = 1;
 		else
-			vchiq_log_error(vchiq_arm_log_level,
+			vchiq_log_error(instance->state->dev, VCHIQ_ARM,
 					"vchiq: could not connect: %d", status);
 		break;
 
@@ -700,7 +700,7 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				vchiq_use_service_internal(service) :
 				vchiq_release_service_internal(service);
 			if (ret) {
-				vchiq_log_error(vchiq_susp_log_level,
+				vchiq_log_error(service->state->dev, VCHIQ_SUSPEND,
 						"%s: cmd %s returned error %ld for service %c%c%c%c:%03d",
 						__func__, (cmd == VCHIQ_IOC_USE_SERVICE) ?
 						"VCHIQ_IOC_USE_SERVICE" :
@@ -1173,7 +1173,7 @@ static int vchiq_open(struct inode *inode, struct file *file)
 	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
 
 	if (!state) {
-		vchiq_log_error(vchiq_arm_log_level,
+		vchiq_log_error(state->dev, VCHIQ_ARM,
 				"vchiq has no connection to VideoCore");
 		return -ENOTCONN;
 	}
-- 
2.40.1

