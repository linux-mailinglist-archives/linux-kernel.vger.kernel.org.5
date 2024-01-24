Return-Path: <linux-kernel+bounces-37253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D223583AD53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89868282790
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581077A73A;
	Wed, 24 Jan 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LweXCt7J"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7544409;
	Wed, 24 Jan 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110227; cv=none; b=UkRkjli76IBC4FV+cPQGhwBzdxZGZvdBxnzUlRbCEEjs2tu9sJuVWbxH/O/it6I78bx0ashz3rrKTmLOiUzWLEm+O3nJJKm+rTM6FvQ0CJgnFL4N/4TcXz05qRRl/9mZDApxDPLD0CHzKJzoK3FWHroYHhsk3K2pqwrowo3vCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110227; c=relaxed/simple;
	bh=xX8V+ooBoGuO9/qAZe63ZvqC3unGlMbM7oteiXO0RC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+kjZyIHxuY2+7viC3Hk5F9sALPGnp4FLmdK1rJ1rXaJB/xA5K2n4eHVjYmthVLDkpFNA4l6WJuGGG737+ZiIFVgWsUVYQ0FMSJyySkKWlc5rdVvVPedLWOjKdj91PBP1CVea3FqItrhNqFs8sGPwTElkBhCP9BpQZkgkiDys0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LweXCt7J; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O8MvMl030107;
	Wed, 24 Jan 2024 09:30:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=l
	RLqdGz9nV9jBTZzuw5ozwQtDA2zkxWRDOuyDlnnA78=; b=LweXCt7JqcK49xNqX
	jp/83OkDlTze3OwnFiOBAR2BUrWPPy3ikkugkAcdCc7bNBsxBOAylOB0QiqSYNJr
	Xnd9kWLFasRG7pAbdJpobqUV6a3XRP7s41pRXKfyzmm98DkcheM26N0fiUaEOj2Y
	I/RO4rdrwJoc/OgG9JHPMqoCKgb7N3lvKcv7a9BtaCNwTqDz+pPX0o3PMcM7lFbF
	p8PNYvGaWf45HSIV6e+y2ZRegGU9uJRX3soOUiSxVMreZzSCSx3s42AQV7dYe68c
	5pOy22uQtZzd5k+FoKAHaarDBypFg7neXNfws3El6CvQUFhjMttQqiWnj/DdSliE
	dFhZA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9ryqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:30:18 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:30:16 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:30:16 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 98D63820246;
	Wed, 24 Jan 2024 15:30:16 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 1/6] spi: cs42l43: Tidy up header includes
Date: Wed, 24 Jan 2024 15:30:11 +0000
Message-ID: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: m-fKSUnpiyZc6hYMIqEPaZ1VCktx70Fo
X-Proofpoint-ORIG-GUID: m-fKSUnpiyZc6hYMIqEPaZ1VCktx70Fo
X-Proofpoint-Spam-Reason: safe

Including some missing headers.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Moved to start of the series

The changes to the MFD headers necessitate the inclusion of of.h here to
keep things building, hence my including this SPI change in the this MFD
series. The rest of the SPI fixups will be sent separately, as they are
also not dependent on this change.

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


