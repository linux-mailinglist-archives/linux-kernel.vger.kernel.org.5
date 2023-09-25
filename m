Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026947AD459
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjIYJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjIYJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:16:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8603C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695633389; x=1727169389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4mYYGMtvhrZ5Go/HEV8QLtGBFT/aHlbOysA0rNPlmFE=;
  b=b5Nwiyb3L1r19jIw5gLYhiI9JKSijtgICcjOaOMuabYJCkr7Pz4yEKs9
   1nyN+e30fr9SZTPlA87WZogJAe43uVA8HkQSZp3XjTsITVOBtNT8OnGjZ
   iDzcyTBK6bfK0goXTq3acrDqvVgE8taWsLCESgrWkHpJjteAKKQe8y1mU
   5NeiLAj7sYFA2WigPRzbe8H15RnrNqilBwALrNpdAp52Ejd+EkRAznvyA
   pAyrHDnb9zDhkpQcvoTZzayd6zA3T9bernDo5T+JEQkOxk3l7hxNGQlSw
   HguQ7e7nagk38mfwOUS2wmCTRIRZqYK5bWeaznZDgW28Xebifyiskh3vq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="381115719"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="381115719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 02:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838515025"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="838515025"
Received: from lab-ah.igk.intel.com (HELO lab-ah.corp.intel.com) ([10.102.138.202])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 02:16:27 -0700
From:   Andrzej Hajda <andrzej.hajda@intel.com>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH] debugobjects: stop accessing objects after releasing spinlock
Date:   Mon, 25 Sep 2023 11:16:00 +0200
Message-Id: <20230925091600.2941364-1-andrzej.hajda@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After spinlock release object can be modified/freed by concurrent thread.
Using it in such case is error prone, even for printing object state.
To avoid such situation local copy of the object is created if necessary.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 lib/debugobjects.c | 208 +++++++++++++++++++++------------------------
 1 file changed, 97 insertions(+), 111 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index a517256a270b71..d6f9af11bff0d9 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -620,9 +620,8 @@ static void debug_objects_fill_pool(void)
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
-	enum debug_obj_state state;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
+	struct debug_obj *obj, o;
 	unsigned long flags;
 
 	debug_objects_fill_pool();
@@ -644,23 +643,19 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_INIT;
 		break;
-
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
-		debug_object_fixup(descr->fixup_init, addr, state);
-		return;
-
-	case ODEBUG_STATE_DESTROYED:
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
-		return;
 	default:
-		break;
+		o = *obj;
+		obj = NULL;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	if (obj)
+		return;
+
+	debug_print_object(&o, "init");
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_init, addr, o.state);
 }
 
 /**
@@ -700,12 +695,9 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  */
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
-	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	enum debug_obj_state state;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
+	struct debug_obj *obj, o;
 	unsigned long flags;
-	int ret;
 
 	if (!debug_objects_enabled)
 		return 0;
@@ -717,49 +709,46 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
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
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 			obj->state = ODEBUG_STATE_ACTIVE;
-			ret = 0;
 			break;
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
+			obj = NULL;
 			break;
 		default:
-			ret = 0;
-			break;
 		}
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		if (print_object)
-			debug_print_object(obj, "activate");
-		return ret;
+	} else {
+		o.object = addr;
+		o.state = ODEBUG_STATE_NOTAVAILABLE;
+		o.descr = descr;
+		obj = NULL;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 
-	/* If NULL the allocation has hit OOM */
-	if (!obj) {
-		debug_objects_oom();
+	if (obj)
 		return 0;
-	}
 
-	/* Object is neither static nor tracked. It's not initialized */
 	debug_print_object(&o, "activate");
-	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
-	return ret ? 0 : -EINVAL;
+
+	switch (o.state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_NOTAVAILABLE:
+		if (debug_object_fixup(descr->fixup_activate, addr, o.state))
+			return 0;
+	default:
+	}
+
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -771,9 +760,8 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
 void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_bucket *db;
-	struct debug_obj *obj;
+	struct debug_obj *obj, o;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -788,30 +776,29 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 		case ODEBUG_STATE_ACTIVE:
-			if (!obj->astate)
+			if (!obj->astate) {
 				obj->state = ODEBUG_STATE_INACTIVE;
-			else
-				print_object = true;
-			break;
-
+				break;
+			}
+			fallthrough;
 		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
+			o = *obj;
+			obj = NULL;
 			break;
 		default:
 			break;
 		}
+	} else {
+		o.object = addr;
+		o.state = ODEBUG_STATE_NOTAVAILABLE;
+		o.descr = descr;
+		obj = NULL;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
 
+	if (!obj)
 		debug_print_object(&o, "deactivate");
-	} else if (print_object) {
-		debug_print_object(obj, "deactivate");
-	}
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -822,11 +809,9 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  */
 void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
+	struct debug_obj *obj, o;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -836,8 +821,10 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
 	case ODEBUG_STATE_NONE:
@@ -846,22 +833,22 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 		obj->state = ODEBUG_STATE_DESTROYED;
 		break;
 	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "destroy");
-		debug_object_fixup(descr->fixup_destroy, addr, state);
-		return;
-
 	case ODEBUG_STATE_DESTROYED:
-		print_object = true;
+		o = *obj;
+		obj = NULL;
 		break;
 	default:
-		break;
 	}
-out_unlock:
+
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (print_object)
-		debug_print_object(obj, "destroy");
+
+	if (obj)
+		return;
+
+	debug_print_object(&o, "destroy");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_destroy, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -872,9 +859,8 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  */
 void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
+	struct debug_obj *obj, o;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
@@ -885,24 +871,29 @@ void debug_object_free(void *addr, const struct debug_obj_descr *descr)
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
+		o = *obj;
+		obj = NULL;
+		break;
 	default:
 		hlist_del(&obj->node);
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	if (obj) {
 		free_object(obj);
 		return;
 	}
-out_unlock:
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	debug_print_object(&o, "free");
+	debug_object_fixup(descr->fixup_free, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_free);
 
@@ -955,9 +946,8 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
 	struct debug_bucket *db;
-	struct debug_obj *obj;
+	struct debug_obj *obj, o;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -970,28 +960,27 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
-			if (obj->astate == expect)
+			if (obj->astate == expect) {
 				obj->astate = next;
-			else
-				print_object = true;
-			break;
-
+				break;
+			}
+			fallthrough;
 		default:
-			print_object = true;
+			o = *obj;
+			obj = NULL;
 			break;
 		}
+	} else {
+		o.object = addr;
+		o.state = ODEBUG_STATE_NOTAVAILABLE;
+		o.descr = descr;
+		obj = NULL;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
 
+	if (!obj)
 		debug_print_object(&o, "active_state");
-	} else if (print_object) {
-		debug_print_object(obj, "active_state");
-	}
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -999,11 +988,9 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	const struct debug_obj_descr *descr;
-	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
-	struct debug_obj *obj;
+	struct debug_obj *obj, o;
 	int cnt, objs_checked = 0;
 
 	saddr = (unsigned long) address;
@@ -1026,12 +1013,11 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
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
+				debug_object_fixup(o.descr->fixup_free,
+						   (void *) oaddr, o.state);
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
-- 
2.34.1

