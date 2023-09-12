Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9879DBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjILWJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjILWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:09:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B110D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:09:43 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CM8n4U004028;
        Tue, 12 Sep 2023 22:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Fmtr17vxfvAxr7b2eFqtCMkznpCwBpMbLf427hX+pdA=;
 b=f03n89EPnp3SJ4kTeBj2ojmhKP5EFEMahYYTmhmqEBfCTu0asgipjFoMSujac1W2fqvf
 mDV8V3rtS7K9Xo9Lj0gfri9uS2n7q/rA15ULe0UIkX6PL+vu4iC63Ybw+EZ4i78eTqLu
 cD6nmp7fIhcLGg+cgvlq8wp9kualjLjpD2xdcM74XqD7op/OzwakF8+rW27ONljrAHQX
 D9KM1ynBx5Y3Nr4SmKUlQLy+D/YSGeFh9SBYwSh85aHNV3DlBe5nzZMSU6HuObROYiSK
 vjD6A7yg2HqlR+bxh095DNFKB55I3Drj+aD54gX6Ag7vRvK91MbdOFYxVwDGWLlVChQR Yg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2ymgh3gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:09:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38CJN5tO011942;
        Tue, 12 Sep 2023 22:09:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1wxbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:09:29 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38CM9RZA34210232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 22:09:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A90BA58052;
        Tue, 12 Sep 2023 22:09:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 623145805A;
        Tue, 12 Sep 2023 22:09:27 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 22:09:27 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com
Cc:     Ninad Palsule <ninad@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3 0/2] soc/aspeed: Add host side BMC device driver
Date:   Tue, 12 Sep 2023 17:09:21 -0500
Message-Id: <20230912220923.3701688-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d0fml4SP8ZwWFH_R5rCO1M3gg0WtpQLy
X-Proofpoint-ORIG-GUID: d0fml4SP8ZwWFH_R5rCO1M3gg0WtpQLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_21,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=533 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Please review a version 3 of patchset.
    - Fixed warning reported by kernel test robot.
    - Added MAINTAINER for new file.
    - Fixed check patch warning.

Ninad Palsule (2):
  soc/aspeed: Add host side BMC device driver
  MAINTAINERS: Added maintainer for host bmc DD

 MAINTAINERS                              |   7 +
 drivers/soc/aspeed/Kconfig               |  11 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 250 +++++++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.39.2

