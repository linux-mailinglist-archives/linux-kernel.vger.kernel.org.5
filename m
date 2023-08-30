Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF80778DF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbjH3T0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbjH3PDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:03:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2DAAC;
        Wed, 30 Aug 2023 08:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B43E56252E;
        Wed, 30 Aug 2023 15:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41423C433C8;
        Wed, 30 Aug 2023 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407822;
        bh=qKjRE+r7HSOYksbQ2LSzVXXmEWe2j5En39MrE80IH1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZMTom39H8wiQnUBFzVTWg5A40JZ5iPqVBmKESJVOsS1h/RHyFBqXLE8iIJkrJhug
         rlfywN+kJ771ZeKVlfkDIox9IZPhACz4zHY0guCZuC+i+zP/qAQhhAs4zjuEzt/eXB
         phsAG0aQdHy90ZdxQ8ufpcMZEV4dJ/vTZZxfLXPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.193
Date:   Wed, 30 Aug 2023 17:03:30 +0200
Message-ID: <2023083030-woof-deserve-ad26@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023083030-cryptic-sultry-b7bf@gregkh>
References: <2023083030-cryptic-sultry-b7bf@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 316598ce1b12..0423b4b2b000 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 192
+SUBLEVEL = 193
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 8294eaa6f902..dd03bc905841 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -126,7 +126,24 @@
 #define cpu_has_tx39_cache	__opt(MIPS_CPU_TX39_CACHE)
 #endif
 #ifndef cpu_has_octeon_cache
-#define cpu_has_octeon_cache	0
+#define cpu_has_octeon_cache						\
+({									\
+	int __res;							\
+									\
+	switch (boot_cpu_type()) {					\
+	case CPU_CAVIUM_OCTEON:						\
+	case CPU_CAVIUM_OCTEON_PLUS:					\
+	case CPU_CAVIUM_OCTEON2:					\
+	case CPU_CAVIUM_OCTEON3:					\
+		__res = 1;						\
+		break;							\
+									\
+	default:							\
+		__res = 0;						\
+	}								\
+									\
+	__res;								\
+})
 #endif
 /* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */
 #ifndef cpu_has_fpu
