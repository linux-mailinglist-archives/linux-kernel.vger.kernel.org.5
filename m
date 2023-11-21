Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2115F7F339D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjKUQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjKUQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:25:21 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB1F1A2;
        Tue, 21 Nov 2023 08:25:17 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALDQR9s022514;
        Tue, 21 Nov 2023 10:25:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=a
        /7u789OEKGmrzwWMfo3Tx7id73xOZOq/UBx/8LmtAk=; b=VdJvR+PM1JVNbKr+B
        wvEHwmOA+mU45lBA85+WhADAivTLMG8mYI55kEKPbQiaY3U72QH7Uq54vwweSbvn
        xp8Q/gdM0xvvyOIIlTf2+Sp5C6HBP9kmwO8RX5V6jIZJ274UWdribh2qPm65X2F1
        e2FEtrXKxHeVLxxsFvCVcYGC5E+808eMOvubfLbM8hMBAdJpKoN/DOsO/GiDkHq8
        7DZCcyM/0jFiW366QFU5AeqkTfqvcvq5sADMw8VhpUCGuCW7BXPlYcePFuYtDf/K
        T9wxwJ7NTChSiFgZ27lqnR1SdZItxNeOfgV6SEC/t2LcHTEoFFLcorrIx6r5JSmI
        pXK0Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ueuj2bdag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 10:25:02 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 21 Nov
 2023 16:25:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Tue, 21 Nov 2023 16:25:00 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.98])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BC675458;
        Tue, 21 Nov 2023 16:24:59 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] kunit: string-stream-test: Avoid cast warning when testing gfp_t flags
Date:   Tue, 21 Nov 2023 16:24:57 +0000
Message-ID: <20231121162457.17703-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 11SOlOybwqtl2KAu4CPyy3AQ8cBaz4Ma
X-Proofpoint-GUID: 11SOlOybwqtl2KAu4CPyy3AQ8cBaz4Ma
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing a gfp_t to KUNIT_EXPECT_EQ() causes a cast warning:

  lib/kunit/string-stream-test.c:73:9: sparse: sparse: incorrect type in
  initializer (different base types) expected long long right_value
  got restricted gfp_t const __right

Avoid this by testing stream->gfp for the expected value and passing the
boolean result of this comparison to KUNIT_EXPECT_TRUE(), as was already
done a few lines above in string_stream_managed_init_test().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: d1a0d699bfc0 ("kunit: string-stream: Add tests for freeing resource-managed string_stream")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311181918.0mpCu2Xh-lkp@intel.com/
---
 lib/kunit/string-stream-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 06822766f29a..03fb511826f7 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -72,7 +72,7 @@ static void string_stream_unmanaged_init_test(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, stream->length, 0);
 	KUNIT_EXPECT_TRUE(test, list_empty(&stream->fragments));
-	KUNIT_EXPECT_EQ(test, stream->gfp, GFP_KERNEL);
+	KUNIT_EXPECT_TRUE(test, (stream->gfp == GFP_KERNEL));
 	KUNIT_EXPECT_FALSE(test, stream->append_newlines);
 
 	KUNIT_EXPECT_TRUE(test, string_stream_is_empty(stream));
-- 
2.30.2

