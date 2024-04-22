Return-Path: <linux-kernel+bounces-153970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469648AD572
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4270B23ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83370156F23;
	Mon, 22 Apr 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gqYtkVZW"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C489156C64
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815968; cv=none; b=dXRBp5/kUaJtFyafKc4eKn4t0JduGNa8SniTwLRtXhnA4xdKObn5UQRwCA0nnPhqMXxyHrmRFhW0dpPZlYZpic+dhyeRsY7mMxq3ByaJGqOjFY+Sw5h+MgX3XEftDKMDi79kxu0vKs8KWVCpqh6P9yURVRfrw4s1dJzF8R3tJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815968; c=relaxed/simple;
	bh=q5dgckPWStwDbs/ciTx+/6dkgSSrmHIxfJYYBbAO7qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiEiQ5eQ5Luo9oEBfPoyPxRqcVT2Zhekhzs0QUwnpfbyKF/E9IYrwmG9qxVGrIrAvIZKj5nVrkRY2zY7m42vHU8HaY1c6iupafM/ClpPNRJznC+Owh+TxNwr/ve0NDdC9JYXBQj9OxwqodJE//jiOUt9SN3kujM6t0oeXa8VYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gqYtkVZW; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713815965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=az+1RlpkpwvbFiQL8Y2JcSKU17oJBB1RPjU9RUMsFTI=;
	b=gqYtkVZWHVY3rUzWbcfnY5HaBZSffbPwuoIF8xPuls5Fo7ZVpdEvwNV4Trl2PCzP0rhqye
	Cavg7IKrCVjLtTsTJ9rDM3mhv0XSFNy4oQR/fN5dOgfUPZoZvRbHOVioF598noEWDBx4OT
	bDGJKE7nd5IASxTW55JpIkG0QrltLLg=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Subject: [PATCH 7/7] [RFT] arm64: zynqmp: Add PCIe phys
Date: Mon, 22 Apr 2024 15:59:04 -0400
Message-Id: <20240422195904.3591683-8-sean.anderson@linux.dev>
In-Reply-To: <20240422195904.3591683-1-sean.anderson@linux.dev>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add PCIe phy bindings for the ZCU102.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
I don't have a ZCU102, so please test this.

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index ad8f23a0ec67..68fe53685351 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -941,6 +941,8 @@ conf-pull-none {
 
 &pcie {
 	status = "okay";
+	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
+	phy-names = "pcie-phy0";
 };
 
 &psgtr {
-- 
2.35.1.1320.gc452695387.dirty


