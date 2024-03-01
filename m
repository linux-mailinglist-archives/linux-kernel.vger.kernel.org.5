Return-Path: <linux-kernel+bounces-88236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7545E86DEF5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681B81C2175A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59A6BB46;
	Fri,  1 Mar 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CJnW+pS1"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920876A8C1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287525; cv=none; b=XROequdaiHOUeksjBvZAb9IWv2k/Gh2jpXLX/fO1qTRaDq4tRT2zKaKT5U2WiGruktDTH+DyCS11TCML2LYE12wYPvCbW2hBf1TtaAVQCtozQ4k5GAp1gh0kl0+yca34SrB8uIb/tFAc2nG3uifqx7hZg2XC3TFtAdpU1r6bSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287525; c=relaxed/simple;
	bh=AZhNOafdGhOovDqD3kXVqHUFt7AIztBXGiKsvWHgrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbTtVuvnzri1cIMXgvZ9n/tFJkR/lD0h5rNzASk3pruCWmA1roM/fWggeGs3bzuh0LAsAxf72e+BEXviEI/DrP6PHbTPkToqVyIY8RnUUuEIUpbevgFSZmQh6ef4K0jWlrm3cx94S0M9/LoY+e6aYr38dKb4PL9kazrQaUivFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CJnW+pS1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso630440e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 02:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1709287520; x=1709892320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQGNsd9pf3Q0pJgkYTHLsj6DvJ2Trk9t60cOcnToq+A=;
        b=CJnW+pS1M1udI2L0bqWX9a+5lo3bNhCHNiosMCsQ5tmAqrBPxsyZxIHZ1soak4mZN2
         KOsyt5KarrJ5fcA2G5NrheuOaAnRcabMnufjKAFjPJhX8KAqJsYNzLeNEGH8Kpw0lMom
         /Rd5gb0yftIrtmsuvHvROFbbXLS0m9P3UrLec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709287520; x=1709892320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQGNsd9pf3Q0pJgkYTHLsj6DvJ2Trk9t60cOcnToq+A=;
        b=m11tywN9oV2W5jbxv/HxB8J2k8x2GTMVgb/FFuQWYT0FZhxlvvi+xjrf+NG2VKQYij
         Q/Q4yAzIv9W11GAkm98web3kwWTmx25MCKvidZw/Kkh+gPmCpDeiZ0/0AuWc/ragwMxD
         orRNo8czWR634SLxXcRVNggMpyrvOxEJWuCUovtYCMfhZcUaS/+Ixf2sw3oFZgIGUnfc
         V4xQJlfQPBnoRCydU2OpzCsgKkxTBL4/vWb99dbYLMnafQJs989CtV/JMLGBNf0qwHY3
         Xa9RQSFgYun/4W4N+rYb51n8XIbWtvhG6qzVhikK+F7s7IARPBhF+UnKXr4HsLrB9Ti7
         J0sg==
X-Gm-Message-State: AOJu0Yw7HMTkTYAzojPmbsSBvdZAr5TBep0V+Ei8ZC7Cezpfo8Wvl8WP
	hxiygbd96w4h/D0ZRhCV+AZt4PR5JkX3cT2q7UrwRed3F7plJoSU/8zRKTu4JiQ=
X-Google-Smtp-Source: AGHT+IGrJCEmEmHGxfNfvl9FgRwQCRJTk01GBtqjkFgg71Me8R+hir23GDTbTBt3mKAYS3Sep2uEjg==
X-Received: by 2002:a05:6512:514:b0:513:22d5:3ab5 with SMTP id o20-20020a056512051400b0051322d53ab5mr654363lfb.5.1709287520336;
        Fri, 01 Mar 2024 02:05:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h12-20020adf9ccc000000b0033e03a6b1ecsm4144127wre.18.2024.03.01.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 02:05:19 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC] drm/panic: Add drm panic locking
Date: Fri,  1 Mar 2024 11:05:16 +0100
Message-ID: <20240301100516.2516297-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jocelyn Falempe <jfalempe@redhat.com>

