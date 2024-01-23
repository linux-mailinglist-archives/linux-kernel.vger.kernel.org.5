Return-Path: <linux-kernel+bounces-34781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233C7838769
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4811F1C22C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3D57311;
	Tue, 23 Jan 2024 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBURJ1Yc"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF556B68;
	Tue, 23 Jan 2024 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991356; cv=none; b=MP9NuRepjNn4rOEPPqP5VFDwc4WfbSGh0srZ/ibS3TZwk7GMZa8HjrYfaHgo9AGbXN14xKWifE4BaUwPdaKfrJr35ENVi0o+IeOYPEuT0FQEANPTz7XEWeoDwE6ZFA84/00wg0QYwPy9SJ5SPWpE+Xz5POr/hZNoIM85ZFt/5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991356; c=relaxed/simple;
	bh=EgGgJPPMCxsC49KchIcWRFtw3jd16GCP6Tv9c/52e40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUwe7xTWQ7Ek59CGtRudmrCS+08KBaOtw3/Q+tPrV/NWpKfsSuN7suwrJ6ll8PTCAlYauM+nNb9dxssvIcDVmPSDGPW9SEZZoImG1XO7W8ejBgeGK1vfK54U4Q3zTa6Z2ttxyoyl7oI0R9PDN2uCDfW84RqhcMyi98z6aCIMxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBURJ1Yc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3891336b3a.0;
        Mon, 22 Jan 2024 22:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705991354; x=1706596154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu6Gw65kOYAMcVt2LO/nl23pdGClmlnX60UJoi2DF3Y=;
        b=XBURJ1YcWIuhZEL/hAwwCWZB4T3a4ggglFQhE2JfgU5EoWRACUIYZBelEEriN2XB2f
         WAZWuvu/xgpXUV0AE8tEnahS2OU+DG7oK3X9QgbkmqG0Tt3Kz3/0tdwqXEw9Mww2gTEQ
         lxbLjnEF5FE0gZbJXbjxkbogYtHNgGPHVz3bYbg0WxBVukdQ5CVS41oY6GVKvWu/6meJ
         DXt9rETTlpErV/RzSl4umvQjdrwlmROvabr7dJAxqD9j8JsWmrmO8gxJTDK/Mkr4ih7z
         H2oatjStuPfi2PcxKq5G8LhgIe0Eh7ceqCBabQkJ1wOesaCOYdxi4bsDmoJIW+uCBOKk
         FszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991354; x=1706596154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu6Gw65kOYAMcVt2LO/nl23pdGClmlnX60UJoi2DF3Y=;
        b=Wms0W8qLRANyGtcZAioMLOqZ0lWgjk0kbsFsjXox2ftuhAgOcpjMYpN0YZtAg4t/jS
         Iv5vuRBLYWlXx/eM1fIq+nBNPSkKf5WzJiWkx0EtFDeWm9WlIGoUEjJbT5PK+RjAleFq
         rJYmbgOagwhuHH9tt50hIx12MiMbZd7wvMVeRiSDogPZUCJV7njZ3jmz7hgA1Dno4KW3
         FLuIpxQ8SLuWor3GPAyWCgBJ//Ij/9svkLGyybPL3+D9VEtYTYaTW76eJJeB4ys3Cdd/
         +d9QJe4lMIvOwyCVQdmRlilQs38AjHkY+9I0xt9DEgqCsp4xASYtoVFjb4SkpWCQ/G/t
         in2A==
X-Gm-Message-State: AOJu0Yz4NY+h0vr7SAANbiMQqAdvhbTZ6fZwAoEFwpOXjfRttAvEp0eS
	kHhVfMYbreJcqjhJM5oK0opJ0I1QlXxEzioBWKwuGLAsDP/dL8TuuQtLlBWfcdc=
X-Google-Smtp-Source: AGHT+IHUrJq9iXQi92S7Pn8as5BvaSUDKBeOCNxSX6p3V/a5FvWiKU8wJw3+SHz1xC93CkM0Zi3B8g==
X-Received: by 2002:a05:6a20:4c2f:b0:19a:efad:dd53 with SMTP id fm47-20020a056a204c2f00b0019aefaddd53mr5722345pzb.94.1705991354321;
        Mon, 22 Jan 2024 22:29:14 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2ac-a4c6-7d2b-d8b3-ed27-1f50.emome-ip6.hinet.net. [2001:b400:e2ac:a4c6:7d2b:d8b3:ed27:1f50])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b006d9b2694b0csm10595188pfu.200.2024.01.22.22.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:29:14 -0800 (PST)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V14 11/21] mmc: sdhci-uhs2: add reset function function
Date: Tue, 23 Jan 2024 14:28:17 +0800
Message-Id: <20240123062827.8525-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123062827.8525-1-victorshihgli@gmail.com>
References: <20240123062827.8525-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
   sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mode().

Updates in V13:
 - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.

Updates in V8:
 - Adjust the position of matching brackets.

Updates in V6:
 - Remove unnecessary functions and simplify code.

---

 drivers/mmc/host/sdhci-uhs2.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 9cb0f1b2a37d..3d16f1ef9344 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -10,7 +10,9 @@
  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/iopoll.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -21,6 +23,8 @@
 #define SDHCI_UHS2_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
+#define UHS2_RESET_TIMEOUT_100MS		100000
+
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
 	if (!(mmc_card_uhs2(host->mmc)))
@@ -49,6 +53,39 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+/**
+ * sdhci_uhs2_reset - invoke SW reset
+ * @host: SDHCI host
+ * @mask: Control mask
+ *
+ * Invoke SW reset, depending on a bit in @mask and wait for completion.
+ */
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	u32 val;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL)
+		host->clock = 0;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
+				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
+		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
+			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
+		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 2bfe18d29bca..caaf9fba4975 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -177,5 +177,6 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1


