Return-Path: <linux-kernel+bounces-126610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FAF893A5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDCD281A37
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9622625;
	Mon,  1 Apr 2024 10:50:43 +0000 (UTC)
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC0171C9;
	Mon,  1 Apr 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968641; cv=none; b=ZuTJFGNlh6P46DytGRdIcTg6hd1QTb1DJfIhG6q9Wwbx7SmsUofgl0Md4K1hJzAvZZEi18ymLef3mzdToWEXm/BTkSjCtLdzJ6Z+iBFV7BjLvzOOKOVYXrFeaS2WEpXFH00HmfWOIhLPoE8BnGhtN1Ni6ZY2vSvKPTMWHI6LPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968641; c=relaxed/simple;
	bh=kgXVW9ub7g7KYo/GTh7WW56XJRiQ1/lEN+wcukIbHXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRjAlfOnZTBQtPUISv8T/dmQbcz3y0mmT7fdOX3AQ5ccFUj5EgjTZsodGvHb3kwnxw0TdzwdHHwwerb6io1g+f4z57sJyff3w11V9fxCzqYxdU1lf+9wih3qYJp+Eq7ZrSCghvcrzwYo36O7dkDQZvIZYXIAjYuCajjnTMINFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 431AoRPK027703;
	Mon, 1 Apr 2024 05:50:27 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 431AoQLY027701;
	Mon, 1 Apr 2024 05:50:26 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v3 11/12] Implement the internal Trusted Modeling Agent.
Date: Mon,  1 Apr 2024 05:50:14 -0500
Message-Id: <20240401105015.27614-12-greg@enjellic.com>
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

The model.c file is responsible for managing the security state
information for a security modeling namespace.  Important to note
is that the map.c file is responsible for generating the
coefficients and hence the implementation of the model.  The
model.c file maintains the state information and makes the
decision with respect to whether or not a presented event is
consistent with the model being enforced.

By default the TMA runs in free modeling mode where all security
coefficients and there associated descriptions are considered
valid and retained as the security execution trajectory for the
namespace.

The model implementation can be 'sealed' through the TSEM control
plane, a condition that causes any state points not registered in
the model to be considered a 'forensics' event.  The description
of such an event is added to the forensics execution trajectory
for the model.  A forensics event does not result in permission
to the event to be denied unless the model is placed in
'enforcing' mode.

The TMA implementation also supports the definition of 'base'
point that is binary value equal in length to the cryptographic
hash function being used by the security modeling namespace.
This base point is used to linear extend each security state
coefficient before it is added to the model.  This allows a
relying part to confirm the 'freshnes' of the functional state of
the model.

The modeling implementation supports two different functional
values for the model being implemented.  The classic linear
extension sum of all the security state points and a value
referred to as the 'state' of the security model.

The classic linear extension sum is similar to what would be
implemented by a Platform Configuration Register in a Trusted
Platform Module.  It can be used verify the order in which
security event occurred but is also fragile with respect to
process scheduling dependencies, particularly on SMP platforms.

The 'state' value is designed to make the measurement value
invariant to these scheduling induced variations.  The state
value is computed by sorting the security event state points in
the model in big-endian (natural hash byte order) format and then
computing the extension sum over this sorted vector of points.

This value verifies that the model has only existed in a
prescribed set of security states.
---
 security/tsem/model.c | 757 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 757 insertions(+)
 create mode 100644 security/tsem/model.c

