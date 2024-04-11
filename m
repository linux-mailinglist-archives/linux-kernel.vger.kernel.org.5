Return-Path: <linux-kernel+bounces-140365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8087D8A1363
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AB51C21146
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD2714EC4D;
	Thu, 11 Apr 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QuKlKOR7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842D14D710;
	Thu, 11 Apr 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835798; cv=none; b=fnKBn7j3WFCf133vlxaqlZIFQlbwPvvPof/wUiauWbvoGfhdulqzH37ZAL8O8OhNDPQ4SDZuThwTYGVBwATUME3JDGzRxfoFatdQnK4gwntwz/xlXTW+uOs2mXIDJosMhkxaXKlZmiXYbaQixagWUDOWAiehnp5EF3YGywFyjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835798; c=relaxed/simple;
	bh=GuvA/DRMxI0WIit88vBOOF9cxqJqFuEuz4b3EKsPftc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCtm+lO54UNkIRHawYFyCSQrRxMxaAVhrJYj4+EGXSfdnuORoR5EFJ/peFSB8Lg6y46N95qt0qyTCYAw+h55xRdjn+opEiLfqcmcx/z4VtLpUrcW0cMO1eteR+rz7LkpAKQ4TUpgHWCPKaaHZ52VtJWmtdBix5AJcjg0xeoOF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QuKlKOR7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712835795;
	bh=GuvA/DRMxI0WIit88vBOOF9cxqJqFuEuz4b3EKsPftc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QuKlKOR7aMM+sLqdhb/WMLya6mDI7djcoX1wqAT9KwAhyBJ1kxGVxoQGW2WlCkkv4
	 h65DYklhQ7zWhIltlIrQxEZVTFKUdK/C91dP3NHQvpmF/7i+lPz/pa0oF07nBke2wi
	 2UiQRUzzWqQSc3/I+0fCipRiHR5NUjLoVe9hL2ciKGnnB152YincNhLiH0KAfYMEeX
	 1q1MYJBoWGfumqOq+Fwl9Z7U0jMqL6fIDKHqW53bEPHYDP+YOanNOKM78qoFyOUY3f
	 9DhUCSyse16hlGLotr20rZXp5fj69tYkSRCAWmGHF5/G5CBFTyGop+6X+CTlYCN4MY
	 sVTpDtefpUI8g==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EE5F23782132;
	Thu, 11 Apr 2024 11:43:13 +0000 (UTC)
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
Subject: [PATCH v2 7/8] dt-bindings: ufs: mediatek,ufs: Document additional clocks
Date: Thu, 11 Apr 2024 13:42:59 +0200
Message-ID: <20240411114300.169055-8-angelogioacchino.delregno@collabora.com>
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

Add additional clocks, used on all MediaTek SoCs' UFSHCI controllers:
some of these clocks are optional and used only for scaling purposes
to save power, or to improve performance in the case of the crypt
clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/ufs/mediatek,ufs.yaml      | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index e2c276da3f2c..21b038db100c 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -26,11 +26,23 @@ properties:
           - const: mediatek,mt8183-ufshci
 
   clocks:
-    maxItems: 1
+    minItems: 1
 
   clock-names:
+    minItems: 1
     items:
       - const: ufs
+      - const: ufs-aes
+      - const: ufs-tick
+      - const: unipro-sys
+      - const: unipro-tick
+      - const: ufs-sap
+      - const: ufs-tx-symbol
+      - const: ufs-rx-symbol
+      - const: ufs-mem
+      - const: crypt-mux
+      - const: crypt-lp
+      - const: crypt-perf
 
   phys:
     maxItems: 1
-- 
2.44.0


