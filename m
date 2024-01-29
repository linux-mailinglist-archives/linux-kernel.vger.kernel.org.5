Return-Path: <linux-kernel+bounces-43000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A96138409E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC01E1C2271C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A6156975;
	Mon, 29 Jan 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BgFpVD/z"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE8155A59;
	Mon, 29 Jan 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541976; cv=none; b=aShp6LT3i5O2IXtkxT613qgzyP6SQ8+wwe7EICwdBTrQ1L5TLf4trR8o3i2SoT46hjUocUOQ4CJdL7PNNmdrdtyQwqWYyAxU6TcK9w8RwQNSR9fq87nwUl4bXMr8ktjJf9xXvizaGiju3xA4QtoIDPcq/Qeh7GMdJ4IuW4rEJow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541976; c=relaxed/simple;
	bh=68yJ9U7yDOQN/tmXLFDBJ2RA3Jr4KUc5Ol0WN9miz6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uskceqwgZAvQ1qjaP9bAvwuUE/RjBtypk31pC28nXleRIq03ZYsEsNKlwqsG9j/2XUxEi41j36v3M0LOcFSV8lXRH7duQXMymq2FpzJq3O+ihZwvs7BWwE2wDJj+aWa+4oka+bO1i6p5JUzxggNyr/Maiuq16ow594uq19lYG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BgFpVD/z; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5ga4N008621;
	Mon, 29 Jan 2024 09:26:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=zml9ilUhvsqCAh5cH8JndKwXXuBxD+atI54RnGVm2Bk=; b=
	BgFpVD/z66u1pteeL5S3eYNSF7D+gSSj6+O4JgJJYoiZma7MKBdVc74pjdJVGp56
	dvYrgAMLGOazp/CEpmioDsjg7GNWtYfeu7+QXz5rF0JscNmhSYzUQdlVWjnihb27
	gclt8jepTECtGu2gMwSqCv3hdi0SUu7Lty/DIN/Xtigq+/MjX3++nXBoDz3xh3Xm
	MlUSFL5eyIDGZ56XGDrZGaOUSzo9E3P3Vp4it4NEn6xqDKoDCa6bgKsfFbDI9Zsc
	/KMy4cLoY5po4Z5AHR83Lztm8YZCnEGdTCdiaPPBI4WltjRIe6hGkEY3z9Jp3JhA
	Tz3xIqNadm6i1kQukRvE4g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nt7ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 09:25:59 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 15:25:58 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 15:25:58 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C66A4820248;
	Mon, 29 Jan 2024 15:25:57 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <andy.shevchenko@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v4 3/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
Date: Mon, 29 Jan 2024 15:25:54 +0000
Message-ID: <20240129152557.3221212-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gdghCE4TGgvasgVyNJlJSWeJmIiytLmo
X-Proofpoint-GUID: gdghCE4TGgvasgVyNJlJSWeJmIiytLmo
X-Proofpoint-Spam-Reason: safe

__xxx is the preferred type for firmware interfaces.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v3.

Thanks,
Charles

 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 4e2bc5ad244a..65a331481d97 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -55,8 +55,8 @@
 struct cs42l43_patch_header {
 	__le16 version;
 	__le16 size;
-	u8 reserved;
-	u8 secure;
+	__u8 reserved;
+	__u8 secure;
 	__le16 bss_size;
 	__le32 apply_addr;
 	__le32 checksum;
-- 
2.30.2


