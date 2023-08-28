Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E678B499
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjH1Phd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjH1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:37:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB621B1;
        Mon, 28 Aug 2023 08:36:48 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SF8LkI016755;
        Mon, 28 Aug 2023 15:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fuSNwwow7xUdJM87SsviW6neX56cMmlgdBfa7WN6Pes=;
 b=tZz6wiCvOiAJIkOZwHKFSx9RDcuVCg2xVFHxxO8dwuzgHi1FJ8THOYMhtf1WMekpiZvn
 ok7sD8NfjNcn/smgJIDII3SPeoDrz6ve8He8iyWq5cPBR/aVD0It37c/P3YZDBFbzTGi
 fi5lZpFoUisEwWMOoTrcfMKTJmccHEMMiHEr1YcFGN60a+avBAJ0PSS9TK9p6cG3pVnO
 O+IMqcfQABShEo2l7ZXZCrRIY+N/OW9nr9MN+luMTnyGPOhwFy7luMBu/eUlR/F2modO
 aWVe2AwwnvvwOo9sP1VMkRGrp7VKSXhX/NMO5lS9TZ00SOuugigs2TJu2p4UgQ/cvuVy 6g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87h2p5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 15:36:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37SEqxLU019181;
        Mon, 28 Aug 2023 15:31:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1bnvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 15:31:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37SFVg1F22020654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 15:31:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D207920043;
        Mon, 28 Aug 2023 15:31:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F2D320040;
        Mon, 28 Aug 2023 15:31:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Aug 2023 15:31:42 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 0/1] s390/dasd: fix string length handling
Date:   Mon, 28 Aug 2023 17:31:41 +0200
Message-Id: <20230828153142.2843753-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jqw_vFUrPEw0Lb7OVDvQuxgkGNAiOsnO
X-Proofpoint-GUID: Jqw_vFUrPEw0Lb7OVDvQuxgkGNAiOsnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_12,2023-08-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=477
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308280137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

since both Stefan and Jan are not available, I'm sending a simple fix
to address a valid clang finding. Since I expect more reports and
patches for this, I'm sending this now in order to avoid that more
people spend time on this.

Please apply.

Thanks,
Heiko

Heiko Carstens (1):
  s390/dasd: fix string length handling

 drivers/s390/block/dasd_devmap.c |  6 +-----
 drivers/s390/block/dasd_eckd.c   | 10 +++++-----
 drivers/s390/block/dasd_int.h    |  4 ++++
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.39.2