@@ -353,7 +370,7 @@
 ({									\
 	int __res;							\
 									\
-	switch (current_cpu_type()) {					\
+	switch (boot_cpu_type()) {					\
 	case CPU_M14KC:							\
 	case CPU_74K:							\
 	case CPU_1074K:							\
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 80836b94189e..b897feb519ad 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -892,6 +892,14 @@ void __init fpu__init_system_xstate(void)
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
+
+	/*
+	 * CPU capabilities initialization runs before FPU init. So
+	 * X86_FEATURE_OSXSAVE is not set. Now that XSAVE is completely
+	 * functional, set the feature bit so depending code works.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 63491748dc8d..95cbd5790ed6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3740,7 +3740,7 @@ static int rbd_lock(struct rbd_device *rbd_dev)
 	ret = ceph_cls_lock(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			    RBD_LOCK_NAME, CEPH_CLS_LOCK_EXCLUSIVE, cookie,
 			    RBD_LOCK_TAG, "", 0);
-	if (ret)
+	if (ret && ret != -EEXIST)
 		return ret;
 
 	__rbd_lock(rbd_dev, cookie);
@@ -3914,10 +3914,26 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
 	list_splice_tail_init(&rbd_dev->acquiring_list, &rbd_dev->running_list);
 }
 
-static int get_lock_owner_info(struct rbd_device *rbd_dev,
-			       struct ceph_locker **lockers, u32 *num_lockers)
+static bool locker_equal(const struct ceph_locker *lhs,
+			 const struct ceph_locker *rhs)
+{
+	return lhs->id.name.type == rhs->id.name.type &&
+	       lhs->id.name.num == rhs->id.name.num &&
+	       !strcmp(lhs->id.cookie, rhs->id.cookie) &&
+	       ceph_addr_equal_no_type(&lhs->info.addr, &rhs->info.addr);
+}
+
+static void free_locker(struct ceph_locker *locker)
+{
+	if (locker)
+		ceph_free_lockers(locker, 1);
+}
+
+static struct ceph_locker *get_lock_owner_info(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_locker *lockers;
+	u32 num_lockers;
 	u8 lock_type;
 	char *lock_tag;
 	int ret;
@@ -3926,39 +3942,45 @@ static int get_lock_owner_info(struct rbd_device *rbd_dev,
 
 	ret = ceph_cls_lock_info(osdc, &rbd_dev->header_oid,
 				 &rbd_dev->header_oloc, RBD_LOCK_NAME,
-				 &lock_type, &lock_tag, lockers, num_lockers);
-	if (ret)
-		return ret;
+				 &lock_type, &lock_tag, &lockers, &num_lockers);
+	if (ret) {
+		rbd_warn(rbd_dev, "failed to get header lockers: %d", ret);
+		return ERR_PTR(ret);
+	}
 
-	if (*num_lockers == 0) {
+	if (num_lockers == 0) {
 		dout("%s rbd_dev %p no lockers detected\n", __func__, rbd_dev);
+		lockers = NULL;
 		goto out;
 	}
 
 	if (strcmp(lock_tag, RBD_LOCK_TAG)) {
 		rbd_warn(rbd_dev, "locked by external mechanism, tag %s",
 			 lock_tag);
-		ret = -EBUSY;
-		goto out;
+		goto err_busy;
 	}
 
 	if (lock_type == CEPH_CLS_LOCK_SHARED) {
 		rbd_warn(rbd_dev, "shared lock type detected");
-		ret = -EBUSY;
-		goto out;
+		goto err_busy;
 	}
 
-	if (strncmp((*lockers)[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
+	WARN_ON(num_lockers != 1);
+	if (strncmp(lockers[0].id.cookie, RBD_LOCK_COOKIE_PREFIX,
 		    strlen(RBD_LOCK_COOKIE_PREFIX))) {
 		rbd_warn(rbd_dev, "locked by external mechanism, cookie %s",
-			 (*lockers)[0].id.cookie);
-		ret = -EBUSY;
-		goto out;
+			 lockers[0].id.cookie);
+		goto err_busy;
 	}
 
 out:
 	kfree(lock_tag);
-	return ret;
+	return lockers;
+
+err_busy:
+	kfree(lock_tag);
+	ceph_free_lockers(lockers, num_lockers);
+	return ERR_PTR(-EBUSY);
 }
 
 static int find_watcher(struct rbd_device *rbd_dev,
@@ -3974,13 +3996,19 @@ static int find_watcher(struct rbd_device *rbd_dev,
 	ret = ceph_osdc_list_watchers(osdc, &rbd_dev->header_oid,
 				      &rbd_dev->header_oloc, &watchers,
 				      &num_watchers);
-	if (ret)
+	if (ret) {
+		rbd_warn(rbd_dev, "failed to get watchers: %d", ret);
 		return ret;
+	}
 
 	sscanf(locker->id.cookie, RBD_LOCK_COOKIE_PREFIX " %llu", &cookie);
 	for (i = 0; i < num_watchers; i++) {
-		if (!memcmp(&watchers[i].addr, &locker->info.addr,
-			    sizeof(locker->info.addr)) &&
+		/*
+		 * Ignore addr->type while comparing.  This mimics
+		 * entity_addr_t::get_legacy_str() + strcmp().
+		 */
+		if (ceph_addr_equal_no_type(&watchers[i].addr,
+					    &locker->info.addr) &&
 		    watchers[i].cookie == cookie) {
 			struct rbd_client_id cid = {
 				.gid = le64_to_cpu(watchers[i].name.num),
@@ -4008,51 +4036,72 @@ static int find_watcher(struct rbd_device *rbd_dev,
 static int rbd_try_lock(struct rbd_device *rbd_dev)
 {
 	struct ceph_client *client = rbd_dev->rbd_client->client;
-	struct ceph_locker *lockers;
-	u32 num_lockers;
+	struct ceph_locker *locker, *refreshed_locker;
 	int ret;
 
 	for (;;) {
+		locker = refreshed_locker = NULL;
+
 		ret = rbd_lock(rbd_dev);
-		if (ret != -EBUSY)
-			return ret;
+		if (!ret)
+			goto out;
+		if (ret != -EBUSY) {
+			rbd_warn(rbd_dev, "failed to lock header: %d", ret);
+			goto out;
+		}
 
 		/* determine if the current lock holder is still alive */
-		ret = get_lock_owner_info(rbd_dev, &lockers, &num_lockers);
-		if (ret)
-			return ret;
-
-		if (num_lockers == 0)
+		locker = get_lock_owner_info(rbd_dev);
+		if (IS_ERR(locker)) {
+			ret = PTR_ERR(locker);
+			locker = NULL;
+			goto out;
+		}
+		if (!locker)
 			goto again;
 
-		ret = find_watcher(rbd_dev, lockers);
+		ret = find_watcher(rbd_dev, locker);
 		if (ret)
 			goto out; /* request lock or error */
 
+		refreshed_locker = get_lock_owner_info(rbd_dev);
+		if (IS_ERR(refreshed_locker)) {
+			ret = PTR_ERR(refreshed_locker);
+			refreshed_locker = NULL;
+			goto out;
+		}
+		if (!refreshed_locker ||
+		    !locker_equal(locker, refreshed_locker))
+			goto again;
+
 		rbd_warn(rbd_dev, "breaking header lock owned by %s%llu",
-			 ENTITY_NAME(lockers[0].id.name));
+			 ENTITY_NAME(locker->id.name));
 
 		ret = ceph_monc_blocklist_add(&client->monc,
-					      &lockers[0].info.addr);
+					      &locker->info.addr);
 		if (ret) {
-			rbd_warn(rbd_dev, "blocklist of %s%llu failed: %d",
-				 ENTITY_NAME(lockers[0].id.name), ret);
+			rbd_warn(rbd_dev, "failed to blocklist %s%llu: %d",
+				 ENTITY_NAME(locker->id.name), ret);
 			goto out;
 		}
 
 		ret = ceph_cls_break_lock(&client->osdc, &rbd_dev->header_oid,
 					  &rbd_dev->header_oloc, RBD_LOCK_NAME,
-					  lockers[0].id.cookie,
-					  &lockers[0].id.name);
-		if (ret && ret != -ENOENT)
+					  locker->id.cookie, &locker->id.name);
+		if (ret && ret != -ENOENT) {
+			rbd_warn(rbd_dev, "failed to break header lock: %d",
+				 ret);
 			goto out;
+		}
 
 again:
-		ceph_free_lockers(lockers, num_lockers);
+		free_locker(refreshed_locker);
+		free_locker(locker);
 	}
 
 out:
-	ceph_free_lockers(lockers, num_lockers);
+	free_locker(refreshed_locker);
+	free_locker(locker);
 	return ret;
 }
 
@@ -4102,11 +4151,8 @@ static int rbd_try_acquire_lock(struct rbd_device *rbd_dev)
 
 	ret = rbd_try_lock(rbd_dev);
 	if (ret < 0) {
-		rbd_warn(rbd_dev, "failed to lock header: %d", ret);
-		if (ret == -EBLOCKLISTED)
-			goto out;
-
-		ret = 1; /* request lock anyway */
+		rbd_warn(rbd_dev, "failed to acquire lock: %d", ret);
+		goto out;
 	}
 	if (ret > 0) {
 		up_write(&rbd_dev->lock_rwsem);
@@ -6656,12 +6702,11 @@ static int rbd_add_acquire_lock(struct rbd_device *rbd_dev)
 		cancel_delayed_work_sync(&rbd_dev->lock_dwork);
 		if (!ret)
 			ret = -ETIMEDOUT;
-	}
 
-	if (ret) {
-		rbd_warn(rbd_dev, "failed to acquire exclusive lock: %ld", ret);
-		return ret;
+		rbd_warn(rbd_dev, "failed to acquire lock: %ld", ret);
 	}
+	if (ret)
+		return ret;
 
 	/*
 	 * The lock may have been released by now, unless automatic lock
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 4fb4fd4b06bd..737aa70e2cb3 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -205,18 +205,19 @@ EXPORT_SYMBOL(devm_clk_put);
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
+	struct devm_clk_state *state;
+	struct clk *clk;
 
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	if (!state)
 		return ERR_PTR(-ENOMEM);
 
 	clk = of_clk_get_by_name(np, con_id);
 	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
+		state->clk = clk;
+		devres_add(dev, state);
 	} else {
-		devres_free(ptr);
+		devres_free(state);
 	}
 
 	return clk;
diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 348b3a9170fa..7f5ed1aa7a9f 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -191,6 +191,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
  */
 static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 {
+	LIST_HEAD(signalled);
 	struct sync_pt *pt, *next;
 
 	trace_sync_timeline(obj);
@@ -203,21 +204,20 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;
 
-		list_del_init(&pt->link);
+		dma_fence_get(&pt->base);
+
+		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);
 
-		/*
-		 * A signal callback may release the last reference to this
-		 * fence, causing it to be freed. That operation has to be
-		 * last to avoid a use after free inside this loop, and must
-		 * be after we remove the fence from the timeline in order to
-		 * prevent deadlocking on timeline->lock inside
-		 * timeline_fence_release().
-		 */
 		dma_fence_signal_locked(&pt->base);
 	}
 
 	spin_unlock_irq(&obj->lock);
+
+	list_for_each_entry_safe(pt, next, &signalled, link) {
+		list_del_init(&pt->link);
+		dma_fence_put(&pt->base);
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 71a85c5306ed..1c669f115dd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3282,7 +3282,9 @@ void dcn10_wait_for_mpcc_disconnect(
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
 			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
 
-			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
+			if (pipe_ctx->stream_res.tg &&
+				pipe_ctx->stream_res.tg->funcs->is_tg_enabled(pipe_ctx->stream_res.tg))
+				res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
 			hubp->funcs->set_blank(hubp, true);
 		}
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index cae9ac6379a5..aba811c6aa0d 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -457,8 +457,11 @@ int i915_active_ref(struct i915_active *ref, u64 idx, struct dma_fence *fence)
 		}
 	} while (unlikely(is_barrier(active)));
 
-	if (!__i915_active_fence_set(active, fence))
+	fence = __i915_active_fence_set(active, fence);
+	if (!fence)
 		__i915_active_acquire(ref);
+	else
+		dma_fence_put(fence);
 
 out:
 	i915_active_release(ref);
@@ -477,13 +480,9 @@ __i915_active_set_fence(struct i915_active *ref,
 		return NULL;
 	}
 
-	rcu_read_lock();
 	prev = __i915_active_fence_set(active, fence);
-	if (prev)
-		prev = dma_fence_get_rcu(prev);
-	else
+	if (!prev)
 		__i915_active_acquire(ref);
-	rcu_read_unlock();
 
 	return prev;
 }
@@ -1050,10 +1049,11 @@ void i915_request_add_active_barriers(struct i915_request *rq)
  *
  * Records the new @fence as the last active fence along its timeline in
  * this active tracker, moving the tracking callbacks from the previous
- * fence onto this one. Returns the previous fence (if not already completed),
- * which the caller must ensure is executed before the new fence. To ensure
- * that the order of fences within the timeline of the i915_active_fence is
- * understood, it should be locked by the caller.
+ * fence onto this one. Gets and returns a reference to the previous fence
+ * (if not already completed), which the caller must put after making sure
+ * that it is executed before the new fence. To ensure that the order of
+ * fences within the timeline of the i915_active_fence is understood, it
+ * should be locked by the caller.
  */
 struct dma_fence *
 __i915_active_fence_set(struct i915_active_fence *active,
@@ -1062,7 +1062,23 @@ __i915_active_fence_set(struct i915_active_fence *active,
 	struct dma_fence *prev;
 	unsigned long flags;
 
-	if (fence == rcu_access_pointer(active->fence))
+	/*
+	 * In case of fences embedded in i915_requests, their memory is
+	 * SLAB_FAILSAFE_BY_RCU, then it can be reused right after release
+	 * by new requests.  Then, there is a risk of passing back a pointer
+	 * to a new, completely unrelated fence that reuses the same memory
+	 * while tracked under a different active tracker.  Combined with i915
+	 * perf open/close operations that build await dependencies between
+	 * engine kernel context requests and user requests from different
+	 * timelines, this can lead to dependency loops and infinite waits.
+	 *
+	 * As a countermeasure, we try to get a reference to the active->fence
+	 * first, so if we succeed and pass it back to our user then it is not
+	 * released and potentially reused by an unrelated request before the
+	 * user has a chance to set up an await dependency on it.
+	 */
+	prev = i915_active_fence_get(active);
+	if (fence == prev)
 		return fence;
 
 	GEM_BUG_ON(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags));
@@ -1071,27 +1087,56 @@ __i915_active_fence_set(struct i915_active_fence *active,
 	 * Consider that we have two threads arriving (A and B), with
 	 * C already resident as the active->fence.
 	 *
-	 * A does the xchg first, and so it sees C or NULL depending
-	 * on the timing of the interrupt handler. If it is NULL, the
-	 * previous fence must have been signaled and we know that
-	 * we are first on the timeline. If it is still present,
-	 * we acquire the lock on that fence and serialise with the interrupt
-	 * handler, in the process removing it from any future interrupt
-	 * callback. A will then wait on C before executing (if present).
-	 *
-	 * As B is second, it sees A as the previous fence and so waits for
-	 * it to complete its transition and takes over the occupancy for
-	 * itself -- remembering that it needs to wait on A before executing.
+	 * Both A and B have got a reference to C or NULL, depending on the
+	 * timing of the interrupt handler.  Let's assume that if A has got C
+	 * then it has locked C first (before B).
 	 *
 	 * Note the strong ordering of the timeline also provides consistent
 	 * nesting rules for the fence->lock; the inner lock is always the
 	 * older lock.
 	 */
 	spin_lock_irqsave(fence->lock, flags);
-	prev = xchg(__active_fence_slot(active), fence);
-	if (prev) {
-		GEM_BUG_ON(prev == fence);
+	if (prev)
 		spin_lock_nested(prev->lock, SINGLE_DEPTH_NESTING);
+
+	/*
+	 * A does the cmpxchg first, and so it sees C or NULL, as before, or
+	 * something else, depending on the timing of other threads and/or
+	 * interrupt handler.  If not the same as before then A unlocks C if
+	 * applicable and retries, starting from an attempt to get a new
+	 * active->fence.  Meanwhile, B follows the same path as A.
+	 * Once A succeeds with cmpxch, B fails again, retires, gets A from
+	 * active->fence, locks it as soon as A completes, and possibly
+	 * succeeds with cmpxchg.
+	 */
+	while (cmpxchg(__active_fence_slot(active), prev, fence) != prev) {
+		if (prev) {
+			spin_unlock(prev->lock);
+			dma_fence_put(prev);
+		}
+		spin_unlock_irqrestore(fence->lock, flags);
+
+		prev = i915_active_fence_get(active);
+		GEM_BUG_ON(prev == fence);
+
+		spin_lock_irqsave(fence->lock, flags);
+		if (prev)
+			spin_lock_nested(prev->lock, SINGLE_DEPTH_NESTING);
+	}
+
+	/*
+	 * If prev is NULL then the previous fence must have been signaled
+	 * and we know that we are first on the timeline.  If it is still
+	 * present then, having the lock on that fence already acquired, we
+	 * serialise with the interrupt handler, in the process of removing it
+	 * from any future interrupt callback.  A will then wait on C before
+	 * executing (if present).
+	 *
+	 * As B is second, it sees A as the previous fence and so waits for
+	 * it to complete its transition and takes over the occupancy for
+	 * itself -- remembering that it needs to wait on A before executing.
+	 */
+	if (prev) {
 		__list_del_entry(&active->cb.node);
 		spin_unlock(prev->lock); /* serialise with prev->cb_list */
 	}
@@ -1108,11 +1153,7 @@ int i915_active_fence_set(struct i915_active_fence *active,
 	int err = 0;
 
 	/* Must maintain timeline ordering wrt previous active requests */
-	rcu_read_lock();
 	fence = __i915_active_fence_set(active, &rq->fence);
-	if (fence) /* but the previous fence may not belong to that timeline! */
-		fence = dma_fence_get_rcu(fence);
-	rcu_read_unlock();
 	if (fence) {
 		err = i915_request_await_dma_fence(rq, fence);
 		dma_fence_put(fence);
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 896389f93029..eda56b2fdc68 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1525,6 +1525,8 @@ __i915_request_add_to_timeline(struct i915_request *rq)
 							 &rq->dep,
 							 0);
 	}
+	if (prev)
+		i915_request_put(prev);
 
 	/*
 	 * Make sure that no request gazumped us - if it was allocated after
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index ad208a5f4ebe..0a79c57c7db6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1606,4 +1606,17 @@ static inline void vmw_mmio_write(u32 value, u32 *addr)
 {
 	WRITE_ONCE(*addr, value);
 }
+
+static inline bool vmw_shadertype_is_valid(enum vmw_sm_type shader_model,
+					   u32 shader_type)
+{
+	SVGA3dShaderType max_allowed = SVGA3D_SHADERTYPE_PREDX_MAX;
+
+	if (shader_model >= VMW_SM_5)
+		max_allowed = SVGA3D_SHADERTYPE_MAX;
+	else if (shader_model >= VMW_SM_4)
+		max_allowed = SVGA3D_SHADERTYPE_DX10_MAX;
+	return shader_type >= SVGA3D_SHADERTYPE_MIN && shader_type < max_allowed;
+}
+
 #endif
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 739cbc77d886..4c6c2e5abf95 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1998,7 +1998,7 @@ static int vmw_cmd_set_shader(struct vmw_private *dev_priv,
 
 	cmd = container_of(header, typeof(*cmd), header);
 
-	if (cmd->body.type >= SVGA3D_SHADERTYPE_PREDX_MAX) {
+	if (!vmw_shadertype_is_valid(VMW_SM_LEGACY, cmd->body.type)) {
 		VMW_DEBUG_USER("Illegal shader type %u.\n",
 			       (unsigned int) cmd->body.type);
 		return -EINVAL;
@@ -2120,8 +2120,6 @@ vmw_cmd_dx_set_single_constant_buffer(struct vmw_private *dev_priv,
 				      SVGA3dCmdHeader *header)
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXSetSingleConstantBuffer);
-	SVGA3dShaderType max_shader_num = has_sm5_context(dev_priv) ?
-		SVGA3D_NUM_SHADERTYPE : SVGA3D_NUM_SHADERTYPE_DX10;
 
 	struct vmw_resource *res = NULL;
 	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
@@ -2138,6 +2136,14 @@ vmw_cmd_dx_set_single_constant_buffer(struct vmw_private *dev_priv,
 	if (unlikely(ret != 0))
 		return ret;
 
+	if (!vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type) ||
+	    cmd->body.slot >= SVGA3D_DX_MAX_CONSTBUFFERS) {
+		VMW_DEBUG_USER("Illegal const buffer shader %u slot %u.\n",
+			       (unsigned int) cmd->body.type,
+			       (unsigned int) cmd->body.slot);
+		return -EINVAL;
+	}
+
 	binding.bi.ctx = ctx_node->ctx;
 	binding.bi.res = res;
 	binding.bi.bt = vmw_ctx_binding_cb;
@@ -2146,14 +2152,6 @@ vmw_cmd_dx_set_single_constant_buffer(struct vmw_private *dev_priv,
 	binding.size = cmd->body.sizeInBytes;
 	binding.slot = cmd->body.slot;
 
-	if (binding.shader_slot >= max_shader_num ||
-	    binding.slot >= SVGA3D_DX_MAX_CONSTBUFFERS) {
-		VMW_DEBUG_USER("Illegal const buffer shader %u slot %u.\n",
-			       (unsigned int) cmd->body.type,
-			       (unsigned int) binding.slot);
-		return -EINVAL;
-	}
-
 	vmw_binding_add(ctx_node->staged, &binding.bi, binding.shader_slot,
 			binding.slot);
 
@@ -2174,15 +2172,13 @@ static int vmw_cmd_dx_set_shader_res(struct vmw_private *dev_priv,
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXSetShaderResources) =
 		container_of(header, typeof(*cmd), header);
-	SVGA3dShaderType max_allowed = has_sm5_context(dev_priv) ?
-		SVGA3D_SHADERTYPE_MAX : SVGA3D_SHADERTYPE_DX10_MAX;
 
 	u32 num_sr_view = (cmd->header.size - sizeof(cmd->body)) /
 		sizeof(SVGA3dShaderResourceViewId);
 
 	if ((u64) cmd->body.startView + (u64) num_sr_view >
 	    (u64) SVGA3D_DX_MAX_SRVIEWS ||
-	    cmd->body.type >= max_allowed) {
+	    !vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type)) {
 		VMW_DEBUG_USER("Invalid shader binding.\n");
 		return -EINVAL;
 	}
@@ -2206,8 +2202,6 @@ static int vmw_cmd_dx_set_shader(struct vmw_private *dev_priv,
 				 SVGA3dCmdHeader *header)
 {
 	VMW_DECLARE_CMD_VAR(*cmd, SVGA3dCmdDXSetShader);
-	SVGA3dShaderType max_allowed = has_sm5_context(dev_priv) ?
-		SVGA3D_SHADERTYPE_MAX : SVGA3D_SHADERTYPE_DX10_MAX;
 	struct vmw_resource *res = NULL;
 	struct vmw_ctx_validation_info *ctx_node = VMW_GET_CTX_NODE(sw_context);
 	struct vmw_ctx_bindinfo_shader binding;
@@ -2218,8 +2212,7 @@ static int vmw_cmd_dx_set_shader(struct vmw_private *dev_priv,
 
 	cmd = container_of(header, typeof(*cmd), header);
 
-	if (cmd->body.type >= max_allowed ||
-	    cmd->body.type < SVGA3D_SHADERTYPE_MIN) {
+	if (!vmw_shadertype_is_valid(dev_priv->sm_type, cmd->body.type)) {
 		VMW_DEBUG_USER("Illegal shader type %u.\n",
 			       (unsigned int) cmd->body.type);
 		return -EINVAL;
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 7599a122c956..1667ac140609 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -31,11 +31,11 @@
 #define DEFAULT_BUFFER_SECTORS		128
 #define DEFAULT_JOURNAL_WATERMARK	50
 #define DEFAULT_SYNC_MSEC		10000
-#define DEFAULT_MAX_JOURNAL_SECTORS	131072
+#define DEFAULT_MAX_JOURNAL_SECTORS	(IS_ENABLED(CONFIG_64BIT) ? 131072 : 8192)
 #define MIN_LOG2_INTERLEAVE_SECTORS	3
 #define MAX_LOG2_INTERLEAVE_SECTORS	31
 #define METADATA_WORKQUEUE_MAX_ACTIVE	16
-#define RECALC_SECTORS			8192
+#define RECALC_SECTORS			(IS_ENABLED(CONFIG_64BIT) ? 32768 : 2048)
 #define RECALC_WRITE_SUPER		16
 #define BITMAP_BLOCK_SIZE		4096	/* don't change it */
 #define BITMAP_FLUSH_INTERVAL		(10 * HZ)
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 21de1431cfcb..2c2be43a3e9e 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -729,6 +729,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 152f76f86927..64ba465741a7 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -656,10 +656,10 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 		return NULL;
 	arp = (struct arp_pkt *)skb_network_header(skb);
 
-	/* Don't modify or load balance ARPs that do not originate locally
-	 * (e.g.,arrive via a bridge).
+	/* Don't modify or load balance ARPs that do not originate
+	 * from the bond itself or a VLAN directly above the bond.
 	 */
-	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
+	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
 		return NULL;
 
 	if (arp->op_code == htons(ARPOP_REPLY)) {
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 282c53ef76d2..1bfede407270 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -179,12 +179,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 
 		nla_peer = data[VXCAN_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) +
-					  sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) -
-					  sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index ab8ee9331635..a4f6143e66fe 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1448,7 +1448,7 @@ int bgmac_phy_connect_direct(struct bgmac *bgmac)
 	int err;
 
 	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-	if (!phy_dev || IS_ERR(phy_dev)) {
+	if (IS_ERR(phy_dev)) {
 		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
 		return -ENODEV;
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 99aba64f03c2..2b0538f2af63 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -568,7 +568,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
 		};
 
 		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-		if (!phydev || IS_ERR(phydev)) {
+		if (IS_ERR(phydev)) {
 			dev_err(kdev, "failed to register fixed PHY device\n");
 			return -ENODEV;
 		}
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index c3ec9ceed833..d80f155574c6 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -196,7 +196,7 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
 	unsigned long offset;
 
 	for (offset = 0; offset < length; offset += SMP_CACHE_BYTES)
-		asm("dcbfl %0,%1" :: "b" (addr), "r" (offset));
+		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
 /* replenish the buffers for a pool.  note that we don't need to
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1929847b8c40..59df4c9bd8f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -353,7 +353,8 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
+	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
 	rlan_ctx.dsize = 1;
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 86a576201f5f..0dbbb32905fa 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1262,18 +1262,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		return;
 	}
 
-	spin_lock_init(&adapter->tmreg_lock);
-	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
-
-	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
-		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
-				  igb_ptp_overflow_check);
-
-	adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-	adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-
-	igb_ptp_reset(adapter);
-
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
 						&adapter->pdev->dev);
 	if (IS_ERR(adapter->ptp_clock)) {
@@ -1283,6 +1271,18 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
+
+		spin_lock_init(&adapter->tmreg_lock);
+		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
+
+		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+			INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
+					  igb_ptp_overflow_check);
+
+		adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+		adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
+
+		igb_ptp_reset(adapter);
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 449f5224d1ae..e549b09c347a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2876,9 +2876,10 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-	nix_find_link_frs(rvu, req, pcifunc);
 
 linkcfg:
+	nix_find_link_frs(rvu, req, pcifunc);
+
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link));
 	cfg = (cfg & ~(0xFFFFULL << 16)) | ((u64)req->maxlen << 16);
 	if (req->update_minlen)
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 60b7d93bb834..93be7dd571fc 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -745,7 +745,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 		write_pnet(&port->pnet, newnet);
 
-		ipvlan_migrate_l3s_hook(oldnet, newnet);
+		if (port->mode == IPVLAN_MODE_L3S)
+			ipvlan_migrate_l3s_hook(oldnet, newnet);
 		break;
 	}
 	case NETDEV_UNREGISTER:
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 5aa23a036ed3..4ba86fa4d649 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1313,10 +1313,7 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 
 		nla_peer = data[VETH_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifla(peer_tb,
-					  nla_data(nla_peer) + sizeof(struct ifinfomsg),
-					  nla_len(nla_peer) - sizeof(struct ifinfomsg),
-					  NULL);
+		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		if (err < 0)
 			return err;
 
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index fe64430b438a..be26346085fa 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -63,15 +63,14 @@ int of_reconfig_notifier_unregister(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
 
-#ifdef DEBUG
-const char *action_names[] = {
+static const char *action_names[] = {
+	[0] = "INVALID",
 	[OF_RECONFIG_ATTACH_NODE] = "ATTACH_NODE",
 	[OF_RECONFIG_DETACH_NODE] = "DETACH_NODE",
 	[OF_RECONFIG_ADD_PROPERTY] = "ADD_PROPERTY",
 	[OF_RECONFIG_REMOVE_PROPERTY] = "REMOVE_PROPERTY",
 	[OF_RECONFIG_UPDATE_PROPERTY] = "UPDATE_PROPERTY",
 };
-#endif
 
 int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
 {
@@ -589,21 +588,9 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		}
 
 		ret = __of_add_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: add_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	case OF_RECONFIG_REMOVE_PROPERTY:
 		ret = __of_remove_property(ce->np, ce->prop);
-		if (ret) {
-			pr_err("changeset: remove_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 
 	case OF_RECONFIG_UPDATE_PROPERTY:
@@ -617,20 +604,17 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
 		}
 
 		ret = __of_update_property(ce->np, ce->prop, &old_prop);
-		if (ret) {
-			pr_err("changeset: update_property failed @%pOF/%s\n",
-				ce->np,
-				ce->prop->name);
-			break;
-		}
 		break;
 	default:
 		ret = -EINVAL;
 	}
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
-	if (ret)
+	if (ret) {
+		pr_err("changeset: apply failed: %-15s %pOF:%s\n",
+		       action_names[ce->action], ce->np, ce->prop->name);
 		return ret;
+	}
 
 	switch (ce->action) {
 	case OF_RECONFIG_ATTACH_NODE:
@@ -913,6 +897,9 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	if (!ce)
 		return -ENOMEM;
 
+	if (WARN_ON(action >= ARRAY_SIZE(action_names)))
+		return -EINVAL;
+
 	/* get a reference to the node */
 	ce->action = action;
 	ce->np = of_node_get(np);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index f031302ad401..0a37967b0a93 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -503,12 +503,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					__pci_bus_size_bridges(dev->subordinate,
-							       &add_list);
+					if (pci_is_root_bus(bus))
+						__pci_bus_size_bridges(dev->subordinate, &add_list);
 				}
 			}
 		}
-		__pci_bus_assign_resources(bus, &add_list, NULL);
+		if (pci_is_root_bus(bus))
+			__pci_bus_assign_resources(bus, &add_list, NULL);
+		else
+			pci_assign_unassigned_bridge_resources(bus->self);
 	}
 
 	acpiphp_sanitize_bus(bus);
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 32829eb9656c..ddd8ee6b604e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -14,6 +14,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/pinmux.h>
 
@@ -46,6 +47,7 @@ struct rza2_pinctrl_priv {
 	struct pinctrl_dev *pctl;
 	struct pinctrl_gpio_range gpio_range;
 	int npins;
+	struct mutex mutex; /* serialize adding groups and functions */
 };
 
 #define RZA2_PDR(port)		(0x0000 + (port) * 2)	/* Direction 16-bit */
@@ -359,10 +361,14 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 		psel_val[i] = MUX_FUNC(value);
 	}
 
+	mutex_lock(&priv->mutex);
+
 	/* Register a single pin group listing all the pins we read from DT */
 	gsel = pinctrl_generic_add_group(pctldev, np->name, pins, npins, NULL);
-	if (gsel < 0)
-		return gsel;
+	if (gsel < 0) {
+		ret = gsel;
+		goto unlock;
+	}
 
 	/*
 	 * Register a single group function where the 'data' is an array PSEL
@@ -391,6 +397,8 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 	(*map)->data.mux.function = np->name;
 	*num_maps = 1;
 
+	mutex_unlock(&priv->mutex);
+
 	return 0;
 
 remove_function:
@@ -399,6 +407,9 @@ static int rza2_dt_node_to_map(struct pinctrl_dev *pctldev,
 remove_group:
 	pinctrl_generic_remove_group(pctldev, gsel);
 
+unlock:
+	mutex_unlock(&priv->mutex);
+
 	dev_err(priv->dev, "Unable to parse DT node %s\n", np->name);
 
 	return ret;
@@ -474,6 +485,8 @@ static int rza2_pinctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	mutex_init(&priv->mutex);
+
 	platform_set_drvdata(pdev, priv);
 
 	priv->npins = (int)(uintptr_t)of_device_get_match_data(&pdev->dev) *
diff --git a/drivers/scsi/raid_class.c b/drivers/scsi/raid_class.c
index 711252e52d8e..95a86e0dfd77 100644
--- a/drivers/scsi/raid_class.c
+++ b/drivers/scsi/raid_class.c
@@ -209,54 +209,6 @@ raid_attr_ro_state(level);
 raid_attr_ro_fn(resync);
 raid_attr_ro_state_fn(state);
 
-static void raid_component_release(struct device *dev)
-{
-	struct raid_component *rc =
-		container_of(dev, struct raid_component, dev);
-	dev_printk(KERN_ERR, rc->dev.parent, "COMPONENT RELEASE\n");
-	put_device(rc->dev.parent);
-	kfree(rc);
-}
-
-int raid_component_add(struct raid_template *r,struct device *raid_dev,
-		       struct device *component_dev)
-{
-	struct device *cdev =
-		attribute_container_find_class_device(&r->raid_attrs.ac,
-						      raid_dev);
-	struct raid_component *rc;
-	struct raid_data *rd = dev_get_drvdata(cdev);
-	int err;
-
-	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&rc->node);
-	device_initialize(&rc->dev);
-	rc->dev.release = raid_component_release;
-	rc->dev.parent = get_device(component_dev);
-	rc->num = rd->component_count++;
-
-	dev_set_name(&rc->dev, "component-%d", rc->num);
-	list_add_tail(&rc->node, &rd->component_list);
-	rc->dev.class = &raid_class.class;
-	err = device_add(&rc->dev);
-	if (err)
-		goto err_out;
-
-	return 0;
-
-err_out:
-	put_device(&rc->dev);
-	list_del(&rc->node);
-	rd->component_count--;
-	put_device(component_dev);
-	kfree(rc);
-	return err;
-}
-EXPORT_SYMBOL(raid_component_add);
-
 struct raid_template *
 raid_class_attach(struct raid_function_template *ft)
 {
diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index c445853c623e..e362453e8d26 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -317,12 +317,11 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
-		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
 		spin_unlock_irqrestore(snic->shost->host_lock, flags);
-		kfree(tgt);
+		put_device(&tgt->dev);
 		tgt = NULL;
 
 		return tgt;
diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index a4d05b1b17d7..665ef7a0a249 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -188,23 +188,29 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 {
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 bit_mask, end_mask, eorx, shift;
-	const char *s = image->data, *src;
+	u32 bit_mask, eorx, shift;
+	const u8 *s = image->data, *src;
 	u32 *dst;
-	const u32 *tab = NULL;
+	const u32 *tab;
+	size_t tablen;
+	u32 colortab[16];
 	int i, j, k;
 
 	switch (bpp) {
 	case 8:
 		tab = fb_be_math(p) ? cfb_tab8_be : cfb_tab8_le;
+		tablen = 16;
 		break;
 	case 16:
 		tab = fb_be_math(p) ? cfb_tab16_be : cfb_tab16_le;
+		tablen = 4;
 		break;
 	case 32:
-	default:
 		tab = cfb_tab32;
+		tablen = 2;
 		break;
+	default:
+		return;
 	}
 
 	for (i = ppw-1; i--; ) {
@@ -218,20 +224,62 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 	eorx = fgx ^ bgx;
 	k = image->width/ppw;
 
+	for (i = 0; i < tablen; ++i)
+		colortab[i] = (tab[i] & eorx) ^ bgx;
+
 	for (i = image->height; i--; ) {
 		dst = dst1;
 		shift = 8;
 		src = s;
 
-		for (j = k; j--; ) {
+		/*
+		 * Manually unroll the per-line copying loop for better
+		 * performance. This works until we processed the last
+		 * completely filled source byte (inclusive).
+		 */
+		switch (ppw) {
+		case 4: /* 8 bpp */
+			for (j = k; j >= 2; j -= 2, ++src) {
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		case 2: /* 16 bpp */
+			for (j = k; j >= 4; j -= 4, ++src) {
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		case 1: /* 32 bpp */
+			for (j = k; j >= 8; j -= 8, ++src) {
+				*dst++ = colortab[(*src >> 7) & bit_mask];
+				*dst++ = colortab[(*src >> 6) & bit_mask];
+				*dst++ = colortab[(*src >> 5) & bit_mask];
+				*dst++ = colortab[(*src >> 4) & bit_mask];
+				*dst++ = colortab[(*src >> 3) & bit_mask];
+				*dst++ = colortab[(*src >> 2) & bit_mask];
+				*dst++ = colortab[(*src >> 1) & bit_mask];
+				*dst++ = colortab[(*src >> 0) & bit_mask];
+			}
+			break;
+		}
+
+		/*
+		 * For image widths that are not a multiple of 8, there
+		 * are trailing pixels left on the current line. Print
+		 * them as well.
+		 */
+		for (; j--; ) {
 			shift -= ppw;
-			end_mask = tab[(*src >> shift) & bit_mask];
-			*dst++ = (end_mask & eorx) ^ bgx;
+			*dst++ = colortab[(*src >> shift) & bit_mask];
 			if (!shift) {
 				shift = 8;
-				src++;
+				++src;
 			}
 		}
+
 		dst1 += p->fix.line_length;
 		s += spitch;
 	}
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index dde9afb6747b..51ab06308bc7 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1856,7 +1856,7 @@ static void del_timeout(struct dlm_lkb *lkb)
 void dlm_scan_timeout(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	int do_cancel, do_warn;
 	s64 wait_us;
 
@@ -1867,27 +1867,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
 		do_cancel = 0;
 		do_warn = 0;
 		mutex_lock(&ls->ls_timeout_mutex);
-		list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list) {
+		list_for_each_entry(iter, &ls->ls_timeout, lkb_time_list) {
 
 			wait_us = ktime_to_us(ktime_sub(ktime_get(),
-					      		lkb->lkb_timestamp));
+							iter->lkb_timestamp));
 
-			if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
-			    wait_us >= (lkb->lkb_timeout_cs * 10000))
+			if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
+			    wait_us >= (iter->lkb_timeout_cs * 10000))
 				do_cancel = 1;
 
