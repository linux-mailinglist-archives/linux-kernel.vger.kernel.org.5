Return-Path: <linux-kernel+bounces-105570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96A87E093
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5A8B2161F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEC521104;
	Sun, 17 Mar 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYsdadTf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2F2032A;
	Sun, 17 Mar 2024 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710713497; cv=none; b=XxFJ+WRzGEl/0irEADqXIP5uzDQodE38jE2wC/J3OWJnuTopSh4TN+BLw7FbrIJbH4war2+zkiloDQbJ6F6D5Ock7IjpQc4y5e8bNCn5bi3iNjrAvb10RY9exLz6ZkOf13zxRmLxRqaGj9DDrQryvNBQppcgvul0ICOfXLbTu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710713497; c=relaxed/simple;
	bh=7JxVARnpt8VrtLOpL/eqdg5jtbrceKiiBGREyTRVRtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Oc/2p3k8Lp7sUNt/bTQlW50ZQ/rY9B59PAxBPyQp/TcmEP4hGfAdxWmNzfFh3U46clJiSnySxQMhvO6gPRViSpqLURG2BxJb6MFaZA1acbHBc3jBUpgLQIKKmO3lJuSlT323xv3L64nJHS6LrcNtWC4psG4ZLUEhcxAYqwBImJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYsdadTf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131316693cso4628160e87.0;
        Sun, 17 Mar 2024 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710713493; x=1711318293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZmm9s9W7l5cdXxYDm6zTzBblgqnwNDluCe4+r/QOr4=;
        b=HYsdadTfvSat8AjDAz3Sh9/JiL/p6Wzm+BGVP7dO9NuKfKPR71YXPq8UR7MNm1tsWb
         jRqId45A45/bFYvl5DjjOM6fjdYNPTypwIGT5Zvj1wPQAWrjcbj0+ApbhfGHsys4CSz6
         0m2LTpXTchPyuEbs6q9gUqByCbJvHOkPvOEA0vHOlMe2OFY6F93GpoYxTgQWBzgZPxDF
         XavmDVS4p/HpsN7uw8QTrOWsr4Wgg+HO44W6/vb+9b6i8OlgcMr5veIwG1bmnJVYQUj1
         Bb5VT4OtLjzZ6lZ1C/7BWqrz/Yr5LH4to5vwnj45XEjTbGUYawTFogc5MANfwPQGX2ar
         UpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710713493; x=1711318293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZmm9s9W7l5cdXxYDm6zTzBblgqnwNDluCe4+r/QOr4=;
        b=b1XidL/JMN7zkVV4//P8Jsn1gGeUbtWD7PCMtryzINcNRodqdCP/4pXEuISfIdEGiw
         /nly909FaV3kKqMQ2clG3od7da4lo6pUI3TEZl7fFNXeq8mo+8o1Xxlvtu1O0Hc8PWfC
         o5QxXxd/NyQaEk/+4Gx7SVD4KbT68nnhjWYjQm8NXah3XUf2vM1UXsqJe7JA73TBquGO
         u999PTpBfTe80lViiz8yxDhrvm3zlH+qY5Spg7GHdbTK2LXiN+ce9NTgRV/vbPikjncB
         T1eJg3ntXTYbz9Ah/O+2O+GgzDwyu/aipPUM8cZYZQooXLgM/luIuqpq51YbdoC8WQ+P
         tm0A==
X-Forwarded-Encrypted: i=1; AJvYcCXCcmA1a1FWs0IdzILIyWBoCXshECrTHroOGAc0X9y9Cv92/dTVEmK6ITrfJIxVwa96rTr1OuW2PmElWDJelinK335cC1Q/c22kH+ZCbS31rFrnBjNLuk9KkTDgtRKyckbCOCKWKPpeSQ==
X-Gm-Message-State: AOJu0Yy+1xOtulMgCabh3w0DuPlaf/WNE6DNkyOyvlflqmIsWm7brM61
	xvV+OO9b5kLLZzis58rMBTjZiPr4Ljls2RHKv8iO8++/Osr7YwHe
X-Google-Smtp-Source: AGHT+IGSb4vn1VG/LKLn9iIV31b0qpmYMFxtDzfKEmp2doNXYedxkw8XdC5P9x/zshzJVd8cN9Lulg==
X-Received: by 2002:a19:e050:0:b0:513:ed0f:36c9 with SMTP id g16-20020a19e050000000b00513ed0f36c9mr194791lfj.45.1710713493135;
        Sun, 17 Mar 2024 15:11:33 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y16-20020a197510000000b00513d8e5a088sm973049lfe.140.2024.03.17.15.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:11:32 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	"David S . Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 0/4] arm64: dts: mediatek: mt7622: fix some validation errors
Date: Sun, 17 Mar 2024 23:10:46 +0100
Message-Id: <20240317221050.18595-1-zajec5@gmail.com>
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

One more step in cleaning up DTS for "make dtbs_check".

V2: Add "Fixes" tags

Rafał Miłecki (4):
  arm64: dts: mediatek: mt7622: fix clock controllers
  arm64: dts: mediatek: mt7622: fix IR nodename
  arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
  arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block

 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 34 ++++++++++--------------
 1 file changed, 14 insertions(+), 20 deletions(-)

-- 
2.35.3


