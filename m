Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED27A910E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIUCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIUCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:48 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F17F0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:36 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230921024834epoutp0389ff5dd7a4ce9587df788efb95d9f6a9~GyhgcLn_i0702607026epoutp03N
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230921024834epoutp0389ff5dd7a4ce9587df788efb95d9f6a9~GyhgcLn_i0702607026epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264514;
        bh=KmG4QbAqci7Vhz1LB8iYJDLiqlnNyIXTPBwsLXKrGy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKztScs7SPzulyj4QmbqrFC0rqaxP0wfQHbW+t7X1EdQ8bN2WICdI3vVDEbdvR/55
         4Efuj0dZ7GrLhWeIP8LU1N38zAqJXmjDmf7FPvuKIA8jH/ZUfKzVvoR5Z1QuN5HV3v
         xzdfebxZUJa4wZp9Le+QMxFnlHB4Sw4kODvPG9N8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230921024833epcas2p2ad590b1433f821543f2bb9e37233b932~GyhfLei2r0273502735epcas2p2f;
        Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rrfwc5G0Xz4x9Q2; Thu, 21 Sep
        2023 02:48:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.B4.09660.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230921024832epcas2p450ca98aebdcdd0124be9ad5c2ff22b13~GyheBVbOM0279002790epcas2p4G;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epsmtrp2b39a58f73aea53c7b9716d78eb6776f4~GyheANMZn1801818018epsmtrp2C;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-7d-650baf0091f3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.53.08649.FFEAB056; Thu, 21 Sep 2023 11:48:31 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024831epsmtip26edec8385ac36fdede8946d4af5d5f5a~GyhdsRkE91641616416epsmtip24;
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
Subject: [PATCH 3/7] cxl/mem: Fix a checkpatch error
Date:   Thu, 21 Sep 2023 11:51:06 +0900
Message-Id: <20230921025110.3717583-4-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025110.3717583-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmuS7Deu5Ug+PT1CzuPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE7Y/fmL0wFM1krVk3dz9zAuIGli5GTQ0LAROLhrpuMXYxc
        HEICOxgl1v6aywzhfGKU6O48BZX5xigxZcskJpiWjiMXWCASexkl9sxqYwZJCAn8YZQ41qYF
        YrMJaElMn9nAClIkIvCQSWLnqz4mEIdZ4BGTxMcTr8A6hIFG7fuzDMxmEVCVmHXzByuIzStg
        LfG7bQIbxDp5if0Hz4LVcArYSJx7cYkJokZQ4uTMJ2BfMAPVNG+dDXa4hMAZDonu1WcZIZpd
        JM7caYS6W1ji1fEt7BC2lMTnd3vZIBqaGSVeP7/CAuG0MEqsu70DqspY4t3N50AncQCt0JRY
        v0sfxJQQUJY4cgtqMZ9Ex+G/7BBhXomONiGIRiWJeUvnMUPYEhKX5m5hhijxkGiY7QQJuX5G
        iXPbXzFPYFSYheSdWUjemYWwdwEj8ypGsdSC4tz01GKjAmN4HCfn525iBCduLfcdjDPeftA7
        xMjEwXiIUYKDWUmEN/kTV6oQb0piZVVqUX58UWlOavEhRlNgYE9klhJNzgfmjrySeEMTSwMT
        MzNDcyNTA3Mlcd57rXNThATSE0tSs1NTC1KLYPqYODilGphcl59sMVu1u/M19/di5rfL9/D7
        bl9g6ZpV2vQ75+bstV5fw/Yc0bvVO+22y8GGG9v3cHBb1eX+OL+C9/KB0z98H9xb1G8ovEZq
        5cdjRUozLep8wlo0nrwx3Gozfw+nekKvyAkJ1g/d0ZUn6o552T0+zvHnSvxRx8Rvr7ekZ5Vv
        O8bZ7ijwwUfWe2nh0ph3M7dGflNbu940y85VX2rRrLeMasv2ztulz3cq3+Ib+xFFRe285Zaz
        a1J3bTgU8SHxYtmmKhH/z8qyM24n3nkdyDyz+d+ndQLOM7ZpvVpyuHumxolLnjzP3pQ8v3t0
        qXpWfdbKgFP1Xj/S9s+x7zhULWK2enLZWhbbOU1dmy5fu3T6ixJLcUaioRZzUXEiAMbIFVpl
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJXvf/Ou5UgzMHTC3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARxWWTkpqTWZZapG+XwJWxe/MXpoKZrBWrpu5nbmDcwNLF
        yMkhIWAi0XHkApDNxSEksJtR4umsi4wQCQmJ5RteMEHYwhL3W46wQhT9YpR4e+UwO0iCTUBL
        YvrMBrCEiMBzJomTb04xgjjMAq+YJHr/X2cGqRIG2rHvzzIwm0VAVWLWzR+sIDavgLXE77YJ
        bBAr5CX2HzwLVsMpYCNx7sUlsNVCQDXLL+1lg6gXlDg58wnY3cxA9c1bZzNPYBSYhSQ1C0lq
        ASPTKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4BjT0tjBeG/+P71DjEwcjIcYJTiY
        lUR4kz9xpQrxpiRWVqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXA
        VFzweOps9xnXDvhbtagy3JTcsNp9y8KWNbLPAtRm3UuQuZMT4h6k5/vgSWA1U+qKmv/B3PWT
        rkzRcHZnXqcitned2QR5qyssty7aPTyX/0zg2gqT29sLLGPVey/KqtlN+vnGrnP7df23Ex+8
        ehe2Zpt/+AOZusO3FLb/33fc+OLbnbyF5xMbMj425uxe+bL3mBgbt0aDhmZE3uT3O3OW8ytL
        8V0qKzWrOzL5j9gyq/Cd/OkajMyuiW6c2eJrkyPu33dmKq4Wyud9F766QeiD7k+d+rdcM0QD
        GR/+uGCY8fI7o85MZ1e5pu+sGRO85S4/nPD52s/1MwwbhdP+N+4XfiPh3/s2/PRjz7wJm9ex
        KrEUZyQaajEXFScCAEwgCKkgAwAA
X-CMS-MailID: 20230921024832epcas2p450ca98aebdcdd0124be9ad5c2ff22b13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024832epcas2p450ca98aebdcdd0124be9ad5c2ff22b13
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024832epcas2p450ca98aebdcdd0124be9ad5c2ff22b13@epcas2p4.samsung.com>
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

ERROR: spaces required around that '=' (ctx:WxV)

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..1ac3eb2be84f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -183,7 +183,7 @@ struct cxl_mbox_cmd_rc {
 };
 
 static const
-struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
+struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = { CMD_CMD_RC_TABLE };
 #undef C
 
 static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
-- 
2.34.1

