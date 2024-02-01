Return-Path: <linux-kernel+bounces-48386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1411845B50
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44921C282C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D67B626B7;
	Thu,  1 Feb 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XswRnU+9"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31232626AC;
	Thu,  1 Feb 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800740; cv=none; b=dPCJvJPoVPZcsPrrsgZWgbV3oTOD7Isets57/eJfzwjs0XszRiWIyHuRDKhgMjP5mRgRaVHcBXFtEwgpDSL/5G4APsYB+rXDj9Vd8rKe8gyo9MidNG1RPFOa5DnzP1uJeyUOSth0vk1oMMWOSCrWnbdTQ+jPMXBOAZixWikbj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800740; c=relaxed/simple;
	bh=x2Jr4nV3kJTIg0KYAbhrFtYkqlzK2SYGmGQTdfLTNJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdLodpJ4cvVr+JlvPIuHQ2Ntn5wM5rwELVksCOgM64glUvL5tyZoewYFL225vR7ZdhvzYhKKpMjb9y7g/ycHiO5/VH4ZooMBnn7WF3ajTN/QaO9Y2xUhBb2IO9pt/wP6KplqJJzaWv0vYzS0nyJ6z8iWZSi3JQzPhACI7DuqkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XswRnU+9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a35e65df2d8so134440366b.0;
        Thu, 01 Feb 2024 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800737; x=1707405537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7rgZm3r6uF9XcdUSoMmbnnPMtYOwIoB+ZObdBMW3Go=;
        b=XswRnU+9+81y4RVbDOQ+Z6xhSbkmvb1flTsKEzxLH1n3q2u+Uhk32/PC5LDrRr+SMY
         mWcLCGL2tNMRh0ptBuSQyYGNJi/yAhAbPWM9FjvY2LSdSgNdoQe88KFofQE/6JD+Yli/
         8kWUZUxkVArqFTVVB5vUMNypLciHJ9cS7u9cutk/Y+sGB8uZkXVniFJLwHF/Lj2lBMwz
         Xz8wOyOM+6nrsVj5IGubOMAAMNtJOM/YqL8Enh18x+3GGukBG1ERP5DDaWJCI31dq+qb
         nbwY+Uqh+o6x1pP/E7eorL+cvolvXzobPrs9JbCZSMmVvK2bYPp7EkKtMa+xxySa0Xqg
         8MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800737; x=1707405537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7rgZm3r6uF9XcdUSoMmbnnPMtYOwIoB+ZObdBMW3Go=;
        b=gqLJFqQ3fzqYoWFaUpICXyNGOhC21HMJQ9eDoiBEU16SHvWCIFUZhBuCBgf5F/HY9T
         B7TP2ivxpVAb3kBOKajMmhQyEQ5MQmFE/IFk3crDbooIC/WNaDaIEyVhfadaHlnHiiSF
         zj9o03GyIOMnfKgdy7c5/m1uyKrCX0WFo4iasoI+4DYP7beYkUt7t13qiB0uAz1rM9j6
         B8t87SRkcYpHQbC0SlAGnSyIpw0MC6+C041jt1a7cDGCy/bJH4tVWs1cwEaLMHjkBy5+
         mK7sYisKPWojL0HqMquJVDUh4MX3dJr1A3dOZqrxbuExmYDba8QFlFM8Mk76sUbkXbcN
         FVMw==
X-Gm-Message-State: AOJu0YyjYYkCIgfnYyCGNMM6R0f80T5iSOM/EzQJKhVICUQRPjlUQhNK
	5Y4T6Gk/4Y3/KkRnYywYWGkkQf3nbLURBubNIDLtjtNbyGrAbabu
X-Google-Smtp-Source: AGHT+IFem4E/8W0pKsC0gsMVprFszUbs9kqx0etdldtQi5ehHLevvPYNncZyZj2CcLr/6ZPY9LeBkw==
X-Received: by 2002:a17:906:e98:b0:a36:95cd:5e64 with SMTP id p24-20020a1709060e9800b00a3695cd5e64mr2741748ejf.62.1706800737106;
        Thu, 01 Feb 2024 07:18:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfarDKUPfvZbgtKsZHsl7RZR9QwXyYK39JaqO6UCGhp/rzYkh5eKF2lYdLrI0tdO1g98WDuZmYg2RA9/fM8aNC8WCNtRfA1AgRusxt46UD2pmkOsTgFnrwndssg4gNkPeRcjbgksHMfFiqcrUnJMHtUvLdlh7gP0JKZA==
Received: from localhost.localdomain (101-82.fiber.cz. [217.28.82.101])
        by smtp.gmail.com with ESMTPSA id og16-20020a1709071dd000b00a28aba1f56fsm7244984ejc.210.2024.02.01.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:56 -0800 (PST)
From: Nikita Mikhailevich <ermyril@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ermyril@gmail.com
Subject: [PATCH] iio: accel: mxc4005: new ACPI ID for the MXC6655 accelerometer
Date: Thu,  1 Feb 2024 16:18:48 +0100
Message-ID: <20240201151848.1666245-1-ermyril@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New ID was introduced by Chuwi on Minibook X 2023.

Signed-off-by: Nikita Mikhailevich <ermyril@gmail.com>
---
 drivers/iio/accel/mxc4005.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 82e8d0b39..09764ef8b 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -472,6 +472,7 @@ static int mxc4005_probe(struct i2c_client *client)
 static const struct acpi_device_id mxc4005_acpi_match[] = {
 	{"MXC4005",	0},
 	{"MXC6655",	0},
+	{"MDA6655",	0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
--
2.43.0


