Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF17BF59C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442748AbjJJIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379441AbjJJIXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:23:31 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41427AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:23:27 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231010082323epoutp02dca50ae543073d5c07bc9368c3702820~MsWQrRv6P3142831428epoutp02-
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231010082323epoutp02dca50ae543073d5c07bc9368c3702820~MsWQrRv6P3142831428epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696926203;
        bh=dGxmS/KBK2vjw8fTdA2H0+jeYD6Sf29f/JkO+nkrNVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ady6suh7BufvLKcV504NC7A/MtX98IDx3QBMBRPEbe75JS0CGiVHfEkD5Bv2vrZIi
         vlNq9Mu7QsEIPXDvvYI+wP5iuiseI+HMn5GoK5HjN3k7grNXtAuf5Hycl3jgrrNhLJ
         bxGg2LbZqLBDIBH/j7erwnKBOdTNWOgv3v96XSF8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231010082322epcas2p447808e5a68048400b86aa4e4faa4f612~MsWQHs-vr2036320363epcas2p4z;
        Tue, 10 Oct 2023 08:23:22 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4S4TSB0Zzpz4x9Ps; Tue, 10 Oct
        2023 08:23:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.89.09660.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epcas2p26c6ba3f7298bd8266c59761e080cc732~MsWO_a4vF1534015340epcas2p2I;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231010082321epsmtrp1680899064e1f9b09931b9db5b1cb321b~MsWO9b6Vk1187111871epsmtrp1f;
        Tue, 10 Oct 2023 08:23:21 +0000 (GMT)
X-AuditID: b6c32a47-d5dfa700000025bc-48-652509f95ad5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.CE.08649.9F905256; Tue, 10 Oct 2023 17:23:21 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231010082321epsmtip260c297943c46c2fdac318e82b27cf022~MsWOrFWFy0746607466epsmtip2D;
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
Subject: [PATCH v3 4/6] cxl: Fix a checkpatch error
Date:   Tue, 10 Oct 2023 17:26:06 +0900
Message-Id: <20231010082608.859137-5-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010082608.859137-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmme5PTtVUg8XnrC3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFs2L17NZfHjzj8XiwOsGdoszZ1+yWqxaeI3N4sjaq0wW
        i4/OYLY4uofD4vysUywWl3fNYbO4NeEYk8XG++/YHIQ8ds66y+7RcuQtq8fiPS+ZPDat6mTz
        2D93DbtH35ZVjB5TZ9d7fN4kF8ARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/SKkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE74+2lnYwFi9grzrVtZmpgnMvWxcjJISFgIrFs3n3WLkYu
        DiGBHYwST/93sUE4nxgltrYdYYdwvjFKPJu0Ha7l/I9VUIm9jBIz5jcwQzh/GCWuP+1lB6li
        E9CSmD6zAWywiMBDJomdr/qYQBxmgSnMEp2ztgJlODiEBYwlZl42BWlgEVCVaJ11EmwFr4CV
        xJlfXYwQ6+Ql9h88ywxicwpYSzyc/xaqRlDi5MwnLCA2M1BN89bZYFdICFzgkDjcOIkFotlF
        4v6MF1C2sMSr41vYIWwpiZf9bewQDc2MEq+fX2GBcFoYJdbd3gFVZSzx7uZzsEuZBTQl1u/S
        BzElBJQljtyCWswn0XH4LztEmFeio00IolFJYt7SecwQtoTEpblboGwPiaZtF6FB18co0T9h
        MesERoVZSP6ZheSfWQiLFzAyr2IUSy0ozk1PLTYqMIZHcnJ+7iZGcOrWct/BOOPtB71DjEwc
        jIcYJTiYlUR4H2WqpArxpiRWVqUW5ccXleakFh9iNAWG9kRmKdHkfGD2yCuJNzSxNDAxMzM0
        NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1Oqgcl1mcDl/YeK3wp1RtnrV9yR6M294/9/
        5qdpkZcv3/1m3nuqZ4G99rrKlsxyT6vv7WxOJp1ixtNLtjfHNHOKnEz6Ics6Y/eyB8HuB6NV
        l9SHzWSRis/MuNraUqtyYDvvmbqVi381Ba+rq9g3s3CJVpetM2va2QmXLxxfMatS6alUVsjV
        vsAAm9/tpku9TSu+JdkIp2v8PZajFWvxK/nk6cizbScO163iF43aU+m7vCfmZNrtrwfeHr+2
        bfV0+QAm4xzW56cfhK7X7+1L9soUMOH5y6V+1fdEm/vmm7s2vYmwL5rs+cmI98DEW4q/bATO
        zxftLMtTPDEneP2SA5ejdvLF2vvfSf1R/PT1or6cGiWW4oxEQy3mouJEAFQgKjpmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvcnp2qqwZpOKYu7jy+wWTRPXsxo
        MX3qBUaLEzcb2SxW31zDaNG0+i6rRfPi9WwWH978Y7E48LqB3eLM2ZesFqsWXmOzOLL2KpPF
        4qMzmC2O7uGwOD/rFIvF5V1z2CxuTTjGZLHx/js2ByGPnbPusnu0HHnL6rF4z0smj02rOtk8
        9s9dw+7Rt2UVo8fU2fUenzfJBXBEcdmkpOZklqUW6dslcGW8vbSTsWARe8W5ts1MDYxz2boY
        OTkkBEwkzv9Yxd7FyMUhJLCbUWLb9CaohITE8g0vmCBsYYn7LUdYIYp+MUpsWbqcBSTBJqAl
        MX1mA1hCROA5k8TJN6cYQRxmgTnMEoc7XwLN5eAQFjCWmHnZFKSBRUBVonXWSbANvAJWEmd+
        dTFCbJCX2H/wLDOIzSlgLfFw/luwGiGgmm0H26HqBSVOznwCtpgZqL5562zmCYwCs5CkZiFJ
        LWBkWsUomVpQnJuem2xYYJiXWq5XnJhbXJqXrpecn7uJERxhWho7GO/N/6d3iJGJg/EQowQH
        s5II76NMlVQh3pTEyqrUovz4otKc1OJDjNIcLErivIYzZqcICaQnlqRmp6YWpBbBZJk4OKUa
        mM5+/Ky77VbZleiIAm23UxO/b3JsXrbuhWx6o/bMz0EvPoVEn1hl1Ogd5HuiYHdq/UcT5i07
        3bueGpQ+DhXsKxHMnqJcsN7sxoxNP2PPrF7w2NN1dfoD7dO9N12kw5Pvh85MYJ7/aHuVUDZ3
        2zlL5trXa68EMfBZfLBurvjvwvX7g7fYi+xYVWG7Fcz3D/TzNteen1JhOXtv98KM6cFL10xS
        aXm1f7/o1p4TaUqq6w/pXG+7s+fWjVNmons3NLz8Y/JkttGcJzxarHM/Wysr3TLkD8xaOvPR
        mf+bO+rbs/azXl/j9U/BNCNo0mrLz1dVz4T3XjOOnW1fWccov8vlmll0zPxqhgmyJxO2a/Bk
        SiqxFGckGmoxFxUnAgD8pVrAHwMAAA==
X-CMS-MailID: 20231010082321epcas2p26c6ba3f7298bd8266c59761e080cc732
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010082321epcas2p26c6ba3f7298bd8266c59761e080cc732
References: <20231010082608.859137-1-jtp.park@samsung.com>
        <CGME20231010082321epcas2p26c6ba3f7298bd8266c59761e080cc732@epcas2p2.samsung.com>
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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

