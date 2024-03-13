Return-Path: <linux-kernel+bounces-101245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4187A48F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEC1C21BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823820DDC;
	Wed, 13 Mar 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKJu4bla"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671B1B971;
	Wed, 13 Mar 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320679; cv=none; b=kWBGO1njxQS1Od1vq37cyqi5/05mEjn940efOjgudvQD9Bo50AOrhezVJtSaO2/OguVEHKIvs11XgVn6GDKTmi6ytVqZSku0niDb4lf08zMv0JlJA2fMA3OhfSM79HjH8pFvlKuE9udheAz+3MdDcVyctPBAMNgWzZJa2IqnUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320679; c=relaxed/simple;
	bh=ABNAIctSLDSs2aKwynQcOBhqzG8RDByD/Ji7/NnXqQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QnmUmzz6mGxXWSvgs44Ifz5cqy70nxGc7ADDUCjk4NA6IYlmIBd+52Ke56DWwJDu5cFL7WFfcjLB7Q1dMR9MJpfbCu06xK55E1covxjiB/4KV9XBlGAdHSO0mhOlTXwOZyTU4R9o4ifAE1FtbNQHFhxoUMePLyZiUvW5bUGCnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKJu4bla; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710320678; x=1741856678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABNAIctSLDSs2aKwynQcOBhqzG8RDByD/Ji7/NnXqQ4=;
  b=mKJu4blau5iuziEVhvO2F6ba/SKn/hp9OSiCdEkU/vJIddSTwkRyORV4
   AI1l/ouK/y5s/i4Gpu7GywrNci8zbFivQIS1Gd7pMZkoYgFhS4w0YSIIz
   gvajT7337zlugxeH9Awq4AsgMskHWKFR7FYecji0hXHjnQkInjEV+54NC
   +E0+lQYIu1CvdjVIVYsXBN6dW/jxikXSK+QTbXicr54RmTzdNNwbq5mJx
   DR0ub0yYzj4y1bE0pNtKECp5r/lvRhMIboLf3q3nsYDBwUT2gynewoTuF
   EZY8E38tn6eK94CqTfhE5M7R5ljfGvLXe8dVRI296YlsbNYTkpL5hJRvS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22586876"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22586876"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265607"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:35 -0700
From: Li Ming <ming4.li@intel.com>
To: dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [RFC PATCH 1/6] PCI/RCEC: Introduce pcie_walk_rcec_all()
Date: Wed, 13 Mar 2024 08:35:57 +0000
Message-Id: <20240313083602.239201-2-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240313083602.239201-1-ming4.li@intel.com>
References: <20240313083602.239201-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCIe RCEC core only provides pcie_walk_rcec() to walk all RCiEP devices
associating with RCEC, but CXL subsystem needs a helper function which
can walk all devices in RCEC associated bus range other than RCiEPs for
below RAS error case.

CXL r3.1 section 12.2.2 mentions that the CXL.cachemem protocol errors
detected by a CXL root port could be logged in RCEC AER Extended
Capability. The recommendation solution from CXL r3.1 section 9.18.1.5
is:

	"Probe all CXL Downstream Ports and determine whether they have
	logged an error in the CXL.io or CXL.cachemem status registers."

The new helper function called pcie_walk_rcec_all(), CXL RAS error
handler can use it to locate all CXL root ports or CXL devices in RCEC
associated bus range.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/rcec.c | 44 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..a068f2d7dd28 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -444,6 +444,9 @@ void pcie_link_rcec(struct pci_dev *rcec);
 void pcie_walk_rcec(struct pci_dev *rcec,
 		    int (*cb)(struct pci_dev *, void *),
 		    void *userdata);
+void pcie_walk_rcec_all(struct pci_dev *rcec,
+			int (*cb)(struct pci_dev *, void *),
+			void *userdata);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) { }
 static inline void pci_rcec_exit(struct pci_dev *dev) { }
@@ -451,6 +454,9 @@ static inline void pcie_link_rcec(struct pci_dev *rcec) { }
 static inline void pcie_walk_rcec(struct pci_dev *rcec,
 				  int (*cb)(struct pci_dev *, void *),
 				  void *userdata) { }
+static inline void pcie_walk_rcec_all(struct pci_dev *rcec,
+				      int (*cb)(struct pci_dev *, void *),
+				      void *userdata) { }
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index d0bcd141ac9c..189de280660c 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -65,6 +65,15 @@ static int walk_rcec_helper(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static int walk_rcec_all_helper(struct pci_dev *dev, void *data)
+{
+	struct walk_rcec_data *rcec_data = data;
+
+	rcec_data->user_callback(dev, rcec_data->user_data);
+
+	return 0;
+}
+
 static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
 		      void *userdata)
 {
@@ -83,7 +92,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
 	nextbusn = rcec->rcec_ea->nextbusn;
 	lastbusn = rcec->rcec_ea->lastbusn;
 
-	/* All RCiEP devices are on the same bus as the RCEC */
+	/* All devices are on the same bus as the RCEC */
 	if (nextbusn == 0xff && lastbusn == 0x00)
 		return;
 
@@ -96,7 +105,7 @@ static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
 		if (!bus)
 			continue;
 
-		/* Find RCiEP devices on the given bus ranges */
+		/* Find devices on the given bus ranges */
 		pci_walk_bus(bus, cb, rcec_data);
 	}
 }
@@ -146,6 +155,37 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
 	walk_rcec(walk_rcec_helper, &rcec_data);
 }
 
+/**
+ * pcie_walk_rcec_all - Walk all devices in RCEC's bus range.
+ * @rcec:	RCEC whose devices should be walked
+ * @cb:		Callback to be called for each device found
+ * @userdata:	Arbitrary pointer to be passed to callback
+ *
+ * It is implemented only for CXL cases.
+ * Per CXL r3.1 section 12.2.2, CXL protocol errors detected by
+ * CXL root port could be logged in an RCEC's AER Extended Capability.
+ * And per CXL r3.1 section 9.18.1.5, the recommendation is that probing
+ * all CXL root ports to determine whether they have logged an error.
+ * So provide this function for CXL to walk the given RCEC, CXL driver
+ * will figure out which CXL root ports detected errors.
+ *
+ * If @cb returns anything other than 0, break out.
+ */
+void pcie_walk_rcec_all(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+			void *userdata)
+{
+	struct walk_rcec_data rcec_data;
+
+	if (!rcec->rcec_ea)
+		return;
+
+	rcec_data.rcec = rcec;
+	rcec_data.user_callback = cb;
+	rcec_data.user_data = userdata;
+
+	walk_rcec(walk_rcec_all_helper, &rcec_data);
+}
+
 void pci_rcec_init(struct pci_dev *dev)
 {
 	struct rcec_ea *rcec_ea;
-- 
2.40.1


