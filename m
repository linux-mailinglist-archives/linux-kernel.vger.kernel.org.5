Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A757A48C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbjIRLwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbjIRLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:52:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA26E6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:52:24 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IBgMnY028468;
        Mon, 18 Sep 2023 11:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : references : in-reply-to : to : cc :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9jzteoHEIzdqh8tOaro7yj/VFvME4x3Qvpq6QEzYKTU=;
 b=mHakv94Tlcmr5Enx1U87Z8ow6TLq9bJ9YUlCV7AyrsK3W7hMy+JrWdnp4w1xRwagLvWD
 K9xJTvxgTrwxBFLnzjQdag8JAuyaf6RHxzetWEJduGZgmiKZSszC1Lcv84P6h5UB6VXY
 oOUUx/pw6cOYBB6XiUj1T8B50r1iUaJiF+OaTo452AH1SdOmhtIJJy8GSUNv8Eyz0OQg
 17HV+/TWpO5abhrw7y8TxqsXs3H+bcJP6IuQ2/FoXed9e56g1Ml0xp8BPNrYfHJ7hPPv
 qAmCTqi3IP/+p/TEqRlSPWxZ1tRrGIMS99Y1VC6kn0uRuY8vpkYwKz5/L6tQazLpmq23 qQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6nwhr6eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:52:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38IA0Q90011683;
        Mon, 18 Sep 2023 11:52:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5qpn2bdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:52:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IBq43S7144038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 11:52:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F02120040;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40F3C2004F;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Mon, 18 Sep 2023 13:51:43 +0200
Subject: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
In-Reply-To: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2246;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=9DWWTNpNbWK0dWH80r17ghRqxZ4r9lAHmGntuH/H0Ls=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFI5LK8fmXclesfsUzZMLytLdrtsfi8x2XvxrpT1yYcqf
 zTIszMqdJSyMIhxMMiKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjARYyeGf+rHxM2n8in9vRa4
 92Pevj8SwRf0f1uzKiW6iaqXLK5kSGf479Txhy06+Zf4YbfNFX+rxB4l7ks1W1DGfv3jvOIXyzd
 e5QEA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w6vAB7KI49RqmI13ttuXNrChbd2X2jXW
X-Proofpoint-GUID: w6vAB7KI49RqmI13ttuXNrChbd2X2jXW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=340 priorityscore=1501 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull out the sync operation from viommu_map_pages() by implementing
ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.

Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 17dcd826f5c2..3649586f0e5c 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
 	int ret;
 	unsigned long flags;
 
+	/*
+	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
+	 * is initialized e.g. via iommu_create_device_direct_mappings()
+	 */
+	if (!viommu)
+		return 0;
 	spin_lock_irqsave(&viommu->request_lock, flags);
 	ret = __viommu_sync_req(viommu);
 	if (ret)
@@ -843,7 +849,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			.flags		= cpu_to_le32(flags),
 		};
 
-		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
+		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
 		if (ret) {
 			viommu_del_mappings(vdomain, iova, end);
 			return ret;
@@ -912,6 +918,14 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
 	viommu_sync_req(vdomain->viommu);
 }
 
+static int viommu_iotlb_sync_map(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	return viommu_sync_req(vdomain->viommu);
+}
+
 static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
 	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
@@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops = {
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
 		.iotlb_sync		= viommu_iotlb_sync,
+		.iotlb_sync_map		= viommu_iotlb_sync_map,
 		.free			= viommu_domain_free,
 	}
 };

-- 
2.39.2

