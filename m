Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16DE76DE8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjHCCvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHCCvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:51:04 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC5C103
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:51:03 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230803025101epoutp01595a198f93395b673df99144dd11255d~3v8qWqkAA3015830158epoutp01d
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:51:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230803025101epoutp01595a198f93395b673df99144dd11255d~3v8qWqkAA3015830158epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691031061;
        bh=GgZEpQKj5vGYyF34El8cqciXDkasij1/6nECeUJEU8w=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=lG6g6KM0H5iTchjUnUVs4vAwUs7AdYdVHA6MXcQIoLxuL0M0ohLrDzbfWaQDPDG24
         kcWdRIcNUD6+QPWMP1vdobBe6DeqFLhQpZcuiANsjJoJOAIFZ07RnXI/rzR6+g+tfB
         EvGFEcJzUsepMh0i280gVPDV8qUUTm91ugpl7kvs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230803025100epcas2p19ca34ccc42f2fccb928a183efe4589de~3v8opgKQX1952119521epcas2p1D;
        Thu,  3 Aug 2023 02:51:00 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RGYJ33WbNz4x9Ps; Thu,  3 Aug
        2023 02:50:59 +0000 (GMT)
X-AuditID: b6c32a4d-637c170000047356-e5-64cb1613582c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.EA.29526.3161BC46; Thu,  3 Aug 2023 11:50:59 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 3/4] bio-integrity: cleanup adding integrity pages to
 bip's bvec.
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230803025058epcms2p5a4d0db5da2ad967668932d463661c633@epcms2p5>
Date:   Thu, 03 Aug 2023 11:50:58 +0900
X-CMS-MailID: 20230803025058epcms2p5a4d0db5da2ad967668932d463661c633
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmha6w2OkUg/dPxS1W3+1ns5h1+zWL
        xctDmhanJyxisph06Bqjxd5b2haXd81hs1h+/B+TxbrX71kcOD3O39vI4rF5hZbH5bOlHptW
        dbJ5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
        GlpamCsp5CXmptoqufgE6Lpl5gDdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkp
        MC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpi0/w1TwSKeiqmzjzI3MB7m7GLk5JAQMJHYvGsK
        O4gtJLCHUeLfX7MuRg4OXgFBib87hEHCwgJhEov//2GGKFGSOLdmFiNE3ECi5XYbC4jNJqAn
        seP5bqAxXBwiAnOYJS6tWcYKMZ9XYkb7UxYIW1pi+/KtYM2cAn4Sl6bNhoprSPxY1ssMYYtK
        3Fz9lh3Gfn9sPiOELSLReu8sVI2gxIOfu6HikhKHDn1lA7lZQiBfYsOBQIhwjUTbr/dQ5foS
        1zo2gq3iFfCVmLZ7OxuIzSKgKrFw5kQWiFYXiaer80HCzALyEtvfzmEGCTMLaEqs36UPUaEs
        ceQWC0QFn0TH4b/sMP81bPyNlb1j3hMmiFY1iUVNRhBhGYmvh+ezT2BUmoUI5VlI1s5CWLuA
        kXkVo1RqQXFuemqyUYGhbl5qOTxuk/NzNzGCU6mW7w7G1+v/6h1iZOJgPMQowcGsJMIr/ft4
        ihBvSmJlVWpRfnxRaU5q8SFGU6CfJzJLiSbnA5N5Xkm8oYmlgYmZmaG5kamBuZI4773WuSlC
        AumJJanZqakFqUUwfUwcnFINTDrXX2/ZyO3zTGPD+8Ygaa5gp+5TyrIzf0t8mNduffp8gcjf
        6UFium1za/w1Hl7Iedz4d8M21sIG02tP7nls7b1141jFS5mp788fZhDYt45VqT3s155HjEb9
        5/kWSvovNRFZdCHk4+apwT/CXjJZmcRM3VlvWReRvpiHa7ZvjrNviGOBc73HSzXNph7fnqcd
        dUa7GjRM76/Zt/ZVtM8J7vtP/IUOfNKNnLQihS+E5/G8vSuWXWLYcGeqYHeY4hnhfQya5pMa
        Nmz4vmHaHc/LQo0uSxlebFv0X8J53b75HJ56blqWgSyVke+Fd5yzeD6Jt+Y/n5DUj/Cny454
        8YTxKPqeun/XTe5evFjzbCZXCyWW4oxEQy3mouJEAD1waQUuBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524
References: <20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p4>
        <CGME20230803024656epcms2p4da6defb8e1e9b050fe2fbd52cb2e9524@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio_integrity_add_page() returns the add length if successful, else 0,
just as bio_add_page.  Simply check return value checking in
bio_integrity_prep to not deal with a > 0 but < len case that can't
happen.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 block/bio-integrity.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6220a99977a4..c6b3bc86e1f9 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -252,27 +252,18 @@ bool bio_integrity_prep(struct bio *bio)
 
 	/* Map it */
 	offset = offset_in_page(buf);
-	for (i = 0 ; i < nr_pages ; i++) {
-		int ret;
+	for (i = 0; i < nr_pages && len > 0; i++) {
 		bytes = PAGE_SIZE - offset;
 
-		if (len <= 0)
-			break;
-
 		if (bytes > len)
 			bytes = len;
 
-		ret = bio_integrity_add_page(bio, virt_to_page(buf),
-					     bytes, offset);
-
-		if (ret == 0) {
+		if (bio_integrity_add_page(bio, virt_to_page(buf),
+					   bytes, offset) < bytes) {
 			printk(KERN_ERR "could not attach integrity payload\n");
 			goto err_end_io;
 		}
 
-		if (ret < bytes)
-			break;
-
 		buf += bytes;
 		len -= bytes;
 		offset = 0;
@@ -291,7 +282,6 @@ bool bio_integrity_prep(struct bio *bio)
 	bio->bi_status = BLK_STS_RESOURCE;
 	bio_endio(bio);
 	return false;
-
 }
 EXPORT_SYMBOL(bio_integrity_prep);
 
-- 
2.34.1
