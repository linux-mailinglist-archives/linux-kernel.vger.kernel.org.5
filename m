Return-Path: <linux-kernel+bounces-135999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572089CEC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1424283808
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7EB14A094;
	Mon,  8 Apr 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpoY5xr6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E753146A8C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618005; cv=none; b=Pc3Quj6iusj5fEU7De83Fas2JG8PbrE7SLW3OT7iJmUKMdlyTWudOFEWQBBiflts5L2tmNJ32oXTLDG04Y/jMvlutsj0IrZJ+oDNCp6RFziomKR3dAlnF0mqRjZAzDnimlWbSWMWuZNOLXGY0Rqo2lYyxfzvKIUXWHh8UqlKYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618005; c=relaxed/simple;
	bh=UeZnCjsFlLic2qaSZoKNxomMdFYr768316T0wajX8u0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=FEvOwz4kML7oD5KeYok1mohIxuh83IUeql7CMewi77NWtDj0sxP0IxHig/90sI64a6QcA80QUo6XjEAwJZ3CXuER83WEwgwzDQJlj4WnNSlWa1DJ4IJxgrZtqwbeoy+G4Ww/TZpIVt8f2qy2XmcQbbd8tAVAQcR6bMDGBZL8ZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpoY5xr6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150dcdf83fso96950647b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712618003; x=1713222803; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHsEtZCKaHOJpKzkmFo1QTaciQX5xyBED5wwHFx24rA=;
        b=wpoY5xr6Eg6EIdLC4rv+CVpg8IK9m7r88Lq7sUjAN7JGmqQnHUkl7ZJNKkRv0aMcTo
         G1q5jvy3BPbTzUPL45v80/RmMSq10sQsTLzvUIprfThwt2mCsYXpoIry45LtahYfHeXX
         lFA0jtqu0e1KKoKr/7FAEVJcTzC6JYjpZtwpD8ucViQ2BfIULB+VYBuFlbLMjflb6nbF
         u2jVj527tvgYe2csd7Pejh+P0yQ613LZM08jj0G9cyKAey127wcXoUnBQL/XZv8aqqk0
         DBex7aHqv89gyXDNihMRO03qbY014eM2KPxKq9jWb5B35cu3LwnJ8+Sy+Z/QcS02pqlw
         G3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712618003; x=1713222803;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHsEtZCKaHOJpKzkmFo1QTaciQX5xyBED5wwHFx24rA=;
        b=jvH/mapK9jyHwEMYqVfZXX1HuPJURgIbsbEnhTrThsa9AjVHEnps5dYRf8207Jx472
         RaqOuptE4PjQzsnLuUn4VOZL9vczzs6viW7B9ceZCOfmJFA69vZ7O5JoywnW7S8lWpLB
         ehKomoL1qps+lW5rED/RYF5gd/OGd63sZYckDjIs4lP3Nufo9irCrI10oePfCJXKjamt
         HKrpgNusCmbFK0NNCVtLmsP2Xs2obh7QV3brtuaj6yacdrsmDUs1a78rZoX8E8COXF3d
         ib2g1X6R96oIa5C/4JBTQTNjWYAHLL20OIMT87vc1K92hKrz3qSObe4YyM8Zv3g6z0Kq
         /90g==
X-Forwarded-Encrypted: i=1; AJvYcCVwFqrYKoO4cLF2SVpB9pfvCCIwX4Fv8UK6Hsa+OF6UwhsIWuOWKsHLOSIzkhHVX/TGjFW0cLSrP6vGnx+lgFGBmOLH5rOATvvhwaEe
X-Gm-Message-State: AOJu0YzkvbWT+mQ2pRAQHZttaeMs8IORIB/sU5Li8Z6UU0W04H+Bm9IJ
	pZdJZejNRUW68fdCFYBLskJQEkT9TgVmdLYxJvtppegDKTbnUVAlwgeC611FYXy/8NRY4ZnGQdJ
	7Ez2rGwbLH5DYcg==
X-Google-Smtp-Source: AGHT+IGUNVwH6Vn5KU9h3xgJ3juWehgll1GRUIrL/52jY9NzlwNFR0T9bAXNZP4TZgr6puPAMVlsBtbBaZPruJU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:96d3:321a:67f3:5322])
 (user=saravanak job=sendgmr) by 2002:a05:690c:6e09:b0:615:33de:61d5 with SMTP
 id jb9-20020a05690c6e0900b0061533de61d5mr2900141ywb.1.1712618003548; Mon, 08
 Apr 2024 16:13:23 -0700 (PDT)
Date: Mon,  8 Apr 2024 16:13:08 -0700
In-Reply-To: <20240408231310.325451-1-saravanak@google.com>
Message-Id: <20240408231310.325451-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408231310.325451-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [RFC PATCH v1 1/2] Revert "treewide: Fix probing of devices in DT overlays"
From: Saravana Kannan <saravanak@google.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
---
 drivers/bus/imx-weim.c    | 6 ------
 drivers/i2c/i2c-core-of.c | 5 -----
 drivers/of/dynamic.c      | 1 -
 drivers/of/platform.c     | 5 -----
 drivers/spi/spi.c         | 5 -----
 5 files changed, 22 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 837bf9d51c6e..caaf887e0ccc 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -331,12 +331,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
 				 "Failed to setup timing for '%pOF'\n", rd->dn);
 
 		if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
-			/*
-			 * Clear the flag before adding the device so that
-			 * fw_devlink doesn't skip adding consumers to this
-			 * device.
-			 */
-			rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 			if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
 				dev_err(&pdev->dev,
 					"Failed to create child device '%pOF'\n",
diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index a6c407d36800..a250921bbce0 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -178,11 +178,6 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 			return NOTIFY_OK;
 		}
 
-		/*
-		 * Clear the flag before adding the device so that fw_devlink
-		 * doesn't skip adding consumers to this device.
-		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		client = of_i2c_register_device(adap, rd->dn);
 		if (IS_ERR(client)) {
 			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 4d57a4e34105..19a1a38554f2 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -224,7 +224,6 @@ static void __of_attach_node(struct device_node *np)
 	np->sibling = np->parent->child;
 	np->parent->child = np;
 	of_node_clear_flag(np, OF_DETACHED);
-	np->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
 
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 389d4ea6bfc1..efd861fa254f 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -743,11 +743,6 @@ static int of_platform_notify(struct notifier_block *nb,
 		if (of_node_check_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_OK;
 
-		/*
-		 * Clear the flag before adding the device so that fw_devlink
-		 * doesn't skip adding consumers to this device.
-		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		/* pdev_parent may be NULL when no bus platform device */
 		pdev_parent = of_find_device_by_node(rd->dn->parent);
 		pdev = of_platform_device_create(rd->dn, NULL,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff75838c1b5d..17cd417f7681 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4761,11 +4761,6 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 			return NOTIFY_OK;
 		}
 
-		/*
-		 * Clear the flag before adding the device so that fw_devlink
-		 * doesn't skip adding consumers to this device.
-		 */
-		rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
 		spi = of_register_spi_device(ctlr, rd->dn);
 		put_device(&ctlr->dev);
 
-- 
2.44.0.478.gd926399ef9-goog


