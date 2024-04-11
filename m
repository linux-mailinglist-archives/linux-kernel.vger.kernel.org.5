Return-Path: <linux-kernel+bounces-140087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241B8A0B44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4295B22831
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13B14600F;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JkCmh2ee"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC314532C;
	Thu, 11 Apr 2024 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824325; cv=none; b=TH3eZsIoOI9uIXyAMTogNR9HWE5yG7RsD1iZu+JZFR4ufaoIlgx9BPGnd4J2GehJ+4bqLJvSTAPA1CMcCPvq4bGinKdmmIbpbfrEibXUSUQ2915sfdJAZjN1T0v6xfWaY/2HIMFHOYoMI5+dkVmBl1JFLy9fmgG2wu0jicd48nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824325; c=relaxed/simple;
	bh=XK+I2rHX8gkIddpwg379tC6deWLfihQGpL9it+LQ4dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRRhbNJAXwUbF1yptXhctEZAvyJGmsuclmIeltAYshdHajLaKvImt31usyggRRxOLDMNdnjD86vNgf+HqHN5rm2Z8iPFIs48SpNUDrBSEAi7csP1L7cuS84arGkcyJn4JCgMdDbRuPJ1UQY0dP7gnOSWFkRbUiOllsnCsJ/RHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JkCmh2ee; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712824322;
	bh=XK+I2rHX8gkIddpwg379tC6deWLfihQGpL9it+LQ4dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkCmh2eeCBX4DHpZmQp29q2isI1K3aQlJh5Cj03+1k9HcQ+ECwwStpNJ7wger2CtD
	 w5CdrZ5gOg8buDDe/7hXusQ/Q4Z6m/aPND7t0ozlgds0X2DNu+NUHfyNOnEa6qhqbw
	 /2cVEWaNbt0PWsUkWI+EdrT+k1VkXppQO59weIRZSX5uDaTOxuBbYmKTfH11Zqvzhs
	 LK0P3OWFxkduW1O9GWr8nzLkqqIDWrdoQC4zOKbdc0TN7eeVND6goqRUSfg63xLly3
	 Lmw7L30sqVoSbLoCn0MdjKvyBedpYrnMcvWRkpcwvy8xXqlcr2NbNK04oX+EZrZPu7
	 /rI4dslVa7T7A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 309B43782135;
	Thu, 11 Apr 2024 08:32:01 +0000 (UTC)
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
Subject: [PATCH v1 6/8] dt-bindings: ufs: mediatek,ufs: Document MT8195 compatible
Date: Thu, 11 Apr 2024 10:31:47 +0200
Message-ID: <20240411083149.78537-7-angelogioacchino.delregno@collabora.com>
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


