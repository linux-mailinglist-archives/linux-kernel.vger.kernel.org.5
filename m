Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A413788C61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjHYPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjHYPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:22:15 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC3D212C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:22:13 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PF9TZe014529;
        Fri, 25 Aug 2023 15:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : date :
 message-id : content-type : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=B6s7RFpuNIwovKrCL5Zw/lCLHPMgGd2PO1cM3Uvsd8Q=;
 b=PTLvQfCQ4OzvrkuaSx7xJ/Ea/9dw30bhvnzgfcMrwPDLyhYm2qrascurxHbf2lJes6g9
 UldSVIsU/oLxVVpfBf4ngPc2Ox8kkX/70aFPwnw3NPLt8W9TjBDvrSL35vjup2Q7+A7C
 5+UsI7Mfi4QREld6EN80DOFc8g5Lg5EvFC0kj8XLPc29BeobML5jvMmURi0/MMpcbFwb
 RIThuMZyVC3AfJyrFx1lhLUtND7vT8TVuptkPDOWIApL2kNptqo7PPvqgi0vUyKBO8xD
 4VOymQyTKebC9f9vGCNNv3QxKtPfOAoHgsDBVgvzAE564v4ArWGDPDNrC6n5AzMsptJs Dg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spvrmc1qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 15:22:00 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDJ8bh016727;
        Fri, 25 Aug 2023 15:21:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn2288j8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 15:21:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PFLvxR63701348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 15:21:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 942EC20043;
        Fri, 25 Aug 2023 15:21:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4882A20040;
        Fri, 25 Aug 2023 15:21:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 15:21:57 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Date:   Fri, 25 Aug 2023 17:21:24 +0200
Message-Id: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIAPTG6GQC/x3MQQqAIBBA0avIrBtQK4iuEi1sGmsWWihFEd09a
 fkW/z+QOQln6NUDiU/JssUCUymg1cWFUeZisNrWurMtnrKFcGC+I2FwO5rJa6LGz2RaKNWe2Mv
 1H4fxfT9C5wRQYQAAAA==
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=Sud9iIXJLQZCzy8zQhoMn+gWI2ww7v3oAAAhl31EGnU=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJeHPun5vrEwzDkyqJnOxj2Vk89zr3h7nNVj8u3WLhX1
 X6V5n9f0VHKwiDGwSArpsiyqMvZb13BFNM9Qf0dMHNYmUCGMHBxCsBE/uUy/C+q6BDom3ksa6o8
 a251QNuzsprsD5ZLJ6j08cl+zxH79Zzhr2yrY2K3e8BBlnd+UmbiNZ8nGfYLBzDyHj4sljV/4no
 XJgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1hwwZn9bITUcK12PuuCiNJVZzhBN42Im
X-Proofpoint-ORIG-GUID: 1hwwZn9bITUcK12PuuCiNJVZzhBN42Im
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 mlxlogscore=764 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
series of these two changes. This still applies on top of my series[1]
because its first patch titled "iommu: Allow .iotlb_sync_map to fail and
handle s390's -ENOMEM return" enable ops->iotlb_sync_map to return
errors and virtio-iommu's sync can fail. This also makes sure there is
no merge conflict with that series.

The code is also available on the b4/viommu-deferred-flush branch of my
kernel.org git repository[3]

Thanks,
Niklas

[0] https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/lkml/20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com/
[2] https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=b4/viommu-deferred-flush

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Niklas Schnelle (2):
      iommu/virtio: Make use of ops->iotlb_sync_map
      iommu/virtio: Add ops->flush_iotlb_all and enable deferred flush

 drivers/iommu/virtio-iommu.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)
---
base-commit: fcf2e20eb3ef21e36bc31fbbc84e37d17030fa16
change-id: 20230825-viommu-sync-map-1bf0cc4fdc15

Best regards,
-- 
Niklas Schnelle
Linux on Z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement - https://www.ibm.com/privacy 

