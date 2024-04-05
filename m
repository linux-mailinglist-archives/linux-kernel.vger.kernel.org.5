Return-Path: <linux-kernel+bounces-132894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B166C899BA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667EC28532E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22CF16C6B7;
	Fri,  5 Apr 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fh8wBnw7"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387C16C691
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315406; cv=none; b=JHDI62O/VkmCevmAsi/azB4jeTwZCShHxkA9K64qCcpt11S8+7iWTZFvv9l9cttVkz5aaSPqC3qO2coCjF1bK+8fE/bCRWkr70Oms6dMbUeAXyPyT+Ny/WRLFW0llW2V1if239H6sYDJvffT7VLXjW1x6L7+KNZlK7eEi0ZaA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315406; c=relaxed/simple;
	bh=oJ0Xk5ltsUzu+JZRjpvBKqDh2i8n3mVzm5U30u1RFic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kp8le0O6kEHqtB9/h4R+Cgzw2dOIICI48ymjIDpZefwc5WqGTqMRHnoPGkNO2roMKiPy0GPBj72IL7bqKbQfR4GnENq1bVHdHMyEGzQh0L5loOXAT2S/RwGt5zAWEbeuG8iMNPUH14FwojEhwfCluHssa7x1Cb6gqgQcqC+o+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fh8wBnw7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0d82d441bso18190935ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712315402; x=1712920202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys2+MgQ3wDlipfHVv7Q6NNeD/t7+Th7HLHKb6mu7BLE=;
        b=Fh8wBnw7hDzzYdD/s3mlOCL6n/BRvfJVfMWPPrvntKBZam9VS0SyPObxRCeg8xn/k0
         4B32wlfoHtZ/4Way/ADAbmBihWMS1cKxtxnulV05oADTwdZLwemdgRieYqOW4rWV/4UT
         5rm3IAtEMwVMZlwsij2zw9zvKepfj3W0baJItCV7hi0taFHsxEBMxGursmMdK3+SFMkR
         Inhv/QHtl5X0qewZ6OatQQglcag82IrDS8krwENPZL0hys6lBBHFOiPLmn6bl1ubZoer
         iHEVcVZ5xxAJHF68i0l/+I1+M5278kOJUTEV5SG8M3b2gMGpG6+zadJweGxjUIN+MmL+
         IUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712315402; x=1712920202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ys2+MgQ3wDlipfHVv7Q6NNeD/t7+Th7HLHKb6mu7BLE=;
        b=M6Q9d9WsXlJLIXcFxCeavdRtgCktuQTp/vvHzv0aJIuWhzSRyHdjXuFlKEwDDMdfoh
         ZYWlYw3wVlyApEuejyaV7lal8rU6pQGvIwws1mciozyU0IQaopHLOkDhGS6Rbql//Vm5
         429ZDpXSOeFQhc50lbRhkNi2ITWYd2X7lpD3bFL0tq/xFQoaKnPr/kM2bpsLE05Cyt4w
         ufTCl8jgPsRusd4GKGxohJEmD4jTFQ0n2oUOhIVS2Gc6Vx8I9rHtuCnMLObqYml61v5D
         UFGk5TGKgJHScLQkrciBAVT69WyPnLsUTltz1idY4v3ki9UBmIcO7gNFaQ13Yr6JSSwX
         1iMw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Zjr+/P3vSdSC0rovBLiMW4jiY7OabnFhbgg06D7YZ3D5DmwgO1VUZSoVISwlkHB8g0xBOoqred/atnSLe/uflU1u5BGpZPAjaaZK
X-Gm-Message-State: AOJu0YxyUF1GBamS1umF6R/PEzqOMHyioYcf6ngcdkefnRGU0Z4kUzCK
	hT4fSNF7KbEWCeIakZV8c2YLbT69QqBqqYlJobRmt0VGKrf1xAuZ1Lzk7cKPjx8=
X-Google-Smtp-Source: AGHT+IHY008fVlaXyLCmPu4dOH9eJ8BuR16MLkMWqRpMFG6rw8TwPA5CEyLsSKF/R0JagteMrv6iVg==
X-Received: by 2002:a17:902:d4c4:b0:1e2:1df1:5ac0 with SMTP id o4-20020a170902d4c400b001e21df15ac0mr1301311plg.9.1712315402338;
        Fri, 05 Apr 2024 04:10:02 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001dddf29b6e8sm1297065pll.299.2024.04.05.04.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 04:10:01 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] cpufreq: Add Rust based cpufreq-dt driver
Date: Fri,  5 Apr 2024 16:39:40 +0530
Message-Id: <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org>
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

This commit adds a Rust based cpufreq-dt driver, which covers most of
the functionality of the existing C based driver. Only a handful of
things are left, like fetching platform data from cpufreq-dt-platdev.c.

