Return-Path: <linux-kernel+bounces-69315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE52858726
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB56E289E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3311534E3;
	Fri, 16 Feb 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JlO18UXd"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AC6150994
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115612; cv=none; b=RfUcevFIlKVaTOrQoDgUE7BJgQP0XnNgCkHfMKKXU5xfI7h2MkEaePW4Z+NXQjKFmfRsY1hxvQPpsBrq2Ez1mexUR1u93VSNIiKZPnIrN7puIgF7ton9kSmkTPRTwtdJr/GQ836i7zRJxW/piCcaHJOA3Gf9vjecNwEEu92A+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115612; c=relaxed/simple;
	bh=iWQpZyVUYNR0FgdTLJWWfXolJLly1aZ0q2sdWcfiADU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HmQ3F3AtXYmho2xl1uFIuqxY21soBKltA6U5b8IeaBSJpapeLqF7UqkBsMWWZmgmZq3+tWlmwEmQBXwjW3H3s+8tuoAV2GX3rs9GoCQZdaUHLQ/E0mTpuWJScUlUS2gaEJFlonXg0iuIIuDroupKjsSpYtzHd+eFnzYfJcttcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JlO18UXd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so29995951fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115608; x=1708720408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=JlO18UXdAY40EYPh5vQMlAFsIPsHixgABilZ9EkLiVRSYzLOSjW5w+ypfcbuMeHrfZ
         CjEn1EyR1b4/rA7fxre/BWWN0FumJvdbBNy7LiHW23Uu6JgXO3AM6b3HgrQuCxUexSO8
         8XpfNDuMNPm8XbbzzOhjM0K5uGImrSyKsDGkLl9V7jvCAEkeoP4cJwkHiR5U34FMABTe
         qFXW5mmFrbqL/QQqcnHl68kZl3ACLvKxIv8BqgCo+nyqzzqAviso6s6C5/trv4oan69U
         Q0X06jqsaVauq/rzu3/3ZqSQftU65tbC/WCOJ4wIWUW7SJBKnuP/5gxaSFP1Pe861jde
         u2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115608; x=1708720408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPKtETY44L+sLLhmL3uaX4nFnllKG+8eyvkbzTNtgX4=;
        b=bb8ON44qk6HKbpNXpI7XMZTCwgnBaYN/QQd/+dcKl6pwF0CdYez6NS/2GWPMRsuw9F
         f6vLoXe0n3BSl8oP/k4bTKbe1CDY/pjp7p5a0pmCaQ85r8dJasgbQJYv5KujTCTr94aZ
         jssVzeJcRSFhZ8+y92ObLtZaUqjoHaAxDJHN5Nik8nooJBTvEcrnmbSBxAL+X2lgxhxG
         1HkdGDXHa8adKsdtN0Q1xSVlSio8X94xN440E34PM40y5/SPUTO5tb9oqCBB+8fpLi+y
         6hIcJ5Ehy9Td5wNjQhEGxVfA2psN1OVvwI89/Tu3FagkwGOek1OvyY94diCuYxrudz/U
         3MTg==
X-Forwarded-Encrypted: i=1; AJvYcCUCG34oXhNl2/8AM/weYisEa0t7vZnENgk2oJf0iXKukB14nHh1r4hENb5IXl5nR8YMcTBQZeF3bD5fTh81Q5KQIF7T3YJqTbWA9G4P
X-Gm-Message-State: AOJu0Yxm7XBCEMSQN5S3FfCKpU725l/pEwMzTEH6HpLqW5PcBg2FdEYc
	+vfUg/tMBhN4HmIX/jfV7zt+m3zG2BOw6+wSs9a9KKzdogHeDiyp3/t9e0uAuwU=
X-Google-Smtp-Source: AGHT+IEA6PoShhob8vA8LHOTLObGA6LSgflaMRnbW+2bPuCja7p6p6LxUhdbKaL3IWhCeNx0gCY0nA==
X-Received: by 2002:a2e:9198:0:b0:2d0:cfe6:4364 with SMTP id f24-20020a2e9198000000b002d0cfe64364mr4325724ljg.36.1708115608679;
        Fri, 16 Feb 2024 12:33:28 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:28 -0800 (PST)
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
Subject: [PATCH v5 11/18] PCI/pwrctl: reuse the OF node for power controlled devices
Date: Fri, 16 Feb 2024 21:32:08 +0100
Message-Id: <20240216203215.40870-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
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


