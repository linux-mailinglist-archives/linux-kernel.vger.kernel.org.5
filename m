Return-Path: <linux-kernel+bounces-112868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB7887F3F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35451C210CF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217151C6B6;
	Sun, 24 Mar 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1ynWDGC"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54291CF87;
	Sun, 24 Mar 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316656; cv=none; b=D7IJO6DROybh1uFsIxl1GplIW0emKjzW4T6L84VyD1DG94/oIkp5ELcEeE+qVh1JXXEWI95osoidAI70CcsWHzYxpH3qN/+PqGVhalkHpO9Op6pU/I+GS5gG3kZb/nVtD14hc7WYpJxDOrS1oHov6hIFGSNtH0qJIlDoR0uh698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316656; c=relaxed/simple;
	bh=buC834cJ5PGo5oJchUT2YLg1bsBnkAZ7cjYXTU4h5o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g5U4H0tdvXumnFF0Z21Iwkvlhk9iwga2AgFBcqlvOVpiLisJYimkDX5u7ny9OHKmWRPkdijZj73+kYbPxhwZNE11YyTn6ItbFyq/9MvBMUZ3rUbQkpyzInYOInGuF6SDarXMX0YVNXUtA5nb6qv4YWtygyKDcTkpzKFF/ouGAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1ynWDGC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46a7208eedso514576266b.0;
        Sun, 24 Mar 2024 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711316653; x=1711921453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTZA9pQL+fXB1waoY1qk23hB0BwT+L9gfxhygtEOxzs=;
        b=g1ynWDGCQZRWcUl6fx9NBn4CWJRiXzi8sT2Kyk3ThZ/kwQlPLrtJBoT4OS03vv/IDU
         FfzKFltfk6V2k4vWcv9Wl/S4KiVDwADf6wcUnmyYiwf2puD/SntB4xEvte1dRGBuqRFm
         gL6Qr5zgHeIraYe5trgBpu64i6VW6u2meLME64sSRj7I2K0LXHeV9qIoB/SWVO4UpCCu
         C9J0FndTq/c1V7iQcPcumn7bKUUz+PgJBzvHYD/E6WRhrUPDXVq2wTQbIXfa8rh12+m9
         EScL0fWMiMgrbcNn1SCuJVL6DiN4pJ3Fto7nBzVNP676fqJoq1QDmDrRlkOqM8B+tN2O
         3Aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316653; x=1711921453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTZA9pQL+fXB1waoY1qk23hB0BwT+L9gfxhygtEOxzs=;
        b=stRBU2pZXrHQsVvNwhlGFj1u1MvYY3ea3Q5eqj3vg5ITFWxRl+37fcrTjezV9oHnlI
         wkM5a7u6uy80/mwCLoveHDYMXARfyOIl/vXYdB4ihrQ0E59uJHOURrfS/7YdeIKI854F
         vKakBIEL0UWPiZ3YgsYzwkdurv27OQ+1YCsu3hPVTg7vut2CPWDGqGjjih70MCkSL6Vy
         bbLDJ5+fYlwGDzCaf669t/2avoGrCKEPWDAN6BrnWrpfCD7yS+YJbGsjzQKpPU3bj13s
         H5ZS739IDC3rNfAlSHyv4L7kVUOZDPKxuBcXViJOOELjPSKRdbjydLmBnjMZn1ZOClrD
         mpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpVNoDl/h1MdrP0XCzWQBZbYYrVrBxiCD7wyj/AglPwBixAM+qALRx45fGZGxzVECXHmZlstJBNpqft9EkkzuM4jElA3bGZEbje5ITQX8DT9r41wqVz/TYJl3KYlKxyIW7+ZG5YILHFv89niagujgqKs0pLH2NuDWufa9DcZD+tguokKHbw7hE4OBvTHEOYS3AiqBjCVu6HJHtUcBLhBcJ4A==
X-Gm-Message-State: AOJu0Yyec08OW8NIa7+vS4sy4xpma9n/U1vD8lypzD468eUTWLimOUBG
	v8xrmYowOwd3e8XGfrt/IIEZoNlIa4BXoblEBjVI6CsDyc925vp4
X-Google-Smtp-Source: AGHT+IE9FXnBq5KWK19yRUIBwOEv5nthjfX/jxJUSlivRE6Bipyf5RuLBU+T5hmYyk8LBrVc3TUwZg==
X-Received: by 2002:a17:907:6d1a:b0:a47:4862:7fef with SMTP id sa26-20020a1709076d1a00b00a4748627fefmr3466569ejc.76.1711316652837;
        Sun, 24 Mar 2024 14:44:12 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::2043])
        by smtp.googlemail.com with ESMTPSA id w17-20020a170906385100b00a46d8e5a031sm2327542ejc.209.2024.03.24.14.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:44:12 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: arm: fsl: add NXP S32G3 board
Date: Sun, 24 Mar 2024 22:43:23 +0100
Message-Id: <20240324214329.29988-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240324214329.29988-1-wafgo01@gmail.com>
References: <20240324214329.29988-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3) [1]

[1]
https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..23bf1d7f95b1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1503,6 +1503,12 @@ properties:
               - nxp,s32g274a-rdb2
           - const: nxp,s32g2
 
+      - description: S32G3 based Boards
+        items:
+          - enum:
+              - nxp,s32g399a-rdb3
+          - const: nxp,s32g3
+
       - description: S32V234 based Boards
         items:
           - enum:
-- 
2.25.1


