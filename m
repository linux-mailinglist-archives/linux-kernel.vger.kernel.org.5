Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564A17A910B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjIUCsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIUCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:48:47 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6AEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:48:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230921024834epoutp017cdd8cf9bacdf1814182fa1b5f0e4bf3~Gyhf4Kid71676416764epoutp01f
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 02:48:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230921024834epoutp017cdd8cf9bacdf1814182fa1b5f0e4bf3~Gyhf4Kid71676416764epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695264514;
        bh=rZpfn7HBf1ns47vxI/aFGjH+FW1yFBazuIf8zLmEj0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4xdTLLtsCF+JKsRyT8PHgFqprzTlLBMFfMv6RNi6NmfvKLeqP9sPNtcwjQkmWMW4
         xKl5uVJlNUQ0fiLb79pAPZVBumbta+6ZcE6s6xYk1ji61D+F8Dx3Q9Z2I3a5h5eXJB
         rFTbvncaF32yNJUwkaIkntt5kW5Jeg6pkJzS+Wlg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230921024833epcas2p2d22b84e0e67c87a97080cf8c73c3d44f~GyhfZz1X-0036500365epcas2p2E;
        Thu, 21 Sep 2023 02:48:33 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rrfwd0tsfz4x9Pv; Thu, 21 Sep
        2023 02:48:33 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.AE.09649.00FAB056; Thu, 21 Sep 2023 11:48:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230921024832epcas2p35c4d3c20f7a70b023db64cd0db823eb8~Gyhec_7AZ2864028640epcas2p3u;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230921024832epsmtrp2b7b1c2347d9a0d7191a0f82beff318b2~GyheXZkKu1783917839epsmtrp2U;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-ce-650baf0023ca
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.D7.18916.00FAB056; Thu, 21 Sep 2023 11:48:32 +0900 (KST)
Received: from jtpark-7920.dsn.sec.samsung.com (unknown [10.229.83.56]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230921024832epsmtip2b49ec7b005c2ca7b5463466a48a341de~GyheLgwbC1639116391epsmtip2O;
        Thu, 21 Sep 2023 02:48:32 +0000 (GMT)
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
Subject: [PATCH 7/7] cxl/trace: Enclose a multiple statements macro in a do
 while loop
Date:   Thu, 21 Sep 2023 11:51:10 +0900
Message-Id: <20230921025110.3717583-8-jtp.park@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921025110.3717583-1-jtp.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRz1vldeH5XqsyC7Ytyap8xABrQd0DsFlPGxZlscw5mpS2SFvlBG
        aZu+omjG16DbBAaoY0BZu2mVRDbENcAA+SiUOUTZCHUYBuicM+PDEj4SNhM3bHk4998593dO
        Tn7n3kviIhcRRGZpjYxBq9TQhIDX7gyRh4GWJxnJsTEMTf8xSqCSz2wA1daMAjQ0UUygCxMX
        ATp2YdoHldhaCLT410MecswX8dFPI7M+qOnzcQINNt/AkO1KHY6udJPounmYh1xdZwl0s/p7
        DF36bYF4XaToNE/zFaWDbh+FrXsWU9ibPiYUfZaLfEVlaxNQ1DQUKlbsm1PId7Nj1IxSxRjE
        jDZDp8rSZsbSe95MS0iLipZIw6Q7kJwWa5U5TCyduDclLDlL41mFFr+v1OR6jlKULEtHxMUY
        dLlGRqzWscZYmtGrNHq5PpxV5rC52sxwLWN8RSqRyKI8wsPZ6u8mHZi+7ek8a3sHVgSm/coA
        SUIqEpb+/XIZEJAiqgPAB+XXeBxZBrDm3HXsEbFZroIy4Lvu6B03bQw6AezvqgUc+QfAHusk
        4VURVCisrS/y8Q4CqN8x2DlXuW7BqdsYXBqaw70qf+ptOLN6n+fFPCoY2pzFfC8WUq/CqSUX
        j8vbAvv6R9b1vlQMvDYzhnGaZ+AP9XfWNbhHU9LWgHsDIDVEQsfIWYIzJ8J+69wG9odzV1v5
        HA6CKws9BGcoAXD+7s88jpQC+M1kx4ZqO1yYuOvjLQqnQmBLVwTX2Ytw8OZG8FPwpPMBnzsW
        wpPHRZyRhtavrDiHIRyztG5gBZy6P05wdVUBWDzejVcDsfmxfcyP7WP+P/g8wJtAIKNnczIZ
        VqaXPbrkDF2OHay/7tDkDnDavRg+ADASDABI4nSAMGNZwIiEKuWHHzEGXZohV8OwAyDK0/Yn
        eNCzGTrP99Aa06SROySR0dFSuSxKIqc3CX81WVQiKlNpZLIZRs8Y/vNhpG9QEfZOAYwvIxoi
        3kqqOoIig6vIveeecH2aG2A3bU8/VGHNO6gw17xgvfVnSbBFu3WmWTgBvnZvdTkq6lNPmctn
        01MDLSv6M0mpJ/LWZLvemJ9AGkFjYqpz6oNxqbBY61pceD7i3oGq9BMrcQcb+cPmmuZezNZ3
        yJ5QcJTaPehePrXlUufSZFL8fstLFdsad2525pt2znwb4mtxfrGr8GHCe+VspWPVzzSs3h0y
        F3hb0/bjkeo9/EJezh1hb4+7+kvBrfzLluDlX1TBDsu++PY1hFXXxx+OO1PgXsKTxflVg/vX
        Loc5t9Wp9t0r5LuK/RKZ86+pj9adNh0Yfa7w+NTqJv8bNI9VK6WhuIFV/gup+jVKZgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXpdhPXeqwZmXohZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wi+bF69ksPrz5x2Jx4HUDu8WZsy9ZLVYtvMZmcWTtVSaL
        xUdnMFsc3cNhcX7WKRaLy7vmsFncmnCMyWLj/XdsDkIeO2fdZfdoOfKW1WPxnpdMHptWdbJ5
        7J+7ht2jb8sqRo+ps+s9Pm+SC+CI4rJJSc3JLEst0rdL4MrYffsAU8FW/op523YwNTDe5eli
        5OSQEDCR2HetlamLkYtDSGA7o8S3T32MEAkJieUbXjBB2MIS91uOsEIU/WKUOH1sATNIgk1A
        S2L6zAawhIjAcyaJk29OMYI4zAKvmCR6/18HqxIWCJM41TaBBcRmEVCVWHy4kR3E5hWwlrjz
        8TILxAp5if0Hz4LVcwrYSJx7cQlstRBQzfJLe9kg6gUlTs58AlbPDFTfvHU28wRGgVlIUrOQ
        pBYwMq1iFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECI4traAdjMvW/9U7xMjEwXiIUYKDWUmE
        N/kTV6oQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDE2/a
        y221UXdEPlW2GvVczptYwbPukXh30faTqVxijFrnfkt3aWnv+M+6t1KWKWW22vfnCpGLHKcf
        iXijcfxjbsy1tFsBU/n/Z0TXfph4Zr67uN/Oh6GKzp/UfTcteDtVRPvS5pqJ6+14BKOFCnqK
        Wv32ej3oae3ICJN8WLbsZ4Ky9YbL3FOt537kWXx/+h/Lh/Eip6TnnQ18eIZ78vmTM4yP33PX
        TOMT3mR6nNnNcDPLF579PSv/MXj7PZQxZpQ1qa7JTFfV/cqWsOMT933d6xHH+F83ulpf641c
        YJW+IvS97f4ZsxXzfmba/EuyVd4quE+myM7t7M0iKy21SkH1zarn31XWiPmWiH94aLpWiaU4
        I9FQi7moOBEA/QCcvBwDAAA=
X-CMS-MailID: 20230921024832epcas2p35c4d3c20f7a70b023db64cd0db823eb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921024832epcas2p35c4d3c20f7a70b023db64cd0db823eb8
References: <20230921025110.3717583-1-jtp.park@samsung.com>
        <CGME20230921024832epcas2p35c4d3c20f7a70b023db64cd0db823eb8@epcas2p3.samsung.com>
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

ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
---
 drivers/cxl/core/trace.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 7aee7fb008a5..e2338773dcd6 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -199,17 +199,19 @@ TRACE_EVENT(cxl_overflow,
 	__field(u8, hdr_maint_op_class)
 
 #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
-	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
-	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
-	__entry->log = (l);							\
-	__entry->serial = (cxlmd)->cxlds->serial;				\
-	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
-	__entry->hdr_length = (hdr).length;					\
-	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
-	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
-	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
-	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
-	__entry->hdr_maint_op_class = (hdr).maint_op_class
+	do {									\
+	    __assign_str(memdev, dev_name(&(cxlmd)->dev));			\
+	    __assign_str(host, dev_name((cxlmd)->dev.parent));			\
+	    __entry->log = (l);							\
+	    __entry->serial = (cxlmd)->cxlds->serial;				\
+	    memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));		\
+	    __entry->hdr_length = (hdr).length;					\
+	    __entry->hdr_flags = get_unaligned_le24((hdr).flags);		\
+	    __entry->hdr_handle = le16_to_cpu((hdr).handle);			\
+	    __entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
+	    __entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);		\
+	    __entry->hdr_maint_op_class = (hdr).maint_op_class;			\
+	} while (0)
 
 #define CXL_EVT_TP_printk(fmt, ...) \
 	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
-- 
2.34.1

