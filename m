Return-Path: <linux-kernel+bounces-26628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3C82E44F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C519C283689
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E06B1B7F7;
	Tue, 16 Jan 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8a/4uk8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4A13FF1;
	Tue, 16 Jan 2024 00:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F24AC433C7;
	Tue, 16 Jan 2024 00:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705363773;
	bh=keNpc4F7/ql7Q5I14Hor30JYw+6MbHxueqAwNucrgsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8a/4uk8hslx4rQt99bAdvH6c8RmpNI7js5ujHonyDphciCYJ4AxFJxQQdOIu7YKf
	 jxLbZ6NbKkjwR27rOwUnDBicitEAfEn+gBXiTslFtGgdgWdoXqbMwF6nh3cgxJBY2E
	 QWX6S9BLUMSRBqPnOY8xW31sJeoA6WjGCJAq+XRs/zn13KZltUwo55eMQDZ/y+rtB0
	 aZ4G98GSSoCWl8/IXAihKzgTwr2srAJbVazmZCrnJ6V7yOm5defpA2fjbKKwQyINiI
	 aNX7SYCd8HbplIx84qqzO7rxjlqcGxh8HGrylutjphsvXViut1z1ftDaNt5iR79KOr
	 YjMvbf7duYMtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 2/2] debugobjects: Stop accessing objects after releasing hash bucket lock
Date: Mon, 15 Jan 2024 19:09:29 -0500
Message-ID: <20240116000929.212677-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116000929.212677-1-sashal@kernel.org>
References: <20240116000929.212677-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Andrzej Hajda <andrzej.hajda@intel.com>

[ Upstream commit 9bb6362652f3f4d74a87d572a91ee1b38e673ef6 ]

After release of the hashbucket lock the tracking object can be modified or
freed by a concurrent thread.  Using it in such a case is error prone, even
for printing the object state:

    1. T1 tries to deactivate destroyed object, debugobjects detects it,
       hash bucket lock is released.

    2. T2 preempts T1 and frees the tracking object.

    3. The freed tracking object is allocated and initialized for a
       different to be tracked kernel object.

    4. T1 resumes and reports error for wrong kernel object.

Create a local copy of the tracking object before releasing the hash bucket
lock and use the local copy for reporting and fixups to prevent this.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231025-debugobjects_fix-v3-1-2bc3bf7084c2@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 200 ++++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 122 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index dacb80c22c4f..5dfa582dbadd 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -609,9 +609,8 @@ static void debug_objects_fill_pool(void)
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	debug_objects_fill_pool();
@@ -632,24 +631,18 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_INIT;
-		break;
-
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
-		debug_object_fixup(descr->fixup_init, addr, state);
-		return;
-
-	case ODEBUG_STATE_DESTROYED:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
 		return;
 	default:
 		break;
 	}
 
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "init");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_init, addr, o.state);
 }
 
 /**
@@ -690,11 +683,9 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	int ret;
 
 	if (!debug_objects_enabled)
 		return 0;
@@ -706,49 +697,38 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
-	if (likely(!IS_ERR_OR_NULL(obj))) {
-		bool print_object = false;
-
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return 0;
+	} else if (likely(!IS_ERR(obj))) {
 		switch (obj->state) {
-		case ODEBUG_STATE_INIT:
-		case ODEBUG_STATE_INACTIVE:
-			obj->state = ODEBUG_STATE_ACTIVE;
-			ret = 0;
-			break;
-
 		case ODEBUG_STATE_ACTIVE:
-			state = obj->state;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_print_object(obj, "activate");
-			ret = debug_object_fixup(descr->fixup_activate, addr, state);
-			return ret ? 0 : -EINVAL;
-
 		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			ret = -EINVAL;
+			o = *obj;
 			break;
+		case ODEBUG_STATE_INIT:
+		case ODEBUG_STATE_INACTIVE:
+			obj->state = ODEBUG_STATE_ACTIVE;
+			fallthrough;
 		default:
-			ret = 0;
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return 0;
 		}
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		if (print_object)
-			debug_print_object(obj, "activate");
-		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "activate");
 
-	/* If NULL the allocation has hit OOM */
-	if (!obj) {
-		debug_objects_oom();
-		return 0;
+	switch (o.state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_NOTAVAILABLE:
+		if (debug_object_fixup(descr->fixup_activate, addr, o.state))
+			return 0;
+		fallthrough;
+	default:
+		return -EINVAL;
 	}
-
-	/* Object is neither static nor tracked. It's not initialized */
-	debug_print_object(&o, "activate");
-	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
-	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -759,10 +739,10 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
  */
 void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -774,33 +754,24 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 	obj = lookup_object(addr, db);
 	if (obj) {
 		switch (obj->state) {
+		case ODEBUG_STATE_DESTROYED:
+			break;
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 		case ODEBUG_STATE_ACTIVE:
-			if (!obj->astate)
-				obj->state = ODEBUG_STATE_INACTIVE;
-			else
-				print_object = true;
-			break;
-
-		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			break;
+			if (obj->astate)
+				break;
+			obj->state = ODEBUG_STATE_INACTIVE;
+			fallthrough;
 		default:
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "deactivate");
-	} else if (print_object) {
-		debug_print_object(obj, "deactivate");
-	}
+	debug_print_object(&o, "deactivate");
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -811,11 +782,9 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  */
 void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -825,32 +794,31 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_DESTROYED:
+		break;
 	case ODEBUG_STATE_NONE:
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_DESTROYED;
-		break;
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
+		fallthrough;
+	default:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "destroy");
-		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
-
-	case ODEBUG_STATE_DESTROYED:
-		print_object = true;
-		break;
-	default:
-		break;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (print_object)
-		debug_print_object(obj, "destroy");
+	debug_print_object(&o, "destroy");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_destroy, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -861,9 +829,8 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  */
 void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
@@ -874,24 +841,26 @@ void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "free");
-		debug_object_fixup(descr->fixup_free, addr, state);
-		return;
+		break;
 	default:
 		hlist_del(&obj->node);
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 		free_object(obj);
 		return;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "free");
+
+	debug_object_fixup(descr->fixup_free, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_free);
 
@@ -943,10 +912,10 @@ void
 debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -959,28 +928,19 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
-			if (obj->astate == expect)
-				obj->astate = next;
-			else
-				print_object = true;
-			break;
-
+			if (obj->astate != expect)
+				break;
+			obj->astate = next;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		default:
-			print_object = true;
 			break;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "active_state");
-	} else if (print_object) {
-		debug_print_object(obj, "active_state");
-	}
+	debug_print_object(&o, "active_state");
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -988,12 +948,10 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	const struct debug_obj_descr *descr;
-	enum debug_obj_state state;
+	int cnt, objs_checked = 0;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
-	struct debug_obj *obj;
-	int cnt, objs_checked = 0;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -1015,12 +973,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				descr = obj->descr;
-				state = obj->state;
+				o = *obj;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
-				debug_print_object(obj, "free");
-				debug_object_fixup(descr->fixup_free,
-						   (void *) oaddr, state);
+				debug_print_object(&o, "free");
+				debug_object_fixup(o.descr->fixup_free, (void *)oaddr, o.state);
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-- 
2.43.0


