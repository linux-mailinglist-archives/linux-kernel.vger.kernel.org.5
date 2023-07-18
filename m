Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E064758343
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjGRROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjGRROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:14:16 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806111C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:14:14 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36I7rQ3L013833;
        Tue, 18 Jul 2023 12:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=c
        MMPz/fH5EniNJdP/uG9bosVI37Ht5TetmgLLC30gkk=; b=ZV1mPaJfp/LVTgTnp
        zp5FBbpFY+O+2jq8o/Oynq+K6SHpljGxF0YAmSuPzabGuOcOqWoF7C3BjZS0Y0+/
        xIfccT0HlZm9MzHBuSRLITxV/36O2bxU6YgNE+9OVTlQwr16+0EctBLpANHZu5W4
        2TDZ6xyzRW95YZvzIvrA/lqwX1tkTB5BB+apqIQ6RhrDcDRVhJF6+fbDeUVxtdnw
        pZFyfCxO+FMlNfo9pK5SY5fojDGuOBLxKe+HYvaAHpHHM9oXIv4nsjWlwWEFuADn
        S0DZRS8/Xa68v8Krk9d9E09v2Xv5WJYwspzusHSVswDOMjsRyVxBEodFrA5DAU0k
        dHGfQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3rus6gur76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 12:13:48 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 18 Jul
 2023 18:13:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 18 Jul 2023 18:13:47 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 00FE8458;
        Tue, 18 Jul 2023 17:13:46 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] regmap: maple: Clear async flag when doing a maple tree cache sync
Date:   Tue, 18 Jul 2023 18:13:46 +0100
Message-ID: <20230718171346.1002994-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1SCD0pyraLMVTWZovO3pBkZIkdqdoCRF
X-Proofpoint-GUID: 1SCD0pyraLMVTWZovO3pBkZIkdqdoCRF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal regcache_sync function sets the async flag on the register
map. The maple tree sync code uses a temporary buffer, which is freed
after the register is written, however, as the async flag is set the
buffer might not be used until after it is freed. Fix this by clearing
the async flag in the maple tree sync function.

Fixes: bfa0b38c1483 ("regmap: maple: Implement block sync for the maple tree cache")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regcache-maple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 283c2e02a2985..a24045a8c18f9 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -248,6 +248,8 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 	bool sync_needed = false;
 
 	map->cache_bypass = true;
+	/* Maple tree sync uses a temporary buffer, so clear async */
+	map->async = false;
 
 	rcu_read_lock();
 
-- 
2.30.2

