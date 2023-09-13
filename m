Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1A79F17D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjIMS4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjIMS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:56:01 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4471BD9;
        Wed, 13 Sep 2023 11:55:52 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF959BEB;
        Wed, 13 Sep 2023 20:54:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694631259;
        bh=Gws1HLNugV+/ldC8Da4t8T2GOB1sE8I2MsTwU7I076s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7e3muyJdRpK4PMi+gubkzOygMtrp93hhdK6dtQf7Ve7cuM5TcJxvsMx7p3RRJ8Rm
         Rn4eZM1orC7LL0E9LrjXnMdgWkf8q4Jp/UXpTLVJ/2hEFljXEIUbyceTAmOgTs5QiR
         DcjjCQjuNpfo6sua8fNxuwEqFRbSFK5VAJYcOjTo=
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
Subject: [RFC PATCH v2 3/4] staging: vc04: Convert vchiq_log_info() to use dynamic debug
Date:   Thu, 14 Sep 2023 00:25:27 +0530
Message-Id: <20230913185528.770634-4-umang.jain@ideasonboard.com>
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
converts vchiq_log_info() wrapper to use dynamic debug.
The log category is dictated by enum vchiq_log_category
which will become the part of the warning string format that
will be logged to dynamic debug (for grep).

All the vchiq_log_info() calls are adjusted to use the
modified wrapper.

