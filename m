Return-Path: <linux-kernel+bounces-36390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AA839FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73C3290C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90AE17573;
	Wed, 24 Jan 2024 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NNNMf8+z"
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B217547
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065551; cv=none; b=k9aMl0WhkTDv10X1Pb1SOf7EsXYtBsNvUyym7u4lWE1exC4bEEOWhWsj4FqnUwVEw2p1RdL6Um1jnehhzZLlpbwmgr00CITlG0m+ce9eh6XMojwL76oMWCJEIn9vZbIeVQBGcVPNPLJBldxK6Bl+MNglivAMKXjLNjWNqBfMjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065551; c=relaxed/simple;
	bh=OSS8fz0R/URNmGIQV9ECEcXaS+l2j4CeGiDfsdomdEk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLF2MfS+qpnvTOmF0AI0MPh0Vt/nqk0XyTYWpKPLRGfbcZvZ1mGWOadO+H5PogHq7CCBRF9QpqwjVX0696T0O8AwaYuRjHqbqiGu9H9oVWRXB0reJCtpAgk7YEAWen65pG5yy4e4Kjwz3BP8Fu6nhS735bAvvivdMhGnelmKV/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NNNMf8+z; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-210e5a5fa70so2428455fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706065547; x=1706670347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWrjbDqCG/a53iknaUN5XiQX6sRbzWT8kV4u/Nqcod0=;
        b=NNNMf8+zkru3b2zWt0l9SPmsl0egRVmhcd6r5T9l8ZnNpEcnvCjvJGo6Kh46qVPNwI
         taiGy1aZU2FbfKuLE7V6UoUks5IO9AZB7NJqxG77jxQmcefprUgToYFMCzjpFNM964dF
         rhhuCjhGiiG5xaFl1XZkwVIjp/qJioqS88sq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065547; x=1706670347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWrjbDqCG/a53iknaUN5XiQX6sRbzWT8kV4u/Nqcod0=;
        b=AR73bUrhLBuLSndCJXt6jHzSwefEnBSji+1m+/V4zNX0nVDhHjHNYFvdB4EPHKJzuo
         vUlptwKdRTL7HB3Sism9FpfyqibpVsVhNpxh81HlTs9yc5nURt2OajdTF0gAEvwL8yun
         lR3hruaW7LIioDq1xs4iZqimp549+ZH0CFTckOBk3kXEG1txPErLrRu8wD6lZuUE4917
         ah1YT4xBSH7/05VISxcmW2mU2WmZ7LLJ+h73qozG/J/gK0BgjIwWTEqvM0EUMaYtL/qf
         pNwiIAA4cm7VCPdgTwhmKxAWxHM8A7zoSXAmSrEh0WoQNjhNPGDoB8CQqj41rpuHOTuM
         pFPQ==
X-Gm-Message-State: AOJu0YyKDCUn7Fbzz/EiySJLXNEI2Lwqqp3Qmx0OSZaYWXLNoggC3CJO
	CmSPWhn5rtmuBHZOqOGB3agVGt0S57XV5uNDvmGjcrLI02LykJjQvy35Rdez22N15KXR4K+EDdo
	bbrO6sBDwHfxoAhut/661ODZLrGVIJA==
X-Google-Smtp-Source: AGHT+IE2vHfCyYBih52W5M0f3AGmJiw1Z9U9eEUslAe6KVnFMwBp5+AcLPHZaEhOIqYfPDx3p0JRjIIhi8Zi
X-Received: by 2002:a05:6871:2887:b0:210:9047:1e47 with SMTP id bq7-20020a056871288700b0021090471e47mr2612080oac.60.1706065547131;
        Tue, 23 Jan 2024 19:05:47 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp-relay.gmail.com with ESMTPS id c22-20020a056830349600b006dc7502beabsm455320otu.3.2024.01.23.19.05.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 19:05:47 -0800 (PST)
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
Subject: [PATCH v3 10/10] mtd: rawnand: brcmnand: allow for on-die ecc
Date: Tue, 23 Jan 2024 19:04:58 -0800
Message-Id: <20240124030458.98408-11-dregan@broadcom.com>
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

Allow settings for on-die ecc such that if on-die ECC is selected
don't error out but require ECC strap setting of zero

Signed-off-by: David Regan <dregan@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
---
Changes in v3: None
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


