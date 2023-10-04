Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5CE7B7ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbjJDI4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbjJDI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:56:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF03A7;
        Wed,  4 Oct 2023 01:56:33 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948k4Mj013396;
        Wed, 4 Oct 2023 08:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=Obkl1GMWxBS6IO9KRTWJRxho2HtrWuWdgU6R2ARUbfU=;
 b=oqdOCAmRPtiKIe+KvRpnAD51ZhvDemhBQ9X26sGgR37XaGFAj3gnFGwoC5YvEMaBlHg0
 Ok7fRog73EmhTx7E2+IG5gqY8aClbdVXKgIS/PcUMRERSMGOkYQf2/7zWog5b1mNa7eG
 CfdaOFa1JBiFsQ4I0nYpO6mvRvT/1VzXl84ndnDxDMJXZTRF034roIqqWZ2PHPeKORF8
 r8/K+KH1kZdYQXcRvD3USptOM+eEWMw0A86ffaKI90Dgk2epWU4FmYFv/NxR4MwkVO38
 4H4vyK0YOYxfEqJt81+n3gMfg/bR1m1S34Hnd4d8pG7CLm1oBC4rCpbUvMCsZk+vd/bS Wg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th4a0924d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 08:56:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3948NGAG005869;
        Wed, 4 Oct 2023 08:56:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tex0stg3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 08:56:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3948uNZG40173984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 08:56:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 267932004D;
        Wed,  4 Oct 2023 08:56:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8C2E20043;
        Wed,  4 Oct 2023 08:56:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 08:56:22 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Wed, 04 Oct 2023 10:56:12 +0200
Subject: [PATCH] s390/pci: Fix reset of IOMMU software counters
Content-Type: text/plain; charset="utf-8"
Message-Id: <20231004-dma_iommu_fix-v1-1-129777cd8232@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAKsoHWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwMj3ZTcxPjM/Nzc0vi0zApdg0RTY0tzS0ujNENTJaCegqJUoDDYvOj
 Y2loA9OLeo18AAAA=
To:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2844;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=H90IBelQNG7rhfTWySXD+NU46UuE+9PSGFOR8fcgG4U=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJlNTasnrGecZ+I1t/be2uWcmlInPjbetvrYf6ENf8nf
 qjc++QYS0cpC4MYB4OsmCLLoi5nv3UFU0z3BPV3wMxhZQIZwsDFKQATebac4Z/qln2OF1ft925s
 cX0otWzXlkxR0ejqW/3lM2bXvYv5HPGCkaFLM6F+KkfS+fvPGjdfniX6bodmrkOihtnOrjiLtQn
 2qmwA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9-TEznx7mp5zg37bZc5FgD7uyTqWdBNH
X-Proofpoint-GUID: 9-TEznx7mp5zg37bZc5FgD7uyTqWdBNH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=718
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Together with enabling the Function Measurement Block
zpci_fmb_enable_device() also resets the software counters. This allows
to use "echo 0 > /sys/kernel/debug/pci/<dev>/statistics" followed by
echo "1 > /../statistics" to reset all counters. In commit c76c067e488c
("s390/pci: Use dma-iommu layer") this use of the now obsolete counters
in struct zpci_device was missed as was their removal. Fix this by
resetting the new counters and removing the old ones.

Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: This is based on and references commit IDs from Joerg Roedel's
iommu/next branch and should go in via the iommu tree.
---
 arch/s390/include/asm/pci.h |  4 ----
 arch/s390/pci/pci.c         | 13 ++++++++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 3f74f1cf37df..e91cd6bbc330 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -173,10 +173,6 @@ struct zpci_dev {
 	struct zpci_fmb *fmb;
 	u16		fmb_update;	/* update interval */
 	u16		fmb_length;
-	/* software counters */
-	atomic64_t allocated_pages;
-	atomic64_t mapped_pages;
-	atomic64_t unmapped_pages;
 
 	u8		version;
 	enum pci_bus_speed max_bus_speed;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 563cb72d9ed0..63fd9e1d9f22 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -157,6 +157,7 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 int zpci_fmb_enable_device(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
+	struct zpci_iommu_ctrs *ctrs;
 	struct zpci_fib fib = {0};
 	u8 cc, status;
 
@@ -169,9 +170,15 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	WARN_ON((u64) zdev->fmb & 0xf);
 
 	/* reset software counters */
-	atomic64_set(&zdev->allocated_pages, 0);
-	atomic64_set(&zdev->mapped_pages, 0);
-	atomic64_set(&zdev->unmapped_pages, 0);
+	ctrs = zpci_get_iommu_ctrs(zdev);
+	if (ctrs) {
+		atomic64_set(&ctrs->mapped_pages, 0);
+		atomic64_set(&ctrs->unmapped_pages, 0);
+		atomic64_set(&ctrs->global_rpcits, 0);
+		atomic64_set(&ctrs->sync_map_rpcits, 0);
+		atomic64_set(&ctrs->sync_rpcits, 0);
+	}
+
 
 	fib.fmb_addr = virt_to_phys(zdev->fmb);
 	fib.gd = zdev->gisa;

---
base-commit: 8e5ab3f54a1061c2be3e1fbcda01fbe604c3450e
change-id: 20231002-dma_iommu_fix-0a5397992f15

Best regards,
-- 
Niklas Schnelle
Linux on Z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement - https://www.ibm.com/privacy 

