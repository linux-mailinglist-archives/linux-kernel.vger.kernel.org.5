Return-Path: <linux-kernel+bounces-105314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4C87DC20
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4731F21E92
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF34C9A;
	Sun, 17 Mar 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="NYDKb5fV"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC82139F;
	Sun, 17 Mar 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710636113; cv=none; b=o6mGprM9dmiZ2fXiTjMgIcEnHvgauXhVrX0NarVVFIALI4Mqvx9LqBDZ4TOUZ5yugHTffhI9KfV+oDYfg6onTkkCVFkknij30wAgoRZpd3L2vopclMZyEk3NwZef8NLeiuTSH139PPZk8EPn8/NhHCZQM3bhQCls0X2ojoLCU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710636113; c=relaxed/simple;
	bh=ksVLPcTsVnyj995EmOMcI2srIAC9s9IT4KG2Pj+lGbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EiWDYzkfI1BG4rop4JTVk1i3neeErYQ2/3SxF8M9nkjIAW7aUT2bdTaJSB0lz203z+fvWQGBZVDreP51/bIg1zt9lIavrxZui0oVBwSyDQxj9J6fIsyJS9bCSapMJ5hcoxAnnHF+PY37F3rr10t3Ioqj+cp/wbg6LCIBjyyZ8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=NYDKb5fV; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 85B1D47565;
	Sun, 17 Mar 2024 00:41:44 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Pavel Machek <pavel@ucw.cz>,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Miles Alan <m@milesalan.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	Ondrej Jirman <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>
Subject: [PATCH v3 1/2] arm64: dts: allwinner: pinephone: Retain LEDs state in suspend
Date: Sat, 16 Mar 2024 20:39:28 -0400
Message-ID: <20240317004116.1473967-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1710636105;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
	bh=F3bSG+mqyiDBJJBU+WfFQefVpoTTbxWAEd15u4S7jEo=;
	b=NYDKb5fVA5FZXLWv6gQh/vg6NQD63TxJURhfsrCpIO40V5kxA8VEHm15bryWhGXxFahRcG
	5fNTu82ePrqrlEvFUalZwmJ3A5pv9UvgjOjsCDL20Te/jq1AAaUCe5pNGYxviKojtAsG+3
	bmBVnjKdCuNQ8ilEZ4fBR13ZfF7s2cY=

From: Miles Alan <m@milesalan.com>

Allows user to set a LED before entering suspend to know that
the phone is still on (or could be used for notifications etc).

Signed-off-by: Miles Alan <m@milesalan.com>
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
The previous revision can be found at:
https://lore.kernel.org/lkml/20240206185400.596979-1-aren@peacevolution.org/

(no changes since v1)

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d..ad2476ee01e4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -43,18 +43,21 @@ led-0 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
+			retain-state-suspended;
 		};
 
 		led-1 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
+			retain-state-suspended;
 		};
 
 		led-2 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
+			retain-state-suspended;
 		};
 	};
 
-- 
2.44.0


