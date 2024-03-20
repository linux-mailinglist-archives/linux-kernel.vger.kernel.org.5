Return-Path: <linux-kernel+bounces-108805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3901881041
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA64284ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF92339FFD;
	Wed, 20 Mar 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Iwqqg2Mz"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143629CEB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931786; cv=none; b=kQvL8RiglQxuIL0Le5UFYfpCnXcCC5P+um56DW7W4Key3wCFbhDChUwfDrbrCHAQ2C/1Io/3pFnuYeluz28Fkzc0IvjnzpdWENDcc6rxOziZv4zMy/vw0WVyxNCIFTblIkksSUkXvCeHfcpC1aoQgGVfolcZ+oAnwLIdSwkEooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931786; c=relaxed/simple;
	bh=t1TrKITjPnw/EArrpDUtUW0J3HKSodUqgn3N+ztvLRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bWjaFVGA8pWEX1NRHqTxI1s3Rnhf8dEItNG4GfKeXBhDkAYp9wEb2kJ3ITx5oLSE8cVv3C9NIs5+m0SrdrOsIarTa6B+Psz9uTR9fox11kYpY8lx+IoKAhp/vmZpFZD11P/lRhQz7k0STR88uasVxJQ8FksphNOm2c7wSEV/h+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Iwqqg2Mz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56b9e5ed074so2092544a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1710931783; x=1711536583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjQpv43RsbyZPpH2EK5mjEDZoLFEPdnIRs0RsD7dBMo=;
        b=Iwqqg2Mzr/HprEUXvFiP3zjkzbBtIpoP1UqPgR31A5a/M9jA0IZdpnYp3KfFV8H9M7
         dbNc26xGapqzFilH2CkA96BD4dC1yuRb18c59E5jUuPgsQdLAZ59VaLkqgC2xtCaF4fg
         y2er15Xkfj34SjoSH4bgh9giC3/rUxU+9wyu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931783; x=1711536583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjQpv43RsbyZPpH2EK5mjEDZoLFEPdnIRs0RsD7dBMo=;
        b=HU1yZ7cG1L0QbvqWdQAF5nqWwbXdxz7cFpy6PbzlPRBEULqNq98zLHeKViJN1NF/pe
         A69VZSVYFjOUY9YzNlMt2Y3sPZCN9jSc1mAEB7CIbvCXQaiPqDaIAAbPtS6NlOM1KOzm
         Yu4K6B6udrfWAvws9ybb43sUV/Y5f3gaYxrPBkNUPmxxACUNMcmEd0vnvIVy4qfgKcaT
         050wNX7Z9/YUc//CGdEDVny+AFnG260oTLOguRB0w0BkZWAYQ3BrdLP2Vd8A3mQbdygQ
         7hhW8d1a091YFz2Fb/5wb4E99HCzcx3nYh6s/smKvjFKruovLj851n4RnJibk6zb2UUN
         sz7A==
X-Forwarded-Encrypted: i=1; AJvYcCXahDN7rpPaD3+9/xOvhnpu2x8iGGLx7EeTplFFc4k6fbdYk/GFBrR4hTtp8fuqQUJX0IAGctbHXeeXplC5xf6Xa/woyMrYS4vuik2E
X-Gm-Message-State: AOJu0YxdtBdKClFxuzG8OgzqUvFbgQIr27Kn1xK1SOKhzq+fX1uTsu+x
	Hdulsrivw/mnnfsWziIEaLltFTqXLKZBXtVH25/qSMy0XN/zr2zdkebcNud1LQI=
X-Google-Smtp-Source: AGHT+IG6IU2dlJVmfC6TljYpywN0I/ValR6I0IV2RbZWDK2G/AHMthaopzSlCWJYMoMDG62gqjGIfQ==
X-Received: by 2002:a05:6402:5025:b0:567:a318:ac0b with SMTP id p37-20020a056402502500b00567a318ac0bmr1552209eda.16.1710931783220;
        Wed, 20 Mar 2024 03:49:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l8-20020aa7c308000000b0056b7ed75a46sm2738978edq.27.2024.03.20.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 03:49:42 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: armada: simplify name sanitization
Date: Wed, 20 Mar 2024 11:49:39 +0100
Message-Id: <20240320104940.65031-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code by using the helper we have for doing exactly this.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/thermal/armada_thermal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index f783547ef964..fdcb077cfd54 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -763,7 +763,6 @@ static void armada_set_sane_name(struct platform_device *pdev,
 				 struct armada_thermal_priv *priv)
 {
 	const char *name = dev_name(&pdev->dev);
-	char *insane_char;
 
 	if (strlen(name) > THERMAL_NAME_LENGTH) {
 		/*
@@ -781,12 +780,8 @@ static void armada_set_sane_name(struct platform_device *pdev,
 	/* Save the name locally */
 	strscpy(priv->zone_name, name, THERMAL_NAME_LENGTH);
 
-	/* Then check there are no '-' or hwmon core will complain */
-	do {
-		insane_char = strpbrk(priv->zone_name, "-");
-		if (insane_char)
-			*insane_char = '_';
-	} while (insane_char);
+	/* Then ensure there are no '-' or hwmon core will complain */
+	strreplace(priv->zone_name, '-', '_');
 }
 
 /*
-- 
2.40.1.1.g1c60b9335d


