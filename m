Return-Path: <linux-kernel+bounces-36389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE7839FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C8D290246
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9E171AE;
	Wed, 24 Jan 2024 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bw16DmCk"
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78788171A6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065549; cv=none; b=B9st78oEfFq/TKqQvOqYzP3gSjvfIZWzYGmkNF6wYYAWqlO6iS5v9zCkcIXOIFuFO+C7PCoCMJeKpLIQbFQwrClkvzBCeCIcUpJ588ONcWkjSu5/OshZYV0FX7FjBEBL4FXS0PoLGmZJ3yVXEXZR83wJH+SBl2mA5WmasyX+1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065549; c=relaxed/simple;
	bh=gORbgX4teZi7rbooLeEPlNv6bc+nAkHkNdOAFysH/I4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcGKO1KglBdqBdX4sbKTGpC/HClYskQV5R4vl2II0YN79Cv4fJtLbZ+gBnzBjtNJLH3/zgX/5sI9Ua/z5vNfmD0BJwo+rh0V84G8aqpMMG4kFYexLEDskeyLumvQIQ+zyvTywLYZ4WE/lSWdb6zFyD/fkJeq5aVc7l0S8iaqoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bw16DmCk; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-6e0f43074edso1138021a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065545; x=1706670345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFcgSd1V+HgKBuaL7L8NE1SRwQaKowsXm4oxPTjKU9s=;
        b=bw16DmCk0t3GcEnlUjWJl2I+qncVVKpqqhY+QFzgZTekbrTPGcEc59vzp8O9vXdcF2
         eFwAFQje0EpTUZ2K60iVeLOI+4+l1iMZuCYN2D0iS3ojSM7ugtt8AR/5+mwcJ7LlhaLK
         dgwXagY3Mi7vpoBhM6D/Wg/+u8hIL1NyZDLFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065545; x=1706670345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFcgSd1V+HgKBuaL7L8NE1SRwQaKowsXm4oxPTjKU9s=;
        b=QAoAckQ7P4wU9aoATCCR8rSPzishrW9TyctqVCu1zmmyMqC+uw8KBpIoDDboZpXCbq
         Lc79cY9npCtK8qSr77VJwDkJ4jI/HRrX5h4rK9hKpCzVyHREUJR0gudYlR9ht1qo2+y+
         q97Qz7YPFfFt519e1Npcl0+r1x1hqSy+B2kSPf8VIWNpSDspV6aJf4lfVFjzMb5JpVA4
         zn4qu8GlVmf5dgiIKmvYePNRjaYUkYV9vrmylzyqzsfCo2rlyHj4R8YFs6BAH2A0tUlK
         P6zFTV535E/S053fD3YFgzQE5AZKv1H6+91qpjHHnltgNmgeIDyu/Otrfy9UxoAOVQPK
         FcqQ==
X-Gm-Message-State: AOJu0YyVo4Rgh/Ju7COI63djoHKZzn4VuFUhKcaPlItl96jUS0wszJZt
	QzHDQ02y2Wme7tNb3fxpJxyjqTg8fqjQFeSzYWWmZSBsYod65rdzFshxBW41WItTyaIAo1iZnOB
	6+mgq/tRbiW3C27/Sx6IDe5lXPQeFqw==
X-Google-Smtp-Source: AGHT+IFUczeGsTMucdCz87Q+XuPWNyli22xHQyTTbN3tL8x5ItmmZiArLg9wfVebnUPSv4u1XyEUy/6CxWC9
X-Received: by 2002:a05:6830:144a:b0:6dd:ee32:2843 with SMTP id w10-20020a056830144a00b006ddee322843mr937842otp.42.1706065545326;
        Tue, 23 Jan 2024 19:05:45 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: David Regan <dregan@broadcom.com>
To: dregan@broadcom.com,
	dregan@mail.com,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	computersforpeace@gmail.com,
	kdasu.kdev@gmail.com,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joel.peshkin@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	william.zhang@broadcom.com,
	anand.gore@broadcom.com,
	kursad.oney@broadcom.com,
	florian.fainelli@broadcom.com,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andre.przywara@arm.com,
	baruch@tkos.co.il,
	linux-arm-kernel@lists.infradead.org,
	dan.carpenter@linaro.org
Subject: [PATCH v3 09/10] mtd: rawnand: brcmnand: update log level messages
Date: Tue, 23 Jan 2024 19:04:57 -0800
Message-Id: <20240124030458.98408-10-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240124030458.98408-1-dregan@broadcom.com>
References: <20240124030458.98408-1-dregan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update log level messages so that more critical messages
can be seen.

Signed-off-by: David Regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
---
Changes in v3: None
---
Changes in v2:
- Added to patch series
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 6b5d76eff0ec..a4e311b6798c 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1143,7 +1143,7 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_host *host,
 	if ((val & mask) == expected_val)
 		return 0;
 
-	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
+	dev_err(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
 		 expected_val, val & mask);
 
 	return -ETIMEDOUT;
@@ -2196,7 +2196,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 				return err;
 		}
 
-		dev_dbg(ctrl->dev, "uncorrectable error at 0x%llx\n",
+		dev_err(ctrl->dev, "uncorrectable error at 0x%llx\n",
 			(unsigned long long)err_addr);
 		mtd->ecc_stats.failed++;
 		/* NAND layer expects zero on ECC errors */
@@ -2211,7 +2211,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 			err = brcmnand_read_by_pio(mtd, chip, addr, trans, buf,
 						   oob, &err_addr);
 
-		dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
+		dev_info(ctrl->dev, "corrected error at 0x%llx\n",
 			(unsigned long long)err_addr);
 		mtd->ecc_stats.corrected += corrected;
 		/* Always exceed the software-imposed threshold */
-- 
2.37.3


