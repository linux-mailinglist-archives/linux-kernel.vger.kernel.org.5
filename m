Return-Path: <linux-kernel+bounces-48456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3577845C59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A3F1F2CE71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80FF15F32F;
	Thu,  1 Feb 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uk0552m0"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06215F32B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802953; cv=none; b=MTaGhF9GwtbpSdxlAtM0IgAqKAvV4yX3I5cJxYpTKET1RghEvokw8cWXp78vL6b+Xf1RMVFvn49IEwEt64mz112cwKz1H/5OUwRVTNgdnqMiUjiPSawe+U7+LhzAoO+euaW48yM6eB/8Tlrvr76/fSsKYcc2QsaAMdKI13uCFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802953; c=relaxed/simple;
	bh=SRaAiGQwt/dfTnu/kFN7Gord4bVSFSW1hMzlLnCuYxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NA30ox0Q8NPR8mhWUH83DYldovXLuxb6uF/7NCgZP7M13FArI/745f4h4GjFhzocsefYj+quCW1T1x+M7AErg87qq2oO29n4aMvm+2WsgsXIsIS03J8FKjdew7tkXdAhf/TlDkx5aFdoHWLyT2rrqCbmaBkCTPFCWtZd0RsJ11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uk0552m0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b029a1c8aso1197346f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802949; x=1707407749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CZ4CYGhd/azweShj7DUYvXo7iLunSpVFtNI+LPmojk=;
        b=uk0552m0tqeCrs3CXRNJxPY/KmEifTlxZfT3uPjxFBYoVoxeglrgxiEGEkvjSaI2uF
         ZTKdNlISZId8XGRvIqADL+LWnS71QD2ZhLwkGIpPS9y94QghZk70Nu8yifdqs0/mx42U
         6SsSfchagUJ8ZBPUSJ2+zeb6claI7FJJZVttX1448Gst+1u3mPq+iPqEQt8sLoDHOpYK
         QCHvFLa7VMHfQcC9EzjDQYVFnPZka6gza+w/IX1Ko7A2TOyJX4OMSsnvmkAUvHblRWGu
         pFtqGxvTKIQ5jphebYuE+5QeYFQUrH+bPfnX+2XF5g/6aY5jGyo8Oknla3qRQFqLvSsn
         G/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802949; x=1707407749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CZ4CYGhd/azweShj7DUYvXo7iLunSpVFtNI+LPmojk=;
        b=hAim2k4Es5VXeEF44xvpI6clZnOxi21iNYHVZn3lhc1Xl5IWcWaFZNwzkjrxKambKe
         B7QM8rGmxhVvD4oq1ShAcLbvP6Z9pDd575tVh/KAhwz9e5zjWbqXxdHbNZqth6qQ6ZQ1
         tE7JVzV0OzYo1e2/fP7k9RyH1BySbMWtMnBAg8K5D/DJfBbDepdsmRA77xI8jTdFPVxN
         8dXUGelWSwELB4Wj0tSuzvkmqIostK/myJvcVFAQof5Q/rp/XS5vt2XVaFHw1L+HItMv
         g2AiMpdTDiqLrPefJ435+P+UhLY7aE14PcStXWRS/yKQRXiVVZW/08X2i/wHLNwK1/gf
         QhmQ==
X-Gm-Message-State: AOJu0Ywa1QqcwaE0DEkw/7+QBpMR3PgvcyEpCSeqnW0/LuWrMjVk9lnT
	EtGc/+ZIRncUCbLHddEoRFsHol2dfQ/kqPiLgy9oBkr+i7i6dAoxqflm6fsWA3U=
X-Google-Smtp-Source: AGHT+IF0oL0ltCF+I+m2lXndBn2DewW2NEZjIjC7hgrBmZs4spfU1MvvKwjPTHeskQYocgpg9bPSsQ==
X-Received: by 2002:a5d:64c3:0:b0:33b:1b5f:6215 with SMTP id f3-20020a5d64c3000000b0033b1b5f6215mr740087wri.25.1706802949710;
        Thu, 01 Feb 2024 07:55:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBkZM/mc6f5LQe4VTAy8QR5OXfk6rlEhlstGhgoOxdbhQaD9R0QxXw/uRpRBH4a6b7tDR4CmD9cOg9TtH6NPIS1CsFZ3wkgka0VTSd+qQT2/oEl7oyIBtL0QHkz4LSS2/MLVCwO2aJ4pNk79/A6IdNapdw0/azS2i6IdVscooMHQ/t+Iy9xCdweJkxnkgl4ZsfNSzxPqsEQlHy22XBBWS17PK2whyQ3PAjUfdezuWSvsXo8qRwXo7dIxrB/6X48/TEDHXdh24EH0jundGMtCQz06Hob58ag1nCe6YN5rGWaqifFzXxqmwcc7P2UL8gOTC3N4a9hVkwYw9pngFNF9ux9R63liMXmTIo4OZYKsTMKmiFEiyP/ka86FxfXVwqVPUf1MR2lmZXVczbxDErG2eaNJJ5q7n2PzFq5IkoJdqga9GM2vkeYx4fC24V63+mnToUuT1oT/fG4gQnrXwSCLtZRFehYyot6V2ejANl+fflUOtgOLHMS6QoR/NrP5dw0nAlJ+HuKZhKLVkfVehzATEEkiXnkQGik54U40/qQkakRxwRvwsESMJFRPWmLUOmBihVK1Zp0sq3lmTtxNhlx+0e5+E2SDAkMQkhvoN9bte4FmPvpM9CSTaW45EP/PYK5Rxm1PeHX4lT8+nXDKUscrkt6Z8aIUD4Mz1CxerlPKe1DC4EfgYkk383n8UZRZIndfizbz4MN20r
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 8/9] PCI/pwrctl: add PCI power control core code
Date: Thu,  1 Feb 2024 16:55:31 +0100
Message-Id: <20240201155532.49707-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some PCI devices must be powered-on before they can be detected on the
bus. Introduce a simple framework reusing the existing PCI OF
infrastructure.

