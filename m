Return-Path: <linux-kernel+bounces-32901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8328361AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4803B28F69D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA0344370;
	Mon, 22 Jan 2024 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jriKl1Z0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158343A8C7;
	Mon, 22 Jan 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922299; cv=none; b=r8SE2WLG64/+vO13Vu+5LAu3g8eMBg2BujhfFpc9Xmm0x37ro8SsA//bZLJq5xS1uM2QiiQqLrBYtB83y21T3jkG0BI9dkosawk3StRm2ljXFhtH9j+c9RkMicLK3kE8Fn1ln3EXd+ddyvWXcy1ih79aeH4KVDLqE1qLxS7WhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922299; c=relaxed/simple;
	bh=vMwa77UO4uFeclhllLNti7h0zFg4x5xedkwHOsvwIW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pieoMB312nOSmy5vnH8J+wSmCnF4rsyM+1kEVY0Dn3xGCCveUADKiwtXQMEPIuSVLSEL+Wc+4Gr/GUwEAKhipfzL4w58EcDDo3ZwdFr6x/FRCSCQ1UuJvXxrLsCidA4ucg/q7FstOhQEU0exsnhJGvv4aBhOArNnZQz7AiQmFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jriKl1Z0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705922296;
	bh=vMwa77UO4uFeclhllLNti7h0zFg4x5xedkwHOsvwIW8=;
	h=From:To:Cc:Subject:Date:From;
	b=jriKl1Z0lFRP7Vj045GQrt14Sk0lUooKDfd47uejA2xDlo+LPom7GZyRlVej5ey7x
	 az3sE6ZS2UPo6VHkjCEbwKYk6hGAQMhnwVNQWAQJXWFwYTmC53IwSNqD7pBPslIS2G
	 IoQfCEmNX64nAQD51BRnnWBlPI0iaC2Br/FWDl1V5Rv0mYYy5KmHnQC5FUUXZiaQbL
	 uKpCAkl5qP0I69i+EkFoBqVDez/PBJ1ATHzY5y8elFXaLHibfMVa5ZlVvMl0jf4BcZ
	 wpQy+mIg/6RNbhwLSfgSc5WeZ/U7Kym3itVm3S3azykvinMnmF6Vfc5rzS2bVJjWe3
	 nIRDs4eoU91jA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 60C7037810CD;
	Mon, 22 Jan 2024 11:18:15 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: mtu3: Add MT8195 MTU3 ip-sleep support
Date: Mon, 22 Jan 2024 12:18:08 +0100
Message-ID: <20240122111809.148546-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Of the four USB controllers present on the MediaTek MT8195 SoC, three
of them (0, 2 and 3) are behind MTU3: add wakeup controls for them.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index a59d91243ac8..d4e187c78a0b 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -185,7 +185,10 @@ properties:
             2 - used by mt2712 etc, revision 2 with following IPM rule;
             101 - used by mt8183, specific 1.01;
             102 - used by mt8192, specific 1.02;
-          enum: [1, 2, 101, 102]
+            103 - used by mt8195, IP0, specific 1.03;
+            105 - used by mt8195, IP2, specific 1.05;
+            106 - used by mt8195, IP3, specific 1.06;
+          enum: [1, 2, 101, 102, 103, 105, 106]
 
   mediatek,u3p-dis-msk:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.43.0


