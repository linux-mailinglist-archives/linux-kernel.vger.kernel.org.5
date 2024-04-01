Return-Path: <linux-kernel+bounces-126611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B708D893A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE01F21253
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2597122606;
	Mon,  1 Apr 2024 10:50:43 +0000 (UTC)
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5EF1F600;
	Mon,  1 Apr 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968642; cv=none; b=j9AcSGHVnG3TB9877vFXooibsiAFJtdWzSAQ72QckQnW6GALBKa3SSB+g32QvZh9lNk6lk1II10DTl2ThgMsNzBErhtIBViJJhIiznf47lEGRLzWKkA9maCH+OXlQ3z8xulAZksN7AlFSWqF/2DEZxCBmdLvnhq5P4AZeE0Sq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968642; c=relaxed/simple;
	bh=gYLX9Ffik6L9xSbSu1xsQZRwiKfxq0sOMo2fjhM5Tis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeXqSDgx0yRNs6iNFCX+KEPEQW2DTdtFmwgTi5h4MHE5xYxXcPI5oRUWKbnAt//tw08j4QtmTLq55UCMRr7hJGpXI5IYrDUhq7yETEih8HqeOyDeX0gft99e3YDJMwkKXCqUZ/+CN48TTdselDl/AdTqGHW2ioo3QmqI1tlZZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 431AoOrp027688;
	Mon, 1 Apr 2024 05:50:24 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 431AoORd027686;
	Mon, 1 Apr 2024 05:50:24 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v3 08/12] Add security event description export facility.
Date: Mon,  1 Apr 2024 05:50:11 -0500
Message-Id: <20240401105015.27614-9-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240401105015.27614-1-greg@enjellic.com>
References: <20240401105015.27614-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. Greg" <greg@enjellic.com>

The functionality for surfacing security model events to an
external modeling domain is implemented in the export.c file.

ASCII descriptions of the events are presented to a userspace
trust orchestrator through the following pseudo-files:

/sys/kernel/security/tsem/external_tma/N

Where N is replaced with security namespace identifier.  This
identifier is a 64-bit integer value incremented each time a
namespace is created

The following event types are exported:

export_event

async_event

aggregate_event

log_event

An export_event is used to surface the JSON encoded description
of a security event to the trust orchestrator responsible for
managing the security modeling namespace.

The async_event is identical to an export_event but the alternate
definition is used to indicate to the trust orchestrator that the
process that generated the event is running in atomic context.

The aggregate_event is used to provide the hardware platform
measurement value to the trust orchestrator for integration into
the security model by the associated trusted modeling agent.

A log_event is used to provide descriptions of security events
that are invoked by untrusted processes.

The /sys/kernel/security/tsem/external_tma/N pseudo-files
implement a pollable interface that the trust orchestrators can
use to wait on events.  After placing the event description into
the device queue a process that is not running in atomic context
is placed in an interruptible sleep state.

After the TMA completes modeling of the event, the trust
orchestrator is responsible for using the TSEM control plane to
wake the process that exported the event and set its status to
either trusted or untrusted.

Security modeling namespaces, including the root modeling
namespace, can be configured to run in export only mode.  In this
mode the security event descriptions are asynchronously exported
to the trust orchestrator for driving applications such as
machine learning models or other Host Intrusion Detection
schemes.
---
 security/tsem/export.c | 432 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 432 insertions(+)
 create mode 100644 security/tsem/export.c

