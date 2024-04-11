Return-Path: <linux-kernel+bounces-140094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9430B8A0B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E6B1C216FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A137149DEE;
	Thu, 11 Apr 2024 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZWl6KJ2M"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EB146591;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824328; cv=none; b=nF8KmKD7ImEUtgP5sZDdzzkO8b4MSxK4SGD97IOBWHJJ9Mq7irNu4fCuKrIzKS1G/0+jPalaf8Iajx0rVNiql8vo1iTp5//+sss7brZcurAvajBaVEHL0G7cJR9YOTSxWHeyGWjfx9sSqnX+yck8Q6hTdPIK42POT9osn1vCp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824328; c=relaxed/simple;
	bh=pkymiWIPWxat5Rr2zyDqx/dSmImzanbRzBc2AuBwPV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpE5CCa8AANWqmEHsNWeXz4fcW9f4G2urTXuRNdZ0yhu+suoBxrvQOpp1nssiS1Z130DU1sBNnfucch0UTNqgW7tHPBuOI/HAdIurbcDAERDocxTEDeYaLU1kS/WvzaCY5SM+eP5Wksy9L8Dorowd05BnSTGAWjCAdYGVn+x6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZWl6KJ2M; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712824325;
	bh=pkymiWIPWxat5Rr2zyDqx/dSmImzanbRzBc2AuBwPV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWl6KJ2MaCPG2TpRWPsqMCPlaKKShFlrxo4JYx5AsHPwuitSP3TaKHqheV8CBG2n8
	 oG5L0ARRG551EVUNEcTvGHCr8ktGLwojLReg0KceFzgfs0KHn6v+LYtTgg/Pkt8kCx
	 3sEfFzTaqnYC+FI1RcK1/gTceXl5WEPd6lJa+qNbIBYcNNIdHlF9pvWLkYr8364W3T
	 2Oh6DfncModQDTz7eSGwZ/RY16x44WbS/jUSCSjeuUMDjrOhnl06Y0ld14hbiFvybY
	 xRqmmvJ5GL5rAhe2zCtpdgfz1ZMIu1UPudk3xQc8R4GrafUThTIn9dsoVBpIvPJNBR
	 177BHAR/cYmMw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 132DF3782139;
	Thu, 11 Apr 2024 08:32:04 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	chu.stanley@gmail.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 8/8] dt-bindings: ufs: mediatek,ufs: Document optional dvfsrc/va09 regulators
Date: Thu, 11 Apr 2024 10:31:49 +0200
Message-ID: <20240411083149.78537-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411083149.78537-1-angelogioacchino.delregno@collabora.com>
References: <20240411083149.78537-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index df2e2d388e70..118abfad0250 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -49,6 +49,8 @@ properties:
   reg:
     maxItems: 1
 
+  dvfsrc-vcore-supply: true
+  va09-supply: true
   vcc-supply: true
 
 required:
-- 
2.44.0


