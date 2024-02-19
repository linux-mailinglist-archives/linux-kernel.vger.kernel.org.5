Return-Path: <linux-kernel+bounces-70760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78998859BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE601C20DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4C20DE1;
	Mon, 19 Feb 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ft7Oxg8O"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68920B35
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323069; cv=none; b=OSBWSmhv30lJKa/F4HhQpELcB1B2jhzN6nPyoDm039yGC6TK+YhJ1tyy7KLkE4jkkSmvJR3qKvQLDp8F2eIRZdU3YeuVxB/hmXg7D8c30ZEAQFPl6afVvx0maAm2bbr52OJe5+j0mNqC5dkY0GWsKkq9SpM2nz5kx18aqyMbkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323069; c=relaxed/simple;
	bh=HtGG0/RfvtH7s+ui0pzbBr0R2lgMfFDP9I164eit4A8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2YN662byE9w2G0Rr8jQoQtESVHdMXQbHYaWU9dj1xmEtqwoWrp/g6A47PnChpLrBpioDtJGCcX3sKQzeyWPtcfxJKi77S+WCudauXIuxPrvTxiJ9NkGrCzcvSa0c9OxpKd571VK+H0pr2XG30yJUff/gBKGJirK1kYxzbtAM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ft7Oxg8O; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74645bfa8so5579300276.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708323067; x=1708927867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0UCGzE9XzoSgZHJhdATrkQ8JGBIvoj4u5hKA82RY5w=;
        b=ft7Oxg8OQHPPCknHSxAXte7z8ElCOyEautUpZ9RrE6ZIREuYvHH3Q6tbIS7xLjjGuJ
         n5T7KIjDBbt0mArhfq97QB0dC59TpxgXkxFPW7UNWzKViDNFcLjJ+xvVkaPdCpVNsTzH
         hr/f0Xf2s1HURwmTePaIDMoznfVHCJHtn3KArDu19WOpuzbKkNPX633EMwsg1unXOjzB
         OfCRuliusmAOKH2Bit9dD7ojVg7rh/IwErBpxBSZ69VvUva9wwgpRPfOJmZzVAlBrKMr
         4gjdxkkYwKupfFLQtmiF8X3cwHoLD/hMw59/RwG/z3AsvaYg5Yr2S/A2ZVJHIGLXgpLH
         Fazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708323067; x=1708927867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0UCGzE9XzoSgZHJhdATrkQ8JGBIvoj4u5hKA82RY5w=;
        b=HZpOPd1qGoqdhkJLM2hfcwW99weaKW4f0Gk6Sresa9sLfZGhmTQ1EyCcZONjF0/r2E
         dgoBPrI0zgLg8n8n37/V15wIowZEyomWI7FSESiQGB9gvEALvY9p56RuY7zHtAgdx7+F
         budPmre5H+WoX39zwa64fFB6iBQups3200qOWW9HUe6wN0zDOR6INNtHQLb4Dyi6/IWO
         DnHPSR6dp/cD8ultEf+Q3/QIHTBVEoo3UnZnWMR7Rzx/2Lmq0xmM4+jtqiPuGJDZp9T8
         lMzWxtGRmHNHlpx6xAD0zllQKXdpQbqLbJbREuwLPNwBgbz+0fA3Dta5Xqw4ceFrvL+g
         Flfg==
X-Forwarded-Encrypted: i=1; AJvYcCXISaes38GakwcdPPusvNI38t+ZJyfNY4sHXNBd27M+yUpNIDNU+FI7KgJjj5LSv+C2AwTSLggmk8da2xBmu0KJs3rMzC0UujZFX5z9
X-Gm-Message-State: AOJu0Yzwk33m34plns11spxJu3Jo9Tt9MldlHUOOJdkDVTkRB9e1wLXI
	uwYVVLaJ2NJD+r42GVEcNHvO4lEnEn5NZw4obVAm92hC5cwwSu3PVX9Uu0ITsRWm9Er8gQYGqTB
	HCSegHA==
