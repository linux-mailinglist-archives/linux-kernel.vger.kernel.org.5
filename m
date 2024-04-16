Return-Path: <linux-kernel+bounces-146189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D48A61D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEFA1F23A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01B22F0D;
	Tue, 16 Apr 2024 03:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1mRn1f8"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47320317;
	Tue, 16 Apr 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239271; cv=none; b=ENI5qsvvdFGeWIeDdEaVy9L9ynG2Aq4D8XLmDqonznI/2wv2wH7UW6fdsksGTQriiWylLyQ8UZFu2gKo66ZRgB6xzwziOGbJh6NjUhR43XmwY80OFuHY6SZRQYo+TqblRKCdazVk487HChwe1IFyka89nffrBHtnEdmfhMjZOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239271; c=relaxed/simple;
	bh=nE3yJuMkAdOlRlVY8wIVjXUHI3A8rjm/f6MWM5egj6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDMuc4m+XpT4P1mvq24Sdq2KxqF71Ynsn8LZSppbaegRdPAB0l0KPejTCaFGnmpcktgAfon8jSV8JboLzcOZFJYARGmyG1YqvUZ6cQpE0FTBCVU9+/bpF6QyV60LAffLiePN55KuZeWY8LIZMqL6Z7cucXLdwzYcP4G59/qA1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1mRn1f8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a5215314a4so2307947a91.0;
        Mon, 15 Apr 2024 20:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713239268; x=1713844068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST7IBP1G+OA+O25mvhaCDcJ5UjWGi92SIHIsGwEi/5k=;
        b=k1mRn1f8NrGAKdXtCp1qrDfWvPOCfRgLOhwKZbwxBLI3qA+ofTXuflCqsffyzRMQZM
         SrQcH26jiVwjocM6z/gMcwEJoTTUCxZ6vnbElQe1S/gN5vCUr5fP/LAr7cgQ0q8rf62j
         qxTheRqA/w2zdeyobkqLsS2N+AvIJe9tTFSRsjoilt9E1ELWRbbzM+CDNjvBYvkNWQD0
         kijfymgo6tCkkD2uIen/NphqSaLeTsWSpW8iVx3u4tKXAeVk+/FFJh/fHtu4pHXEuI4o
         0o8Fmma2DT3RB8N2/y2IvV8JA8W+bh43KDu61q6/+8BSuT+IkHw7Fyp14kwJmmaCdWqi
         XeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239268; x=1713844068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST7IBP1G+OA+O25mvhaCDcJ5UjWGi92SIHIsGwEi/5k=;
        b=JSJ+kOOtqlR0L9gOiL0x28MgOy/WacSXayLXx2mF++bq7WCbAWxXUJQKFwa1kASH6d
         bK1pcfOXlRmdGeuqvSdhLI2igb868T7cKsdvS+TcIa1Vt6l2w9vdjWwRxXt3tizYuMCj
         BabSrjiY0Hkf3rsRQ4/y1cSitG8SQoVJSCxjxxWpm0wwX2qj6pTWZ9q8h3tW4kF3+0rv
         LwEgbYMwwx1FgRckdDBpvDnbEKkRvU3c0+IkjWKr/3uoTCh+eHl4rOgg0ZNXZ8vrQ6gV
         stxy/aQVvhtu8ORGmccLJrlcMyeaJqlM71TGVTe6MJSV7OY2aagsSekSdH2SXh5HD3Yn
         CqCw==
X-Forwarded-Encrypted: i=1; AJvYcCUwNi+CMJjGo1SLJ0j2Cd8ERoMbjXBHx6LYjfiQ3YWgASrDcVDNIjmtJOW+v57/OfhkUxJJu40cFh2BtVj3Y+vK/zFcpznToxc117uL
X-Gm-Message-State: AOJu0Yzz+MeyopW/OQwDERo7TU5U/ukxP5MnuMJRyavtR644FmWJbuhN
	QLNdxIi/0wmxI5KBJCm2ej6hDOUX+s6mry69ejSZ88eLsB4BSHaRfRl+CPBmcXI=
X-Google-Smtp-Source: AGHT+IGny5bC7Y3tJQxKz4CiTcluG91UQ9fL39+yhBEESmg70qqMHWQqyIoMaVHKhBiTyoXGquRchw==
X-Received: by 2002:a17:90b:4b4e:b0:29c:582d:bade with SMTP id mi14-20020a17090b4b4e00b0029c582dbademr9322115pjb.2.1713239268281;
        Mon, 15 Apr 2024 20:47:48 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090adb4600b002a51dcecc49sm7748815pjx.38.2024.04.15.20.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:47:47 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: arm: rockchip: Add ArmSoM Sige7
Date: Tue, 16 Apr 2024 11:46:25 +0800
Message-Id: <20240416034626.317823-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416034626.317823-1-liujianfeng1994@gmail.com>
References: <20240416034626.317823-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for ArmSoM Sige7 board

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4bd033ade..fd644e32c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566
 
+      - description: ArmSoM Sige7 board
+        items:
+          - const: armsom,sige7
+          - const: rockchip,rk3588
+
       - description: Asus Tinker board
         items:
           - const: asus,rk3288-tinker
-- 
2.34.1


