Return-Path: <linux-kernel+bounces-135543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA489C758
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2551282DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F013F45D;
	Mon,  8 Apr 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pYzDZLZk"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4C13F00F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587571; cv=none; b=eLE2G8fRFS3LTR+FAncQSTfetr9oQQtofcNoZ/ixyC7trcA3swi+zyWAXzqw+tBj1iVhX+cXmlwMt+Yy9wm8AXu9Xn2WJ1Y22+hUpgzsQMkoo8nKJu8ucdRT5b2yHhgBrNVcj8wpj0Hf1NNb4Gy/BQCxzX0LqySj22UYlvyRXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587571; c=relaxed/simple;
	bh=sTfmfVPhpMGuDAHbqYsRP7cnCg3e51KBYNhc//xaRAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq/HI5U9dS/jn2vWvpIHzQe+nZ6hJOvq3Qy7lx0NRqosuVAsYJsMNQ/u97oEAWkAfyl7Bh0EnvY3zdSJwbwXQLhOmhmY5x0m2lfEBhTzjAycmFRAVLH6ASfwx9L1YqvixmvBeasB/SCWiV4/fd1J7dsryepFqv0EomACfwoOUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pYzDZLZk; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385mlL4032409;
	Mon, 8 Apr 2024 09:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=QPpgOfGYK0iVtyw0IHD3gINHQz41xmuzbxAEiOBp3XY=; b=
	pYzDZLZk4vLj1y5YGg3wyvboG7NYRupMmFFTNPYplrh/qp1cBOOh6CfVrMTcH3gu
	FPZz9OT3leKJyzCzeyUCoUopdOPIzxftIdvM/J1QYLoZHMB/EhTI/ED7rqefqTzB
	9INbHIm5+zv3gkwSj2DsCfgMRajyS8D81wH1wHzOKavlTzi6bAgBVGe03ur8MoXf
	v6t6MRISrqdtczo1MntsZ2gDpSc3+wQBjizQ0gEkuZcGKhNXBWOSpp0Z+PPg+EjI
	gDb0nWB75nYqTkJHXMCl4oE305YIM8gkyMZqbdtevhYdxpIwThLV4GW9eLSrWkEj
	U4JJ4gPlTh8zmodSpsPtvQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxhjp7-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:46:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:46:01 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Apr 2024 15:46:01 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C2E3B820271;
	Mon,  8 Apr 2024 14:46:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 09/11] regmap: kunit: Replace a kmalloc/kfree() pair with KUnit-managed alloc
Date: Mon, 8 Apr 2024 15:45:58 +0100
Message-ID: <20240408144600.230848-10-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: c5yPfZbTj3D8-9jqQ7an6X-z9_piVggn
X-Proofpoint-GUID: c5yPfZbTj3D8-9jqQ7an6X-z9_piVggn
X-Proofpoint-Spam-Reason: safe

Replace the kmalloc() and kfree() in raw_read_defaults() with a
kunit_kmalloc() so that KUnit will free it automatically.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-kunit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index e21028cbddc3..4c29d2db4d20 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1360,7 +1360,7 @@ static void raw_read_defaults(struct kunit *test)
 		return;
 
 	val_len = sizeof(*rval) * (config.max_register + 1);
-	rval = kmalloc(val_len, GFP_KERNEL);
+	rval = kunit_kmalloc(test, val_len, GFP_KERNEL);
 	KUNIT_ASSERT_TRUE(test, rval != NULL);
 	if (!rval)
 		return;
@@ -1375,8 +1375,6 @@ static void raw_read_defaults(struct kunit *test)
 			KUNIT_EXPECT_EQ(test, def, le16_to_cpu((__force __le16)rval[i]));
 		}
 	}
-
-	kfree(rval);
 }
 
 static void raw_write_read_single(struct kunit *test)
-- 
2.39.2


