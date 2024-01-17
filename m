Return-Path: <linux-kernel+bounces-29332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6F5830CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D9D2872F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D40623763;
	Wed, 17 Jan 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="n6tMzGF0"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0101A23750;
	Wed, 17 Jan 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517269; cv=none; b=P+zy2mu1gFLlYwNL+FAzDVgnHdbwzBgqKkvN/uLVbv5fQPAVoozwvBR+KuHd2yKjRfeqiwSQ44xAKMOVZNrfp300ORsfc/QnUNDm3zsp7qZZLGLW9P+AdGJfUpzyP4UFVmvC1Rvu5DyiOUvWKQJZdeEIddGRDC3dC1uEf2rdW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517269; c=relaxed/simple;
	bh=7shlTtd6zib1WY6lh/1uY3EF78yI7A5U7HUGuYvl1/g=;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mail-ID; b=mPWvDgCKZxrC5BwZ5XRA4Hw521GuCAQg3rUmzPjs8ffTAcgf9KTLJy0JauJEnJS2ROhNH+dsOgp0furfICMXr2ITxm9IaVwwyF1mcvtTS7w+T1j12IYXCnD6zvupxTEGfU/wMTMpRyhRA4oO2EbKX3ir8gh0lJ5SUUg/KxBfqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=n6tMzGF0; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id C4AC5101655;
	Wed, 17 Jan 2024 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1705516875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsTpAwqd/7QjMORruXxyzjor5gLJU3V4uDYNASOFOIs=;
	b=n6tMzGF06/M3ISIDribRHuKQ35U3S/Y2vBsVitsfhE06qp2j629OGhuGEM/o+HpMEM30iK
	5+wrlfYZPZT73HpZDindSidDxoR80xoXMDD7LXaa/kyH9WnA6QMOuHpMQo18lZRFgRoxMO
	jATEPVe+VhBR/PrV6oA+oPR4drCioEI=
Received: from frank-G5.. (fttx-pool-217.61.151.254.bambit.de [217.61.151.254])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id DC922100738;
	Wed, 17 Jan 2024 18:41:14 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: reset: mediatek: add MT7988 reset IDs
Date: Wed, 17 Jan 2024 19:41:10 +0100
Message-Id: <20240117184111.62371-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117184111.62371-1-linux@fw-web.de>
References: <20240117184111.62371-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 8e13c0df-8d77-41db-a62c-66e3a8be9a12

From: Frank Wunderlich <frank-w@public-files.de>

Add reset constants for using as index in driver and dts.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- add pcie reset id as suggested by angelo

v2:
 - add missing commit message and SoB
 - change value of infrareset to 0
---
 include/dt-bindings/reset/mediatek,mt7988-resets.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
index 493301971367..0eb152889a89 100644
--- a/include/dt-bindings/reset/mediatek,mt7988-resets.h
+++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
@@ -10,4 +10,10 @@
 /* ETHWARP resets */
 #define MT7988_ETHWARP_RST_SWITCH		0
 
+/* INFRA resets */
+#define MT7988_INFRA_RST0_PEXTP_MAC_SWRST	0
+#define MT7988_INFRA_RST1_THERM_CTRL_SWRST	1
+
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT7988 */
+
-- 
2.34.1