-			if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
+			if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
 			    wait_us >= dlm_config.ci_timewarn_cs * 10000)
 				do_warn = 1;
 
 			if (!do_cancel && !do_warn)
 				continue;
-			hold_lkb(lkb);
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 		mutex_unlock(&ls->ls_timeout_mutex);
 
-		if (!do_cancel && !do_warn)
+		if (!lkb)
 			break;
 
 		r = lkb->lkb_resource;
@@ -5241,21 +5242,18 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 
 static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
-	struct dlm_lkb *lkb;
-	int found = 0;
+	struct dlm_lkb *lkb = NULL, *iter;
 
 	mutex_lock(&ls->ls_waiters_mutex);
-	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
-		if (lkb->lkb_flags & DLM_IFL_RESEND) {
-			hold_lkb(lkb);
-			found = 1;
+	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
+		if (iter->lkb_flags & DLM_IFL_RESEND) {
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
 
-	if (!found)
-		lkb = NULL;
 	return lkb;
 }
 
@@ -5914,37 +5912,36 @@ int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 		     int mode, uint32_t flags, void *name, unsigned int namelen,
 		     unsigned long timeout_cs, uint32_t *lkid)
 {
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	struct dlm_user_args *ua;
 	int found_other_mode = 0;
-	int found = 0;
 	int rv = 0;
 
 	mutex_lock(&ls->ls_orphans_mutex);
-	list_for_each_entry(lkb, &ls->ls_orphans, lkb_ownqueue) {
-		if (lkb->lkb_resource->res_length != namelen)
+	list_for_each_entry(iter, &ls->ls_orphans, lkb_ownqueue) {
+		if (iter->lkb_resource->res_length != namelen)
 			continue;
-		if (memcmp(lkb->lkb_resource->res_name, name, namelen))
+		if (memcmp(iter->lkb_resource->res_name, name, namelen))
 			continue;
-		if (lkb->lkb_grmode != mode) {
+		if (iter->lkb_grmode != mode) {
 			found_other_mode = 1;
 			continue;
 		}
 
-		found = 1;
-		list_del_init(&lkb->lkb_ownqueue);
-		lkb->lkb_flags &= ~DLM_IFL_ORPHAN;
-		*lkid = lkb->lkb_id;
+		lkb = iter;
+		list_del_init(&iter->lkb_ownqueue);
+		iter->lkb_flags &= ~DLM_IFL_ORPHAN;
+		*lkid = iter->lkb_id;
 		break;
 	}
 	mutex_unlock(&ls->ls_orphans_mutex);
 
-	if (!found && found_other_mode) {
+	if (!lkb && found_other_mode) {
 		rv = -EAGAIN;
 		goto out;
 	}
 
-	if (!found) {
+	if (!lkb) {
 		rv = -ENOENT;
 		goto out;
 	}
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index f3482e936cc2..28735e8c5e20 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -80,8 +80,7 @@ static void send_op(struct plock_op *op)
    abandoned waiter.  So, we have to insert the unlock-close when the
    lock call is interrupted. */
 
-static void do_unlock_close(struct dlm_ls *ls, u64 number,
-			    struct file *file, struct file_lock *fl)
+static void do_unlock_close(const struct dlm_plock_info *info)
 {
 	struct plock_op *op;
 
@@ -90,15 +89,12 @@ static void do_unlock_close(struct dlm_ls *ls, u64 number,
 		return;
 
 	op->info.optype		= DLM_PLOCK_OP_UNLOCK;
-	op->info.pid		= fl->fl_pid;
-	op->info.fsid		= ls->ls_global_id;
-	op->info.number		= number;
+	op->info.pid		= info->pid;
+	op->info.fsid		= info->fsid;
+	op->info.number		= info->number;
 	op->info.start		= 0;
 	op->info.end		= OFFSET_MAX;
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
-		op->info.owner	= (__u64) fl->fl_pid;
-	else
-		op->info.owner	= (__u64)(long) fl->fl_owner;
+	op->info.owner		= info->owner;
 
 	op->info.flags |= DLM_PLOCK_FL_CLOSE;
 	send_op(op);
@@ -161,13 +157,14 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	rv = wait_event_killable(recv_wq, (op->done != 0));
 	if (rv == -ERESTARTSYS) {
-		log_debug(ls, "%s: wait killed %llx", __func__,
-			  (unsigned long long)number);
 		spin_lock(&ops_lock);
 		list_del(&op->list);
 		spin_unlock(&ops_lock);
+		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
+			  __func__, ls->ls_global_id,
+			  (unsigned long long)number, op->info.pid);
 		dlm_release_plock_op(op);
-		do_unlock_close(ls, number, file, fl);
+		do_unlock_close(&op->info);
 		goto out;
 	}
 
@@ -408,7 +405,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
 			list_del(&op->list);
 		else
-			list_move(&op->list, &recv_list);
+			list_move_tail(&op->list, &recv_list);
 		memcpy(&info, &op->info, sizeof(info));
 	}
 	spin_unlock(&ops_lock);
@@ -433,9 +430,9 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 			 loff_t *ppos)
 {
+	struct plock_op *op = NULL, *iter;
 	struct dlm_plock_info info;
-	struct plock_op *op;
-	int found = 0, do_callback = 0;
+	int do_callback = 0;
 
 	if (count != sizeof(info))
 		return -EINVAL;
@@ -446,31 +443,63 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 	if (check_version(&info))
 		return -EINVAL;
 
+	/*
+	 * The results for waiting ops (SETLKW) can be returned in any
+	 * order, so match all fields to find the op.  The results for
+	 * non-waiting ops are returned in the order that they were sent
+	 * to userspace, so match the result with the first non-waiting op.
+	 */
 	spin_lock(&ops_lock);
-	list_for_each_entry(op, &recv_list, list) {
-		if (op->info.fsid == info.fsid &&
-		    op->info.number == info.number &&
-		    op->info.owner == info.owner) {
-			list_del_init(&op->list);
-			memcpy(&op->info, &info, sizeof(info));
-			if (op->data)
-				do_callback = 1;
-			else
-				op->done = 1;
-			found = 1;
-			break;
+	if (info.wait) {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (iter->info.fsid == info.fsid &&
+			    iter->info.number == info.number &&
+			    iter->info.owner == info.owner &&
+			    iter->info.pid == info.pid &&
+			    iter->info.start == info.start &&
+			    iter->info.end == info.end &&
+			    iter->info.ex == info.ex &&
+			    iter->info.wait) {
+				op = iter;
+				break;
+			}
+		}
+	} else {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (!iter->info.wait) {
+				op = iter;
+				break;
+			}
 		}
 	}
+
+	if (op) {
+		/* Sanity check that op and info match. */
+		if (info.wait)
+			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
+		else
+			WARN_ON(op->info.fsid != info.fsid ||
+				op->info.number != info.number ||
+				op->info.owner != info.owner ||
+				op->info.optype != info.optype);
+
+		list_del_init(&op->list);
+		memcpy(&op->info, &info, sizeof(info));
+		if (op->data)
+			do_callback = 1;
+		else
+			op->done = 1;
+	}
 	spin_unlock(&ops_lock);
 
-	if (found) {
+	if (op) {
 		if (do_callback)
 			dlm_plock_callback(op);
 		else
 			wake_up(&recv_wq);
 	} else
-		log_print("dev_write no op %x %llx", info.fsid,
-			  (unsigned long long)info.number);
+		log_print("%s: no op %x %llx", __func__,
+			  info.fsid, (unsigned long long)info.number);
 	return count;
 }
 
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index 8928e99dfd47..df18f38a0273 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -732,10 +732,9 @@ void dlm_recovered_lock(struct dlm_rsb *r)
 
 static void recover_lvb(struct dlm_rsb *r)
 {
-	struct dlm_lkb *lkb, *high_lkb = NULL;
+	struct dlm_lkb *big_lkb = NULL, *iter, *high_lkb = NULL;
 	uint32_t high_seq = 0;
 	int lock_lvb_exists = 0;
-	int big_lock_exists = 0;
 	int lvblen = r->res_ls->ls_lvblen;
 
 	if (!rsb_flag(r, RSB_NEW_MASTER2) &&
@@ -751,37 +750,37 @@ static void recover_lvb(struct dlm_rsb *r)
 	/* we are the new master, so figure out if VALNOTVALID should
 	   be set, and set the rsb lvb from the best lkb available. */
 
-	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_grantqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			big_lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
-	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_convertqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			big_lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
@@ -790,7 +789,7 @@ static void recover_lvb(struct dlm_rsb *r)
 		goto out;
 
 	/* lvb is invalidated if only NL/CR locks remain */
-	if (!big_lock_exists)
+	if (!big_lkb)
 		rsb_set_flag(r, RSB_VALNOTVALID);
 
 	if (!r->res_lvbptr) {
@@ -799,9 +798,9 @@ static void recover_lvb(struct dlm_rsb *r)
 			goto out;
 	}
 
-	if (big_lock_exists) {
-		r->res_lvbseq = lkb->lkb_lvbseq;
-		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, lvblen);
+	if (big_lkb) {
+		r->res_lvbseq = big_lkb->lkb_lvbseq;
+		memcpy(r->res_lvbptr, big_lkb->lkb_lvbptr, lvblen);
 	} else if (high_lkb) {
 		r->res_lvbseq = high_lkb->lkb_lvbseq;
 		memcpy(r->res_lvbptr, high_lkb->lkb_lvbptr, lvblen);
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index c220810c61d1..fbc7304bed56 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -509,20 +509,26 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	return result;
 }
 
-static void
-nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
-	struct nfs_page *req, *next;
+	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req || req->wb_this_page == req)
+		if (req->wb_head != req)
 			continue;
-		for (next = req->wb_this_page;
-				next != req->wb_head;
-				next = next->wb_this_page) {
-			nfs_list_remove_request(next);
-			nfs_release_request(next);
-		}
+		subreq = req->wb_this_page;
+		if (subreq == req)
+			continue;
+		do {
+			/*
+			 * Remove subrequests from this list before freeing
+			 * them in the call to nfs_join_page_group().
+			 */
+			if (!list_empty(&subreq->wb_list)) {
+				nfs_list_remove_request(subreq);
+				nfs_release_request(subreq);
+			}
+		} while ((subreq = subreq->wb_this_page) != req);
 		nfs_join_page_group(req, inode);
 	}
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b9567cc8698e..c34df51a8f2b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5864,9 +5864,8 @@ static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t bu
 out_ok:
 	ret = res.acl_len;
 out_free:
-	for (i = 0; i < npages; i++)
-		if (pages[i])
-			__free_page(pages[i]);
+	while (--i >= 0)
+		__free_page(pages[i]);
 	if (res.acl_scratch)
 		__free_page(res.acl_scratch);
 	kfree(pages);
@@ -7047,8 +7046,15 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 		} else if (!nfs4_update_lock_stateid(lsp, &data->res.stateid))
 			goto out_restart;
 		break;
-	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_OLD_STATEID:
+		if (data->arg.new_lock_owner != 0 &&
+			nfs4_refresh_open_old_stateid(&data->arg.open_stateid,
+					lsp->ls_state))
+			goto out_restart;
+		if (nfs4_refresh_lock_old_stateid(&data->arg.lock_stateid, lsp))
+			goto out_restart;
+		fallthrough;
+	case -NFS4ERR_BAD_STATEID:
 	case -NFS4ERR_STALE_STATEID:
 	case -NFS4ERR_EXPIRED:
 		if (data->arg.new_lock_owner != 0) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1c1b231b2ab3..b045be7394a0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1145,9 +1145,9 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	WARN_ON(!list_empty(&dp->dl_recall_lru));
 
 	if (clp->cl_minorversion) {
+		spin_lock(&clp->cl_lock);
 		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
-		spin_lock(&clp->cl_lock);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
 	}
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index a53243abd945..881d329cee2f 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1182,7 +1182,7 @@ u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZ
 
 #define DP_BRANCH_OUI_HEADER_SIZE	0xc
 #define DP_RECEIVER_CAP_SIZE		0xf
-#define DP_DSC_RECEIVER_CAP_SIZE        0xf
+#define DP_DSC_RECEIVER_CAP_SIZE        0x10 /* DSC Capabilities 0x60 through 0x6F */
 #define EDP_PSR_RECEIVER_CAP_SIZE	2
 #define EDP_DISPLAY_CTL_CAP_SIZE	3
 
diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
index 9e50aede46c8..7bde0af29a81 100644
--- a/include/linux/ceph/msgr.h
+++ b/include/linux/ceph/msgr.h
@@ -61,11 +61,18 @@ extern const char *ceph_entity_type_name(int type);
  * entity_addr -- network address
  */
 struct ceph_entity_addr {
-	__le32 type;
+	__le32 type;  /* CEPH_ENTITY_ADDR_TYPE_* */
 	__le32 nonce;  /* unique id for process (e.g. pid) */
 	struct sockaddr_storage in_addr;
 } __attribute__ ((packed));
 
+static inline bool ceph_addr_equal_no_type(const struct ceph_entity_addr *lhs,
+					   const struct ceph_entity_addr *rhs)
+{
+	return !memcmp(&lhs->in_addr, &rhs->in_addr, sizeof(lhs->in_addr)) &&
+	       lhs->nonce == rhs->nonce;
+}
+
 struct ceph_entity_inst {
 	struct ceph_entity_name name;
 	struct ceph_entity_addr addr;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1814eabb7c20..12c85ba606ec 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -172,6 +172,39 @@ int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale);
  */
 bool clk_is_match(const struct clk *p, const struct clk *q);
 
+/**
+ * clk_rate_exclusive_get - get exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to get exclusive control over the rate of a
+ * provider. It prevents any other consumer to execute, even indirectly,
+ * opereation which could alter the rate of the provider or cause glitches
+ *
+ * If exlusivity is claimed more than once on clock, even by the same driver,
+ * the rate effectively gets locked as exclusivity can't be preempted.
+ *
+ * Must not be called from within atomic context.
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_rate_exclusive_get(struct clk *clk);
+
+/**
+ * clk_rate_exclusive_put - release exclusivity over the rate control of a
+ *                          producer
+ * @clk: clock source
+ *
+ * This function allows drivers to release the exclusivity it previously got
+ * from clk_rate_exclusive_get()
+ *
+ * The caller must balance the number of clk_rate_exclusive_get() and
+ * clk_rate_exclusive_put() calls.
+ *
+ * Must not be called from within atomic context.
+ */
+void clk_rate_exclusive_put(struct clk *clk);
+
 #else
 
 static inline int clk_notifier_register(struct clk *clk,
@@ -218,6 +251,13 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
 	return p == q;
 }
 
+static inline int clk_rate_exclusive_get(struct clk *clk)
+{
+	return 0;
+}
+
+static inline void clk_rate_exclusive_put(struct clk *clk) {}
+
 #endif
 
 /**
@@ -530,38 +570,6 @@ struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
  */
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id);
-/**
- * clk_rate_exclusive_get - get exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to get exclusive control over the rate of a
- * provider. It prevents any other consumer to execute, even indirectly,
- * opereation which could alter the rate of the provider or cause glitches
- *
- * If exlusivity is claimed more than once on clock, even by the same driver,
- * the rate effectively gets locked as exclusivity can't be preempted.
- *
- * Must not be called from within atomic context.
- *
- * Returns success (0) or negative errno.
- */
-int clk_rate_exclusive_get(struct clk *clk);
-
-/**
- * clk_rate_exclusive_put - release exclusivity over the rate control of a
- *                          producer
- * @clk: clock source
- *
- * This function allows drivers to release the exclusivity it previously got
- * from clk_rate_exclusive_get()
- *
- * The caller must balance the number of clk_rate_exclusive_get() and
- * clk_rate_exclusive_put() calls.
- *
- * Must not be called from within atomic context.
- */
-void clk_rate_exclusive_put(struct clk *clk);
 
 /**
  * clk_enable - inform the system when the clock source should be running.
@@ -921,14 +929,6 @@ static inline void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks) {}
 
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
-
-static inline int clk_rate_exclusive_get(struct clk *clk)
-{
-	return 0;
-}
-
-static inline void clk_rate_exclusive_put(struct clk *clk) {}
-
 static inline int clk_enable(struct clk *clk)
 {
 	return 0;
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 04c20de66afc..b70224370832 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -55,8 +55,10 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
-extern void cpuset_read_lock(void);
-extern void cpuset_read_unlock(void);
+extern void inc_dl_tasks_cs(struct task_struct *task);
+extern void dec_dl_tasks_cs(struct task_struct *task);
+extern void cpuset_lock(void);
+extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -178,8 +180,10 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
-static inline void cpuset_read_lock(void) { }
-static inline void cpuset_read_unlock(void) { }
+static inline void inc_dl_tasks_cs(struct task_struct *task) { }
+static inline void dec_dl_tasks_cs(struct task_struct *task) { }
+static inline void cpuset_lock(void) { }
+static inline void cpuset_unlock(void) { }
 
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index 5cdfcb873a8f..772d45b2a60a 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -77,7 +77,3 @@ DEFINE_RAID_ATTRIBUTE(enum raid_state, state)
 	
 struct raid_template *raid_class_attach(struct raid_function_template *);
 void raid_class_release(struct raid_template *);
-
-int __must_check raid_component_add(struct raid_template *, struct device *,
-				    struct device *);
-
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5da4b3c89f63..aa015416c569 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1657,7 +1657,9 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int task_can_attach(struct task_struct *p);
+extern int dl_bw_alloc(int cpu, u64 dl_bw);
+extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index a248caff969f..82d128c0fe6d 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -698,37 +698,14 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
 }
 
 /* Caller must hold rcu_read_lock() for read */
-static inline struct slave *bond_slave_has_mac_rcu(struct bonding *bond,
-					       const u8 *mac)
+static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 {
 	struct list_head *iter;
 	struct slave *tmp;
 
-	bond_for_each_slave_rcu(bond, tmp, iter)
-		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
-			return tmp;
-
-	return NULL;
-}
-
-/* Caller must hold rcu_read_lock() for read */
-static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
-{
-	struct list_head *iter;
-	struct slave *tmp;
-	struct netdev_hw_addr *ha;
-
 	bond_for_each_slave_rcu(bond, tmp, iter)
 		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
 			return true;
-
-	if (netdev_uc_empty(bond->dev))
-		return false;
-
-	netdev_for_each_uc_addr(ha, bond->dev)
-		if (ether_addr_equal_64bits(mac, ha->addr))
-			return true;
-
 	return false;
 }
 
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 4da61c950e93..5c2a73bbfabe 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -166,8 +166,8 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 int rtnl_delete_link(struct net_device *dev);
 int rtnl_configure_link(struct net_device *dev, const struct ifinfomsg *ifm);
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr);
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr);
 struct net *rtnl_get_net_ns_capable(struct sock *sk, int netnsid);
 
 #define MODULE_ALIAS_RTNL_LINK(kind) MODULE_ALIAS("rtnl-link-" kind)
diff --git a/include/net/sock.h b/include/net/sock.h
index 665e38859375..234196d90423 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1233,6 +1233,7 @@ struct proto {
 	/*
 	 * Pressure flag: try to collapse.
 	 * Technical note: it is used by multiple contexts non atomically.
+	 * Make sure to use READ_ONCE()/WRITE_ONCE() for all reads/writes.
 	 * All the __sk_mem_schedule() is of this nature: accounting
 	 * is strict, actions are advisory and have some latency.
 	 */
@@ -1349,7 +1350,7 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 static inline bool sk_under_global_memory_pressure(const struct sock *sk)
 {
 	return sk->sk_prot->memory_pressure &&
-		!!*sk->sk_prot->memory_pressure;
+		!!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline bool sk_under_memory_pressure(const struct sock *sk)
@@ -1361,7 +1362,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
 }
 
 static inline long
@@ -1415,7 +1416,7 @@ proto_memory_pressure(struct proto *prot)
 {
 	if (!prot->memory_pressure)
 		return false;
-	return !!*prot->memory_pressure;
+	return !!READ_ONCE(*prot->memory_pressure);
 }
 
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 70ed21607e47..11400eba6124 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -56,6 +56,7 @@
 #include <linux/file.h>
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/deadline.h>
 #include <linux/psi.h>
 #include <net/sock.h>
 
@@ -6326,6 +6327,9 @@ void cgroup_exit(struct task_struct *tsk)
 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 	cset->nr_tasks--;
 
+	if (dl_task(tsk))
+		dec_dl_tasks_cs(tsk);
+
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
 	if (unlikely(cgroup_task_freeze(tsk)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b476591168dc..195f9cccab20 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -161,6 +161,14 @@ struct cpuset {
 	 */
 	int use_parent_ecpus;
 	int child_ecpus_count;
+
+	/*
+	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
+	 * know when to rebuild associated root domain bandwidth information.
+	 */
+	int nr_deadline_tasks;
+	int nr_migrate_dl_tasks;
+	u64 sum_migrate_dl_bw;
 };
 
 /*
@@ -206,6 +214,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
+void inc_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks++;
+}
+
+void dec_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks--;
+}
+
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
@@ -334,16 +356,16 @@ static struct cpuset top_cpuset = {
  * guidelines for accessing subsystem state in kernel/cgroup.c
  */
 
-DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
+static DEFINE_MUTEX(cpuset_mutex);
 
-void cpuset_read_lock(void)
+void cpuset_lock(void)
 {
-	percpu_down_read(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
-void cpuset_read_unlock(void)
+void cpuset_unlock(void)
 {
-	percpu_up_read(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 static DEFINE_SPINLOCK(callback_lock);
@@ -912,11 +934,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
-static void update_tasks_root_domain(struct cpuset *cs)
+static void dl_update_tasks_root_domain(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
 
+	if (cs->nr_deadline_tasks == 0)
+		return;
+
 	css_task_iter_start(&cs->css, 0, &it);
 
 	while ((task = css_task_iter_next(&it)))
@@ -925,12 +950,12 @@ static void update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void rebuild_root_domains(void)
+static void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -953,7 +978,7 @@ static void rebuild_root_domains(void)
 
 		rcu_read_unlock();
 
-		update_tasks_root_domain(cs);
+		dl_update_tasks_root_domain(cs);
 
 		rcu_read_lock();
 		css_put(&cs->css);
@@ -967,7 +992,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	mutex_lock(&sched_domains_mutex);
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	rebuild_root_domains();
+	dl_rebuild_rd_accounting();
 	mutex_unlock(&sched_domains_mutex);
 }
 
@@ -991,7 +1016,7 @@ static void rebuild_sched_domains_locked(void)
 	int ndoms;
 
 	lockdep_assert_cpus_held();
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
@@ -1042,9 +1067,9 @@ static void rebuild_sched_domains_locked(void)
 void rebuild_sched_domains(void)
 {
 	get_online_cpus();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	rebuild_sched_domains_locked();
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	put_online_cpus();
 }
 
@@ -1160,7 +1185,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	int new_prs;
 	bool part_error = false;	/* Partition error? */
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * The parent must be a partition root.
@@ -1490,7 +1515,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
@@ -2145,19 +2170,26 @@ static int fmeter_getrate(struct fmeter *fmp)
 
 static struct cpuset *cpuset_attach_old_cs;
 
+static void reset_migrate_dl_data(struct cpuset *cs)
+{
+	cs->nr_migrate_dl_tasks = 0;
+	cs->sum_migrate_dl_bw = 0;
+}
+
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
+	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	int ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
+	oldcs = cpuset_attach_old_cs;
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* allow moving tasks into an empty cpuset if on default hierarchy */
 	ret = -ENOSPC;
@@ -2166,14 +2198,39 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->effective_cpus);
+		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
+
+		if (dl_task(task)) {
+			cs->nr_migrate_dl_tasks++;
+			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+		}
 	}
 
+	if (!cs->nr_migrate_dl_tasks)
+		goto out_success;
+
+	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
+		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+
+		if (unlikely(cpu >= nr_cpu_ids)) {
+			reset_migrate_dl_data(cs);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+		if (ret) {
+			reset_migrate_dl_data(cs);
+			goto out_unlock;
+		}
+	}
+
+out_success:
 	/*
 	 * Mark attach is in progress.  This makes validate_change() fail
 	 * changes which zero cpus/mems_allowed.
@@ -2181,7 +2238,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs->attach_in_progress++;
 	ret = 0;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -2193,11 +2250,19 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
-	percpu_up_write(&cpuset_rwsem);
+
+	if (cs->nr_migrate_dl_tasks) {
+		int cpu = cpumask_any(cs->effective_cpus);
+
+		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
+		reset_migrate_dl_data(cs);
+	}
+
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -2221,7 +2286,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* prepare for attach */
 	if (cs == &top_cpuset)
@@ -2271,11 +2336,17 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
+	if (cs->nr_migrate_dl_tasks) {
+		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
+		reset_migrate_dl_data(cs);
+	}
+
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /* The various types of files and directories in a cpuset file system */
@@ -2307,7 +2378,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = 0;
 
 	get_online_cpus();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -2343,7 +2414,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	put_online_cpus();
 	return retval;
 }
@@ -2356,7 +2427,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = -ENODEV;
 
 	get_online_cpus();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2369,7 +2440,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	put_online_cpus();
 	return retval;
 }
@@ -2410,7 +2481,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	flush_work(&cpuset_hotplug_work);
 
 	get_online_cpus();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2434,7 +2505,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	put_online_cpus();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
@@ -2567,13 +2638,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 
 	css_get(&cs->css);
 	get_online_cpus();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
 	retval = update_prstate(cs, val);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	put_online_cpus();
 	css_put(&cs->css);
 	return retval ?: nbytes;
@@ -2781,7 +2852,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		return 0;
 
 	get_online_cpus();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
@@ -2832,7 +2903,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	put_online_cpus();
 	return 0;
 }
@@ -2853,7 +2924,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	struct cpuset *cs = css_cs(css);
 
 	get_online_cpus();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	if (is_partition_root(cs))
 		update_prstate(cs, 0);
@@ -2872,7 +2943,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	put_online_cpus();
 }
 
@@ -2885,7 +2956,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
@@ -2898,7 +2969,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 	}
 
 	spin_unlock_irq(&callback_lock);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -2940,8 +3011,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 
 int __init cpuset_init(void)
 {
-	BUG_ON(percpu_init_rwsem(&cpuset_rwsem));
-
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
@@ -3013,7 +3082,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
@@ -3023,7 +3092,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	if (is_empty)
 		remove_tasks_in_empty_cpuset(cs);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
 static void
@@ -3073,14 +3142,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/*
 	 * We have raced with task attaching. We wait until attaching
 	 * is finished, so we won't attach a task to an empty cpuset.
 	 */
 	if (cs->attach_in_progress) {
-		percpu_up_write(&cpuset_rwsem);
+		mutex_unlock(&cpuset_mutex);
 		goto retry;
 	}
 
@@ -3152,7 +3221,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /**
@@ -3182,7 +3251,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
@@ -3239,7 +3308,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		update_tasks_nodemask(&top_cpuset);
 	}
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/* if cpus or mems changed, we need to propagate to descendants */
 	if (cpus_updated || mems_updated) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9d6dd14cfd26..40f40f359c5d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5221,6 +5221,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct rq *rq;
+	bool cpuset_locked = false;
 
 	/* The pi code expects interrupts enabled */
 	BUG_ON(pi && in_interrupt());
@@ -5318,8 +5319,14 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
-	if (pi)
-		cpuset_read_lock();
+	/*
+	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
+	 * information.
+	 */
+	if (dl_policy(policy) || dl_policy(p->policy)) {
+		cpuset_locked = true;
+		cpuset_lock();
+	}
 
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
@@ -5395,8 +5402,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (pi)
-			cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		goto recheck;
 	}
 
@@ -5462,7 +5469,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
-		cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		rt_mutex_adjust_pi(p);
 	}
 
