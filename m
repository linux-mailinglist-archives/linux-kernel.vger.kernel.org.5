Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B487BF59E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442797AbjJJIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442728AbjJJIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:23:32 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE8DB9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:23:27 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231010082322epoutp020604ea2e943d78fea305545ac54031ad~MsWQH3C9Y3053230532epoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231010082322epoutp020604ea2e943d78fea305545ac54031ad~MsWQH3C9Y3053230532epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696926202;
        bh=GpZy6Q+tXeZU5uccB0dIFaz7/p+CFzhMH/eTY6zV/SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNUuKSmxwRRBuvLAoViacekqjQj9Nq+9ekGljdjLSO4LF7fbnwMXEvV6QhpiniWqa
         adHo8nVciB5/s61K34oxHMb0SfXa+PBYzCofW8QewVzoaq6sd+F3ok81/UZgolNDB6
         cLkNoXtE95bd6YTpRJ10dy6f8XMrSXtpRU7DO8gU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231010082322epcas2p15e5de4639d4c453edf9e0523049a08b3~MsWPdkCSl3103731037epcas2p1c;
        Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S4TS95TwXz4x9Q0; Tue, 10 Oct
        2023 08:23:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.FA.09693.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epcas2p13641bd794b1c26d2137bb51093fd49f7~MsWOsYoiJ1887818878epcas2p1K;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231010082321epsmtrp279925121211d7579921935bbd7e39f5c~MsWOrR01p2242122421epsmtrp2Y;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-97-652509f99038
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.CE.08649.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082320epsmtip2cb008db60fb2feb5e219fa0cc4f670c6~MsWOb2Mo_0722107221epsmtip2D;
        Tue, 10 Oct 2023 08:23:20 +0000 (GMT)
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
Subject: [PATCH v3 2/6] cxl/region: Fix a checkpatch warning
Date:   Tue, 10 Oct 2023 17:26:04 +0900
Message-Id: <20231010082608.859137-3-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010082608.859137-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRze6b29vTxKrh26Q8mwXsUGFkpbeVwmbE7GcpW5IP5h3B/iDdwA
        o7RNb8FXokUemWTykCDQCYww3OyAhYqkTAjvyQQyGJMIrpsFBo4KQTuYKGO2vaj77/f9zvfl
        y/edc3BEMoVJ8WytkTVoGQ2J+aJdQ2ExEVs+oayytfp5yr4wiVGFVc2AqqmeBNTobAFGXZpt
        BdQnl+xCqrD5Mkat/7aDUv1Ok4gan7gnpCxNMxg13PajgGoeqUWokR6cum7+AaWmr3yJUXMV
        VwVUx5017CUJ3W22i+ii4VUh3dxzT0BbLZ9idF99q4gu67QAuvrsx7TLGpKCn8yJz2KZDNYg
        Y7XpuoxsbWYCmfxGWmJadIxSFaGKo2JJmZbJZRPIo8dTIo5la9xRSFk+o8lzr1IYjiMjD8Ub
        dHlGVpal44wJJKvP0Ohj9QqOyeXytJkKLWs8qFIq1dFu4js5WXPmPH27/3s3uvxMwOpbCnAc
        ElHw0WRQKfDFJYQNQNPfjSgP/gCw8Kc1IQ82AXxUuSMqBT5exfm7jRh/0AvgXxcviniwDWB5
        zefAw8KIcFhTZ/LKAwmHAHavlAk8ACHmBfD30RXEw9pLxMO6chvqmVEiFC42NHs9xMRBuGUf
        EvJ+T8O+gQkv34d4EToaVzGe8wS8Vrfo1SJuTuG3ZxGPASTGcTiy1IXy4qOwf6kI4ee9cOX7
        zt0QUuha68V4QSGAzuWbKA+KAGz/2bbLegGuzS4LPUUhRBi8fCWS7+xZODy3axwATw89FPFr
        MTxdIuGFJGxoadi1hfBGfefuTMO5+56GPHWVAbjx0CqoADLzY3nMj+Ux/298DiAW8BSr53Iz
        WU6tV/13xem6XCvwvu3wJBuoWl1XDAIBDgYBxBEyUDyf/RwrEWcw73/AGnRphjwNyw2CaHfb
        lYj0yXSd+3NojWmqqDhlVEyMKlYdrYwl94lvF9dnSIhMxsjmsKyeNfyrE+A+UpMg7pXUBHO8
        0KZ/sBmmUFfJt05saVrLT8pPfLd5fabtdneIXT4jLy+umKedb2/4p8s/g/vnDQt7hvYMtCDU
        Pp+42ogE5PUev8OOL64dmBVYh0ZTHcOBllBbcof0Ankg6N0cBRNET7g2+jvHZP5S5i2LvGGh
        uPZmcOKDXtOZAbPwF+f+0I4l+4d+ju1bakl+OZfZQjTNXJ0wN53/Jql9GB//1WkMW07sW791
        5lzJa2l1qSniu4v+qUeansmNpqZr3wzYms7vNB55+dT9ZIdrTHR4Z92JVKpDAi4E//lV5Kt3
        8o9tk/OuQMWpguC2kqDE40lLyfkfoQXo1NTgoTCmauxrEuWyGFU4YuCYfwB+4Z+DZAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXvcnp2qqwdo2Dou7jy+wWTRPXsxo
        MX3qBUaLEzcb2SxW31zDaNG0+i6rRfPi9WwWH978Y7E48LqB3eLM2ZesFqsWXmOzOLL2KpPF
        4qMzmC2O7uGwOD/rFIvF5V1z2CxuTTjGZLHx/js2ByGPnbPusnu0HHnL6rF4z0smj02rOtk8
        9s9dw+7Rt2UVo8fU2fUenzfJBXBEcdmkpOZklqUW6dslcGXcmlVasI6n4tI27gbGTVxdjJwc
        EgImEkuezmcDsYUEdjNKvJ1sCxGXkFi+4QUThC0scb/lCGsXIxdQzS9Gicebr7CCJNgEtCSm
        z2wAS4gIPGeSOPnmFCOIwyzwikmi9/91ZpAqYQEbiZn9O1hAbBYBVYkn8xazg9i8AlYSP+8e
        ZoVYIS+x/+BZsHpOAWuJh/PfQp1kJbHtYDsbRL2gxMmZT8DmMAPVN2+dzTyBUWAWktQsJKkF
        jEyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCo0tLYwfjvfn/9A4xMnEwHmKU4GBW
        EuF9lKmSKsSbklhZlVqUH19UmpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVAMT
        +/rJP2T2Ptqsc/B9mNYTobU/T4cbvlFbN5PH3Kacsd1U9ffet5zz11plXxbstRaefrW3fOoX
        hkD7pNiNNos/ZrI3/lIN1vlUXxT+38zsnJNo0t/kZoePnmYH6i/LaYQv771598PDzOnRyfPt
        f8i0aR8Mu3jhs5zozRl8LxViFpxX+2uYzvr+n1uvS9xrwQMNX48/fP1d1L1FJrA7+Wtp9pkP
        grlmmy0O171N3rmW8Xrrq1ufSiIq2KfcSl8gnjt5pnpHTKya+sIUV/M7uY9Y69/dEs2+evza
        JJkrh28UXnz15dmBX/GSp5zWSh44n1VZ9mi9f8vsiG8b4yJi606f5N/Xs3xi7tvvcefbUvp2
        KrEUZyQaajEXFScCAMZvt8QdAwAA
X-CMS-MailID: 20231010082321epcas2p13641bd794b1c26d2137bb51093fd49f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010082321epcas2p13641bd794b1c26d2137bb51093fd49f7
References: <20231010082608.859137-1-jtp.park@samsung.com>
        <CGME20231010082321epcas2p13641bd794b1c26d2137bb51093fd49f7@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: else is not generally useful after a break or return

Since cpu_cache_invalidate_memregion() already checks for
support of invalidaton operation, it can be removed.
This change would make more efficient or small codes
when 'CONFIG_CXL_REGION_INVALIDATION_TEST' is not set.

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/core/region.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e115ba382e04..0eb7a12badb9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -127,21 +127,15 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
 
 static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 {
-	if (!cpu_cache_has_invalidate_memregion()) {
-		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
-			dev_warn_once(
-				&cxlr->dev,
-				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
-			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
-		}
+	if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)
+			&& cpu_cache_has_invalidate_memregion()) {
+		dev_warn_once(
+			&cxlr->dev,
+			"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
+		return 0;
 	}
 
-	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-	return 0;
+	return cpu_cache_invalidate_memregion(IORES_DESC_CXL);
 }
 
 static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
-- 
2.34.1

