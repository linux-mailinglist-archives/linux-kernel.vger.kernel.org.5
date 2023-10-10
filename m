Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8007BF5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442827AbjJJIXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442742AbjJJIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:23:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B336A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:23:33 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231010082323epoutp034c7064d93f10caf193f3fe1be34f4ed0~MsWRFJofL1875718757epoutp03Y
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231010082323epoutp034c7064d93f10caf193f3fe1be34f4ed0~MsWRFJofL1875718757epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696926203;
        bh=11JVUyHitflKTv1oP+aIUUOynGhGeOyQ35o7CuUsBKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7cjTyRa5KhqfVdqVXr06UPED+MxIVtohdmMGxdHVCFOfhOvye32P0kvEJQ3wMqSZ
         6sbH5WJzHBLfUr8Za/Ksph8tbrr3+Ycaljt6v3dmA7IYZzI3EQwBxde0CpnZmiBU8/
         sADI66VeJjHTQ+N3SMacZ6EhL6F9SGbwtbbE/W/k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231010082323epcas2p182eb59312f88c3f27933da0ce5dfb4cb~MsWQiwrVC2109721097epcas2p1J;
        Tue, 10 Oct 2023 08:23:23 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S4TSB3SF7z4x9Pw; Tue, 10 Oct
        2023 08:23:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.89.09660.AF905256; Tue, 10 Oct 2023 17:23:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epcas2p29211e29f64b7a4d0a032df5f60c6942f~MsWPQHiN01534015340epcas2p2J;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231010082321epsmtrp1cf63ce41ac83b347cd79e14b0177b525~MsWPPTGK11187111871epsmtrp1h;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-49-652509fac562
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.A1.08742.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epsmtip2fdc58e8087e562c7af62a8cfc2681615~MsWO8NYP70746607466epsmtip2E;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
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
        Jeongtae Park <jtp.park@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 6/6] cxl/memdev: Fix a whitespace error
Date:   Tue, 10 Oct 2023 17:26:08 +0900
Message-Id: <20231010082608.859137-7-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010082608.859137-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzO6W1vL2yFa8vjrCbYXcc2IK0t0HJB6rasSrNHgptZ9jJw1961
        jL7SV5x/KAMkwLRChFmKYJVMGBXICBieAwsqLGMyFUklQHBzWhAlmtTsoVnb6zb/+77f7/vO
        73HOwRD+L6gQKzHZaauJMhBoLPvcRJpC/GdMKi091JBMLv46i5IVx9oAebxxFpBTga9Q0hc4
        C8hy3yKHrGjrQcmNu0/Y5PhaGZf8aSbIITtPXUfJya45Ftl2wY2QF0Yw8rLnRzZ5degESt6o
        u8giv1++h77OVw96Frnqysl1jrptJMhS93bWoOqxlrNctauvE6gbmw+qH/amFGIfl+braUpL
        W0W0SWPWlph0SuLt94veLJIrpDKxLJfMIUQmykgrCdU7heJdJYbwKITISRkc4VAhZbMR23bk
        W80OOy3Sm212JUFbtAZLjkVio4w2h0knMdH2PJlUmikPC4tL9fOVR7mWb7B93gchdhkIoLUA
        wyCeDevaBbUgFuPjAwDO33rEZsgDAEd91VyGhAAcr51i1YKYqGMwOMdiEqMADk00cxjyN4DL
        i0dARIXi6fB4U1k0kYCvsODgqitqQfAGBNZ4+jkRlQDPg3eqppAIZuOp8O7aqWhXvHC8PpjC
        lNsCx87PRCUx+Ha4cnIdjWAevglON/3GjmAkrKnob0Yi50P8GgZdrXMcxqyCw3+cRBksgKuX
        +rgMFsLg0SouY6gAcO32NTZDKgHsXhh4qsqC9wK3OZGOEDwN9gxtY1a2FU7eeFo4DlZPPOYy
        YR6sruIzRgK2ftuKMBjCKy19CCNRw6Xfk5lluQAcdp1B64DI88w4nmfG8fxf1wuQTpBEW2xG
        HW3LtGT9d8Uas7EXRN92esEAcK9vSPyAhQE/gBhCJPBulrxE83la6sv9tNVcZHUYaJsfyMO7
        rkeEiRpz+HOY7EWy7FxptkIhy8mUS3OIZN7SoRYtH9dRdrqUpi209V8fC4sRlrG6qoZfeJy0
        M37csSn/w9iU/d3rH3R1iD8qCH13eum9S4Js5fJU6agzY21XZvfz06EDqeS5RYVG89rA+Zv+
        xKxA5cNpd+LnQYVOmAQ5Pm38E7bnrY2993fvNSNynqpfW58gHsgYbAp++rI3t4MSjkze3+zu
        OqbtSFP1HnC7r87LXX95fO3Gwz2XHSrvxetn4or7CvwK63Se1Klb2HNHaVotrovfPHtrdyi5
        4edYh+RF/A2qJSTpFc+G9i28GzOzfeXKnufWMwT15Ykn4g4bxpAtP/i9zvasdhNMmdiqX3Dl
        Ltd0x33xydLXCsdnj/JfBUc65svnGiUHg684d3Si86czCLZNT8nSEauN+gfZah7VZAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvcnp2qqwaG72hZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4Mq43tLPXjCNo2LBp28sDYw32boY
        OTkkBEwkdr68ytTFyMUhJLCbUWL+kr8sEAkJieUbXjBB2MIS91uOsEIU/WKUaN4+kRkkwSag
        JTF9ZgNYQkTgOZPEyTenGEEcZoE5zBKHO1+yg1QJC1hJvGg7AdbBIqAq8eb1QqDdHBy8QPGJ
        L+UgNshL7D94FqyEU8Ba4uH8t2DnCQGVbDvYDmbzCghKnJz5BOw6ZqD65q2zmScwCsxCkpqF
        JLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwhGlp7mDcvuqD3iFGJg7GQ4wS
        HMxKIryPMlVShXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBK
        NTDFfdZMjTl8S3LbS9c5vQfndVa0zvr8UfmP+f3Et2/D70d8qWtf8vDOwbqbn3zzth+f9ejx
        z5CuDLcVJSrTjqfMOPqq18T4TFJnruDNr19Xi9lplbUmry6Ulj5pXni6LljgyLmPU1dVr3zy
        9NH3c0eOil9g1WPTTnfjFevwXN08b/qRZ2sucp7nZ1q5kv3f0RPcp29wrj00J+DT2svVVw2c
        wo+GKnDERv8W9T3gI+W3sGlForpw4cU0xhXW4VfC/FmPs91pPe21pGTFjOfzVRw63VRn3VA+
        dfuX8IOWPZwlzzas/X1uyfRZdeyL98xxebGfbynzo5IJi3Y1b+qODzeZtvye+8oCnQvKqU3b
        OnXZ9imxFGckGmoxFxUnAgDISiMPHwMAAA==
X-CMS-MailID: 20231010082321epcas2p29211e29f64b7a4d0a032df5f60c6942f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010082321epcas2p29211e29f64b7a4d0a032df5f60c6942f
References: <20231010082608.859137-1-jtp.park@samsung.com>
        <CGME20231010082321epcas2p29211e29f64b7a4d0a032df5f60c6942f@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: code indent should use tabs where possible

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