@@ -5474,8 +5482,8 @@ static int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	if (pi)
-		cpuset_read_unlock();
+	if (cpuset_locked)
+		cpuset_unlock();
 	return retval;
 }
 
@@ -6592,8 +6600,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_effective_cpus)
+int task_can_attach(struct task_struct *p)
 {
 	int ret = 0;
 
@@ -6606,21 +6613,9 @@ int task_can_attach(struct task_struct *p,
 	 * success of set_cpus_allowed_ptr() on all attached tasks
 	 * before cpus_mask may be changed.
 	 */
-	if (p->flags & PF_NO_SETAFFINITY) {
+	if (p->flags & PF_NO_SETAFFINITY)
 		ret = -EINVAL;
-		goto out;
-	}
 
-	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs_effective_cpus);
-
-		if (unlikely(cpu >= nr_cpu_ids))
-			return -EINVAL;
-		ret = dl_cpu_busy(cpu, p);
-	}
-
-out:
 	return ret;
 }
 
@@ -6877,7 +6872,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_cpu_busy(cpu, NULL);
+		int ret = dl_bw_check_overflow(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f59cb3e8a613..d91295d3059f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -17,6 +17,7 @@
  */
 #include "sched.h"
 #include "pelt.h"
+#include <linux/cpuset.h>
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -2417,6 +2418,12 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
+	/*
+	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
+	 * keep track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	dec_dl_tasks_cs(p);
+
 	if (!task_on_rq_queued(p)) {
 		/*
 		 * Inactive timer is armed. However, p is leaving DEADLINE and
@@ -2457,6 +2464,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 		put_task_struct(p);
 
+	/*
+	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
+	 * track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	inc_dl_tasks_cs(p);
+
 	/* If p is not queued we will update its parameters at next wakeup. */
 	if (!task_on_rq_queued(p)) {
 		add_rq_bw(&p->dl, &rq->dl);
@@ -2845,26 +2858,38 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int dl_cpu_busy(int cpu, struct task_struct *p)
+enum dl_bw_request {
+	dl_bw_req_check_overflow = 0,
+	dl_bw_req_alloc,
+	dl_bw_req_free
+};
+
+static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags, cap;
+	unsigned long flags;
 	struct dl_bw *dl_b;
-	bool overflow;
+	bool overflow = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cap = dl_bw_capacity(cpu);
-	overflow = __dl_overflow(dl_b, cap, 0, p ? p->dl.dl_bw : 0);
 
-	if (!overflow && p) {
-		/*
-		 * We reserve space for this task in the destination
-		 * root_domain, as we can't fail after this point.
-		 * We will free resources in the source root_domain
-		 * later on (see set_cpus_allowed_dl()).
-		 */
-		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
+	if (req == dl_bw_req_free) {
+		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
+	} else {
+		unsigned long cap = dl_bw_capacity(cpu);
+
+		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
+
+		if (req == dl_bw_req_alloc && !overflow) {
+			/*
+			 * We reserve space in the destination
+			 * root_domain, as we can't fail after this point.
+			 * We will free resources in the source root_domain
+			 * later on (see set_cpus_allowed_dl()).
+			 */
+			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
+		}
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -2872,6 +2897,21 @@ int dl_cpu_busy(int cpu, struct task_struct *p)
 
 	return overflow ? -EBUSY : 0;
 }
+
+int dl_bw_check_overflow(int cpu)
+{
+	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+}
+
+int dl_bw_alloc(int cpu, u64 dl_bw)
+{
+	return dl_bw_manage(dl_bw_req_alloc, cpu, dl_bw);
+}
+
+void dl_bw_free(int cpu, u64 dl_bw)
+{
+	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
+}
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 852e856eed48..8de07aba8bdd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -348,7 +348,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_cpu_busy(int cpu, struct task_struct *p);
+extern int  dl_bw_check_overflow(int cpu);
 
 #ifdef CONFIG_CGROUP_SCHED
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d07de3ff42ac..fc79b04b5947 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -148,6 +148,8 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
 
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
@@ -175,6 +177,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
+	/*
+	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * or VMEXIT'ed for several msecs), force an update.
+	 */
+	if (ts->last_tick_jiffies != jiffies) {
+		ts->stalled_jiffies = 0;
+		ts->last_tick_jiffies = READ_ONCE(jiffies);
+	} else {
+		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
+			tick_do_update_jiffies64(now);
+			ts->stalled_jiffies = 0;
+			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		}
+	}
+
 	if (ts->inidle)
 		ts->got_idle_tick = 1;
 }
@@ -867,6 +884,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	if (unlikely(expires == KTIME_MAX)) {
 		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1257,9 +1276,15 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
 
-	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		/*
+		 * The clockevent device is not reprogrammed, so change the
+		 * clock event device to ONESHOT_STOPPED to avoid spurious
+		 * interrupts on devices which might not be truly one shot.
+		 */
+		tick_program_event(KTIME_MAX, 1);
 		return;
+	}
 
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 4fb06527cf64..1e7ec5c968a5 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -49,6 +49,8 @@ enum tick_nohz_mode {
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @next_timer:		Expiry time of next expiring timer for debugging purpose only
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -77,6 +79,8 @@ struct tick_sched {
 	u64				next_timer;
 	ktime_t				idle_expires;
 	atomic_t			tick_dep_mask;
+	unsigned long			last_tick_jiffies;
+	unsigned int			stalled_jiffies;
 };
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
diff --git a/kernel/torture.c b/kernel/torture.c
index 1061492f14bd..458a5eed9454 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -788,7 +788,7 @@ void torture_kthread_stopping(char *title)
 	VERBOSE_TOROUT_STRING(buf);
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb(title);
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	}
 }
 EXPORT_SYMBOL_GPL(torture_kthread_stopping);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 167f2a19fd8a..597487a7f1bf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3782,8 +3782,15 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	 * will point to the same string as current_trace->name.
 	 */
 	mutex_lock(&trace_types_lock);
