Return-Path: <linux-kernel+bounces-140364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8508A1360
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFACA1C215EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E714E2E0;
	Thu, 11 Apr 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gQwnAfHF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232114D449;
	Thu, 11 Apr 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835797; cv=none; b=soYvulA8CDii9hxwKuaaPXjtETSuSzNi4+cKTcR9LWELzkrkSaAS0ccCoWMwbD88nlGt2kdUMTZ2dw50j3Mo0kNhWsp7q2ty0YrM15mRsCdt2Y+zncCpKJNyP7rq4EQYatcj67DLVZrA7o9hnqTRENZ97dUUYmok46xiOomfwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835797; c=relaxed/simple;
	bh=XK+I2rHX8gkIddpwg379tC6deWLfihQGpL9it+LQ4dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXhMgdxNyOCVepROj/pQg13ZY6yQJdhqi0MT3cN8T2WMN7Wmq3c+eg9VDyXyd9YhWVNDyj4QoaNCSpui+3KzaOazrogvBNVne2fiAL9f5YErcekoV4O+efAWAoFMLaBA51+uHeFyh5r+pMpGkFV3KMKx2fkIrEK5BmmA+R9IRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gQwnAfHF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712835793;
	bh=XK+I2rHX8gkIddpwg379tC6deWLfihQGpL9it+LQ4dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQwnAfHF0KS/oa6i2PPDzESXcAwD9eRMsGZUYtWIPXIg1KsDOslk2o2zgchV5v+2H
	 j+ULGrUDmHGFcoCq8FCTgeC6pBwVo1At2zXU2g6nkt4k8930bRQ1KKlaW45TKZWdmQ
	 ddZEztSEpPtmJAtPKnSNmJmvt+2e9wsgsAkPemBdJKQ0A0jWwsw0ic60ukWub9D6O9
	 JYfHzWfUcrCKBQiuCYZ/kX+UPDnmFrs1vzC2GnKppMg2pCxPupGV402oFVtMoR79MS
	 pyPscqiwAwif/AwglRt2DLwV0GiNShuq+5DW/RScwf+ggtrPZvHk436hqIHc4ctSAB
	 oL/M5dDgDsp7g==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 909373782133;
	Thu, 11 Apr 2024 11:43:12 +0000 (UTC)
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/8] dt-bindings: ufs: mediatek,ufs: Document MT8195 compatible
Date: Thu, 11 Apr 2024 13:42:58 +0200
Message-ID: <20240411114300.169055-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the new mediatek,mt8195-ufshci string.
This SoC's UFSHCI controller is compatible with MT8183.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index adcd13023866..e2c276da3f2c 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -22,6 +22,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8192-ufshci
+              - mediatek,mt8195-ufshci
           - const: mediatek,mt8183-ufshci
 
   clocks:
-- 
2.44.0


