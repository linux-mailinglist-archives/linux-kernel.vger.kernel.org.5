Return-Path: <linux-kernel+bounces-140085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12288A0B40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2CB27B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C19145B08;
	Thu, 11 Apr 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Tbv3N6Uk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44711F176;
	Thu, 11 Apr 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824324; cv=none; b=Ykz4njvax8ndyLzE2qjxAoj28IXpyHYv3xV1e9LuoWVNfFD/Ico1E19YuQBtti+iLJfs4GqLtFAeVHI03nWTaPziETanZR8T5jEW5dcpYpmMq5zlF8TSeywNUMS9+rPpkFWl4ro/1uXkSQzFicyQs+dzGkEOG0t5bDGe+Wu9Tik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824324; c=relaxed/simple;
	bh=qvwukQ63ru7c/su/YXR6zlEYXzSPY/kzv1TeqWamDO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfbSa4+KS0508FqiTdUELT18hvAjmifGJqKwFGRuYTbaZorm2N3yfzFLdEU64cA1VfmzcDF3e3bUxGj0oJ12j+rqa0ZJY/1hlnRm2BzHaM1mhTROvjRjscNnkW78C4b5yQrhB7cRBAjBnTIGzoTUnTmnaGpNjkwWj5jVOLKtx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Tbv3N6Uk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712824321;
	bh=qvwukQ63ru7c/su/YXR6zlEYXzSPY/kzv1TeqWamDO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tbv3N6UkWXQ3FwscFqj284jPwjO1i8h8kykuyl6pf1ztcSQ7NqnBmlOAXNenTtw0z
	 KADZtve/5TXBl6DuxO8pdBqLO20VCyb1aD7O74TR025UdSMMBBJO3KvVl95OPN9x69
	 y65lREzpxn3l4ud07dBNZC8Mapg0vlrSk5Pwun04EYFTY995JJ3VTVm9LugVZmzttC
	 49DOI2amJX+/WCRBX8u+w3AfI384OABE/JBfEgpcJFqzoE13fnDqvRJ/uTdwEg5qej
	 doNiJ/5tGFo1sqM9RRw+J9uz9RoMg7esE2KInqME7nJvNrpJqBVZ2ZHW1AInfRxH39
	 rPHdNEGOSRPMQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BF3A33782134;
	Thu, 11 Apr 2024 08:31:59 +0000 (UTC)
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
Subject: [PATCH v1 5/8] dt-bindings: ufs: mediatek,ufs: Document MT8192 compatible with MT8183
Date: Thu, 11 Apr 2024 10:31:46 +0200
Message-ID: <20240411083149.78537-6-angelogioacchino.delregno@collabora.com>
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

The MT8192 UFS controller is compatible with the MT8183 one:
document this by allowing to assign both compatible strings
"mediatek,mt8192-ufshci", "mediatek,mt8183-ufshci" to the UFSHCI node.

In preparation for adding MT8195 to the mix, the MT8192 compatible
was added as enum instead of const.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/ufs/mediatek,ufs.yaml        | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index 32fd535a514a..adcd13023866 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -14,9 +14,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8183-ufshci
-      - mediatek,mt8192-ufshci
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt8183-ufshci
+              - mediatek,mt8192-ufshci
+      - items:
+          - enum:
+              - mediatek,mt8192-ufshci
+          - const: mediatek,mt8183-ufshci
 
   clocks:
     maxItems: 1
-- 
2.44.0


