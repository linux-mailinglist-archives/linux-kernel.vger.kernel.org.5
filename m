Return-Path: <linux-kernel+bounces-61258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5637850FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144891C214EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957018B15;
	Mon, 12 Feb 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4qcL07S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB917BB6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731190; cv=none; b=OwMvDXVUB5wSvVdJw+zlxzSL3vgpD/rNjr1ZeB+ZconpE7NhLyS5ezoud0CGSUrrQ85fk1pHsNIfiQEV6pA1huQ3JUlZGocuGo1/PQiWOe/Yi/f5wmLPYqMeeZ3q7lwnpsVaaQInMP5oRlwAKaIW0Bk43c3N50hcGWV2AzeducU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731190; c=relaxed/simple;
	bh=GCBoBAoo/8mj/fqY6112iWUXqL2JJlgA0ytaI1YG8K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+zYlJJgUPeqEPqpOSIu6NFrXTmaABiZIBX3KfqPPUMrOTeK2EF1aBPsbNsFd2TwXjwmMUC933rcJTPSf+Eo3zxQccLjXUH0Nrhxwk8j5iccSIw3yK+TGC/WrL6km01t/sQAuNkjHS4pi/VoxOg9JQ9Pl9Tim2yAqy1JFQwffvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4qcL07S; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707731187; x=1739267187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GCBoBAoo/8mj/fqY6112iWUXqL2JJlgA0ytaI1YG8K0=;
  b=I4qcL07SSs2H+16O4LTsa2ZkAbQK+hKp+VFNFUA4iRu3Oo5aKoFUfOtJ
   4WndixBoZisZMrlZQtPCq/DvN8v+Yqjns1dQRSG6AYxsF7XMP11oJA3Xf
   mrHN/mdtGFNyO1d1/sfTzOdA/wqhhMRMZ19AINE3qJ/iPkK+gjzkYi3eA
   zFAwyIXNNWM9ZZm20BA/YgCR6T4oPGrObWr0Kgl7XedfriygpRYvYT3gD
   CPSWKQSz36Z5C3lXtjLT1BlMfmPP5C0YuMXjxHkLKlpB3u9T/KiEpzhd/
   F7zoDqJc3ZlP8woJSnFdfFsdMP11fpGr6lDZX+IHumh/cW4cD4KCI8L/S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12335884"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12335884"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2502543"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:24 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 758FC11FB0F;
	Mon, 12 Feb 2024 11:46:21 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] mei: vsc: Assign pinfo fields in variable declaration
Date: Mon, 12 Feb 2024 11:46:18 +0200
Message-Id: <20240212094618.344921-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign all possible fields of pinfo in variable declaration, instead of
just zeroing it there.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/vsc-tp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 200af14490d7..1eda2860f63b 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -447,11 +447,16 @@ static int vsc_tp_match_any(struct acpi_device *adev, void *data)
 
 static int vsc_tp_probe(struct spi_device *spi)
 {
-	struct platform_device_info pinfo = { 0 };
+	struct vsc_tp *tp;
+	struct platform_device_info pinfo = {
+		.name = "intel_vsc",
+		.data = &tp,
+		.size_data = sizeof(tp),
+		.id = PLATFORM_DEVID_NONE,
+	};
 	struct device *dev = &spi->dev;
 	struct platform_device *pdev;
 	struct acpi_device *adev;
-	struct vsc_tp *tp;
 	int ret;
 
 	tp = devm_kzalloc(dev, sizeof(*tp), GFP_KERNEL);
@@ -508,13 +513,8 @@ static int vsc_tp_probe(struct spi_device *spi)
 		ret = -ENODEV;
 		goto err_destroy_lock;
 	}
-	pinfo.fwnode = acpi_fwnode_handle(adev);
-
-	pinfo.name = "intel_vsc";
-	pinfo.data = &tp;
-	pinfo.size_data = sizeof(tp);
-	pinfo.id = PLATFORM_DEVID_NONE;
 
+	pinfo.fwnode = acpi_fwnode_handle(adev);
 	pdev = platform_device_register_full(&pinfo);
 	if (IS_ERR(pdev)) {
 		ret = PTR_ERR(pdev);
-- 
2.39.2