Rough sketch for the locking of drm panic printing code. The upshot of
this approach is that we can pretty much entirely rely on the atomic
commit flow, with the pair of raw_spin_lock/unlock providing any
barriers we need, without having to create really big critical
sections in code.

This also avoids the need that drivers must explicitly update the
panic handler state, which they might forget to do, or not do
consistently, and then we blow up in the worst possible times.

It is somewhat racy against a concurrent atomic update, and we might
write into a buffer which the hardware will never display. But there's
fundamentally no way to avoid that - if we do the panic state update
explicitly after writing to the hardware, we might instead write to an
old buffer that the user will barely ever see.

Note that an rcu protected deference of plane->state would give us the
the same guarantees, but it has the downside that we then need to
protect the plane state freeing functions with call_rcu too. Which
would very widely impact a lot of code and therefore doesn't seem
worth the it compared to a raw spinlock with very tiny critical
sections. Plus rcu cannot be used to protect access to peek/poke registers
anyway, so we'd still need it for those cases.

Peek/poke registers for vram access (or a gart pte reserved just for
panic code) are also the reason I've gone with a per-device and not
per-plane spinlock, since usually these things are global for the
entire display. Going with per-plane locks would mean drivers for such
hardware would need additional locks, which we don't want, since it
deviates from the per-console takeoverlocks design.

Longer term it might be useful if the panic notifiers grow a bit more
structure than just the absolute bare
EXPORT_SYMBOL(panic_notifier_list) - somewhat aside, why is that not
EXPORT_SYMBOL_GPL ... If panic notifiers would be more like console
drivers with proper register/unregister interfaces we could perhaps
reuse the very fancy console lock with all it's check and takeover
semantics that John Ogness is developing to fix the console_lock mess.
But for the initial cut of a drm panic printing support I don't think
we need that, because the critical sections are extremely small and
only happen once per display refresh. So generally just 60 tiny locked
sections per second, which is nothing compared to a serial console
running a 115kbaud doing really slow mmio writes for each byte. So for
now the raw spintrylock in drm panic notifier callback should be good
enough.

Another benefit of making panic notifiers more like full blown
consoles (that are used in panics only) would be that we get the two
stage design, where first all the safe outputs are used. And then the
dangerous takeover tricks are deployed (where for display drivers we
also might try to intercept any in-flight display buffer flips, which
if we race and misprogram fifos and watermarks can hang the memory
controller on some hw).

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_atomic_helper.c |  3 +
 include/drm/drm_mode_config.h       | 10 +++
 include/drm/drm_panic.h             | 99 +++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 include/drm/drm_panic.h

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 40c2bd3e62e8..5a908c186037 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -38,6 +38,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_print.h>
 #include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
@@ -3086,6 +3087,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 		}
 	}
 
+	drm_panic_lock(state->dev);
 	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
 		WARN_ON(plane->state != old_plane_state);
 
@@ -3095,6 +3097,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
 		state->planes[i].state = old_plane_state;
 		plane->state = new_plane_state;
 	}
