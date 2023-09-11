Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694B79BCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjIKV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjIKIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:41:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D631125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694421697; x=1725957697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XyQqE6ua6KWD89cngxqd4htyditGGfSXApdeUeV+fL0=;
  b=NDkJiBO8SZ+Q4FF/JNMmtUa7/yAlT4w0CCVXbgEiJGzPamc+2hNcY2mX
   040oeRvm5iX34kYjaGzHtwsVz4z9j7u26l6EXkZF2oca25EfZUVSGnUSc
   AZ8pbSmm20vzxWhudS4jqsi3fpg/061LE8F8o2VPDsFZ/L/wB/521NBi2
   rZHUkeBDZVm4Y2RhwS3n0MbZp7+aW46bCLvBDho9CK6b2t68R1mdTQUAG
   iI88ZSJlbMTq6fY2Zerc69Ud2IsbeaV9oadtZGtYGbFtlDETTrh+mMSqo
   +OKbhYaZ5IBLV5V9fpJ/73VuWWeMP1fU6U4f/Kwgn7M7b1Idxoms2kZQd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="442024220"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="442024220"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="1074063909"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="1074063909"
Received: from djustese-mobl.ger.corp.intel.com (HELO fedora..) ([10.249.254.185])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 01:41:12 -0700
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedestkop.org
Subject: [RFC PATCH] locking/ww_mutex: Adjust to lockdep nest_lock requirements
Date:   Mon, 11 Sep 2023 10:40:42 +0200
Message-ID: <20230911084042.5160-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using mutex_acquire_nest() with a nest_lock, lockdep refcounts the
number of acquired lockdep_maps of mutexes of the same class, and also
keeps a pointer to the first acquired lockdep_map of a class. That pointer
is then used for various comparison-, printing- and checking purposes,
but there is no mechanism to actively ensure that lockdep_map stays in
memory. Instead, a warning is printed if the lockdep_map is freed and
there are still held locks of the same lock class, even if the lockdep_map
itself has been released.

In the context of WW/WD transactions that means that if a user unlocks
and frees a ww_mutex from within an ongoing ww transaction, and that
mutex happens to be the first ww_mutex grabbed in the transaction,
such a warning is printed and there might be a risk of a UAF.

Note that this is only problem when lockdep is enabled and affects only
dereferences of struct lockdep_map.

Adjust to this by adding a fake lockdep_map to the acquired context and
make sure it is the first acquired lockdep map of the associated
ww_mutex class. Then hold it for the duration of the WW/WD transaction.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: intel-xe@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedestkop.org
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/ww_mutex.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index bb763085479a..a401a2f31a77 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -65,6 +65,16 @@ struct ww_acquire_ctx {
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
+	/**
+	 * @first_lock_dep_map: fake lockdep_map for first locked ww_mutex.
+	 *
+	 * lockdep requires the lockdep_map for the first locked ww_mutex
+	 * in a ww transaction to remain in memory until all ww_mutexes of
+	 * the transaction have been unlocked. Ensure this by keeping a
+	 * fake locked ww_mutex lockdep map between ww_acquire_init() and
+	 * ww_acquire_fini().
+	 */
+	struct lockdep_map first_lock_dep_map;
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	unsigned int deadlock_inject_interval;
@@ -146,7 +156,10 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
 	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
 			 &ww_class->acquire_key, 0);
+	lockdep_init_map(&ctx->first_lock_dep_map, ww_class->mutex_name,
+			 &ww_class->mutex_key, 0);
 	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
+	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx->dep_map, _RET_IP_);
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	ctx->deadlock_inject_interval = 1;
@@ -185,6 +198,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
 #ifdef DEBUG_WW_MUTEXES
-- 
2.41.0

