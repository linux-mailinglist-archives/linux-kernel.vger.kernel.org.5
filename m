Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6E7D3C02
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjJWQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjJWQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:16:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08B83;
        Mon, 23 Oct 2023 09:16:33 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NG7XNS005940;
        Mon, 23 Oct 2023 16:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=HYhIWQZRtySHe65hgdMZB+6jetyQECJ8Q0baz/wx1Aw=;
 b=hZGxfnyE7dhtjyh7ALdC85stxl5f1fdgx4OnVk1ciXzl9v/CZUQbf50JoVjehizZEz0y
 GXnghxhRe2xsJJDNvkRTq0+M1OrhLafkZb6IVO792SeKPh6AYpoZYAacVT3EKQRnFqzu
 5cQbgqslpq12vtLgmi0qhRFwD7loR+bGw0iqyvoZ+D+fbwnsTeXvY/aTFCYcH1mD3MOu
 UR3A29kHUhHPJIcCnnsAP9v4rQC8gQ3/sfSHWmn9Qqt+j3KaOnt95u/4hog1lV5NUz0a
 4VI9sdgHiTneBTx9Q9kY4zIbJJsEEgaZGLhsrWUd6BJZ2HozcdBBEDdkhiiSDCouU77J MA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twv2ur4gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 16:16:04 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFjeXT010305;
        Mon, 23 Oct 2023 16:12:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsby9uct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 16:12:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39NGBuOn58130778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 16:11:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF9E920040;
        Mon, 23 Oct 2023 16:11:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 653432004B;
        Mon, 23 Oct 2023 16:11:56 +0000 (GMT)
Received: from localhost (unknown [9.171.43.41])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Oct 2023 16:11:56 +0000 (GMT)
Date:   Mon, 23 Oct 2023 18:11:54 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/pci: remove custom and misleading bitmap_vzalloc
Message-ID: <your-ad-here.call-01698077514-ext-9164@work.hours>
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
 <CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com>
 <your-ad-here.call-01698077344-ext-9104@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01698077344-ext-9104@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3GcQSxFYYbJO4COea2FdgeR0-W-kLcvx
X-Proofpoint-ORIG-GUID: 3GcQSxFYYbJO4COea2FdgeR0-W-kLcvx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=820 spamscore=0 phishscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit effectively reverts commit c1ae1c59c8c6 ("s390/pci: fix
iommu bitmap allocation") and applies a simpler fix instead. Commit
c1ae1c59c8c6 introduced a custom bitmap_vzalloc() function that included
unnecessary and misleading overflow handling.

This fix is only relevant for the current v6.6 and stable backports. It
will be superseded by the upcoming conversion to use the common
code DMA API on s390 (pending in linux-next [2]), which eliminates
arch/s390/pci/pci_dma.c entirely and, therefore, addresses the original
problem in another way.

Instead of relying on a custom bitmap_vzalloc() function, this change goes
back to straightforward allocation using vzalloc() with the appropriate
size calculated using the BITS_TO_LONGS() macro.

Link: https://lore.kernel.org/all/CAHk-=wgTUz1bdY6zvsN4ED0arCLE8Sb==1GH8d0sjm5bu7zesQ@mail.gmail.com/
Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20231020&id=c76c067e488c
Cc: stable@vger.kernel.org
Fixes: c1ae1c59c8c6 ("s390/pci: fix iommu bitmap allocation")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/pci/pci_dma.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 99209085c75b..1b4b123d79aa 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -565,17 +565,6 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	}
 }
 
-static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
-{
-	size_t n = BITS_TO_LONGS(bits);
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
-		return NULL;
-
-	return vzalloc(bytes);
-}
-	
 int zpci_dma_init_device(struct zpci_dev *zdev)
 {
 	u8 status;
@@ -615,13 +604,15 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 				zdev->end_dma - zdev->start_dma + 1);
 	zdev->end_dma = zdev->start_dma + zdev->iommu_size - 1;
 	zdev->iommu_pages = zdev->iommu_size >> PAGE_SHIFT;
-	zdev->iommu_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
+	zdev->iommu_bitmap = vzalloc(BITS_TO_LONGS(zdev->iommu_pages) *
+				     sizeof(unsigned long));
 	if (!zdev->iommu_bitmap) {
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
 	if (!s390_iommu_strict) {
-		zdev->lazy_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
+		zdev->lazy_bitmap = vzalloc(BITS_TO_LONGS(zdev->iommu_pages) *
+					    sizeof(unsigned long));
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
 			goto free_bitmap;
-- 
2.39.2

