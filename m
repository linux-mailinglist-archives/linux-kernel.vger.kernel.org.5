Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3413D7D0209
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjJSStf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJSSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:49:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC02CA;
        Thu, 19 Oct 2023 11:49:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JHLR8m013588;
        Thu, 19 Oct 2023 18:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=eR7b89cZuKnf9caCq0WosvPgiZRtOTipOcLHpDu5GsI=;
 b=OT7bsnQNWU84BV9l6NtrIaqGJxjqv1iN5UR4W+9xJ+siriggN0e1U1pVgXfSN/Zf+3A2
 WCzn+4V7ps4Yg++TgEfP4PUyf7/yTFrWh8on0T3vr/YLj3Nshh59O2Yu/EZYS7TAQU6J
 IuKoqTakT8wYxTbOzqAPfB2jOUuuKHYDx8q27lfQPPEPsV3S89qDs5tGTWlYhSXvyYvR
 Iim1JJZZq4t3J66JQJkbAloSQmvzYf4HQLnDzuTyYYEXOX2hlZqkvIl6xm1ZdXevXnkU
 x/ybVnBbR38of1ighSEK51/tjrYGpYfbM45gQ8KPKKFeFV+GV5JAKZ6ZNK1nZtv3Auy1 iA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tu14csc7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JInG95015686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:16 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 11:49:13 -0700
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH 0/3] Dynamic allocation of reserved_mem array.
Date:   Thu, 19 Oct 2023 11:48:22 -0700
Message-ID: <20231019184825.9712-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KkC8AwBNYhVCWLzLADvrgaS_JCiGor3r
X-Proofpoint-ORIG-GUID: KkC8AwBNYhVCWLzLADvrgaS_JCiGor3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_18,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=455 clxscore=1011 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved_mem array is used to store the data of the different
reserved memory regions specified in the DT of a device.
The array stores information such as the name, node, starting address,
and size of a reserved memory region.

The array is currently statically allocated with a size of
MAX_RESERVED_REGIONS(64). This means that any system that specifies a
number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
will not have enough space to store the information for all the regions.

Therefore, this series changes the reserved_mem array from a static
array with a fixed size of MAX_RESERVED_REGIONS(64), to a dynamically
allocated array, using memblock_alloc(), based on the number of reserved
memory regions specified in the DT.

Memory gotten from memblock_alloc() is only writable after paging_init()
is called, but the reserved memory regions need to be reserved before
then so that the system does not create page table mappings for them.

It is possible to call memblock_resverve() and memblock_mark_nomap() on
the reserved memory regions and not need to save them to the array until
we dynamically allocate the array after paging_init(), but this becomes
an issue with reserved memory regions that do not have their starting
address specified in the DT.
i.e. regions specified with the "alloc_ranges" and "size" properties.

Therefore, this series achieves the allocation and population of the
reserved_mem array in two steps:

1. Before paging_init()
   Before paging_init() is called, iterate through the reserved_mem
   nodes in the DT and do the following:
   - Allocate memory for dynamically placed reserved memory regions and
     store their starting address in the static allocated reserved_mem
     array.
   - Call memblock_reserve() and memblock_mark_nomap() on all the
     reserved memory regions.
   - Count the total number of reserved_mem nodes in the DT.

2. After paging_init()
   After paging_init() is called:
   - Allocate new memory for the reserved_mem array based on the number
     of reserved memory nodes in the DT.
   - Transfer all the information that was stored in the static array
     into the new array.
   - Store the rest of the reserved_mem regions in the new array.
     i.e. reserved memory nodes specified with the "reg" property.

The static array is no longer needed after this point, but there is
currently no obvious way to free the memory. Therefore, the size of the
initial static array is now defined using a config option.
Since its size would vary depending on the user, scaling it can help get
some memory savings.

Oreoluwa Babatunde (3):
  of: reserved_mem: Change the order that reserved_mem regions are
    stored
  of: reserved_mem: Add code to dynamically allocate reserved_mem array
  of: reserved_mem: Make MAX_RESERVED_REGIONS a config option

 arch/arm64/kernel/setup.c       |   4 ++
 drivers/of/Kconfig              |  13 ++++
 drivers/of/fdt.c                |  63 +++++++++++++++----
 drivers/of/of_private.h         |   3 +-
 drivers/of/of_reserved_mem.c    | 108 ++++++++++++++++++++++----------
 include/linux/of_fdt.h          |   1 +
 include/linux/of_reserved_mem.h |   9 +++
 7 files changed, 154 insertions(+), 47 deletions(-)

-- 
2.17.1

