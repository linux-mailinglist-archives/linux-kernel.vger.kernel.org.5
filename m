Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE767B17A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjI1Jjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjI1JjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11551BB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so130799365e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893940; x=1696498740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Cc+2VEHzN0gMI8y9yXBlUhBR5rjsljwvYfnnw0yDtQ=;
        b=iKeQoNSH3WGg7Effj8D3FWRIoyQznedJwrhz+EXrZcDekHGkS+muP2ZWjqx2nQtzmR
         vgBoQRt1sHYc46jF042FBLrC6JLeJkrg8IZd2XDfoxKXnCH5WIP/odBX4Oe65v5B/goI
         y3895+U8su30ITl86UuSr/yCRIegukQVqRPtS8uny6awnIT9Ie7Kis20LWF/zxjadMWZ
         8krQc1ZJRH7BystIJAaLtaZblkrEpN6y67kWCU9UbluvHl08wKLmN/EgIiLkDuNZljSD
         ZpE7oUtVeEdZspOdWEEfZ6uN7mjRDWPOAtP9PHrl2i6TBKFzEJmsCF7ig+p5qU6ABgsP
         ZxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893940; x=1696498740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Cc+2VEHzN0gMI8y9yXBlUhBR5rjsljwvYfnnw0yDtQ=;
        b=gC0mb8FrRscKhToEJQMOZzrcM+kcQMGI8MgerP4S/Gp5e004VL35+5WG1b1vxeTLiz
         LqfHovOb9PR1yxNGeA43jAK0EEA2R5sf6aHXTYxdj9L5PU/Bs1FVoYgZy/V4h4XIiDEe
         OYWUzQ/Tiyn6HH8Js+4KleGwrddfCXagBACCd4uXWoHs8EQAMqeKjJeSfvfnwAkKt0OC
         ecXyiRdj+VjfOM2RASuYFduMXf92HyYmVW+y6vU9cQD0qBcckKG9g50P7npVY/2uKF8W
         BEkJtCmqr22IQ1auAPbGpZOTm/xwIK4fZtZam2vOSewZFSJSYETcmqCabFZT6AdUG/Cf
         JM7w==
X-Gm-Message-State: AOJu0YyK+JYttSaNb6FJ3naVUDYQ8TxE2uXpkxfu+Xg41x4YN+cYvRZc
        vH5LF1bTEsva+xUCe9REWI9z0g==
X-Google-Smtp-Source: AGHT+IFknNEfUixX3PQogMUw9mOrpiqCWyEZVq5mQjEtWqL1IBLZaQ8qOmr4WiiuSUiiNWsOBK2q/w==
X-Received: by 2002:a5d:64c6:0:b0:324:884a:5cd0 with SMTP id f6-20020a5d64c6000000b00324884a5cd0mr905273wri.47.1695893939636;
        Thu, 28 Sep 2023 02:38:59 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:38:59 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 1/5] drbd: Rename per-connection "worker" thread to "sender"