The way this works is: a DT node representing a PCI device connected to
the port can be matched against its power control platform driver. If
the match succeeds, the driver is responsible for powering-up the device
and calling pcie_pwrctl_device_enable() which will trigger a PCI bus
rescan as well as subscribe to PCI bus notifications.

When the device is detected and created, we'll make it consume the same
DT node that the platform device did. When the device is bound, we'll
create a device link between it and the parent power control device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/Kconfig         |  1 +
 drivers/pci/Makefile        |  1 +
 drivers/pci/pwrctl/Kconfig  |  8 ++++
 drivers/pci/pwrctl/Makefile |  3 ++
 drivers/pci/pwrctl/core.c   | 82 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-pwrctl.h  | 24 +++++++++++
 6 files changed, 119 insertions(+)
 create mode 100644 drivers/pci/pwrctl/Kconfig
 create mode 100644 drivers/pci/pwrctl/Makefile
 create mode 100644 drivers/pci/pwrctl/core.c
 create mode 100644 include/linux/pci-pwrctl.h

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 74147262625b..5b9b84f8774f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -291,5 +291,6 @@ source "drivers/pci/hotplug/Kconfig"
 source "drivers/pci/controller/Kconfig"
 source "drivers/pci/endpoint/Kconfig"
 source "drivers/pci/switch/Kconfig"
+source "drivers/pci/pwrctl/Kconfig"
 
 endif
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index cc8b4e01e29d..6ae202d950f8 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 
 obj-$(CONFIG_PCI)		+= msi/
 obj-$(CONFIG_PCI)		+= pcie/
+obj-$(CONFIG_PCI)		+= pwrctl/
 
 ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
new file mode 100644
index 000000000000..e2dc5e5d2af1
--- /dev/null
+++ b/drivers/pci/pwrctl/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "PCI Power control drivers"
+
+config PCI_PWRCTL
+	bool
+
+endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
new file mode 100644
index 000000000000..4381cfbf3f21
--- /dev/null
+++ b/drivers/pci/pwrctl/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PCI_PWRCTL)		+= core.o
diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
new file mode 100644
index 000000000000..312e6fe95c31
--- /dev/null
+++ b/drivers/pci/pwrctl/core.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
+			     void *data)
+{
+	struct pci_pwrctl *pwrctl = container_of(nb, struct pci_pwrctl, nb);
+	struct device *dev = data;
+
+	if (dev_fwnode(dev) != dev_fwnode(pwrctl->dev))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		device_set_of_node_from_dev(dev, pwrctl->dev);
+		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		pwrctl->link = device_link_add(dev, pwrctl->dev,
+					       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!pwrctl->link)
+			dev_err(pwrctl->dev, "Failed to add device link\n");
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		device_link_del(pwrctl->link);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl)
+{
+	if (!pwrctl->dev)
+		return -ENODEV;
+
+	pwrctl->nb.notifier_call = pci_pwrctl_notify;
+	bus_register_notifier(&pci_bus_type, &pwrctl->nb);
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
+	pci_unlock_rescan_remove();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_pwrctl_device_enable);
+
+void pci_pwrctl_device_disable(struct pci_pwrctl *pwrctl)
+{
+	bus_unregister_notifier(&pci_bus_type, &pwrctl->nb);
+}
+EXPORT_SYMBOL_GPL(pci_pwrctl_device_disable);
+
+static void devm_pci_pwrctl_device_disable(void *data)
+{
+	struct pci_pwrctl *pwrctl = data;
+
+	pci_pwrctl_device_disable(pwrctl);
+}
+
+int devm_pci_pwrctl_device_enable(struct device *dev,
+				  struct pci_pwrctl *pwrctl)
+{
+	int ret;
+
+	ret = pci_pwrctl_device_enable(pwrctl);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pci_pwrctl_device_disable,
+					pwrctl);
+}
+EXPORT_SYMBOL_GPL(devm_pci_pwrctl_device_enable);
diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctl.h
new file mode 100644
index 000000000000..8d16d27cbfeb
--- /dev/null
+++ b/include/linux/pci-pwrctl.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#ifndef __PCI_PWRCTL_H__
+#define __PCI_PWRCTL_H__
+
+#include <linux/notifier.h>
+
+struct device;
+
+struct pci_pwrctl {
+	struct notifier_block nb;
+	struct device *dev;
+	struct device_link *link;
+};
+
+int pci_pwrctl_device_enable(struct pci_pwrctl *pwrctl);
+void pci_pwrctl_device_disable(struct pci_pwrctl *pwrctl);
+int devm_pci_pwrctl_device_enable(struct device *dev,
+				  struct pci_pwrctl *pwrctl);
+
+#endif /* __PCI_PWRCTL_H__ */
-- 
2.40.1


