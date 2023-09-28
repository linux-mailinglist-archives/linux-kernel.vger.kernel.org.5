Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511287B17A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjI1Jju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjI1JjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0079CDD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso10917499f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893941; x=1696498741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjqSRzwtcmbZCSdKBG680ING+E16TFEDXl3yu9hsx/4=;
        b=C8M0DdeXPslPvE2nDGk1T6oVddJq0OD10kcrqDGNu7AEzn3VKwgw/N2JL8t2Oazj60
         DYz0MAh1+2PoNkVNK3IuowcCZ3+nAUi9jvLlVQM0r7zsOb5CqxRcaJTjKYEADq37DNeS
         lf0ly9rWlXyHxvqRiUuVAW0mPvwoRLSqc6nuYDYk8qBPBqWDTVft0e2Xsz0+1K1MllFq
         8wtJlqyoC6+mcjhHiKx7Dc4DDEsTMPdMgxR/nEmVEzO+LCpOtCWFkx84vtgnHBlSHV+x
         w9lGMMf57GBh5lVof3OxqQqyQJQqERyhZxelnkSB/HZWZcnGSzCizQABp/wjTVrVdh6G
         nsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893941; x=1696498741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjqSRzwtcmbZCSdKBG680ING+E16TFEDXl3yu9hsx/4=;
        b=Vh2BTS6BjnCPMXgYbsT+IGauTnc4Cv2UiILKuZHruPo+5WKtdAeKeuUecWxnT0uEoi
         Khx0kfV28Z0xqcqjuIJlmggwKvPlE8oOQ44KKdIsbu5PPk8U+af0so4lDoKVL12KeNRR
         I6NupZHcZjMPWyt+wKBC1mqgtdOjQU2PnoFAjS1elhHTcEAwq+X4YfNP1XCtbS1qy53/
         6GwZYNlEG4oxhRl/NHSQzBf73Vm3ebYvueWCFzwk6ltvsTGuBJquQ1m/YDXXcvAxiybN
         qbuHfzNuzvZ3a/vNUmvP7ZdRPz8bmV00Jrd5653Hk1iRRrMPV2K5MKUILlSzIXdDjZFS
         ukew==
X-Gm-Message-State: AOJu0Yx8fNColeO6Kvq/PQjA/SSwVYSrjye88sexyvqsDAbfe9GQNZHW
        tn+7ot2MvEoCXQLs3t5KdQejNQ==
X-Google-Smtp-Source: AGHT+IGdEtds9yfynzz07vsuk4Ka5Y1yzotz4oFQqFgtVM7Pp6z4PO00hby8WHdz4jdco6WcaLK5Aw==
X-Received: by 2002:adf:dc90:0:b0:319:7134:a3cf with SMTP id r16-20020adfdc90000000b003197134a3cfmr617107wrj.31.1695893941024;
        Thu, 28 Sep 2023 02:39:01 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:39:00 -0700 (PDT)
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
Subject: [PATCH 2/5] drbd: Add new per-resource "worker" thread
Date:   Thu, 28 Sep 2023 11:38:49 +0200
Message-ID: <20230928093852.676786-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out-of-tree fixes folded in:
- drbd: allow to dequeue batches of work at a time (partial backport)
- drbd: Keep "worker" alive while resource exists
- Flush the work queue before stopping the worker thread

Originally-from: Andreas Gruenbacher <agruen@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h    |  4 +++
 drivers/block/drbd/drbd_main.c   |  5 ++++
 drivers/block/drbd/drbd_nl.c     |  2 +-
 drivers/block/drbd/drbd_sender.c | 46 ++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index a53e63af23f1..fe7e93a4dfa6 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -603,6 +603,9 @@ struct drbd_resource {
 	enum write_ordering_e write_ordering;
 
 	cpumask_var_t cpu_mask;
+
+	struct drbd_work_queue work;
+	struct drbd_thread worker;
 };
 
 struct drbd_thread_timing_details
