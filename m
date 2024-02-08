Return-Path: <linux-kernel+bounces-58747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136584EB00
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD796285A66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20F4F60C;
	Thu,  8 Feb 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux8XM/HR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2A4F21A;
	Thu,  8 Feb 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429577; cv=none; b=oTfBwVeboL64phwslwy7J1StCXro7rD/9eC3k5pxwOtOcWXCMGqSBMxTqCrQX7etISiGg/AkgOpLnhYU1bWJtB6+6xLpE8V+gTE91yzPABA2se80wGIigcbR3gByiO/C9QXHQXX54+stjE0N5E6wGo6CsjDgGD6aiRKmRyfWcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429577; c=relaxed/simple;
	bh=uHyXa92dUIhERG1ew5gLbhZiePw643woFrYt8y0H3do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dUDEPeCi6YH5q58OhAyEhhs96GZ3adzn9TjA9SZWoAX+4xx9GmjYi1M0iaFDaNUM6C1j8bRSllR6E5OOqkmNhdzeLqeNm5bnGJtGy5a5AgqnsVRMRofxJ5MSfH0uFy5qhBuEcoP8X8Y/q0ZlsnQwruLYlvIGruP0xDLMRNYSuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux8XM/HR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a36126ee41eso38747166b.2;
        Thu, 08 Feb 2024 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707429574; x=1708034374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVepR+rGi9qP7QecZrVNZGxlAacyZEcN1GI2ljcPknM=;
        b=Ux8XM/HRLzBSRUK/Y1OSjRgYNQuYdEF7RFjJsAXOWQLtaZT2DJPwuqNntuAyElpZIF
         dlLfJT6DsAEljz/O99B5PebUA7y264vjPI/Sm9fSQP0+wE9F1sEApSFLkS7OjxX6p8Ol
         er70KDKPg3WRSd/oKSKBFfqV1kp4hlg9QLCa837CN17CtZWTOXAGtnhoEIPFDc6NOmVC
         snIR/LchcZeHoZnQeLR6hQJAEtXYIwh9XoL7bs+sBhgOjxRKONqAfJXQJc0n/jvkbmAt
         CiJfo+URgyEfqQT7fbTLctsi5lBrHo8Fh+rgI7YetlTkvSInZBrPDjwqAlb0xgN8ZP18
         CvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429574; x=1708034374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVepR+rGi9qP7QecZrVNZGxlAacyZEcN1GI2ljcPknM=;
        b=aYyW06PJTeweerWkSL50IbQmMSqKjvaxzwIt3JWcf4zFnHwXw9j6gdXjBb+MoZDfgx
         //up8oa0dIPfoo6+1KqBdVDyo6c7CPUR9/Egk3PNQa6oFI9O+r/zVO5iOZkCS192SGyi
         btfweaiGx3GIiKgy8CUjaen54ZYhMV+gUbUs++lXK6lu2Vcw0jJxOF1F1Tg1Qm/coc4y
         oO783jyydusFovU8D0yeoaPMnC/V/iZm4KhlDppYtE6hHUlTefJmlRaixwLsB/v7FugA
         OgHiJnVCgeMdAneFJVBo7gPHQmjS1rgVi6dHrQxoGu2DK6DMbA993EnHnO+efvXI82Gn
         BsAg==
X-Gm-Message-State: AOJu0Yzm8ahNhb7puysph9LYdEBYI650KWiekzsmo8n1/F9+R2j2g4MC
	XyFL0L9KfJZ5aR88RMzvzG6YA+ZMmOr7m6HzHZ2oDs06FEhoYJ7j
X-Google-Smtp-Source: AGHT+IEVbsowZHNTpuOZoU601hiKKk3mWRkCBHnoXB13FY31HnF9RpvsMi6ycgM1IRowDJQTYenTMA==
X-Received: by 2002:a17:906:4acf:b0:a38:350:bbdd with SMTP id u15-20020a1709064acf00b00a380350bbddmr425752ejt.48.1707429573863;
        Thu, 08 Feb 2024 13:59:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqyCuLpoE7cM/3uLYgV4UJ6clpSsEYm9CsGZNT7AzfgdOIJKirfgJjt5TTDl9Q/ltRUhJeYTh5pPtgzcOrivc0ClfGBRijNGIHSuqKR4HnIgGQe1agfegzSFID9YemtwFA6UWyURUCozfrantbxlEyXTO0ZhQreQ2sbOsKiXTcvCZeBEJw5un3ygPl5uEOXbc9RNrRsQ+b5r6jUCPWfL6jYF2SfzkKLdK/2160WkZmrv1wV86qZ6fxVMJCNuTkAP9MaHtPuVe3uqARUqVhdnMo7CbEYVmcU3NC8IA6DmvC9cTUs1Cbt+k3HbKdFzNG3k0MVPD0hoRkCdqCPejsjfqU0yhIcOf/fdvAvJcY2uUVDbxnauh1Cy16FsAAoXwkNaq9Zmd5Fi9hDy5+kMfXAQJEXBTV0guJolL09hmmLAFsd8SsC9NKQc5ois0CmbWuzp5XGBa0zDwwfBGPIlXHdTbkq7ubFP8pAlicSYb5brBE745Ir5uiBAdNI2GuajblMfc3ZVo=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a3743142429sm108255ejc.39.2024.02.08.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:59:33 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 0/3] dt-bindings: arm: mediatek: convert MT7622-related bindings to the json-schema
Date: Thu,  8 Feb 2024 22:59:23 +0100
Message-Id: <20240208215926.10085-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

There are more MediaTek bindings to convert but for now I focused on
those used by MT7622.

V2: Move bindings to /clock/
    Use clock-controller@ nodenames
    Drop incorrectly specified "syscon"

Rafał Miłecki (3):
  dt-bindings: arm: mediatek: convert hifsys to the json-schema clock
  dt-bindings: arm: mediatek: convert PCIESYS to the json-schema clock
  dt-bindings: arm: mediatek: convert SSUSBSYS to the json-schema clock

 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
 .../arm/mediatek/mediatek,pciesys.txt         | 25 ---------
 .../arm/mediatek/mediatek,ssusbsys.txt        | 25 ---------
 .../clock/mediatek,mt2701-hifsys.yaml         | 51 +++++++++++++++++++
 .../clock/mediatek,mt7622-pciesys.yaml        | 45 ++++++++++++++++
 .../clock/mediatek,mt7622-ssusbsys.yaml       | 45 ++++++++++++++++
 6 files changed, 141 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml

-- 
2.35.3