X-Google-Smtp-Source: AGHT+IFFZKDLvXQxZdmvs8iUCbWZSI06ZVUiveFCaZqwdYIpYMzr0ShyN632SuT3DZjrN9JqogAZyUF7McA9
X-Received: from pumahsu-p620linsp01.ntc.corp.google.com ([2401:fa00:fc:202:c8b2:b71:a506:971a])
 (user=pumahsu job=sendgmr) by 2002:a05:6902:18d4:b0:dcd:2f2d:7a0f with SMTP
 id ck20-20020a05690218d400b00dcd2f2d7a0fmr402399ybb.9.1708323067195; Sun, 18
 Feb 2024 22:11:07 -0800 (PST)
Date: Mon, 19 Feb 2024 14:10:07 +0800
In-Reply-To: <20240219061008.1761102-1-pumahsu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219061008.1761102-1-pumahsu@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219061008.1761102-3-pumahsu@google.com>
Subject: [PATCH 2/3] usb: xhci: Add support for Google XHCI controller
From: Puma Hsu <pumahsu@google.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	Thinh.Nguyen@synopsys.com
Cc: badhri@google.com, royluo@google.com, howardyen@google.com, 
	albertccwang@google.com, raychi@google.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"

In our SoC platform, we support allocating dedicated memory spaces
other than system memory for XHCI, which also requires IOMMU mapping.
The rest of driver probing and executing will use the generic
xhci-plat driver.

We support USB dual roles and switch roles by generic dwc3 driver,
the dwc3 driver always probes xhci-plat driver now, so we introduce
a device tree property to probe a XHCI glue driver.

Sample:
  xhci_dma: xhci_dma@99C0000 {
    compatible = "shared-dma-pool";
    reg = <0x00000000 0x99C0000 0x00000000 0x40000>;
    no-map;
  };

  dwc3: dwc3@c400000 {
    compatible = "snps,dwc3";
    reg = <0 0x0c400000  0 0x10000>;
    xhci-glue = "xhci-hcd-goog";
    memory-region = <&xhci_dma>;
    iommus = <&cpuacc_mmu 0x8100>;
  };

Signed-off-by: Puma Hsu <pumahsu@google.com>
---
 drivers/usb/dwc3/host.c      |   8 +-
 drivers/usb/host/Kconfig     |   6 ++
 drivers/usb/host/Makefile    |   1 +
 drivers/usb/host/xhci-goog.c | 154 +++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci-goog.c

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index ae189b7a4f8b..45114c0fc38d 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -109,6 +109,7 @@ int dwc3_host_init(struct dwc3 *dwc)
 	struct platform_device	*xhci;
 	int			ret, irq;
 	int			prop_idx = 0;
