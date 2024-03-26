Return-Path: <linux-kernel+bounces-118231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99C88B68D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7FB1F60B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7991CAB9;
	Tue, 26 Mar 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yL/Cz4GW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056B1CA8A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415424; cv=none; b=LaYIKWvYSWyLV5xRsWfjc72SXsME+mpiyVq1QtxydobnmnsuPDA/IwU64RGfnRz6frkx+STBX+k19aT1ik/1Dm1AK7JJxlMCmbBbSYSY7tiBHNQuQUIqX3op4YPUV+ULLCkbTdhx49LMNqWGxQhwtFurXqlKrBG/ixzYMDhErRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415424; c=relaxed/simple;
	bh=MgTEnzvxfV5oP86hOkhozcO0Gi92SCNSjxhsRMxE+lw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDkl6sUTwChMDk2qi9vRvAKxnZdMySuaSZUJGMOU2w0B6dJDMlKszPMOPFbj9iLZVAikHnpFU7NWVlsMJbccD+rum5vJHuD/l+6tzukIzlb8L5m0Hu2FKh1evsOyrFwhG2+R4Q2AGIBvQMSB5FeIjS03B5TfkvMmqx9Ee6w9D5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yL/Cz4GW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19HAs021281;
	Mon, 25 Mar 2024 20:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711415357;
	bh=ByM2Fg8OCVFPgNuDVK69mmXP2u8CSpBbdsgUaXTYJMM=;
	h=From:To:CC:Subject:Date;
	b=yL/Cz4GWzFcvwYYPCW4Hi5t+SMv9AHlVTPqjb0ViCmEPtrdG+neHaZO+UEb4h9K1n
	 hiwJHgOqUr5fMx5CApHritnaM8VnVZ/NmEi14ev3tA87pHhQatPfXItSq+GpfQhIrS
	 a09gQwaA+PfOcpP39uk7TKkVFns3I3P9cKlb2zps=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q19Hjs044152
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 20:09:17 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 20:09:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 20:09:17 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19AY7120020;
	Mon, 25 Mar 2024 20:09:11 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v1 1/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Date: Tue, 26 Mar 2024 09:08:58 +0800
Message-ID: <20240326010905.2147-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add TXNW2781 support in smi.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7c157bf92..226bd9097 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1765,6 +1765,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 		{"CSC3557", },
 		{"INT33FE", },
 		{"INT3515", },
+		{"TXNW2781", },
 		/* Non-conforming _HID for Cirrus Logic already released */
 		{"CLSA0100", },
 		{"CLSA0101", },
-- 
2.40.1