Date:   Thu, 28 Sep 2023 11:38:48 +0200
Message-ID: <20230928093852.676786-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile                    |  2 +-
 drivers/block/drbd/drbd_int.h                  | 10 +++++-----
 drivers/block/drbd/drbd_main.c                 | 16 ++++++++--------
 drivers/block/drbd/drbd_nl.c                   | 16 ++++++++--------
 drivers/block/drbd/drbd_req.c                  |  4 +++-
 .../drbd/{drbd_worker.c => drbd_sender.c}      | 18 +++++++++---------
 drivers/block/drbd/drbd_state.c                | 10 +++++-----
 7 files changed, 39 insertions(+), 37 deletions(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (99%)

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 67a8b352a1d5..cddece877b25 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
-drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
+drbd-y += drbd_sender.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nla.o
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a30a5ed811be..a53e63af23f1 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -665,7 +665,7 @@ struct drbd_connection {
 	/* empty member on older kernels without blk_start_plug() */
 	struct blk_plug receiver_plug;
 	struct drbd_thread receiver;
-	struct drbd_thread worker;
+	struct drbd_thread sender;
 	struct drbd_thread ack_receiver;
 	struct workqueue_struct *ack_sender;
 
@@ -1075,7 +1075,7 @@ extern int drbd_bitmap_io(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device);
-extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
+extern int drbd_bitmap_io_from_sender(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device);
@@ -1422,12 +1422,12 @@ extern void conn_try_outdate_peer_async(struct drbd_connection *connection);
 extern enum drbd_peer_state conn_khelper(struct drbd_connection *connection, char *cmd);
 extern int drbd_khelper(struct drbd_device *device, char *cmd);
 
-/* drbd_worker.c */
+/* drbd_sender.c */
 /* bi_end_io handlers */
 extern void drbd_md_endio(struct bio *bio);
 extern void drbd_peer_request_endio(struct bio *bio);
 extern void drbd_request_endio(struct bio *bio);
-extern int drbd_worker(struct drbd_thread *thi);
+extern int drbd_sender(struct drbd_thread *thi);
 enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, int o_minor);
 void drbd_resync_after_changed(struct drbd_device *device);
 extern void drbd_start_resync(struct drbd_device *device, enum drbd_conns side);
@@ -1912,7 +1912,7 @@ static inline void drbd_thread_restart_nowait(struct drbd_thread *thi)
  *  w_send_barrier
  *  _req_mod(req, QUEUE_FOR_NET_WRITE or QUEUE_FOR_NET_READ);
  *    it is much easier and equally valid to count what we queue for the
- *    worker, even before it actually was queued or send.
+ *    sender, even before it actually was queued or send.
  *    (drbd_make_request_common; recovery path on read io-error)
  * decreased:
  *  got_BarrierAck (respective tl_clear, tl_clear_barrier)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 6bc86106c7b2..a14c1e9ee327 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -279,7 +279,7 @@ void tl_restart(struct drbd_connection *connection, enum drbd_req_event what)
  *
  * This is called after the connection to the peer was lost. The storage covered
  * by the requests on the transfer gets marked as our of sync. Called from the
- * receiver thread and the worker thread.
+ * receiver thread and the sender thread.
  */
 void tl_clear(struct drbd_connection *connection)
 {
@@ -2533,7 +2533,7 @@ int set_resource_options(struct drbd_resource *resource, struct res_opts *res_op
 		for_each_connection_rcu(connection, resource) {
 			connection->receiver.reset_cpu_mask = 1;
 			connection->ack_receiver.reset_cpu_mask = 1;
-			connection->worker.reset_cpu_mask = 1;
+			connection->sender.reset_cpu_mask = 1;
 		}
 	}
 	err = 0;
@@ -2619,8 +2619,8 @@ struct drbd_connection *conn_create(const char *name, struct res_opts *res_opts)
 
 	drbd_thread_init(resource, &connection->receiver, drbd_receiver, "receiver");
 	connection->receiver.connection = connection;
-	drbd_thread_init(resource, &connection->worker, drbd_worker, "worker");
-	connection->worker.connection = connection;
+	drbd_thread_init(resource, &connection->sender, drbd_sender, "sender");
+	connection->sender.connection = connection;
 	drbd_thread_init(resource, &connection->ack_receiver, drbd_ack_receiver, "ack_recv");
 	connection->ack_receiver.connection = connection;
 
@@ -3497,7 +3497,7 @@ static int w_bitmap_io(struct drbd_work *w, int unused)
  *
  * While IO on the bitmap happens we freeze application IO thus we ensure
  * that drbd_set_out_of_sync() can not be called. This function MAY ONLY be
- * called from worker context. It MUST NOT be used while a previous such
+ * called from sender context. It MUST NOT be used while a previous such
  * work is still pending!
  *
  * Its worker function encloses the call of io_fn() by get_ldev() and
@@ -3509,7 +3509,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 			  char *why, enum bm_flag flags,
 			  struct drbd_peer_device *peer_device)
 {
-	D_ASSERT(device, current == peer_device->connection->worker.task);
+	D_ASSERT(device, current == peer_device->connection->sender.task);
 
 	D_ASSERT(device, !test_bit(BITMAP_IO_QUEUED, &device->flags));
 	D_ASSERT(device, !test_bit(BITMAP_IO, &device->flags));
@@ -3544,7 +3544,7 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
  * @flags:	Bitmap flags
  *
  * freezes application IO while that the actual IO operations runs. This
- * functions MAY NOT be called from worker context.
+ * functions MAY NOT be called from sender context.
  */
 int drbd_bitmap_io(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
@@ -3555,7 +3555,7 @@ int drbd_bitmap_io(struct drbd_device *device,
 	const bool do_suspend_io = flags & (BM_DONT_CLEAR|BM_DONT_SET|BM_DONT_TEST);
 	int rv;
 
-	D_ASSERT(device, current != first_peer_device(device)->connection->worker.task);
+	D_ASSERT(device, current != first_peer_device(device)->connection->sender.task);
 
 	if (do_suspend_io)
 		drbd_suspend_io(device);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d3538bd83fb3..a5844819d1c3 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -365,7 +365,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	struct sib_info sib;
 	int ret;
 
-	if (current == connection->worker.task)
+	if (current == connection->sender.task)
 		set_bit(CALLBACK_PENDING, &connection->flags);
 
 	snprintf(mb, 14, "minor-%d", device_to_minor(device));
@@ -394,7 +394,7 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	drbd_bcast_event(device, &sib);
 	notify_helper(NOTIFY_RESPONSE, device, connection, cmd, ret);
 
-	if (current == connection->worker.task)
+	if (current == connection->sender.task)
 		clear_bit(CALLBACK_PENDING, &connection->flags);
 
 	if (ret < 0) /* Ignore any ERRNOs we got. */
@@ -1349,14 +1349,14 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_ba
 	drbd_setup_queue_param(device, bdev, new, o);
 }
 
-/* Starts the worker thread */
+/* Starts the sender thread */
 static void conn_reconfig_start(struct drbd_connection *connection)
 {
-	drbd_thread_start(&connection->worker);
+	drbd_thread_start(&connection->sender);
 	drbd_flush_workqueue(&connection->sender_work);
 }
 
-/* if still unconfigured, stops worker again. */
+/* if still unconfigured, stops sender again. */
 static void conn_reconfig_done(struct drbd_connection *connection)
 {
 	bool stop_threads;
@@ -1368,7 +1368,7 @@ static void conn_reconfig_done(struct drbd_connection *connection)
 		/* ack_receiver thread and ack_sender workqueue are implicitly
 		 * stopped by receiver in conn_disconnect() */
 		drbd_thread_stop(&connection->receiver);
-		drbd_thread_stop(&connection->worker);
+		drbd_thread_stop(&connection->sender);
 	}
 }
 
@@ -4362,7 +4362,7 @@ static enum drbd_ret_code adm_del_minor(struct drbd_device *device)
 		/* If the state engine hasn't stopped the sender thread yet, we
 		 * need to flush the sender work queue before generating the
 		 * DESTROY events here. */
-		if (get_t_state(&connection->worker) == RUNNING)
+		if (get_t_state(&connection->sender) == RUNNING)
 			drbd_flush_workqueue(&connection->sender_work);
 
 		mutex_lock(&notification_mutex);
@@ -4424,7 +4424,7 @@ static int adm_del_resource(struct drbd_resource *resource)
 	/* Make sure all threads have actually stopped: state handling only
 	 * does drbd_thread_stop_nowait(). */
 	list_for_each_entry(connection, &resource->connections, connections)
-		drbd_thread_stop(&connection->worker);
+		drbd_thread_stop(&connection->sender);
 	synchronize_rcu();
 	drbd_free_resource(resource);
 	return NO_ERROR;
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 380e6584a4ee..cd56fd0f3b06 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -202,6 +202,7 @@ void drbd_req_complete(struct drbd_request *req, struct bio_and_error *m)
 	 *	not yet completed by the local io subsystem
 	 * these flags may get cleared in any order by
 	 *	the worker,
+	 *	the sender,
 	 *	the receiver,
 	 *	the bio_endio completion callbacks.
 	 */
@@ -717,7 +718,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 	case SEND_CANCELED:
 	case SEND_FAILED:
 		/* real cleanup will be done from tl_clear.  just update flags
-		 * so it is no longer marked as on the worker queue */
+		 * so it is no longer marked as on the sender queue
+		 */
 		mod_rq_state(req, m, RQ_NET_QUEUED, 0);
 		break;
 
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_sender.c
similarity index 99%
rename from drivers/block/drbd/drbd_worker.c
rename to drivers/block/drbd/drbd_sender.c
index 4352a50fbb3f..fcc8a43efdca 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_sender.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
-   drbd_worker.c
+   drbd_sender.c
 
    This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
 
@@ -865,7 +865,7 @@ int drbd_resync_finished(struct drbd_peer_device *peer_device)
 	 * resync LRU would be wrong. */
 	if (drbd_rs_del_all(device)) {
 		/* In case this is not possible now, most probably because
-		 * there are P_RS_DATA_REPLY Packets lingering on the worker's
+		 * there are P_RS_DATA_REPLY Packets lingering on the sender's
 		 * queue (or even the read operations for those packets
 		 * is not finished by now).   Retry in 100ms. */
 
@@ -1587,7 +1587,7 @@ static bool drbd_pause_after(struct drbd_device *device)
  * drbd_resume_next() - Resume resync on all devices that may resync now
  * @device:	DRBD device.
  *
- * Called from process context only (admin command and worker).
+ * Called from process context only (admin command and sender).
  */
 static bool drbd_resume_next(struct drbd_device *device)
 {
@@ -1783,8 +1783,8 @@ void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)
 		}
 	}
 
-	if (current == connection->worker.task) {
-		/* The worker should not sleep waiting for state_mutex,
+	if (current == connection->sender.task) {
+		/* The sender should not sleep waiting for state_mutex,
 		   that can take long */
 		if (!mutex_trylock(device->state_mutex)) {
 			set_bit(B_RS_H_DONE, &device->flags);
@@ -1977,7 +1977,7 @@ static void go_diskless(struct drbd_device *device)
 		 * while we detach.
 		 * Any modifications would not be expected anymore, though.
 		 */
-		if (drbd_bitmap_io_from_worker(device, drbd_bm_write,
+		if (drbd_bitmap_io_from_sender(device, drbd_bm_write,
 					"detach", BM_LOCKED_TEST_ALLOWED, peer_device)) {
 			if (test_bit(WAS_READ_ERROR, &device->flags)) {
 				drbd_md_set_flag(device, MDF_FULL_SYNC);
@@ -2142,7 +2142,7 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 			break;
 
 		/* drbd_send() may have called flush_signals() */
-		if (get_t_state(&connection->worker) != RUNNING)
+		if (get_t_state(&connection->sender) != RUNNING)
 			break;
 
 		schedule();
@@ -2167,7 +2167,7 @@ static void wait_for_work(struct drbd_connection *connection, struct list_head *
 	mutex_unlock(&connection->data.mutex);
 }
 
-int drbd_worker(struct drbd_thread *thi)
+int drbd_sender(struct drbd_thread *thi)
 {
 	struct drbd_connection *connection = thi->connection;
 	struct drbd_work *w = NULL;
@@ -2191,7 +2191,7 @@ int drbd_worker(struct drbd_thread *thi)
 		if (signal_pending(current)) {
 			flush_signals(current);
 			if (get_t_state(thi) == RUNNING) {
-				drbd_warn(connection, "Worker got an unexpected signal\n");
+				drbd_warn(connection, "Sender got an unexpected signal\n");
 				continue;
 			}
 			break;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 287a8d1d3f70..c623769abc1a 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -622,7 +622,7 @@ drbd_req_state(struct drbd_device *device, union drbd_state mask,
 	spin_unlock_irqrestore(&device->resource->req_lock, flags);
 
 	if (f & CS_WAIT_COMPLETE && rv == SS_SUCCESS) {
-		D_ASSERT(device, current != first_peer_device(device)->connection->worker.task);
+		D_ASSERT(device, current != first_peer_device(device)->connection->sender.task);
 		wait_for_completion(&done);
 	}
 
@@ -1519,14 +1519,14 @@ static void abw_start_sync(struct drbd_device *device, int rv)
 	}
 }
 
-int drbd_bitmap_io_from_worker(struct drbd_device *device,
+int drbd_bitmap_io_from_sender(struct drbd_device *device,
 		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device)
 {
 	int rv;
 
-	D_ASSERT(device, current == first_peer_device(device)->connection->worker.task);
+	D_ASSERT(device, current == first_peer_device(device)->connection->sender.task);
 
 	/* open coded non-blocking drbd_suspend_io(device); */
 	atomic_inc(&device->suspend_cnt);
@@ -1841,7 +1841,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			/* We may still be Primary ourselves.
 			 * No harm done if the bitmap still changes,
 			 * redirtied pages will follow later. */
-			drbd_bitmap_io_from_worker(device, &drbd_bm_write,
+			drbd_bitmap_io_from_sender(device, &drbd_bm_write,
 				"demote diskless peer", BM_LOCKED_SET_ALLOWED, peer_device);
 		put_ldev(device);
 	}
@@ -1853,7 +1853,7 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		device->state.conn <= C_CONNECTED && get_ldev(device)) {
 		/* No changes to the bitmap expected this time, so assert that,
 		 * even though no harm was done if it did change. */
-		drbd_bitmap_io_from_worker(device, &drbd_bm_write,
+		drbd_bitmap_io_from_sender(device, &drbd_bm_write,
 				"demote", BM_LOCKED_TEST_ALLOWED, peer_device);
 		put_ldev(device);
 	}
-- 
2.41.0

