Return-Path: <linux-kernel+bounces-63901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58388853639
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1AA1C232FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B960272;
	Tue, 13 Feb 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WnFS03xL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E485FDBD;
	Tue, 13 Feb 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842178; cv=none; b=QnC7xZ2gGPb5ds+1GTaup2ruMLCVWTpWSFOFt7aHvy88dX1NW+xoRtAuCZsuF5j39d7qEi4R9J6c9RyJ2VadFaLhkvO6aeMNHqj9uXW9woHiOmjdaxliTtv8/ymuOPpNUAXaVZyBsLbepsUXJ2Szo1l82SWfwirWelUvPiVHWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842178; c=relaxed/simple;
	bh=N8XGqG6EO77dbuaFhDjXtSm+LE8VQGaOvq4GwvbAt0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hm0yxc22C/VdqeYvdoTHXw02udK3sPExONm9vAh9Vulp4ki0KGnRUKzsc5LJVw0prUMCDB4Uy1t2sTVwbu8tMSXIrM3E+tktVWjnAfL4q1/BfuML9PFQ564rMP89XgU6yoc5dBELmM113etv7mm/Wt+Z3caD6i2+jcRfpHJCWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WnFS03xL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842172;
	bh=N8XGqG6EO77dbuaFhDjXtSm+LE8VQGaOvq4GwvbAt0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnFS03xLIK3rqImjfP2peI+x3omVK9bf7sCs5rP/oVyf2QtgMVFAW6wic1tGyqsrO
	 M6Vzqq0/6Dtl228KlpVPb4HEh3Poo9ZrSV97lfu8s6aJb/aMkzoCVekNp16PZu5MLE
	 w90lvkGpkf2ok4WritcNnTwDkilQn4zYadon5JJu4krGMQ5fYZ9YwIVbVcJoTCXIXV
	 lY7Hj9f4VWrA4kkVCpQPj46MAumLIX+m3lCnHKsikxzBNYLKEs+63Q7YTszNT3pbPa
	 o+joqvrFjAKDli7lh9uSsjBHqxfWbl7cw0dRJ54LmMkJgAV2YKGG0v0bBTt5YNWJvA
	 v0xTdSYs3oCIQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD3543782077;
	Tue, 13 Feb 2024 16:36:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 052084800D4; Tue, 13 Feb 2024 17:36:11 +0100 (CET)
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
Subject: [PATCH v2 06/12] arm64: dts: rockchip: Fix usb2phy nodename for rk3588
Date: Tue, 13 Feb 2024 17:32:40 +0100
Message-ID: <20240213163609.44930-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213163609.44930-1-sebastian.reichel@collabora.com>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
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
index 36b1b7acfe6a..38e075b7b661 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -542,7 +542,7 @@ usb2phy2_grf: syscon@fd5d8000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy2: usb2-phy@8000 {
+		u2phy2: usb2phy@8000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0x8000 0x10>;
 			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -567,7 +567,7 @@ usb2phy3_grf: syscon@fd5dc000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy3: usb2-phy@c000 {
+		u2phy3: usb2phy@c000 {
 			compatible = "rockchip,rk3588-usb2phy";
 			reg = <0xc000 0x10>;
 			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.43.0


