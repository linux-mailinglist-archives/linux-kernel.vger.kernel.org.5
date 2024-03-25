Return-Path: <linux-kernel+bounces-117111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B788A76D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9507B303AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B114D44E;
	Mon, 25 Mar 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cUbS4nGT"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAD514D71A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372637; cv=none; b=FrxybXiVeV4VQwjXbQ6ML0r/Tp8Vtl9OIZ7p7yhVM2JB3WRpx0ce4B62SDSjmtctyl8VDIK/qKhEA6EzmSgCja8ZQ9jQPD5E43K9nbclxuVV7KFoKbp2+zNETOwP1X9Wz5xjISKz2FYS8R4QzqloE00CkUS6qLPVDAwEYrIfMA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372637; c=relaxed/simple;
	bh=iWQpZyVUYNR0FgdTLJWWfXolJLly1aZ0q2sdWcfiADU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thpCrRcCfW6cN18euRkDfYZ9LxVd4UgKc4u3gapUYzK26gSlRwatRvj9LeRHfwvTrLWwGmz+44rPwiwZr06uVmRzSpbTCrKEYULNQnFJOXPeKxT3yy2Vpe6dYQPOKzchyUgKmnRELvdW/48ygtILnmDgPzpLqdwNMVnXAuwGj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cUbS4nGT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso3073463f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372632; x=1711977432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=cUbS4nGT0+lfRnrunIb/YNFs5x5KjLBB5tZj58rqQZ7yj/oqsNqHDCkLnoS6eAcE3p
         gsyW+n+o3iwItVVdhcFdeenW8F1X5Zt3O/JWzE37VCVkAFHXC8C8FnbosWgnOOP9C+01
         mhG2DfaImEHlzrhbgbnliOF2Xe6PQzer30VhTpSvo9gydkqSBz3w+wqTbWeyNBwgkeqb
         VaocQURcHNwf9IiMy9cyCF2mMu3uwlcIcd9bFMW6hIMA32tf9SVptNUb0H6rESyOwQHK
         OXHdbOdnZFO0PnOCjWAH0Z2FaSVX1LU9+/EefNDKZsGMxv6Kqlm9cqyHLPM6gPRaOHty
         Mzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372632; x=1711977432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=vChF5mqLYuWaIVCTq53YiVGKsmK7k/mzRF50YOplW4MrAhMfLoocQCmEzFd79lF7Yo
         djJa0y/N2giBjJSUSGHqcy7iS5mq3ebhjvKD2Dpu/HyNA6GO2bbU+Z90QHxa/7eCgngQ
         nur7q4dgHKCAr9hvmPrG0qFzdMuG04oAbFt1At9hpCm8K1lVnfgOapeAKxPg02OMdTVp
         etya5ZZiaN29Qr4Mo3gO6bPGlpv8pz2+yuFlhqqKiETwL0tbkT18/hpcu8yuYMg41os5
         M9MuLysaF0NL+crChfytHdUqpDKZb2Q0u5pcX4Hd6TkM9j4FWBCAI7fabbd2JPTtHbsf
         mc9g==
X-Forwarded-Encrypted: i=1; AJvYcCUVzf3U+Sefs2e4fSDaVU6e27nBtD5zCxoqAfgHaa9wZVJisCslvkgU3sdPd5vP4KDecQlJYvY8XCv7pkhaD2yeG4abt3AtcemqQDbe
X-Gm-Message-State: AOJu0YwgTYngdRo2BhP3dHss2evaev2tMv+urIjJrnt7OceKOcz8l897
	50xSRSwY3f06cKrrNVkAazp0KLIkAE0MHCLTRyc/rziJVcLG5jyCZoGhaEUGwhw=
X-Google-Smtp-Source: AGHT+IE8S1Cqc4BSl1gj1NJjC/8Phc5hQVnSu5kD3rjt0a7CtT1C9cZCCiVYJzGQ4RLrhpqJ51Qh5g==
X-Received: by 2002:a5d:4bd1:0:b0:33d:b2d7:6264 with SMTP id l17-20020a5d4bd1000000b0033db2d76264mr4900718wrt.51.1711372632066;
        Mon, 25 Mar 2024 06:17:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:17:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 10/16] PCI/pwrctl: reuse the OF node for power controlled devices
Date: Mon, 25 Mar 2024 14:16:18 +0100
Message-Id: <20240325131624.26023-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With PCI power control we deal with two struct device objects bound to
two different drivers but consuming the same OF node. We must not bind
the pinctrl twice. To that end: before setting the OF node of the newly
instantiated PCI device, check if a platform device consuming the same
OF node doesn't already exist on the platform bus and - if so - mark the
PCI device as reusing the OF node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..b908fe1ae951 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -13,6 +14,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/platform_device.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -25,16 +27,20 @@
  */
 int pci_set_of_node(struct pci_dev *dev)
 {
-	struct device_node *node;
-
 	if (!dev->bus->dev.of_node)
 		return 0;
 
-	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
+	struct device_node *node __free(device_node) =
+		of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
 	if (!node)
 		return 0;
 
-	device_set_node(&dev->dev, of_fwnode_handle(node));
+	struct device *pdev __free(put_device) =
+		bus_find_device_by_of_node(&platform_bus_type, node);
+	if (pdev)
+		dev->bus->dev.of_node_reused = true;
+
+	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
 }
 
-- 
2.40.1


