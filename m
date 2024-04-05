Return-Path: <linux-kernel+bounces-132893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F41899BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8831E286863
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422D16C69F;
	Fri,  5 Apr 2024 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAzmL4/8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4D16C42E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315402; cv=none; b=CkdHX5B2QyImK3BSyGvdB0LEpGDUm/OlkGAVbFRezcdlxQpubvnzX+kOz6PjRGMBmO/TaUXdnM41E1susl5b1i4BesDFV0vIPKCX2LnN6e7htsN9u3Qm2X+e2IDeE+EArYJ2yV7Q1E6Kw0EeUpLPsnBwX4sMKf0CKsSc+/bmRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315402; c=relaxed/simple;
	bh=rtDNdH9T/V+SH8Uxz+khdfZdc4dUwD3Wrt3AN23zUWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ceBNoxsia+gdgL5WwHO7v/vqY4Jy0ShlDoTSTHQ98s/MaTgLfzLE6BJDNuRio8zZjX3GjSgvo8XObR644LwJYdA0VT/PRTq/QoWXiwfIuXOa7nwgU+93bp97+n+OZpCBsKWdf42/vMt+Ffr5FUEqzSm2tx31hoB0j31S/j9cGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EAzmL4/8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ead4093f85so1751153b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712315399; x=1712920199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lHSLoZMeJ+GxuQ3DvQ6li8qiuwjNUgRcNrW4cLzKFw=;
        b=EAzmL4/8hHQFvHP9m+gu88Bbn3nbYGc0LZmP6nW9QpaKlWeLnjcg9ufceQJ5JAW9lH
         jRcObHnsxgtl4gaTGpxj4HwVH5HLTRC5rzEWpUyjvP2qexQ1sPysH+B1hp75wwPeTTsM
         jdeVzmT9IwiU8E4gNERZ3PFyeyxADsQPeEwrWg0Ajp4Im766nzkf8+9moev7xaAa5Y0f
         vzpk43Q1UK6H+qQok289ZvO9MXXC7LAiO8AHtip1iIsIueD5F7urlccQOOMkiJ2VLa4T
         rman/5w1aySH3yvzQH2gh2jL7kXrGym/9W6S12x8oaLR42XUyCSJ96O+Bw2pMRWaQJpt
         ceZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712315399; x=1712920199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lHSLoZMeJ+GxuQ3DvQ6li8qiuwjNUgRcNrW4cLzKFw=;
        b=SRFmCKlq8Z65qOm/2CTyT1afdlYfsLHQuuHU8FbXtpuaJByoZCzpubzWm49Z77YTRg
         x/K46sKojYKkdPyddcnTEw1t3YYhi5c9PPk8+udAfneTMhHjaa0LIu/rq+wg1AVvh1q1
         T/tEM/yEexeBZFYHr0rUwGJiAno9ZFPhlxCfoHjBrkWAhEUcPjkgkZuWHAxLTN/J4u0U
         8FtxEZXbIN9TE5jAnAbVxX9YQPaUodMffVXrPWsWyUk6ygUgHO8MxwOCqN4bNWq80B59
         fnLZgryfHrTK10v+nbpb43G89WRKYqmuDSk37tfnab2RFAo55HB2a+aUZ+qjqWkvIsI9
         Zkog==
X-Forwarded-Encrypted: i=1; AJvYcCX6+qofjr+XwkmvmTsa1KI5F78A945EfufAlLCLJ2msFgOPtdxe8MEufKUJZY7jfc64mbNvRgckoEtga9VNTQXZG9oZq5YQhXSaOLIH
X-Gm-Message-State: AOJu0YwAis0DNp0FktEmH6IoXtetkBWtexoX6CBJtdiskpPxZL0Gh/YI
	91Eu/8ikKSwl7vT32wfuyBTnYCeXUoV2501DdN7cgt+j+7d153ItplNJ9BNnGz0=
X-Google-Smtp-Source: AGHT+IFpAarlTm02HmGJxzRQx9BCc7uFM/9Sg2eBPRJZN8hASYfwXGvYvaUn/Aa3I06DJRNjGX+cmA==
X-Received: by 2002:a05:6a00:92a4:b0:6ea:bd59:9389 with SMTP id jw36-20020a056a0092a400b006eabd599389mr1206004pfb.8.1712315398469;
        Fri, 05 Apr 2024 04:09:58 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id km23-20020a056a003c5700b006e6bf17ba8asm1240096pfb.65.2024.04.05.04.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 04:09:58 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] rust: Add bindings for cpufreq framework
Date: Fri,  5 Apr 2024 16:39:39 +0530
Message-Id: <efeb1927ceb688ee691442bc9421385d67162ede.1712314032.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1712314032.git.viresh.kumar@linaro.org>
References: <cover.1712314032.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds Rust bindings for the cpufreq core. The current
implementation doesn't implement Rust wrappers for all the APIs, but
mostly the ones usable by the cpufreq-dt driver.