@@ -1428,6 +1431,7 @@ extern void drbd_md_endio(struct bio *bio);
 extern void drbd_peer_request_endio(struct bio *bio);
 extern void drbd_request_endio(struct bio *bio);
 extern int drbd_sender(struct drbd_thread *thi);
+extern int drbd_worker(struct drbd_thread *thi);
 enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, int o_minor);
 void drbd_resync_after_changed(struct drbd_device *device);
 extern void drbd_start_resync(struct drbd_device *device, enum drbd_conns side);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a14c1e9ee327..bb5de1e1ca9f 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2329,6 +2329,8 @@ void drbd_free_resource(struct drbd_resource *resource)
 {
 	struct drbd_connection *connection, *tmp;
 
+	drbd_flush_workqueue(&resource->work);
+	drbd_thread_stop(&resource->worker);
 	for_each_connection_safe(connection, tmp, resource) {
 		list_del(&connection->connections);
 		drbd_debugfs_connection_cleanup(connection);
@@ -2564,6 +2566,9 @@ struct drbd_resource *drbd_create_resource(const char *name)
 	mutex_init(&resource->conf_update);
 	mutex_init(&resource->adm_mutex);
 	spin_lock_init(&resource->req_lock);
+	drbd_init_workqueue(&resource->work);
+	drbd_thread_init(resource, &resource->worker, drbd_worker, "worker");
+	drbd_thread_start(&resource->worker);
 	drbd_debugfs_resource_add(resource);
 	return resource;
 
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a5844819d1c3..9d9ced46f968 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1900,7 +1900,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	 */
 	wait_event(device->misc_wait, !atomic_read(&device->ap_pending_cnt) || drbd_suspended(device));
 	/* and for any other previously queued work */
-	drbd_flush_workqueue(&connection->sender_work);
+	drbd_flush_workqueue(&device->resource->work);
 
 	rv = _drbd_request_state(device, NS(disk, D_ATTACHING), CS_VERBOSE);
 	retcode = (enum drbd_ret_code)rv;
diff --git a/drivers/block/drbd/drbd_sender.c b/drivers/block/drbd/drbd_sender.c
index fcc8a43efdca..0c482d45a52a 100644
--- a/drivers/block/drbd/drbd_sender.c
+++ b/drivers/block/drbd/drbd_sender.c
@@ -2239,3 +2239,49 @@ int drbd_sender(struct drbd_thread *thi)
 
 	return 0;
 }
+
+int drbd_worker(struct drbd_thread *thi)
+{
+	LIST_HEAD(work_list);
+	struct drbd_resource *resource = thi->resource;
+	struct drbd_work *w;
+
+	while (get_t_state(thi) == RUNNING) {
+		drbd_thread_current_set_cpu(thi);
+
+		if (list_empty(&work_list)) {
+			wait_event_interruptible(resource->work.q_wait,
+				dequeue_work_batch(&resource->work, &work_list));
+		}
+
+		if (signal_pending(current)) {
+			flush_signals(current);
+			if (get_t_state(thi) == RUNNING) {
+				drbd_warn(resource, "Worker got an unexpected signal\n");
+				continue;
+			}
+			break;
+		}
+
+		if (get_t_state(thi) != RUNNING)
+			break;
+
+
+		while (!list_empty(&work_list)) {
+			w = list_first_entry(&work_list, struct drbd_work, list);
+			list_del_init(&w->list);
+			w->cb(w, 0);
+		}
+	}
+
+	do {
+		while (!list_empty(&work_list)) {
+			w = list_first_entry(&work_list, struct drbd_work, list);
+			list_del_init(&w->list);
+			w->cb(w, 1);
+		}
+		dequeue_work_batch(&resource->work, &work_list);
+	} while (!list_empty(&work_list));
+
+	return 0;
+}
-- 
2.41.0

