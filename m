Return-Path: <linux-kernel+bounces-37225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60E83AD0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02702B2AD28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAB7C09A;
	Wed, 24 Jan 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="d2KEYnie"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0D7A73D;
	Wed, 24 Jan 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109161; cv=none; b=OIqVbIGRJ4yy3pST7dh7S8WNzu2MnghkE5DT42mpeqjNvbBnKAyDdEPjz5gsF4oNTxw1miUcudsMnOpC/toGc9PQy7PDADWGmznOY2C0IlcRH/MnQErzD6d//pDE1ePRlbeGqCu/1VXtRcbBzaHWEw9k4KwySgEigvEFKIbURwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109161; c=relaxed/simple;
	bh=ceYKVMP1sIHfuMD9zr8q+V6zUBR/GmLAtM3+c440sUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjItBluvoUV2mTgjc+Kaa7I20Y8CD/pVz4BT7WVdp8l/vgSWhNK0x1Zh7hcWyEyNOWwum77Zr7Cy68G2yMh5s40ZZq69hGqg76uKevOeyTfEQxl2sIN0kpgsYSCVeuL4ubmx8HP/b23A80aVngFGbe2zHirX/FG6KvLGJNRhqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=d2KEYnie; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O7L4cu000450;
	Wed, 24 Jan 2024 09:12:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=UAmUNjNglZyS7hY/q2jq7ASryAkphOCeaZdMTk9JhPw=; b=
	d2KEYnierMPR13TzXQJCIILQSSTCmUbWDn3TJzzmQ6yXH7W+L+fK2h/JV726Eia3
	k/vWBA2bqI61k87NEULseHvmiiZWJihbXQBvFGQnrIXayuxL4pvz0E8RKB2w0+pe
	awVr5BlXE7FDJAZR7g6YQyKHS0d8HYEui6pKchkyimK7xa7wI2DLWUMbSR3O4JMQ
	wVGdii7SHiAnsiJ3s8RqG5+J31vXnm7TMAWJFnLMrBb0pDUbariScIrl+36vndQq
	t2rPpG20522zc2EtVvot127L5JuCyowv1bXaT29jZPT1bo3W0ATiulXrJxqXU6P0
	bDE6Mg1WkM1E3ZXbS4TB4Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhgxx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 09:12:24 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 15:12:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 15:12:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2DB25820247;
	Wed, 24 Jan 2024 15:12:22 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 2/6] mfd: cs42l43: Use __u8 type rather than u8 for firmware interface
Date: Wed, 24 Jan 2024 15:12:18 +0000
Message-ID: <20240124151222.1448570-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
References: <20240124151222.1448570-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RSmkEUNS_LvGYccNZCvztoVmUzB97cOd
X-Proofpoint-GUID: RSmkEUNS_LvGYccNZCvztoVmUzB97cOd
X-Proofpoint-Spam-Reason: safe

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 4e2bc5ad244a5..65a331481d975 100644
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


