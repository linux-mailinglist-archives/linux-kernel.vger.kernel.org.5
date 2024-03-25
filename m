Return-Path: <linux-kernel+bounces-118002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C7D88B617
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B658B39914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572196FE12;
	Mon, 25 Mar 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t5Fur/Y8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F546EB50;
	Mon, 25 Mar 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400458; cv=none; b=G3Z6e+3QX8r7w1ESFLZu8KR6Qc+siUiizZEqvXOcy1C+wm72USIK+zqPUHcUqx7whQAxBlTGcIuVZiDVFDx24DhF6C/jqu6BOTkbyeV46hEQLkzqLrYhmn7kSjf7gBOZteXPsTC0c4YDNHFkxbnADif459JjbmG8YphCJXV8nKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400458; c=relaxed/simple;
	bh=yKPCm9PQphXY+DJuHS49zOR7Af3I1h/TTRhC6BIMDXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/ELzobAdocXv0IXQfVUVqtkIBEl1T07M+rubRTva2tNMKqMBvsp/vsSMem8WbtpYfkImGCvetCG4QhVS+AbyGLTjbGTx/9CiYOcM8TFRKbW5RQ3HRo1jbgYI25UNGIkwHtN/QenKh0R+PBhzfdMgp1dUV6GzjdfZVClHDMXiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t5Fur/Y8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PL0kq8071964;
	Mon, 25 Mar 2024 16:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711400446;
	bh=JDp3NAhKc2pHdykhj8hMrmaUkf/mzm//42epfcVw2g4=;
	h=From:To:CC:Subject:Date;
	b=t5Fur/Y8rQ6g2qLZUwbT0HIUX5xMgustFJY87Lc+NYAUtiHRU7YqRBEki8Dzxhv79
	 JeUnlFKeMWhTwXnNwOMC+AqwcqSltuKNFeowwZPcK/pb0NhNr2tsv/mlNNIrgp0Icn
	 YdK8sA7Jw11+sLYRnKIX2U3a00dZz67Cdz+2Q+9c=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PL0k8S024479
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 16:00:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 16:00:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 16:00:46 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PL0k8e053788;
	Mon, 25 Mar 2024 16:00:46 -0500
From: Andrew Davis <afd@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren
	<tony@atomide.com>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH] uio: pruss: Deprecate use of this driver
Date: Mon, 25 Mar 2024 16:00:45 -0500
Message-ID: <20240325210045.153827-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This UIO driver was used to control the PRU processors found on various
TI SoCs. It was created before the Remoteproc framework, but now with
that we have a standard way to program and manage the PRU processors.
The proper PRU Remoteproc driver should be used instead of this driver.
Mark this driver deprecated.

The userspace tools to use this are no longer available, so also remove
those dead links from the Kconfig description.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/uio/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 2e16c5338e5b1..358dc2d19b885 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -126,19 +126,13 @@ config UIO_FSL_ELBC_GPCM_NETX5152
 	  http://www.hilscher.com/netx
 
 config UIO_PRUSS
-	tristate "Texas Instruments PRUSS driver"
+	tristate "Texas Instruments PRUSS driver (DEPRECATED)"
 	select GENERIC_ALLOCATOR
 	depends on HAS_IOMEM && HAS_DMA
 	help
 	  PRUSS driver for OMAPL138/DA850/AM18XX devices
-	  PRUSS driver requires user space components, examples and user space
-	  driver is available from below SVN repo - you may use anonymous login
 
-	  https://gforge.ti.com/gf/project/pru_sw/
-
-	  More info on API is available at below wiki
-
-	  http://processors.wiki.ti.com/index.php/PRU_Linux_Application_Loader
+	  This driver is deprecated, replaced by PRU_REMOTEPROC.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called uio_pruss.
-- 
2.39.2