diff --git a/security/tsem/export.c b/security/tsem/export.c
new file mode 100644
index 000000000000..d104c31d2931
--- /dev/null
+++ b/security/tsem/export.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * This file implements the export of security relevant events to
+ * an external trust orchestrator.  The primary TSEM security
+ * documentation describes the types of events that are exported.
+ *
+ * The structures used to export each event are provided either by the
+ * kmem_cache implementation maintained in this file or from a
+ * magazine of structures that are maintained for events that are
+ * running in atomic context.
+ *
+ * The events are exported through the following control plane file:
+ *
+ * /sys/kernel/security/tsem/external_tma/N
+ *
+ * Where N is a filename consisting of the context identifier of the
+ * security modeling namespace that generated the event.
+ *
+ * A description of the security relevant event being exported is
+ * encoded in JSON format.  The TSEM ABI documentation has a
+ * description of the encoding that is used.
+ *
+ * For export events that describe a security event the JSON encoding
+ * of the event description is provided by the
+ * tsem_fs_show_trajectory() function.  This is the same function that
+ * is used to generate the security event descriptions for internally
+ * modeled namespaces.
+ *
+ * Processes that are generating security events in non-atomic context
+ * are put to sleep and placed on a wait queue to be scheduled back
+ * into execution by the external trust orchestrator after the event
+ * is modeled for conformance with the enforced security model.
+ *
+ * Processes running in atomic context export the event and continue
+ * to run.  A trust orchestrator is responsible for determing how to
+ * address a workload that generates a model violating event, either
+ * by shutting down the workload or generating a security alert via
+ * the trust orchestration
+ *
+ * Security modeling namespaces, including the root namespace, can
+ * also be configured for export only mode where the only purpose of
+ * the export event is to hand a description of the event to
+ * userspace.  This type of export is handled in the same manner as
+ * an event being modeled that is running in atomic context.
+ */
+
+#include <linux/seq_file.h>
+
+#include "tsem.h"
+
+enum export_type {
+	AGGREGATE_EVENT = 1,
+	EXPORT_EVENT,
+	EXPORT_ASYNC_EVENT,
+	LOG_EVENT
+};
+
+struct action_description {
+	enum export_type type;
+	enum tsem_action_type action;
+	char comm[TASK_COMM_LEN];
+};
+
+struct export_event {
+	struct list_head list;
+	enum export_type type;
+	union {
+		u8 *aggregate[HASH_MAX_DIGESTSIZE];
+		struct tsem_event *ep;
+		struct action_description action;
+	} u;
+};
+
+static const char * const tsem_actions[TSEM_ACTION_CNT] = {
+	"LOG",
+	"DENY"
+};
+
+static struct kmem_cache *export_cachep;
+
+static void refill_export_magazine(struct work_struct *work)
+{
+	struct export_event *exp;
+	struct tsem_external *ext;
+	struct tsem_work *ws;
+
+	ws = container_of(work, struct tsem_work, work);
+	ext = ws->u.ext;
+
+	exp = kmem_cache_zalloc(export_cachep, GFP_KERNEL);
+	if (!exp) {
+		pr_warn("tsem: Cannot refill event magazine.\n");
+		return;
+	}
+
+	spin_lock(&ws->u.ext->magazine_lock);
+	ws->u.ext->magazine[ws->index] = exp;
+	clear_bit(ws->index, ws->u.ext->magazine_index);
+
+	/*
+	 * The following memory barrier is used to cause the magazine
+	 * index to be visible after the refill of the cache slot.
+	 */
+	smp_mb__after_atomic();
+	spin_unlock(&ws->u.ext->magazine_lock);
+}
+
+static struct export_event *allocate_export(bool locked)
+{
+	unsigned int index;
+	struct export_event *exp = NULL;
+	struct tsem_external *ext = tsem_context(current)->external;
+
+	if (!locked)
+		return kmem_cache_zalloc(export_cachep, GFP_KERNEL);
+
+	spin_lock(&ext->magazine_lock);
+	index = find_first_zero_bit(ext->magazine_index, ext->magazine_size);
+	if (index < ext->magazine_size) {
+		exp = ext->magazine[index];
+		ext->ws[index].index = index;
+		ext->ws[index].u.ext = ext;
+		set_bit(index, ext->magazine_index);
+
+		/*
+		 * Similar to the issue noted in the refill_event_magazine()
+		 * function, this barrier is used to cause the consumption
+		 * of the cache entry to become visible.
+
+		 */
+		smp_mb__after_atomic();
+	}
+
+	spin_unlock(&ext->magazine_lock);
+
+	if (exp) {
+		INIT_WORK(&ext->ws[index].work, refill_export_magazine);
+		queue_work(system_highpri_wq, &ext->ws[index].work);
+		return exp;
+	}
+
+	pr_warn("tsem: Fail export allocation comm %s ns %llu cs %u.\n",
+		current->comm, tsem_context(current)->id, ext->magazine_size);
+	return NULL;
+}
+
+static void trigger_event(struct tsem_context *ctx)
+{
+	ctx->external->have_event = true;
+	wake_up_interruptible(&ctx->external->wq);
+}
+
+int tsem_export_show(struct seq_file *sf, void *v)
+{
+	bool locked = false;
+	struct export_event *exp = NULL;
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (!ctx->id && !ctx->external)
+		return -ENODATA;
+
+	spin_lock(&ctx->external->export_lock);
+	if (!list_empty(&ctx->external->export_list)) {
+		exp = list_first_entry(&ctx->external->export_list,
+				       struct export_event, list);
+		list_del(&exp->list);
+	}
+	spin_unlock(&ctx->external->export_lock);
+
+	if (!exp)
+		return -ENODATA;
+
+	seq_putc(sf, '{');
+	tsem_fs_show_field(sf, "export");
+
+	switch (exp->type) {
+	case AGGREGATE_EVENT:
+		tsem_fs_show_key(sf, "type", "}, ", "%s", "aggregate");
+		tsem_fs_show_field(sf, "aggregate");
+		tsem_fs_show_key(sf, "value", "}", "%*phN", tsem_digestsize(),
+				 exp->u.aggregate);
+		break;
+
+	case EXPORT_EVENT:
+		tsem_fs_show_key(sf, "type", "}, ", "%s", "event");
+		tsem_fs_show_trajectory(sf, exp->u.ep);
+		locked = exp->u.ep->locked;
+		tsem_event_put(exp->u.ep);
+		break;
+
+	case EXPORT_ASYNC_EVENT:
+		tsem_fs_show_key(sf, "type", "}, ", "%s", "async_event");
+		tsem_fs_show_trajectory(sf, exp->u.ep);
+		locked = exp->u.ep->locked;
+		tsem_event_put(exp->u.ep);
+		break;
+
+	case LOG_EVENT:
+		tsem_fs_show_key(sf, "type", "}, ", "%s", "log");
+		tsem_fs_show_field(sf, "log");
+		tsem_fs_show_key(sf, "process", ",", "%s", exp->u.action.comm);
+		tsem_fs_show_key(sf, "event", ",", "%s",
+				 tsem_names[exp->u.action.type]);
+		tsem_fs_show_key(sf, "action", "}", "%s",
+				 tsem_actions[exp->u.action.action]);
+		break;
+	}
+	seq_puts(sf, "}\n");
+
+	kmem_cache_free(export_cachep, exp);
+	return 0;
+}
+
+/**
+ * tsem_export_event() - Export a security event description.
+ * @event: The TSEM event type number for which the log event is being
+ *	   generated.
+ *
+ * This function queues for export to an external modeling agent a
+ * security event description.
+ *
+ * Return: This function returns 0 if the export was successful or
+ *	   an error value if it was not.
+ */
+int tsem_export_event(struct tsem_event *ep)
+{
+	int retn = 0;
+	struct tsem_task *task = tsem_task(current);
+	struct tsem_context *ctx = task->context;
+	struct export_event *exp;
+
+	exp = allocate_export(ep->locked);
+	if (!exp)
+		return -ENOMEM;
+
+	exp->type = ep->locked ? EXPORT_ASYNC_EVENT : EXPORT_EVENT;
+	exp->u.ep = ep;
+	tsem_event_get(ep);
+
+	spin_lock(&ctx->external->export_lock);
+	list_add_tail(&exp->list, &ctx->external->export_list);
+	spin_unlock(&ctx->external->export_lock);
+
+	if (ctx->external->export_only || ep->locked) {
+		trigger_event(ctx);
+		return 0;
+	}
+
+	task->trust_status |= TSEM_TASK_TRUST_PENDING;
+	trigger_event(ctx);
+
+	while (task->trust_status & TSEM_TASK_TRUST_PENDING) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		if (signal_pending(current)) {
+			if (sigismember(&current->pending.signal, SIGKILL) ||
+			    sigismember(&current->signal->shared_pending.signal,
+					SIGKILL))
+				task->trust_status = TSEM_TASK_UNTRUSTED;
+		}
+	}
+
+	return retn;
+}
+
+/**
+ * tsem_export_action() - Exports the action taken to a security violation.
+ * @event: The TSEM event type number for which the log event is being
+ *	   generated.
+ * @locked: A boolean flag indicating whether or not the security hook
+ *	    being reported on is called in atomic context.
+ *
+ * This function queues for export a description of an event that
+ * was being disciplined.
+ *
+ * Return: This function returns 0 if the export was successful or
+ *	   an error value if it was not.
+ */
+int tsem_export_action(enum tsem_event_type event, bool locked)
+{
+	struct tsem_context *ctx = tsem_context(current);
+	struct export_event *exp;
+
+	exp = allocate_export(locked);
+	if (!exp) {
+		pr_warn("tsem: domain %llu failed export allocation.\n",
+			ctx->id);
+		return -ENOMEM;
+	}
+
+	exp->type = LOG_EVENT;
+	exp->u.action.type = event;
+	exp->u.action.action = ctx->actions[event];
+	strscpy(exp->u.action.comm, current->comm, sizeof(exp->u.action.comm));
+
+	spin_lock(&ctx->external->export_lock);
+	list_add_tail(&exp->list, &ctx->external->export_list);
+	spin_unlock(&ctx->external->export_lock);
+
+	trigger_event(ctx);
+
+	return 0;
+}
+
+/**
+ * tsem_export_aggregate() - Exports the hardware aggregate value.
+ *
+ * This function exports the hardware aggregate measurement for
+ * the platform on which the TSEM LSM is being run on.
+ *
+ * Return: This function returns a value of 0 if the export was
+ *	   successful or a non-zero return value if the export was
+ *	   not successful.
+ */
+int tsem_export_aggregate(void)
+{
+	struct tsem_context *ctx = tsem_context(current);
+	struct export_event *exp;
+
+	exp = kmem_cache_zalloc(export_cachep, GFP_KERNEL);
+	if (!exp)
+		return -ENOMEM;
+
+	exp->type = AGGREGATE_EVENT;
+	memcpy(exp->u.aggregate, tsem_trust_aggregate(), tsem_digestsize());
+
+	spin_lock(&ctx->external->export_lock);
+	list_add_tail(&exp->list, &ctx->external->export_list);
+	spin_unlock(&ctx->external->export_lock);
+
+	trigger_event(ctx);
+
+	return 0;
+}
+
+/**
+ * tsem export_magazine_allocate() - Allocate a TSEM export magazine.
+ * @ctx: A pointer to the external modeling context that the magazine is
+ *	 to be allocated for.
+ * @size: The number of entries to be created in the magazine.
+
+ * The security event export magazine is an array of export_event
+ * structures that are used to service security hooks that are called
+ * in atomic context.  Each external modeling domain has a magazine
+ * allocated to it and this function allocates and initializes the
+ * memory structures needed to manage that magazine.
+
+ * Return: This function returns a value of zero on success and a negative
+ *	   error code on failure.
+ */
+int tsem_export_magazine_allocate(struct tsem_external *ext, size_t size)
+{
+	unsigned int lp;
+	int retn = -ENOMEM;
+
+	ext->magazine_size = size;
+
+	spin_lock_init(&ext->magazine_lock);
+
+	ext->magazine_index = bitmap_zalloc(ext->magazine_size, GFP_KERNEL);
+	if (!ext->magazine_index)
+		return retn;
+
+	ext->magazine = kcalloc(ext->magazine_size, sizeof(*ext->magazine),
+				GFP_KERNEL);
+	if (!ext->magazine)
+		goto done;
+
+	for (lp = 0; lp < ext->magazine_size; ++lp) {
+		ext->magazine[lp] = kmem_cache_zalloc(export_cachep,
+						      GFP_KERNEL);
+		if (!ext->magazine[lp])
+			goto done;
+	}
+
+	ext->ws = kcalloc(ext->magazine_size, sizeof(*ext->ws), GFP_KERNEL);
+	if (ext->ws)
+		retn = 0;
+
+ done:
+	if (retn)
+		tsem_export_magazine_free(ext);
+
+	return retn;
+}
+
+/**
+ * tsem export_magazine_free() - Releases a TSEM export magazine
+ * @ctx: A pointer to the external modeling context whose magazine is
+ *	 to be released.
+ *
+ * The function is used to free the memory that was allocated by
+ * the tsem_export_magazine_allocate() function for an extenral
+ * modeling context.
+ */
+void tsem_export_magazine_free(struct tsem_external *ext)
+{
+	unsigned int lp;
+
+	for (lp = 0; lp < ext->magazine_size; ++lp)
+		kmem_cache_free(export_cachep, ext->magazine[lp]);
+
+	bitmap_free(ext->magazine_index);
+	kfree(ext->ws);
+	kfree(ext->magazine);
+}
+
+/**
+ * tsem export_cache_init() - Initialize the TSEM export cache.
+ *
+ * This function is called by the TSEM initialization function and sets
+ * up a cache for export structures that are called by security event
+ * descriptions that are generated in atomix context
+ *
+ * Return: This function returns a value of zero on success and a negative
+ *	   error code on failure.
+ */
+int __init tsem_export_cache_init(void)
+{
+
+	export_cachep = kmem_cache_create("tsem_export_cache",
+					 sizeof(struct export_event), 0,
+					 SLAB_PANIC, 0);
+	if (!export_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
-- 
2.39.1


