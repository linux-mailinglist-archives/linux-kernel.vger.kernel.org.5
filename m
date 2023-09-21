Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925907A910C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjIUCsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjIUCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:47 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D047E8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230921024833epoutp02dff2527906246616e276167dde4f8ffd~GyhfvKmBn1787817878epoutp022
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230921024833epoutp02dff2527906246616e276167dde4f8ffd~GyhfvKmBn1787817878epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264513;
        bh=JsGFPRSyn0agbiv2BsE55C5s//NowQKDPVALOSXvPFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsmWTtqYa/K6ZstkAwfICFKd9eqcdUQctc5DlKN1yRE+2iVY5j8PaAGNtu2OlwFJM
         KtZQmld7d/o3WeWjty8dO8wWUPITO3c5xJPYE2As9OAWx2HrMrQn0YW/+8lfVzpqlu
         by0g4WX/YveWlSQZWkvnecjRE35yoX70RT5sj9eM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230921024833epcas2p38de9ac9ff5a072c27b9b7ce4dd688eba~Gyhe_EWrA2379423794epcas2p30;
        Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rrfwc5BJmz4x9QB; Thu, 21 Sep
        2023 02:48:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.AE.09649.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230921024832epcas2p3677e522ed0175b83c1a56e36a730ce97~GyheJd-Vw2379423794epcas2p3w;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epsmtrp17d96bf194d512a6bdb7bdbf9965d156f~GyheFPkw30473204732epsmtrp1G;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
X-AuditID: b6c32a46-943ff700000025b1-ca-650baf001e11
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.D7.18916.FFEAB056; Thu, 21 Sep 2023 11:48:31 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epsmtip2c025d707382acb4bdbdd10b52e7cea8d~Gyhd0MWoQ2027220272epsmtip2b;
        Thu, 21 Sep 2023 02:48:31 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>,
        Jeongtae Park <jtp.park@samsung.com>
