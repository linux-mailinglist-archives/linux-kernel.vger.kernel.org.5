Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0C7BF5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442778AbjJJIXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442721AbjJJIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:23:32 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A588B8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:23:27 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231010082322epoutp046c80cd4b64623011f40f8eb78a242fc7~MsWQO4bEJ1482914829epoutp04O
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231010082322epoutp046c80cd4b64623011f40f8eb78a242fc7~MsWQO4bEJ1482914829epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696926202;
        bh=zLkZnc/pcWjXJ3bYQCnWrW8f1xlPgc4UXyOfQUTHZm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxGpkfEVOYCzYy0s2+6bnKnjtuRgapniJAtuZKyqZksQJmN4bmLyCf38Axglyi8Kq
         N+qCDjewICvrqHtNUoOgWSzyD3NCBvdrizUBMLgT6MZe4OS/Xc7eZNrta5qRJftBGu
         4QpEOr1FkuAp4yGewea65JyD+hYcRBGzWXRvOtxo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231010082322epcas2p3363586dfc249b9749a35bfab71250c43~MsWPkI9oY2472824728epcas2p3W;
        Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4S4TS94b4Zz4x9QB; Tue, 10 Oct
        2023 08:23:21 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.6E.19471.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epcas2p39eb70352eb4e1febe51f9aa56681002e~MsWOnGAFZ1247212472epcas2p34;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231010082321epsmtrp28abcd014eb947b538066b5a0bf9f5ae1~MsWOk8da82242122421epsmtrp2X;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-72-652509f9737a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.CE.08649.8F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082320epsmtip2fbc1e9637b7c24390ef9eb58cc974181~MsWOTTYNX0746607466epsmtip2C;
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
        Jeongtae Park <jtp.park@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 1/6] cxl/trace: Fix improper SPDX comment style for
 header file
