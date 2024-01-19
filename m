Return-Path: <linux-kernel+bounces-31518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC819832F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DDB2336C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76865645F;
	Fri, 19 Jan 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TgnQeH2j"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07151E492;
	Fri, 19 Jan 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693093; cv=none; b=fp5Q816idnUIY4GMEXTbiuOhmMh4DBLwmS/2Y0Gk0Bu92DL+4A/vZoLAi0cJ6FfyIgVp9wd4JtM7q3U7T6elp1GcBxhgN/YuV9Tm0H6EXjFQ6Eq2gNdXo18jJnKnf2i0PBH4Glb3AHNJx3iemQKvjFjcIc+My1gq2wiDvSIjioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693093; c=relaxed/simple;
	bh=sj/aqzYfZIDTUDNdCb7eHJppTugbxRlSalOblYODELs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vda8RbrUZtmNw6zybq58FJm2XSkvBDRp1ZPfFHo9/fUArki9jevvHnkQTqu5n+yAn7wXKVYLB5sk/58bQJNcdin3WJXxK419pt3j2vFc5j1+Pe8h+b6JmVH09IojVgHVzyyYrfRObRofe0c2NqP4KMulcVvyzoA1vw9ueJ56DQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TgnQeH2j; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705693090;
	bh=sj/aqzYfZIDTUDNdCb7eHJppTugbxRlSalOblYODELs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgnQeH2jS6UZs8ulzz0LUiqetDM2CLH2UuSiA+Jb/Yd1LRFJ9aHWhWlTVHENwKZmH
	 T+1V4R/WDxV9tAbBliZsZ4SGcMbftX1DO8YkPgGAiJLCNFe2LUhIcEzklERHyyZFM1
	 TyFiaAVLfMTVvauvreTo6XGs8Mnn14BTonm7eN6pSHVY2/eK5LDmsbiKHqnuh6p2HH
	 kB3VgwccHAjkvuE3BjV701twB7HnZXB2W4gq4Tv7V18UZ38Lx51NHlfs9RPH5BqTSf
	 GT5cBZOLRJP3M5PPwp+Ylnu2aF2vmtQvRP5+pZ9pRkTzX2Dpe5Wts5gbkZQ1MaUHKP
	 VYK55PyWrASCQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 053373782087;
	Fri, 19 Jan 2024 19:38:09 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Johan Jonker <jbx6244@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 1/3] dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon
Date: Fri, 19 Jan 2024 21:38:01 +0200
Message-ID: <20240119193806.1030214-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
References: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for the hdptxphy GRF used by rk3588-hdptx-phy.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 9793ea6f0fe6..61bfe678dc7f 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -22,6 +22,7 @@ properties:
               - rockchip,rk3568-usb2phy-grf
               - rockchip,rk3588-bigcore0-grf
               - rockchip,rk3588-bigcore1-grf
+              - rockchip,rk3588-hdptxphy-grf
               - rockchip,rk3588-ioc
               - rockchip,rk3588-php-grf
               - rockchip,rk3588-pipe-phy-grf
-- 
2.43.0


