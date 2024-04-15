Return-Path: <linux-kernel+bounces-144961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286638A4D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C963A1F2561E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938C6E2BE;
	Mon, 15 Apr 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oFqOrkCq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C6D6CDAD;
	Mon, 15 Apr 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178831; cv=none; b=b0AKDvgKmzRqjqlT9N2SMKgrFC2Q86+JSfNEKVrBQxRtwg0bAqa+Q0G/A5VqdUkweJRF6DD3EacTMepRCvgYYr3KfhAN5zPP0h7Lo6JfzWUECWBkAXoseh9YwnDW1JkNCQHLRcEgrM4uSPrWwNANIpG9u8YjChK/0Y9DUu+WAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178831; c=relaxed/simple;
	bh=Y1uqBUPVNGc10mDuk9ItFOcl/06l4dJLjdZpRz+FbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSgYdM5bozBmjHsysRs4NlZ90FS8FtP1nVQI2VdHKNtv14yplJrhjQFSUnJAsk/VlBa9hOcPf8iw6bU4okplzGOnTUbTl1IpnBS7UTD9dB6pFBINPUaB5Q2Z04iEyM5REbswC2PJvEfR4mFYyGIpuV4BWF/6boXHpaoFbzFTUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oFqOrkCq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178827;
	bh=Y1uqBUPVNGc10mDuk9ItFOcl/06l4dJLjdZpRz+FbPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFqOrkCqMTSBRYOnWA6mmPsL5ckxO3phYo8v091hzbBSYGJP+AlgdxA/QzqBWSmJx
	 vfnfG6JEIni9jizg9F5aFgKFADsHQ4ks7pKZOP/G/fsZLojtSUoPaVWRz7uac0fcD0
	 ZuSqYv9pfQLKelJJDOMXBGnfyG1IiwJr51jQGYR42kzZsT6y5z2dXPi6GgXQnHa/SJ
	 /Q+fb0z1Ry477hrZcysZTDuqO77TIUm54YNettLANpoh+lp+nnuvjMqOl8iKTSVf0c
	 evUie7Er2VaF+cIHkxwEmiLvDm+zFOizog1JgSdoFbWZ8WbAKPxfk8HYaq68BZ9tGM
	 sW3pxEEPzym/A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5E0DE3780022;
	Mon, 15 Apr 2024 11:00:26 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 8/8] dt-bindings: ufs: mediatek,ufs: Document optional dvfsrc/va09 regulators
Date: Mon, 15 Apr 2024 13:00:12 +0200
Message-ID: <20240415110012.148871-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional dvfsrc-vcore and va09 regulators used for,
respectively, crypt boost and internal MPHY power management in
when powering on/off the (external) MediaTek UFS PHY.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index 1df8779ee902..b74a2464196d 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -48,6 +48,8 @@ properties:
   reg:
     maxItems: 1
 
+  dvfsrc-vcore-supply: true
+  va09-supply: true
   vcc-supply: true
 
 required:
-- 
2.44.0


