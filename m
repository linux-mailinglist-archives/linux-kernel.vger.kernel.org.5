Return-Path: <linux-kernel+bounces-13242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9338201D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 22:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F6B283931
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1B14AB9;
	Fri, 29 Dec 2023 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HPgwDdLK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D014AA5;
	Fri, 29 Dec 2023 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703885467;
	bh=XL6wkiD2HYx6HaI4hGDV0Keb34y3XqC2DjGmqSSBy68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPgwDdLKJcKpAtUbU9HxQhIW+JM1CO3SqRQv5YJMD2R4TwrVN+DJJBNTbNklpO7nS
	 Bfklfoae+bCfaUPBoDG9McM1aebFRKxtHozaTaQZ2xjsuoC8tUX2utslWOKSADvf04
	 X3SsEQVGUlzn4VfGVG6l45wtPcjIY10tTUeqZE1BMjpgEdkp9qbFSx/B+rl2z0vc6r
	 Pc3Z+/REaBuT1b029wtURtyKCBUpAcvbzgfDOiGMi98HAa1J+/5/Kj+5QPvT44UK92
	 9/ZIkguje/JeQsZ+vuHU81HeqEy4/e9iz0AM/HwPdFOdLMqtxuaV3IA0ALA/L8jQWL
	 Pfsh9wZQX7AdA==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E0A023781FDE;
	Fri, 29 Dec 2023 21:31:02 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: mediatek: cherry: Add CPU supply dependency to cpufreq-hw
Date: Fri, 29 Dec 2023 18:28:40 -0300
Message-ID: <20231229212853.277334-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229212853.277334-1-nfraprado@collabora.com>
References: <20231229212853.277334-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the mediatek-cpufreq-hw driver enables the hardware (by
writing to REG_FREQ_ENABLE), if the regulator supplying the voltage to
the big CPUs hasn't probed yet, the platform hangs shortly after and
"rcu: INFO: rcu_preempt detected stalls on CPUs/tasks" are printed in
the log.

To prevent this from happening, describe the big CPUs regulator in the
performance-controller DT node, so that devlink ensures the regulator
has been probed and configured before the frequency scaling hardware is
probed and enabled.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index dd5b89b73190..505da60eee90 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -502,6 +502,10 @@ &pcie1 {
 	pinctrl-0 = <&pcie1_pins_default>;
 };
 
+&performance {
+	big-cpus-supply = <&mt6315_6_vbuck1>;
+};
+
 &pio {
 	mediatek,rsel-resistance-in-si-unit;
 	pinctrl-names = "default";
-- 
2.43.0