-	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name))
+	if (unlikely(tr->current_trace && iter->trace->name != tr->current_trace->name)) {
+		/* Close iter->trace before switching to the new current tracer */
+		if (iter->trace->close)
+			iter->trace->close(iter);
 		*iter->trace = *tr->current_trace;
+		/* Reopen the new current tracer */
+		if (iter->trace->open)
+			iter->trace->open(iter);
+	}
 	mutex_unlock(&trace_types_lock);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -4843,11 +4850,17 @@ int tracing_set_cpumask(struct trace_array *tr,
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 	}
 	arch_spin_unlock(&tr->max_lock);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index ee4571b624bc..619a60944bb6 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -228,7 +228,8 @@ static void irqsoff_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
-
+	else
+		iter->private = NULL;
 }
 
 static void irqsoff_trace_close(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 97b10bb31a1f..037e1e863b17 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -171,6 +171,8 @@ static void wakeup_trace_open(struct trace_iterator *iter)
 {
 	if (is_graph(iter->tr))
 		graph_trace_open(iter);
+	else
+		iter->private = NULL;
 }
 
 static void wakeup_trace_close(struct trace_iterator *iter)
diff --git a/lib/clz_ctz.c b/lib/clz_ctz.c
index 0d3a686b5ba2..fb8c0c5c2bd2 100644
--- a/lib/clz_ctz.c
+++ b/lib/clz_ctz.c
@@ -28,36 +28,16 @@ int __weak __clzsi2(int val)
 }
 EXPORT_SYMBOL(__clzsi2);
 
