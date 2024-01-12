Return-Path: <linux-kernel+bounces-24736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9A82C193
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6761C221AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394086DCEF;
	Fri, 12 Jan 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5IswpgLy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD46EB44;
	Fri, 12 Jan 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705069361;
	bh=2cBD3Lbpl2cRVVQBqOcu4sRyjCaGrfbaTxuW4Uf9u2k=;
	h=From:To:Cc:Subject:Date:From;
	b=5IswpgLyvJQ/mJIsfPnF4WKCupnP39c+fFVV1tvMQdxIs1duZkylkmsmdnG3dTY07
	 ffU5rLJyazvVoCGTVMnM3eI1JJm0HpPt9psFhDvT9Vei0roUZZ2t3EAY57K2jTcQfF
	 F7kRJttqjHnpy/UQk0lHe9sBm1h4NRgMtwUUVSfD5Jad7f5ciCtGMD1RmEcoghPr5y
	 qZrHeSFeACqYw1ZaOmdxbX+SfaPisa2qOCR3/8+qwIaHzvfy9gyO2SXFcKThx1NWf8
	 uBTVqheYQrpVpOLQRjPPjmPs8K7plC4OJJtWnsKT7fVp17PpmtDBihD+AtuR8wns9c
	 6WE44Hi7+6Wcg==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0605A3780624;
	Fri, 12 Jan 2024 14:22:35 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com,
	Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ikjoon Jang <ikjn@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] arm64: dts: mt8183: jacuzzi: Remove CrosEC base detection node
Date: Fri, 12 Jan 2024 11:20:28 -0300
Message-ID: <20240112142032.909736-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cbas node is used to describe base detection functionality in the
ChromeOS EC, which is used for units that have a detachable keyboard and
thus rely on this functionality to switch between tablet and laptop
mode.

All machines in the jacuzzi family are either clamshells (ie normal
laptops) or convertibles, meaning the keyboard can be flipped but not
detached. The detection for the keyboard getting flipped is handled by
the driver bound to the keyboard-controller node in the EC.

Since there is no base detection in these machines, and the device
backed by this node fails to probe and goes unused, delete the node from
the DT.

Fixes: 4fa8492d1e5b ("arm64: dts: mt8183: add cbas node under cros_ec")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Moved cbas node removal to jacuzzi dtsi

 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 7592e3b86037..8c9f7435cf4c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -484,3 +484,6 @@ volup-btn-odl {
 	};
 };
 
+&cros_ec {
+	/delete-node/ cbas;
+};
-- 
2.43.0


