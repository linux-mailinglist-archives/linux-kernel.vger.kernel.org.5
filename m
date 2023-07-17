Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D6675611C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGQLEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQLDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:03:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0CE60;
        Mon, 17 Jul 2023 04:03:53 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAgM9V022401;
        Mon, 17 Jul 2023 11:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : date :
 message-id : content-type : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=y3nup/KSKmQnQdAEmiTT2rtUgn+/Fb8UZ8mlZ9vlJkI=;
 b=ObYjddM/gCRCidNT/p9u3mjWIg5bgquxouzWQ36yJWQFarJzqgorPOQS/o4SO8IDYeCb
 Ftc1EfFqL7/UlcJLWkspTK5bfA7BW3L705buKqSLp4t0ZiCwPuS/yeNBuWbcKiiX+iFV
 ejmU5++ELGSI0KqtDFixfFzwsuzwtHjgLsMxjfOdzDflx1FgU6/nHyNxmgvN5zyuhKwa
 wxybXPJdgfIpTu9g8zwtCP9zfS+rFfQYDKZxbjCXHaJHjfRsBD3B+QCS82NpdhJsOuAK
 J+wf2JRdqnNfd+CJhIL1rFNceruSlQVhgyvkFEKGOL0BpQ4sq59CEBnRB8pRhV2EEpRv xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw3ty8qdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:01:56 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36HAioGf027255;
        Mon, 17 Jul 2023 11:01:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw3ty8qbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:01:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAmOQE004479;
        Mon, 17 Jul 2023 11:01:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv8g0tn6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:01:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HB1neA61866260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 11:01:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C77420040;
        Mon, 17 Jul 2023 11:01:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3C802004E;
        Mon, 17 Jul 2023 11:01:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 11:01:47 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v11 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Date:   Mon, 17 Jul 2023 13:00:00 +0200
Message-Id: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIADEftWQC/3WOyWoDMRBEf8XoHA1aPbJP+Y8QgpZWJNASJM/gY
 Obfo/ElYOy+VXe/qrqhDi1CR+fDDTVYY4+1DEHp2wHZoMs34OjGAjHCOOGUYJf1V6w5L1gCEcp
 Kro5iRuPf6A7YNF1sGERZUhrLnwY+Xu8JH59D+1YzvoQG+t+WMUIlGzNRRRUXAlPcbSiQErynW
 JbrFE2ebM17TIj9UtvvvfKqdt9n5VaFCWZczM4bcLP2D0Z7l/X0kj4N+iiNUeAcM2Ce0ZS8xIc
 i2FNvnBoXJcUjv23bHyNeGcN8AQAA
To:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6610;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=wYPyQab6RbeXBpxgS0dQX8QkSyUwdBwOSaxQ0tMSvbk=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFK2ymfxLRbSTLgSuLH/7NkbW0JuOXzVuZ/fuyP9W8zsC
 u9PKgdiOkpZGMQ4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZhIcQIjw8ry2y4cFoqZksZf
 O17G3H7rrqm1NksqJ/LTi1z50jMHXjP8d2wwP5EekS9tKvfL+mdvjzWfNf/EnU0GHs/XeCd+SWx
 iBAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OGhxHxWgcMkAy6m2E5KVD60rPjuPppqM
X-Proofpoint-GUID: -GjtqlkFB94nzoetNvD0BlWEJ-CTsxYQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series converts s390's PCI support from its platform specific DMA
API implementation in arch/s390/pci/pci_dma.c to the common DMA IOMMU layer.
The conversion itself is done in patches 3-4 with patch 2 providing the final
necessary IOMMU driver improvement to handle s390's special IOTLB flush
out-of-resource indication in virtualized environments. Patches 1-2 may be
applied independently. The conversion itself only touches the s390 IOMMU driver
and s390 arch code moving over remaining functions from the s390 DMA API
implementation. No changes to common code are necessary.

After patch 3 the basic conversion is done and on our partitioning machine
hypervisor LPAR performance matches or exceeds the existing code. When running
under z/VM or KVM however, performance plummets to about half of the existing
code due to a much higher rate of IOTLB flushes for unmapped pages. Due to the
hypervisors use of IOTLB flushes to synchronize their shadow tables these are
very expensive and minimizing them is key for regaining the performance loss.

To this end patches 4-5 add a new, single queue, IOTLB flushing scheme as
an alternative to the existing per-CPU flush queues. Introducing an alternative
scheme was suggested by Robin Murphy[1]. In the previous RFC of this
conversion Robin suggested reusing more of the existing queuing logic which
I incorporated since v2. The single queue mode is introduced in patch
4 together with a new .shadow_on_flush flag bit in struct dev_iommu.
This allows IOMMU drivers to indicate that their IOTLB flushes do the
extra work of shadowing. This then lets the dma-iommu code use a single
queue.

