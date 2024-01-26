Return-Path: <linux-kernel+bounces-39771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41D83D5EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC4B1F281CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51D823A0;
	Fri, 26 Jan 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Itne4E/U"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3C7F7F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258300; cv=none; b=GT5NnKC6X1BbhTS3vBWXL+TPP8Y0Czp2qyBGkv21hW8zxJ1r7oE9U29nOgpZGwwPk9Tb5YUbRwWXV3Lj282gk/r5OoGfsEdKOHE2DBw2xx6+9xKeVxMk78IoRbcblE3PO0gtuc/s/LikDoTxQSgXKVgpbassQQtbFqwFlR+noOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258300; c=relaxed/simple;
	bh=UqrS3dVMO/6GnZNzZMI5I26QwPpIldmkuk+o681+rv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+QwXUaRp+FKgRBxcaQkQ61Rm74RB98ksxk4eWmrnTGHj9vouFTDN0V6Ubn30xQfgekH9EBAlUUWiLjlEgSC/8tTRTKVNvQfoOeuRDxIZyiUyXCFHZPgGllhVuz+uV3bGmDG8PvP9QqEJE5SySsXpjfd7a68KGEwNVb76iOKC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Itne4E/U; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d76671e5a4so1024685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706258298; x=1706863098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cogi64Y0F2tp8CwfE9RTV56n6beiSf1YYbgAclTRDJg=;
        b=Itne4E/UMs6JehpvFBIv1D052N8heeFdKPO8fkHQgTogZFQ4mt2kH66O/8m18SUs6L
         /Md0F5IPQLkjwuThF7b1ZLsKWDfJPQF1dhdt/8LdEv70VX/7kIBp3aqhfkhM6yRjU180
         oy4jNAnUmTqeSwnT2pdhB3LSSZN5SUU2DI1Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258298; x=1706863098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cogi64Y0F2tp8CwfE9RTV56n6beiSf1YYbgAclTRDJg=;
        b=N0m9RHK6QROqjN+klsYhSo5wnfjxA3Z9DjIl8GwfLTkHXuoVJSEGIAdv1JmYAtCG2Z
         SoxGjbdSAqIEMdGD8T6ylFHmE/XSNVCDUc5eEc888YJOe2URjU6ta1mVIZtmM7I+gQjN
         1XCRgNvNNsIaMrq9jmhAAMERj/tZelmAf3OCqdXF/81D1gk8KQaeOW4CFcGezFX4IMPK
         IRPUcmQanTIUeXNtXcPmJDnOo/MvPCsCQVcIwAl79g7VNYtQA1f2+Q81jSlcHLo4SZzY
         Y23vHlIM555nLE+NgeixsxJY6nqOjhAghx/hX/i2CvsLbkiEZlT0DZGp0rM+DxfrmO64
         CYKA==
X-Gm-Message-State: AOJu0YyFTMBBU2S934cuOP+0R/23SmSwRKhk8QujQtjMFLPbHoDWa9e3
	nKuhNR7rudZ6L8AkeSCi1KCqKWFNK33uXFz3vPjV02d4/mX7oyc59Osxu7TrxQ==
X-Google-Smtp-Source: AGHT+IF0U9j/ZKLnUWSANBPy/KQZ3zWCgPlpALjoSGydw/Yn0Zd9JE0GDdtVYJQnpHfDdP9rJ6bjKA==
X-Received: by 2002:a17:902:ced0:b0:1d7:3d44:7a0e with SMTP id d16-20020a170902ced000b001d73d447a0emr1181869plg.11.1706258298357;
        Fri, 26 Jan 2024 00:38:18 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b001d6ff1795aesm589529plr.8.2024.01.26.00.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:38:18 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel / Tentacool Chromebooks
Date: Fri, 26 Jan 2024 16:37:51 +0800
Message-ID: <20240126083802.2728610-3-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126083802.2728610-1-wenst@chromium.org>
References: <20240126083802.2728610-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add entries for MT8186 based Tentacruel / Tentacool Chromebooks. The two
are based on the same board design: the former is a convertible device
with a touchscreen, stylus, and some extra buttons; the latter is a
clamshell device and lacks these additional features.

The two devices both have two variants. The difference is a second
source trackpad controller that shares the same address as the original,
but is incompatible.

The extra SKU IDs for the Tentacruel devices map to different sensor
components attached to the Embedded Controller. These are not visible
to the main processor.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes since v4:
- Minor: change "touchpad" to "trackpad" in description

Changes since v3:
- Collected reviewed-by from Angelo

Changes since v2:
- Picked up Conor's ack

Changes since v1:
- Reorder SKU numbers in descending order.
---
 .../devicetree/bindings/arm/mediatek.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index dd5240b03d6c..d9fdc1196b10 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -235,6 +235,32 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402F)
+        items:
+          - const: google,tentacruel-sku262147
+          - const: google,tentacruel-sku262146
+          - const: google,tentacruel-sku262145
+          - const: google,tentacruel-sku262144
+          - const: google,tentacruel
+          - const: mediatek,mt8186
+      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402F)
+        items:
+          - const: google,tentacruel-sku262151
+          - const: google,tentacruel-sku262150
+          - const: google,tentacruel-sku262149
+          - const: google,tentacruel-sku262148
+          - const: google,tentacruel
+          - const: mediatek,mt8186
+      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
+        items:
+          - const: google,tentacruel-sku327681
+          - const: google,tentacruel
+          - const: mediatek,mt8186
+      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
+        items:
+          - const: google,tentacruel-sku327683
+          - const: google,tentacruel
+          - const: mediatek,mt8186
       - items:
           - enum:
               - mediatek,mt8186-evb
-- 
2.43.0.429.g432eaa2c6b-goog


