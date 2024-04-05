Return-Path: <linux-kernel+bounces-132892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54947899BA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C9D1C2281D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B416C454;
	Fri,  5 Apr 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtUmAC1v"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143FA16C453
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315397; cv=none; b=Isv7ghA4XBmcD6NKAhyqBheGf5MzonhEXfxSRg5u6YyEN40xchGvHykj3bByV6DPWFFCADdx67zG9+Vy6m6b+sqvmJCm/aY3DoMbn/XvGJGlHw8bGgBtG8gks49Ov8lFsYu0JkX5KUMZWGrkfv8taGFXK5UqeDBObEAaFq6MEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315397; c=relaxed/simple;
	bh=2EcJ5DiB+HBEAoHUohIiZf7RD7GHSOqqFQDVZWKbmss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bDAaBaMALIlbF6ehl/VyOh0Wz/j2RuQ3XdS/guDuWTUW3UZT+MdfJzmSQ2BVuN6x2Q/qIXDC3FOcDluJHM8kdqJL/6XH6Ovg1lX0XnKjTMM9bqm4NMVIZFnb81xUdvM/7JH51g3btQrrSww77Pz7kI5GOKO4Pk/lpLYYTO58lM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jtUmAC1v; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so2274207a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712315394; x=1712920194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsu5OYWeYSVBZDXAd+w+rXoj01VyZpbg9nhZSFAD/Ko=;
        b=jtUmAC1vkTK7JjtxYxrOp17yR8MlODkOoZE5EkjUTK51UTDcKtDeuvxc6xOb0rbJ4J
         JbvdeZtmvg+oFdRXpLOZR0okjodr+s5W30o9p69GZrsBmXfwFhKQxkfj4oLBxISmEW3k
         +oIRSppkhB8Np+tdW4a7WAMheFBUC3Zo7VZm2bActHj6L/EOK2aa3QUAjlZW54vd8o9f
         aiySnSkOhr7gYjJG8AO413Km4+yoEq+0pEY/744p+Ic9fFwO5fgVYqUkTt46OtERnAI+
         Wvx/PFdi2t6c5LsFwE6xi5QOWuSm7iMnQvZyYr/SVT7kHN82d1Bbq5PHkFAEEEHP6Ohu
         59Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712315394; x=1712920194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsu5OYWeYSVBZDXAd+w+rXoj01VyZpbg9nhZSFAD/Ko=;
        b=FkrjQhocahqHyt6pwGH38UiRvnAqjWJzm7HeFOmUAGRb38VQ3SMgOhjU6c+3xSVAY9
         /MWPU6+zitNZKLo1wqVM18iY9GFK/7IuYXO5IAPa3V0IDy7NbL4KteHpxclcrINnWDkx
         cg6F3DcDKEHI+jNxE1oZVPZLgUaOGs58c0w5KK0kOQYHnAE3ah+v1KoiVXMUR2WpE2Qd
         gnyiUuEIDjRXRWx3IAeIq4PRuYQjbZXwcLReCUqc3EQvrAlL9Esm07BnYkP/K6WHwa8g
         ZYL2xIoSG6x6tya/l14lJ8effyT9NimpifhVVgDJYye/GSUHBNPIaoJx2mOL77vSvJV9
         CW0g==
X-Forwarded-Encrypted: i=1; AJvYcCXM2GnFgqKCkJXYy9Wa1bV0IDkEpMI4+Vzoj3yxn6epcy0vReoTmv57BZmSsEtqcHrZFKm8/5Gbny+fX0tcxbJs7lEU0ctySo9cMyC0
X-Gm-Message-State: AOJu0YzdIvG0wmB8m/oEnzSoxMT56RQzh2H9ceSJpwqVnvKpIkfRoJh4
	suJ/Cf/VKzMWltc3dpzmpCaEmi1ortL8Dzzr5t9qmYif0BPV3a8n7hqimcupvkc=
X-Google-Smtp-Source: AGHT+IGgTgOgBLmYA6ftK3+ZUfKAwfsElLS+qJg9lnOaUfEGs2K3+NA1MUGU3wbCbJEaXfAh83VPkw==
X-Received: by 2002:a17:90b:3793:b0:2a2:9e5d:9bf9 with SMTP id mz19-20020a17090b379300b002a29e5d9bf9mr2912912pjb.8.1712315393848;
        Fri, 05 Apr 2024 04:09:53 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090a2dce00b002a25bf61931sm3057419pjm.29.2024.04.05.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 04:09:53 -0700 (PDT)
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
Subject: [RFC PATCH 1/3] rust: Add bindings for OPP framework
Date: Fri,  5 Apr 2024 16:39:38 +0530
Message-Id: <06bb914eae00671a69b393bf86bb01ddec86c16f.1712314032.git.viresh.kumar@linaro.org>
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

