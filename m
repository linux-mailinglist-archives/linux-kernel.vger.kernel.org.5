Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA0797DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjIGVJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbjIGVJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:09:28 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0992;
        Thu,  7 Sep 2023 14:09:17 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387J2G3n019322;
        Thu, 7 Sep 2023 21:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=m6Gk2lhFU2fmbnv1QuYhU74BBf+VJwz1IrdICroLvYQ=;
 b=HrHp1pVCaVCb+2Kq5sKyZdUGhRdklQQ6o3oI3lpcp6eGadxAUdLGklz/TsMGHuLlDf4H
 jar13plzB6qmEmV+OjflS/ZBz0bEU4CHYoksJue2tuQwk5L748MLbncZwYfpqS2tLE2V
 oQgaLhWohbCnqrYBQX2ZOyRKRvwnpPKaZNivKrhk96oVZ1K7PU4SrgNMqMSmaAN1/zYF
 SzSsN/nNQzH7ugb3XBayigkTRH37nFfLELAX1FuYHodIbDLWdcOcQR5DGFq1+Ew9BzhO
 mO5f1bawoyehcg8lf0KPtF0d43Vco6bc1SD+2srbSlPA/kkSXT9SvVFzhpRtZzwUlFu9 VA== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3sy7xn87p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 21:09:03 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 29C381318D;
        Thu,  7 Sep 2023 21:09:03 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2DB5C80B0D3;
        Thu,  7 Sep 2023 21:09:01 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richard.yu@hpe.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add USB driver for HPE GXP Architecture
Date:   Thu,  7 Sep 2023 16:05:58 -0500
Message-Id: <20230907210601.25284-1-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: 3rzevSaTyOIjeLRdvpdy9c2HWYxyHb3A
X-Proofpoint-GUID: 3rzevSaTyOIjeLRdvpdy9c2HWYxyHb3A
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=516 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

The GXP hub controller presents a four ports to host software.
Each port is logically connected to one control endpoint and
four generic endpoints.

---

Changes since v1:
 *Renamed binding.
 *Removed all unneeded include files.
 *Using generic node name, usb-hub.
 *Removed of_match_ptr().
 *Using helper for both get resource and IO remap.
 *Using dev_err_probe() return in probe routine.
 *Used sizeof(*...) in the code instead of sizeof(struct...).
 *Removed the term "virtual" as it is still a device.
 *Removed the downstream port number and generic endpoints
  number properties from device tree structure.

Richard Yu (3):
  dt-bindings: usb: Add HPE GXP HUB Controller
  usb: gadget: udc: gxp-udc: add HPE GXP USB HUB support
  MAINTAINERS: add USB HUB support for GXP

 .../devicetree/bindings/usb/hpe,gxp-hub.yaml  |   53 +
 MAINTAINERS                                   |    2 +
 drivers/usb/gadget/udc/Kconfig                |   10 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/gxp-udc.c              | 1371 +++++++++++++++++
 5 files changed, 1437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-hub.yaml
 create mode 100644 drivers/usb/gadget/udc/gxp-udc.c

-- 
2.17.1

