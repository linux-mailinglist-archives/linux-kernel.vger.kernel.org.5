Return-Path: <linux-kernel+bounces-71934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0FD85ACAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003E81F2387E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14155537E6;
	Mon, 19 Feb 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOVKngJu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBE0524D7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372701; cv=none; b=DQTaDayEW44jg42s1xzAmxjWGGlBDehQrtP8iKmMXmlwYdvvjZMbPpK6ZqjXVt3cBLM9V4MW/yVICNDpKJEcXrhfcI51gZ64tbv2LFIX0uH5D1NPrgXbVpQ7iXMuDMYWjSLFO/fCKvv3qhFIaPi2Tinnms2kRhJKJ+XAp0b/kxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372701; c=relaxed/simple;
	bh=CnCKLmpVpCmUXuzfNqSYcIlBmrUGIF8rsECdq6agMcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkqExx1k9P7DT6bKD3rfCiUUjVR2HYPHBYznF0SP5UnTDoah/bZkXWrpI7vFRI3BahtG1GCAwp9oG9ci8O0CYjdcVOq6rJycRkCNvQwetN6HrUzDPzGD7MG2PnCq7ZSVjn3N/w26TVyWi599b9oSiJzWR+3unDTFs2Js2CTWiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOVKngJu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708372700; x=1739908700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CnCKLmpVpCmUXuzfNqSYcIlBmrUGIF8rsECdq6agMcQ=;
  b=ZOVKngJuBYY2bzZ1AY+1qW4Abg91gl3onef0FaQCxg8fwaADKf8ZjVQC
   gdwiX3LjyPLA88x9pYbKeAE2nXxwimQQyKDjMLK9LpDqftDE/Cnui6vpL
   Fec2IfjqLpQ6PsRE0K6f+AdD62MeEqPz2a4NE3+ZqPLDpo0Dwd01MJGz+
   ELrZF91PVLcl326sd56xRCsYdOR2CtoxVPOnSouBluTKvfxEx5BPIR+GY
   APTOqx8DFwyWikdRyFzMkmRLWhm08PkXLJllhq3DSnbVyLdtDjF4MGxik
   /tZl3PAB65av7HePgVx+t/nqbliMD5W5C1YUxb/PqroE9yNI3SoSJkH+8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="19893449"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19893449"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9239492"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:15 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 44BF9120204;
	Mon, 19 Feb 2024 21:58:11 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 3/3] mei: vsc: Assign pinfo fields in variable declaration
Date: Mon, 19 Feb 2024 21:58:07 +0200
Message-Id: <20240219195807.517742-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
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
index 7b678005652b..9b4584d67a1b 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -445,11 +445,16 @@ static int vsc_tp_match_any(struct acpi_device *adev, void *data)
 
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
@@ -501,13 +506,8 @@ static int vsc_tp_probe(struct spi_device *spi)
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


