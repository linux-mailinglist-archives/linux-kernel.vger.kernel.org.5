Return-Path: <linux-kernel+bounces-48665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C6845F8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941341F2315C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0EC12EBE9;
	Thu,  1 Feb 2024 18:07:22 +0000 (UTC)
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8512E1CC;
	Thu,  1 Feb 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.193.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810842; cv=none; b=SnqKSweXWaUWi2iiuuJfo1gn0qh1drJ799Y9Fiiur22RLC7LNamnrEzQYLCcZIM2e9gGzaONzmScH0rS0j/iIjcajmaLIvcRZDrZFTxNJlkKtx0qp51Uw0huATIU6OAqbrdiIWwYYgVY4oPS0oR6pQm5bdOo74w697/rTtuIRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810842; c=relaxed/simple;
	bh=TIHsrpiXhvakc3QpotZKPzxEDzOuO24UX7NpNCsypps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ny9nyHI3Ou9wgX9nys79M/sOep77TZ2j9nCOlS1oLotC70thNXlp1togM6kc58pkEKa2Cdu5leWQh+BX61qzB0L42WqOrRreYnA2T8bZkzqPGQk5Qn2vE2k0BiS/SGngyYUEkl7K2qOIFeYHxRShXFZ4jWSY/hgWyqCY5qmsSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de; spf=pass smtp.mailfrom=christina-quast.de; arc=none smtp.client-ip=116.202.193.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christina-quast.de
Received: from localhost (unknown [195.162.191.218])
	by mail.someserver.de (Postfix) with ESMTPSA id F41BCA2267;
	Thu,  1 Feb 2024 19:07:17 +0100 (CET)
From: Christina Quast <contact@christina-quast.de>
Date: Thu, 01 Feb 2024 19:07:00 +0100
Subject: [PATCH v2 3/3] net: phy: add Rust Rockchip PHY driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
In-Reply-To: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Christina Quast <contact@christina-quast.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706810819; l=6330;
 i=contact@christina-quast.de; s=20240130; h=from:subject:message-id;
 bh=TIHsrpiXhvakc3QpotZKPzxEDzOuO24UX7NpNCsypps=;
 b=8X+Cl8CgP8FACgRIhTspxgnky8uPVFD6oK9+YPkEb03a9uYnKVWs2Fjil6lGl/w6frseON75r
 cp6NdHHykN+DubHZ8prPcfHHGD5OQHP108x7AX4hJtENdpJQ/MTXYUM
X-Developer-Key: i=contact@christina-quast.de; a=ed25519;
 pk=aoQfinjbnr265vCkIZdYteLDcmIqLBhY1m74WfFUU9E=

This is the Rust implementation of drivers/net/phy/rockchip.c. The
features are equivalent. You can choose C or Rust version kernel
configuration.

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
 drivers/net/phy/Kconfig          |   8 +++
 drivers/net/phy/Makefile         |   4 ++
 drivers/net/phy/rockchip_rust.rs | 131 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 9e2672800f0b..8b73edb7e836 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -362,6 +362,14 @@ config ROCKCHIP_PHY
 	help
 	  Currently supports the integrated Ethernet PHY.
 
+config ROCKCHIP_RUST_PHY
+	bool "Rust driver for Rockchip Ethernet PHYs"
+	depends on RUST_PHYLIB_ABSTRACTIONS && ROCKCHIP_PHY
+	help
+	  Uses the Rust reference driver for Rockchip PHYs (rockchip_rust.ko).
+	  The features are equivalent. It supports the integrated Ethernet PHY.
+
+
 config SMSC_PHY
 	tristate "SMSC PHYs"
 	select CRC16
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 6097afd44392..045d2913bf2e 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -94,7 +94,11 @@ obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
 obj-$(CONFIG_RENESAS_PHY)	+= uPD60620.o
+ifdef CONFIG_ROCKCHIP_RUST_PHY
+obj-$(CONFIG_ROCKCHIP_PHY)	+= rockchip_rust.o
+else
 obj-$(CONFIG_ROCKCHIP_PHY)	+= rockchip.o
