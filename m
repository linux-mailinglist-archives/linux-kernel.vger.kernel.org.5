Return-Path: <linux-kernel+bounces-42994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846DA8409D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7B7B22F55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952CA153BCE;
	Mon, 29 Jan 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QEe42v70"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2E151CF5;
	Mon, 29 Jan 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541966; cv=none; b=W8g+rtiCZKQK89EXrzPzR7fAoRg/WhdVXIAHwJghlWWdD3+xYjalYnMrQF9lZyFKhNPAQtA1HZFK3tsEZBxh5LSKm3+Q7MVyRvP9cwnuCmmOpGYPOx6ciCI84zfKhf1lPxaxsT85RSk2weU03xksIogu/bcc4jkvYEycJ7qziGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541966; c=relaxed/simple;
	bh=E7coSRQ/lrL+zPhCt/stQdEMSwH7peEoinjsQ9l/Kyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jhZqLRmAnVCnV1B6Al1F/vzGUHsH3T9gUan443lzxlXICE4heWMGx330d3UPnfrPHN8oLdH3wPg5Z19vFDCC0qLByo1MdRjgHWGYluwAH6277R8tFx9DQugZdut9JxPjkrAX/pteh3dt7dYMc1qCeYZYsvc55ztZ+lFSAj2lryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=QEe42v70; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T7djL9025835;
	Mon, 29 Jan 2024 09:26:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=/
	FvPKNYW8+69ZrZpAFPlMtLu/qoplLQuSrPYv2i/F2M=; b=QEe42v70JDh890v60
	Ljn3Qdq7AT2j/FjBD1+qazzQy4x/ElR7+VQkYU++e/u1mbcZ/ea0Ks661E5h/CNC
	DcrKR5fSJMhJiv2rdia1mX4rTOo/YdQOkPrUJZSlrCFqwqoxXfGCJfUEk7+xzND5
	r9hOCCzAeDMHeCdTP9fmqkjHTa3Kfy/NK+tUgOnjWmBk2IXqGAHWiRlSRbkSq2mO
	/LV8yCOYX7DaQEmesomcr1cSgBCa0gsCbVMD6do2yfc0kGvYyXWVCkiSR8QCgssP
	xNYNOap+6VMl/Ozm3/i56uAFV9Y6jekmciThiHWYZImFNX8zeFco+6u/DAgjLtdS
	GzC5g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vw043t6cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:59 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 15:25:57 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 15:25:57 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A8668820242;
	Mon, 29 Jan 2024 15:25:57 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Date: Mon, 29 Jan 2024 15:25:52 +0000
Message-ID: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T1Yo4X84zz3NwzJ67FxkTfmYZRAVJ_4W
X-Proofpoint-GUID: T1Yo4X84zz3NwzJ67FxkTfmYZRAVJ_4W
X-Proofpoint-Spam-Reason: safe

Including some missing headers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v3.

Thanks,
Charles

 drivers/spi/spi-cs42l43.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index f13073e12593..16b2c6c2e006 100644
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


