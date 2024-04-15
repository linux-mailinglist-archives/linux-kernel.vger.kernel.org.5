Return-Path: <linux-kernel+bounces-144959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E648A4D27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE45282A75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279AF6BFB8;
	Mon, 15 Apr 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B12gsYSr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8A769DFD;
	Mon, 15 Apr 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178827; cv=none; b=pfUBy/mNanI1r5DjNQ9EEmuiVOzIgp+LpuN05ivW9+pKUeJcNCKG6gVL9hzUoiCrLEvG/M4DGLjHiyZMm9tXNwDE7BN6qZk5leNYDjPZ8j5CSrYw2tYFCxOsOuINErm/Cez7Uc+BMEsVCiDWCdtW9VEGY93qyImDqg6fW81MPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178827; c=relaxed/simple;
	bh=BFZxzlOXlh4INwTzOFkmc4Gr8sWYonUVaud3Z6iWoOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crhzu9yaucCIXQOzZ28ChnMQVpA1aGwIQT+Sev+3ylXUNpuPyV4wxCHNzh+HCKQJakAKyrIbbtY2pT1y4qWODHWbIpF2rEZzthJzZisKwArxXUi49HKzoeoa1x+YBlGQscyUu4mF23TqPHgRIGzhehlgdk896G9DumEROYxtm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B12gsYSr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178824;
	bh=BFZxzlOXlh4INwTzOFkmc4Gr8sWYonUVaud3Z6iWoOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B12gsYSrca7B2bMWRU3Z8pSIwrFv1BfHwJZUn/k66FMrqlsPNy+QnsWKUcjm/IP8Q
	 HM6UkebdymEj9rvOjiHHmhIX89cS3LjdHQgnt1GtbjK0TYgvF/N4WDvkKzCUjcJsYt
	 /5uVl/qxJKqAFBTgYGDE0Nn/jYVL1aPH0CtjfpoqDHlzmFxzdCUljhUhs6yFOzM2La
	 TWZ2pghMDbyIIm5qCni2+BsDDXqhg9e0JLDVkbGzIqxuZzENqZwSSgirzLnJqOj6UP
	 4C+Ra136eZnfitqO5XYGl7BkBbqjlNd3A5/1t5F+eAswlaN3dF5aKylahkUwa31tG/
	 WOwvboE3O+zWQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 61C303782134;
	Mon, 15 Apr 2024 11:00:23 +0000 (UTC)
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
Subject: [PATCH v4 6/8] dt-bindings: ufs: mediatek,ufs: Document MT8195 compatible
Date: Mon, 15 Apr 2024 13:00:10 +0200
Message-ID: <20240415110012.148871-7-angelogioacchino.delregno@collabora.com>
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

Add the new mediatek,mt8195-ufshci string.
This SoC's UFSHCI controller is compatible with MT8183.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index f14887ea6fdc..5728e750761f 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8192-ufshci
+              - mediatek,mt8195-ufshci
           - const: mediatek,mt8183-ufshci
 
   clocks:
-- 
2.44.0


