Return-Path: <linux-kernel+bounces-39772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158183D5EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C2A1C2634D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E1B82D9A;
	Fri, 26 Jan 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oI20iQfW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5D823B2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258303; cv=none; b=WqXtRchZGEvdWOd8wuNq7ylT79BSGFlQ5AfG1KR55ntd3w3aXA/tK6ZOV3llbgbBwiOlOQyiep+kbuElFDQ9/zDN8cA4KaoXctWgRfqKrjmM9sN9TiWVi8TnyA7VkR5BscDZh725J6fk83J3c+Mif5C7yjL7Fu+6DRxkd1uLfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258303; c=relaxed/simple;
	bh=LqtmnevtRTioL5+MOiNaOXN+tA7khuWbKstLdYSQFgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBNbq2qAqxuXi0LVBEQc3tx/a5CIz69kV2Pinx891lHUkPcVCXDW8AB2lGGT/irrVmRxSpkF9aJD7ElbM4rPyRYv4tnZlVTtzcFpjvQkzo1XpDVdsYgY/753iFxtHuPgEMl/Q/W7a8fc8YpyI8OuN5NLTHbUysPJ5xmkAKVYXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oI20iQfW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d720c7fc04so687115ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706258301; x=1706863101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oTTl0kuIE0sGIGedIYHJhdAzFdP8/kOBtYd/88i2hU=;
        b=oI20iQfWzNsRzBaonQhdrGF/221IFjzkqHF52fyBlGK/6nniIMHxPgvvKRiwMcd7cc
         Sfd6tCUMzKLV8Mt3W+poJT8UW7jwrlIkdyF4MD+oSyuEQ+/tX/8LO62+/vIaHdqexaVJ
         BNYhvTbetqYnfFYUyOt12oQdKUPE/IDg7FO7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258301; x=1706863101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oTTl0kuIE0sGIGedIYHJhdAzFdP8/kOBtYd/88i2hU=;
        b=fVKWtLsH2FFyni8+YvRaOAxL5D8iV4DqkiWmqNcF1v6VoHPGuXd+hKeUQubaCQ4/84
         E+EGEXHtU0YT7PMdw9Kldp5jdpF2ybWSH9QRJWXOZaOuMjQzBBcJO+4XYKCa4znxagl2
         coy9DXbZFGagB80XobcFy7YBI+XzuFNhsZrFyZYBwSfQgOI7fOcotpwwo3W0BU3djWUU
         X2CCbJym6ihnmKeokR4M8kV3XqRJ9OssU2xoWthN2BRta+2Ym6w3RQWI+5XmqChLo6jp
         y0Ng5ejkYrcjvVwiikwU1wcv3JvEvJIhoI/U/GAjR0/icbYuuaGuEU1czYHy5iioqqHV
         VhlA==
X-Gm-Message-State: AOJu0Yxkrh5SOMTw98B9kRp+fVShK+6IL438TwwCrC7eMAsDnvO494t9
	+8cwHPgBTIan7IMyLLevO6wwSlyDccBjrDkxueAe4Zv+Egvb4gS8aht4Y3I1BQ==
X-Google-Smtp-Source: AGHT+IETHH1fQVURJgrJ4iOrJNkKJ3noS96sIPlIi5X44S4MZUtWIcs1NtUNftj3yuO6DgF0WGtHgw==
X-Received: by 2002:a17:902:c403:b0:1d7:4d4f:db24 with SMTP id k3-20020a170902c40300b001d74d4fdb24mr944475plk.0.1706258300840;
        Fri, 26 Jan 2024 00:38:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b001d6ff1795aesm589529plr.8.2024.01.26.00.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:38:20 -0800 (PST)
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
Subject: [PATCH v5 3/9] dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
Date: Fri, 26 Jan 2024 16:37:52 +0800
Message-ID: <20240126083802.2728610-4-wenst@chromium.org>
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

Add an entry for the MT8186 based Steelix Chromebook, also known as the
Lenovo 300e Yoga Chromebook Gen 4.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes since v4:
none

Changes since v3:
- Collected reviewed-by from Angelo

Changes since v2:
- Picked up Conor's ack
Changes since v1:
none
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index d9fdc1196b10..23acfe5ed940 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -235,6 +235,13 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
+        items:
+          - enum:
+              - google,steelix-sku131072
+              - google,steelix-sku131073
+          - const: google,steelix
+          - const: mediatek,mt8186
       - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402F)
         items:
           - const: google,tentacruel-sku262147
-- 
2.43.0.429.g432eaa2c6b-goog


