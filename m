Return-Path: <linux-kernel+bounces-135540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C689C755
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB20C28403E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFE13CFAF;
	Mon,  8 Apr 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hxzKDxsP"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D213E8AB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587570; cv=none; b=AscGmnu0MzDx/GukgR7jvD+scKQkcDgYOuqs+48FA5dmqj9xQzIzQPBoloNqMzzCGWRWmBy14BnJGNyX994X60AOvOTJu2btP5X6Et3E9awq40BWpS0VAWDl0m5CYQcT9aoZ0kfnbGe35MTaf8mPOdgqejVKJiShsvPNgEOiHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587570; c=relaxed/simple;
	bh=2VvsmAud6HU2mz3SIdnGDsedcDs4k8YOUBKNvajsU88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSHUGgBcjX6jHudif4ViYA4EkjLpxinFeNfHl7no5uyf0IavCq2jGbdAhjYCRT7PdQhS5+/o3EqNNe598i8FQtdycbwdZ8srgrEu8wutLrugFvI6QllBekE0Fw1TOz7cqJSFVaMx+llPzgUHJrqAXOomt2U7p024oVMRuYfnhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hxzKDxsP; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385hvQm026412;
	Mon, 8 Apr 2024 09:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=3TPAwAiwLKJ6paogqx6Zr4LOq26x7e1uKRWSbDHaXj4=; b=
	hxzKDxsPkPgitM1MrXsce2k8rxInMxpI8rSdbOWXiZild4QgjBFB9FLcg8ysdaPx
	txaA00Cm6ZZJj4oL3C/U9zvqowLh+B38o6b04TkXheudfFt6revjVhXB5BfWznzY
	OZbnUR99CFqBnY75z5/tgbmh0Ld21cYH1c61pDIdM/jcZF5nZ1tBCZToqfM90I+d
	jnFqVONJWvEEB33fknYn3YS8MaLGT2vd//fd2fp+eNr2fAgd8Z1EDWsnbPoxhZ9t
	V+K0ISGpSvdKF3R+IvpCXKLJgZBm90HkhavIaGUM2L1hEs26+6rvKxtlzfg/7gdm
	vMJgFkYCvZfgAuvcOhl4Hw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:04 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id ACC51820243;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 01/11] regmap: kunit: Fix warnings of implicit casts to __le16 and __be16
Date: Mon, 8 Apr 2024 15:45:50 +0100
Message-ID: <20240408144600.230848-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408144600.230848-1-rf@opensource.cirrus.com>
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xNhCxnl_K8S4zfaaPeGKnBlPpjM43t2X
X-Proofpoint-GUID: xNhCxnl_K8S4zfaaPeGKnBlPpjM43t2X
X-Proofpoint-Spam-Reason: safe

Fix warnings about implicit casts to __le16 and __be16 types reported
by smatch:

drivers/base/regmap/regmap-kunit.c:1118:25:
warning: cast to restricted __be16
drivers/base/regmap/regmap-kunit.c:1120:25:
warning: cast to restricted __le16
drivers/base/regmap/regmap-kunit.c:1187:33:
warning: cast to restricted __be16
drivers/base/regmap/regmap-kunit.c:1190:33:
warning: cast to restricted __le16
drivers/base/regmap/regmap-kunit.c:1302:33:
warning: cast to restricted __be16
drivers/base/regmap/regmap-kunit.c:1305:33:
warning: cast to restricted __le16

Perform a __force cast for all these.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index bb2ab6129f38..b46a4f28c1a1 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1115,12 +1115,12 @@ static void raw_read_defaults(struct kunit *test)
 	for (i = 0; i < config.max_register + 1; i++) {
 		def = config.reg_defaults[i].def;
 		if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
-			KUNIT_EXPECT_EQ(test, def, be16_to_cpu(rval[i]));
+			KUNIT_EXPECT_EQ(test, def, be16_to_cpu((__force __be16)rval[i]));
 		} else {
-			KUNIT_EXPECT_EQ(test, def, le16_to_cpu(rval[i]));
+			KUNIT_EXPECT_EQ(test, def, le16_to_cpu((__force __le16)rval[i]));
 		}
 	}
-	
+
 	kfree(rval);
 	regmap_exit(map);
 }
@@ -1185,10 +1185,10 @@ static void raw_write(struct kunit *test)
 		case 3:
 			if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
 				KUNIT_EXPECT_EQ(test, rval,
-						be16_to_cpu(val[i % 2]));
+						be16_to_cpu((__force __be16)val[i % 2]));
 			} else {
 				KUNIT_EXPECT_EQ(test, rval,
-						le16_to_cpu(val[i % 2]));
+						le16_to_cpu((__force __le16)val[i % 2]));
 			}
 			break;
 		default:
@@ -1300,10 +1300,10 @@ static void raw_sync(struct kunit *test)
 		case 3:
 			if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
 				KUNIT_EXPECT_EQ(test, rval,
-						be16_to_cpu(val[i - 2]));
+						be16_to_cpu((__force __be16)val[i - 2]));
 			} else {
 				KUNIT_EXPECT_EQ(test, rval,
-						le16_to_cpu(val[i - 2]));
+						le16_to_cpu((__force __le16)val[i - 2]));
 			}
 			break;
 		case 4:
-- 
2.39.2


