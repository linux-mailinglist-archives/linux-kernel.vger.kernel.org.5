Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F177AB4DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjIVPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjIVPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:37:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7329122
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:37:19 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38MC0AqK016187;
        Fri, 22 Sep 2023 10:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=n
        KhM77gqNSy8Ek4opOM5KZqnhQBhQZLQUyl0L4NNigk=; b=gEOh2xPkoFKemoYtx
        r+m6uFs4NSKVCBXN7bEgk99Uubibfw2i4FaAklPUKuA3+LzBrplnWRqlZaHpd64p
        vfp98uVmDLJD/blv8Oxi//jC2DjVyLG0FDdKOJNcIxbx5iEMbUEXv6qgYQz2Vyjl
        cI9pELGbIAS7gxBPPdc8A/idZfmhtLvVVanVFYpcLExUi6qsPWCX5+DEToExwV61
        6Bfg9zZwRTw7mQW+qGrXrkjxzXKJwsCQRIgok9LFDK7RSwVBEepKOBOd9J70xNwU
        qtEFMjr1sVoUb5YdRxJ7Eum4asLHpEW0QU/V1+J7sp+OlT/2DCWWzMwUzN9RXYRo
        pZfCA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t8tvhsdan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 10:37:17 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Fri, 22 Sep
 2023 16:37:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Fri, 22 Sep 2023 16:37:15 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (unknown [198.90.238.129])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B363911AA;
        Fri, 22 Sep 2023 15:37:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] regmap: rbtree: Fix wrong register marked as in-cache when creating new node
Date:   Fri, 22 Sep 2023 16:37:11 +0100
Message-ID: <20230922153711.28103-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -zK9O-u8XVrb3s-yA7IUBGANnrLMlZ9K
X-Proofpoint-GUID: -zK9O-u8XVrb3s-yA7IUBGANnrLMlZ9K
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When regcache_rbtree_write() creates a new rbtree_node it was passing the
wrong bit number to regcache_rbtree_set_register(). The bit number is the
offset __in number of registers__, but in the case of creating a new block
regcache_rbtree_write() was not dividing by the address stride to get the
number of registers.

Fix this by dividing by map->reg_stride.
Compare with regcache_rbtree_read() where the bit is checked.

This bug meant that the wrong register was marked as present. The register
that was written to the cache could not be read from the cache because it
was not marked as cached. But a nearby register could be marked as having
a cached value even if it was never written to the cache.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 3f4ff561bc88 ("regmap: rbtree: Make cache_present bitmap per node")
---
 drivers/base/regmap/regcache-rbtree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index db716ffd083e..3db88bbcae0f 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -453,7 +453,8 @@ static int regcache_rbtree_write(struct regmap *map, unsigned int reg,
 		if (!rbnode)
 			return -ENOMEM;
 		regcache_rbtree_set_register(map, rbnode,
-					     reg - rbnode->base_reg, value);
+					     (reg - rbnode->base_reg) / map->reg_stride,
+					     value);
 		regcache_rbtree_insert(map, &rbtree_ctx->root, rbnode);
 		rbtree_ctx->cached_rbnode = rbnode;
 	}
-- 
2.30.2