Subject: [PATCH 4/7] cxl: Fix a checkpatch error
Date:   Thu, 21 Sep 2023 11:51:07 +0900
Message-Id: <20230921025110.3717583-5-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025110.3717583-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHve+1rw+WzmcVvGuCsjfdAqHYVqAPBzqjMV2EhIWFhP3qHu1L
        IdAf6SuLW+IECo6RgBhhrEUYQoixlPEjlQEzwUEZuIk0wGYKlmF1IFSworgRN7eWh5v/nXPy
        +X7PPefei6OicUyM5+nNjElPF5BYOK9nKEYh2dLxEiP13HmD8t5xY5TlXAug6mrdgBr1FGNU
        m8cBqJI2L5+ytHRgVOD+Mx511V8koK6PLfIp+4VfMcrV/gtCtQx/jVLDV3Bq3PYTj5rsP49R
        09U/IlTXbyvYWyJln80rUJa6lvnKliuLiLLb/iWmHGhwCJRVTjtQ1tafUj7q3pWBv5efksvQ
        GsYUzejVBk2eXptKHs9UHVElJkllElkypSCj9bSOSSWPpmVIjuUVBEchoz+hCwqDpQyaZcl9
        B1NMhkIzE51rYM2pJGPUFBgVxniW1rGFem28njEfkEml8sQg+HF+rvvPUcRowU48ninjF4FK
        fgUIwyGRAG8V1aAVIBwXEb0ADnt6+FyyCuCCs10QojaSbyrx54rS2X4BB/UBWH+rBHDQXwDO
        unWhGCNiYZ21aMNpB3EbgX1LVUgoQQkfAh+OLqEhajshhY5Od1CN4zxiL1wvl4TKQuJNOOn5
        XcB12w0HfhjbwMOIFHjj3gTCMdvgNetdXihGg4zlcj3K8aM49H13OGQJiaOwvl3BlbfDpRHn
        pqUYLp45vTEAJCwA+hemeFxSCuC3M72b1H644lngh4xQIgZ29O/jPF+DrunNti/D8qG/BVxZ
        CMtPizghCRtbGzdPA+FEg3MzVsKmJhfg9nYGwJ/PN/OrQbTthWlsL0xj+79xE0DtIJIxsjot
        w8qN8v8uWG3QdYONlx17rBfULAfiBwGCg0EAcZTcIVSvhjMioYb+9DPGZFCZCgsYdhAkBld9
        FhVHqA3Br6E3q2QJydKEpCSZQp4oVZA7hbNlDRoRoaXNTD7DGBnTcx2Ch4mLkIRdvUhtzYi1
        4/BOXOY7/o6lYcSPt64d2eP9ZznGkL6WopnH47QCefLcNcUlVwU5p83KdJqqdjtal9mTN9Zz
        Xp1TPbm5J6cq4qIkrLNyS5rm0v75cx/2uCLvPnMJqsyZndkPcuaKsxV7nTPxSz7r5RFLjjfr
        qTi5NHO5S02kJ91zN3cfvCq4zthWFtORqNuHfPXNBx5/QPdZA1Frq36hJKpGPd311f233X+E
        jX8um3j9qXikEYs8pTub/sVQ8vuErNp+0pZdUtb6UaCuuO37tEDgUXPu1kNro08aHHHm7K0Z
        izlu37b5/Fci7GjczYcP1ien3s2akrsHFqwn0LFmP8ljc2lZLGpi6X8BTROm6GIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXpdhPXeqwRFTi7uPL7BZNE9ezGgx
        feoFRosTNxvZLFbfXMNo0bT6LqtF8+L1bBYf3vxjsTjwuoHd4szZl6wWqxZeY7M4svYqk8Xi
        ozOYLY7u4bA4P+sUi8XlXXPYLG5NOMZksfH+OzYHIY+ds+6ye7QcecvqsXjPSyaPTas62Tz2
        z13D7tG3ZRWjx9TZ9R6fN8kFcERx2aSk5mSWpRbp2yVwZVz4cYKpoJmt4svtVtYGxl7WLkZO
        DgkBE4mWe7vYuxi5OIQEtjNKbP63gAkiISGxfMMLKFtY4n7LEVaIol+MEh+OnGUDSbAJaElM
        n9kAlhAReM4kcfLNKUYQh1ngFZNE7//rzCBVwgIGEms2XABKcHCwCKhK/OzQBQnzClhLXL75
        lB1ig7zE/oNnwco5BWwkzr24BLZZCKhm+aW9bBD1ghInZz5hAbGZgeqbt85mnsAoMAtJahaS
        1AJGplWMoqkFxbnpuckFhnrFibnFpXnpesn5uZsYwXGlFbSDcdn6v3qHGJk4GA8xSnAwK4nw
        Jn/iShXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgmq6q
        6+ZVkzG/yWLnQxluuds/P/5/NrXf1/instAqly1Nkp/SGtqDzj4VSEi/tyepunuW4+1avZnR
        O3N2PzNcGcH2zutRzQWhox9392/3ajnwo3zbPrXvPJtdjMwitz7miZb7XC6Se9rwkU3F+/Sc
        JSc1XB5bfZkRKjGd7WlXbu2huzO3Pzp3peIE8/qvPyzsdz50y3AxSJQ4MltdYk1p9j3Bmumi
        CYz/stmf3NYJelsz10nhkJOW7PWWEpnvy3cYKDz6ZOOdoxXOcuCpbcde5tAdU/fqcE+zZNna
        v+L1Sva8R58esj5+q69gbKvFcTj+xs5qJe5TnRaMdhcD1vtpGNYs7jgyxcbrmby0cUONEktx
        RqKhFnNRcSIAxmh3RRoDAAA=
X-CMS-MailID: 20230921024832epcas2p3677e522ed0175b83c1a56e36a730ce97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024832epcas2p3677e522ed0175b83c1a56e36a730ce97
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024832epcas2p3677e522ed0175b83c1a56e36a730ce97@epcas2p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/cxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..545381355efb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -142,7 +142,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
 #define CXL_HEADERLOG_SIZE SZ_512
-#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
+#define CXL_HEADERLOG_SIZE_U32 (SZ_512 / sizeof(u32))
 
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
-- 
2.34.1