Date:   Tue, 10 Oct 2023 17:26:03 +0900
Message-Id: <20231010082608.859137-2-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010082608.859137-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwbdRjO7669HlsgR0H5pXGunkMDCrRI22N8qFkjTZyGzEnUbIMTLrSj
        X/aKG8O4akEBk0p1DOlotwk61jEQ1iFMGpBvJ0QydBkoYx3MCRSGg5mQAbOlne6/53nf58n7
        Pr8PHOVfxQS4SmtkDFpaTWJbOG29MVTcakg0I/LeIanJ6VGMMn9ZB6jqqlFADY1/hFHnxhsB
        9fG5SS5lrmvGqCXvBofqnjfxqOGRWS7lPH0Vo/rO/4ZQdf1foVR/J079YrvMocYu1WLUROUA
        QrVMLWIv8RUdtkmeoqRvgauo65xFFK3OckzRZW/kKSwuJ1BUnTiqWG59MhN/pyBVydB5jEHI
        aHN1eSptfhr56hvZu7IlUpE4TpxMyUihltYwaaR8d2bcKyq1LwopfJ9WF/pKmTTLkgnpqQZd
        oZERKnWsMY1k9HlqvUwfz9IatlCbH69ljDvFIlGixCfMKVD2P+jm6qe5hxd6BhETWOFUgBAc
        Ekmwa67Uh7fgfKITwMpGGxYgdwE8f2EtSP4B0P6gnfvQMlN3J2hxA7g6VIYGyBqA3dfvb6ow
        IhZW15i4/kYk4UFgx5wF8ROUOIbCcttFXwfHI4i9cMpp9EMOEQ2bymm/N5TYCUtdU7zAtO2w
        68cR1I9DiBToObmABTTh8Keamc0QqE9jvnhicwlIjOJwqfly0CyHcx1twbUj4NygK1gXwOVF
        NxYwmAGcv/0rJ0BKAGz6vT2oegEujt/eXBQlYmDzpQQ/hMTTsG8iODgMlvWu8wLlUFj2CT9g
        JKHjGwcawBBesbuCWAFXvqsNHqkFwJKhK2glENoeyWN7JI/t/8GnAOoEAkbPavKZ3ES9OE7L
        HPrvnnN1mlaw+cBjX2sH883r8T0AwUEPgDhKRobeVO1g+KF5dNERxqDLNhSqGbYHSHwHbkUF
        j+XqfD9Ea8wWJyWLkqRSsSxRIpKRUaHXS+15fCKfNjIFDKNnDA99CB4iMCFKe6nsh1O4J301
        K3LoYIozp2H9oF7+7BN7Di3Vl30xQX8tIcMm9FtjlXvoA1bv5xsC95ljUkGVzHqk3XRfVyJx
        HNU0XJtxjcjDi6Uvz/7dcvaecW/O/rUwcuNdz/J7365l3djPRh3Y9/hMRsqQwh1pFuueO1t8
        ARl2iW86/pyzSdyZY7v4TSLhGWPUz97cfRnDp731td9LniKK0mc11RXKtxLijrf0Jt7YIWC3
        D7ZwO6IjB6zIykRWUesfHyan8tQhpqKx3Xc1Fumb0y9WNFi3FbuvvR6e+unbz6tisq2fncw4
        7Gn1LlUPWJ6pPy7YJueYVyZvOT6oYWbvbW2I6G279RfJYZW0OBY1sPS/O1vluGkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvcnp2qqwdk2Jou7jy+wWTRPXsxo
        MX3qBUaLEzcb2SxW31zDaNG0+i6rRfPi9WwWH978Y7E48LqB3eLM2ZesFqsWXmOzOLL2KpPF
        4qMzmC2O7uGwOD/rFIvF5V1z2CxuTTjGZLHx/js2ByGPnbPusnu0HHnL6rF4z0smj02rOtk8
        9s9dw+7Rt2UVo8fU2fUenzfJBXBEcdmkpOZklqUW6dslcGUc/X+AteAxa8XbQ8eZGhi/sHQx
        cnJICJhIPFn8Hsjm4hAS2M0osWraD0aIhITE8g0vmCBsYYn7LUdYIYp+MUos+nUQLMEmoCUx
        fWYDWEJE4DmTxMk3pxhBHGaBOcwShztfsoNUCQsESXR0XQayOThYBFQl1nUmgoR5BawkWrfc
        Z4fYIC+x/+BZZhCbU8Ba4uH8t2wgthBQzbaD7WwQ9YISJ2c+ATubGai+eets5gmMArOQpGYh
        SS1gZFrFKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREcYVoaOxjvzf+nd4iRiYPxEKME
        B7OSCO+jTJVUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODil
        GpgCds3JVpvysyzzYBdHg85Fm+YGU9Wf+ovFtlbO/LJkaTxL3iSBLVcYShLtmdJWMNy90DVd
        vyxvqVhanrH53O/LvdKXbL+eKus2y0q97cN5Zodd3ueYZ2y9r+sjLXXBXnTHxuf/Zu3scODc
        xdXLcODrEvcYXivefYuv32w1K/ghGTg9dr2nEpfWct7jTQxZ2x6f6ly1QOh+iWvBfpOGV9qT
        p1vf+VVz8OH2i86yhdcWV03++eLg+dYdE8PtFl1bkSrqaXF/9fOQVKlnW+qTOpeyhRROE7j3
        MZ7rLM9R9WW3+pfuntictmfe6jWnTQ4f2/tNbMuU7jnxE2urzkpufrdVMumBfF7d9vv/D9yQ
        t3gZoMRSnJFoqMVcVJwIAINPXRkfAwAA
X-CMS-MailID: 20231010082321epcas2p39eb70352eb4e1febe51f9aa56681002e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010082321epcas2p39eb70352eb4e1febe51f9aa56681002e
References: <20231010082608.859137-1-jtp.park@samsung.com>
        <CGME20231010082321epcas2p39eb70352eb4e1febe51f9aa56681002e@epcas2p3.samsung.com>
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

The SPDX license identifier for C header have to be added
in form of a C-like comment.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/core/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..7aee7fb008a5 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cxl
-- 
2.34.1