+endif
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
diff --git a/drivers/net/phy/rockchip_rust.rs b/drivers/net/phy/rockchip_rust.rs
new file mode 100644
index 000000000000..17a1f94da8c1
--- /dev/null
+++ b/drivers/net/phy/rockchip_rust.rs
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Christina Quast <contact@christina-quast.de>
+
+//! Rust Rockchip PHY driver
+//!
+//! C version of this driver: [`drivers/net/phy/rockchip.c`](./rockchip.c)
+use kernel::{
+    c_str,
+    net::phy::{self, DeviceId, Driver},
+    prelude::*,
+    uapi,
+};
+
+kernel::module_phy_driver! {
+    drivers: [PhyRockchip],
+    device_table: [
+        DeviceId::new_with_driver::<PhyRockchip>(),
+    ],
+    name: "rust_asix_phy",
+    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
+    description: "Rust Asix PHYs driver",
+    license: "GPL",
+}
+
+
+const MII_INTERNAL_CTRL_STATUS: u16 = 17;
+const SMI_ADDR_TSTCNTL: u16 = 20;
+const SMI_ADDR_TSTWRITE: u16 = 23;
+
+const MII_AUTO_MDIX_EN: u16 = bit(7);
+const MII_MDIX_EN: u16 = bit(6);
+
+const TSTCNTL_WR: u16 = bit(14) | bit(10);
+
+const TSTMODE_ENABLE: u16 = 0x400;
+const TSTMODE_DISABLE: u16 = 0x0;
+
+const WR_ADDR_A7CFG: u16 = 0x18;
+
+struct PhyRockchip;
+
+impl PhyRockchip {
+   /// Helper function for helper_integrated_phy_analog_init
+    fn helper_init_tstmode(dev: &mut phy::Device) -> Result {
+        // Enable access to Analog and DSP register banks
+        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_ENABLE)?;
+        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_DISABLE)?;
+        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_ENABLE)
+    }
+
+    /// Helper function for helper_integrated_phy_analog_init
+    fn helper_close_tstmode(dev: &mut phy::Device) -> Result {
+        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_DISABLE)
+    }
+
+    /// Helper function for rockchip_config_init
+    fn helper_integrated_phy_analog_init(dev: &mut phy::Device) -> Result {
+        Self::helper_init_tstmode(dev)?;
+        dev.write(SMI_ADDR_TSTWRITE, 0xB)?;
+        dev.write(SMI_ADDR_TSTCNTL, TSTCNTL_WR | WR_ADDR_A7CFG)?;
+        Self::helper_close_tstmode(dev)
+    }
+
+    /// Helper function for config_init
+    fn helper_config_init(dev: &mut phy::Device) -> Result {
+        let val = !MII_AUTO_MDIX_EN & dev.read(MII_INTERNAL_CTRL_STATUS)?;
+        dev.write(MII_INTERNAL_CTRL_STATUS, val)?;
+        Self::helper_integrated_phy_analog_init(dev)
+    }
+
+    fn helper_set_polarity(dev: &mut phy::Device, polarity: u8) -> Result {
+        let reg = !MII_AUTO_MDIX_EN & dev.read(MII_INTERNAL_CTRL_STATUS)?;
+        let val = match polarity as u32 {
+            // status: MDI; control: force MDI
+            uapi::ETH_TP_MDI => Some(reg & !MII_MDIX_EN),
+            // status: MDI-X; control: force MDI-X
+            uapi::ETH_TP_MDI_X => Some(reg | MII_MDIX_EN),
+            // uapi::ETH_TP_MDI_AUTO => control: auto-select
+            // uapi::ETH_TP_MDI_INVALID => status: unknown; control: unsupported
+            _ => None,
+        };
+        if let Some(v) = val {
+            if v != reg {
+                return dev.write(MII_INTERNAL_CTRL_STATUS, v);
+            }
+        }
+        Ok(())
+
+    }
+}
+
+#[vtable]
+impl Driver for PhyRockchip {
+    const FLAGS: u32 = 0;
+    const NAME: &'static CStr = c_str!("Rockchip integrated EPHY");
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_custom_mask(0x1234d400, 0xfffffff0);
+
+    fn link_change_notify(dev: &mut phy::Device) {
+    // If mode switch happens from 10BT to 100BT, all DSP/AFE
+    // registers are set to default values. So any AFE/DSP
+    // registers have to be re-initialized in this case.
+        if dev.state() == phy::DeviceState::Running && dev.speed() == uapi::SPEED_100 {
+            if let Err(e) = Self::helper_integrated_phy_analog_init(dev) {
+                pr_err!("rockchip: integrated_phy_analog_init err: {:?}", e);
+            }
+        }
+    }
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        dev.genphy_soft_reset()
+    }
+
+    fn config_init(dev: &mut phy::Device) -> Result {
+        PhyRockchip::helper_config_init(dev)
+    }
+
+    fn config_aneg(dev: &mut phy::Device) -> Result {
+        PhyRockchip::helper_set_polarity(dev, dev.mdix())?;
+        dev.genphy_config_aneg()
+    }
+
+    fn suspend(dev: &mut phy::Device) -> Result {
+        dev.genphy_suspend()
+    }
+
+    fn resume(dev: &mut phy::Device) -> Result {
+        let _ = dev.genphy_resume();
+
+        PhyRockchip::helper_config_init(dev)
+    }
+}

-- 
2.43.0