diff --git a/security/tsem/model.c b/security/tsem/model.c
new file mode 100644
index 000000000000..1a969c5a0915
--- /dev/null
+++ b/security/tsem/model.c
@@ -0,0 +1,757 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2024 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+
+ * This file is responsible for maintaining the security model state
+ * information for the internal trusted modeling agent implementation.
+ *
+ * The state information consists of security event descriptions that
+ * have been experienced by a security modeling namespace and the
+ * security state coefficients that they map into.  Only unique
+ * descriptions and their coefficients are maintained for maintained
+ * for each security modeling namespace.
+ *
+ * An important point to note is that the routines in this file do not
+ * implement a security model.  The mapping of security event
+ * descriptions into coefficients, in the map.c file, is the
+ * functionality that actually implements the model.  Future
+ * implementations of TSEM are anticipated to provide alternate models
+ * by providing alternative implementations of the mapping routines.
+ *
+ * The generative functions used to create the security state
+ * coefficients managed by this file are fully described in the
+ * primary TSEM documentation file.
+ *
+ * As with the event.c and export.c files this file must handle events
+ * that run in both atomic and non-atomic context.  For processes that
+ * run in non-atomic context the structures that represent a security
+ * state coefficient are provided by the kmem_cache structure
+ * implement in this file.
+ *
+ * In order to support processes that are running in atomic context a
+ * magazine of structure is maintained as well.  Allocations from this
+ * magazine are replaced with a function that runs in the context of
+ * an asynchronous workqueue.
+ */
+
+#include <linux/sort.h>
+
+#include "tsem.h"
+
+struct pseudonym {
+	struct list_head list;
+	u8 mapping[HASH_MAX_DIGESTSIZE];
+};
+
+static struct kmem_cache *point_cachep;
+
+static void refill_point_magazine(struct work_struct *work)
+{
+	struct tsem_event_point *tep;
+	struct tsem_work *ws;
+
+	ws = container_of(work, struct tsem_work, work);
+
+	tep = kmem_cache_zalloc(point_cachep, GFP_KERNEL);
+	if (!tep) {
+		pr_warn("tsem: Cannot refill model point magazine.\n");
+		return;
+	}
+
+	spin_lock(&ws->u.model->magazine_lock);
+	ws->u.model->magazine[ws->index] = tep;
+	clear_bit(ws->index, ws->u.model->magazine_index);
+
+	/*
+	 * The following memory barrier is used to cause the magazine
+	 * index to be visible after the refill of the cache slot.
+	 */
+	smp_mb__after_atomic();
+
+	spin_unlock(&ws->u.model->magazine_lock);
+}
+
+static struct tsem_event_point *alloc_event_point(struct tsem_model *model,
+						  bool locked)
+{
+	unsigned int index;
+	struct tsem_event_point *tep = NULL;
+
+	if (!locked)
+		return kmem_cache_zalloc(point_cachep, GFP_KERNEL);
+
+	spin_lock(&model->magazine_lock);
+	index = find_first_zero_bit(model->magazine_index,
+				    model->magazine_size);
+	if (index < model->magazine_size) {
+		tep = model->magazine[index];
+		model->ws[index].index = index;
+		model->ws[index].u.model = model;
+		set_bit(index, model->magazine_index);
+
+		/*
+		 * Similar to the issue noted in the refill_point_magazine(),
+		 * function, this barrier is used to cause the consumption
+		 * of the cache entry to become visible.
+		 */
+		smp_mb__after_atomic();
+	}
+	spin_unlock(&model->magazine_lock);
+
+	if (tep) {
+		INIT_WORK(&model->ws[index].work, refill_point_magazine);
+		queue_work(system_wq, &model->ws[index].work);
+		return tep;
+	}
+
+	pr_warn("tsem: Fail model point allocation comm %s ns %llu cs %u.\n",
+		current->comm, tsem_context(current)->id,
+		model->magazine_size);
+	return NULL;
+
+}
+
+static int magazine_allocate(struct tsem_model *model, size_t size)
+{
+	unsigned int lp;
+	int retn = -ENOMEM;
+
+	model->magazine_size = size;
+
+	spin_lock_init(&model->magazine_lock);
+
+	model->magazine_index = bitmap_zalloc(model->magazine_size,
+					      GFP_KERNEL);
+	if (!model->magazine_index)
+		return retn;
+
+	model->magazine = kcalloc(model->magazine_size,
+				  sizeof(*model->magazine), GFP_KERNEL);
+	if (!model->magazine)
+		goto done;
+
+	for (lp = 0; lp < model->magazine_size; ++lp) {
+		model->magazine[lp] = kmem_cache_zalloc(point_cachep,
+							GFP_KERNEL);
+		if (!model->magazine[lp])
+			goto done;
+	}
+
+	model->ws = kcalloc(model->magazine_size, sizeof(*model->ws),
+			    GFP_KERNEL);
+	if (model->ws)
+		retn = 0;
+
+ done:
+	if (retn)
+		tsem_model_magazine_free(model);
+
+	return retn;
+}
+
+static int generate_pseudonym(char *pathname, u8 *pseudonym)
+{
+	int retn = 0;
+	u32 size;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	size = strlen(pathname);
+	retn = crypto_shash_update(shash, (u8 *) &size, sizeof(size));
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, pathname, size, pseudonym);
+
+ done:
+	return retn;
+}
+
+static struct tsem_event_point *have_point(u8 *point)
+{
+	struct tsem_event_point *entry, *retn = NULL;
+	struct tsem_context *ctx = tsem_context(current);
+	struct tsem_model *model = ctx->model;
+
+	spin_lock(&model->point_lock);
+	list_for_each_entry(entry, &model->point_list, list) {
+		if (!memcmp(entry->point, point, tsem_digestsize())) {
+			retn = entry;
+			goto done;
+		}
+	}
+
+ done:
+	spin_unlock(&model->point_lock);
+	return retn;
+}
+
+static struct tsem_event_point *add_event_point(u8 *point, bool valid,
+						bool locked)
+{
+	struct tsem_event_point *entry;
+	struct tsem_model *model = tsem_model(current);
+
+	entry = alloc_event_point(model, locked);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->valid = valid;
+	memcpy(entry->point, point, tsem_digestsize());
+
+	spin_lock(&model->point_lock);
+	++model->point_count;
+	list_add_tail(&entry->list, &model->point_list);
+	spin_unlock(&model->point_lock);
+
+	return entry;
+}
+
+static int add_trajectory_point(struct tsem_event *ep)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	ep->pid = 0;
+	tsem_event_get(ep);
+
+	spin_lock(&model->trajectory_lock);
+	list_add_tail(&ep->list, &model->trajectory_list);
+	spin_unlock(&model->trajectory_lock);
+
+	return 0;
+}
+
+static int add_forensic_point(struct tsem_event *ep)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	ep->pid = 0;
+	tsem_event_get(ep);
+
+	spin_lock(&model->forensics_lock);
+	list_add_tail(&ep->list, &model->forensics_list);
+	spin_unlock(&model->forensics_lock);
+
+	return 0;
+}
+
+static int get_host_measurement(u8 *id, u8 *digest)
+{
+	int retn;
+	struct tsem_model *model = tsem_model(current);
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, model->base, tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, id, tsem_digestsize(), digest);
+
+ done:
+	return retn;
+}
+
+static int update_events_measurement(struct tsem_event *ep)
+{
+	int retn;
+	u8 digest[HASH_MAX_DIGESTSIZE];
+	struct tsem_context *ctx = tsem_context(current);
+	struct tsem_model *model = ctx->model;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	retn = get_host_measurement(ep->mapping, digest);
+	if (retn)
+		goto done;
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, model->measurement,
+				   tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, digest, tsem_digestsize(),
+				  model->measurement);
+	if (retn)
+		goto done;
+
+	if (!tsem_context(current)->id)
+		retn = tsem_trust_add_event(ep);
+
+ done:
+	return retn;
+}
+
+static int state_sort(const void *a, const void *b)
+{
+	unsigned int lp, retn = 0;
+	struct tsem_event_point *ap, *bp;
+
+	ap = *((struct tsem_event_point **) a);
+	bp = *((struct tsem_event_point **) b);
+
+	for (lp = 0; lp < tsem_digestsize(); ++lp) {
+		if (ap->point[lp] == bp->point[lp])
+			continue;
+
+		if (ap->point[lp] < bp->point[lp])
+			retn = -1;
+		else
+			retn = 1;
+		goto done;
+	}
+
+ done:
+	return retn;
+}
+
+/**
+ * tesm_model_compute_state() - Calculate a security model state value.
+ *
+ * The function generates the state value of the current modeling domain.
+ */
+void tsem_model_compute_state(void)
+{
+	u8 state[HASH_MAX_DIGESTSIZE];
+	int retn;
+	unsigned int lp, count, pt_count = 0;
+	struct list_head *end;
+	struct tsem_event_point *end_point, *entry, **points = NULL;
+	struct tsem_model *model = tsem_model(current);
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	memset(state, '\0', sizeof(state));
+	retn = crypto_shash_update(shash, state, tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = get_host_measurement(tsem_trust_aggregate(), state);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, state, tsem_digestsize(), state);
+	if (retn)
+		goto done;
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	count = model->point_count;
+	spin_unlock(&model->point_lock);
+
+	points = vmalloc(sizeof(*points) * count);
+	if (!points) {
+		retn = -ENOMEM;
+		goto done;
+	}
+
+	end_point = container_of(end, struct tsem_event_point, list);
+	list_for_each_entry(entry, &model->point_list, list) {
+		points[pt_count++] = entry;
+		if (end_point == entry)
+			break;
+	}
+	sort(points, count, sizeof(*points), state_sort, NULL);
+
+	memcpy(model->state, state, tsem_digestsize());
+	for (lp = 0; lp < pt_count; ++lp) {
+		entry = points[lp];
+
+		if (get_host_measurement(entry->point, state))
+			goto done;
+
+		if (crypto_shash_init(shash))
+			goto done;
+		if (crypto_shash_update(shash, model->state,
+					tsem_digestsize()))
+			goto done;
+		if (crypto_shash_finup(shash, state, tsem_digestsize(),
+				       model->state))
+			goto done;
+	}
+
+ done:
+	if (retn)
+		memset(model->state, '\0', tsem_digestsize());
+
+	vfree(points);
+}
+
+/**
+ * tsem_model_has_pseudonym() - Test for a model pseudonym.
+ * @tsip: A pointer to the TSEM inode security structure.
+ * @file: A pointer to the tsem_file_args structure characterizing the
+ *	  file whose pseudonym is to be checked.
+ *
+ * This function is used to test whether a pseudonym has been
+ * declared for a modeling domain.  It is up to the caller to
+ * populate the event description structure with a suitable
+ * value for the pseudonym digest.
+ *
+ * Return: If an error occurs during the pseudonym probe a negative
+ *	   return value is returned.  A zero return value indicates that
+ *	   a pseudonym was not present.  A value of one indicates that a
+ *	   pseudonym has been defined.
+ */
+int tsem_model_has_pseudonym(struct tsem_inode *tsip, char *pathname)
+{
+	int retn = 0;
+	u8 pseudo_mapping[HASH_MAX_DIGESTSIZE];
+	struct tsem_model *model = tsem_model(current);
+	struct pseudonym *entry;
+
+	retn = generate_pseudonym(pathname, pseudo_mapping);
+	if (retn)
+		goto done;
+
+	mutex_lock(&model->pseudonym_mutex);
+	list_for_each_entry(entry, &model->pseudonym_list, list) {
+		if (!memcmp(entry->mapping, pseudo_mapping,
+			    tsem_digestsize())) {
+			retn = 1;
+			goto done;
+		}
+	}
+	retn = 0;
+
+ done:
+	mutex_unlock(&model->pseudonym_mutex);
+	return retn;
+}
+
+/**
+ * tesm_model_event() - Inject a security event into a modeling domain.
+ * @ep: A pointer to the event description structure.
+ *
+ * This function is the entry point for the in kernel Trusted Modeling
+ * Agent (TMA).  It takes a description of an event encoded in a
+ * tsem_event structure and generates and updates the security model
+ * description.
+ *
+ * Return: If an error occurs during the injection of an event into a
+ *	   model a negative error value is returned.  A value of zero
+ *	   is returned if the event was successfully modeled.  The
+ *	   security status of the event is returned by encoding the value
+ *	   in the bad_COE member of the tsem_task structure.
+ */
+int tsem_model_event(struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_event_point *point;
+	struct tsem_task *task = tsem_task(current);
+	struct tsem_context *ctx = task->context;
+
+	retn = tsem_map_event(ep);
+	if (retn)
+		return retn;
+
+	point = have_point(ep->mapping);
+	if (point) {
+		++point->count;
+		if (!point->valid)
+			task->trust_status = TSEM_TASK_UNTRUSTED;
+		return 0;
+	}
+
+	retn = update_events_measurement(ep);
+	if (retn)
+		return retn;
+
+	retn = -ENOMEM;
+	if (ctx->sealed) {
+		point = add_event_point(ep->mapping, false, ep->locked);
+		if (point) {
+			retn = add_forensic_point(ep);
+			task->trust_status = TSEM_TASK_UNTRUSTED;
+		}
+	} else {
+		point = add_event_point(ep->mapping, true, ep->locked);
+		if (point)
+			retn = add_trajectory_point(ep);
+	}
+
+	if (!retn)
+		++point->count;
+	return retn;
+}
+
+/**
+ * tesm_model_load_point() - Load a security state event into a model.
+ * @point: A pointer to the array containing the security state
+ *	   point to be added to the model.
+ *
+ * This function takes the binary representation of a security state
+ * point and loads it into the current model domain.
+ *
+ * Return: If an error occurs during the processing of the security state
+ *	   point a negative return value is returned.  A return value of
+ *	   zero indicates the point was successfully loaded into the domain.
+ */
+int tsem_model_load_point(u8 *point)
+{
+	int retn = -ENOMEM;
+	struct tsem_event *ep;
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (have_point(point))
+		return 0;
+
+	if (!add_event_point(point, true, false))
+		return retn;
+
+	if (!ctx->model->have_aggregate) {
+		retn = tsem_model_add_aggregate();
+		if (retn)
+			return retn;
+
+		ctx->model->have_aggregate = true;
+	}
+
+	ep = tsem_event_allocate(0, false);
+	if (!ep)
+		return retn;
+
+	kref_init(&ep->kref);
+	memcpy(ep->mapping, point, tsem_digestsize());
+	retn = update_events_measurement(ep);
+
+	tsem_event_put(ep);
+	return retn;
+}
+
+/**
+ * tesm_model_load_pseudonym() - Load a pseudonym state point to a model.
+ * @mapping: A pointer to the array containing the pseudonym state
+ *	     point that is to be added to the model.
+ *
+ * This function takes the binary representation of a file pseudonym
+ * and declares the presence of the pseudonym in the modeling domain.
+ *
+ * Return: If an error occurs during the processing of the pseudonym
+ *	   state point a negative return value is returned.  A return
+ *	   value of zero indicates the point was successfully loaded
+ *	   into the model.
+ */
+int tsem_model_load_pseudonym(u8 *mapping)
+{
+	struct pseudonym *psp = NULL;
+	struct tsem_model *model = tsem_model(current);
+
+	psp = kzalloc(sizeof(*psp), GFP_KERNEL);
+	if (!psp)
+		return -ENOMEM;
+	memcpy(psp->mapping, mapping, tsem_digestsize());
+
+	mutex_lock(&model->pseudonym_mutex);
+	list_add_tail(&psp->list, &model->pseudonym_list);
+	mutex_unlock(&model->pseudonym_mutex);
+	return 0;
+}
+
+/**
+ * tesm_model_load_base() - Load a model base point.
+ * @mapping: A pointer to the array containing the base point to be
+ *	     set for the model.
+ *
+ * This function takes the binary representation of a base point and
+ * sets this point as the base point for the model.
+ */
+void tsem_model_load_base(u8 *mapping)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	memcpy(model->base, mapping, tsem_digestsize());
+}
+
+/**
+ * tesm_model_add_aggregate() - Add the hardware aggregate to a model.
+ *
+ * This function adds the hardware aggregate value to an internally
+ * modeled security domain.
+ *
+ * Return: If an error occurs during the injection of the aggregate
+ *	   value into the model a negative error value is returned.
+ *	   A return value of zero indicates the aggregate was
+ *	   successfully added.
+ */
+int tsem_model_add_aggregate(void)
+{
+	int retn;
+	struct tsem_event *ep;
+
+	ep = tsem_event_allocate(0, false);
+	if (!ep)
+		return -ENOMEM;
+
+	kref_init(&ep->kref);
+	ep->digestsize = tsem_digestsize();
+	memcpy(ep->mapping, tsem_trust_aggregate(), ep->digestsize);
+
+	retn = update_events_measurement(ep);
+	tsem_event_put(ep);
+
+	return retn;
+}
+
+/**
+ * tsem_model_allocate() - Allocates a kernel TMA modeling structure.
+ * @size: The number of slots in the event point magazine for the model.
+ *
+ * This function allocates and initializes a tsem_model structure
+ * that is used to hold modeling information for an in kernel
+ * modeling domain.
+ *
+ * Return: On success a pointer to the model description structure is
+ *	   returned.  If an error occurs an error return value is
+ *	   encoded in the returned pointer.
+ */
+struct tsem_model *tsem_model_allocate(size_t size)
+{
+	struct tsem_model *model = NULL;
+
+	model = kzalloc(sizeof(*model), GFP_KERNEL);
+	if (!model)
+		return NULL;
+
+	spin_lock_init(&model->point_lock);
+	INIT_LIST_HEAD(&model->point_list);
+	mutex_init(&model->point_end_mutex);
+
+	spin_lock_init(&model->trajectory_lock);
+	INIT_LIST_HEAD(&model->trajectory_list);
+	mutex_init(&model->trajectory_end_mutex);
+
+	spin_lock_init(&model->forensics_lock);
+	INIT_LIST_HEAD(&model->forensics_list);
+	mutex_init(&model->forensics_end_mutex);
+
+	mutex_init(&model->pseudonym_mutex);
+	INIT_LIST_HEAD(&model->pseudonym_list);
+
+	mutex_init(&model->mount_mutex);
+	INIT_LIST_HEAD(&model->mount_list);
+
+	if (magazine_allocate(model, size)) {
+		kfree(model);
+		model = NULL;
+	}
+
+	return model;
+}
+
+/**
+ * tsem_model_free() - Frees an a kernel TMA description structure.
+ * @ctx: A pointer to the TMA modeling description structure whose
+ *	 model definition is to be deleted.
+ *
+ * This function is called when the last reference to a kernel
+ * based TMA model description structure is released.
+ */
+void tsem_model_free(struct tsem_context *ctx)
+{
+	struct tsem_event_point *ep, *tmp_ep;
+	struct tsem_event *tentry, *tmp_tentry;
+	struct pseudonym *sentry, *tmp_sentry;
+	struct tsem_inode_instance *ientry, *tmp_ientry;
+	struct tsem_model *model = ctx->model;
+
+	list_for_each_entry_safe(ep, tmp_ep, &model->point_list, list) {
+		list_del(&ep->list);
+		kmem_cache_free(point_cachep, ep);
+	}
+
+	list_for_each_entry_safe(sentry, tmp_sentry, &model->pseudonym_list,
+				 list) {
+		list_del(&sentry->list);
+		kfree(sentry);
+	}
+
+	list_for_each_entry_safe(tentry, tmp_tentry, &model->trajectory_list,
+				 list) {
+		list_del(&tentry->list);
+		tsem_event_put(tentry);
+	}
+
+	list_for_each_entry_safe(ientry, tmp_ientry, &model->mount_list,
+				 list) {
+		list_del(&ientry->list);
+		kfree(ientry);
+	}
+
+	if (ctx->sealed) {
+		list_for_each_entry_safe(tentry, tmp_tentry,
+					 &model->forensics_list, list) {
+			list_del(&tentry->list);
+			tsem_event_put(tentry);
+		}
+	}
+
+	tsem_model_magazine_free(model);
+	kfree(model);
+}
+
+/**
+ * tsem_model_magazine_free: Free the event point magazine for a model domain.
+ * @model: A pointer to the model whose magazine is to be freed.
+ *
+ * This function releases all of the components of an event point
+ * magazine that has been allocated for a modeling domain.
+ */
+void tsem_model_magazine_free(struct tsem_model *model)
+{
+	unsigned int lp;
+
+	for (lp = 0; lp < model->magazine_size; ++lp)
+		kmem_cache_free(point_cachep, model->magazine[lp]);
+
+	bitmap_free(model->magazine_index);
+	kfree(model->ws);
+	kfree(model->magazine);
+}
+
+/**
+ * tsem model_init() - Initialize the TSEM event point cache.
+ * @model: A pointer to the model that is being initialized.
+ * @size: The number of slots in the event point magazine for the root
+ *	  model.
+ *
+ * This function is called by the primary TSEM initialization function
+ * and sets up the cache that will be used to dispense tsem_event_point
+ * structures for security events that are called in atomic context.
+ *
+ * Return: This function returns a value of zero on success and a negative
+ *	   error code on failure.
+ */
+int __init tsem_model_cache_init(struct tsem_model *model, size_t size)
+{
+	point_cachep = kmem_cache_create("tsem_event_point_cache",
+					 sizeof(struct tsem_event_point), 0,
+					 SLAB_PANIC, 0);
+	if (!point_cachep)
+		return -ENOMEM;
+
+	if (magazine_allocate(model, size)) {
+		kmem_cache_destroy(point_cachep);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
-- 
2.39.1


