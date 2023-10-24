Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF327D57A0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjJXQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbjJXQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:12:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94B3AF;
        Tue, 24 Oct 2023 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163921; x=1729699921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKoMcXbN2L6Bp1UujVMkXfxYLgXbZyOn20AweTGZa3U=;
  b=V4B5+Ud/gg1hKnZr5/K5OFoTEfyqoEqNd7mm2WjC9oGtbY5tfw+my/eg
   dUhXvT1Pk0/j8bgGFd9mlE6ITvoRlH2CmW3bvsHio/96Ih8TIduGcp6PE
   YOuV/6RTOsN4S5pnL5+FKksz5YzA45QqaadUg+cEPj0vgMOHyMaNilfj1
   6FI8+NtqCFDFLIxGqIQK2mT7UDaGqlL5dCju05G8NYNWjXgbVRjQltzt5
   p17e9/EriFk8w/Hx6yQ51Z1yg7ms2lgwbZ1XVW1Esoqmvl+xbczVgIB4Z
   bF/n8Tvu46qwW9b0SWFOCpPOOieedNnEDsxDTpwsRm3a8q1WY4Z+LX94D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451328163"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="451328163"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="902237262"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="902237262"
Received: from aidenbar-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.213.219.125])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:05:30 -0700
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [RFC 5/8] drm/cgroup: Only track clients which are providing drm_cgroup_ops
Date:   Tue, 24 Oct 2023 17:07:24 +0100
Message-Id: <20231024160727.282960-6-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>
References: <20231024160727.282960-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

To reduce the number of tracking going on, especially with drivers which
will not support any sort of control from the drm cgroup controller side,
lets express the funcionality as opt-in and use the presence of
drm_cgroup_ops as activation criteria.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 kernel/cgroup/drm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
index 68f31797c4f0..60e1f3861576 100644
--- a/kernel/cgroup/drm.c
+++ b/kernel/cgroup/drm.c
@@ -97,6 +97,9 @@ void drmcgroup_client_open(struct drm_file *file_priv)
 {
 	struct drm_cgroup_state *drmcs;
 
+	if (!file_priv->minor->dev->driver->cg_ops)
+		return;
+
 	drmcs = css_to_drmcs(task_get_css(current, drm_cgrp_id));
 
 	mutex_lock(&drmcg_mutex);
@@ -112,6 +115,9 @@ void drmcgroup_client_close(struct drm_file *file_priv)
 
 	drmcs = css_to_drmcs(file_priv->__css);
 
+	if (!file_priv->minor->dev->driver->cg_ops)
+		return;
+
 	mutex_lock(&drmcg_mutex);
 	list_del(&file_priv->clink);
 	file_priv->__css = NULL;
@@ -126,6 +132,9 @@ void drmcgroup_client_migrate(struct drm_file *file_priv)
 	struct drm_cgroup_state *src, *dst;
 	struct cgroup_subsys_state *old;
 
+	if (!file_priv->minor->dev->driver->cg_ops)
+		return;
+
 	mutex_lock(&drmcg_mutex);
 
 	old = file_priv->__css;
-- 
2.39.2

