Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF07F1662
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjKTOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjKTOxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:53:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C71FC2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:52:31 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKEF9a1003878;
        Mon, 20 Nov 2023 14:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : date :
 message-id : content-type : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=IWVM0w+Z8IoujKc8CxKxxMHs9XgsT6zJJUKE7vVPGFk=;
 b=V/fu8p0y04MZFmnw8G+HWeiorxSJfb7ixQmsBcL9AIOHC6RDaQlkM8A7up3/452WqCZN
 C/E3mQMYNLpjXuNjH22Mld1bqqxvcqiSSu9WpjeDvN4yfKIhDhIWaLa6Jl7NbWk2nQMv
 s8ECG78f/x2hOtj10VJsSgJrZcuQ5TGaSaGbkCGiUyJBlRO70U/7db/JSAUJsaH7gPD+
 B+Lw0MxkzJ2Pc72rximOPWkPELP9N+iDm3vRPLnGg5qrfCp1LECruGkRu08BQ0L7CJf+
 L/SCXpSXsF0bUM6fMXWf3l9Q4Zcq7v18ChAlqy9+Y8o7kYi5hu3IXz23ExlltI9unNrq rQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug928s4wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:52:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDU5BG027937;
        Mon, 20 Nov 2023 14:52:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kst37h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 14:52:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKEqFKX46137944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 14:52:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62CC620040;
        Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30D952004B;
        Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 14:52:15 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Date:   Mon, 20 Nov 2023 15:51:55 +0100
Message-Id: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIAItyW2UC/3XNywqDMBCF4VeRrBvJpd666nuULuKY1IHGSFKDI
 r57o5tCS5f/gflmJUF71IFcspV4HTGgG1LIU0agV8NDU+xSE8GEZLUoaERn7UTDMgC1aqS8NQz
 gbDrgBUlXo9cG50O83VP3GF7OL8eDyPf1vxU5ZbQo2w6MUqLRcH3iMM05tjYHZ8nuRfExGl7/G
 iIZRsqqrEwJplLfxrZtb3q/dX32AAAA
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2832;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=F4corESfp9/wHG5HKyzzSk+TFTzQvo+AJLDiL9ON04g=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFKji3q55zz3+7Z6A1tm61VeVhNVf7XnZ/IWJnyfEqkW+
 6sv8e3fjlIWBjEOBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACaycD/DH94DIskbrdLkq5Uu
 sUpMjDuYFP9wz9S99b02T+Z1TAuY5sLIsGdjlPpP9Y9y7Gz5/1R8a3eVt8vWmh7VWf/pQFjUfYc
 OfgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: an9jJ_hlHuFRS_bsUOHHzbwydHxQM_dh
X-Proofpoint-ORIG-GUID: an9jJ_hlHuFRS_bsUOHHzbwydHxQM_dh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

Hi All,

Previously I used virtio-iommu as a non-s390x test vehicle[0] for the
single queue flushing scheme introduced by my s390x DMA API conversion
series[1]. For this I modified virtio-iommu to a) use .iotlb_sync_map
and b) enable IOMMU_CAP_DEFERRED_FLUSH. It turned out that deferred
flush and even just the introduction of ops->iotlb_sync_map yield
performance uplift[2] even with per-CPU queues. So here is a small
series of these two changes.

The code is also available on the b4/viommu-deferred-flush branch of my
kernel.org git repository[3].

Note on testing: I tested this series on my AMD Ryzen 3900X workstation
using QEMU 8.1.2 a pass-through NVMe and Intel 82599 NIC VFs. For the
NVMe I saw an increase of about 10% in IOPS and 30% in read bandwidth
compared with v6.7-rc2. One odd thing though is that QEMU seemed to make
the entire guest resident/pinned once I passed-through a PCI device.
I seem to remember this wasn't the case with my last version but not
sure which QEMU version I used back then.

@Jean-Philippe: I didn't include your R-b's as I changed back to the
nr_endpoints check and this is like 30% of the patches.

Thanks,
Niklas

[0] https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/lkml/20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com/
[2] https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v3:
- Removed NULL check from viommu_sync_req() (Jason)
- Went back to checking for 0 endpoints in IOTLB ops (Robin)
- Rebased on v6.7-rc2 which includes necessary iommu-dma changes
- Link to v2: https://lore.kernel.org/r/20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com

Changes in v2:
- Check for viommu == NULL in viommu_sync_req() instead of for
  0 endpoints in ops (Jean-Philippe)
- Added comment where viommu can be NULL (me)
- Link to v1: https://lore.kernel.org/r/20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com

To: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: virtualization@lists.linux-foundation.org,
Cc: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
Cc: Niklas Schnelle <schnelle@linux.ibm.com>

---
Niklas Schnelle (2):
      iommu/virtio: Make use of ops->iotlb_sync_map
      iommu/virtio: Add ops->flush_iotlb_all and enable deferred flush

 drivers/iommu/virtio-iommu.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20230825-viommu-sync-map-1bf0cc4fdc15

Best regards,
-- 
Niklas Schnelle

