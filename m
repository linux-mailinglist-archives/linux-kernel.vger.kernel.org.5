Return-Path: <linux-kernel+bounces-140366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B458A1366
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BD31C2083A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2314EC79;
	Thu, 11 Apr 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NTU/yLSR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47314E2DF;
	Thu, 11 Apr 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835799; cv=none; b=AOJI0Rva0nxsvDOnhjrMhra4E0cYhbMLZ8iJuTz2t/ka61rmRX3OBdORZBHcwjohWZdhbBmYYpFnoYb8bwK/iI6eWp4pSzmT/WZ8FKqPPNGstkOTu+m5/+Nk9ZfANu50EDPBQwOwvaLd84Y4dMjkLw1w9XyXPgB/L+OyrfAk9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835799; c=relaxed/simple;
	bh=sY1R1NA7jkwBIAVzv78scvrc0A647hsvQsRji2DzXiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsHKHhQW2jbuWQidIP9mbwKsFlav7X5jTgRposfpDnumBajUyMrq9zzxROQixPYV0Wl10qqGJeXgKmEEDTpM7CzhVcPvg/mxI73z7g5MnOLwdX9IfK3MqVFrZVgbcFE7vGw2dGi3JOg+qv/6ZkT0dXvEgLO33kk/joCCjKQBIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NTU/yLSR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712835796;
	bh=sY1R1NA7jkwBIAVzv78scvrc0A647hsvQsRji2DzXiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTU/yLSRChU1zIhnZbUUml0WZdVLgoejrrSVR3AU0ddhtd/S9/YcYop24AImmyCBT
	 CYe6xH1a9bfKr75uwRS2wj8QZElrX3vRCrbnjTpXXPiQ8fzR+2nwcwcxJ5SzjlA6LE
	 oMyV6N9SxCJWRvOq/mqkpjvM1I/oSFcH8ZRiQcaFoJBdPTzoem42DWzsLQagXWZZvt
	 YSZwAYfkDiEZSrffIsCTn6SKVDGzeQleQUxyPTraenVcVyOpS6N37k7NywzrIQDChC
	 GQBnPlTK9HZ949+QHTPTfIpljhcyOm5LLDhJ3TVuP66LeJW5Rv3l6cjQx58ykdlh8H
	 vttgvk/q3N9Ig==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5525E3782134;
	Thu, 11 Apr 2024 11:43:15 +0000 (UTC)
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
Subject: [PATCH v2 8/8] dt-bindings: ufs: mediatek,ufs: Document optional dvfsrc/va09 regulators
Date: Thu, 11 Apr 2024 13:43:00 +0200
Message-ID: <20240411114300.169055-9-angelogioacchino.delregno@collabora.com>
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

Document the optional dvfsrc-vcore and va09 regulators used for,
respectively, crypt boost and internal MPHY power management in
when powering on/off the (external) MediaTek UFS PHY.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index 21b038db100c..2ee8bb7d5aac 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -50,6 +50,8 @@ properties:
   reg:
     maxItems: 1
 
+  dvfsrc-vcore-supply: true
+  va09-supply: true
   vcc-supply: true
 
 required:
-- 
2.44.0


