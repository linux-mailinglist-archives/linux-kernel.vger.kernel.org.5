Return-Path: <linux-kernel+bounces-120768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596188DCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CC71C2586E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851312883D;
	Wed, 27 Mar 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GeaZvMfp"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C9128827
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539853; cv=none; b=fZtJUuRk+gYD/P2sbqJgJunL7i7A2lyNbDDQ0GRViL7oh47PP9n22Nvutyr3wZ/sF3qDlt2HMeM1R6W6rDqX7dGKkpo2U+Zo7SqG3Wxx++zVWDe6q5GmMvAZTugu6dnViHBeVvSLvBz/wyoia13iV6b46fIModr3DhR20YlXrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539853; c=relaxed/simple;
	bh=nljWhfqKr4AC2yw5PlZRC4zCYIVGlHgtDCtDA93Dp2E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H15VtHO4YpPzV/FmqnWDtUyRGA/8vxQj7fTt5qVYardh2ddRUbXPi9pJ6/HYK6kxHKX3rC9ONc2pq9hunjyH8gCGU62y4m94NtHIQJ1hPMipy5BTIKvElZGttswUw1NGSbCL0b0uA0ppOQ2U6r1btu7LCq3oDiwm2MrMqg0V3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GeaZvMfp; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R4cFXC010149;
	Wed, 27 Mar 2024 06:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=L
	ac8H7R3zm0lUQHp4v6nVKoKn2WF9gC+zAcJfYjCrEA=; b=GeaZvMfpoKiU+WMsE
	YInMtRawsD7a9CfmGyPuCFwg9xmvXgXXWv1+berbDGlzNMOpwMLjGkUjMoDwsbv8
	qkKvB0CIK90a4gfPcLEEvfep/EjZHNwLRfqNeEhNzXX+D4xrajGqm6SKmNRiq8q4
	dV3r7qYfij7w+7PClZvE3gE4wEyh8fpm8m2tirWhJchbtR7ZS1P5Lgbw92ER2yST
	xEXRmNq2nEJ3vpyEgq3B2vlLl+U8bYl5C+z65oDfPyuXZk9S/gabSjk6rS5yt2pe
	p6LVsY5a8X9AK8zPML2jYSZkzafsw4faheIt+KLwaTT0UNGY/kZRyFnn2zNi7/Fo
	b3lQA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyev5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 06:44:09 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 27 Mar
 2024 11:44:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Wed, 27 Mar 2024 11:44:06 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EA14E820245;
	Wed, 27 Mar 2024 11:44:06 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] regmap: maple: Fix cache corruption in regcache_maple_drop()
Date: Wed, 27 Mar 2024 11:44:06 +0000
Message-ID: <20240327114406.976986-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yzrfu7CvoQ5N5nsH931g8ql30Jzs26r8
X-Proofpoint-GUID: yzrfu7CvoQ5N5nsH931g8ql30Jzs26r8
X-Proofpoint-Spam-Reason: safe

When keeping the upper end of a cache block entry, the entry[] array
must be indexed by the offset from the base register of the block,
i.e. max - mas.index.

The code was indexing entry[] by only the register address, leading
to an out-of-bounds access that copied some part of the kernel
memory over the cache contents.

This bug was not detected by the regmap KUnit test because it only
tests with a block of registers starting at 0, so mas.index == 0.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
---
 drivers/base/regmap/regcache-maple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 41edd6a430eb..c1776127a572 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -145,7 +145,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 			upper_index = max + 1;
 			upper_last = mas.last;
 
-			upper = kmemdup(&entry[max + 1],
+			upper = kmemdup(&entry[max - mas.index + 1],
 					((mas.last - max) *
 					 sizeof(unsigned long)),
 					map->alloc_flags);
-- 
2.39.2


