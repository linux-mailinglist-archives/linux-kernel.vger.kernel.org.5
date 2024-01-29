Return-Path: <linux-kernel+bounces-42873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728C3840804
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF91C211F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842866B2E;
	Mon, 29 Jan 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIdv6Wzr"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A875664C9;
	Mon, 29 Jan 2024 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537803; cv=none; b=AKmxeOm04y+evRYzhGt4vxH6tGSQnjomJtI7lDyx2oXVfcaYNJ4FATASVuwRIAlPsGj+cw4c/lBQfBTeDbyNIhCwSNFuowFJKU0+CnRhxtC0IfhvVHHGdxbyLMAKsebcrwAvqRuU4ogUnXGfCelYOddzMbne8FIgoMOldsv2wlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537803; c=relaxed/simple;
	bh=+EExTy2u6AlSztElz9tL2ssdCDBEksPhvdbRRK9RYmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZWyF/Hs2xDFARpoOCQcD415LaO6k2KZEIep9CFqMW9ETdcjvGtagh6ezNeIlvEA0hKYzcdqz8F4nvYI23NO8J4092l0QVgLG9x2BSUyAgxqhhetADVqW+kn0SY09NotiptUnnP4lItaGsxEGiVPojZ3hUZJ+do5hlBTr/Eifz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIdv6Wzr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so213260a12.2;
        Mon, 29 Jan 2024 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706537800; x=1707142600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgIbJQBIdKijDrsyTdVViX5YcJJgoOCIyCGBsI9jQnM=;
        b=FIdv6Wzr04WadfFdxNYIqe3vke+UpvXEHrWYjcsPIzoY6vqgzOqmNN2GjdZNOE1LTV
         9jvA/KS8cqhUFEJmtO6V7Bv17Nj7yXhjbC3+ulA91ltz3yIfZz7aHbTPc8vBJL3jKQL2
         DpYJ7wLUAQWdpwX7Qxe48xO8BeC/ZAZCaeYcLa4F7Kaa6fk30Pjm72hqX2WvIU3dm9P/
         XVW23p7bnyrMgMms++ggf5JgfMuph4qkQMLzWvxsgHiJJFlCvK0KoyT8WpxalirjMDMA
         4OXV8U353f2AiAFfZ5WCw8LiaWUKi1gdyQxm+HRGaJDijMk8gI0ya49HeWQmog2FbWR+
         BJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537800; x=1707142600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgIbJQBIdKijDrsyTdVViX5YcJJgoOCIyCGBsI9jQnM=;
        b=h12RsSV0IEatGG16u+CMA7Uvu+xd+5N0h9WQgbxwMMRNPehOELKV5lYvbcStmR1Lbj
         MToc1AjpaezssS5og4hONdioOi603iwTELoAx7fUBTdimH6VgfVZNeoW3Gugu92/PqMB
         svPtIaNaX7b4v/QjT8BOd5Twqm/CsSU0Eqo16rAfgndxCJ8NbbxN3IYjebP1rcdJ15p7
         GsV90GmCCjR/8t8xEGe1FEENaSbuquHC+5msKNrDjL8dbu/t1na9d1IQEdQ3nDjF+pA/
         eUmGeEPzFIX9FBLiZFu547HtH+l2/3yFvZHrn+ba8AIYlQtpHVGJnA1k9LF5OnrGoyg/
         LOfw==
X-Gm-Message-State: AOJu0YwtSkFTC7Nt21615qge/SZgBK3eP1PRg4O15niFi4GFLN859//K
	qn1CnjaJ+3l9I1Rk7xUgCcoB+CsCMVPc+CDdF17MadjGuJmwvWXa
X-Google-Smtp-Source: AGHT+IE1y8qeE9EPBl7gCN4c0FCSyAJsrCBac8RPFxM/xKTtH8Poo5WghCnaOu7Zuk3F9jyIaVtDog==
X-Received: by 2002:a17:906:1c55:b0:a28:7fe8:8b29 with SMTP id l21-20020a1709061c5500b00a287fe88b29mr5410571ejg.68.1706537800015;
        Mon, 29 Jan 2024 06:16:40 -0800 (PST)
Received: from localhost.localdomain ([78.208.142.203])
        by smtp.googlemail.com with ESMTPSA id cu12-20020a170906ba8c00b00a27a32e6502sm3919470ejd.117.2024.01.29.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:16:39 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v4 1/5] net: phy: move at803x PHY driver to dedicated directory
Date: Mon, 29 Jan 2024 15:15:19 +0100
Message-ID: <20240129141600.2592-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129141600.2592-1-ansuelsmth@gmail.com>
References: <20240129141600.2592-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for addition of other Qcom PHY and to tidy things up,
move the at803x PHY driver to dedicated directory.

The same order in the Kconfig selection is saved.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig             | 7 +------
 drivers/net/phy/Makefile            | 2 +-
 drivers/net/phy/qcom/Kconfig        | 7 +++++++
 drivers/net/phy/qcom/Makefile       | 2 ++
 drivers/net/phy/{ => qcom}/at803x.c | 0
 5 files changed, 11 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/phy/qcom/Kconfig
 create mode 100644 drivers/net/phy/qcom/Makefile
 rename drivers/net/phy/{ => qcom}/at803x.c (100%)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 9e2672800f0b..e261e58bf158 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -335,12 +335,7 @@ config NCN26000_PHY
 	  Currently supports the NCN26000 10BASE-T1S Industrial PHY
 	  with MII interface.
 
-config AT803X_PHY
-	tristate "Qualcomm Atheros AR803X PHYs and QCA833x PHYs"
-	depends on REGULATOR
-	help
-	  Currently supports the AR8030, AR8031, AR8033, AR8035 and internal
-	  QCA8337(Internal qca8k PHY) model
+source "drivers/net/phy/qcom/Kconfig"
 
 config QSEMI_PHY
 	tristate "Quality Semiconductor PHYs"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 6097afd44392..197acfa0b412 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
-obj-$(CONFIG_AT803X_PHY)	+= at803x.o
 ifdef CONFIG_AX88796B_RUST_PHY
   obj-$(CONFIG_AX88796B_PHY)	+= ax88796b_rust.o
 else
@@ -91,6 +90,7 @@ endif
 obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja.o
 obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
+obj-y				+= qcom/
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 obj-$(CONFIG_REALTEK_PHY)	+= realtek.o
 obj-$(CONFIG_RENESAS_PHY)	+= uPD60620.o
diff --git a/drivers/net/phy/qcom/Kconfig b/drivers/net/phy/qcom/Kconfig
new file mode 100644
index 000000000000..2c274fbbe410
--- /dev/null
+++ b/drivers/net/phy/qcom/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config AT803X_PHY
+	tristate "Qualcomm Atheros AR803X PHYs and QCA833x PHYs"
+	depends on REGULATOR
+	help
+	  Currently supports the AR8030, AR8031, AR8033, AR8035 and internal
+	  QCA8337(Internal qca8k PHY) model
diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
new file mode 100644
index 000000000000..6a68da8aaa7b
--- /dev/null
+++ b/drivers/net/phy/qcom/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_AT803X_PHY)	+= at803x.o
diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/qcom/at803x.c
similarity index 100%
rename from drivers/net/phy/at803x.c
rename to drivers/net/phy/qcom/at803x.c
-- 
2.43.0


