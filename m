Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5C797E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbjIGWK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbjIGWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:10:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9AF1BC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:10:53 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387M7bnl032382;
        Thu, 7 Sep 2023 22:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KNhFym+Bi6Rbj4eYJLeDHj2XaygTNOimx3SJ/6jzYqQ=;
 b=UaS7G8VslMVvg0QgjOWVyOVnASZWjCpeby+phpkVhsxUFVCwknIIgLmaTNR/WdsWKrZO
 2HuI1OFG09DIBX/E+nMYuAlQR8/BMwQe/23dqFWLNPmDLMJlI15S+WTN6qYrAnJi/q2X
 BrC2JLi7Hy6tlge4Q3x63b85itlom+1t2NnptMvjcyGNaWX7vUNx67dQQTpkXsBKIBGn
 TwSD035eFl4YOeAXRkaBD0f1rwED7c7FNs/MTfmpcISfI6Sp9tWZQuSQEK61MD7LoAXe
 SEiaR3FTqQXdc+b99Iyz1vZnmWqahzKmAx/ZbzRb5FxCcy3r0Yp5j3PukgUo5oHfLfoR BA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3syp1u9kdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:10:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 387KCFMt026750;
        Thu, 7 Sep 2023 22:10:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcny8kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 22:10:42 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 387MAfNW5636632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Sep 2023 22:10:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 533DD58062;
        Thu,  7 Sep 2023 22:10:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB2055805A;
        Thu,  7 Sep 2023 22:10:40 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Sep 2023 22:10:40 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 0/2] fsi: sbefifo: fixes
Date:   Thu,  7 Sep 2023 17:10:14 -0500
Message-Id: <20230907221016.2978802-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qQEt2cF10PVxfHmCWdPTqrcf8UeNwkZK
X-Proofpoint-ORIG-GUID: qQEt2cF10PVxfHmCWdPTqrcf8UeNwkZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=680 phishscore=0 spamscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please review support for large write in sbefifo driver and also bug
fix.

Ninad Palsule (2):
  fsi: sbefifo: Remove write's max command length
  fsi: sbefifo: Validate pending user write

 drivers/fsi/fsi-sbefifo.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.39.2

