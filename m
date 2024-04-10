Return-Path: <linux-kernel+bounces-139526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9808A03F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513F91C2286C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191B40870;
	Wed, 10 Apr 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rd4S6tQL"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3943F9CB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791339; cv=none; b=asAnBWz1Rd2aOsoC8c/jFqgae5U9VrgRPvUAcb+m8BmBRxiTPkvEjKbcSsNPK1UmDmpdU9JoYKZHu5F7S1zJJPQjBjP423ttZxZ0eqR1XGrgRZ6pa43CvQxjj5YnWIAe7ZqI6+nqHSGVJPChwjkh99RqlB5CwBqzcZvo0dK0FJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791339; c=relaxed/simple;
	bh=C+gYjeg5zZ5V+ObjDETKL9RPwWWedDsQjvht1segjE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UD6CDluUPSCwSM/RDa73W9mAnabAfX0wCe6jmJSaPY3xtlUH9VLZg+72+tShTMYAgs06JFXaCnstxvuYZ/CnigeJRa3iA0NX6ctWC76rLG3zIf0y7ZL0/COg8p4tkEyiIPrvXgFUr8+KTRWi1VMDDCOjEgZgXEsrDbyuGuu3sJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Rd4S6tQL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so947806b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712791337; x=1713396137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtYSOn3SCnt1iF6Cpwohya7U+hEK19NDzm0dmKWZmA0=;
        b=Rd4S6tQL2l+fAc9KXFErFLHNKEDlUIvbIoGA5aQWJKA0kt0d0YV+f0IxZt9FXV4OhN
         QVzKJPjJamIsEE1IDVv4yn9NGkAOU0ltArZXZKcCUnFeIXXBZUtQtRRmWsaj1ElI2mph
         2iVAQgSJ75C/cJdexlhCRER+lx09Sz9ebhLh6nAlNpd5oluDrGnGdoS1y7Up3GRWvAw/
         UsAqlUiogFKhkM6yuOEGAzw8xJynOesqMtxyp70FwjPd6L7bQv9cdS38NJwA7UGvP9HZ
         TLxUh4byV5F57Z80jhJUwmXU7JKcl+Jz93wWoMgxXKC2qdZHU4FtzNMD27LNtLeZTHQy
         cfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791337; x=1713396137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtYSOn3SCnt1iF6Cpwohya7U+hEK19NDzm0dmKWZmA0=;
        b=ihQUzLoTUCHou+A0Ixr86q3zjsReXju9JewDyPWDuNLfymHG7XUO9/YqnuglfZnFOI
         /5t/YfK88xlGbDyqTiqUG9U2jSn1uGc2Tn9ijLfUHmj2RG6ysshNrZ0RVAPYygOLbRfy
         A+jQ6AadRo+QFACUJxWn45N8vnH8gd/1uAlr53lLOmaHsh1ERffF3aab/0kOM1z39Ig4
         lZSYq/u1F6i5d1OndBKPYQHI2Tr81vB7Oz07MWJBTwPr2rrhQLP9FgM8OVHFfC6+asBk
         YZmvNSMSl7iL3bWGoe/dI1SsQKI1pL41bAhCcTpdRYO67inuyxLnVHodYB7bUPyNPuWX
         sTaA==
X-Forwarded-Encrypted: i=1; AJvYcCVm8lpfA/vd0pbrQv2CZ2DHeSQ4eLPA5xH4msStiEYA2/spdG/mPrkiALEoOzqz95ECzwL5UIJXageRv8TPGowrzYAflxdycciimcTR
X-Gm-Message-State: AOJu0YwiQoxD9gSC8N7a/0hfVM0cjUQbyofeCWQWLXfECYDTfJNj2Mc+
	GkUS/S69wC4Ug+62MWZ5Mj9du169y1ayYdYoR82lP4EyUPOucBOW5Ky1dqjZRmiHeT7o4kKEi9O
	C