+	drm_panic_unlock(state->dev);
 
 	for_each_oldnew_private_obj_in_state(state, obj, old_obj_state, new_obj_state, i) {
 		WARN_ON(obj->state != old_obj_state);
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 973119a9176b..92a390379e85 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -505,6 +505,16 @@ struct drm_mode_config {
 	 */
 	struct list_head plane_list;
 
+	/**
+	 * @panic_lock:
+	 *
+	 * Raw spinlock used to protect critical sections of code that access
+	 * the display hardware or modeset software, which the panic printing
+	 * code must be protected against. See drm_panic_trylock(),
+	 * drm_panic_lock() and drm_panic_unlock().
+	 */
+	struct raw_spinlock panic_lock;
+
 	/**
 	 * @num_crtc:
 	 *
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
new file mode 100644
index 000000000000..caa12f60beae
--- /dev/null
+++ b/include/drm/drm_panic.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+#ifndef __DRM_PANIC_H__
+#define __DRM_PANIC_H__
+
+#include <drm/drm_device.h>
+/*
+ * Copyright (c) 2024 Intel
+ */
+
+/**
+ * drm_panic_trylock - try to enter the panic printing critical section
+ * @dev: struct drm_device
+ *
+ * This function must be called by any panic printing code. The panic printing
+ * attempt must be aborted if the trylock fails.
+ *
+ * Panic printing code can make the following assumptions while holding the
+ * panic lock:
+ *
+ * - Anything protected by drm_panic_lock() and drm_panic_unlock() pairs is safe
+ *   to access.
+ *
+ * - Furthermore the panic printing code only registers in drm_dev_unregister()
+ *   and gets removed in drm_dev_unregister(). This allows the panic code to
+ *   safely access any state which is invariant in between these two function
+ *   calls, like the list of planes drm_mode_config.plane_list or most of the
+ *   struct drm_plane structure.
+ *
+ * Specifically thanks to the protection around plane updates in
+ * drm_atomic_helper_swap_state() the following additional guarantees hold:
+ *
+ * - It is safe to deference the drm_plane.state pointer.
+ *
+ * - Anything in struct drm_plane_state or the driver's subclass thereof which
+ *   stays invariant after the atomic check code has finished is safe to access.
+ *   Specifically this includes the reference counted pointers to framebuffer
+ *   and buffer objects.
+ *
+ * - Anything set up by drm_plane_helper_funcs.fb_prepare and cleaned up
+ *   drm_plane_helper_funcs.fb_cleanup is safe to access, as long as it stays
+ *   invariant between these two calls. This also means that for drivers using
+ *   dynamic buffer management the framebuffer is pinned, and therefer all
+ *   relevant datastructures can be accessed without taking any further locks
+ *   (which would be impossible in panic context anyway).
+ *
+ * - Importantly, software and hardware state set up by
+ *   drm_plane_helper_funcs.begin_fb_access and
+ *   drm_plane_helper_funcs.end_fb_access is not safe to access.
+ *
+ * Drivers must not make any assumptions about the actual state of the hardware,
+ * unless they explicitly protected these hardware access with drm_panic_lock()
+ * and drm_panic_unlock().
+ *
+ * Returns:
+ *
+ * 0 when failing to acquire the raw spinlock, nonzero on success.:w
+ */
+static inline int drm_panic_trylock(struct drm_device *dev)
+{
+	return raw_spin_trylock(&dev->mode_config.panic_lock);
+}
+
+/**
+ * drm_panic_lock - protect panic printing relevant state
+ * @dev: struct drm_device
+ *
+ * This function must be called to protect software and hardware state that the
+ * panic printing code must be able to rely on. The protected sections must be
+ * as small as possible. Examples include:
+ *
+ * - Access to peek/poke or other similar registers, if that is the way the
+ *   driver prints the pixels into the scanout buffer at panic time.
+ *
+ * - Updates to pointers like drm_plane.state, allowing the panic handler to
+ *   safely deference these. This is done in drm_atomic_helper_swap_state().
+ *
+ * - An state that isn't invariant and that the driver must be able to access
+ *   during panic printing.
+ *
+ * Call drm_panic_unlock() to unlock the locked spinlock.
+ */
+static inline void drm_panic_lock(struct drm_device *dev)
+{
+	return raw_spin_lock(&dev->mode_config.panic_lock);
+}
+
+/**
+ * drm_panic_unlock - end of the panic printing critical section
+ * @dev: struct drm_device
+ *
+ * Unlocks the raw spinlock acquired by either drm_panic_lock() or
+ * drm_panic_trylock().
+ */
+static inline void drm_panic_unlock(struct drm_device *dev)
+{
+	raw_spin_unlock(&dev->mode_config.panic_lock);
+}
+
+#endif /* __DRM_PANIC_H__ */
-- 
2.43.0


