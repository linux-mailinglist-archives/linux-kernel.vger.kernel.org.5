Return-Path: <linux-kernel+bounces-38384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9883BEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884731C20DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964B1CD13;
	Thu, 25 Jan 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MoQKyPCe"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE971CA84;
	Thu, 25 Jan 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178363; cv=none; b=LXfjzTMyiFNFN46neXmr5p8JKzArxAIA6bNO6d7Leent8Wj8HfWvSOAHEH/YblUB8I76V7AFwxAi5r5bDCUbfHMM25I+mPSfRNGufT3MZATDtlZRjmsKWv2ovDqZv2NS/irNkuus4NZVa+EAq6RBilUEufN47PKyZYeqvpouDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178363; c=relaxed/simple;
	bh=ADL6EEUd16TWoEirfUXHF7UrKKLkYyngvp1UHT/BuGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=knbwtZsmUG2xBomgvghAScz7JSs8sGiFA48JP49nDZ478e4oDKA1rEAFf0v0DCyYhjMYHgJZO5bCuvh5fy9QdpyTd00eLDWz0syOLy+McLOfhvD2w1zFfMGCpVrZSulq+oZW9DDdBxJGQle6qXWRYYdt4/mefTUAbKlbZdeX41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MoQKyPCe; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P7paSN014010;
	Thu, 25 Jan 2024 04:25:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=Q
	W01UQTD20P8CqBxFTRKQQwM25ERFOAQZUxt044R47k=; b=MoQKyPCeHpoLItGPx
	eah2szKYE21lONRS1Iu9LPh5Ary0AET+v/NXGjrbrKTYyfsKjrGaNFMrkVA+/qsF
	FPaydmCfYlqqY9jjKi/v7NPhsJtz0lkg51jdcdpuR0b6aMYvIw6iw4rdkDkmHZyR
	k++KOEjTs/xWESQ8f3PB7EimEIX3H6MaJeGEyqIWBFGlcSer0YD9hTR0gJzOJguS
	q/vgWwIMpMYUQwtOecIopRcZ/72SQjf3gFHWbP3taGx/01TFV6MzyrBBHrITtEL8
	H1lQVd0ok9qFII+CHtn67M3sqIdMwkCVIvgKg2uoufOQ+I+f7jfq2jZvRJ+IuBAx
	25zFw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9t2gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 04:25:57 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 10:25:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 10:25:55 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 50250820246;
	Thu, 25 Jan 2024 10:25:55 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 1/6] spi: cs42l43: Tidy up header includes
Date: Thu, 25 Jan 2024 10:25:50 +0000
Message-ID: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: A1islOW7n7jO12Zs_UFZL2kq9edDRCJK
X-Proofpoint-ORIG-GUID: A1islOW7n7jO12Zs_UFZL2kq9edDRCJK
X-Proofpoint-Spam-Reason: safe

Including some missing headers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index d239fc5a49ccc..fb62807fc991c 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -11,7 +11,9 @@
 #include <linux/errno.h>
 #include <linux/mfd/cs42l43.h>
 #include <linux/mfd/cs42l43-regs.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-- 
2.30.2


