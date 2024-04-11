Return-Path: <linux-kernel+bounces-141686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57148A21FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63808B23EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372A47F51;
	Thu, 11 Apr 2024 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qzatVyx4"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF424778E;
	Thu, 11 Apr 2024 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876031; cv=none; b=je80hVh7fsHX9ApK2aS+8IvY6oW0bNf/wWtwHlbMNVpch3QpnvtibtgacRDGkATRCaKI9XXOw7lBjGvCBy3Ufa4SFSEyfq6ejibSSJ7NUsoZjwznKC8fTp565CwLHjUUeVD6G04UWdjNwluNHucVrveBywhxcb4CGvtyonAXxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876031; c=relaxed/simple;
	bh=qWSQajGvAFp8rYeLSWNIrAWsrlGO3m7nZf+qzgyXh60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u+6puQQOh6W6dfE39v1lEEzMlOz5KyIv1R8JCZPPyaHYLO1aDhe1QacGOMWJVjKST9NKYlo53yWWny/E5akuKgnKCEcsKyPjGh52L+Pf1oSOaDQrwq/AdBXeL4KYbvxotsCyANLfRsc18ONkITFSoIHklHGJk3TtU3igW/J8Ebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qzatVyx4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from nell-linux-vm-03-21.gri2q54hbuce1hot0vo1lnhzqd.bx.internal.cloudapp.net (unknown [172.191.244.78])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E2F920EC318;
	Thu, 11 Apr 2024 15:53:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E2F920EC318
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712876030;
	bh=llre/MDl7IywXh8WJ6+smgivWD460w0JI7M1HXl7uHU=;
	h=From:To:Cc:Subject:Date:From;
	b=qzatVyx42RykiqdKow7smAP17n/BvU/34tiZ1k7zzuvss7nhYzH9zPuec7yln8qJy
	 eIbAZAmxYVPQmviKjIl4uQLgDhSqTvNiIbFXuHMJA8YYzN8v6Y8+DPtyKSEc3QweDt
	 L9ns8Gs3OBDvt2POGQKwmKFv7Kq4QXz7/KkUU/9I=
From: Nell Shamrell-Harrington <nells@linux.microsoft.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	fujita.tomonori@gmail.com,
	tmgross@umich.edu,
	yakoyoku@gmail.com,
	kent.overstreet@gmail.com,
	matthew.brost@intel.com,
	kernel@valentinobst.de,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: remove unneeded `kernel::prelude` imports from doctests
Date: Thu, 11 Apr 2024 22:53:31 +0000
Message-Id: <20240411225331.274662-1-nells@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rust doctests implicitly include `kernel::prelude::*`.

Removes explicit `kernel::prelude` imports from doctests.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1064
Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
---
 rust/kernel/init.rs      | 6 +++---
 rust/kernel/net/phy.rs   | 1 -
 rust/kernel/workqueue.rs | 3 ---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 424257284d16..8f0380697c09 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -87,7 +87,7 @@
 //!
 //! ```rust
 //! # #![allow(clippy::disallowed_names)]
-//! # use kernel::{sync::Mutex, prelude::*, new_mutex, init::PinInit, try_pin_init};
+//! # use kernel::{sync::Mutex, new_mutex, init::PinInit, try_pin_init};
 //! #[pin_data]
 //! struct DriverData {
 //!     #[pin]
@@ -121,7 +121,7 @@
 //!
 //! ```rust
 //! # #![allow(unreachable_pub, clippy::disallowed_names)]
-//! use kernel::{prelude::*, init, types::Opaque};
+//! use kernel::{init, types::Opaque};
 //! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
 //! #     #![allow(non_camel_case_types)]
@@ -412,7 +412,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// ```rust
 /// # #![allow(clippy::disallowed_names)]
-/// # use kernel::{init, pin_init, prelude::*, init::*};
+/// # use kernel::{init, pin_init, init::*};
 /// # use core::pin::Pin;
 /// # #[pin_data]
 /// # struct Foo {
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 96e09c6e8530..d10a415c376f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -766,7 +766,6 @@ const fn as_int(&self) -> u32 {
 /// # mod module_phy_driver_sample {
 /// use kernel::c_str;
 /// use kernel::net::phy::{self, DeviceId};
-/// use kernel::prelude::*;
 ///
 /// kernel::module_phy_driver! {
 ///     drivers: [PhySample],
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index c22504d5c8ad..7884f0007b38 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -33,7 +33,6 @@
 //! we do not need to specify ids for the fields.
 //!
 //! ```
-//! use kernel::prelude::*;
 //! use kernel::sync::Arc;
 //! use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
 //!
@@ -75,7 +74,6 @@
 //! The following example shows how multiple `work_struct` fields can be used:
 //!
 //! ```
-//! use kernel::prelude::*;
 //! use kernel::sync::Arc;
 //! use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
 //!
@@ -411,7 +409,6 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 /// like this:
 ///
 /// ```no_run
-/// use kernel::prelude::*;
 /// use kernel::workqueue::{impl_has_work, Work};
 ///
 /// struct MyWorkItem {
-- 
2.34.1