This commit adds Rust bindings for the Operating performance points
(OPP) core. The current implementation doesn't implement Rust wrappers
for all the APIs, but mostly the ones usable by the cpufreq-dt driver.

The missing APIs will be added later once required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/opp.rs              | 895 ++++++++++++++++++++++++++++++++
 3 files changed, 898 insertions(+)
 create mode 100644 rust/kernel/opp.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index baabff999bd5..370043838a54 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
+#include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a153336973e6..56b666f466a0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,8 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+#[cfg(CONFIG_PM_OPP)]
+pub mod opp;
 pub mod platform;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
new file mode 100644
index 000000000000..dba4b8592ac0
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,895 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Operating performance points.
+//!
+//! This module provides bindings for interacting with the OPP subsystem.
+//!
+//! C header: [`include/linux/pm_opp.h`](../../../../../../include/linux/pm_opp.h)
+
+use crate::{
+    bindings, cpufreq,
+    device::{Device, RawDevice},
+    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    prelude::*,
+    str::CString,
+};
+
+use core::{ffi::c_char, marker::PhantomData, ops::Deref, ptr};
+
+use macros::vtable;
+
+// Creates a pinned null-terminated slice of pointers to Cstrings.
+fn to_c_str_array(names: &Pin<Vec<CString>>) -> Result<Vec<*const c_char>> {
+    // Allocated a null-terminated vector of pointers.
+    let mut list = Vec::try_with_capacity(names.len() + 1)?;
+
+    for name in names.iter() {
+        list.try_push(name.as_ptr() as _)?;
+    }
+
+    list.try_push(ptr::null())?;
+    Ok(list)
+}
+
+/// Equivalent to `struct dev_pm_opp_data` in the C Code.
+#[repr(transparent)]
+pub struct Data(bindings::dev_pm_opp_data);
+
+impl Data {
+    /// Creates new instance of [`Data`].
+    pub fn new(freq: u64, u_volt: u64, level: u32, turbo: bool) -> Self {
+        Self(bindings::dev_pm_opp_data {
+            turbo,
+            freq,
+            u_volt,
+            level,
+        })
+    }
+}
+
+/// OPP search types.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum SearchType {
+    /// Search for exact value.
+    Exact,
+    /// Search for highest value less than equal to value.
+    Floor,
+    /// Search for lowest value greater than equal to value.
+    Ceil,
+}
+
+/// Implement this trait to provide OPP Configuration callbacks.
+#[vtable]
+pub trait ConfigOps {
+    /// Called by the OPP core to configure OPP clks.
+    fn config_clks(_dev: &Device, _table: &Table, _opp: &OPP, _scaling_down: bool) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Called by the OPP core to configure OPP regulators.
+    fn config_regulators(
+        _dev: &Device,
+        _opp_old: &OPP,
+        _opp_new: &OPP,
+        _data: *mut *mut bindings::regulator,
+        _count: u32,
+    ) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_config` in the C Code.
+pub struct Config<T: ConfigOps> {
+    token: Option<i32>,
+    clk_names: Option<Pin<Vec<CString>>>,
+    prop_name: Option<Pin<CString>>,
+    regulator_names: Option<Pin<Vec<CString>>>,
+    genpd_names: Option<Pin<Vec<CString>>>,
+    supported_hw: Option<Pin<Vec<u32>>>,
+    required_devs: Option<Pin<Vec<Device>>>,
+    _data: PhantomData<T>,
+}
+
+impl<T: ConfigOps> Config<T> {
+    /// Creates a new instance of [`Config`].
+    pub fn new() -> Self {
+        Self {
+            token: None,
+            clk_names: None,
+            prop_name: None,
+            regulator_names: None,
+            genpd_names: None,
+            supported_hw: None,
+            required_devs: None,
+            _data: PhantomData,
+        }
+    }
+
+    /// Initializes clock names.
+    pub fn set_clk_names(&mut self, names: Vec<CString>) -> Result<()> {
+        // Already configured.
+        if self.token.is_some() {
+            return Err(EBUSY);
+        }
+
+        // Already configured.
+        if self.clk_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.clk_names = Some(Pin::new(names));
+        Ok(())
+    }
+
+    /// Initializes property name.
+    pub fn set_prop_name(&mut self, name: CString) -> Result<()> {
+        // Already configured.
+        if self.token.is_some() {
+            return Err(EBUSY);
+        }
+
+        // Already configured.
+        if self.prop_name.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.prop_name = Some(Pin::new(name));
+        Ok(())
+    }
+
+    /// Initializes regulator names.
+    pub fn set_regulator_names(&mut self, names: Vec<CString>) -> Result<()> {
+        // Already configured.
+        if self.token.is_some() {
+            return Err(EBUSY);
+        }
+
+        // Already configured.
+        if self.regulator_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.regulator_names = Some(Pin::new(names));
+
+        Ok(())
+    }
+
+    /// Initializes genpd names.
+    pub fn set_genpd_names(&mut self, names: Vec<CString>) -> Result<()> {
+        // Already configured.
+        if self.token.is_some() {
+            return Err(EBUSY);
+        }
+
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.genpd_names = Some(Pin::new(names));
+        Ok(())
+    }
+
+    /// Initializes required devices.
+    pub fn set_required_devs(&mut self, devs: Vec<Device>) -> Result<()> {
+        // Already configured.
+        if self.token.is_some() {
+            return Err(EBUSY);
+        }
+
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if devs.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.required_devs = Some(Pin::new(devs));
+        Ok(())
+    }
+
+    /// Initializes supported hardware.
+    pub fn set_supported_hw(&mut self, hw: Vec<u32>) -> Result<()> {
+        // Already configured.
+        if self.token.is_some() {
+            return Err(EBUSY);
+        }
+
+        // Already configured.
+        if self.supported_hw.is_some() {
+            return Err(EBUSY);
+        }
+
+        if hw.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.supported_hw = Some(Pin::new(hw));
+        Ok(())
+    }
+
+    /// Sets the configuration with the OPP core.
+    pub fn set(&mut self, dev: &Device) -> Result<()> {
+        // Already configured.
+        if self.token.is_some() {
+            return Err(EBUSY);
+        }
+
+        let (_clk_list, clk_names) = match &self.clk_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_regulator_list, regulator_names) = match &self.regulator_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_genpd_list, genpd_names) = match &self.genpd_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let prop_name = match &self.prop_name {
+            Some(x) => x.as_char_ptr(),
+            None => ptr::null(),
+        };
+
+        let (supported_hw, supported_hw_count) = match &self.supported_hw {
+            Some(x) => (x.as_ptr(), x.len() as u32),
+            None => (ptr::null(), 0),
+        };
+
+        let (_required_devs_list, required_devs) = match &self.required_devs {
+            Some(x) => {
+                // Create a non-NULL-terminated vectorof pointers.
+                let mut list = Vec::try_with_capacity(x.len())?;
+
+                for dev in x.iter() {
+                    list.try_push(dev.raw_device())?;
+                }
+
+                let ptr = list.as_mut_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null_mut()),
+        };
+
+        let mut config = bindings::dev_pm_opp_config {
+            clk_names,
+            config_clks: if T::HAS_CONFIG_CLKS {
+                Some(Self::config_clks)
+            } else {
+                None
+            },
+            prop_name,
+            regulator_names,
+            config_regulators: if T::HAS_CONFIG_REGULATORS {
+                Some(Self::config_regulators)
+            } else {
+                None
+            },
+            genpd_names,
+            supported_hw,
+            supported_hw_count,
+
+            // Don't need to support virt_devs for now.
+            virt_devs: ptr::null_mut(),
+            required_devs,
+        };
+
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. The OPP core guarantees to not use fields of `config`, after this call has
+        // returned and so we don't need to save a copy of them for future use
+        let ret = unsafe { bindings::dev_pm_opp_set_config(dev.raw_device(), &mut config) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            self.token = Some(ret);
+            Ok(())
+        }
+    }
+
+    // Config's config_clks callback.
+    extern "C" fn config_clks(
+        dev: *mut bindings::device,
+        opp_table: *mut bindings::opp_table,
+        opp: *mut bindings::dev_pm_opp,
+        _data: *mut core::ffi::c_void,
+        scaling_down: bool,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::new(dev) };
+            T::config_clks(
+                &dev,
+                // SAFETY: 'opp_table' is guaranteed by the C code to be valid.
+                &unsafe { Table::from_ptr(opp_table, dev.clone()) },
+                // SAFETY: 'opp' is guaranteed by the C code to be valid.
+                &unsafe { OPP::new(opp) },
+                scaling_down,
+            )
+            .map(|_| 0)
+        })
+    }
+
+    // Config's config_regulators callback.
+    extern "C" fn config_regulators(
+        dev: *mut bindings::device,
+        old_opp: *mut bindings::dev_pm_opp,
+        new_opp: *mut bindings::dev_pm_opp,
+        regulators: *mut *mut bindings::regulator,
+        count: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::new(dev) };
+            T::config_regulators(
+                &dev,
+                // SAFETY: 'old_opp' is guaranteed by the C code to be valid.
+                &unsafe { OPP::new(old_opp) },
+                // SAFETY: 'new_opp' is guaranteed by the C code to be valid.
+                &unsafe { OPP::new(new_opp) },
+                regulators,
+                count,
+            )
+            .map(|_| 0)
+        })
+    }
+}
+
+impl<T: ConfigOps> Drop for Config<T> {
+    fn drop(&mut self) {
+        if let Some(token) = self.token.take() {
+            // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+            // to relinquish it now.
+            unsafe { bindings::dev_pm_opp_clear_config(token) };
+        }
+    }
+}
+
+/// CPU Frequency table created from OPP entries.
+pub struct FreqTable {
+    dev: Device,
+    table: cpufreq::Table,
+}
+
+impl FreqTable {
+    /// Creates new instance of [`FreqTable`] from raw pointer.
+    fn new(table: &Table) -> Result<Self> {
+        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_init_cpufreq_table(table.dev.raw_device(), &mut ptr)
+        })?;
+        Ok(Self {
+            dev: table.dev.clone(),
+            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+            table: unsafe { cpufreq::Table::from_raw(ptr) },
+        })
+    }
+
+    /// Returns reference to the underlying [`cpufreq::Table`].
+    pub fn table(&self) -> &cpufreq::Table {
+        &self.table
+    }
+}
+
+impl Deref for FreqTable {
+    type Target = cpufreq::Table;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.table
+    }
+}
+
+impl Drop for FreqTable {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe {
+            bindings::dev_pm_opp_free_cpufreq_table(self.dev.raw_device(), &mut self.as_ptr())
+        };
+    }
+}
+
+/// Operating performance point (OPP) table.
+///
+/// # Invariants
+///
+/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
+/// `self`, and will be decremented when `self` is dropped.
+pub struct Table {
+    ptr: *mut bindings::opp_table,
+    dev: Device,
+    em: bool,
+    of: bool,
+    cpumask: Option<cpufreq::Cpumask>,
+}
+
+// SAFETY: The fields of `Table` are safe to be used from any thread.
+unsafe impl Send for Table {}
+
+// SAFETY: The fields of `Table` are safe to be referenced from any thread.
+unsafe impl Sync for Table {}
+
+impl Table {
+    /// Creates a new OPP table instance from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    unsafe fn from_ptr(ptr: *mut bindings::opp_table, dev: Device) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcount will be incremented.
+        unsafe { bindings::dev_pm_opp_get_opp_table_ref(ptr) };
+
+        Self {
+            ptr,
+            dev,
+            em: false,
+            of: false,
+            cpumask: None,
+        }
+    }
+
+    /// Find OPP table from device.
+    pub fn from_dev(dev: &Device) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. Refcount of the OPP table is incremented as well.
+        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.raw_device()) })?;
+
+        Ok(Self {
+            ptr,
+            dev: dev.clone(),
+            em: false,
+            of: false,
+            cpumask: None,
+        })
+    }
+
+    /// Add device tree based OPP table for the device.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of(dev: &Device, index: i32) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. Refcount of the OPP table is incremented as well.
+        to_result(unsafe { bindings::dev_pm_opp_of_add_table_indexed(dev.raw_device(), index) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        table.of = true;
+
+        Ok(table)
+    }
+
+    // Remove device tree based OPP table for the device.
+    #[cfg(CONFIG_OF)]
+    fn remove_of(&self) {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. We took the reference from `from_of` earlier, it is safe to drop the same
+        // now.
+        unsafe { bindings::dev_pm_opp_of_remove_table(self.dev.raw_device()) };
+    }
+
+    /// Add device tree based OPP table for CPU devices.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of_cpumask(dev: &Device, cpumask: &mut cpufreq::Cpumask) -> Result<Self> {
+        // SAFETY: The cpumask is valid and the returned ptr will be owned by the [`Table`] instance.
+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_ptr()) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        // SAFETY: The `cpumask` is guaranteed by the C code to be valid.
+        table.cpumask = Some(unsafe { cpufreq::Cpumask::new(cpumask.as_mut_ptr()) });
+
+        Ok(table)
+    }
+
+    // Remove device tree based OPP table for CPU devices.
+    #[cfg(CONFIG_OF)]
+    fn remove_of_cpumask(&self, cpumask: &cpufreq::Cpumask) {
+        // SAFETY: The cpumask is valid and we took the reference from `from_of_cpumask` earlier,
+        // it is safe to drop the same now.
+        unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_ptr()) };
+    }
+
+    /// Returns the number of OPPs in the table.
+    pub fn opp_count(&self) -> Result<u32> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.raw_device()) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u32)
+        }
+    }
+
+    /// Returns max clock latency of the OPPs in the table.
+    pub fn max_clock_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_clock_latency(self.dev.raw_device()) }
+    }
+
+    /// Returns max volt latency of the OPPs in the table.
+    pub fn max_volt_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_volt_latency(self.dev.raw_device()) }
+    }
+
+    /// Returns max transition latency of the OPPs in the table.
+    pub fn max_transition_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_transition_latency(self.dev.raw_device()) }
+    }
+
+    /// Returns the suspend OPP.
+    pub fn suspend_freq(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_suspend_opp_freq(self.dev.raw_device()) }
+    }
+
+    /// Synchronizes regulators used by the OPP table.
+    pub fn sync_regulators(&self) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_sync_regulators(self.dev.raw_device()) })
+    }
+
+    /// Gets sharing CPUs.
+    pub fn sharing_cpus(dev: &Device, cpumask: &mut cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_get_sharing_cpus(dev.raw_device(), cpumask.as_mut_ptr())
+        })
+    }
+
+    /// Sets sharing CPUs.
+    pub fn set_sharing_cpus(&self, cpumask: &cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.raw_device(), cpumask.as_ptr())
+        })
+    }
+
+    /// Gets sharing CPUs from Device tree.
+    #[cfg(CONFIG_OF)]
+    pub fn of_sharing_cpus(dev: &Device, cpumask: &mut cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_get_sharing_cpus(dev.raw_device(), cpumask.as_mut_ptr())
+        })
+    }
+
+    /// Updates the voltage value for an OPP.
+    pub fn adjust_voltage(
+        &self,
+        freq: u64,
+        u_volt: u64,
+        u_volt_min: u64,
+        u_volt_max: u64,
+    ) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_adjust_voltage(
+                self.dev.raw_device(),
+                freq,
+                u_volt,
+                u_volt_min,
+                u_volt_max,
+            )
+        })
+    }
+
+    /// Create cpufreq table from OPP table.
+    pub fn to_cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
+    /// Sets a matching OPP based on frequency.
+    pub fn set_rate(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_rate(self.dev.raw_device(), freq) })
+    }
+
+    /// Sets exact OPP.
+    pub fn set_opp(&self, opp: &OPP) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.raw_device(), opp.as_mut_ptr()) })
+    }
+
+    /// Finds OPP based on frequency.
+    pub fn opp_from_freq(
+        &self,
+        mut freq: u64,
+        available: Option<bool>,
+        index: Option<u32>,
+        stype: SearchType,
+    ) -> Result<OPP> {
+        let rdev = self.dev.raw_device();
+        let index = index.unwrap_or(0);
+
+        let ptr = from_err_ptr(match stype {
+            SearchType::Exact => {
+                if let Some(available) = available {
+                    // SAFETY: The requirements are satisfied by the existence of `RawDevice` and
+                    // its safety requirements. The returned ptr will be owned by the new [`OPP`]
+                    // instance.
+                    unsafe {
+                        bindings::dev_pm_opp_find_freq_exact_indexed(rdev, freq, index, available)
+                    }
+                } else {
+                    return Err(EINVAL);
+                }
+            }
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_freq_ceil_indexed(rdev, &mut freq as *mut u64, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_freq_floor_indexed(rdev, &mut freq as *mut u64, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        Ok(unsafe { OPP::new_owned(ptr) })
+    }
+
+    /// Finds OPP based on level.
+    pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<OPP> {
+        let rdev = self.dev.raw_device();
+
+        let ptr = from_err_ptr(match stype {
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Exact => unsafe { bindings::dev_pm_opp_find_level_exact(rdev, level) },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_level_ceil(rdev, &mut level as *mut u32)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_level_floor(rdev, &mut level as *mut u32)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        Ok(unsafe { OPP::new_owned(ptr) })
+    }
+
+    /// Finds OPP based on bandwidth.
+    pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<OPP> {
+        let rdev = self.dev.raw_device();
+
+        let ptr = from_err_ptr(match stype {
+            // The OPP core doesn't support this yet.
+            SearchType::Exact => return Err(EINVAL),
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_bw_ceil(rdev, &mut bw as *mut u32, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_bw_floor(rdev, &mut bw as *mut u32, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        Ok(unsafe { OPP::new_owned(ptr) })
+    }
+
+    /// Enable the OPP.
+    pub fn enable_opp(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.raw_device(), freq) })
+    }
+
+    /// Disable the OPP.
+    pub fn disable_opp(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_disable(self.dev.raw_device(), freq) })
+    }
+
+    /// Registers with Energy model.
+    #[cfg(CONFIG_OF)]
+    pub fn of_register_em(&mut self, cpumask: &mut cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_register_em(self.dev.raw_device(), cpumask.as_mut_ptr())
+        })?;
+
+        self.em = true;
+        Ok(())
+    }
+
+    // Unregisters with Energy model.
+    #[cfg(CONFIG_OF)]
+    fn of_unregister_em(&self) {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. We registered with the EM framework earlier, it is safe to unregister now.
+        unsafe { bindings::em_dev_unregister_perf_domain(self.dev.raw_device()) };
+    }
+}
+
+impl Drop for Table {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_put_opp_table(self.ptr) };
+
+        #[cfg(CONFIG_OF)]
+        {
+            if self.em {
+                self.of_unregister_em();
+            }
+
+            if self.of {
+                self.remove_of();
+            } else if let Some(cpumask) = &self.cpumask {
+                self.remove_of_cpumask(cpumask);
+            }
+        }
+    }
+}
+
+/// Operating performance point (OPP).
+///
+/// # Invariants
+///
+/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
+/// `self`, and will be decremented when `self` is dropped.
+#[repr(transparent)]
+pub struct OPP(*mut bindings::dev_pm_opp);
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
+unsafe impl Send for OPP {}
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
+// thread.
+unsafe impl Sync for OPP {}
+
+impl OPP {
+    /// Creates a new OPP instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    unsafe fn new(ptr: *mut bindings::dev_pm_opp) -> Self {
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { bindings::dev_pm_opp_get(ptr) };
+        Self(ptr)
+    }
+
+    /// Creates a new owned OPP instance.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid, and non-null.
+    unsafe fn new_owned(ptr: *mut bindings::dev_pm_opp) -> Self {
+        Self(ptr)
+    }
+
+    fn as_mut_ptr(&self) -> *mut bindings::dev_pm_opp {
+        self.0
+    }
+
+    /// Adds an OPP dynamically.
+    pub fn add(dev: &Device, mut data: Data) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.raw_device(), &mut data.0) })
+    }
+
+    /// Removes a dynamically added OPP.
+    pub fn remove(dev: &Device, freq: u64) {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_remove(dev.raw_device(), freq) };
+    }
+
+    /// Returns the frequency of an OPP.
+    pub fn freq(&self, index: Option<u32>) -> u64 {
+        let index = index.unwrap_or(0);
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_freq_indexed(self.0, index) }
+    }
+
+    /// Returns the voltage of an OPP.
+    pub fn voltage(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_voltage(self.0) }
+    }
+
+    /// Returns the level of an OPP.
+    pub fn level(&self) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_level(self.0) }
+    }
+
+    /// Returns the power of an OPP.
+    pub fn power(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_power(self.0) }
+    }
+
+    /// Returns the required pstate of an OPP.
+    pub fn required_pstate(&self, index: u32) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_required_pstate(self.0, index) }
+    }
+
+    /// Returns true if the OPP is turbo.
+    pub fn is_turbo(&self) -> bool {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_is_turbo(self.0) }
+    }
+}
+
+impl Drop for OPP {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe { bindings::dev_pm_opp_put(self.0) };
+    }
+}
-- 
2.31.1.272.g89b43f80a514


