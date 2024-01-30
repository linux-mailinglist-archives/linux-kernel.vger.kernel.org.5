Return-Path: <linux-kernel+bounces-44320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22585842072
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4927FB311FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1666B34;
	Tue, 30 Jan 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TcpH6VlP"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E195664A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608351; cv=none; b=fhqrqCg9ncXGOqabz+dJB1ozDE9B0aoC3kitZR7NDwbiKn5rVbyeNYujTejqQ8ab6dfkJ/a9dmC78LfEJjvriOWyeSp+NXIIIp7c5ePmUTAXN2AToo1C5rYiSgDneSHTFjHMD5w5jjBWhHZJ4YaBF5t8Lv0ic0/XMX5WgP85WFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608351; c=relaxed/simple;
	bh=g5rkrsUczvT98u64IjHetISOxo+BA6WM15O5Bq18z8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=st/LDS2znZmkppGub6JzyF7SsCGhBncHMZ8XNUjCCU0gqQQcHd9g8XnKZGlhaZAWzBGYTEjmgptDCGlmfWXRCPSvtqrcmsVmC3G19L6r4tSBWzf517vHVza4gQMSCqgdjRKSKDmJgSTNAnEaGRIFyJ0nX3u+SRFspVH73G0hfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TcpH6VlP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=eMpBOKcHgjOgUu
	6e0neo1Xoqw8sM/5NUtcgLJ0eoc9w=; b=TcpH6VlPrVDpYNb89HzqoMZMVwpoPp
	ByXNStY2Nw+iq2OQokAZfA0LfEF/FsCJJ56MBIwXxliwrkEHJeM8ImdK5WMaf8ca
	EqNbRRdr+OqhBOZbD1GpPfIzIZeaK7t03XR+4kMNq6W04vhnLtFTBWggvRIns4qo
	gKk90EhhBm4QaHjGvby4bkbccsWbMwy1MjBo5XZID1bk0oNa8bjFZfDNZcyNDX6K
	COmnxNzCjSv5tPPuLhetN0puHmLqOw936p8f41CqLOkQS56T4UNnH23H96xXFp+7
	u8TvrtEqnXBRvcWEJkagetICxazv1W8gvXvSR/qfCkTLt3GRovl38MAg==
Received: (qmail 2786307 invoked from network); 30 Jan 2024 10:52:26 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jan 2024 10:52:26 +0100
X-UD-Smtp-Session: l3s3148p1@vQM5uCYQZOdehhtJ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: renesas: ulcb-kf: document a problemw with old firmware
Date: Tue, 30 Jan 2024 10:52:22 +0100
Message-Id: <20240130095222.11177-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old firmware set the GPIO to output, so no interrupts could be read.
Newer firmware does this correctly. The exact version could not be
determined, sadly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 84b0976503b7..45e55ce760d1 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -324,6 +324,7 @@ gpio_exp_77: gpio@77 {
 		reg = <0x77>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		/* If these interrupts don't work, please update your firmware */
 		interrupt-controller;
 		interrupt-parent = <&gpio5>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
-- 
2.39.2