X-Google-Smtp-Source: AGHT+IGvaBONYQY7M1Nm4m+yg0Dzz07V09Xf33DgGd+N0sJJ6Z8nDrAUEytLry8/LOFs+9OnJyibVw==
X-Received: by 2002:a05:6a20:9145:b0:1a7:136c:c940 with SMTP id x5-20020a056a20914500b001a7136cc940mr5052313pzc.17.1712791337472;
        Wed, 10 Apr 2024 16:22:17 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm161865pjq.40.2024.04.10.16.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:22:17 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] cache: sifive_ccache: Add EDAC and PMU as auxiliary devices
Date: Wed, 10 Apr 2024 16:22:06 -0700
Message-ID: <20240410232211.438277-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410232211.438277-1-samuel.holland@sifive.com>
References: <20240410232211.438277-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the child drivers to access the Composable Cache device's
MMIO space and ties them to the lifecycle of the main platform device.

Currently, the EDAC driver is probed regardless of whether a Composable
Cache device actually exists on the system. Once converted to use the
auxiliary device bus, it will only be probed when needed.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/cache/Kconfig              |  1 +
 drivers/cache/sifive_ccache.c      | 42 ++++++++++++++++++++++++++++++
 include/soc/sifive/sifive_ccache.h |  4 +++
 3 files changed, 47 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 9345ce4976d7..08e0415eba80 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -11,6 +11,7 @@ config AX45MP_L2_CACHE
 config SIFIVE_CCACHE
 	bool "Sifive Composable Cache controller"
 	depends on ARCH_SIFIVE || ARCH_STARFIVE
+	select AUXILIARY_BUS
 	help
 	  Support for the composable cache controller on SiFive platforms.
 
diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index 42dac39c41cf..c7aa6f360967 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "CCACHE: " fmt
 
 #include <linux/align.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
@@ -249,6 +250,39 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	return IRQ_HANDLED;
 }
 
+static void sifive_ccache_del_aux_dev(void *adev)
+{
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int sifive_ccache_add_aux_dev(struct device *dev, struct auxiliary_device *adev,
+				     const char *name)
+{
+	int rc;
+
+	adev->dev.parent = dev;
+	adev->name = name;
+
+	rc = auxiliary_device_init(adev);
+	if (rc)
+		return rc;
+
+	rc = auxiliary_device_add(adev);
+	if (rc)
+		goto err_uninit;
+
+	rc = devm_add_action_or_reset(dev, sifive_ccache_del_aux_dev, adev);
+	if (rc)
+		return rc;
+
+	return 0;
+
+err_uninit:
+	auxiliary_device_uninit(adev);
+	return rc;
+}
+
 static int sifive_ccache_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -274,6 +308,14 @@ static int sifive_ccache_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, rc, "Could not request IRQ %d\n", g_irq[i]);
 	}
 
+	rc = sifive_ccache_add_aux_dev(dev, &ccache.edac_dev, "edac");
+	if (rc)
+		return rc;
+
+	rc = sifive_ccache_add_aux_dev(dev, &ccache.pmu_dev, "pmu");
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
diff --git a/include/soc/sifive/sifive_ccache.h b/include/soc/sifive/sifive_ccache.h
index 85fd1ff1355a..034dc8b6e4e4 100644
--- a/include/soc/sifive/sifive_ccache.h
+++ b/include/soc/sifive/sifive_ccache.h
@@ -7,8 +7,12 @@
 #ifndef __SOC_SIFIVE_CCACHE_H
 #define __SOC_SIFIVE_CCACHE_H
 
+#include <linux/auxiliary_bus.h>
+
 struct sifive_ccache {
 	void __iomem		*base;
+	struct auxiliary_device	edac_dev;
+	struct auxiliary_device	pmu_dev;
 };
 
 extern int register_sifive_ccache_error_notifier(struct notifier_block *nb);
-- 
2.44.0


