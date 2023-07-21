Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877175BEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGUGgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGUGgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:36:10 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7D1113
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:36:09 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2LDL1013218;
        Thu, 20 Jul 2023 23:35:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=nXKsQhXZQh7jLi2u+CGwysXvPU2p6+KEJSHslWJTMYw=;
 b=dgCMgKtz0xlcBjmmmclXsUBo+c87Orzvd+Hdp2GoaP3bzthpkpOhKK4l6apj9ue8GfGB
 jIvXRCAdxSsTEKJW3Pi0oCO3QBoty1j6vicauDx4DibI0qEhTzUnhm2RYd4/6cjnXfM8
 nBouh+0TlYQJTVVBjRNel9L/OBAgbyyS7KuakMgd0m4DL7yuwKv2Sxn0HW8BuCG2+Abt
 CEb3SRqongtPdw6aw4rkDuIKX0edjE7VDFKJNxI0gKaBFizuZCNk0nIyAkeox8KCOzzG
 XMCeiF97VOa1n1pxSm4CVJ4TuXTA2i7aidGT6X0h3fQ6JDT6P+DBhu5j4Kcygz+Rgaek 0A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ryh5egm40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 23:35:38 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Jul
 2023 23:35:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 20 Jul 2023 23:35:36 -0700
Received: from odyssey-031.marvell.com (unknown [10.75.48.92])
        by maili.marvell.com (Postfix) with ESMTP id 43E2E3F7062;
        Thu, 20 Jul 2023 23:35:35 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <gcherian@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
Subject: [RESEND PATCH 0/4] Add support for SMMU ECMDQ
Date:   Fri, 21 Jul 2023 02:35:09 -0400
Message-ID: <20230721063513.33431-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NNuYSk_QPobThdYPGY-59G1A-d1JQXzN
X-Proofpoint-ORIG-GUID: NNuYSk_QPobThdYPGY-59G1A-d1JQXzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_03,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patches by Zhen Lei <thunder.leizhen@huawei.com> that add
support for SMMU's ECMDQ feature.

I have tested these patches on Marvell SoC that has the ECMDQ feature.

Zhen Lei (4):
  iommu/arm-smmu-v3: Add support for ECMDQ register mode
  iommu/arm-smmu-v3: Ensure that a set of associated commands are
    inserted in the same ECMDQ
  iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for non-shared
    ECMDQ
  iommu/arm-smmu-v3: Add support for less than one ECMDQ per core

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 419 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  37 ++
 2 files changed, 448 insertions(+), 8 deletions(-)

-- 
2.34.1

