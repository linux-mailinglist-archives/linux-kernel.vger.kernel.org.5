Return-Path: <linux-kernel+bounces-48664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7171845F87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BFD29AF13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FDD12E1EE;
	Thu,  1 Feb 2024 18:07:21 +0000 (UTC)
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD912D162;
	Thu,  1 Feb 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.193.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810840; cv=none; b=pkILYfYFNi0HBtzkjay0rnbJ49sWc9EiexE1DD7dIAD1mP6LVy2qKllt2t8B6LPWYikpQuwaBc85tJhBlokfX7Qy6cBwjVWFNzU4jhf9x/3WEOhZovTcs3va2vn91zNqiaH+8Z+6YzTtT05+qR19H6ANVQ9rOlHcprWgbWbGAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810840; c=relaxed/simple;
	bh=lj9jzLLyVHFhew0Zi2auFkzyMGCjvKyZGt3bltSvs9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4VGjZ2pnk5iCCMCGeMU/0p8uDuMlUNDG+fSbj1/PQD184tSW0/7JrDGfNpzKZ5e6So9D27to0iNNLujv5e8d4y/29D/G7ZW3YPjsOJ6qLgouAXGOQh+Yqpz6hMXcA02pCG4k7IwLSi+e7Bm/y0QZ3M6EUsPGDPraGB1X2T1pJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de; spf=pass smtp.mailfrom=christina-quast.de; arc=none smtp.client-ip=116.202.193.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christina-quast.de
Received: from localhost (unknown [195.162.191.218])
	by mail.someserver.de (Postfix) with ESMTPSA id 8B6DAA2250;
	Thu,  1 Feb 2024 19:07:15 +0100 (CET)
From: Christina Quast <contact@christina-quast.de>
Date: Thu, 01 Feb 2024 19:06:59 +0100
Subject: [PATCH v2 2/3] rust: phy: add some phy_driver and genphy_
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-rockchip-rust-phy_depend-v2-2-c5fa4faab924@christina-quast.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706810819; l=2422;
 i=contact@christina-quast.de; s=20240130; h=from:subject:message-id;
 bh=lj9jzLLyVHFhew0Zi2auFkzyMGCjvKyZGt3bltSvs9k=;
 b=aBY8aB9sq9C6dAXsUFZ7GKm0DaKOL3Rg4HPRhXog0o3VGGiSAUmMpGA4nPU0r6SNJlN/kCQ8Q
 6lt+pqrQgCmB3oQRdIWJxLCdbPCslYHVrYtUjsrYQoPoH+xjpDn+Imd
X-Developer-Key: i=contact@christina-quast.de; a=ed25519;
 pk=aoQfinjbnr265vCkIZdYteLDcmIqLBhY1m74WfFUU9E=

Those functions are need for the rockchip_rust.rs implementation.

Added functions:
genphy_config_aneg
config_init

Getter functions for mdix and speed.

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
 rust/kernel/net/phy.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index e457b3c7cb2f..373a4d358e9f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -95,6 +95,22 @@ pub fn phy_id(&self) -> u32 {
         unsafe { (*phydev).phy_id }
     }
 
+    /// Gets the current crossover of the PHY.
+    pub fn mdix(&self) -> u8 {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { (*phydev).mdix }
+    }
+
+    /// Gets the speed of the PHY.
+    pub fn speed(&mut self) -> u32 {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that we may access
+        // this field without additional synchronization.
+        unsafe { (*phydev).speed as u32 }
+    }
+
     /// Gets the state of PHY state machine states.
     pub fn state(&self) -> DeviceState {
         let phydev = self.0.get();
@@ -300,6 +316,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
         // So it's just an FFI call.
         to_result(unsafe { bindings::genphy_read_abilities(phydev) })
     }
+
+    /// Writes BMCR
+    pub fn genphy_config_aneg(&mut self) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        // second param = false => autoneg not requested
+        to_result(unsafe { bindings::__genphy_config_aneg(phydev, false) })
+    }
 }
 
 /// Defines certain other features this PHY supports (like interrupts).
@@ -583,6 +608,12 @@ fn soft_reset(_dev: &mut Device) -> Result {
         Err(code::ENOTSUPP)
     }
 
+    /// Called to initialize the PHY,
+    /// including after a reset
+    fn config_init(_dev: &mut Device) -> Result {
+        Err(code::ENOTSUPP)
+    }
+
     /// Probes the hardware to determine what abilities it has.
     fn get_features(_dev: &mut Device) -> Result {
         Err(code::ENOTSUPP)

-- 
2.43.0


