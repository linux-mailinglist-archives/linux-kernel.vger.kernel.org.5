Return-Path: <linux-kernel+bounces-30541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4583200D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2171F28A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1898358B4;
	Thu, 18 Jan 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QyRz1pTl"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A93529D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607681; cv=none; b=XD+Gg5wut0Xl20BJQ1vpNXRk8bjimmBTXiTJiXmt85NhWoiaOxrgIP0z2KObDnFx/h7dBrBZVmrHkLmYAtwKk9005GeMZzVhEuCQUYtvvDFbdyU62/MdCfXvIcfinuO2nbT8iCz6zbckp5CZHEUX5LxEZt0rQ1uPaLjmcEheFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607681; c=relaxed/simple;
	bh=yzhmvpw6dHvm8R+C7LqpWP3Wj6s8xNkqYMpLWlwi0RI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbGk3ugf1OD/BcqN3gL57ysOJ/cYaV3bblShkTc/BjKSxU5get+sqj9T6YrE2wzMkXo/sPOvN7Jg8rMiLhtSutGJiHOFxNzJ/6YUiKJGwyld/XsCEaJBmAbYT5kA3oxRLGYZl5ITKfk502Ioko+4BenfxnqJZhU8a0jjBLOnGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QyRz1pTl; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28e8c930c01so71767a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607679; x=1706212479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeH1TIJtMu9dNiviTF/nkxwiev6sYu4cBkxn5iUmNwA=;
        b=QyRz1pTldYDbOcvMJiyHe6bWKOyFN/rDBI4ARFsSVxKEXK4a+DoVJ5uXDgrjjbOfBF
         hQwT3XhVITF6cupxzisIzBl9wdwvAaGBBE8WJR8ZbeEfETwCSZIwE3M2+flKWy1X3Pq0
         oEE4Udk2ju502pLLXQFeLKNSAkmiXE5wdSBtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607679; x=1706212479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeH1TIJtMu9dNiviTF/nkxwiev6sYu4cBkxn5iUmNwA=;
        b=XvZhtHg5Ii09+sGaCGF4Hy+kiRLOXB4LkKfh7DIUbwhJS/L3K41pUS3UFgHTQbxnbc
         PttmC8zd+xDSFYWdOrKtuTmiXpyB4Iv0//BeWv4K6wLijG/lZC5q+o3dUWgwyaKxwx2G
         eHB6Xsxfp0W3nREYMdYLyh2YTGvr3uUNavi6DXR6FRyMEeaXdoQnBIAaDJzTDXmBVQyS
         SPjr/dNpDBovbXVlaQQc9iK2wLDPbSZKvOR5Ahtmq3Fnn5fMsRgsQlKaoEgiDGH0rb+N
         pm8+XszSokXTJWinq46agt9+l3pR9rXI6EHGOJsVNrNB7jHUJArwXvCZSBk+V7tqhAEJ
         yRkw==
X-Gm-Message-State: AOJu0YzUmSDyDHnc9U3sRugtFd40wPZAfZdLPxWtoYzmXCTGSW5SHz6w
	jW8WyHU1ryS09MWrPpX1PUSxO9xtfGhNqMTlbPw8s4pLT44RYHEqwD0ThPRepw==
X-Google-Smtp-Source: AGHT+IHACuKl4Ub94+Xnxo/jnjCOYBw1yW1Eo6Y2FDr3CuoZ6RFhJZAwMW6S4Z0cAarZk55E4E+D7g==
X-Received: by 2002:a17:90b:2349:b0:290:1d33:cc66 with SMTP id ms9-20020a17090b234900b002901d33cc66mr1276623pjb.91.1705607679035;
        Thu, 18 Jan 2024 11:54:39 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:38 -0800 (PST)
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
Subject: [PATCH v2 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
Date: Thu, 18 Jan 2024 11:53:56 -0800
Message-Id: <20240118195356.133391-11-dregan@broadcom.com>
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

Allow settings for on-die ecc such that if on-die ECC is selected
don't error out but require ECC strap setting of zero

Signed-off-by: David Regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
---
Changes in v2:
- Added to patch series
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index a4e311b6798c..42526f3250c9 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2727,9 +2727,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	cfg->blk_adr_bytes = get_blk_adr_bytes(mtd->size, mtd->writesize);
 
 	if (chip->ecc.engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST) {
-		dev_err(ctrl->dev, "only HW ECC supported; selected: %d\n",
-			chip->ecc.engine_type);
-		return -EINVAL;
+		if (chip->ecc.strength) {
+			dev_err(ctrl->dev, "ERROR!!! HW ECC must be set to zero for non-hardware ECC; selected: %d\n",
+				chip->ecc.strength);
+			return -EINVAL;
+		}
 	}
 
 	if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN) {
@@ -2797,7 +2799,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	if (ret)
 		return ret;
 
-	brcmnand_set_ecc_enabled(host, 1);
+	if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE) {
+		dev_dbg(ctrl->dev, "Disable HW ECC for on-die ECC\n");
+		brcmnand_set_ecc_enabled(host, 0);
+	} else
+		brcmnand_set_ecc_enabled(host, 1);
 
 	brcmnand_print_cfg(host, msg, cfg);
 	dev_info(ctrl->dev, "detected %s\n", msg);
-- 
2.37.3


