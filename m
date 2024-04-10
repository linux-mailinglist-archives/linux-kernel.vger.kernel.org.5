Return-Path: <linux-kernel+bounces-138170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D225089EDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D548282BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F28472;
	Wed, 10 Apr 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OgzLBbgp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60213D605;
	Wed, 10 Apr 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737816; cv=none; b=agYgzqtzCF+3D5EC0EeEh2uieIl/rsSnGYw5/sr3wa1JBzTC1k9FECcEgAP+KAiKQL+jYA7CH+n6dD3al+uVmbS1OsuAnOIIBCNmJU+9r0w9TASp4NWRexD+Ey3DFBEETW5/95Sav2VyUvYnbVWGXXTIifoUUYZpCbkR9d6EUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737816; c=relaxed/simple;
	bh=DDjimJ60wn8VcBGQiRwLupdMEtQ+UOvMdvJ7mEWJSwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfKLtkpywnTz6AFDRTw4ttUKPvLSaBG/3dDYdnrrmh+rFyUlLoQqowvT1kHJmeVzIva8KO5yUHuGTO4XkNoK2XVo2nu7AKYTG+oMq7JAmciQE75HaScx4GB6vUkIZjfkSjc4q9y58PvUfeGn1vIVp6QKvG8HXpT9ARP6w2wROu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OgzLBbgp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712737812;
	bh=DDjimJ60wn8VcBGQiRwLupdMEtQ+UOvMdvJ7mEWJSwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgzLBbgp3jJviltWg9d7VOkXZa+d+H5tGdI/r03Gb7MDUOSO2dp0902/lIH5n6HZI
	 fEUmFiBcYMR2Haq5A8EozQ/78OMyld51RsuQdrrk3RsrTPWzVEQiOuDzBQ3moAQzSF
	 sYrIKshCKWd5Z+UOiwZrX9LHld9WMjiITr+EYdIN8ZcEhUQY9PHJeTOAEgBdG8ExcH
	 StKK/wB39V+alkABl5b+5S9S27DWaH7lgT8GVus2wH0jcDt9mMm5syAmIqeQGeW5aL
	 aPKsoqg1b6rCpC98rUJc3CeLXk2tSp+00ExVAoVslvqv8carrv7UlmmTLaNgIZApVZ
	 A3naNNJ2msdVg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B197B37820FA;
	Wed, 10 Apr 2024 08:30:11 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bchihi@baylibre.com,
	bero@baylibre.com,
	amergnat@baylibre.com,
	nfraprado@collabora.com,
	michael.kao@mediatek.com,
	mka@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 2/3] arm64: dts: mediatek: mt8192: Fix GPU thermal zone name for SVS
Date: Wed, 10 Apr 2024 10:30:01 +0200
Message-ID: <20240410083002.1357857-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410083002.1357857-1-angelogioacchino.delregno@collabora.com>
References: <20240410083002.1357857-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This SoC has two GPU related thermal zones: the primary zone must be
called "gpu-thermal" for SVS to pick it up.

Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index f3b0da2399a0..1f0f076272a3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -2236,7 +2236,7 @@ vpu1_crit: trip-crit {
 			};
 		};
 
-		gpu0-thermal {
+		gpu-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_ap MT8192_AP_GPU0>;
-- 
2.44.0


