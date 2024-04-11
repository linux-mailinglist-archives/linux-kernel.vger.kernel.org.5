Return-Path: <linux-kernel+bounces-140363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29E38A135D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CC8B25729
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C814A084;
	Thu, 11 Apr 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VAqYmma0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00D14D282;
	Thu, 11 Apr 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835795; cv=none; b=sC9OKIW84JayV++SC37EL4+6XVShPWxZQK3VSS9Si6RHO3Z8UZfAD5BiSbQTsc6jPVdFKeUHofMMiDB50ZuO40rOac3yZJlebpD7IjUdGqCS5h+mruJTn1I/JSH7yxhPWBDvV4ItgWhM/MBZjyfbQyVmC62WyIrVZyKqxgpwDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835795; c=relaxed/simple;
	bh=qvwukQ63ru7c/su/YXR6zlEYXzSPY/kzv1TeqWamDO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCwm4qssV0zB5iuC7mZSD94eglD2ypUwLRJDGR4V7voGwNhpBN+Tm6u5POMRet9Ao/7Jcl1GlRmQdH1scpw4SJDs5IZLxtLANt9+ybbldgyDX4WyFDJv9PdEWFSdOEnNY2L1zetARwEPpkFNZNWDkG2EZE/MZv09chbySF3Qmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VAqYmma0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712835792;
	bh=qvwukQ63ru7c/su/YXR6zlEYXzSPY/kzv1TeqWamDO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAqYmma0GspQtIe1m5Adref3Nhp7/ZUqOfqoew3DXbikfj6o7ArlgIBdvGhdTyLfe
	 JhfmmyMywVH3rWvW1zZYsdslxnfF2tAm6jspQ9BIFL01HDN8BYMm1i/jT+SUYPMNLK
	 AQKcng6DeS9ixBhy3wCeAyu0dYTfOxz/6iNcHgOz7YSyrIP2bAL7nSoZLlNErkBbq4
	 eXIYMea/lkzEsI3WGC7OQX22EHlMy++hWJd0eyd9HxfhBoQuxdJsz3MVqkTMlPsrjl
	 wOrQqTcE5Bk2OuvDsgyXzGtUWCN5zh4wLy7p9NJtPERteBt2GTCTolUJJI6YQdEwYt
	 GL+/x4+EkD3Bg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 32FE7378212D;
	Thu, 11 Apr 2024 11:43:11 +0000 (UTC)
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
Subject: [PATCH v2 5/8] dt-bindings: ufs: mediatek,ufs: Document MT8192 compatible with MT8183
Date: Thu, 11 Apr 2024 13:42:57 +0200
Message-ID: <20240411114300.169055-6-angelogioacchino.delregno@collabora.com>
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