+	const char		*xhci_glue;
 
 	/*
 	 * Some platforms need to power off all Root hub ports immediately after DWC3 set to host
@@ -121,7 +122,12 @@ int dwc3_host_init(struct dwc3 *dwc)
 	if (irq < 0)
 		return irq;
 
-	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
+	device_property_read_string(dwc->dev, "xhci-glue", &xhci_glue);
+	if (xhci_glue)
+		xhci = platform_device_alloc(xhci_glue, PLATFORM_DEVID_AUTO);
+	else
+		xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
+
 	if (!xhci) {
 		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
 		return -ENOMEM;
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4448d0ab06f0..1c1613c548d9 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -61,6 +61,12 @@ config USB_XHCI_PLATFORM
 
 	  If unsure, say N.
 
+config USB_XHCI_GOOG
+	tristate "xHCI support for Google Tensor SoCs"
+	help
+	  Say 'Y' to enable the support for the xHCI host controller
+	  found in Google Tensor SoCs.
+	  If unsure, say N.
+
 config USB_XHCI_HISTB
 	tristate "xHCI support for HiSilicon STB SoCs"
 	depends on USB_XHCI_PLATFORM && (ARCH_HISI || COMPILE_TEST)
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index be4e5245c52f..76f315a1aa76 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -85,3 +85,4 @@ obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
 obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
 obj-$(CONFIG_USB_XEN_HCD)	+= xen-hcd.o
+obj-$(CONFIG_USB_XHCI_GOOG)	+= xhci-goog.o
diff --git a/drivers/usb/host/xhci-goog.c b/drivers/usb/host/xhci-goog.c
new file mode 100644
index 000000000000..db027a5866db
--- /dev/null
+++ b/drivers/usb/host/xhci-goog.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * xhci-goog.c - xHCI host controller driver platform Bus Glue.
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/of.h>
+
+#include "xhci.h"
+#include "xhci-plat.h"
+
+
+static int xhci_goog_probe(struct platform_device *pdev)
+{
+	const struct xhci_plat_priv *priv_match;
+	struct device *sysdev;
+	int ret;
+	struct device_node	*np;
+	struct iommu_domain	*domain;
+	struct reserved_mem	*rmem;
+	unsigned long           iova;
+	phys_addr_t             paddr;
+
+	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
+		if (is_of_node(sysdev->fwnode))
+			break;
+	}
+
+	np = of_parse_phandle(sysdev->of_node, "memory-region", 0);
+	if (np) {
+		ret = of_reserved_mem_device_init(sysdev);
+		if (ret) {
+			dev_err(sysdev, "Could not get reserved memory\n");
+			return ret;
+		}
+
+		domain = iommu_get_domain_for_dev(sysdev);
+		if (domain) {
+			rmem = of_reserved_mem_lookup(np);
+			if (!rmem) {
+				dev_err(sysdev, "reserved memory lookup failed\n");
+				ret = -ENOMEM;
+				goto release_reserved_mem;
+			}
+
+			/* We do a direct mapping */
+			paddr = rmem->base;
+			iova = paddr;
+
+			dev_dbg(sysdev, "map: iova: 0x%lx, pa: %pa, size: 0x%llx\n", iova, &paddr,
+				rmem->size);
+
+			ret = iommu_map(domain, iova, paddr, rmem->size,
+					IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+			if (ret < 0) {
+				dev_err(sysdev, "iommu map error: %d\n", ret);
+				goto release_reserved_mem;
+			}
+		}
+	}
+
+	if (WARN_ON(!sysdev->dma_mask)) {
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			goto unmap_iommu;
+	}
+
+	if (pdev->dev.of_node)
+		priv_match = of_device_get_match_data(&pdev->dev);
+	else
+		priv_match = dev_get_platdata(&pdev->dev);
+
+	ret = xhci_plat_probe(pdev, sysdev, priv_match);
+	if (ret) {
+		dev_err(&pdev->dev, "xhci plat probe failed: %d\n", ret);
+		goto unmap_iommu;
+	}
+
+	return 0;
+
+unmap_iommu:
+	iommu_unmap(domain, rmem->base, rmem->size);
+
+release_reserved_mem:
+	of_reserved_mem_device_release(sysdev);
+
+	return ret;
+}
+
+static int xhci_goog_remove(struct platform_device *dev)
+{
+	struct usb_hcd	*hcd = platform_get_drvdata(dev);
+	struct device *sysdev = hcd->self.sysdev;
+	struct iommu_domain *domain;
+	struct device_node *np;
+	struct reserved_mem *rmem;
+
+	xhci_plat_remove(dev);
+
+	domain = iommu_get_domain_for_dev(sysdev);
+	if (domain) {
+		np = of_parse_phandle(sysdev->of_node, "memory-region", 0);
+		rmem = of_reserved_mem_lookup(np);
+		if (rmem)
+			iommu_unmap(domain, rmem->base, rmem->size);
+	}
+
+	of_reserved_mem_device_release(sysdev);
+
+	return 0;
+}
+
+static void xhci_goog_shutdown(struct platform_device *dev)
+{
+	usb_hcd_platform_shutdown(dev);
+}
+
+static struct platform_driver usb_goog_xhci_driver = {
+	.probe	= xhci_goog_probe,
+	.remove	= xhci_goog_remove,
+	.shutdown = xhci_goog_shutdown,
+	.driver	= {
+		.name = "xhci-hcd-goog",
+		.pm = &xhci_plat_pm_ops,
+	},
+};
+MODULE_ALIAS("platform:xhci-hcd-goog");
+
+static int __init xhci_goog_init(void)
+{
+	return platform_driver_register(&usb_goog_xhci_driver);
+}
+module_init(xhci_goog_init);
+
+static void __exit xhci_goog_exit(void)
+{
+	platform_driver_unregister(&usb_goog_xhci_driver);
+}
+module_exit(xhci_goog_exit);
+
+MODULE_DESCRIPTION("Google xHCI Platform Host Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.44.0.rc0.258.g7320e95886-goog


