Return-Path: <linux-kernel+bounces-132025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0706898EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABB428321D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF3134CC2;
	Thu,  4 Apr 2024 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKzMYws+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE74134416;
	Thu,  4 Apr 2024 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258477; cv=none; b=K18TwGKlqFn6JrrQXbViK2T3W0MEQlfqx+d63yEhVYNHkOOARJygr5GLnI9vjO7zgTmAsEdnqaQXh7L8v8sWjh8Mx2L+1DSArEHwIvRhGZFoufjblvenyOOiWjJwSudIYAHjIshzFahHDX+ldKgHqteYAuvp8f6JtJiu6PElr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258477; c=relaxed/simple;
	bh=3xUa2jqh2u39W0T4E+6RUSmeJpuQ7opgooePMFTToJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LOMVBAUNMxsExgE0SWO6E/hLxke/T3ISYKd5zHiyxdpTHTgdZyI4Abnr2gJD9xxrCv2AxIyFXTS5fY2zyLAWXPqDMggneSydL6Jc37GRt5Twv2Av7CFGQOZe5z9ILQInuLIPgJUP9efa28/09LqOrhB8xpS7TfmPlSgS0OF53QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKzMYws+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258476; x=1743794476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3xUa2jqh2u39W0T4E+6RUSmeJpuQ7opgooePMFTToJI=;
  b=OKzMYws+VHM+mxn/KRRS+RYeqh1ErX6a834YSAuR6OS6XVxYDMwBoE1K
   KKzVLKkHAUqHH6/WJKmUYUDH41froqe7CnlI3jGh48xODVa+oG/8vC6aj
   KS7jjEIlFxMG9potHz5kcDh1ohLFDmapRDhVAHHWoe62BAWxnkJGkxUAM
   VtYBRfctKNzSvqVv/Rk9J7B43EbXxxV7/gRxgEPhAQRR2YibBsANNzWAc
   cbB4AsLHp2aEKvDHWJ7oGQOyepVj+SLTUCt5/27uFyLwWtyi60t9oCq/t
   2+DapfDLYL9zqWXHo5oVrQjXLQ4txF+W0HW5VxfbZgSl2g4cTQoCTWgVm
   A==;
X-CSE-ConnectionGUID: YDxCdoA0S3WxJ6VcR9OE+Q==
X-CSE-MsgGUID: N+cW49vpRRaR5t6trc8Aqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18710359"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18710359"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937087028"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937087028"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 12:21:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 406B63E5; Thu,  4 Apr 2024 22:21:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ata: libata: Move inclusion to where it belongs
Date: Thu,  4 Apr 2024 22:21:11 +0300
Message-ID: <20240404192111.3580578-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace rather heavy acpi.h inclusion by a simple forward declaration
in the public header. Update the local one to include acpi.h as some
of the code requires it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/libata.h   | 3 +++
 include/linux/libata.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5c685bb1939e..29e9387eb249 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -90,6 +90,9 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
 /* libata-acpi.c */
+
+#include <linux/acpi.h>
+
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
 extern void ata_acpi_dissociate(struct ata_host *host);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 66937b787cca..68b969de410f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -19,7 +19,6 @@
 #include <linux/ata.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
-#include <linux/acpi.h>
 #include <linux/cdrom.h>
 #include <linux/sched.h>
 #include <linux/async.h>
@@ -660,6 +659,10 @@ struct ata_cpr_log {
 	struct ata_cpr		cpr[] __counted_by(nr_cpr);
 };
 
+#ifdef CONFIG_ATA_ACPI
+union acpi_object;
+#endif
+
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
-- 
2.43.0.rc1.1.gbec44491f096


