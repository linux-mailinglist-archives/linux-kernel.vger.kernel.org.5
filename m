Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABC37F1663
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjKTOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjKTOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:53:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2EB1FC6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:52:31 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKEiS3Y015546;
        Mon, 20 Nov 2023 14:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : references : in-reply-to : to : cc :
 content-transfer-encoding : mime-version; s=pp1;
 bh=g555knNJ0WaRqIr6zqtIc5qzOjlqBMz8REb3jadN0GY=;
 b=c/krbcBSDcrOpbz6HQoEBExicyBmRe6aIu3WjMSYdtgduiLZbW4mh8rtbHB32aXmvTTY
 Pmr1WOrLdsuS/bVSp7JtbYv06w4Gll/CHAx6SL2yAWeR3FJd9Iuyr8cupea3rSB5GVWl
 8ltOqaFdJcXRLY9YayPffbXAXCGHEZ0A9cN2ZabCiYnDqTHBxh0i/NRTO4I4ykzRTNOT
 poQdut/dRunIoXTg45H+5T35fIl7hEJSwUqMO/6mSchF4LFZ74cCeNIcZeUi82RZXkL5
 alSnQInKEMiGhbLff0ayW62WPnzHgU439YNnB5nga72o17OD9ye1wnji8sDU2n/NKCpd wA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug9fxg6dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:52:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDWm9r028297;
        Mon, 20 Nov 2023 14:52:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kst37m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:52:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKEqFtl46137948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:52:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D21EF20040;
        Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A21B82004B;
        Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Mon, 20 Nov 2023 15:51:57 +0100
Subject: [PATCH v3 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Content-Type: text/plain; charset="utf-8"
Message-Id: <20231120-viommu-sync-map-v3-2-50a57ecf78b5@linux.ibm.com>
References: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
In-Reply-To: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2055;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=0XaEWHDlK1lSjuTPZ/FhgedByLy/6lzBH/egiiPZqP8=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFKji2aye9wXv/L727sCRp+Sx567frCFLDlxMId35f4vX
 60bj6et7ihlYRDjYJAVU2RZ1OXst65giumeoP4OmDmsTCBDGLg4BWAiPhsZGV4wRHvu7n3UeV3j
 svfFmELpx/ON9n/nYMuZdfHekeR5F3Yw/JW9YWe643eX3gTn23FXZJaY/OFWKDA03dz5VyZba+G
 hbAYA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7A8r8QpyjiAyj_T-SVETElit6Gh2OmqG
X-Proofpoint-GUID: 7A8r8QpyjiAyj_T-SVETElit6Gh2OmqG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=855 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ops->flush_iotlb_all operation to enable virtio-iommu for the
dma-iommu deferred flush scheme. This results in a significant increase
in performance in exchange for a window in which devices can still
access previously IOMMU mapped memory when running with
CONFIG_IOMMU_DEFAULT_DMA_LAZY. The previous strict behavior can be
achieved with iommu.strict=1 on the kernel command line or
CONFIG_IOMMU_DEFAULT_DMA_STRICT.

Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3f18f69d70d8..ef6a87445105 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -926,6 +926,19 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
 	return viommu_sync_req(vdomain->viommu);
 }
 
+static void viommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	/*
+	 * May be called before the viommu is initialized including
+	 * while creating direct mapping
+	 */
+	if (!vdomain->nr_endpoints)
+		return;
+	viommu_sync_req(vdomain->viommu);
+}
+
 static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
 	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
@@ -1051,6 +1064,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
 	default:
 		return false;
 	}
@@ -1071,6 +1086,7 @@ static struct iommu_ops viommu_ops = {
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
+		.flush_iotlb_all	= viommu_flush_iotlb_all,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.iotlb_sync_map		= viommu_iotlb_sync_map,
 		.free			= viommu_domain_free,

-- 
2.39.2