Then patch 5 enables variable queue sizes using power of 2 values and
shift/mask to keep performance as close to the existing code as
possible. A larger queue size and timeout is then used by dma-iommu when
shadow_on_flush is set. This same scheme may also be used by other IOMMU
drivers with similar requirements. Particularly virtio-iommu may be
a candidate.

In a previous version I verified that the new scheme does work on my
x86_64 Ryzen workstation by locally modifying iommu_subsys_init() to
default to the single queue mode and verifying its use via
"/sys/.../iommu_group/type". I did not find problems with an AMD GPU,
Intel NIC (with SR-IOV and KVM pass-through), NVMes or any on board
peripherals.

This code is also available in the b4/dma_iommu topic branch of my
git.kernel.org repository[3] with tags the version sent.

NOTE: Due to the large drop in performance I think we should not merge
the DMA API conversion (patch 4) until we have a more suited IOVA
flushing scheme with similar improvements as the proposed changes.

Best regards,
Niklas

[0] https://lore.kernel.org/linux-iommu/20221109142903.4080275-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
[2] https://lore.kernel.org/linux-iommu/a8e778da-7b41-a6ba-83c3-c366a426c3da@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/

---
Changes in v11:
- Rebased on v6.5-rc2
- Added patch to force IOMMU_DOMAIN_DMA on s390 specific ISM devices
- Dropped the patch to properly set DMA mask on ISM devices which went upstream separately.
- s390 IOMMU driver now uses IOMMU_CAP_DEFERRED_FLUSH to enable DMA-FQ
  leaving no uses of IOMMU_DOMAIN_DMA_FQ in the driver.
- Link to v10: https://lore.kernel.org/r/20230310-dma_iommu-v10-0-f1fbd8310854@linux.ibm.com

Changes in v10:
- Rebased on v6.4-rc3
- Removed the .tune_dma_iommu() op in favor of a .shadow_on_flush flag
  in struct dev_iommu which then let's the dma-iommu choose a single
  queue and larger timeouts and IOVA counts. This leaves the dma-iommu
  with full responsibility for the settings.
- The above change affects patches 5 and 6 and lead to a new subject for
  patch 6 since the flush queue size and timeout is no longer driver
  controlled
- Link to v9: https://lore.kernel.org/r/20230310-dma_iommu-v9-0-65bb8edd2beb@linux.ibm.com

Changes in v9:
- Rebased on v6.4-rc2
- Re-ordered iommu_group_store_type() to allow passing the device to
  iommu_dma_init_fq()
- Link to v8: https://lore.kernel.org/r/20230310-dma_iommu-v8-0-2347dfbed7af@linux.ibm.com

---
Niklas Schnelle (6):
      iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
      s390/pci: prepare is_passed_through() for dma-iommu
      s390/pci: Use dma-iommu layer
      iommu/s390: Force ISM devices to use IOMMU_DOMAIN_DMA
      iommu/dma: Allow a single FQ in addition to per-CPU FQs
      iommu/dma: Use a large flush queue and timeout for shadow_on_flush

 Documentation/admin-guide/kernel-parameters.txt |   9 +-
 arch/s390/include/asm/pci.h                     |   7 -
 arch/s390/include/asm/pci_clp.h                 |   3 +
 arch/s390/include/asm/pci_dma.h                 | 119 +---
 arch/s390/pci/Makefile                          |   2 +-
 arch/s390/pci/pci.c                             |  22 +-
 arch/s390/pci/pci_bus.c                         |   5 -
 arch/s390/pci/pci_debug.c                       |  12 +-
 arch/s390/pci/pci_dma.c                         | 735 ------------------------
 arch/s390/pci/pci_event.c                       |  17 +-
 arch/s390/pci/pci_sysfs.c                       |  19 +-
 drivers/iommu/Kconfig                           |   4 +-
 drivers/iommu/amd/iommu.c                       |   5 +-
 drivers/iommu/apple-dart.c                      |   5 +-
 drivers/iommu/dma-iommu.c                       | 212 +++++--
 drivers/iommu/intel/iommu.c                     |   5 +-
 drivers/iommu/msm_iommu.c                       |   5 +-
 drivers/iommu/mtk_iommu.c                       |   5 +-
 drivers/iommu/s390-iommu.c                      | 433 ++++++++++++--
 drivers/iommu/sprd-iommu.c                      |   5 +-
 drivers/iommu/sun50i-iommu.c                    |   6 +-
 drivers/iommu/tegra-gart.c                      |   5 +-
 include/linux/iommu.h                           |   6 +-
 23 files changed, 641 insertions(+), 1005 deletions(-)
---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230310-dma_iommu-5e048c538647

Best regards,
-- 
Niklas Schnelle
Linux on Z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement - https://www.ibm.com/privacy 

