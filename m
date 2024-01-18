Return-Path: <linux-kernel+bounces-30540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027983200B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FCB1C254C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1253588C;
	Thu, 18 Jan 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XXlnjfzV"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9834CDC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607679; cv=none; b=lEnM8lrKEpTjQS5A3UE0kXBqMRJhC3qRQLcmmRpbxDnAn8GBHZkL3rbihXgCzF2lhufkqHG+b8vrBj+NQKdv3vyxrQvB0EFmyAvBNtGTlTfR3MIRgzxYBdL6YUxOECkPzYHzFNPVIvJkc5oqkxHCswkkjzU77DZH7RT42ewKd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607679; c=relaxed/simple;
	bh=AuzrW9UDgSxJQcq2g8YNuAO77J6D3Xb2mioA2H4DLNI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btM1k/g17RRTxBhzHPTusMQgGpwNWUHbd1JzHH0MFf4GQ2kD6dppCcqv7ixpOWC8NvdxJHRqnKyG3Mw+R1UDMJbysHPYrc9C64EPoAZxpTwce28eZ/t07FXVcLygF2OFIkXwoIdVW/LPy0z0g+FhzC8rXNzssqYVgLlvzTfrfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XXlnjfzV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2902b142211so67602a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607677; x=1706212477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CghvPoNxLJl4lLRdVw4tb22f1/3nanFbn4ZhOjlHkeo=;
        b=XXlnjfzVUOPCjCMtoeJJS74BJ8AufVJCX9XLdtAXsUXONzVc+34TWSlPU9d75tl5tY
         udc7j/IgIG5QbdWRiaTw1rgFxGOxu1oE65I9bApEPKqEmQXWr7w+SXvYn3dTsjDitwQo
         7rQqGDwS380cZ48Nkm8S5TyUMALlMyepSTEFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607677; x=1706212477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CghvPoNxLJl4lLRdVw4tb22f1/3nanFbn4ZhOjlHkeo=;
        b=rpFiJy8s1OovAdRq+I9UL6sz5K9sg6ng1ytvafJz3v6oXqkYh6fqfA+bmt6UaSvzRj
         uGhOJx4CQueRBjU7+d4Im5XvfiWgTBi1bJUxphsS6mTk5wsvySWbJWk/dR+NqBCgAMDi
         xd9NeK/QuWsQ1sHcK/Xybpbwpdek6VfYdspzllIiMzP9Zbz+kr1aPp5XHMe1BzBc4Svg
         S8vgodv26YNqarOkiTaMcNc+uW7IEgqVQPXXotnH+vJ7onTvgVuy1f+VMTm6shG94TfL
         U8EUjx/h/N29euCXid4sQ2QaDAZTYBX5WKDkboyBOpn6kMADHrSQfpmb3keZ9T4F2cOM
         ME/g==
X-Gm-Message-State: AOJu0YxpF3ta2CGvJ2ztQolFC0SAdSNGn2XpTorZMO6DxpUpkeggADpS
	trktSKiOJvF6beiaIF0oiSjXmuWhFhEv8Hlraelh0n8KMHTlmJGvWY5QYHOOKg==
X-Google-Smtp-Source: AGHT+IGpduvvbCU9h++TkrPZzn6xG8chMBt4/0ohm/34e0CnY9xnW4nf7DjMx4QEdaOxW+UnTH2Dog==
X-Received: by 2002:a17:90a:1347:b0:290:3e62:92ab with SMTP id y7-20020a17090a134700b002903e6292abmr571455pjf.29.1705607677448;
        Thu, 18 Jan 2024 11:54:37 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:37 -0800 (PST)
From: dregan@broadcom.com
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
Subject: [PATCH v2 09/10] mtd: rawnand: brcmnand: update log level messages
Date: Thu, 18 Jan 2024 11:53:55 -0800
Message-Id: <20240118195356.133391-10-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240118195356.133391-1-dregan@broadcom.com>
References: <20240118195356.133391-1-dregan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Regan <dregan@broadcom.com>

Update log level messages so that more critical messages
can be seen.

Signed-off-by: David Regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
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


