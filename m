Return-Path: <linux-kernel+bounces-29354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557A8830D31
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078611F25460
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE04249E5;
	Wed, 17 Jan 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pgJgK4b/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92DA24208;
	Wed, 17 Jan 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518963; cv=none; b=LKZbiHXO3fyUx6JhCLyHjr6YFt2mTXPbnmjDbMD+IAnIQxSa9GOYNEBg+LK+HgTpNmZX6qt2/uB5GxQxGzxyhcTer3FhJ9U27T/G1ARrY6n13FI8AFQwLXpZlyVPU0pCvRX3wSFjj/7FwdxZiaBGkCPk6uNiWmnouUro3jOA6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518963; c=relaxed/simple;
	bh=dcPXYXWEcF3z5rXsUj9EOE0H1lS77aogWQRAD35Z/zQ=;
	h=DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=VM46wnCuOtcboxvY3ArNY7woQm5UVsKUmFcCWfbtJX9MEbijnUjKVnE3r4U1huGSQ2itpM3H/MwcVDDD984KK5lE0k2jBJIB+EtbVRGzF8iCj9IZzkVdLyGBxkdvaCATBW4KDnrLyGzHDviJ5UQqT5v9thhMcxhkaRrgUBtO31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pgJgK4b/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705518960;
	bh=dcPXYXWEcF3z5rXsUj9EOE0H1lS77aogWQRAD35Z/zQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pgJgK4b/5ftpOH55deO1U5jaBi9IC48uVHb7G+uKGemRxroFj4vYhOrJdKhV2/lMq
	 eMI50j81ykz0Mfv/SZHt9q1KVpRVqPdvnmLQiSzQ4RgQ7WYLiH5C5gQnySklRMnCbz
	 Z5R7PMetOqksbi8kbsesKOJ21kdIT2osxc7hAKyYtkJ2OPl8S02nl99bb2OtaGxFhf
	 SYjjDV00tAHkDAnPKD3vyb9E1UqpsK2PLafG8kAlMulPWlKYRVYqHmILXREWVl1kuE
	 GC6tf07lDiiVJqiyD7PgY2h8gLTzsHywjsY6jAazpD+JbmVvL/rpa6u2W9hTcZuvjL
	 d9MWXuJeR22Hw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E28E8378000E;
	Wed, 17 Jan 2024 19:15:59 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 83DA1480C4D; Wed, 17 Jan 2024 20:15:59 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 1/1] arm64: dts: rockchip: rk3588-evb1: mark system power controller
Date: Wed, 17 Jan 2024 20:14:48 +0100
Message-ID: <20240117191555.86138-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark the primary PMIC as system-power-controller, so that the
system properly shuts down on poweroff.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 7075366ec85c..fd665dfda55d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -590,6 +590,7 @@ pmic@0 {
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
+		system-power-controller;
 
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
-- 
2.43.0


