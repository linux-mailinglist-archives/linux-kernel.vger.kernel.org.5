Return-Path: <linux-kernel+bounces-135985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F096489CE91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5A71F2373F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAE71448DD;
	Mon,  8 Apr 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I2ejRLU1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517E26ACE;
	Mon,  8 Apr 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616674; cv=none; b=U0FXxBgaI1IniWybwKSJpeIKJgoZPV4aOikSAmdu77bkoKmiTU6WwMZK8nnbelWUh6UCwuJNQhGr0aBafQw1fvmrbGGd7dk0OdvvYdFoQXAg0tn/qupBPLSc6Va721FLTV6fJiQeIfFjyKt/KrUYvJ0YoXPTS8vRR//b0fmdz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616674; c=relaxed/simple;
	bh=T9MvklJg6UVFRQrF868mATr8p8Rs4R1YsfG32amYaZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDk+lgyRfGXfKLUgRQ0ynIjO+jwT8u48qhA9SNC+1AhsPfDhdBwbk+GB+RSdnznndvEJO+QPI1xLTfHdbLg9yMMA4HDcE2LuGFMhiSYSv+uou9S/F7u0Ug/JbWE4FsJNo+Ts+oIFgV7FHvCP0x87MQb19nm6Dx8X9ndWWqXYQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I2ejRLU1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712616671;
	bh=T9MvklJg6UVFRQrF868mATr8p8Rs4R1YsfG32amYaZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2ejRLU13wcmnddPrg5UBm+VBx9/zQOCXH4x1NIlyiNcYvdYPpizilQvr4ETSqs4j
	 3Zh13fJk84Kgms4ZDi4pJPWfrftmYJzp4Us04EVD6oF3nQ+98eP7/0IBRzjtZTBZXb
	 PEmjWYTcVLfE8SMYod7VZeHbFkMc7efou2L/lg+Vkx7dKlcheGzAIshICUk4FECK/Y
	 QgyyqMKPJ0WweIK6l/Z/+erE/nzdryscesam+s2h17Z+IdItAinFKQiOt3RzpNbf2L
	 8v5B040uj+0ni1cihUidQaWEp11NjL392mMKOHVqy3VIlLyIV+mp44Q9tvFzEUzHzV
	 6wu8PSEkxGzSQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C03F137820CD;
	Mon,  8 Apr 2024 22:51:10 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 41AC84800D1; Tue,  9 Apr 2024 00:51:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v5 04/10] arm64: dts: rockchip: fix usb2phy nodename for rk3588
Date: Tue,  9 Apr 2024 00:50:31 +0200
Message-ID: <20240408225109.128953-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408225109.128953-1-sebastian.reichel@collabora.com>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb2-phy should be named usb2phy according to the DT binding,
so let's fix it up accordingly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 87b83c87bd55..5ed0d8c95427 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -543,7 +543,7 @@ usb2phy2_grf: syscon@fd5d8000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy2: usb2-phy@8000 {
+		u2phy2: usb2phy@8000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0x8000 0x10>;
 			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -568,7 +568,7 @@ usb2phy3_grf: syscon@fd5dc000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy3: usb2-phy@c000 {
+		u2phy3: usb2phy@c000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0xc000 0x10>;
 			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.43.0


