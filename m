Return-Path: <linux-kernel+bounces-112065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D098874CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C72848F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D181740;
	Fri, 22 Mar 2024 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtZkECFX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E7627FC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145745; cv=none; b=ICwhhwJTa6DSZHV7G4Yp8UQAvAql4SxRxPowQXMO8RkG/Gl0n1v1/3bACMfA6mZoL9a4Vu2l55DEmw+vdEPaksY3cIGpoK4ly9Zbdnc+jYj+w/5EYxzbpPKZIk7zddlzSKPIJtGcIgLK8UVpEJWPtUasNYapjCOU3EcOmA4VIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145745; c=relaxed/simple;
	bh=ycMrtdPn68CTRrt3aDmyI8tifKQ2EOf0nLCRHFWzr08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gag+72jv+UWfxwEYLRWsQ10UIWOM6pUf1xG4WL8GlJhbKf+DkXtCNomjJeqiQ/J9K4Nv0DurYV7WJiqF+72YjZGHBM1y7FxylDNwfpE9oFt1Ap998HLpyMeBSeJQq1CUjgkX++lBhiPKrJ9XI1tP4SVXicx/uaUcbBioii5l8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JtZkECFX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711145742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+o/hq/vRaAlqZorXgz61wZ5x9VfNVOFlmD2hAnuwQc=;
	b=JtZkECFX5OroTe2z+7T/LHbHzuguh/uULw919Wo8BycfmKV3jXP59AFMUhgkEq83R1lUj1
	We9zxxFcGye0E5HsNjTkPR5WJBmGxeywNAmg5/VOruQizGsOLrJYj65E39suuk+W596Lrv
	BGt7VRhX9hhOxGAmW/4IourcG5G+RSI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-JjZz40PEMPe23vRDS-XaXg-1; Fri,
 22 Mar 2024 18:15:38 -0400
X-MC-Unique: JjZz40PEMPe23vRDS-XaXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5C3D3C02454;
	Fri, 22 Mar 2024 22:15:36 +0000 (UTC)
Received: from emerald.redhat.com (unknown [10.22.8.130])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA338173;
	Fri, 22 Mar 2024 22:15:36 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Asahi Lina <lina@asahilina.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	rust-for-linux@vger.kernel.org (open list:RUST)
Subject: [PATCH 4/4] WIP: rust/drm/kms: Add ShadowPlaneState<T>
Date: Fri, 22 Mar 2024 18:03:36 -0400
Message-ID: <20240322221305.1403600-5-lyude@redhat.com>
In-Reply-To: <20240322221305.1403600-1-lyude@redhat.com>
References: <20240322221305.1403600-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/rvkms/plane.rs           |  7 +++-
 rust/bindings/bindings_helper.h          |  2 +
 rust/kernel/drm/kms.rs                   |  1 +
 rust/kernel/drm/kms/gem_atomic_helper.rs | 48 ++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/drm/kms/gem_atomic_helper.rs

diff --git a/drivers/gpu/drm/rvkms/plane.rs b/drivers/gpu/drm/rvkms/plane.rs
index d98a1f7bf79e2..5fb1b63842929 100644
--- a/drivers/gpu/drm/rvkms/plane.rs
+++ b/drivers/gpu/drm/rvkms/plane.rs
@@ -4,7 +4,10 @@
     prelude::*,
     drm::{
         device::Device,
-        kms::plane::{self, DriverPlaneState},
+        kms::{
+            plane::{self, DriverPlaneState},
+            gem_atomic_helper::ShadowPlaneState,
+        }
     },
 };
 
@@ -15,7 +18,7 @@ pub(crate) struct DriverPlane {
 }
 
 pub(crate) type Plane = plane::Plane<DriverPlane>;
-pub(crate) type PlaneState = plane::PlaneState<RvkmsPlaneState>;
+pub(crate) type PlaneState = ShadowPlaneState<RvkmsPlaneState>;
 
 impl plane::DriverPlane for DriverPlane {
     type Initializer = impl PinInit<Self, Error>;
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5856afbe6e8f6..73a5eb00e8625 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,8 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_ioctl.h>
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index b55d14415367a..14f4c3842ada0 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -6,6 +6,7 @@
 pub mod crtc;
 pub mod encoder;
 pub mod plane;
+pub mod gem_atomic_helper;
 
 use crate::{
     drm::{drv, device::Device},
diff --git a/rust/kernel/drm/kms/gem_atomic_helper.rs b/rust/kernel/drm/kms/gem_atomic_helper.rs
new file mode 100644
index 0000000000000..85bc3df32d8b7
--- /dev/null
+++ b/rust/kernel/drm/kms/gem_atomic_helper.rs
@@ -0,0 +1,48 @@
+use crate::{
+    prelude::*,
+    private::Sealed,
+    bindings,
+    init::Zeroable,
+};
+use super::plane::{IntoPlaneState, DriverPlaneState};
+
+unsafe impl Zeroable for bindings::drm_shadow_plane_state {}
+
+#[derive(Default)]
+#[repr(C)]
+pub struct ShadowPlaneState<T: DriverPlaneState> {
+    shadow_state: bindings::drm_shadow_plane_state,
+    inner: T,
+}
+
+impl<T: DriverPlaneState> Sealed for ShadowPlaneState<T> {}
+
+static_assert!(crate::offset_of!(bindings::drm_shadow_plane_state, base) == 0);
+
+// SAFETY: Our data layout starts with drm_plane_state (contained at the start of
+// drm_shadow_plane_state)
+unsafe impl<T: DriverPlaneState> IntoPlaneState for ShadowPlaneState<T> {
+    fn __duplicate_state(&self, plane: *mut bindings::drm_plane) -> Result<Box<Self>> {
+        let mut new: Box<Self> = Box::try_init(try_init!(Self {
+            shadow_state: bindings::drm_shadow_plane_state { ..Default::default() },
+            inner: self.inner.clone()
+        }))?;
+
+        // SAFETY: FFI call with no special requirements
+        unsafe { bindings::__drm_gem_duplicate_shadow_plane_state(plane, &mut new.shadow_state) };
+
+        Ok(new)
+    }
+
+    fn __destroy_state(state: *mut bindings::drm_plane_state) {
+        // SAFETY: This would not be called without a plane state to destroy, and our data layout
+        // starts with `bindings::drm_plane_state`
+        unsafe { bindings::__drm_gem_destroy_shadow_plane_state(state.cast()) };
+    }
+
+    fn __reset_state(plane: *mut bindings::drm_plane, state: *mut bindings::drm_plane_state) {
+        // SAFETY: This would not be called without a plane state to reset, and our data layout
+        // starts with `bindings::drm_plane_state`
+        unsafe { bindings::__drm_gem_reset_shadow_plane(plane, state.cast()) }
+    }
+}
-- 
2.43.0


