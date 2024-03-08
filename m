Return-Path: <linux-kernel+bounces-97248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B620876789
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065042865C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD1208A4;
	Fri,  8 Mar 2024 15:46:30 +0000 (UTC)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE01DFE8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912790; cv=none; b=hoZmbGdY0zY7kKnLRUv6NJVWJev8N5O5UNbfROh83q8b9/AlaiHTgeW0wGPvfk1BG6EciY6iCDNM+1edDzT+c+okkWjwKHZI5dGpNYe4x5hK+PU++ETKBzT9DhW/vTR8Bm9Mn5GKN/BYRiOuzIXRTDEx6TgK4N8UTsXLfp0hS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912790; c=relaxed/simple;
	bh=CsxBBBSHXzQ815mZ6jxRjFfX677ayQW2fERBzYakubA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NObbA7Pbp1EudFSFDMC5zpG+dnw6EpLBGzS89oDGbMtmPQgiDHg3YYVKy0JhQ4IoY/0cCKK8KF49IUzylIVpoYQm2XxK+78IbxO40f0RDGg7lEi7QbVTovurmrsSsndw0HNo0AaQ7goSr187feC19wsKsf6o95ZZln3qpbBPJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TrrB90RFXzMpvmL;
	Fri,  8 Mar 2024 16:46:25 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TrrB83sMlz3g;
	Fri,  8 Mar 2024 16:46:24 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 08 Mar 2024 16:46:07 +0100
Subject: [PATCH v2 1/3] arm64: dts: rockchip: enable internal pull-up on
 Q7_USB_ID for RK3399 Puma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-puma-diode-pu-v2-1-309f83da110a@theobroma-systems.com>
References: <20240308-puma-diode-pu-v2-0-309f83da110a@theobroma-systems.com>
In-Reply-To: <20240308-puma-diode-pu-v2-0-309f83da110a@theobroma-systems.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The Q7_USB_ID has a diode used as a level-shifter, and is used as an
input pin. The SoC default for this pin is a pull-up, which is correct
but the pinconf in the introducing commit missed that, so let's fix this
oversight.

Fixes: ed2c66a95c0c ("arm64: dts: rockchip: fix rk3399-puma-haikou USB OTG mode")
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 214ea62b24a5b..a51ebb8f8b80f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -459,7 +459,7 @@ vcc5v0_host_en: vcc5v0-host-en {
 	usb3 {
 		usb3_id: usb3-id {
 			rockchip,pins =
-			  <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+			  <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 };

-- 
2.44.0


