Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFAA7696D1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGaMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjGaMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:55:04 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB0103
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:55:02 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230731125501epoutp037a356058fb568521b7ece4e8c754903f~29QKJwjpZ0659606596epoutp03Q
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:55:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230731125501epoutp037a356058fb568521b7ece4e8c754903f~29QKJwjpZ0659606596epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690808101;
        bh=eu93vIczw2e7uVoLZPyx1ldXyXlxA+VenRHpGew8cYQ=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=WMSYarM8NRIIIYT0bwJlrKKmTR824Y7jkYcZ3mqIUiuCjTHSWxHTZ5s4TBCzDv2fz
         I+034GqRx4tHrdKbrXSkKhLEsgNUFsxIEJB8ruEv2zgS+cGEl04C8Dm+eATAl+WlGa
         nIT3z7FDlloV+W8AaBLf2srmR8Q0+cswYYmXe5O8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230731125500epcas2p1498de3fa02baa044d925f0fca88a4219~29QJsh3jz2209822098epcas2p1R;
        Mon, 31 Jul 2023 12:55:00 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RDyrN2SDCz4x9Q0; Mon, 31 Jul
        2023 12:55:00 +0000 (GMT)
X-AuditID: b6c32a43-557fb7000001d7ef-b9-64c7af24bcb8
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.A1.55279.42FA7C46; Mon, 31 Jul 2023 21:55:00 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 3/4] bio-integrity: cleanup adding integrity pages to
 bip's bvec
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung Choi <j-young.choi@samsung.com>
From:   Jinyoung Choi <j-young.choi@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230731125459epcms2p177a5cc5caa7ef0a9de35689e96558f43@epcms2p1>
Date:   Mon, 31 Jul 2023 21:54:59 +0900
X-CMS-MailID: 20230731125459epcms2p177a5cc5caa7ef0a9de35689e96558f43
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTXFdl/fEUg3/f+CxW3+1ns5h1+zWL
        xctDmhaTDl1jtNh7S9vi8q45bBbLj/9jslj3+j2LA4fH+XsbWTwuny312LSqk83j49NbLB59
        W1YxenzeJOfRfqCbKYA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
        1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWle
        ul5eaomVoYGBkSlQYUJ2xpaFigW7eSq2vPBrYLzB2cXIwSEhYCLx94F2FyMXh5DADkaJntP3
        2EHivAKCEn93CHcxcnIIC4RKvLizig3EFhJQkji3ZhYjRNxAouV2GwuIzSagJ7Hj+W52kDki
        Ap+ZJC7/+MAKkpAQ4JWY0f6UBcKWlti+fCtYM6eAn8TU62+ZIOIaEj+W9TJD2KISN1e/ZYex
        3x+bzwhhi0i03jsLVSMo8eDnbqi4pMShQ1/ZIH7Jl9hwIBAiXCPR9us9VLm+xLWOjWAn8Ar4
        Slye+w3sFxYBVYkLs44wQ7S6SBzpkAEJMwvIS2x/OwcszCygKbF+lz5EhbLEkVssEBV8Eh2H
        /7LD/New8TdW9o55T5ggWtUkFjUZQYRlJL4ens8+gVFpFiKUZyFZOwth7QJG5lWMYqkFxbnp
        qclGBYbwWE3Oz93ECE6WWs47GK/M/6d3iJGJg/EQowQHs5II76mAQylCvCmJlVWpRfnxRaU5
        qcWHGE2B/p3ILCWanA9M13kl8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQx
        cXBKNTDJer00Yc2Nlk5jOrT5eMnqLye4DnVsS8ou/Kyspzn1YfKP7XWBt4IMV9m9UFiaPnWj
        /ot95lM+3p7MfKzxc761VdkDwTthz3SzfCxeJ67Nfrh+xSHN0/YRy8wUvy/47vrwR962cPWn
        Ttahsoc2vAy/dXax2NNH7wWSYncvtp4UYfjxQ5KY0GTVxoV/smM9vq1+zvhwS2znISvlNfXb
        3kz8oCv3ri+EMXKZ5455U16FaT85MNs74ZuscalZeIHkXvXr/3Z/+XKZ/Zvip8ob7q9MErRV
        //1eJj1h0Qdbi6sXnFsW3lN3jlBgVPcTb31heKdob2qV9qLnAZHZm+askFuaYycnvoxhoXCn
        1udExy8xSizFGYmGWsxFxYkAXlAquR8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5
References: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
        <CGME20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bio_integrity_add_page() returns the set length if the execution
result is successful. Otherwise, return 0.

Unnecessary if statement was removed. And when the result value was less
than the set value, it was changed to failed.

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
