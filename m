Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60F7AB100
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjIVLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjIVLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:34:32 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72241994
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:33:53 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230922113352epoutp02baa4fd27f5185a7229ad8656b637fc9a~HNVb4wl4k2482924829epoutp02G
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:33:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230922113352epoutp02baa4fd27f5185a7229ad8656b637fc9a~HNVb4wl4k2482924829epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695382432;
        bh=GeR9HYJuHHTGZH8ixk+61KVjXRkSlfy93Eh+hAy3BGw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=n1r5/ZBs03bmpXqAuwIAbWyhuNQnpM70BEhqNH1hxwsB/PG587T2wQXMpVN0WeBN1
         ipoYVT53KY88xcNsDlghv1HYlRK16PT/7hqX60ytPXv3hzCjrr/xXJppTIm87l2fSJ
         ijh9Hiwpp/4I9Zg2bUf6CGNMGxTXYBt8vMLGJ3h0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230922113350epcas2p25c37471828a372d0426b6b37caa277ac~HNValPwoQ2731427314epcas2p2w;
        Fri, 22 Sep 2023 11:33:50 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RsVXG4wp8z4x9Pr; Fri, 22 Sep
        2023 11:33:50 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.21.19471.E9B7D056; Fri, 22 Sep 2023 20:33:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113350epcas2p230c0ea8019d20f8ae8d246a5566d3a64~HNVZxKHcp2731327313epcas2p2v;
        Fri, 22 Sep 2023 11:33:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230922113350epsmtrp129b588400d757e39f76ab7c681fc1e62~HNVZwTX_G1456814568epsmtrp1o;
        Fri, 22 Sep 2023 11:33:50 +0000 (GMT)
X-AuditID: b6c32a4d-dc5ff70000004c0f-0a-650d7b9e0675
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.37.08788.D9B7D056; Fri, 22 Sep 2023 20:33:49 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230922113349epsmtip209b03cc9cdd5493b6fa2498ed3de0635~HNVZdRAM70037300373epsmtip2E;
        Fri, 22 Sep 2023 11:33:49 +0000 (GMT)
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
Subject: [PATCH v2 6/7] cxl/memdev: Fix a whitespace error
Date:   Fri, 22 Sep 2023 20:36:36 +0900
Message-Id: <20230922113636.3301482-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmme68at5Ug6WbFS3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE74/iFZawFa9gr3jUeY2pg/MnaxcjJISFgIrF8zxOWLkYu
        DiGBPYwSDz+3QjmfGCWa375nh3C+MUocn/OCGaZlwZf7zBCJvYwSc/r/QFX9YZQ4+XQeWBWb
        gJbE9JkNrCAJEYGHTBI7X/UxgTjMAo+YJD6eeAVWJSxgJXFh9huwU1gEVCVWN35iBLF5Bawl
        1m55zwaxT15i/8GzzBBxQYmTM0HO5QQaJC/RvHU22B0SAls4JDae2gI0iAPIcZG48ygDoldY
        4tXxLewQtpTEy/42doj6ZkaJ18+vsEA4LYwS627vgKoylnh38znYIGYBTYn1u/QhZipLHLkF
        tZdPouPwX3aIMK9ER5sQRKOSxLyl86BBJCFxae4WKNtDYubz20wgtpBArMSWl31sExjlZyH5
        ZhaSb2Yh7F3AyLyKUSq1oDg3PTXZqMBQNy+1HB63yfm5mxjBiVrLdwfj6/V/9Q4xMnEwHmKU
        4GBWEuFN/sSVKsSbklhZlVqUH19UmpNafIjRFBjGE5mlRJPzgbkiryTe0MTSwMTMzNDcyNTA
        XEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGpvX5d7a0m8w+wX7i3c0bfQJxKVe1ll4zf7nF
        wD/HaQ1L81uWs7xCWYeFPzD+1tjRFs6Xe7bj1M3thkKvnnr++/jmk1AL+4o/xxu3hRy7pDl9
        uVPeZ4kLiQ5sB7uTkrfzX2sxjlRImzwj5nbRwdcSvHr2l3R83T4rN8koHJm+xzL2Cmt959yr
        EUtv2Fa7enHM6lnIvLJWtPe0/fdVxiYL3XLfFJyx3XfsV8Kl9wV6+WH7iuunXOlvk33QsE34
        rKp/jqr3bicWCV+lvptLlIUmh+6TS8j6Kf00m/vi1FDlj6vOfWHjDTNh+C0gMC+A/SDr7J+/
        A6779DP8O+iuudqm6kdPtWRSj9jqRSW9Xi/vK7EUZyQaajEXFScCAFZhYnBdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO7cat5Ug+lbrSzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARxWWTkpqTWZZapG+XwJVx/MIy1oI17BXvGo8xNTD+ZO1i
        5OSQEDCRWPDlPjOILSSwm1HiyuFCiLiExPINL5ggbGGJ+y1HgOq5gGp+MUpMubkQrJlNQEti
        +swGsISIwHMmiZNvTjGCOMwCr5gkev9fBxsrLGAlcWH2G7AOFgFVidWNnxhBbF4Ba4m1W96z
        QayQl9h/8CwzRFxQ4uTMJywgNjNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJda
        rlecmFtcmpeul5yfu4kRHDFaWjsY96z6oHeIkYmD8RCjBAezkghv8ieuVCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK83173pggJpCeWpGanphakFsFkmTg4pRqYnN4uCIr1rFjzUmI9r3H/YZW+
        t7MCV05Y5fBn6nS19qp9jxa63D/RNlu7XNCWm8/nW/Nt63yGH7fqWH9JWEk7Ft2Vtc7YZrAg
        9Df3zVz1t0F3zx15vs3+aodrReDr2m2H6nxfyFxZefvUyxwGpxPyqr+Wz8+9+/uAalWb77qv
        rQqSrpdd9zRZNKy+t92w5nidCLu0IFuZq3jMttq3/MwhCzete5C9VcZk+ckw95rfbz62RfzM
        t923LH75FblNv75vW3q1SO/sqjLFzVtj5rrEy59Jurz15sRHfXc+7nxfM+3bBfl2xdTstps8
        C20Yi9Yw2qefyq2yj1zNeES/cPex+lbDOZzKH7e81djz4OjSg0osxRmJhlrMRcWJAOLVAioH
        AwAA
X-CMS-MailID: 20230922113350epcas2p230c0ea8019d20f8ae8d246a5566d3a64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922113350epcas2p230c0ea8019d20f8ae8d246a5566d3a64
References: <CGME20230922113350epcas2p230c0ea8019d20f8ae8d246a5566d3a64@epcas2p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: code indent should use tabs where possible

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/core/memdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f99e7ec3cc40..7e8fca4707c0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -935,11 +935,11 @@ static void cxl_fw_cancel(struct fw_upload *fwl)
 }
 
 static const struct fw_upload_ops cxl_memdev_fw_ops = {
-        .prepare = cxl_fw_prepare,
-        .write = cxl_fw_write,
-        .poll_complete = cxl_fw_poll_complete,
-        .cancel = cxl_fw_cancel,
-        .cleanup = cxl_fw_cleanup,
+	.prepare = cxl_fw_prepare,
+	.write = cxl_fw_write,
+	.poll_complete = cxl_fw_poll_complete,
+	.cancel = cxl_fw_cancel,
+	.cleanup = cxl_fw_cleanup,
 };
 
 static void devm_cxl_remove_fw_upload(void *fwl)
-- 
2.34.1

