Return-Path: <linux-kernel+bounces-30960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC8B8326D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1BD1C22FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D23C470;
	Fri, 19 Jan 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4TpAef1m"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEE8F4E;
	Fri, 19 Jan 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657272; cv=none; b=ria8YcpI40T19Edc20Ta5Gy71hPUDZP3y3ZFka/UAWYlwvpdzEeKkeQxxRhjhh/SYbq3expPhY93OtHzzU7fXrK1o/JFiPVnkRqe6k1rC5On7E8pBv/e3onxm4D4KfIOpDFU/1kybnht79xxPqZitsRoS7h4A9cA12EkTpsr79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657272; c=relaxed/simple;
	bh=0cDiESFvb7qa9miqI4BzCZ+472VCEQGuIk9jkGeCoRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orS3RZ97xnUKvDl5wo5r8Tc4WXciFg0HRmQN4DIyJ5WM54TcTrJmenpqlEKRe5U7j4RT8Vvi/fN6nPI6ZWXkBreToLNded/cPzgBsG+wZ971ZkvruIqKv9N057m+u2V60HCbZsh5rLXvcnZERlQzU6T9fgBmHqpTG4aQyFIqwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4TpAef1m; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705657269;
	bh=0cDiESFvb7qa9miqI4BzCZ+472VCEQGuIk9jkGeCoRw=;
	h=From:To:Cc:Subject:Date:From;
	b=4TpAef1mYqd/vXLVqPxRe+vRI+fmsaz79QlIT5ypjuDI09RFBTsEZM6vwSCyZRpfC
	 JW7ULhVzEtdRVphkjqkhLQpFGtHSXq/e5nbCAbCv//33K4hFSZM9ApTPMwguJ6oVRp
	 A3d5MekwJLbfuZ5xzzPG6GreWj980WVOH86OHxtcMw5ADzYrzGROfjVGSFYledLfQv
	 u7BPKoGXRGUmAU94knmOFR6rd/7reWdgPl3jLGkzRcswBjwXNnXZfpKUqpY6OcpUMW
	 Ffq8KkJ6EISw7LxSVAkMnAggqT4Bw8sfgv9ugvw6GY0OHBbClbDKtGcgR4uezKmaVe
	 HRAeHRMDAhWiQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7088D37811F1;
	Fri, 19 Jan 2024 09:41:08 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux@roeck-us.net,
	heikki.krogerus@linux.intel.com,
	cy_huang@richtek.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop interrupt-names
Date: Fri, 19 Jan 2024 10:41:04 +0100
Message-ID: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This IP has only one interrupt, hence interrupt-names is not necessary
to have.
Since there is no user yet, simply remove interrupt-names.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml        | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
index 053264e60583..339bc9c00ac0 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
@@ -22,10 +22,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  interrupt-names:
-    items:
-      - const: PD_IRQB
-
   connector:
     type: object
     $ref: ../connector/usb-connector.yaml#
@@ -58,7 +54,6 @@ examples:
         tcpc {
           compatible = "mediatek,mt6360-tcpc";
           interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
-          interrupt-names = "PD_IRQB";
 
           connector {
             compatible = "usb-c-connector";
-- 
2.43.0