This is tested with the help of QEMU for now and switching of
frequencies work as expected.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig        |  12 ++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/rcpufreq_dt.rs | 264 +++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 94e55c40970a..eb9359bd3c5c 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,18 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_DT_RUST
+	tristate "Rust based Generic DT based cpufreq driver"
+	depends on HAVE_CLK && OF && RUST
+	select CPUFREQ_DT_PLATDEV
+	select PM_OPP
+	help
+	  This adds a Rust based generic DT based cpufreq driver for frequency
+	  management.  It supports both uniprocessor (UP) and symmetric
+	  multiprocessor (SMP) systems.
+
+	  If in doubt, say N.
+
 config CPUFREQ_DT_PLATDEV
 	tristate "Generic DT based cpufreq platdev driver"
 	depends on OF
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d141c71b016..4981d908b803 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_COMMON)		+= cpufreq_governor.o
 obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
+obj-$(CONFIG_CPUFREQ_DT_RUST)		+= rcpufreq_dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 
 # Traces
diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
new file mode 100644
index 000000000000..d29182eba75e
--- /dev/null
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust based implementation of the cpufreq-dt driver.
+
+use core::{format_args, ptr};
+
+use kernel::{
+    b_str, bindings, c_str, cpufreq, define_of_id_table,
+    device::{self, Device, RawDevice},
+    error::{code::*, to_result},
+    fmt,
+    macros::vtable,
+    module_platform_driver, of, opp, platform,
+    prelude::*,
+    str::CString,
+    sync::Arc,
+};
+
+// Finds exact supply name from the OF node.
+fn find_supply_name_exact(np: *mut bindings::device_node, name: &str) -> Option<CString> {
+    let sname = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
+
+    // SAFETY: The OF node is guaranteed by the C code to be valid.
+    let pp = unsafe { bindings::of_find_property(np, sname.as_ptr() as *mut _, ptr::null_mut()) };
+    if pp.is_null() {
+        None
+    } else {
+        CString::try_from_fmt(fmt!("{}", name)).ok()
+    }
+}
+
+// Finds supply name for the CPU from DT.
+fn find_supply_names(dev: &Device, cpu: u32) -> Option<Vec<CString>> {
+    // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+    // requirements. The OF node is guaranteed by the C code to be valid or NULL and
+    // `of_node_get()` handles both the cases safely.
+    let np = unsafe { bindings::of_node_get((*dev.raw_device()).of_node) };
+    if np.is_null() {
+        return None;
+    }
+
+    // Try "cpu0" for older DTs.
+    let mut name = if cpu == 0 {
+        find_supply_name_exact(np, "cpu0")
+    } else {
+        None
+    };
+
+    if name.is_none() {
+        name = find_supply_name_exact(np, "cpu");
+    }
+
+    // SAFETY: It is safe to drop reference to the OF node we just took.
+    unsafe { bindings::of_node_put(np) };
+
+    match name {
+        Some(name) => {
+            let mut list = Vec::try_with_capacity(1).ok()?;
+            list.try_push(name).ok()?;
+
+            // SAFETY: The slice is fully initialized now.
+            Some(list)
+        }
+
+        None => None,
+    }
+}
+
+// Represents the cpufreq dt device.
+struct CPUFreqDTDevice {
+    opp_table: opp::Table,
+    freq_table: opp::FreqTable,
+    #[allow(dead_code)]
+    config: Option<opp::Config<Self>>,
+    #[allow(dead_code)]
+    clk: cpufreq::Clk,
+}
+
+#[vtable]
+impl opp::ConfigOps for CPUFreqDTDevice {}
+
+#[vtable]
+impl cpufreq::DriverOps for CPUFreqDTDevice {
+    type PData = Arc<Self>;
+
+    fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
+        let cpu = policy.cpu();
+
+        // SAFETY: It is safe to call `get_cpu_device()` for any CPU.
+        let dev = unsafe { bindings::get_cpu_device(cpu) };
+        if dev.is_null() {
+            return Err(ENODEV);
+        }
+
+        // SAFETY: `dev` is valid, non-null, and has a non-zero reference count.
+        let dev = unsafe { Device::new(dev) };
+
+        policy.set_cpus(cpu);
+
+        let config = if let Some(names) = find_supply_names(&dev, cpu) {
+            let mut config = opp::Config::<Self>::new();
+            config.set_regulator_names(names)?;
+            config.set(&dev)?;
+            Some(config)
+        } else {
+            None
+        };
+
+        // Get OPP-sharing information from "operating-points-v2" bindings.
+        let fallback = match opp::Table::of_sharing_cpus(&dev, policy.cpus()) {
+            Ok(_) => false,
+            Err(e) => {
+                if e != ENOENT {
+                    return Err(e);
+                }
+
+                // "operating-points-v2" not supported. If the platform hasn't
+                // set sharing CPUs, fallback to all CPUs share the `Policy`
+                // for backward compatibility.
+                opp::Table::sharing_cpus(&dev, policy.cpus()).is_err()
+            }
+        };
+
+        // Initialize OPP tables for all policy cpus.
+        //
+        // For platforms not using "operating-points-v2" bindings, we do this
+        // before updating policy cpus. Otherwise, we will end up creating
+        // duplicate OPPs for the CPUs.
+        //
+        // OPPs might be populated at runtime, don't fail for error here unless
+        // it is -EPROBE_DEFER.
+        let mut opp_table = match opp::Table::from_of_cpumask(&dev, policy.cpus()) {
+            Ok(table) => table,
+            Err(e) => {
+                if e == EPROBE_DEFER {
+                    return Err(e);
+                }
+
+                // The table is added dynamically ?
+                opp::Table::from_dev(&dev)?
+            }
+        };
+
+        // The OPP table must be initialized, statically or dynamically, by this point.
+        opp_table.opp_count()?;
+
+        // Set sharing cpus for fallback scenario.
+        if fallback {
+            policy.set_all_cpus();
+            opp_table.set_sharing_cpus(policy.cpus())?;
+        }
+
+        let mut transition_latency = opp_table.max_transition_latency() as u32;
+        if transition_latency == 0 {
+            transition_latency = cpufreq::ETERNAL_LATENCY;
+        }
+
+        let freq_table = opp_table.to_cpufreq_table()?;
+        policy.set_freq_table(freq_table.table());
+        policy.set_dvfs_possible_from_any_cpu();
+        policy.set_suspend_freq((opp_table.suspend_freq() / 1000) as u32);
+        policy.set_transition_latency(transition_latency);
+        let clk = policy.set_clk(&dev, None)?;
+
+        Ok(Arc::try_new(CPUFreqDTDevice {
+            opp_table,
+            config,
+            freq_table,
+            clk,
+        })?)
+    }
+
+    fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result<()> {
+        Ok(())
+    }
+
+    fn online(_policy: &mut cpufreq::Policy) -> Result<()> {
+        // We did light-weight tear down earlier, nothing to do here.
+        Ok(())
+    }
+
+    fn offline(_policy: &mut cpufreq::Policy) -> Result<()> {
+        // Preserve policy->data and don't free resources on light-weight
+        // tear down.
+        Ok(())
+    }
+
+    fn suspend(policy: &mut cpufreq::Policy) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        to_result(unsafe { bindings::cpufreq_generic_suspend(policy.as_ptr()) })
+    }
+
+    fn verify(data: &mut cpufreq::PolicyData) -> Result<()> {
+        // SAFETY: By the type invariants, we know that `data` owns a reference received from the C
+        // code, so it is safe to use it now.
+        to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(data.as_ptr()) })
+    }
+
+    fn target_index(policy: &mut cpufreq::Policy, index: u32) -> Result<()> {
+        let data = match policy.data::<Self::PData>() {
+            Some(data) => data,
+            None => return Err(ENOENT),
+        };
+
+        let freq = data.freq_table.freq(index.try_into().unwrap())? as u64;
+        data.opp_table.set_rate(freq * 1000)
+    }
+
+    fn get(policy: &mut cpufreq::Policy) -> Result<u32> {
+        // SAFETY: It is safe to call `cpufreq_generic_get()` for policy's CPU.
+        Ok(unsafe { bindings::cpufreq_generic_get(policy.cpu()) })
+    }
+
+    fn set_boost(_policy: &mut cpufreq::Policy, _state: i32) -> Result<()> {
+        Ok(())
+    }
+
+    fn register_em(policy: &mut cpufreq::Policy) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it now.
+        unsafe { bindings::cpufreq_register_em_with_opp(policy.as_ptr()) };
+    }
+}
+
+type DeviceData = device::Data<cpufreq::Registration<CPUFreqDTDevice>, (), ()>;
+
+struct CPUFreqDTDriver;
+
+impl platform::Driver for CPUFreqDTDriver {
+    type Data = Arc<DeviceData>;
+
+    define_of_id_table! {(), [
+        (of::DeviceId::Compatible(b_str!("operating-points-v2")), None),
+    ]}
+
+    fn probe(_dev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Self::Data> {
+        let data = Arc::<DeviceData>::from(kernel::new_device_data!(
+            cpufreq::Registration::new(),
+            (),
+            (),
+            "CPUFreqDT::Registration"
+        )?);
+        let flags = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
+        let boost = true;
+
+        data.registrations()
+            .ok_or(ENXIO)?
+            .as_pinned_mut()
+            .register(c_str!("cpufreq-dt"), (), flags, boost)?;
+
+        pr_info!("CPUFreq DT driver registered\n");
+
+        Ok(data)
+    }
+}
+
+module_platform_driver! {
+    type: CPUFreqDTDriver,
+    name: "cpufreq_dt",
+    author: "Viresh Kumar <viresh.kumar@linaro.org>",
+    description: "Generic CPUFreq DT driver",
+    license: "GPL v2",
+}
-- 
2.31.1.272.g89b43f80a514