The existing custom logging for vchiq_log_info() tries
to log trace messages using SRVTRACE_LEVEL, which has been
removed in this patch. For now, those messages will be logged
to vchiq_log_info() but perhaps, should be using vchiq_log_trace()
down the line. (Marking as TODO for comments)

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 28 +++++---
 .../interface/vchiq_arm/vchiq_core.c          | 67 ++++++++++---------
 .../interface/vchiq_arm/vchiq_core.h          |  5 +-
 .../interface/vchiq_arm/vchiq_dev.c           | 23 ++++---
 4 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index bac3c324b6be..a7da2f15d5d4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -307,7 +307,7 @@ create_pagelist(struct vchiq_instance *instance, char *buf, char __user *ubuf,
 						   type == PAGELIST_READ, pages);
 
 		if (actual_pages != num_pages) {
-			vchiq_log_info(vchiq_arm_log_level,
+			vchiq_log_info(instance->state->dev, VCHIQ_ARM,
 				       "%s - only %d/%d pages locked",
 				       __func__, actual_pages, num_pages);
 
@@ -552,7 +552,7 @@ static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state
 		return -ENXIO;
 	}
 
-	vchiq_log_info(vchiq_arm_log_level, "vchiq_init - done (slots %pK, phys %pad)",
+	vchiq_log_info(&pdev->dev, VCHIQ_ARM, "vchiq_init - done (slots %pK, phys %pad)",
 		       vchiq_slot_zero, &slot_phys);
 
 	vchiq_call_connected_callbacks();
@@ -722,7 +722,8 @@ void free_bulk_waiter(struct vchiq_instance *instance)
 	list_for_each_entry_safe(waiter, next,
 				 &instance->bulk_waiter_list, list) {
 		list_del(&waiter->list);
-		vchiq_log_info(vchiq_arm_log_level, "bulk_waiter - cleaned up %pK for pid %d",
+		vchiq_log_info(instance->state->dev, VCHIQ_ARM,
+			       "bulk_waiter - cleaned up %pK for pid %d",
 			       waiter, waiter->pid);
 		kfree(waiter);
 	}
@@ -983,7 +984,8 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level, "saved bulk_waiter %pK for pid %d", waiter,
+		vchiq_log_info(instance->state->dev, VCHIQ_ARM,
+			       "saved bulk_waiter %pK for pid %d", waiter,
 			       current->pid);
 	}
 
@@ -1007,10 +1009,12 @@ add_completion(struct vchiq_instance *instance, enum vchiq_reason reason,
 		vchiq_log_trace(vchiq_arm_log_level, "%s - completion queue full", __func__);
 		DEBUG_COUNT(COMPLETION_QUEUE_FULL_COUNT);
 		if (wait_for_completion_interruptible(&instance->remove_event)) {
-			vchiq_log_info(vchiq_arm_log_level, "service_callback interrupted");
+			vchiq_log_info(instance->state->dev, VCHIQ_ARM,
+				       "service_callback interrupted");
 			return -EAGAIN;
 		} else if (instance->closing) {
-			vchiq_log_info(vchiq_arm_log_level, "service_callback closing");
+			vchiq_log_info(instance->state->dev, VCHIQ_ARM,
+				       "service_callback closing");
 			return 0;
 		}
 		DEBUG_TRACE(SERVICE_CALLBACK_LINE);
@@ -1112,7 +1116,7 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 				instance->completion_remove) < 0) {
 				int status;
 
-				vchiq_log_info(vchiq_arm_log_level,
+				vchiq_log_info(instance->state->dev, VCHIQ_ARM,
 					       "Inserting extra MESSAGE_AVAILABLE");
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				status = add_completion(instance, reason, NULL, user_service,
@@ -1126,12 +1130,14 @@ service_callback(struct vchiq_instance *instance, enum vchiq_reason reason,
 
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			if (wait_for_completion_interruptible(&user_service->remove_event)) {
-				vchiq_log_info(vchiq_arm_log_level, "%s interrupted", __func__);
+				vchiq_log_info(instance->state->dev, VCHIQ_ARM,
+					       "%s interrupted", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
 				return -EAGAIN;
 			} else if (instance->closing) {
-				vchiq_log_info(vchiq_arm_log_level, "%s closing", __func__);
+				vchiq_log_info(instance->state->dev, VCHIQ_ARM,
+					       "%s closing", __func__);
 				DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 				vchiq_service_put(service);
 				return -EINVAL;
@@ -1741,7 +1747,7 @@ void vchiq_platform_conn_state_changed(struct vchiq_state *state,
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
 	char threadname[16];
 
-	vchiq_log_info(vchiq_susp_log_level, "%d: %s->%s", state->id,
+	vchiq_log_info(state->dev, VCHIQ_SUSPEND, "%d: %s->%s", state->id,
 		       get_conn_state_name(oldstate), get_conn_state_name(newstate));
 	if (state->conn_state != VCHIQ_CONNSTATE_CONNECTED)
 		return;
@@ -1829,7 +1835,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 	vchiq_debugfs_init();
 
-	vchiq_log_info(vchiq_arm_log_level,
+	vchiq_log_info(&pdev->dev, VCHIQ_ARM,
 		       "vchiq: platform initialised - version %d (min %d)",
 		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index d25733fa296d..2e92853b9a4b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -103,8 +103,6 @@ static_assert((unsigned int)VCHIQ_PORT_MAX <
 
 #define BULK_INDEX(x) ((x) & (VCHIQ_NUM_SERVICE_BULKS - 1))
 
-#define SRVTRACE_LEVEL(srv) \
-	(((srv) && (srv)->trace) ? VCHIQ_LOG_TRACE : vchiq_core_msg_log_level)
 #define SRVTRACE_ENABLED(srv, lev) \
 	(((srv) && (srv)->trace) || (vchiq_core_msg_log_level >= (lev)))
 
@@ -227,7 +225,7 @@ static const char *msg_type_str(unsigned int msg_type)
 static inline void
 set_service_state(struct vchiq_service *service, int newstate)
 {
-	vchiq_log_info(vchiq_core_log_level, "%d: srv:%d %s->%s",
+	vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: srv:%d %s->%s",
 		       service->state->id, service->localport,
 		       srvstate_names[service->srvstate],
 		       srvstate_names[newstate]);
@@ -255,7 +253,7 @@ find_service_by_handle(struct vchiq_instance *instance, unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
+	vchiq_log_info(service->state->dev, VCHIQ_CORE,
 		       "Invalid service handle 0x%x", handle);
 	return NULL;
 }
@@ -276,7 +274,7 @@ find_service_by_port(struct vchiq_state *state, unsigned int localport)
 		}
 		rcu_read_unlock();
 	}
-	vchiq_log_info(vchiq_core_log_level,
+	vchiq_log_info(state->dev, VCHIQ_CORE,
 		       "Invalid port %u", localport);
 	return NULL;
 }
@@ -297,7 +295,7 @@ find_service_for_instance(struct vchiq_instance *instance, unsigned int handle)
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
+	vchiq_log_info(service->state->dev, VCHIQ_CORE,
 		       "Invalid service handle 0x%x", handle);
 	return NULL;
 }
@@ -320,7 +318,7 @@ find_closed_service_for_instance(struct vchiq_instance *instance, unsigned int h
 		return service;
 	}
 	rcu_read_unlock();
-	vchiq_log_info(vchiq_core_log_level,
+	vchiq_log_info(service->state->dev, VCHIQ_CORE,
 		       "Invalid service handle 0x%x", handle);
 	return service;
 }
@@ -492,7 +490,7 @@ vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate)
 {
 	enum vchiq_connstate oldstate = state->conn_state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: %s->%s", state->id, conn_state_names[oldstate],
+	vchiq_log_info(state->dev, VCHIQ_CORE, "%d: %s->%s", state->id, conn_state_names[oldstate],
 		       conn_state_names[newstate]);
 	state->conn_state = newstate;
 	vchiq_platform_conn_state_changed(state, oldstate, newstate);
@@ -1033,7 +1031,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		int tx_end_index;
 		int slot_use_count;
 
-		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+		vchiq_log_info(state->dev, VCHIQ_CORE, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
 			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
 			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
@@ -1093,7 +1091,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 		VCHIQ_SERVICE_STATS_INC(service, ctrl_tx_count);
 		VCHIQ_SERVICE_STATS_ADD(service, ctrl_tx_bytes, size);
 	} else {
-		vchiq_log_info(vchiq_core_log_level, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
+		vchiq_log_info(state->dev, VCHIQ_CORE, "%d: qm %s@%pK,%zx (%d->%d)", state->id,
 			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
 			       VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 		if (size != 0) {
@@ -1123,7 +1121,8 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
-		vchiq_log_info(SRVTRACE_LEVEL(service),
+		/* TODO: Should be using vchiq_log_trace below? */
+		vchiq_log_info(service->state->dev, VCHIQ_CORE_MSG,
 			       "Sent Msg %s(%u) to %c%c%c%c s:%u d:%d len:%zu",
 			       msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
 			       VCHIQ_FOURCC_AS_4CHARS(svc_fourcc), VCHIQ_MSG_SRCPORT(msgid),
@@ -1182,7 +1181,7 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 					state->id, oldmsgid);
 	}
 
-	vchiq_log_info(vchiq_sync_log_level,
+	vchiq_log_info(state->dev, VCHIQ_SYNC,
 		       "%d: qms %s@%pK,%x (%d->%d)", state->id,
 		       msg_type_str(VCHIQ_MSG_TYPE(msgid)),
 		       header, size, VCHIQ_MSG_SRCPORT(msgid),
@@ -1278,7 +1277,7 @@ release_slot(struct vchiq_state *state, struct vchiq_slot_info *slot_info,
 			VCHIQ_SLOT_QUEUE_MASK] =
 			SLOT_INDEX_FROM_INFO(state, slot_info);
 		state->remote->slot_queue_recycle = slot_queue_recycle + 1;
-		vchiq_log_info(vchiq_core_log_level, "%d: %s %d - recycle->%x", state->id, __func__,
+		vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: %s %d - recycle->%x", state->id, __func__,
 			       SLOT_INDEX_FROM_INFO(state, slot_info),
 			       state->remote->slot_queue_recycle);
 
@@ -1397,7 +1396,7 @@ poll_services_of_group(struct vchiq_state *state, int group)
 
 		service_flags = atomic_xchg(&service->poll_flags, 0);
 		if (service_flags & BIT(VCHIQ_POLL_REMOVE)) {
-			vchiq_log_info(vchiq_core_log_level, "%d: ps - remove %d<->%d",
+			vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: ps - remove %d<->%d",
 				       state->id, service->localport,
 				       service->remoteport);
 
@@ -1411,7 +1410,7 @@ poll_services_of_group(struct vchiq_state *state, int group)
 			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_REMOVE);
 		} else if (service_flags & BIT(VCHIQ_POLL_TERMINATE)) {
-			vchiq_log_info(vchiq_core_log_level, "%d: ps - terminate %d<->%d",
+			vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: ps - terminate %d<->%d",
 				       state->id, service->localport, service->remoteport);
 			if (vchiq_close_service_internal(service, NO_CLOSE_RECVD))
 				request_poll(state, service, VCHIQ_POLL_TERMINATE);
@@ -1462,7 +1461,8 @@ abort_outstanding_bulks(struct vchiq_service *service,
 		if (queue->process != queue->local_insert) {
 			vchiq_complete_bulk(service->instance, bulk);
 
-			vchiq_log_info(SRVTRACE_LEVEL(service),
+			/* TODO: Should be using vchiq_log_trace below? */
+			vchiq_log_info(service->state->dev, VCHIQ_CORE_MSG,
 				       "%s %c%c%c%c d:%d ABORTED - tx len:%d, rx len:%d",
 				       is_tx ? "Send Bulk to" : "Recv Bulk from",
 				       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
@@ -1499,7 +1499,7 @@ parse_open(struct vchiq_state *state, struct vchiq_header *header)
 
 	payload = (struct vchiq_open_payload *)header->data;
 	fourcc = payload->fourcc;
-	vchiq_log_info(vchiq_core_log_level, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
+	vchiq_log_info(state->dev, VCHIQ_CORE, "%d: prs OPEN@%pK (%d->'%c%c%c%c')",
 		       state->id, header, localport, VCHIQ_FOURCC_AS_4CHARS(fourcc));
 
 	service = get_listening_service(state, fourcc);
@@ -1646,7 +1646,8 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		svc_fourcc = service
 			? service->base.fourcc
 			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
-		vchiq_log_info(SRVTRACE_LEVEL(service),
+		/* TODO: Should be using vchiq_log_trace below? */
+		vchiq_log_info(service->state->dev, VCHIQ_CORE_MSG,
 			       "Rcvd Msg %s(%u) from %c%c%c%c s:%d d:%d len:%d",
 			       msg_type_str(type), type, VCHIQ_FOURCC_AS_4CHARS(svc_fourcc),
 			       remoteport, localport, size);
@@ -1675,7 +1676,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 				header->data;
 			service->peer_version = payload->version;
 		}
-		vchiq_log_info(vchiq_core_log_level, "%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
+		vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: prs OPENACK@%pK,%x (%d->%d) v:%d",
 			       state->id, header, size, remoteport, localport,
 			       service->peer_version);
 		if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
@@ -1690,7 +1691,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 	case VCHIQ_MSG_CLOSE:
 		WARN_ON(size); /* There should be no data */
 
-		vchiq_log_info(vchiq_core_log_level, "%d: prs CLOSE@%pK (%d->%d)",
+		vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: prs CLOSE@%pK (%d->%d)",
 			       state->id, header, remoteport, localport);
 
 		mark_service_closing_internal(service, 1);
@@ -1698,12 +1699,12 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		if (vchiq_close_service_internal(service, CLOSE_RECVD) == -EAGAIN)
 			goto bail_not_ready;
 
-		vchiq_log_info(vchiq_core_log_level, "Close Service %c%c%c%c s:%u d:%d",
+		vchiq_log_info(service->state->dev, VCHIQ_CORE, "Close Service %c%c%c%c s:%u d:%d",
 			       VCHIQ_FOURCC_AS_4CHARS(service->base.fourcc),
 			       service->localport, service->remoteport);
 		break;
 	case VCHIQ_MSG_DATA:
-		vchiq_log_info(vchiq_core_log_level, "%d: prs DATA@%pK,%x (%d->%d)",
+		vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: prs DATA@%pK,%x (%d->%d)",
 			       state->id, header, size, remoteport, localport);
 
 		if ((service->remoteport == remoteport) &&
@@ -1723,7 +1724,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 		}
 		break;
 	case VCHIQ_MSG_CONNECT:
-		vchiq_log_info(vchiq_core_log_level, "%d: prs CONNECT@%pK", state->id, header);
+		vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: prs CONNECT@%pK", state->id, header);
 		state->version_common =	((struct vchiq_slot_zero *)
 					 state->slot_data)->version;
 		complete(&state->connect);
@@ -1775,7 +1776,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 			bulk->actual = *(int *)header->data;
 			queue->remote_insert++;
 
-			vchiq_log_info(vchiq_core_log_level, "%d: prs %s@%pK (%d->%d) %x@%pad",
+			vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: prs %s@%pK (%d->%d) %x@%pad",
 				       state->id, msg_type_str(type), header, remoteport, localport,
 				       bulk->actual, &bulk->data);
 
@@ -2074,7 +2075,7 @@ sync_func(void *v)
 					header->data;
 				service->peer_version = payload->version;
 			}
-			vchiq_log_info(vchiq_sync_log_level, "%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
+			vchiq_log_info(state->dev, VCHIQ_SYNC, "%d: sf OPENACK@%pK,%x (%d->%d) v:%d",
 				       state->id, header, size, remoteport, localport,
 				       service->peer_version);
 			if (service->srvstate == VCHIQ_SRVSTATE_OPENING) {
@@ -2478,7 +2479,7 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	/* Bring this service online */
 	set_service_state(service, srvstate);
 
-	vchiq_log_info(vchiq_core_msg_log_level, "%s Service %c%c%c%c SrcPort:%d",
+	vchiq_log_info(service->state->dev, VCHIQ_CORE_MSG, "%s Service %c%c%c%c SrcPort:%d",
 		       (srvstate == VCHIQ_SRVSTATE_OPENING) ? "Open" : "Add",
 		       VCHIQ_FOURCC_AS_4CHARS(params->fourcc), service->localport);
 
@@ -2576,7 +2577,7 @@ release_service_messages(struct vchiq_service *service)
 			int port = VCHIQ_MSG_DSTPORT(msgid);
 
 			if ((port == service->localport) && (msgid & VCHIQ_MSGID_CLAIMED)) {
-				vchiq_log_info(vchiq_core_log_level, "  fsi - hdr %pK", header);
+				vchiq_log_info(service->state->dev, VCHIQ_CORE, "  fsi - hdr %pK", header);
 				release_slot(state, slot_info, header, NULL);
 			}
 			pos += calc_stride(header->size);
@@ -2684,7 +2685,7 @@ vchiq_close_service_internal(struct vchiq_service *service, int close_recvd)
 	int close_id = MAKE_CLOSE(service->localport,
 				  VCHIQ_MSG_DSTPORT(service->remoteport));
 
-	vchiq_log_info(vchiq_core_log_level, "%d: csi:%d,%d (%s)", service->state->id,
+	vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: csi:%d,%d (%s)", service->state->id,
 		       service->localport, close_recvd, srvstate_names[service->srvstate]);
 
 	switch (service->srvstate) {
@@ -2795,7 +2796,7 @@ vchiq_terminate_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: tsi - (%d<->%d)", state->id,
+	vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: tsi - (%d<->%d)", state->id,
 		       service->localport, service->remoteport);
 
 	mark_service_closing(service);
@@ -2810,7 +2811,7 @@ vchiq_free_service_internal(struct vchiq_service *service)
 {
 	struct vchiq_state *state = service->state;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: fsi - (%d)", state->id, service->localport);
+	vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: fsi - (%d)", state->id, service->localport);
 
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPENING:
@@ -2890,7 +2891,7 @@ vchiq_close_service(struct vchiq_instance *instance, unsigned int handle)
 	if (!service)
 		return -EINVAL;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: close_service:%d",
+	vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: close_service:%d",
 		       service->state->id, service->localport);
 
 	if ((service->srvstate == VCHIQ_SRVSTATE_FREE) ||
@@ -2948,7 +2949,7 @@ vchiq_remove_service(struct vchiq_instance *instance, unsigned int handle)
 	if (!service)
 		return -EINVAL;
 
-	vchiq_log_info(vchiq_core_log_level, "%d: remove_service:%d",
+	vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: remove_service:%d",
 		       service->state->id, service->localport);
 
 	if (service->srvstate == VCHIQ_SRVSTATE_FREE) {
@@ -3092,7 +3093,7 @@ int vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int handle,
 	 */
 	wmb();
 
-	vchiq_log_info(vchiq_core_log_level, "%d: bt (%d->%d) %cx %x@%pad %pK",
+	vchiq_log_info(service->state->dev, VCHIQ_CORE, "%d: bt (%d->%d) %cx %x@%pad %pK",
 		       state->id, service->localport, service->remoteport,
 		       dir_char, size, &bulk->data, userdata);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index c7ae2efc33eb..07ce55afb6cf 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -69,9 +69,8 @@ static inline const char *log_category_str(enum vchiq_log_category c)
        dev_dbg(dev, "%s warning: " fmt, log_category_str(cat), ##__VA_ARGS__);
 #endif
 #ifndef vchiq_log_info
-#define vchiq_log_info(cat, fmt, ...) \
-	do { if (cat >= VCHIQ_LOG_INFO) \
-		printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
+#define vchiq_log_info(dev, cat, fmt, ...) \
+       dev_dbg(dev, "%s info: " fmt, log_category_str(cat), ##__VA_ARGS__);
 #endif
 #ifndef vchiq_log_trace
 #define vchiq_log_trace(cat, fmt, ...) \
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index c89dc6d82fd2..c525051f460e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -47,9 +47,9 @@ user_service_free(void *userdata)
 
 static void close_delivered(struct user_service *user_service)
 {
-	vchiq_log_info(vchiq_arm_log_level,
+	vchiq_log_info(user_service->service->state->dev, VCHIQ_ARM,
 		       "%s(handle=%x)",
-		       __func__, user_service->service->handle);
+			__func__, user_service->service->handle);
 
 	if (user_service->close_pending) {
 		/* Allow the underlying service to be culled */
@@ -235,7 +235,7 @@ static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
 			spin_unlock(&msg_queue_spinlock);
 			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
 			if (wait_for_completion_interruptible(&user_service->insert_event)) {
-				vchiq_log_info(vchiq_arm_log_level,
+				vchiq_log_info(service->state->dev, VCHIQ_ARM,
 					       "DEQUEUE_MESSAGE interrupted");
 				ret = -EINTR;
 				break;
@@ -323,7 +323,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 			ret = -ESRCH;
 			goto out;
 		}
-		vchiq_log_info(vchiq_arm_log_level,
+		vchiq_log_info(service->state->dev, VCHIQ_ARM,
 			       "found bulk_waiter %pK for pid %d", waiter, current->pid);
 		userdata = &waiter->bulk_waiter;
 	} else {
@@ -355,7 +355,7 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		mutex_lock(&instance->bulk_waiter_list_mutex);
 		list_add(&waiter->list, &instance->bulk_waiter_list);
 		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level,
+		vchiq_log_info(service->state->dev, VCHIQ_ARM,
 			       "saved bulk_waiter %pK for pid %d", waiter, current->pid);
 
 		ret = put_user(mode_waiting, mode);
@@ -455,7 +455,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
 		mutex_lock(&instance->completion_mutex);
 		if (rc) {
 			DEBUG_TRACE(AWAIT_COMPLETION_LINE);
-			vchiq_log_info(vchiq_arm_log_level,
+			vchiq_log_info(instance->state->dev, VCHIQ_ARM,
 				       "AWAIT_COMPLETION interrupted");
 			ret = -EINTR;
 			goto out;
@@ -868,16 +868,17 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			ret = -EINTR;
 	}
 
-	if (!status && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK))
-		vchiq_log_info(vchiq_arm_log_level,
+	if (!status && (ret < 0) && (ret != -EINTR) && (ret != -EWOULDBLOCK)) {
+		vchiq_log_info(service->state->dev, VCHIQ_ARM,
 			       "  ioctl instance %pK, cmd %s -> status %d, %ld",
 			       instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 			       ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
-	else
+	} else {
 		vchiq_log_trace(vchiq_arm_log_level,
 				"  ioctl instance %pK, cmd %s -> status %d, %ld",
 				instance, (_IOC_NR(cmd) <= VCHIQ_IOC_MAX) ?
 				ioctl_names[_IOC_NR(cmd)] : "<invalid>", status, ret);
+	}
 
 	return ret;
 }
@@ -1170,7 +1171,7 @@ static int vchiq_open(struct inode *inode, struct file *file)
 	struct vchiq_state *state = vchiq_get_state();
 	struct vchiq_instance *instance;
 
-	vchiq_log_info(vchiq_arm_log_level, "vchiq_open");
+	vchiq_log_info(state->dev, VCHIQ_ARM, "vchiq_open");
 
 	if (!state) {
 		vchiq_log_error(state->dev, VCHIQ_ARM,
@@ -1206,7 +1207,7 @@ static int vchiq_release(struct inode *inode, struct file *file)
 	int ret = 0;
 	int i;
 
-	vchiq_log_info(vchiq_arm_log_level, "%s: instance=%lx", __func__,
+	vchiq_log_info(state->dev, VCHIQ_ARM, "%s: instance=%lx", __func__,
 		       (unsigned long)instance);
 
 	if (!state) {
-- 
2.40.1

