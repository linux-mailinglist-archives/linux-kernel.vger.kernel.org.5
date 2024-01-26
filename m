Return-Path: <linux-kernel+bounces-40229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1A83DCDD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619E52814DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B41CA9A;
	Fri, 26 Jan 2024 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egPEmdpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C51CA89
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281019; cv=none; b=SV0InHxEO0021ccwC30Jl9bWuaeVAkSfDO3VFPSn6whsuk6754Ce5KKYc9g/ws2B86BoYcO1OpE1nf4waJeKK7D26J8MoX2dJ4SIq7Q8TlhJc8hxzQZwmlKI/6QPT4TYy2bCBtvrVhyQ7ecOUBMH/1vgpzO6A3vsAxljTvrJIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281019; c=relaxed/simple;
	bh=HM/4wZmW5lT5j//nMdp1UG/9xtHNmD6BXoRS+b2+x4M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XnQwWIchlz93WlMgIWfwk0PBa6IPW+16IqQKntZmYWfhbFDQL1tgTH/j0ORyuX1RfaryPCzgtFON5qE75Ui0SKfu56IaiSS2B7S9OPwzJhGHqUlIOjOD7zEoFQJp/dpqPJyjlYGOjkZFW0hJZQFbF+UqLoYsiUXWiVaxzo9l6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egPEmdpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C1DC43330;
	Fri, 26 Jan 2024 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706281018;
	bh=HM/4wZmW5lT5j//nMdp1UG/9xtHNmD6BXoRS+b2+x4M=;
	h=Date:From:To:Cc:Subject:From;
	b=egPEmdpmYXM6nal0nwfDHoA3CEjfC+Z4OsV+UrfxnyY4Qokn3q2XFeK27P641HKUS
	 w/WjKgo/8GLWNB/5Uwmi2hrhthrJ5wOjce/zGQ/lvKJZmVuxDNhHCp/93MbTw3DBhE
	 OS3wwRE+BUKiFT6fVee5TPTCbHrcRORaJQ/H0kI+BqdmN2T5g8kukRuWF0bXC895wI
	 y/IRNkEJTXMGbJC3d/+Yg+3AUAC1uiJaKedejcD0ZME4oHT3XHzayHRxUBAGXb3cuQ
	 R4LwZzRRAOA6PfjHLLCjcy5T78wqQ6LjWFWN4hvPSJgKcr+1dsxTO3mvSdE2CIXHhA
	 BBxB8A3ZMpcbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0684540441; Fri, 26 Jan 2024 11:56:55 -0300 (-03)
Date: Fri, 26 Jan 2024 11:56:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rob Clark <robdclark@chromium.org>, Simon Ser <contact@emersion.fr>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	topickDRM_IOCTL_MODE_CLOSEFB@ghostprotocols.net
Subject: [PATCH 1/1 fyi] tools headers UAPI: Update tools's copy of drm.h
 headers
Message-ID: <ZbPIN9Dcc5AM0uxo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

Picking the changes from:

  8570c27932e132d2 ("drm/syncobj: Add deadline support for syncobj waits")
  9724ed6c1b1212d1 ("drm: Introduce DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT")
  e4d983acffff270c ("drm: introduce DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP")
  d208d875667e2a29 ("drm: introduce CLOSEFB IOCTL")
  afa5cf3175a22b71 ("drm/i915/uapi: fix typos/spellos and punctuation")

Addressing these perf build warnings:

  Warning: Kernel ABI header differences:

