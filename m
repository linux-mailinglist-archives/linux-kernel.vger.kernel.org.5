Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B846A76349C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGZLPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGZLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:15:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709197
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:15:01 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QBCMFc004325;
        Wed, 26 Jul 2023 11:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=VsW19Z3EE6UAc3/wbvBMuusEpnSQoHb6PLgWAvcMsLs=;
 b=Xt56vqIOoXJzLcCuTQW0krghA8IgFeBno4AqlJ85vCvTCaCwMN6LNSVHq3InQIZ6RtJ2
 vBfoYuOiOjX3t3oelxuAYVowp2QgSoxIqzbFPpbZ+kqp4GE4B/i0EWebj2Lp9DVdPS6j
 SL55+DF8YiicZHnylLc72SX+rqYj7lfNLrtk2gfwHrCXUhZ76Ud2AIhmoLnuGcCVj0c6
 rnROIO2hfMc5GlIperkhcaREOf6R40oyCG6U3y0r1wO14GRu9q4jW6CVu4EjzvFGMPPV
 Hl8PcBhtRG/JOseB67ck8ruLFc0sduSwH/BqfuVELvWApXSK86aJG1k1K1If4vJkfRZ4 9g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s32de81my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 11:14:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36QA95wx014370;
        Wed, 26 Jul 2023 11:14:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0sty4h34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 11:14:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36QBEYmh16908838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 11:14:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39F1220043;
        Wed, 26 Jul 2023 11:14:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00F7F20040;
        Wed, 26 Jul 2023 11:14:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jul 2023 11:14:33 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC] iommu/virtio: Use single flush queue (EXPERIMENTAL)
Date:   Wed, 26 Jul 2023 13:14:33 +0200
Message-Id: <20230726111433.1105665-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K9nDAre1-s-XX4i1RCjeHzfJAkHrr2Wd
X-Proofpoint-ORIG-GUID: K9nDAre1-s-XX4i1RCjeHzfJAkHrr2Wd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_04,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like on paged s390 guests with their virtual IOMMU, syncing
mappings via virtio-iommu is quite expensive. It can thus benefit from
queueing unmapped IOVAs and flushing them in batches but less so from
parallel flushes which is what the shadow_on_flush flag introduced for
s390 tunes dma-iommu to do.

For this to work .flush_iotlb_all is implemented. Furthermore
.iotlb_sync_map is also implemented and used to pull the sync out of the
mapping operation for some additional batching and performance gain.

In a basic test with NVMe pass-through to a KVM guest on a Ryzen 3900X
these changes together lead to about 19% more IOPS in a fio test and
slightly more bandwidth too.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note:
The idea of using the single flush queue scheme from my series "iommu/dma: s390
DMA API conversion and optimized IOTLB flushing"[0] for virtio-iommu was already
mentioned in the cover letter. I now wanted to explore this with this patch
which may also serve as a test vehicle for the single flush queue scheme usable
on non-s390.

Besides limited testing, this is marked experimental mainly because the use of
queuing needs to be a concious decision as it allows continued access to
unmapped pages for up to a second with the currently proposed single flush
queue mechanism. Also it might make sense to split this patch to do the
introduction and use of .iotlb_sync_map separately but as a test vehicle
I found it easier to consume as a single patch.

[0]: https://lore.kernel.org/linux-iommu/20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com/

 drivers/iommu/virtio-iommu.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3551ed057774..f29eb4ce2b88 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -843,7 +843,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			.flags		= cpu_to_le32(flags),
 		};
 
-		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
+		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
 		if (ret) {
 			viommu_del_mappings(vdomain, iova, end);
 			return ret;
@@ -909,6 +909,27 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
+	if (!vdomain->nr_endpoints)
+		return;
+	viommu_sync_req(vdomain->viommu);
+}
+
+static int viommu_iotlb_sync_map(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	if (!vdomain->nr_endpoints)
+		return 0;
+	return viommu_sync_req(vdomain->viommu);
+}
+
+static void viommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+
+	if (!vdomain->nr_endpoints)
+		return;
 	viommu_sync_req(vdomain->viommu);
 }
 
@@ -991,6 +1012,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 		if (ret)
 			goto err_free_dev;
 	}
+	dev->iommu->shadow_on_flush = 1;
 
 	return &viommu->iommu;
 
@@ -1037,6 +1059,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DEFERRED_FLUSH:
+		return true;
 	default:
 		return false;
 	}
@@ -1057,7 +1081,9 @@ static struct iommu_ops viommu_ops = {
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
 		.iova_to_phys		= viommu_iova_to_phys,
+		.flush_iotlb_all	= viommu_flush_iotlb_all,
 		.iotlb_sync		= viommu_iotlb_sync,
+		.iotlb_sync_map		= viommu_iotlb_sync_map,
 		.free			= viommu_domain_free,
 	}
 };

base-commit: 5514392fe77cd45b0d33bf239f13ba594a6759e5
-- 
2.39.2