The missing APIs will be added later once required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h |    1 +
 rust/helpers.c                  |   15 +
 rust/kernel/cpufreq.rs          | 1090 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |    2 +
 4 files changed, 1108 insertions(+)
 create mode 100644 rust/kernel/cpufreq.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 370043838a54..b88eb1a14eee 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/cred.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 05dac59941e4..a2108ac89f5c 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/bug.h>
 #include <linux/build_bug.h>
 #include <linux/cpumask.h>
+#include <linux/cpufreq.h>
 #include <linux/cred.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -315,6 +316,20 @@ void rust_helper_cpumask_setall(struct cpumask *dstp)
 }
 EXPORT_SYMBOL_GPL(rust_helper_cpumask_setall);
 
+#ifdef CONFIG_CPU_FREQ
+unsigned int rust_helper_cpufreq_table_len(struct cpufreq_frequency_table *freq_table)
+{
+	return cpufreq_table_len(freq_table);
+}
+EXPORT_SYMBOL_GPL(rust_helper_cpufreq_table_len);
+
+void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	cpufreq_register_em_with_opp(policy);
+}
+EXPORT_SYMBOL_GPL(rust_helper_cpufreq_register_em_with_opp);
+#endif
+
 #ifndef CONFIG_OF_DYNAMIC
 struct device_node *rust_helper_of_node_get(struct device_node *node)
 {
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
new file mode 100644
index 000000000000..4c9a7534179c
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,1090 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU frequency scaling.
+//!
+//! This module provides bindings for interacting with the cpufreq subsystem.
+//!
+//! C header: [`include/linux/cpufreq.h`](../../../../../../include/linux/cpufreq.h)
+
+use crate::{
+    bindings,
+    device::{Device, RawDevice},
+    error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
+    prelude::*,
+    types::ForeignOwnable,
+};
+
+use core::{
+    cell::UnsafeCell,
+    marker::{PhantomData, PhantomPinned},
+    pin::Pin,
+    ptr::{self, addr_of_mut},
+};
+
+use macros::vtable;
+
+/// Default transition latency value.
+pub const ETERNAL_LATENCY: u32 = bindings::CPUFREQ_ETERNAL as u32;
+
+/// Container for cpufreq driver flags.
+pub mod flags {
+    use crate::bindings;
+
+    /// Set by drivers that need to update internal upper and lower boundaries along with the
+    /// target frequency and so the core and governors should also invoke the driver if the target
+    /// frequency does not change, but the policy min or max may have changed.
+    pub const NEED_UPDATE_LIMITS: u16 = bindings::CPUFREQ_NEED_UPDATE_LIMITS as _;
+
+    /// Set by drivers for platforms where loops_per_jiffy or other kernel "constants" aren't
+    /// affected by frequency transitions.
+    pub const CONST_LOOPS: u16 = bindings::CPUFREQ_CONST_LOOPS as _;
+
+    /// Set by drivers that want the core to automatically register the cpufreq driver as a thermal
+    /// cooling device.
+    pub const IS_COOLING_DEV: u16 = bindings::CPUFREQ_IS_COOLING_DEV as _;
+
+    /// Set by drivers for platforms that have multiple clock-domains, i.e.  supporting multiple
+    /// policies. With this sysfs directories of governor would be created in cpu/cpuN/cpufreq/
+    /// directory and so they can use the same governor with different tunables for different
+    /// clusters.
+    pub const HAVE_GOVERNOR_PER_POLICY: u16 = bindings::CPUFREQ_HAVE_GOVERNOR_PER_POLICY as _;
+
+    /// Set by drivers which do POSTCHANGE notifications from outside of their ->target() routine.
+    pub const ASYNC_NOTIFICATION: u16 = bindings::CPUFREQ_ASYNC_NOTIFICATION as _;
+
+    /// Set by drivers that want cpufreq core to check if CPU is running at a frequency present in
+    /// freq-table exposed by the driver. For these drivers if CPU is found running at an out of
+    /// table freq, the cpufreq core will try to change the frequency to a value from the table.
+    /// And if that fails, it will stop further boot process by issuing a BUG_ON().
+    pub const NEED_INITIAL_FREQ_CHECK: u16 = bindings::CPUFREQ_NEED_INITIAL_FREQ_CHECK as _;
+
+    /// Set by drivers to disallow use of governors with "dynamic_switching" flag set.
+    pub const NO_AUTO_DYNAMIC_SWITCHING: u16 = bindings::CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING as _;
+}
+
+/// CPU frequency selection relations. Each value contains a `bool` argument which corresponds to
+/// the Relation being efficient.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum Relation {
+    /// Select the lowest frequency at or above target.
+    Low(bool),
+    /// Select the highest frequency below or at target.
+    High(bool),
+    /// Select the closest frequency to the target.
+    Close(bool),
+}
+
+impl Relation {
+    // Converts from a value compatible with the C code.
+    fn new(val: u32) -> Result<Self> {
+        let efficient = val & bindings::CPUFREQ_RELATION_E != 0;
+
+        Ok(match val & !bindings::CPUFREQ_RELATION_E {
+            bindings::CPUFREQ_RELATION_L => Self::Low(efficient),
+            bindings::CPUFREQ_RELATION_H => Self::High(efficient),
+            bindings::CPUFREQ_RELATION_C => Self::Close(efficient),
+            _ => return Err(EINVAL),
+        })
+    }
+
+    /// Converts to a value compatible with the C code.
+    pub fn val(&self) -> u32 {
+        let (mut val, e) = match self {
+            Self::Low(e) => (bindings::CPUFREQ_RELATION_L, e),
+            Self::High(e) => (bindings::CPUFREQ_RELATION_H, e),
+            Self::Close(e) => (bindings::CPUFREQ_RELATION_C, e),
+        };
+
+        if *e {
+            val |= bindings::CPUFREQ_RELATION_E;
+        }
+
+        val
+    }
+}
+
+/// Equivalent to `struct cpufreq_policy_data` in the C code.
+#[repr(transparent)]
+pub struct PolicyData(*mut bindings::cpufreq_policy_data);
+
+impl PolicyData {
+    /// Creates new instance of [`PolicyData`].
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    pub unsafe fn from_ptr(ptr: *mut bindings::cpufreq_policy_data) -> Self {
+        Self(ptr)
+    }
+
+    /// Returns the raw pointer to the C structure.
+    pub fn as_ptr(&self) -> *mut bindings::cpufreq_policy_data {
+        self.0
+    }
+}
+
+/// Builder for the `struct cpufreq_frequency_table` in the C code.
+#[repr(transparent)]
+pub struct TableBuilder {
+    entries: Vec<bindings::cpufreq_frequency_table>,
+}
+
+impl TableBuilder {
+    /// Creates new instance of [`TableBuilder`].
+    pub fn new() -> Self {
+        Self {
+            entries: Vec::new(),
+        }
+    }
+
+    /// Adds a new entry to the table.
+    pub fn add(&mut self, frequency: u32, flags: u32, driver_data: u32) -> Result<()> {
+        // Adds new entry to the end of the vector.
+        Ok(self.entries.try_push(bindings::cpufreq_frequency_table {
+            flags,
+            driver_data,
+            frequency,
+        })?)
+    }
+
+    /// Creates [`Table`] from [`TableBuilder`].
+    pub fn into_table(mut self) -> Result<Table> {
+        // Add last entry to the table.
+        self.add(bindings::CPUFREQ_TABLE_END as u32, 0, 0)?;
+        Table::from_builder(self.entries)
+    }
+}
+
+/// A simple implementation of the cpufreq table, equivalent to the `struct
+/// cpufreq_frequency_table` in the C code.
+pub struct Table {
+    #[allow(dead_code)]
+    // Dynamically created table.
+    entries: Option<Pin<Vec<bindings::cpufreq_frequency_table>>>,
+
+    // Pointer to the statically or dynamically created table.
+    ptr: *mut bindings::cpufreq_frequency_table,
+
+    // Number of entries in the table.
+    len: usize,
+}
+
+impl Table {
+    /// Creates new instance of [`Table`] from [`TableBuilder`].
+    fn from_builder(entries: Vec<bindings::cpufreq_frequency_table>) -> Result<Self> {
+        let len = entries.len();
+        if len == 0 {
+            return Err(EINVAL);
+        }
+
+        // Pin the entries to memory, since we are passing its pointer to the C code.
+        let mut entries = Pin::new(entries);
+
+        // The pointer is valid until the table gets dropped.
+        let ptr = entries.as_mut_ptr();
+
+        Ok(Self {
+            entries: Some(entries),
+            ptr,
+            // The last entry in table is reserved for `CPUFREQ_TABLE_END`.
+            len: len - 1,
+        })
+    }
+
+    /// Creates new instance of [`Table`] from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null for the lifetime of the [`Table`].
+    pub unsafe fn from_raw(ptr: *mut bindings::cpufreq_frequency_table) -> Self {
+        Self {
+            entries: None,
+            ptr,
+            // SAFETY: The pointer is guaranteed to be valid for the lifetime of `Self`.
+            len: unsafe { bindings::cpufreq_table_len(ptr) } as usize,
+        }
+    }
+
+    // Validate the index.
+    fn validate(&self, index: usize) -> Result<()> {
+        if index >= self.len {
+            Err(EINVAL)
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Returns raw pointer to the `struct cpufreq_frequency_table` compatible with the C code.
+    pub fn as_ptr(&self) -> *mut bindings::cpufreq_frequency_table {
+        self.ptr
+    }
+
+    /// Returns `frequency` at index in the [`Table`].
+    pub fn freq(&self, index: usize) -> Result<u32> {
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).frequency })
+    }
+
+    /// Returns `flags` at index in the [`Table`].
+    pub fn flags(&self, index: usize) -> Result<u32> {
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).flags })
+    }
+
+    /// Returns `data` at index in the [`Table`].
+    pub fn data(&self, index: usize) -> Result<u32> {
+        self.validate(index)?;
+
+        // SAFETY: The pointer is guaranteed to be valid for the lifetime of `self` and `index` is
+        // also validated before this and is guaranteed to be within limits of the frequency table.
+        Ok(unsafe { (*self.ptr.add(index)).driver_data })
+    }
+}
+
+/// A simple implementation of `struct clk` from the C code.
+#[repr(transparent)]
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    fn new(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call `clk_get()`, on a device pointer earlier received from the C
+        // code.
+        Ok(Self(from_err_ptr(unsafe {
+            bindings::clk_get(dev.raw_device(), con_id)
+        })?))
+    }
+
+    fn as_ptr(&self) -> *mut bindings::clk {
+        self.0
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::clk_put(self.0) };
+    }
+}
+
+/// A simple implementation of `struct cpumask` from the C code.
+#[repr(transparent)]
+pub struct Cpumask(*mut bindings::cpumask);
+
+impl Cpumask {
+    /// Creates cpumask from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    pub unsafe fn new(ptr: *mut bindings::cpumask) -> Self {
+        Self(ptr)
+    }
+
+    /// Returns pointer to the underlying cpumask from the C code.
+    pub fn as_ptr(&self) -> *const bindings::cpumask {
+        self.0
+    }
+
+    /// Returns mutable pointer to the underlying cpumask from the C code.
+    pub fn as_mut_ptr(&mut self) -> *mut bindings::cpumask {
+        self.0
+    }
+}
+
+/// Equivalent to `struct cpufreq_policy` in the C code.
+pub struct Policy {
+    ptr: *mut bindings::cpufreq_policy,
+    put_cpu: bool,
+    cpumask: Cpumask,
+}
+
+impl Policy {
+    /// Creates a new instance of [`Policy`].
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    pub unsafe fn from_ptr(ptr: *mut bindings::cpufreq_policy) -> Self {
+        Self {
+            ptr,
+            put_cpu: false,
+            // SAFETY: The pointer is guaranteed to be valid for the lifetime of `Self`. The `cpus`
+            // pointer is guaranteed to be valid by the C code.
+            cpumask: unsafe { Cpumask::new((*ptr).cpus) },
+        }
+    }
+
+    fn from_cpu(cpu: u32) -> Result<Self> {
+        // SAFETY: It is safe to call `cpufreq_cpu_get()` for any CPU.
+        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu) })?;
+
+        // SAFETY: The pointer is guaranteed to be valid by the C code.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        policy.put_cpu = true;
+        Ok(policy)
+    }
+
+    /// Raw pointer to the underlying cpufreq policy.
+    pub fn as_ptr(&self) -> *mut bindings::cpufreq_policy {
+        self.ptr
+    }
+
+    fn as_ref(&self) -> &bindings::cpufreq_policy {
+        // SAFETY: By the type invariants, we know that `self` owns a reference to the pointer.
+        unsafe { &(*self.ptr) }
+    }
+    fn as_mut_ref(&mut self) -> &mut bindings::cpufreq_policy {
+        // SAFETY: By the type invariants, we know that `self` owns a reference to the pointer.
+        unsafe { &mut (*self.ptr) }
+    }
+
+    /// Returns the primary CPU for a cpufreq policy.
+    pub fn cpu(&self) -> u32 {
+        self.as_ref().cpu
+    }
+
+    /// Returns the minimum frequency for a cpufreq policy.
+    pub fn min(&self) -> u32 {
+        self.as_ref().min
+    }
+
+    /// Returns the maximum frequency for a cpufreq policy.
+    pub fn max(&self) -> u32 {
+        self.as_ref().max
+    }
+
+    /// Returns the current frequency for a cpufreq policy.
+    pub fn cur(&self) -> u32 {
+        self.as_ref().cur
+    }
+
+    /// Sets the suspend frequency for a cpufreq policy.
+    pub fn set_suspend_freq(&mut self, freq: u32) {
+        self.as_mut_ref().suspend_freq = freq;
+    }
+
+    /// Returns the suspend frequency for a cpufreq policy.
+    pub fn suspend_freq(&self) -> u32 {
+        self.as_ref().suspend_freq
+    }
+
+    /// Gets raw pointer to cpufreq policy's CPUs mask.
+    pub fn cpus(&mut self) -> &mut Cpumask {
+        &mut self.cpumask
+    }
+
+    /// Sets CPUs mask for a cpufreq policy.
+    ///
+    /// Update the `cpus` mask with a single CPU.
+    pub fn set_cpus(&mut self, cpu: u32) {
+        // SAFETY: The `cpus` pointer is guaranteed to be valid for the lifetime of `self`. And it
+        // is safe to call `cpumask_set_cpus()` for any CPU.
+        unsafe { bindings::cpumask_set_cpu(cpu, self.cpus().as_mut_ptr()) };
+    }
+
+    /// Sets CPUs mask for a cpufreq policy.
+    ///
+    /// Update the `cpus` mask with a single CPU if `cpu` is set to `Some(cpu)`, else sets all
+    /// CPUs.
+    pub fn set_all_cpus(&mut self) {
+        // SAFETY: The `cpus` pointer is guaranteed to be valid for the lifetime of `self`. And it
+        // is safe to call `cpumask_setall()`.
+        unsafe { bindings::cpumask_setall(self.cpus().as_mut_ptr()) };
+    }
+
+    /// Sets clock for a cpufreq policy.
+    pub fn set_clk(&mut self, dev: &Device, name: Option<&CStr>) -> Result<Clk> {
+        let clk = Clk::new(dev, name)?;
+        self.as_mut_ref().clk = clk.as_ptr();
+        Ok(clk)
+    }
+
+    /// Allows frequency switching code to run on any CPU.
+    pub fn set_dvfs_possible_from_any_cpu(&mut self) {
+        self.as_mut_ref().dvfs_possible_from_any_cpu = true;
+    }
+
+    /// Sets transition latency for a cpufreq policy.
+    pub fn set_transition_latency(&mut self, latency: u32) {
+        self.as_mut_ref().cpuinfo.transition_latency = latency;
+    }
+
+    /// Returns the cpufreq table for a cpufreq policy. The cpufreq table is recreated in a
+    /// light-weight manner from the raw pointer. The table in C code is not freed once this table
+    /// is dropped.
+    pub fn freq_table(&self) -> Result<Table> {
+        if self.as_ref().freq_table == ptr::null_mut() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The `freq_table` is guaranteed to be valid.
+        Ok(unsafe { Table::from_raw(self.as_ref().freq_table) })
+    }
+
+    /// Sets the cpufreq table for a cpufreq policy.
+    ///
+    /// The cpufreq driver must guarantee that the frequency table does not get freed while it is
+    /// still being used by the C code.
+    pub fn set_freq_table(&mut self, table: &Table) {
+        self.as_mut_ref().freq_table = table.as_ptr();
+    }
+
+    /// Returns the data for a cpufreq policy.
+    pub fn data<T: ForeignOwnable>(&mut self) -> Option<<T>::Borrowed<'_>> {
+        if self.as_ref().driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: The data is earlier set by us from [`set_data()`].
+            Some(unsafe { T::borrow(self.as_ref().driver_data) })
+        }
+    }
+
+    // Sets the data for a cpufreq policy.
+    fn set_data<T: ForeignOwnable>(&mut self, data: T) -> Result<()> {
+        if self.as_ref().driver_data.is_null() {
+            // Pass the ownership of the data to the foreign interface.
+            self.as_mut_ref().driver_data = <T as ForeignOwnable>::into_foreign(data) as _;
+            Ok(())
+        } else {
+            Err(EBUSY)
+        }
+    }
+
+    // Returns the data for a cpufreq policy.
+    fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
+        if self.as_ref().driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: The data is earlier set by us from [`set_data()`]. It is safe to take back
+            // the ownership of the data from the foreign interface.
+            let data =
+                Some(unsafe { <T as ForeignOwnable>::from_foreign(self.as_ref().driver_data) });
+            self.as_mut_ref().driver_data = ptr::null_mut();
+            data
+        }
+    }
+}
+
+impl Drop for Policy {
+    fn drop(&mut self) {
+        if self.put_cpu {
+            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+            // relinquish it now.
+            unsafe { bindings::cpufreq_cpu_put(self.as_ptr()) };
+        }
+    }
+}
+
+/// Operations to be implemented by a cpufreq driver.
+#[vtable]
+pub trait DriverOps {
+    /// Driver specific data.
+    ///
+    /// Corresponds to the data retrieved via the kernel's
+    /// `cpufreq_get_driver_data()` function.
+    ///
+    /// Require that `Data` implements `ForeignOwnable`. We guarantee to
+    /// never move the underlying wrapped data structure.
+    type Data: ForeignOwnable = ();
+
+    /// Policy specific data.
+    ///
+    /// Require that `PData` implements `ForeignOwnable`. We guarantee to
+    /// never move the underlying wrapped data structure.
+    type PData: ForeignOwnable = ();
+
+    /// Policy's init callback.
+    fn init(policy: &mut Policy) -> Result<Self::PData>;
+
+    /// Policy's exit callback.
+    fn exit(_policy: &mut Policy, _data: Option<Self::PData>) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's online callback.
+    fn online(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's offline callback.
+    fn offline(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's suspend callback.
+    fn suspend(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's resume callback.
+    fn resume(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's ready callback.
+    fn ready(_policy: &mut Policy) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's verify callback.
+    fn verify(data: &mut PolicyData) -> Result<()>;
+
+    /// Policy's setpolicy callback.
+    fn setpolicy(_policy: &mut Policy) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target callback.
+    fn target(_policy: &mut Policy, _target_freq: u32, _relation: Relation) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target_index callback.
+    fn target_index(_policy: &mut Policy, _index: u32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's fast_switch callback.
+    fn fast_switch(_policy: &mut Policy, _target_freq: u32) -> u32 {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's adjust_perf callback.
+    fn adjust_perf(_policy: &mut Policy, _min_perf: u64, _target_perf: u64, _capacity: u64) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's get_intermediate callback.
+    fn get_intermediate(_policy: &mut Policy, _index: u32) -> u32 {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's target_intermediate callback.
+    fn target_intermediate(_policy: &mut Policy, _index: u32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's get callback.
+    fn get(_policy: &mut Policy) -> Result<u32> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's update_limits callback.
+    fn update_limits(_policy: &mut Policy) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's bios_limit callback.
+    fn bios_limit(_policy: &mut Policy, _limit: &mut u32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's set_boost callback.
+    fn set_boost(_policy: &mut Policy, _state: i32) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Policy's register_em callback.
+    fn register_em(_policy: &mut Policy) {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Registration of a cpufreq driver.
+pub struct Registration<T: DriverOps> {
+    registered: bool,
+    drv: UnsafeCell<bindings::cpufreq_driver>,
+    _p: PhantomData<T>,
+    _pin: PhantomPinned,
+}
+
+// SAFETY: `Registration` doesn't offer any methods or access to fields when shared between threads
+// or CPUs, so it is safe to share it.
+unsafe impl<T: DriverOps> Sync for Registration<T> {}
+
+// SAFETY: Registration with and unregistration from the cpufreq subsystem can happen from any thread.
+// Additionally, `T::Data` (which is dropped during unregistration) is `Send`, so it is okay to move
+// `Registration` to different threads.
+#[allow(clippy::non_send_fields_in_send_ty)]
+unsafe impl<T: DriverOps> Send for Registration<T> {}
+
+impl<T: DriverOps> Default for Registration<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T: DriverOps> Registration<T> {
+    /// Creates new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new() -> Self {
+        Self {
+            registered: false,
+            drv: UnsafeCell::new(bindings::cpufreq_driver::default()),
+            _pin: PhantomPinned,
+            _p: PhantomData,
+        }
+    }
+
+    /// Registers a cpufreq driver with the rest of the kernel.
+    pub fn register(
+        self: Pin<&mut Self>,
+        name: &'static CStr,
+        data: T::Data,
+        flags: u16,
+        boost: bool,
+    ) -> Result {
+        // SAFETY: We never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+
+        if this.registered {
+            return Err(EINVAL);
+        }
+
+        let drv = this.drv.get_mut();
+
+        // Account for the trailing null character.
+        let len = name.len() + 1;
+        if len > drv.name.len() {
+            return Err(EINVAL);
+        };
+
+        // SAFETY: `name` is a valid Cstr, and we are copying it to an array of equal or larger
+        // size.
+        let name = unsafe { &*(name.as_bytes_with_nul() as *const [u8] as *const [i8]) };
+        drv.name[..len].copy_from_slice(name);
+
+        drv.boost_enabled = boost;
+        drv.flags = flags;
+
+        // Allocate an array of 3 pointers to be passed to the C code.
+        let mut attr = Box::try_new([ptr::null_mut(); 3])?;
+        let mut next = 0;
+
+        // SAFETY: The C code returns a valid pointer here, which is again passed to the C code in
+        // an array.
+        attr[next] =
+            unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_available_freqs) as *mut _ };
+        next += 1;
+
+        if boost {
+            // SAFETY: The C code returns a valid pointer here, which is again passed to the C code
+            // in an array.
+            attr[next] =
+                unsafe { addr_of_mut!(bindings::cpufreq_freq_attr_scaling_boost_freqs) as *mut _ };
+            next += 1;
+        }
+        attr[next] = ptr::null_mut();
+
+        // Pass the ownership of the memory block to the C code. This will be freed when
+        // the [`Registration`] object goes out of scope.
+        drv.attr = Box::leak(attr) as *mut _;
+
+        // Initialize mandatory callbacks.
+        drv.init = Some(Self::init_callback);
+        drv.verify = Some(Self::verify_callback);
+
+        // Initialize optional callbacks.
+        drv.setpolicy = if T::HAS_SETPOLICY {
+            Some(Self::setpolicy_callback)
+        } else {
+            None
+        };
+        drv.target = if T::HAS_TARGET {
+            Some(Self::target_callback)
+        } else {
+            None
+        };
+        drv.target_index = if T::HAS_TARGET_INDEX {
+            Some(Self::target_index_callback)
+        } else {
+            None
+        };
+        drv.fast_switch = if T::HAS_FAST_SWITCH {
+            Some(Self::fast_switch_callback)
+        } else {
+            None
+        };
+        drv.adjust_perf = if T::HAS_ADJUST_PERF {
+            Some(Self::adjust_perf_callback)
+        } else {
+            None
+        };
+        drv.get_intermediate = if T::HAS_GET_INTERMEDIATE {
+            Some(Self::get_intermediate_callback)
+        } else {
+            None
+        };
+        drv.target_intermediate = if T::HAS_TARGET_INTERMEDIATE {
+            Some(Self::target_intermediate_callback)
+        } else {
+            None
+        };
+        drv.get = if T::HAS_GET {
+            Some(Self::get_callback)
+        } else {
+            None
+        };
+        drv.update_limits = if T::HAS_UPDATE_LIMITS {
+            Some(Self::update_limits_callback)
+        } else {
+            None
+        };
+        drv.bios_limit = if T::HAS_BIOS_LIMIT {
+            Some(Self::bios_limit_callback)
+        } else {
+            None
+        };
+        drv.online = if T::HAS_ONLINE {
+            Some(Self::online_callback)
+        } else {
+            None
+        };
+        drv.offline = if T::HAS_OFFLINE {
+            Some(Self::offline_callback)
+        } else {
+            None
+        };
+        drv.exit = if T::HAS_EXIT {
+            Some(Self::exit_callback)
+        } else {
+            None
+        };
+        drv.suspend = if T::HAS_SUSPEND {
+            Some(Self::suspend_callback)
+        } else {
+            None
+        };
+        drv.resume = if T::HAS_RESUME {
+            Some(Self::resume_callback)
+        } else {
+            None
+        };
+        drv.ready = if T::HAS_READY {
+            Some(Self::ready_callback)
+        } else {
+            None
+        };
+        drv.set_boost = if T::HAS_SET_BOOST {
+            Some(Self::set_boost_callback)
+        } else {
+            None
+        };
+        drv.register_em = if T::HAS_REGISTER_EM {
+            Some(Self::register_em_callback)
+        } else {
+            None
+        };
+
+        // Set driver data before registering the driver, as the cpufreq core may call few
+        // callbacks before `cpufreq_register_driver()` returns.
+        this.set_data(data)?;
+
+        // SAFETY: It is safe to register the driver with the cpufreq core in the C code.
+        to_result(unsafe { bindings::cpufreq_register_driver(this.drv.get_mut()) })?;
+
+        this.registered = true;
+        Ok(())
+    }
+
+    /// Returns the previous set data for a cpufreq driver.
+    pub fn data<D: ForeignOwnable>() -> Option<<D>::Borrowed<'static>> {
+        // SAFETY: The driver data is earlier set by us from [`set_data()`].
+        let data = unsafe { bindings::cpufreq_get_driver_data() };
+        if data.is_null() {
+            None
+        } else {
+            // SAFETY: The driver data is earlier set by us from [`set_data()`].
+            Some(unsafe { D::borrow(data) })
+        }
+    }
+
+    // Sets the data for a cpufreq driver.
+    fn set_data(&mut self, data: T::Data) -> Result<()> {
+        let drv = self.drv.get_mut();
+
+        if drv.driver_data.is_null() {
+            // Pass the ownership of the data to the foreign interface.
+            drv.driver_data = <T::Data as ForeignOwnable>::into_foreign(data) as _;
+            Ok(())
+        } else {
+            Err(EBUSY)
+        }
+    }
+
+    // Clears and returns the data for a cpufreq driver.
+    fn clear_data(&mut self) -> Option<T::Data> {
+        let drv = self.drv.get_mut();
+
+        if drv.driver_data.is_null() {
+            None
+        } else {
+            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+            // relinquish it now.
+            let data = Some(unsafe { <T::Data as ForeignOwnable>::from_foreign(drv.driver_data) });
+            drv.driver_data = ptr::null_mut();
+            data
+        }
+    }
+}
+
+// cpufreq driver callbacks.
+impl<T: DriverOps> Registration<T> {
+    // Policy's init callback.
+    extern "C" fn init_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+
+            let data = T::init(&mut policy)?;
+            policy.set_data(data)?;
+            Ok(0)
+        })
+    }
+
+    // Policy's exit callback.
+    extern "C" fn exit_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+
+            let data = policy.clear_data();
+            T::exit(&mut policy, data).map(|_| 0)
+        })
+    }
+
+    // Policy's online callback.
+    extern "C" fn online_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::online(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's offline callback.
+    extern "C" fn offline_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::offline(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's suspend callback.
+    extern "C" fn suspend_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::suspend(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's resume callback.
+    extern "C" fn resume_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::resume(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's ready callback.
+    extern "C" fn ready_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::ready(&mut policy);
+    }
+
+    // Policy's verify callback.
+    extern "C" fn verify_callback(ptr: *mut bindings::cpufreq_policy_data) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut data = unsafe { PolicyData::from_ptr(ptr) };
+            T::verify(&mut data).map(|_| 0)
+        })
+    }
+
+    // Policy's setpolicy callback.
+    extern "C" fn setpolicy_callback(ptr: *mut bindings::cpufreq_policy) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::setpolicy(&mut policy).map(|_| 0)
+        })
+    }
+
+    // Policy's target callback.
+    extern "C" fn target_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        target_freq: u32,
+        relation: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::target(&mut policy, target_freq, Relation::new(relation)?).map(|_| 0)
+        })
+    }
+
+    // Policy's target_index callback.
+    extern "C" fn target_index_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::target_index(&mut policy, index).map(|_| 0)
+        })
+    }
+
+    // Policy's fast_switch callback.
+    extern "C" fn fast_switch_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        target_freq: u32,
+    ) -> core::ffi::c_uint {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::fast_switch(&mut policy, target_freq)
+    }
+
+    // Policy's adjust_perf callback.
+    extern "C" fn adjust_perf_callback(cpu: u32, min_perf: u64, target_perf: u64, capacity: u64) {
+        if let Some(mut policy) = Policy::from_cpu(cpu).ok() {
+            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
+        }
+    }
+
+    // Policy's get_intermediate callback.
+    extern "C" fn get_intermediate_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_uint {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::get_intermediate(&mut policy, index)
+    }
+
+    // Policy's target_intermediate callback.
+    extern "C" fn target_intermediate_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        index: u32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::target_intermediate(&mut policy, index).map(|_| 0)
+        })
+    }
+
+    // Policy's get callback.
+    extern "C" fn get_callback(cpu: u32) -> core::ffi::c_uint {
+        // SAFETY: Get the policy for a CPU.
+        Policy::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
+    }
+
+    // Policy's update_limit callback.
+    extern "C" fn update_limits_callback(cpu: u32) {
+        // SAFETY: Get the policy for a CPU.
+        if let Some(mut policy) = Policy::from_cpu(cpu).ok() {
+            T::update_limits(&mut policy);
+        }
+    }
+
+    // Policy's bios_limit callback.
+    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> core::ffi::c_int {
+        from_result(|| {
+            let mut policy = Policy::from_cpu(cpu as u32)?;
+
+            // SAFETY: The pointer is guaranteed by the C code to be valid.
+            T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|_| 0)
+        })
+    }
+
+    // Policy's set_boost callback.
+    extern "C" fn set_boost_callback(
+        ptr: *mut bindings::cpufreq_policy,
+        state: i32,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+            // duration of this call, so it is guaranteed to remain alive for the lifetime of
+            // `ptr`.
+            let mut policy = unsafe { Policy::from_ptr(ptr) };
+            T::set_boost(&mut policy, state).map(|_| 0)
+        })
+    }
+
+    // Policy's register_em callback.
+    extern "C" fn register_em_callback(ptr: *mut bindings::cpufreq_policy) {
+        // SAFETY: `ptr` is valid by the contract with the C code. `policy` is alive only for the
+        // duration of this call, so it is guaranteed to remain alive for the lifetime of
+        // `ptr`.
+        let mut policy = unsafe { Policy::from_ptr(ptr) };
+        T::register_em(&mut policy);
+    }
+}
+
+impl<T: DriverOps> Drop for Registration<T> {
+    // Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        let drv = self.drv.get_mut();
+
+        if self.registered {
+            // SAFETY: The driver was earlier registered from `register()`.
+            unsafe { bindings::cpufreq_unregister_driver(drv) };
+        }
+
+        // Free the previously leaked memory to the C code.
+        if !drv.attr.is_null() {
+            // SAFETY: The pointer was earlier initialized from the result of `Box::leak`.
+            unsafe { drop(Box::from_raw(drv.attr)) };
+        }
+
+        // Free data
+        drop(self.clear_data());
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 56b666f466a0..1c2f8903577a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -34,6 +34,8 @@
 #[cfg(not(testlib))]
 mod allocator;
 mod build_assert;
+#[cfg(CONFIG_CPU_FREQ)]
+pub mod cpufreq;
 pub mod cred;
 pub mod device;
 pub mod driver;
-- 
2.31.1.272.g89b43f80a514


