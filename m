Return-Path: <linux-kernel+bounces-24020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168382B581
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9771F250C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52756B6A;
	Thu, 11 Jan 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vXUnY8To"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE115676A;
	Thu, 11 Jan 2024 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705002944;
	bh=SmeOEDSBky71Md5WcIgFutmSu6F+tVl6/qd5e5Nr00I=;
	h=From:To:Cc:Subject:Date:From;
	b=vXUnY8TokOIid07j7JM3xAa6tWdwjj2xyHSGuAXP1cTmJrPb+dtU9lKsB3GINxata
	 uuEkniEOyCZ+2jDJ1Oor6r9Z9D5oecP/6jjVjT0/NytnnbtvFBp84swvmWtXpzVap6
	 2tzb9d3AIWMTzvDV+JXpsJyZDuDb3ql2UTdv04Uo07yd+Rfjoe7taQYgl3RQnhkyis
	 maRheIu04/BTdEN+WxUapufoIdG+H51lE+53vrQiOsXSuq2YE0LoKOuzAW9+VeAFZQ
	 IN81QP0RDna7P9+REF+hROxy82SpudMNKHzeQubyYQqHezxy9bXqatha62wQs6F3Kv
	 5fC+RDYnksbfg==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 35F703780894;
	Thu, 11 Jan 2024 19:55:39 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com,
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
Subject: [PATCH] arm64: dts: mt8183: juniper: Remove CrosEC base detection node
Date: Thu, 11 Jan 2024 16:53:12 -0300
Message-ID: <20240111195335.871096-1-nfraprado@collabora.com>
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

The juniper-sku16 machine is a convertible, meaning the keyboard can be
flipped but not detached. The detection for the keyboard getting
flipped is handled by the driver bound to the keyboard-controller
node in the EC.

Since there is no base detection in this machine, and the device backed
by this node fails to probe and goes unused, delete the node from the
DT.

Fixes: 4fa8492d1e5b ("arm64: dts: mt8183: add cbas node under cros_ec")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
index 8ac6bf5b17f9..8096ca215258 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dts
@@ -13,3 +13,6 @@ / {
 	compatible = "google,juniper-sku16", "google,juniper", "mediatek,mt8183";
 };
 
+&cros_ec {
+	/delete-node/ cbas;
+};
-- 
2.43.0