-int __weak __clzdi2(long val);
-int __weak __ctzdi2(long val);
-#if BITS_PER_LONG == 32
-
-int __weak __clzdi2(long val)
+int __weak __clzdi2(u64 val);
+int __weak __clzdi2(u64 val)
 {
-	return 32 - fls((int)val);
+	return 64 - fls64(val);
 }
 EXPORT_SYMBOL(__clzdi2);
 
-int __weak __ctzdi2(long val)
+int __weak __ctzdi2(u64 val);
+int __weak __ctzdi2(u64 val)
 {
-	return __ffs((u32)val);
+	return __ffs64(val);
 }
 EXPORT_SYMBOL(__ctzdi2);
-
-#elif BITS_PER_LONG == 64
-
-int __weak __clzdi2(long val)
-{
-	return 64 - fls64((u64)val);
-}
-EXPORT_SYMBOL(__clzdi2);
-
-int __weak __ctzdi2(long val)
-{
-	return __ffs64((u64)val);
-}
-EXPORT_SYMBOL(__ctzdi2);
-
-#else
-#error BITS_PER_LONG not 32 or 64
-#endif
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 3a4da11b804d..cbc691525236 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1133,7 +1133,6 @@ static void set_iter_tags(struct radix_tree_iter *iter,
 void __rcu **radix_tree_iter_resume(void __rcu **slot,
 					struct radix_tree_iter *iter)
 {
-	slot++;
 	iter->index = __radix_tree_iter_add(iter, 1);
 	iter->next_index = iter->index;
 	iter->tags = 0;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b21dd4a79392..652283a1353d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1690,70 +1690,51 @@ EXPORT_SYMBOL(unpoison_memory);
 
 /*
  * Safely get reference count of an arbitrary page.
- * Returns 0 for a free page, -EIO for a zero refcount page
- * that is not free, and 1 for any other page type.
- * For 1 the page is returned with increased page count, otherwise not.
+ * Returns 0 for a free page, 1 for an in-use page, -EIO for a page-type we
+ * cannot handle and -EBUSY if we raced with an allocation.
+ * We only incremented refcount in case the page was already in-use and it is
+ * a known type we can handle.
  */
-static int __get_any_page(struct page *p, unsigned long pfn, int flags)
+static int get_any_page(struct page *p, int flags)
 {
-	int ret;
+	int ret = 0, pass = 0;
+	bool count_increased = false;
 
 	if (flags & MF_COUNT_INCREASED)
-		return 1;
-
-	/*
-	 * When the target page is a free hugepage, just remove it
-	 * from free hugepage list.
-	 */
-	if (!get_hwpoison_page(p)) {
-		if (PageHuge(p)) {
-			pr_info("%s: %#lx free huge page\n", __func__, pfn);
-			ret = 0;
-		} else if (is_free_buddy_page(p)) {
-			pr_info("%s: %#lx free buddy page\n", __func__, pfn);
-			ret = 0;
-		} else if (page_count(p)) {
-			/* raced with allocation */
+		count_increased = true;
+
+try_again:
+	if (!count_increased && !get_hwpoison_page(p)) {
+		if (page_count(p)) {
+			/* We raced with an allocation, retry. */
+			if (pass++ < 3)
+				goto try_again;
 			ret = -EBUSY;
-		} else {
-			pr_info("%s: %#lx: unknown zero refcount page type %lx\n",
-				__func__, pfn, p->flags);
+		} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
+			/* We raced with put_page, retry. */
+			if (pass++ < 3)
+				goto try_again;
 			ret = -EIO;
 		}
 	} else {
-		/* Not a free page */
-		ret = 1;
-	}
-	return ret;
-}
-
-static int get_any_page(struct page *page, unsigned long pfn, int flags)
-{
-	int ret = __get_any_page(page, pfn, flags);
-
-	if (ret == -EBUSY)
-		ret = __get_any_page(page, pfn, flags);
-
-	if (ret == 1 && !PageHuge(page) &&
-	    !PageLRU(page) && !__PageMovable(page)) {
-		/*
-		 * Try to free it.
-		 */
-		put_page(page);
-		shake_page(page, 1);
-
-		/*
-		 * Did it turn free?
-		 */
-		ret = __get_any_page(page, pfn, 0);
-		if (ret == 1 && !PageLRU(page)) {
-			/* Drop page reference which is from __get_any_page() */
-			put_page(page);
-			pr_info("soft_offline: %#lx: unknown non LRU page type %lx (%pGp)\n",
-				pfn, page->flags, &page->flags);
-			return -EIO;
+		if (PageHuge(p) || PageLRU(p) || __PageMovable(p)) {
+			ret = 1;
+		} else {
+			/*
+			 * A page we cannot handle. Check whether we can turn
+			 * it into something we can handle.
+			 */
+			if (pass++ < 3) {
+				put_page(p);
+				shake_page(p, 1);
+				count_increased = false;
+				goto try_again;
+			}
+			put_page(p);
+			ret = -EIO;
 		}
 	}
+
 	return ret;
 }
 
@@ -1876,14 +1857,10 @@ static int soft_offline_in_use_page(struct page *page)
 	return __soft_offline_page(page);
 }
 
-static int soft_offline_free_page(struct page *page)
+static void put_ref_page(struct page *page)
 {
-	int rc = 0;
-
-	if (!page_handle_poison(page, true, false))
-		rc = -EBUSY;
-
-	return rc;
+	if (page)
+		put_page(page);
 }
 
 /**
@@ -1911,36 +1888,49 @@ static int soft_offline_free_page(struct page *page)
 int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
-	struct page *page;
 	bool try_again = true;
+	struct page *page, *ref_page = NULL;
+
+	WARN_ON_ONCE(!pfn_valid(pfn) && (flags & MF_COUNT_INCREASED));
 
 	if (!pfn_valid(pfn))
 		return -ENXIO;
+	if (flags & MF_COUNT_INCREASED)
+		ref_page = pfn_to_page(pfn);
+
 	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
 	page = pfn_to_online_page(pfn);
-	if (!page)
+	if (!page) {
+		put_ref_page(ref_page);
 		return -EIO;
+	}
 
 	if (PageHWPoison(page)) {
-		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_page(page);
+		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
+		put_ref_page(ref_page);
 		return 0;
 	}
 
 retry:
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, flags);
 	put_online_mems();
 
-	if (ret > 0)
+	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
-	else if (ret == 0)
-		if (soft_offline_free_page(page) && try_again) {
-			try_again = false;
-			flags &= ~MF_COUNT_INCREASED;
-			goto retry;
+	} else if (ret == 0) {
+		if (!page_handle_poison(page, true, false)) {
+			if (try_again) {
+				try_again = false;
+				flags &= ~MF_COUNT_INCREASED;
+				goto retry;
+			}
+			ret = -EBUSY;
 		}
+	} else if (ret == -EIO) {
+		pr_info("%s: %#lx: unknown page type: %lx (%pGp)\n",
+			 __func__, pfn, page->flags, &page->flags);
+	}
 
 	return ret;
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fff03a331314..d6a4794fa8ca 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2453,6 +2453,10 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 		free_vm_area(area);
 		return NULL;
 	}
+
+	flush_cache_vmap((unsigned long)area->addr,
+			 (unsigned long)area->addr + count * PAGE_SIZE);
+
 	return area->addr;
 }
 EXPORT_SYMBOL_GPL(vmap_pfn);
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 79a7dfc32e76..83586f1dd8d7 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -509,7 +509,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr;
 	bool res;
 	int ret = NET_RX_DROP;
 
@@ -517,6 +517,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	if (!res)
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 8c1148fc73d7..c451694fdb42 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -123,8 +123,10 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		kfree_skb(skb);
 		return;
+	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
@@ -998,7 +1000,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm2_packet *ogm_packet;
-	struct ethhdr *ethhdr = eth_hdr(skb);
+	struct ethhdr *ethhdr;
 	int ogm_offset;
 	u8 *packet_pos;
 	int ret = NET_RX_DROP;
@@ -1012,6 +1014,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index fe0898a9b4e8..fe79bfc6d2dd 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -632,7 +632,19 @@ int batadv_hardif_min_mtu(struct net_device *soft_iface)
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	soft_iface->mtu = batadv_hardif_min_mtu(soft_iface);
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	int limit_mtu;
+	int mtu;
+
+	mtu = batadv_hardif_min_mtu(soft_iface);
+
+	if (bat_priv->mtu_set_by_user)
+		limit_mtu = bat_priv->mtu_set_by_user;
+	else
+		limit_mtu = ETH_DATA_LEN;
+
+	mtu = min(mtu, limit_mtu);
+	dev_set_mtu(soft_iface, mtu);
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 121459704b06..931bc3b5c6df 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -496,7 +496,10 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
 		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+
+		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->soft_iface);
+		rtnl_unlock();
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 8f7c778255fb..7ac16d7b94a2 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -156,11 +156,14 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+
 	/* check ranges */
 	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
+	bat_priv->mtu_set_by_user = new_mtu;
 
 	return 0;
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f990a206107..9e8ebac9b7e7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -775,7 +775,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		if (roamed_back) {
 			batadv_tt_global_free(bat_priv, tt_global,
 					      "Roaming canceled");
-			tt_global = NULL;
 		} else {
 			/* The global entry has to be marked as ROAMING and
 			 * has to be kept for consistency purpose
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 965336a3b89d..7d47fe7534c1 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1566,6 +1566,12 @@ struct batadv_priv {
 	/** @soft_iface: net device which holds this struct as private data */
 	struct net_device *soft_iface;
 
+	/**
+	 * @mtu_set_by_user: MTU was set once by user
+	 * protected by rtnl_lock
+	 */
+	int mtu_set_by_user;
+
 	/**
 	 * @bat_counters: mesh internal traffic statistic counters (see
 	 *  batadv_counters)
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index c4cf2529d08b..ef5c174102d5 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -96,9 +96,11 @@ int ceph_monmap_contains(struct ceph_monmap *m, struct ceph_entity_addr *addr)
 {
 	int i;
 
-	for (i = 0; i < m->num_mon; i++)
-		if (memcmp(addr, &m->mon_inst[i].addr, sizeof(*addr)) == 0)
+	for (i = 0; i < m->num_mon; i++) {
+		if (ceph_addr_equal_no_type(addr, &m->mon_inst[i].addr))
 			return 1;
+	}
+
 	return 0;
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ce37a052b9c3..021dcfdae283 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2161,13 +2161,27 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-int rtnl_nla_parse_ifla(struct nlattr **tb, const struct nlattr *head, int len,
-			struct netlink_ext_ack *exterr)
+int rtnl_nla_parse_ifinfomsg(struct nlattr **tb, const struct nlattr *nla_peer,
+			     struct netlink_ext_ack *exterr)
 {
-	return nla_parse_deprecated(tb, IFLA_MAX, head, len, ifla_policy,
+	const struct ifinfomsg *ifmp;
+	const struct nlattr *attrs;
+	size_t len;
+
+	ifmp = nla_data(nla_peer);
+	attrs = nla_data(nla_peer) + sizeof(struct ifinfomsg);
+	len = nla_len(nla_peer) - sizeof(struct ifinfomsg);
+
+	if (ifmp->ifi_index < 0) {
+		NL_SET_ERR_MSG_ATTR(exterr, nla_peer,
+				    "ifindex can't be negative");
+		return -EINVAL;
+	}
+
+	return nla_parse_deprecated(tb, IFLA_MAX, attrs, len, ifla_policy,
 				    exterr);
 }
-EXPORT_SYMBOL(rtnl_nla_parse_ifla);
+EXPORT_SYMBOL(rtnl_nla_parse_ifinfomsg);
 
 struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[])
 {
@@ -3258,6 +3272,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct ifinfomsg *ifm;
 	char ifname[IFNAMSIZ];
 	struct nlattr **data;
+	bool link_specified;
 	int err;
 
 #ifdef CONFIG_MODULES
@@ -3278,12 +3293,19 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ifname[0] = '\0';
 
 	ifm = nlmsg_data(nlh);
-	if (ifm->ifi_index > 0)
+	if (ifm->ifi_index > 0) {
+		link_specified = true;
 		dev = __dev_get_by_index(net, ifm->ifi_index);
-	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
+	} else if (ifm->ifi_index < 0) {
+		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+		return -EINVAL;
+	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
+		link_specified = true;
 		dev = rtnl_dev_get(net, NULL, tb[IFLA_ALT_IFNAME], ifname);
-	else
+	} else {
+		link_specified = false;
 		dev = NULL;
+	}
 
 	master_dev = NULL;
 	m_ops = NULL;
@@ -3386,7 +3408,12 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
-		if (ifm->ifi_index == 0 && tb[IFLA_GROUP])
+		/* No dev found and NLM_F_CREATE not set. Requested dev does not exist,
+		 * or it's for a group
+		*/
+		if (link_specified)
+			return -ENODEV;
+		if (tb[IFLA_GROUP])
 			return rtnl_group_changelink(skb, net,
 						nla_get_u32(tb[IFLA_GROUP]),
 						ifm, extack, tb);
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 3293c1e3aa5d..c647035a36d1 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -324,11 +324,15 @@ EXPORT_SYMBOL_GPL(dccp_disconnect);
 __poll_t dccp_poll(struct file *file, struct socket *sock,
 		       poll_table *wait)
 {
-	__poll_t mask;
 	struct sock *sk = sock->sk;
+	__poll_t mask;
+	u8 shutdown;
+	int state;
 
 	sock_poll_wait(file, sock, wait);
-	if (sk->sk_state == DCCP_LISTEN)
+
+	state = inet_sk_state_load(sk);
+	if (state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
 	/* Socket is not locked. We are protected from async events
@@ -337,20 +341,21 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	 */
 
 	mask = 0;
-	if (sk->sk_err)
+	if (READ_ONCE(sk->sk_err))
 		mask = EPOLLERR;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
-	if (sk->sk_shutdown == SHUTDOWN_MASK || sk->sk_state == DCCP_CLOSED)
+	if (shutdown == SHUTDOWN_MASK || state == DCCP_CLOSED)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected? */
-	if ((1 << sk->sk_state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
+	if ((1 << state) & ~(DCCPF_REQUESTING | DCCPF_RESPOND)) {
 		if (atomic_read(&sk->sk_rmem_alloc) > 0)
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (sk_stream_is_writeable(sk)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -368,7 +373,6 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	}
 	return mask;
 }
-
 EXPORT_SYMBOL_GPL(dccp_poll);
 
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 3be93175b3ff..50f840e312b0 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -901,12 +901,14 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 static int pipapo_insert(struct nft_pipapo_field *f, const uint8_t *k,
 			 int mask_bits)
 {
-	int rule = f->rules++, group, ret, bit_offset = 0;
+	int rule = f->rules, group, ret, bit_offset = 0;
 
-	ret = pipapo_resize(f, f->rules - 1, f->rules);
+	ret = pipapo_resize(f, f->rules, f->rules + 1);
 	if (ret)
 		return ret;
 
+	f->rules++;
+
 	for (group = 0; group < f->groups; group++) {
 		int i, v;
 		u8 mask;
@@ -1051,7 +1053,9 @@ static int pipapo_expand(struct nft_pipapo_field *f,
 			step++;
 			if (step >= len) {
 				if (!masks) {
-					pipapo_insert(f, base, 0);
+					err = pipapo_insert(f, base, 0);
+					if (err < 0)
+						return err;
 					masks = 1;
 				}
 				goto out;
@@ -1234,6 +1238,9 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		else
 			ret = pipapo_expand(f, start, end, f->groups * f->bb);
 
+		if (ret < 0)
+			return ret;
+
 		if (f->bsize > bsize_max)
 			bsize_max = f->bsize;
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index fb50e3f3283f..5c2d230790db 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1513,10 +1513,28 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static bool req_create_or_replace(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_REPLACE);
+}
+
+static bool req_create_exclusive(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_EXCL);
+}
+
+static bool req_change(struct nlmsghdr *n)
+{
+	return (!(n->nlmsg_flags & NLM_F_CREATE) &&
+		!(n->nlmsg_flags & NLM_F_REPLACE) &&
+		!(n->nlmsg_flags & NLM_F_EXCL));
+}
+
 /*
  * Create/change qdisc.
  */
-
 static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			   struct netlink_ext_ack *extack)
 {
@@ -1613,27 +1631,35 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 *
 				 *   We know, that some child q is already
 				 *   attached to this parent and have choice:
-				 *   either to change it or to create/graft new one.
+				 *   1) change it or 2) create/graft new one.
+				 *   If the requested qdisc kind is different
+				 *   than the existing one, then we choose graft.
+				 *   If they are the same then this is "change"
+				 *   operation - just let it fallthrough..
 				 *
 				 *   1. We are allowed to create/graft only
-				 *   if CREATE and REPLACE flags are set.
+				 *   if the request is explicitly stating
+				 *   "please create if it doesn't exist".
 				 *
-				 *   2. If EXCL is set, requestor wanted to say,
-				 *   that qdisc tcm_handle is not expected
+				 *   2. If the request is to exclusive create
+				 *   then the qdisc tcm_handle is not expected
 				 *   to exist, so that we choose create/graft too.
 				 *
 				 *   3. The last case is when no flags are set.
+				 *   This will happen when for example tc
+				 *   utility issues a "change" command.
 				 *   Alas, it is sort of hole in API, we
 				 *   cannot decide what to do unambiguously.
-				 *   For now we select create/graft, if
-				 *   user gave KIND, which does not match existing.
+				 *   For now we select create/graft.
 				 */
-				if ((n->nlmsg_flags & NLM_F_CREATE) &&
-				    (n->nlmsg_flags & NLM_F_REPLACE) &&
-				    ((n->nlmsg_flags & NLM_F_EXCL) ||
-				     (tca[TCA_KIND] &&
-				      nla_strcmp(tca[TCA_KIND], q->ops->id))))
-					goto create_n_graft;
+				if (tca[TCA_KIND] &&
+				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
+					if (req_create_or_replace(n) ||
+					    req_create_exclusive(n))
+						goto create_n_graft;
+					else if (req_change(n))
+						goto create_n_graft2;
+				}
 			}
 		}
 	} else {
@@ -1667,6 +1693,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
 		return -ENOENT;
 	}
+create_n_graft2:
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
 			q = qdisc_create(dev, dev_ingress_queue(dev), p,
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 534364bb871a..fa4d31b507f2 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -97,7 +97,7 @@ struct percpu_counter sctp_sockets_allocated;
 
 static void sctp_enter_memory_pressure(struct sock *sk)
 {
-	sctp_memory_pressure = 1;
+	WRITE_ONCE(sctp_memory_pressure, 1);
 }
 
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 338b06de86d1..d015576f3081 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -972,9 +972,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	if (!rep->rr_rdmabuf)
 		goto out_free;
 
-	if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf))
-		goto out_free_regbuf;
-
 	xdr_buf_init(&rep->rr_hdrbuf, rdmab_data(rep->rr_rdmabuf),
 		     rdmab_length(rep->rr_rdmabuf));
 	rep->rr_cqe.done = rpcrdma_wc_receive;
@@ -987,8 +984,6 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	list_add(&rep->rr_all, &r_xprt->rx_buf.rb_all_reps);
 	return rep;
 
-out_free_regbuf:
-	rpcrdma_regbuf_free(rep->rr_rdmabuf);
 out_free:
 	kfree(rep);
 out:
@@ -1425,6 +1420,10 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 			rep = rpcrdma_rep_create(r_xprt, temp);
 		if (!rep)
 			break;
+		if (!rpcrdma_regbuf_dma_map(r_xprt, rep->rr_rdmabuf)) {
+			rpcrdma_rep_put(buf, rep);
+			break;
+		}
 
 		trace_xprtrdma_post_recv(rep);
 		rep->rr_recv_wr.next = wr;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6a04de21343f..82cfeab16217 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2011,6 +2011,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 		if (!datum)
 			goto out;
 
+		datum->next = NULL;
 		*dst = datum;
 
 		/* ebitmap_read() will at least init the bitmap */
@@ -2023,7 +2024,6 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 			goto out;
 
 		datum->otype = le32_to_cpu(buf[0]);
-		datum->next = NULL;
 
 		dst = &datum->next;
 	}
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 191883842a35..3e60a337bbef 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -31,20 +31,51 @@ static unsigned long max_alloc_per_card = 32UL * 1024UL * 1024UL;
 module_param(max_alloc_per_card, ulong, 0644);
 MODULE_PARM_DESC(max_alloc_per_card, "Max total allocation bytes per card.");
 
+static void __update_allocated_size(struct snd_card *card, ssize_t bytes)
+{
+	card->total_pcm_alloc_bytes += bytes;
+}
+
+static void update_allocated_size(struct snd_card *card, ssize_t bytes)
+{
+	mutex_lock(&card->memory_mutex);
+	__update_allocated_size(card, bytes);
+	mutex_unlock(&card->memory_mutex);
+}
+
+static void decrease_allocated_size(struct snd_card *card, size_t bytes)
+{
+	mutex_lock(&card->memory_mutex);
+	WARN_ON(card->total_pcm_alloc_bytes < bytes);
+	__update_allocated_size(card, -(ssize_t)bytes);
+	mutex_unlock(&card->memory_mutex);
+}
+
 static int do_alloc_pages(struct snd_card *card, int type, struct device *dev,
 			  size_t size, struct snd_dma_buffer *dmab)
 {
 	int err;
 
+	/* check and reserve the requested size */
+	mutex_lock(&card->memory_mutex);
 	if (max_alloc_per_card &&
-	    card->total_pcm_alloc_bytes + size > max_alloc_per_card)
+	    card->total_pcm_alloc_bytes + size > max_alloc_per_card) {
+		mutex_unlock(&card->memory_mutex);
 		return -ENOMEM;
+	}
+	__update_allocated_size(card, size);
+	mutex_unlock(&card->memory_mutex);
 
 	err = snd_dma_alloc_pages(type, dev, size, dmab);
 	if (!err) {
-		mutex_lock(&card->memory_mutex);
-		card->total_pcm_alloc_bytes += dmab->bytes;
-		mutex_unlock(&card->memory_mutex);
+		/* the actual allocation size might be bigger than requested,
+		 * and we need to correct the account
+		 */
+		if (dmab->bytes != size)
+			update_allocated_size(card, dmab->bytes - size);
+	} else {
+		/* take back on allocation failure */
+		decrease_allocated_size(card, size);
 	}
 	return err;
 }
@@ -53,10 +84,7 @@ static void do_free_pages(struct snd_card *card, struct snd_dma_buffer *dmab)
 {
 	if (!dmab->area)
 		return;
-	mutex_lock(&card->memory_mutex);
-	WARN_ON(card->total_pcm_alloc_bytes < dmab->bytes);
-	card->total_pcm_alloc_bytes -= dmab->bytes;
-	mutex_unlock(&card->memory_mutex);
+	decrease_allocated_size(card, dmab->bytes);
 	snd_dma_free_pages(dmab);
 	dmab->area = NULL;
 }
diff --git a/sound/soc/codecs/rt711-sdw.h b/sound/soc/codecs/rt711-sdw.h
index 43b2b984b29c..6acf9858330d 100644
--- a/sound/soc/codecs/rt711-sdw.h
+++ b/sound/soc/codecs/rt711-sdw.h
@@ -267,7 +267,9 @@ static const struct reg_default rt711_reg_defaults[] = {
 	{ 0x8393, 0x00 },
 	{ 0x7319, 0x00 },
 	{ 0x8399, 0x00 },
+	{ 0x752008, 0xa807 },
 	{ 0x752009, 0x1029 },
+	{ 0x75200b, 0x7770 },
 	{ 0x752011, 0x007a },
 	{ 0x75201a, 0x8003 },
 	{ 0x752045, 0x5289 },
diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 9bdcc7872053..0e343ad205fc 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -389,6 +389,36 @@ static void rt711_jack_init(struct rt711_priv *rt711)
 				RT711_HP_JD_FINAL_RESULT_CTL_JD12,
 				RT711_HP_JD_FINAL_RESULT_CTL_JD12);
 			break;
+		case RT711_JD2_100K:
+			rt711_index_update_bits(rt711->regmap, RT711_VENDOR_REG,
+				RT711_JD_CTL2, RT711_JD2_2PORT_100K_DECODE | RT711_JD2_1PORT_TYPE_DECODE |
+				RT711_HP_JD_SEL_JD2 | RT711_JD1_2PORT_TYPE_100K_DECODE,
+				RT711_JD2_2PORT_100K_DECODE_HP | RT711_JD2_1PORT_JD_HP |
+				RT711_HP_JD_SEL_JD2 | RT711_JD1_2PORT_JD_RESERVED);
+			rt711_index_update_bits(rt711->regmap, RT711_VENDOR_REG,
+				RT711_CC_DET1,
+				RT711_HP_JD_FINAL_RESULT_CTL_JD12,
+				RT711_HP_JD_FINAL_RESULT_CTL_JD12);
+			break;
+		case RT711_JD2_1P8V_1PORT:
+			rt711_index_update_bits(rt711->regmap, RT711_VENDOR_REG,
+				RT711_JD_CTL1, RT711_JD2_DIGITAL_JD_MODE_SEL,
+				RT711_JD2_1_JD_MODE);
+			rt711_index_update_bits(rt711->regmap, RT711_VENDOR_REG,
+				RT711_JD_CTL2, RT711_JD2_1PORT_TYPE_DECODE |
+				RT711_HP_JD_SEL_JD2,
+				RT711_JD2_1PORT_JD_HP |
+				RT711_HP_JD_SEL_JD2);
+			rt711_index_update_bits(rt711->regmap, RT711_VENDOR_REG,
+				RT711_JD_CTL4, RT711_JD2_PAD_PULL_UP_MASK |
+				RT711_JD2_MODE_SEL_MASK,
+				RT711_JD2_PAD_PULL_UP |
+				RT711_JD2_MODE2_1P8V_1PORT);
+			rt711_index_update_bits(rt711->regmap, RT711_VENDOR_REG,
+				RT711_CC_DET1,
+				RT711_HP_JD_FINAL_RESULT_CTL_JD12,
+				RT711_HP_JD_FINAL_RESULT_CTL_JD12);
+			break;
 		default:
 			dev_warn(rt711->component->dev, "Wrong JD source\n");
 			break;
diff --git a/sound/soc/codecs/rt711.h b/sound/soc/codecs/rt711.h
index ca0f581feec7..5f2ba1341085 100644
--- a/sound/soc/codecs/rt711.h
+++ b/sound/soc/codecs/rt711.h
@@ -52,7 +52,9 @@ struct sdw_stream_data {
 
 /* Index (NID:20h) */
 #define RT711_DAC_DC_CALI_CTL1				0x00
+#define RT711_JD_CTL1				0x08
 #define RT711_JD_CTL2				0x09
+#define RT711_JD_CTL4				0x0b
 #define RT711_CC_DET1				0x11
 #define RT711_PARA_VERB_CTL				0x1a
 #define RT711_COMBO_JACK_AUTO_CTL1				0x45
@@ -171,10 +173,33 @@ struct sdw_stream_data {
 /* DAC DC offset calibration control-1 (0x00)(NID:20h) */
 #define RT711_DAC_DC_CALI_TRIGGER (0x1 << 15)
 
+/* jack detect control 1 (0x08)(NID:20h) */
+#define RT711_JD2_DIGITAL_JD_MODE_SEL (0x1 << 1)
+#define RT711_JD2_1_JD_MODE (0x0 << 1)
+#define RT711_JD2_2_JD_MODE (0x1 << 1)
+
 /* jack detect control 2 (0x09)(NID:20h) */
 #define RT711_JD2_2PORT_200K_DECODE_HP (0x1 << 13)
+#define RT711_JD2_2PORT_100K_DECODE (0x1 << 12)
+#define RT711_JD2_2PORT_100K_DECODE_HP (0x0 << 12)
 #define RT711_HP_JD_SEL_JD1 (0x0 << 1)
 #define RT711_HP_JD_SEL_JD2 (0x1 << 1)
+#define RT711_JD2_1PORT_TYPE_DECODE (0x3 << 10)
+#define RT711_JD2_1PORT_JD_LINE2 (0x0 << 10)
+#define RT711_JD2_1PORT_JD_HP (0x1 << 10)
+#define RT711_JD2_1PORT_JD_LINE1 (0x2 << 10)
+#define RT711_JD1_2PORT_TYPE_100K_DECODE (0x1 << 0)
+#define RT711_JD1_2PORT_JD_RESERVED (0x0 << 0)
+#define RT711_JD1_2PORT_JD_LINE1 (0x1 << 0)
+
+/* jack detect control 4 (0x0b)(NID:20h) */
+#define RT711_JD2_PAD_PULL_UP_MASK (0x1 << 3)
+#define RT711_JD2_PAD_NOT_PULL_UP (0x0 << 3)
+#define RT711_JD2_PAD_PULL_UP (0x1 << 3)
+#define RT711_JD2_MODE_SEL_MASK (0x3 << 0)
+#define RT711_JD2_MODE0_2PORT (0x0 << 0)
+#define RT711_JD2_MODE1_3P3V_1PORT (0x1 << 0)
+#define RT711_JD2_MODE2_1P8V_1PORT (0x2 << 0)
 
 /* CC DET1 (0x11)(NID:20h) */
 #define RT711_HP_JD_FINAL_RESULT_CTL_JD12 (0x1 << 10)
@@ -215,7 +240,9 @@ enum {
 enum rt711_jd_src {
 	RT711_JD_NULL,
 	RT711_JD1,
-	RT711_JD2
+	RT711_JD2,
+	RT711_JD2_100K,
+	RT711_JD2_1P8V_1PORT
 };
 
 int rt711_io_init(struct device *dev, struct sdw_slave *slave);
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index cbbb50ddc795..f36a0fda1b6a 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -13,8 +13,9 @@
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
 #include "sof_sdw_common.h"
+#include "../../codecs/rt711.h"
 
-unsigned long sof_sdw_quirk = SOF_RT711_JD_SRC_JD1;
+unsigned long sof_sdw_quirk = RT711_JD1;
 static int quirk_override = -1;
 module_param_named(quirk, quirk_override, int, 0444);
 MODULE_PARM_DESC(quirk, "Board-specific quirk override");
@@ -63,7 +64,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "09C6")
 		},
-		.driver_data = (void *)(SOF_RT711_JD_SRC_JD2 |
+		.driver_data = (void *)(RT711_JD2 |
 					SOF_RT715_DAI_ID_FIX),
 	},
 	{
@@ -73,7 +74,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0983")
 		},
-		.driver_data = (void *)(SOF_RT711_JD_SRC_JD2 |
+		.driver_data = (void *)(RT711_JD2 |
 					SOF_RT715_DAI_ID_FIX),
 	},
 	{
@@ -82,7 +83,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "098F"),
 		},
-		.driver_data = (void *)(SOF_RT711_JD_SRC_JD2 |
+		.driver_data = (void *)(RT711_JD2 |
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_FOUR_SPK),
 	},
@@ -92,7 +93,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0990"),
 		},
-		.driver_data = (void *)(SOF_RT711_JD_SRC_JD2 |
+		.driver_data = (void *)(RT711_JD2 |
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_FOUR_SPK),
 	},
@@ -114,7 +115,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 				  "Tiger Lake Client Platform"),
 		},
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
-					SOF_RT711_JD_SRC_JD1 |
+					RT711_JD1 |
 					SOF_SDW_PCH_DMIC |
 					SOF_SSP_PORT(SOF_I2S_SSP2)),
 	},