Now 'perf trace' and other code that might use the
tools/perf/trace/beauty autogenerated tables will be able to translate
this new ioctl command into a string:

  $ tools/perf/trace/beauty/drm_ioctl.sh > before
  $ cp include/uapi/drm/drm.h tools/include/uapi/drm/drm.h
  $ tools/perf/trace/beauty/drm_ioctl.sh > after
  $ diff -u before after
  --- before	2024-01-26 10:54:23.486381862 -0300
  +++ after	2024-01-26 10:54:35.767902442 -0300
  @@ -109,6 +109,7 @@
   	[0xCD] = "SYNCOBJ_TIMELINE_SIGNAL",
   	[0xCE] = "MODE_GETFB2",
   	[0xCF] = "SYNCOBJ_EVENTFD",
  +	[0xD0] = "MODE_CLOSEFB",
   	[DRM_COMMAND_BASE + 0x00] = "I915_INIT",
   	[DRM_COMMAND_BASE + 0x01] = "I915_FLUSH",
   	[DRM_COMMAND_BASE + 0x02] = "I915_FLIP",
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Clark <robdclark@chromium.org>
Cc: Simon Ser <contact@emersion.fr>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h      | 72 ++++++++++++++++++++++++++++++-
 tools/include/uapi/drm/i915_drm.h | 12 +++---
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index de723566c5ae8238..16122819edfeff87 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -713,7 +713,8 @@ struct drm_gem_open {
 /**
  * DRM_CAP_ASYNC_PAGE_FLIP
  *
- * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC.
+ * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for legacy
+ * page-flips.
  */
 #define DRM_CAP_ASYNC_PAGE_FLIP		0x7
 /**
@@ -773,6 +774,13 @@ struct drm_gem_open {
  * :ref:`drm_sync_objects`.
  */
 #define DRM_CAP_SYNCOBJ_TIMELINE	0x14
+/**
+ * DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP
+ *
+ * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for atomic
+ * commits.
+ */
+#define DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP	0x15
 
 /* DRM_IOCTL_GET_CAP ioctl argument type */
 struct drm_get_cap {
@@ -842,6 +850,31 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	5
 
+/**
+ * DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
+ *
+ * Drivers for para-virtualized hardware (e.g. vmwgfx, qxl, virtio and
+ * virtualbox) have additional restrictions for cursor planes (thus
+ * making cursor planes on those drivers not truly universal,) e.g.
+ * they need cursor planes to act like one would expect from a mouse
+ * cursor and have correctly set hotspot properties.
+ * If this client cap is not set the DRM core will hide cursor plane on
+ * those virtualized drivers because not setting it implies that the
+ * client is not capable of dealing with those extra restictions.
+ * Clients which do set cursor hotspot and treat the cursor plane
+ * like a mouse cursor should set this property.
+ * The client must enable &DRM_CLIENT_CAP_ATOMIC first.
+ *
+ * Setting this property on drivers which do not special case
+ * cursor planes (i.e. non-virtualized drivers) will return
+ * EOPNOTSUPP, which can be used by userspace to gauge
+ * requirements of the hardware/drivers they're running on.
+ *
+ * This capability is always supported for atomic-capable virtualized
+ * drivers starting from kernel version 6.6.
+ */
+#define DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT	6
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
@@ -893,6 +926,7 @@ struct drm_syncobj_transfer {
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
 #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
+#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence deadline to deadline_nsec */
 struct drm_syncobj_wait {
 	__u64 handles;
 	/* absolute timeout */
@@ -901,6 +935,14 @@ struct drm_syncobj_wait {
 	__u32 flags;
 	__u32 first_signaled; /* only valid when not waiting all */
 	__u32 pad;
+	/**
+	 * @deadline_nsec - fence deadline hint
+	 *
+	 * Deadline hint, in absolute CLOCK_MONOTONIC, to set on backing
+	 * fence(s) if the DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag is
+	 * set.
+	 */
+	__u64 deadline_nsec;
 };
 
 struct drm_syncobj_timeline_wait {
@@ -913,6 +955,14 @@ struct drm_syncobj_timeline_wait {
 	__u32 flags;
 	__u32 first_signaled; /* only valid when not waiting all */
 	__u32 pad;
+	/**
+	 * @deadline_nsec - fence deadline hint
+	 *
+	 * Deadline hint, in absolute CLOCK_MONOTONIC, to set on backing
+	 * fence(s) if the DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE flag is
+	 * set.
+	 */
+	__u64 deadline_nsec;
 };
 
 /**
@@ -1218,6 +1268,26 @@ extern "C" {
 
 #define DRM_IOCTL_SYNCOBJ_EVENTFD	DRM_IOWR(0xCF, struct drm_syncobj_eventfd)
 
+/**
+ * DRM_IOCTL_MODE_CLOSEFB - Close a framebuffer.
+ *
+ * This closes a framebuffer previously added via ADDFB/ADDFB2. The IOCTL
+ * argument is a framebuffer object ID.
+ *
+ * This IOCTL is similar to &DRM_IOCTL_MODE_RMFB, except it doesn't disable
+ * planes and CRTCs. As long as the framebuffer is used by a plane, it's kept
+ * alive. When the plane no longer uses the framebuffer (because the
+ * framebuffer is replaced with another one, or the plane is disabled), the
+ * framebuffer is cleaned up.
+ *
+ * This is useful to implement flicker-free transitions between two processes.
+ *
+ * Depending on the threat model, user-space may want to ensure that the
+ * framebuffer doesn't expose any sensitive user information: closed
+ * framebuffers attached to a plane can be read back by the next DRM master.
+ */
+#define DRM_IOCTL_MODE_CLOSEFB		DRM_IOWR(0xD0, struct drm_mode_closefb)
+
 /*
  * Device specific ioctls should only be in their respective headers
  * The device specific ioctl range is from 0x40 to 0x9f.
diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 218edb0a96f8c043..fd4f9574d177a269 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -693,7 +693,7 @@ typedef struct drm_i915_irq_wait {
 #define I915_PARAM_HAS_EXEC_FENCE	 44
 
 /* Query whether DRM_I915_GEM_EXECBUFFER2 supports the ability to capture
- * user specified bufffers for post-mortem debugging of GPU hangs. See
+ * user-specified buffers for post-mortem debugging of GPU hangs. See
  * EXEC_OBJECT_CAPTURE.
  */
 #define I915_PARAM_HAS_EXEC_CAPTURE	 45
@@ -1606,7 +1606,7 @@ struct drm_i915_gem_busy {
 	 * is accurate.
 	 *
 	 * The returned dword is split into two fields to indicate both
-	 * the engine classess on which the object is being read, and the
+	 * the engine classes on which the object is being read, and the
 	 * engine class on which it is currently being written (if any).
 	 *
 	 * The low word (bits 0:15) indicate if the object is being written
@@ -1815,7 +1815,7 @@ struct drm_i915_gem_madvise {
 	__u32 handle;
 
 	/* Advice: either the buffer will be needed again in the near future,
-	 *         or wont be and could be discarded under memory pressure.
+	 *         or won't be and could be discarded under memory pressure.
 	 */
 	__u32 madv;
 
@@ -3246,7 +3246,7 @@ struct drm_i915_query_topology_info {
  * 	// enough to hold our array of engines. The kernel will fill out the
  * 	// item.length for us, which is the number of bytes we need.
  * 	//
- * 	// Alternatively a large buffer can be allocated straight away enabling
+ *	// Alternatively a large buffer can be allocated straightaway enabling
  * 	// querying in one pass, in which case item.length should contain the
  * 	// length of the provided buffer.
  * 	err = ioctl(fd, DRM_IOCTL_I915_QUERY, &query);
@@ -3256,7 +3256,7 @@ struct drm_i915_query_topology_info {
  * 	// Now that we allocated the required number of bytes, we call the ioctl
  * 	// again, this time with the data_ptr pointing to our newly allocated
  * 	// blob, which the kernel can then populate with info on all engines.
- * 	item.data_ptr = (uintptr_t)&info,
+ *	item.data_ptr = (uintptr_t)&info;
  *
  * 	err = ioctl(fd, DRM_IOCTL_I915_QUERY, &query);
  * 	if (err) ...
@@ -3286,7 +3286,7 @@ struct drm_i915_query_topology_info {
 /**
  * struct drm_i915_engine_info
  *
- * Describes one engine and it's capabilities as known to the driver.
+ * Describes one engine and its capabilities as known to the driver.
  */
 struct drm_i915_engine_info {
 	/** @engine: Engine class and instance. */
-- 
2.43.0


