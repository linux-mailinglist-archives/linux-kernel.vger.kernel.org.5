Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB37A48C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjIRLwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbjIRLwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:52:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EAFE1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:52:26 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IBbd9Y008356;
        Mon, 18 Sep 2023 11:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : date :
 message-id : content-type : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=zeil5EHqXdkAJiDROyv+aJGQitO2NHr1r/cNwSoEua8=;
 b=o2styL2jwOota/j2/3AFMQxF8MeC1Af+lVzYDoVd8tB/ehr4ohSpcC60/XoekyTASgvb
 GhZE8Q/SM4x/Ia6yfg0VZWLUP0CR8GF6FzPZBmaL/8HLpJv5eFrBTxvNnir5RO6sfT0l
 x+Z68VdW+HZ0T9C/thPSsg2cVubAL1xQ3uVYUbBBAY35zObZFqySQ89+V28s6bmhFBbx
 UIvVu38pDQ84q6zl1V7MXMwzaO0MjDV6xMfne/MWWtuqz+0uuLbPKSWxmRd1nMMGxRyu
 1kkz/3Pniy9FrcRXBqvmuwaAc/KRr14sO5oo+pR78KRol2bplTPyxAFLtM2cJEQ5IBV0 hQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6nks8htp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:52:06 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38IB7LpM010124;
        Mon, 18 Sep 2023 11:52:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwjsy79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 11:52:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IBq4Ix20185692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 11:52:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3977020040;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09C4D2004B;
        Mon, 18 Sep 2023 11:52:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 11:52:03 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Date:   Mon, 18 Sep 2023 13:51:42 +0200
Message-Id: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIAM45CGUC/3WNQQ6CMBBFr0Jm7ZC2ilFX3MOwKEMrk9iWtNJAC
 He3snf5XvLf3yCZyCbBo9ogmsyJgy+gThXQqP3LIA+FQQl1FjfVYObg3Ixp9YROTyh7K4gudiD
 ZQFlN0VhejuKzKzxy+oS4HgdZ/uz/VpYosLn2A1mt1d1Q+2Y/LzX3rqbgoNv3/QsVhUf6sgAAA
 A==
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=hYfpjQ4hgqRYixGYa10FkDDypLezqIMzaeNq0Xgplxg=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFI5LC9Waj443tmo+2TZ7kUsVx+1sKaEXrDd4n6zlumrv
 H300rLTHaUsDGIcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzkZgnDP33OjMadE662RnWm
 CkXe0kz1YN798qXgpVTx80f/r1r3SYaRofu/bWfS23cSflMtdzNPXRAW96Y+nb1blHnZ050zhGf
 uYwQA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XWH3eRYEFscA15lREfSDhsBGfnCuo69e
X-Proofpoint-ORIG-GUID: XWH3eRYEFscA15lREfSDhsBGfnCuo69e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_04,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Changes in v2:
- Check for viommu == NULL in viommu_sync_req() instead of for
  0 endpoints in ops (Jean-Philippe)
- Added comment where viommu can be NULL (me)
- Link to v1: https://lore.kernel.org/r/20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com

---
Niklas Schnelle (2):
      iommu/virtio: Make use of ops->iotlb_sync_map
      iommu/virtio: Add ops->flush_iotlb_all and enable deferred flush

 drivers/iommu/virtio-iommu.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)
---
base-commit: e165388f6d32dc8a49f49ef6e80584ad3def3d78
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

