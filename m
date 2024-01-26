Return-Path: <linux-kernel+bounces-39773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3205283D5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F90285B03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2C86130;
	Fri, 26 Jan 2024 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jlAqrquL"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA3685C60
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258305; cv=none; b=c1PsfEkYXvGw1YOCk1xTUEPb/2TZZ5ZS55MHoSDHJMdktsAftV2xWdsnLphSpSgZdgquEPfp/5+GZd5Xhn/izgXufLI2n6/DH6yWLFOwI0ySBxpQ2oE6TUZ4NxHVN7xdJEftDMwCgbdwX4r7y7E0DFkquTCzQBZQbn781rFd+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258305; c=relaxed/simple;
	bh=HDrHr2Mm2RpUpCdp9W2zvjhFzmQiCA8tVkPkSw8UHGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbWhAS5xaBGdUh0vtbfiyj+2aJFh6YSmPU0W5Dwtu0dANltxt743Y2bxOQOv0/x0jSafJgO7gmQXHEr4yNhI4+KagC9ra71nZfpyKvlMPOxAr/lEulqHqQGRsiodfFJksHQ+iolayr64wSLYl+dCfZbHPxi9IVZyGF+m4UCX7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jlAqrquL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7859efea5so3472915ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706258303; x=1706863103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKzePUGiZpVCb+bUEgD2WbfAbzcapL4u7uh81bBR8VA=;
        b=jlAqrquLZ5x5UWtFjyvRkbPtjEh11wuuxgodyI1cVXF6u11qE0DDznQvgZXNJr+/AL
         zr5rA9WT7x1EeQBbEpvpkEUxvFEqb7AxGsNoPhV5Md3mFz4XcskSd93mAJE3rJTe9DiH
         BaIyYcNGcDl3ONSStilv7NCc9TglF2a7NBMrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706258303; x=1706863103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKzePUGiZpVCb+bUEgD2WbfAbzcapL4u7uh81bBR8VA=;
        b=XL4DFOSHvFgtHkGJh3LQ45NJ7SQcJXnQhsRhHyvknIxi+dK8r9B8o3CIJraVncToGu
         YTxhbdtkKgUy1Xll8K0BhGv3NWUJLTx54SVuoet4Vr668H90FCu3QAi5Owrw5nTP24UK
         KNX/UHhEfZcAQBH8avwlvY1ScRjnXjOZvO6Bvm6Qc6M/jbeE+uuEnXpa05X9874/hbwr
         CWKiaEBK08XWXCpkR17y86KHJMOMC7+HOJmLlJHV3F+5WPC2gk6Ewbko+ZgA9/merBYM
         Z4f4bGe9LfxL5vbtf2o9gPRv/38+KfptJkslA0yvlKSSZcJVC5ArGUF3k9Xsn2Q6Pamj
         NwOA==
X-Gm-Message-State: AOJu0YyF5blwh9n0U1QXX4Lmax5wd02CCqlaa8qGkCBu0y/3LMznqh2a
	DSuHwbZwAAiyUrbzSsEJffVHoNqITKCNBYIXdalur+HsWCqCo5Cy7JUCCEIsVw==
X-Google-Smtp-Source: AGHT+IGoX96u4tjHCtE1Z/7U5hmcjioZkWhGRLyo7bwfK9lQa1gK/mT/fr7N573TKumHNoAFPo3xfA==
X-Received: by 2002:a17:903:1c3:b0:1d7:2817:a63a with SMTP id e3-20020a17090301c300b001d72817a63amr1016382plh.19.1706258303293;
        Fri, 26 Jan 2024 00:38:23 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902a9c200b001d6ff1795aesm589529plr.8.2024.01.26.00.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:38:22 -0800 (PST)
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
Subject: [PATCH v5 4/9] dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
Date: Fri, 26 Jan 2024 16:37:53 +0800
Message-ID: <20240126083802.2728610-5-wenst@chromium.org>
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

Add an entry for the MT8186 based Rusty Chromebook, also known as the
Lenovo 100e Chromebook Gen 4.

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
- Reorder SKU numbers in descending order.
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 23acfe5ed940..385bd2765626 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -235,6 +235,12 @@ properties:
           - enum:
               - mediatek,mt8183-pumpkin
           - const: mediatek,mt8183
+      - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
+        items:
+          - const: google,steelix-sku196609
+          - const: google,steelix-sku196608
+          - const: google,steelix
+          - const: mediatek,mt8186
       - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
         items:
           - enum:
-- 
2.43.0.429.g432eaa2c6b-goog


