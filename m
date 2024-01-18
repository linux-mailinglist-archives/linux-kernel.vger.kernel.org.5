Return-Path: <linux-kernel+bounces-30538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C2832007
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386AC284D52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA7341AC;
	Thu, 18 Jan 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FymkCagb"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7109328C1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607676; cv=none; b=OfnaiKzmvCqGdkp7wgVJ8XivFeoBB54+du3cSOB7cw8GqisWjDD6n8ddYuM8IsXCb24wIbgcJtlJQztK7hRnrgstOiA4NTHyoCOe4pZbDG2yLTS5dtzL3fh+UdJWCe8B5wK1YFf5G2sldbTesNE/Fb50vE49UUqVB1GGFX0n06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607676; c=relaxed/simple;
	bh=PaTYgclHJjy3rVawJ+5Hzr2JEAWEEUuHVget8mHkU4w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZdMtyD89NNYjntKwWUEAQ/SabdyBTEz8yRKJdTboIllrt0sOHje+yzSfDvufrdaGnV5j/BenhrWD1vP3a1UG/DqtVLeCigFuQ/aZLD+zoEko7rokiqhMXTVaCYV5sT/Lfhl57VSBOpfJ2u4POfUsjZbO8pchJoCqRmACPaFhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FymkCagb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28e7b4546e2so889412a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705607674; x=1706212474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+ZNuMLiQVEBIU4qP2AxAyGfcGqRo4EmDBOaCTelFQA=;
        b=FymkCagbqTK5212RmfJ0TEZKx4oBfERg3cNsCDXCbb6YRnnFmrFjiCJmOoWagQwpZV
         5TmAGfATPs5CwCJC59zqYAK7eWo44AcP7mAgbVtzCrzH97nOc4Lb0O9Fplg1MB0cq6eh
         xmT5s7LJ9q/G6AnpOfBD7YeWOoNJ+FBmXnIpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607674; x=1706212474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+ZNuMLiQVEBIU4qP2AxAyGfcGqRo4EmDBOaCTelFQA=;
        b=J2e0MjgLuDJmDa9Kvmc0c09OOO6W3fXEyuXDqXfuPF/fho2to738zUf9Owzve5KRpB
         FjII1HQMTMjPvTo2OLAT9isLBZp6txFrTS9avtGRIgor3alNy1pdCmpTNnjTHKKY0l4Q
         64AbAQJWkfCoIwdbkYVdns7GvP9sYJNrFiZOTpVlXWwjbp6JAAbEU3toN9E8M7rrxnDU
         MNhgCmY5UbRtQvi3cAXnF9vZkRgWWyX8T1J5r48jRxr+/ZFf3vmP820njWIyvtzEbnQ+
         zlnXHcCJf2RchJHunQuyT4qNr80/5cUE7TYCooe2Img8s6bY1+cXtXLySAoot1+kpsHe
         Kdjw==
X-Gm-Message-State: AOJu0Yw2bD0LMkNyiAEdJzvrQJQT+7TXkBoZU0OLer8lgxaluPCvHC2W
	db+3fOKQiiQX18V9QV0IIlWGHLw80GQRFa/5HfzZOl5L5Uv2TZ8lOn909PuPIg==
X-Google-Smtp-Source: AGHT+IEJ3qIWczlfChoU8rtUAqv8+jLQdgG90HPXrESS4HZTszddZNh5owLB7/ayia0byi0ZhWT++w==
X-Received: by 2002:a17:90a:241:b0:28f:f249:3c4a with SMTP id t1-20020a17090a024100b0028ff2493c4amr3931395pje.19.1705607674171;
        Thu, 18 Jan 2024 11:54:34 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id rr12-20020a17090b2b4c00b0028d9b5d41edsm2263805pjb.38.2024.01.18.11.54.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:54:33 -0800 (PST)
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
Subject: [PATCH v2 07/10] mtd: rawnand: brcmnand: Support write protection setting from dts
Date: Thu, 18 Jan 2024 11:53:53 -0800
Message-Id: <20240118195356.133391-8-dregan@broadcom.com>
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

From: William Zhang <william.zhang@broadcom.com>

The write protection feature is controlled by the module parameter wp_on
with default set to enabled. But not all the board use this feature
especially in BCMBCA broadband board. And module parameter is not
sufficient as different board can have different option.  Add a device
tree property and allow this feature to be configured through the board
dts on per board basis.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: David Regan <dregan@broadcom.com>
---
Changes in v2: None
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 869ea64e9189..9a904c7c6dad 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -3081,7 +3081,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	struct brcmnand_controller *ctrl;
 	struct brcmnand_host *host;
 	struct resource *res;
-	int ret;
+	int ret, wp_dt;
 
 	if (dn && !of_match_node(brcmnand_of_match, dn))
 		return -ENODEV;
@@ -3218,6 +3218,12 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	/* Disable XOR addressing */
 	brcmnand_rmw_reg(ctrl, BRCMNAND_CS_XOR, 0xff, 0, 0);
 
+	/* Not all boards support write protect (WP), check DT property */
+	if (of_property_read_u32(dn, "brcm,nand-use-wp", &wp_dt) == 0) {
+		if (wp_dt >= 0 && wp_dt <= 2)
+			wp_on = wp_dt;
+	}
+
 	if (ctrl->features & BRCMNAND_HAS_WP) {
 		/* Permanently disable write protection */
 		if (wp_on == 2)
-- 
2.37.3


