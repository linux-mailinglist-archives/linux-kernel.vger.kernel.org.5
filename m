Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35A17F79F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjKXRAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjKXRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:00:20 -0500
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666B210C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:00:17 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700845216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWENQVeTzgUlxGLBDIpOkaJ8YTyPuR19yc5enxAnFIw=;
        b=Y89b0090oahW/UxVCcF6BkmwTPuu68hFa995OMYMDYfcq8LCEx3UtwuMuNYlcfZfEcA9fW
        Jujin1UGL0IJ5fMsZcq+bOcwCmQU5pcmjH9rGA+pVxVJ0GsaS+VOsVqYPB7VFglGsNcCzE
        EoVw9De+WKKzL3juazloK4Uw9Frg2ys=
From:   Sergei Shtepa <sergei.shtepa@linux.dev>
To:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH v6 08/11] blksnap: event queue from the difference storage
Date:   Fri, 24 Nov 2023 17:59:30 +0100
Message-Id: <20231124165933.27580-9-sergei.shtepa@linux.dev>
In-Reply-To: <20231124165933.27580-1-sergei.shtepa@linux.dev>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtepa <sergei.shtepa@veeam.com>

Events are used to immediately notify the user land of a change in the
snapshot state. For example, if an error occurred while snapshot holding
when reading data from the original block device or from the difference
storage.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/event_queue.c | 81 +++++++++++++++++++++++++++++
 drivers/block/blksnap/event_queue.h | 64 +++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h

diff --git a/drivers/block/blksnap/event_queue.c b/drivers/block/blksnap/event_queue.c
new file mode 100644
index 000000000000..2256167b631b
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-event_queue: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include "event_queue.h"
+
+void event_queue_init(struct event_queue *event_queue)
+{
+	INIT_LIST_HEAD(&event_queue->list);
+	spin_lock_init(&event_queue->lock);
+	init_waitqueue_head(&event_queue->wq_head);
+}
+
+void event_queue_done(struct event_queue *event_queue)
+{
+	struct event *event;
+
+	spin_lock(&event_queue->lock);
+	while (!list_empty(&event_queue->list)) {
+		event = list_first_entry(&event_queue->list, struct event,
+					 link);
+		list_del(&event->link);
+		event_free(event);
+	}
+	spin_unlock(&event_queue->lock);
+}
+
+int event_gen(struct event_queue *event_queue, gfp_t flags, int code,
+	      const void *data, int data_size)
+{
+	struct event *event;
+
+	event = kzalloc(sizeof(struct event) + data_size + 1, flags);
+	if (!event)
+		return -ENOMEM;
+
+	event->time = ktime_get();
+	event->code = code;
+	event->data_size = data_size;
+	memcpy(event->data, data, data_size);
+
+	pr_debug("Generate event: time=%lld code=%d data_size=%d\n",
+		 event->time, event->code, event->data_size);
+
+	spin_lock(&event_queue->lock);
+	list_add_tail(&event->link, &event_queue->list);
+	spin_unlock(&event_queue->lock);
+
+	wake_up(&event_queue->wq_head);
+	return 0;
+}
+
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms)
+{
+	int ret;
+
+	ret = wait_event_interruptible_timeout(event_queue->wq_head,
+				!list_empty(&event_queue->list), timeout_ms);
+	if (ret >= 0) {
+		struct event *event = ERR_PTR(-ENOENT);
+
+		spin_lock(&event_queue->lock);
+		if (!list_empty(&event_queue->list)) {
+			event = list_first_entry(&event_queue->list,
+						 struct event, link);
+			list_del(&event->link);
+		}
+		spin_unlock(&event_queue->lock);
+		return event;
+	}
+	if (ret == -ERESTARTSYS) {
+		pr_debug("event waiting interrupted\n");
+		return ERR_PTR(-EINTR);
+	}
+
+	pr_err("Failed to wait event. errno=%d\n", abs(ret));
+	return ERR_PTR(ret);
+}
diff --git a/drivers/block/blksnap/event_queue.h b/drivers/block/blksnap/event_queue.h
new file mode 100644
index 000000000000..c919eee3ed96
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_EVENT_QUEUE_H
+#define __BLKSNAP_EVENT_QUEUE_H
+
+#include <linux/types.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+/**
+ * struct event - An event to be passed to the user space.
+ * @link:
+ *	The list header allows to combine events from the queue.
+ * @time:
+ *	A timestamp indicates when an event occurred.
+ * @code:
+ *	Event code.
+ * @data_size:
+ *	The number of bytes in the event data array.
+ * @data:
+ *	An array of event data.
+ *
+ * Events can be different, so they contain different data. The size of the
+ * data array is not defined exactly, but it has limitations. The size of
+ * the event structure is limited by the PAGE_SIZE (4096 bytes).
+ */
+struct event {
+	struct list_head link;
+	ktime_t time;
+	int code;
+	int data_size;
+	char data[];
+};
+
+/**
+ * struct event_queue - A queue of &struct event.
+ * @list:
+ *	Linked list for storing events.
+ * @lock:
+ *	Spinlock allows to guarantee safety of the linked list.
+ * @wq_head:
+ *	A wait queue allows to put a user thread in a waiting state until
+ *	an event appears in the linked list.
+ */
+struct event_queue {
+	struct list_head list;
+	spinlock_t lock;
+	struct wait_queue_head wq_head;
+};
+
+void event_queue_init(struct event_queue *event_queue);
+void event_queue_done(struct event_queue *event_queue);
+
+int event_gen(struct event_queue *event_queue, gfp_t flags, int code,
+	      const void *data, int data_size);
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms);
+static inline void event_free(struct event *event)
+{
+	kfree(event);
+};
+#endif /* __BLKSNAP_EVENT_QUEUE_H */
-- 
2.20.1

