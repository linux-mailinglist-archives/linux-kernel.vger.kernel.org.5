Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81398120F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442651AbjLMVyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMVyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:54:01 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70BAC;
        Wed, 13 Dec 2023 13:54:08 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKbCiQ025993;
        Wed, 13 Dec 2023 21:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=r+TUhhlxCI/DLNrETTUqEE6yD/vt372k5iKQotc3Yl4=;
 b=a2+006XKiRixF/RVLRzLNIlTBWeLn+1vXJ6DXAt3h9dPGEhmoVeOPWkzADV203gRT46k
 RVq/OFwBYF5En4X8j9qbjUB2079OrUYEbSciP48xW6djYE1c5fkSXL9+EMJ+F/B69c6E
 wGt4XBGkVjFQylLjZ7awiHHz0597Ekmx/VRFtDO54v30aEXFhr90+svL90O3QU4SJQtZ
 Ceh90i4/ic/F5NxeeKmf/BV+15SUI22SZ+TKcN0PLQEXpwAj/X3dhl73Bywfv9bTRBes
 94/XSle0v26mG1tGdypm1hnWMwFNnop3hW3a0g5L+sOuo7g0VE0G4Y/EFxq/C25xmUoc qA== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3uyfh82xt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 21:53:52 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DD1BF805E0F;
        Wed, 13 Dec 2023 21:53:51 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id B1FCD8000B4;
        Wed, 13 Dec 2023 21:53:50 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 0/3] watchdog/hpwdt: Cleanup Claiming NMI
Date:   Wed, 13 Dec 2023 14:53:37 -0700
Message-ID: <20231213215340.495734-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iyvfKdkmKXvtcNdv1TI-zV3B89qV7BQD
X-Proofpoint-GUID: iyvfKdkmKXvtcNdv1TI-zV3B89qV7BQD
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130154
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to being a watchdog, hpwdt participates in error
containment on ProLiant systems.

On legacy platforms, Gen 9 and earlier, Fatal IO errors would be
signaled as an IO CHECK NMI with expectation that hpwdt would be present
to receive the NMI and crash the systems thus containing the error.

A problem was that hwpdt did not discriminate enough in accepting NMIs.
This could lead to problems if an NMI generated for another subsystem
was not claimed by that subsystem and became UNKNOWN and was claimed
by hpwdt.  Application profiling was such an example.  Although the known
profiling issue was fixed, hpwdt should avoid claiming NMI not intended
for it.

In iLO 5 time frame, checks were added to make hpwdt more selective
in claiming NMI.  This patchset cleans up the checks and enables them
for future versions of iLO.

Updates from V1
---------------
Refactor second patch into two creating a three patch series.
Update and clarify patch documentation.



Jerry Hoemann (3):
  watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO
  watchdog/hpwdt: Remove redundant test.
  watchdog/hpwdt: Remove unused variable

 drivers/watchdog/hpwdt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

-- 
2.41.0

