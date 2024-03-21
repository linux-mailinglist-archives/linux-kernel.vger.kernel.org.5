Return-Path: <linux-kernel+bounces-109870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17EC8856DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7151F240E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441054FBB;
	Thu, 21 Mar 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+IPc+xy"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BB4F1E5;
	Thu, 21 Mar 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014939; cv=none; b=u1tev3mNvnDNHOHbaFGut673iHF4WS1CX8MXf1TVZ/Lf4iQ6I2VZzZrU6Pm/U2awAR5yk6hZUXg5R4oUDPOQocWsI8TPcrLdqtnSZUmpVjAiASmDEr/HfE2JqE9KZ4TwVMG7nbVOZZnT8YJRypvQlnDWTT66O5XTPXYvMsxh3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014939; c=relaxed/simple;
	bh=a7nyevS6kXHl1cnaRea9FJK70FgEPAKs8q8JMOY4PzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4WP69Qn8wXVW6ovetcXm0u/4zeeMMqpJCPQvXZsH7WKI55hhiDr05bYQ0h1AdkZQuBjf7hBb3YeLvJQX/R4VPzCLSvJ7WA1jj/TcAUCQt9vtLeApKHlzA2minuKJu+7HyFcq7fAXF6suyk5RRztTTfwLmJ5iqzTr3lEVszMdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+IPc+xy; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so10133351fa.3;
        Thu, 21 Mar 2024 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711014936; x=1711619736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRdYtRQgQCnEH10wkUIxAuGuQILiDbkAHuoOc+MadDQ=;
        b=X+IPc+xyNrbCVqmF9xYtiA4d919djJ4rSw6EGHDTylPRcAd2uFAiVs/2HQ9BN/fLag
         Xp3lvnuqzwGKT+Q5Hg1MuI3f89YAlRNoD9q098C9Y7iahD/s6LRIV4oLBZ31L7dm/yfS
         rf0dsPok3lIfOJWC/h6BwuR5GSZ6wxv4uazxHKd28Eo1GQnCoA0vSGjPwCbFa+hvTlcF
         2gRGY5zlrIGOuLbo3+sfPLjPWTeLc33vnhecNBM1mHbREyY0i4XG1357+uJEEwfHjwaV
         17qxdmYUG/+xq0Yg+7uRFoA0Lr3uGWxH5uZ5YOO5mS4lCct5Xclt8qykN/UWz/FW2Dj6
         kqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014936; x=1711619736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRdYtRQgQCnEH10wkUIxAuGuQILiDbkAHuoOc+MadDQ=;
        b=wPnNLirM1H7htGG2JY0+T06elpZnlhXKv94ldyAY6tHhGqfMH8h1NpQkVkLAxDE6kG
         pEmnWuZopZ1WT+55a/AV8SdmMBKGTowZ6rKoMqoh3A9rvb7BkCId5N216yQU4JmGwQ5Z
         Wc3HB6qEuUesym67Dgny2OghXvgNZbHmb4JiSoPHKoaZZuMoz8SAWpdDxHRFmRpzhdhy
         tf8C7Gig26hGy7Xp77Zuq8Yc4JF/cKD/y78h3uelsNtdW32HHSZwxDAr/vixouVOEfTB
         TO9AR/5Dpd48O7x03bdzRQrZ4vdBOHMglcqY5PUwSMZ6Ruega1fw3genW0zDVY3GFuqq
         qJRg==
X-Forwarded-Encrypted: i=1; AJvYcCXBAvi61MFaBnblv+rD0t7Z609isZ7xLB8dweXefX+dlJC5vzFc37TWEJJKIRhuGiANGBIxzshewic0vY9BU2hrIklwEUki9PJDrJA6YjT323BNe5zhauol8uDY/9aPlQg87uhN
X-Gm-Message-State: AOJu0YzNz4cgAPgrD+k/Oz9zfZZcWb+7lgW5vDqlWb1nDUi/rVT4Droo
	ik85SY/ZUi7DmRuEzM/OOtivTzJ3RmPeJHL7mVERbVVyNUfD8FDS
X-Google-Smtp-Source: AGHT+IEweDT5R/pbQGL244a1a+Gfu1CUq42BQlOsQYAQ+MsCxskzyKPWWCdQMVQIczFksFberVTLgA==
X-Received: by 2002:a2e:944d:0:b0:2d5:122a:4b13 with SMTP id o13-20020a2e944d000000b002d5122a4b13mr5932802ljh.16.1711014935817;
        Thu, 21 Mar 2024 02:55:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id p11-20020a05600c358b00b0041408af4b34sm4987103wmq.10.2024.03.21.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:55:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: limit OTP NVMEM Cell parse to non Nand devices
Date: Thu, 21 Mar 2024 10:55:13 +0100
Message-ID: <20240321095522.12755-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTD OTP logic is very fragile and can be problematic with some specific
kind of devices.

NVMEM across the years had various iteration on how Cells could be
declared in DT and MTD OTP probably was left behind and
add_legacy_fixed_of_cells was enabled without thinking of the consequences.

That option enables NVMEM to scan the provided of_node and treat each
child as a NVMEM Cell, this was to support legacy NVMEM implementation
and don't cause regression.

This is problematic if we have devices like Nand where the OTP is
triggered by setting a special mode in the flash. In this context real
partitions declared in the Nand node are registered as OTP Cells and
this cause probe fail with -EINVAL error.

This was never notice due to the fact that till now, no Nand supported
the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
access for MX30LFxG18AC") this changed and coincidentally this Nand is
used on an FritzBox 7530 supported on OpenWrt.

Alternative and more robust way to declare OTP Cells are already
prossible by using the fixed-layout node or by declaring a child node
with the compatible set to "otp-user" or "otp-factory".

To fix this and limit any regression with other MTD that makes use of
declaring OTP as direct child of the dev node, disable
add_legacy_fixed_of_cells if we have a node called nand since it's the
standard property name to identify Nand devices attached to a Nand
Controller.

With the following logic, the OTP NVMEM entry is correctly created with
no Cells and the MTD Nand is correctly probed and partitions are
correctly exposed.

Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax fixed OF cells")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Use mtd_type_is_nand instead of node name check

 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5887feb347a4..0de87bc63840 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 	config.name = compatible;
 	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
-	config.add_legacy_fixed_of_cells = true;
+	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
 	config.ignore_wp = true;
-- 
2.43.0


