Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7046F7FDA73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjK2OyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjK2OyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:54:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B718BE;
        Wed, 29 Nov 2023 06:54:12 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATEqWgm005551;
        Wed, 29 Nov 2023 14:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NFnJQ8+sq6PRxzcrimNnl85UtYHLZzoEj5SNJF7xbtM=;
 b=P6Ckzu5Qe88kz5EsgxGATJSaYLAQRun7VyPkNRQm6Deno5jeHNjqcJPrrTs0epqP/tcs
 n1hSblp9viMBhga7ixwp1kXkkSPgbZk+0fATY7vjC7RtFy+v2cnTUdUH7s1b+pLBOgCp
 iUsCIwbbdYjUezikEHWM7Gu+cS4QLtEcOS2JXCzR5JAI5pr0T9Yt80R72n5nRHhrH2u2
 rK+SJABcQM8/Q1cXLhrW+Tu4TKRX2xEuDIHjjGKmOUcqumfXH26PKE4fsERDz8vgCcnS
 dAirCFtONY+zyuAULcV6Et/b+trj/VAbVwvTd8bzAZkVNulhIi1dpTzA28IvrnVgPhWa 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up7eq02tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:54:09 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ATEs9pm014243;
        Wed, 29 Nov 2023 14:54:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up7eq02sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:54:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATEBj4u001569;
        Wed, 29 Nov 2023 14:54:07 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkqpsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 14:54:07 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATEs7KA17957448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 14:54:07 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC7555805B;
        Wed, 29 Nov 2023 14:54:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A155E58058;
        Wed, 29 Nov 2023 14:54:05 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.149.198])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Nov 2023 14:54:05 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, borntraeger@linux.ibm.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com
Subject: [PATCH v4 0/3]  a couple of corrections to the IRQ enablement function
Date:   Wed, 29 Nov 2023 09:53:58 -0500
Message-ID: <20231129145404.263764-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sErvNc10n8rah2A1GkeU4qV13aqPq4ip
X-Proofpoint-ORIG-GUID: NYi10FMRkaQzbifJO5GqCxxDNtZignW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_12,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series corrects two issues related to enablement of interrupts in 
response to interception of the PQAP(AQIC) command:

1. Returning a status response code 06 (Invalid address of AP-queue 
   notification byte) when the call to register a guest ISC fails makes no
   sense.
   
2. The pages containing the interrupt notification-indicator byte are not
   freed after a failure to register the guest ISC fails.

Change log v3 ==> v4:
--------------------
* Improved commit message in patch 2/3 (Halil)

Anthony Krowiak (2):
  s390/vfio-ap: unpin pages on gisc registration failure
  s390/vfio-ap: set status response code to 06 on gisc registration
    failure

Tony Krowiak (1):
  s390/vfio-ap: improve reaction to response code 07 from PQAP(AQIC)
    command

 drivers/s390/crypto/vfio_ap_ops.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.41.0

