Return-Path: <linux-kernel+bounces-17792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFEB8252D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F01F25F78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882F12C6A7;
	Fri,  5 Jan 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxlPsrIT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CA2D61D;
	Fri,  5 Jan 2024 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704454027; x=1735990027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dWfFMBnvHZMaEWNUAkYHN3XtGYpRfC4Z4Lvgh2Ajbkg=;
  b=lxlPsrITKYJblklUYxngOMRXcoSZ6KnIueRK4vAtx76rgMmNQ2GfiD83
   obWNcKddYhONKFIE2+DrW4eezhV/MPGbu6x8QxrYFZmcTetCjbL/TDmWk
   IBmGdDz8B758KufE2dp6zWPGUmTZsXIGO953LM7HgLUFUjYsfCcKSeb0a
   wuxFY9MUF/1kivTofXW6u2bs2jLOoJx4MZT06KNHEnX1dHgkG1CfVymo8
   yg4JWSEMbEf8unNptiHbrnMV8ua4U2xQMqrRSTWzWvM4jR/OEPNYS5H1m
   zAQXRXitgSifMXSJe1gJB7Xap0c4jhxluT9MKN96fVUOiRUZBCY1GEEHf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="397208958"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="397208958"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:27:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="851118190"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="851118190"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.38])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:27:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 5/8] PCI: Store all PCIe Supported Link Speeds
Date: Fri,  5 Jan 2024 13:25:44 +0200
Message-Id: <20240105112547.7301-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
References: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe bandwidth controller added by a subsequent commit will require
selecting PCIe Link Speeds that are lower than the Maximum Link Speed.

The struct pci_bus only stores max_bus_speed. Even if PCIe r6.1 sec
8.2.1 currently disallows gaps in supported Link Speeds, the
Implementation Note in PCIe r6.1 sec 7.5.3.18, recommends determining
supported Link Speeds using the Supported Link Speeds Vector in the
Link Capabilities 2 Register (when available) to "avoid software being
confused if a future specification defines Links that do not require
support for all slower speeds."

Reuse code in pcie_get_speed_cap() to add pcie_get_supported_speeds()
to query the Supported Link Speeds Vector of a PCIe device. The value
is taken directly from the Supported Link Speeds Vector or synthetized
from the Max Link Speed in the Link Capabilities Register when the Link
Capabilities 2 Register is not available.

The Supported Link Speeds Vector in the Link Capabilities Register 2
corresponds to the bus below on Root Ports and Downstream Ports,
whereas it corresponds to the bus above on Upstream Ports and
Endpoints (PCIe r6.1 sec 7.5.3.18):

	"Supported Link Speeds Vector - This field indicates the
	supported Link speed(s) of the associated Port."

Add supported_speeds into the struct pci_bus that caches the
intersection of the upstream and downstream Supported Link Speeds
Vectors. When the Function 0 is enumerated, calculate the intersection
and set supported_speeds (as per PCIe r6.1 sec 7.5.3.18, the
Multi-Function Devices must have the same speeds for all Functions). If
no Upstream Port or Endpoint exists, supported_speeds is set to
2.5GT/s.

supported_speeds contains a set of Link Speeds only in the case where
PCIe Link Speed can be determined. The Root Complex Integrated
Endpoints do not have a well-defined Link Speed because they do not
seem to implement either of the Link Capabilities Registers, which is
allowed by PCIe r6.1 sec 7.5.3 (the same limitation applies to
determining cur_bus_speed and max_bus_speed that are PCI_SPEED_UNKNOWN
in such case). This is of no concern from PCIe bandwidth controller
point of view because such devices are not attached into a PCIe Root
Port that could be controlled.

supported_speeds field keeps the extra reserved zero at the least
significant bit to match the Link Capabilities 2 Register layouting.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c             | 59 ++++++++++++++++++++++++-----------
 drivers/pci/probe.c           |  8 +++++
 drivers/pci/remove.c          |  3 ++
 include/linux/pci.h           | 10 ++++++
 include/uapi/linux/pci_regs.h |  1 +
 5 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..9c037e90df8a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6283,38 +6283,61 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 EXPORT_SYMBOL(pcie_bandwidth_available);
 
 /**
- * pcie_get_speed_cap - query for the PCI device's link speed capability
+ * pcie_get_supported_speeds - query Supported Link Speed Vector
  * @dev: PCI device to query
  *
- * Query the PCI device speed capability.  Return the maximum link speed
- * supported by the device.
+ * Query @dev supported link speeds.
+ *
+ * Implementation Note in PCIe r6.0.1 sec 7.5.3.18 recommends determining
+ * supported link speeds using the Supported Link Speeds Vector in the Link
+ * Capabilities 2 Register (when available).
+ *
+ * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.
+ *
+ * Without Link Capabilities 2, i.e., prior to PCIe r3.0, Supported Link
+ * Speeds field in Link Capabilities is used and only 2.5 GT/s and 5.0 GT/s
+ * speeds were defined.
+ *
+ * For @dev without Supported Link Speed Vector, the field is synthetized
+ * from the Max Link Speed field in the Link Capabilities Register.
+ *
+ * Return: Supported Link Speeds Vector
  */
-enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
+u8 pcie_get_supported_speeds(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
+	u8 speeds;
 
-	/*
-	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
-	 * implementation note there recommends using the Supported Link
-	 * Speeds Vector in Link Capabilities 2 when supported.
-	 *
-	 * Without Link Capabilities 2, i.e., prior to PCIe r3.0, software
-	 * should use the Supported Link Speeds field in Link Capabilities,
-	 * where only 2.5 GT/s and 5.0 GT/s speeds were defined.
-	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	speeds = lnkcap2 & PCI_EXP_LNKCAP2_SLS;
 
 	/* PCIe r3.0-compliant */
-	if (lnkcap2)
-		return PCIE_LNKCAP2_SLS2SPEED(lnkcap2);
+	if (speeds)
+		return speeds;
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+
+	/* Synthetize from the Max Link Speed field */
 	if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_5_0GB)
-		return PCIE_SPEED_5_0GT;
+		speeds = PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB;
 	else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
-		return PCIE_SPEED_2_5GT;
+		speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
+
+	return speeds;
+}
+EXPORT_SYMBOL_GPL(pcie_get_supported_speeds);
 
-	return PCI_SPEED_UNKNOWN;
+/**
+ * pcie_get_speed_cap - query for the PCI device's link speed capability
+ * @dev: PCI device to query
+ *
+ * Query the PCI device speed capability.
+ *
+ * Return: the maximum link speed supported by the device.
+ */
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
+{
+	return PCIE_LNKCAP2_SLS2SPEED(pcie_get_supported_speeds(dev));
 }
 EXPORT_SYMBOL(pcie_get_speed_cap);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed6b7f48736a..98700b55e5fd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -819,6 +819,8 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
+		if (bus->max_bus_speed != PCI_SPEED_UNKNOWN)
+			bus->supported_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
 
 		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
 		pcie_update_link_speed(bus, linksta);
@@ -2538,6 +2540,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
+	u8 speeds = 0;
 	int ret;
 
 	pci_configure_device(dev);
@@ -2564,11 +2567,16 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	pci_init_capabilities(dev);
 
+	if (bus->self && pci_is_pcie(dev) && PCI_FUNC(dev->devfn) == 0) {
+		speeds = pcie_get_supported_speeds(bus->self) &
+			 pcie_get_supported_speeds(dev);
+	}
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.
 	 */
 	down_write(&pci_bus_sem);
+	bus->supported_speeds = speeds;
 	list_add_tail(&dev->bus_list, &bus->devices);
 	up_write(&pci_bus_sem);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..c492527e994a 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -36,6 +36,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	device_del(&dev->dev);
 
 	down_write(&pci_bus_sem);
+	if (pci_is_pcie(dev) && PCI_FUNC(dev->devfn) == 0 &&
+	    dev->bus->max_bus_speed != PCI_SPEED_UNKNOWN)
+		dev->bus->supported_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 345a3d2a3fcd..1e368d7563c5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -303,6 +303,7 @@ enum pci_bus_speed {
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
+u8 pcie_get_supported_speeds(struct pci_dev *dev);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 
@@ -644,6 +645,14 @@ struct pci_bus_resource {
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
 
+/*
+ * @supported_speeds:	PCIe Supported Link Speeds Vector (+ reserved 0 at
+ *			LSB). Combination of downstream and upstream
+ *			Supported Link Speeds Vectors. 0 when speed cannot
+ *			be determined (e.g., for Root Complex Integrated
+ *			Endpoints without the relevant Capability
+ *			Registers).
+ */
 struct pci_bus {
 	struct list_head node;		/* Node in list of buses */
 	struct pci_bus	*parent;	/* Parent bus this bridge is on */
@@ -664,6 +673,7 @@ struct pci_bus {
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
+	u8		supported_speeds;	/* Supported Link Speeds Vector */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	int		domain_nr;
 #endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..7f929e04222b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -676,6 +676,7 @@
 #define PCI_EXP_DEVSTA2		0x2a	/* Device Status 2 */
 #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2 0x2c	/* end of v2 EPs w/o link */
 #define PCI_EXP_LNKCAP2		0x2c	/* Link Capabilities 2 */
+#define  PCI_EXP_LNKCAP2_SLS		0x000000fe /* Supported Link Speeds Vector */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
-- 
2.39.2


