Return-Path: <linux-kernel+bounces-70422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D988E85978B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0C8281B01
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1CB63126;
	Sun, 18 Feb 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pWqN+LGE"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D591E861
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269243; cv=none; b=VB/nv43IO6BVNeymjjKhw1PPMusyoKgajfxgDlj0DxhZ1p/JDu1ldyNfdyJdH/ekB3xCuU2fxeOQdXRGG43cDyKbg6BeSM9BGMs1lVvlHkEOy3NbzzgWZqznKka0qS9O4WIMaA2nHEX2CmyIHXxxd5UTvIgpXqReshFfKlrDroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269243; c=relaxed/simple;
	bh=2RIlqLb6lOMD1KN12T+mtMdZ8n+dOn+rgY+MsUEh6ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e3lyp9mXILbKPp51F2r3DunA0rXMOTBBY+fsxGyGn1uVc9ZmIkiArLNNL1qWeo4FYSUcFWUJ9fbmu9+kYyadgjHehSgWXMHsYyDY3txwplZMZy7Hu/4m0icNw57mI2RAtOfmYDS5YOdpcIRa5q7N3o5asTFqxmvaENpVDrBPQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pWqN+LGE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so16688371fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708269239; x=1708874039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO56vYs8Z41/vI1Yt38AdTk/YbbFf9TKPY/0g1B0V7s=;
        b=pWqN+LGEhmkHJmXsJdq22uep9IeoMne5ApIQZa6BcigN2KG1ScEgn9PLWDUp0cU/hs
         DnJBoh3bWo1PGiSXRuH0CUAQSGuRkeu0xPBZOItQTpTneAa5RMtRfE830RP9hjAzyQWX
         qBlfuMyQfgtKisMigFq15TPZlgs6idxhH2D++D1OF4gIPU4nwFLWZ39qBzMockFy193z
         4cJB34y9nKhlwmrqS/WVY0Se8yER6o/f61veIlzVaPAHd8zaqVy1aTeMcm8O6+ezHAmk
         R5TSq8Vjtq1Xagz5TsfaMZw3PZvhCJOgRceR+1/gbuEGMdK/LaqYr7yp4zXl2LmKGZ5V
         A8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708269239; x=1708874039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO56vYs8Z41/vI1Yt38AdTk/YbbFf9TKPY/0g1B0V7s=;
        b=BxJ7yn2R0xMhdlgRfxWXeTvhkr06m0IsBL3z5ggmXEYEgUcYtykDBTNhULG0EFkV9y
         UNej1Q6D4xIqQzabJWIHCuCnXxTG4uX/qcOHpGyTe1Wq6Obms+Cp2vwY3el9i2tXEZUe
         k1zxSI7X55SgH/b2Y0YYYEp/IZMqwSuz7h+/q0qe13D/6bdVUAnqaOauFDwuwN9Ng6He
         98orM1y7kEagclsQ8eSmNWRhv4BcJ9VtzgJWBa5d2mQ0iwvYzceGdLQljd9bpR2yQKxL
         wqKtHiK05sEy7FUZBlCTsS+gCNIkns2XlGR5nUT9gpBNvvCGoZ+2oFvmJqXhS2y8PhT9
         irhA==
X-Forwarded-Encrypted: i=1; AJvYcCWa4HKjaOyvJVLbZaCE6Xm0k1Af9+B7tNgocUNQTkK8RsCsYjQgkKrNcCKwC2XiM6q42NRJRrwjb9hmiAPTvi5EtLUvefY50JtPOTLa
X-Gm-Message-State: AOJu0Yzlp5nbX38dwvBG4QIfT+gl/Ma6jaLIMcbZKHVehl3r0A3Gw9qQ
	F24IdLKkajMX/WlenVmougxf6ztYAYOPqN1/nERAs1wCkpBkS4Le3u1fp0+SoRI=
X-Google-Smtp-Source: AGHT+IGbTfCdD6l7YNLzxHRVZ3Lq7dABvgdcel/C4kTR/bFTGrSyBYIzMItjz8BjQvi+mjuH4un6hQ==
X-Received: by 2002:a2e:8e82:0:b0:2d0:f6cd:8abc with SMTP id z2-20020a2e8e82000000b002d0f6cd8abcmr6031430ljk.12.1708269239473;
        Sun, 18 Feb 2024 07:13:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id bu19-20020a056000079300b0033d3d9447e3sm2150744wrb.83.2024.02.18.07.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:13:59 -0800 (PST)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 0/2] ARM: dts: microchip: few DT cleanups
Date: Sun, 18 Feb 2024 17:13:51 +0200
Message-Id: <20240218151353.3612621-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Series adds minor cleanups for sam9x60 and sama7g5.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  ARM: dts: microchip: sama7g5: align dmas to opening '<'
  ARM: dts: microchip: sam9x60: align dmas to opening '<'

 arch/arm/boot/dts/microchip/sam9x60.dtsi | 64 ++++++++++++------------
 arch/arm/boot/dts/microchip/sama7g5.dtsi | 16 +++---
 2 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.39.2