@@ -125,7 +126,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0A3E")
 		},
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
-					SOF_RT711_JD_SRC_JD2 |
+					RT711_JD2 |
 					SOF_RT715_DAI_ID_FIX),
 	},
 	{
@@ -135,7 +136,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0A5E")
 		},
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
-					SOF_RT711_JD_SRC_JD2 |
+					RT711_JD2 |
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_FOUR_SPK),
 	},
@@ -173,7 +174,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
 					SOF_SDW_PCH_DMIC |
-					SOF_RT711_JD_SRC_JD2),
+					RT711_JD2),
 	},
 	/* TigerLake-SDCA devices */
 	{
@@ -183,7 +184,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0A32")
 		},
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
-					SOF_RT711_JD_SRC_JD2 |
+					RT711_JD2 |
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_FOUR_SPK),
 	},
@@ -194,7 +195,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alder Lake Client Platform"),
 		},
-		.driver_data = (void *)(SOF_RT711_JD_SRC_JD1 |
+		.driver_data = (void *)(RT711_JD1 |
 					SOF_SDW_TGL_HDMI |
 					SOF_RT715_DAI_ID_FIX |
 					SOF_SDW_PCH_DMIC),
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index ea60e8ed215c..801600522c47 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -22,11 +22,6 @@
 /* 8 combinations with 4 links + unused group 0 */
 #define SDW_MAX_GROUPS 9
 
-enum {
-	SOF_RT711_JD_SRC_JD1 = 1,
-	SOF_RT711_JD_SRC_JD2 = 2,
-};
-
 enum {
 	SOF_PRE_TGL_HDMI_COUNT = 3,
 	SOF_TGL_HDMI_COUNT = 4,
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 580ce1857585..75840291b393 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int *base);
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index b6791e8d9ab3..9d2af67672e7 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -652,8 +652,11 @@ bool arch_is_retpoline(struct symbol *sym)
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk") ||
-	       !strcmp(sym->name, "srso_untrain_ret") ||
-	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "retbleed_return_thunk");
+	return !strcmp(sym->name, "__x86_return_thunk");
+}
+
+bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return !strcmp(sym->name, "retbleed_return_thunk") ||
+	       !strcmp(sym->name, "srso_safe_ret");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 965c055aa808..bd24951faa09 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -946,16 +946,33 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	return 0;
 }
 
+/*
+ * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
+ * will be added to the .retpoline_sites section.
+ */
 __weak bool arch_is_retpoline(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that replace INSN_RETURN, every (tail) call to such a symbol
+ * will be added to the .return_sites section.
+ */
 __weak bool arch_is_rethunk(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that are embedded inside other instructions, because sometimes crazy
+ * code exists. These are mostly ignored for validation purposes.
+ */
+__weak bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return false;
+}
+
 #define NEGATIVE_RELOC	((void *)-1L)
 
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
@@ -1172,7 +1189,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -1971,6 +1988,9 @@ static int classify_symbols(struct objtool_file *file)
 			if (arch_is_rethunk(func))
 				func->return_thunk = true;
 
+			if (arch_is_embedded_insn(func))
+				func->embedded_insn = true;
+
 			if (!strcmp(func->name, "__fentry__"))
 				func->fentry = true;
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index a1863eb35fbb..19446d911244 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 kcov              : 1;
+	u8 embedded_insn     : 1;
 };
 
 struct reloc {
