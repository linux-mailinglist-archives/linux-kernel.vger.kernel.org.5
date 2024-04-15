Return-Path: <linux-kernel+bounces-144960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD508A4D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE241F2507C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9766CDCB;
	Mon, 15 Apr 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I3WUPgKS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E986BB5D;
	Mon, 15 Apr 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178828; cv=none; b=o0GDuQGRLBWaDaldX7LtnG4lr05KVFak1HsBnIrLjBuJH4tlaLeBOmGk/VdHW18/UvvhcTXNSU3fNvx8OfG49RWG4/LcoZbq2dFYgoIalf4wTt6Qhhm452CCBs1uxxSHrHgZUBGpe0g9VpiMhB8+RUCu5buhSw2kGKjcgEw+TGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178828; c=relaxed/simple;
	bh=xXwyH40ijwhP2NEXGOtiRRBM5Db26dTrTLrEXJ0hCJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFiw+cdZNgnamW0ZxSJU5QBAUTUNuyK/Lt+hLY2uda+lzDIoene1i2v6wVvu7+L1WGzNTrwrnz49zHMk/vy+FrJEvXBDMjm2pNxnbVQ3C8lLQ5fXVnojMaCahubQYxEqy523bs0c56UK/gnt5k+Yf7SeUMzK9Xi3sIPc71Yx2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I3WUPgKS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178826;
	bh=xXwyH40ijwhP2NEXGOtiRRBM5Db26dTrTLrEXJ0hCJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3WUPgKS9DLbmHYGZdy2APm3FvTkdX7OIAgwaE0YmZ5p8CcTtE5shJBDwp9hcBrjg
	 XU+I/SDZ4PVbZnhpFbcSoUG+5uZM1OZKGXsNgz85ghPDbW7kvFx9s0u1qlnwHPrMZp
	 wOV5EetbnRFFyFYUOENiatjmickweG0ivDquo74/s0spHImYVb5ngPXXnpCCBHKWG9
	 srDEIaKX64aSpKCWX08LOWxh+l34o41JirDu1HdvMBvLcuCRjvwBFnAOt9vmgdztBX
	 hs44q7k45Dzk3a6AO/CeB5hxjGXXGK9ueHXWwAgtAR68R0P23KhxPd/yN7tWd1U0zG
	 7mCi8Ee2iX6dg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E0E2C3781107;
	Mon, 15 Apr 2024 11:00:24 +0000 (UTC)
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 7/8] dt-bindings: ufs: mediatek,ufs: Document additional clocks
Date: Mon, 15 Apr 2024 13:00:11 +0200
Message-ID: <20240415110012.148871-8-angelogioacchino.delregno@collabora.com>
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

Add additional clocks, used on all MediaTek SoCs' UFSHCI controllers:
some of these clocks are optional and used only for scaling purposes
to save power, or to improve performance in the case of the crypt
clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/ufs/mediatek,ufs.yaml     | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index 5728e750761f..1df8779ee902 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -23,11 +23,24 @@ properties:
           - const: mediatek,mt8183-ufshci
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 12
 
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


