Return-Path: <linux-kernel+bounces-157558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3768B12D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF831C24E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D081A716;
	Wed, 24 Apr 2024 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIzsY0rU"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150B3D68;
	Wed, 24 Apr 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984671; cv=none; b=S68Z/CDDFaYQ/ehVGNmjmlUBDATiKLb1cTKXuZ6hg2tbQHuRq6bhL328t9mAbmtvmgBZogTBf5aQDL5Nt4X5RF4vl4X1qKEqjoUCBNu2VHjFy511g1385xpuSZWpUpfhcNzXIlf5f9sP/CUqVI/s5LHbuqU2VRqncdQpKdkzzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984671; c=relaxed/simple;
	bh=SStE9y303FO3ATf9eXjsLwO2XtEcu5VteWqqA950+Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apA02oV5pIRUsN166IstDeiNy1b2xnFfI2KbuxqjIZ+hlbH+KatwdMVh6Mm4GoKpzWwakBaN1YM+RbBoqgCuDyvIP/fX8S+coDEVm/vDyHvhdPUkgx1pijwaU/Fze/PJK+3MDD9f2mVkhoWMWKQCTTzlRuCYn2wU4SuR2ALTE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIzsY0rU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5f7a42bf0adso148211a12.1;
        Wed, 24 Apr 2024 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984669; x=1714589469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48mxMFWxRPbfhbz62qZsFgeMgLn9gqf3uPCw7ejtzBk=;
        b=JIzsY0rUYTseNvFbGV1xMuc5T5ORXbbybwNYt4QQ95nEzJZAcoEf1ssPrLeM8qfNdK
         manVZf8qVAQsT/Gs7LfO1nNyPUKDZuu8zEUY6ADEBvU486OXSg49ajagQxQxjq6JZBhE
         aseBANB72FyVhm2366hHNzFz+ybJ8LEhWe3wZ/ZXNSvL9ckCfUTZruIIsvTBIL+wJ5/k
         nJtmgxOW8oHXq7wwOskm5utLI1l1pyxHZoBUSnzPyMK6z76vLP9JMugi85FFkDjj0371
         Kld1su9StKTiCL5PBEu2sH/Sh4IlprLClO1hcPCsyBcAnLtn4qd7ZfVpX/OiIa6EoNVe
         2EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984669; x=1714589469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48mxMFWxRPbfhbz62qZsFgeMgLn9gqf3uPCw7ejtzBk=;
        b=NrdSONMlMQAVYZ98bh6qQLud4BhkG7NuyiQeqPCPO4f/XzYVA+uQahWLwBAmCsiJjc
         E8sR8b5oi/NVc4xDOVfgzr4oQQFeNuSGi1W96/Otd5EUBSYFp2fjJaK6ZsNA9qWTU1EN
         UF8Ga0IVxvz+3gML6pB1XLc2imJ+xO7c6nJ1bux6rIhkTy7Dgfsc9O3FwAoPwtz1PT3c
         H0mzkf+QeQJVx1vFhHS4c5lrPST2EeZEnYtVlBGBvQNrKrHLCLrarGKaDP2XS3JwEFgp
         BOhke9RdqL8AJbPgA7JNLLAvUMJgDxHmx300Hy6uWpysfX2PzCEh95KcZESpWoTRBy9R
         d5GA==
X-Forwarded-Encrypted: i=1; AJvYcCXhiZ1mIFS4OhuXe1fhVnhC1EsS9n/t1Kv5Ttaq7UJTeL8LYh9U8ayxlzmlh6z5M3Q4evm8jBzjY9YwZhyrQrxT2ccWIsI4Fs+crOKB1RVRPn372Yahxvb9HkCEQxg2ZtD/QPQF/qs2Vyc4Vax/aGnfIMS9RaMXeW+1uvHhsMYzRK1RcuA=
X-Gm-Message-State: AOJu0YyBsgFGcXcORdodNV/wK5xNVwn+v+7N27P3OAJ5R4yZwur5R16c
	7e2MqbOz5X4Q82LFAbZFrmgMxXfJ006A0YAYsg3sgcsrfokL+r0H
X-Google-Smtp-Source: AGHT+IHkqSQ1b6O6+sYib4DgIQ/4zA0iPn9beMEBsE9puyrhvi9JxgtyrS6CkUdDbAEWb4Ui+Cy73Q==
X-Received: by 2002:a17:90b:4b0e:b0:29b:10bc:acaf with SMTP id lx14-20020a17090b4b0e00b0029b10bcacafmr2947707pjb.30.1713984669425;
        Wed, 24 Apr 2024 11:51:09 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001e425d86ad9sm12268728plf.151.2024.04.24.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:51:08 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Phil Elwell <phil@raspberrypi.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH 0/3] gpio: brcmstb: add support for gpio-ranges
Date: Wed, 24 Apr 2024 11:50:36 -0700
Message-Id: <20240424185039.1707812-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Raspberry Pi 5 includes Broadcom STB GPIO IP as well as
Broadcom 2712 pin controller IP.

The community has expressed interest in linking the two drivers
with the "gpio-ranges" property in device tree. This commit
stack implements the necessary changes.

Doug Berger (3):
  dt-bindings: gpio: brcmstb: add gpio-ranges
  gpio: of: support gpio-ranges for multiple gpiochip devices
  gpio: brcmstb: add support for gpio-ranges

 .../bindings/gpio/brcm,brcmstb-gpio.yaml      |  3 +++
 drivers/gpio/gpio-brcmstb.c                   |  2 ++
 drivers/gpio/gpiolib-of.c                     | 23 +++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.34.1


