Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798C97C41BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjJJUoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjJJUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:44:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10EE9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:44:06 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKZLcY026863;
        Tue, 10 Oct 2023 20:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NyTcl2WVUIxRz2AihBYuBwAILzqMqo2Hp83u66Osvd8=;
 b=r320EfUtGnQaN3oRXfaOchtrKkgSTMfb5voqHd+KpH1InF8f8uRpr1KZq9vs5H1/QAhR
 oA+QfExf3t361hJOSX1r0dC6f9SAv3uR93vdPTjwkYrdyaXeUO4xTn1Kd32bnW6kVrXy
 4N1R0iitgbAWjuLzvtoMNsD+wjeMZQ7OndhSrE5c7SzUdVBqa0qQrC/Db1aXT/pHAxb6
 RzS5V4UrxigZXODT7wZQF2I5eKGBDjJXyNPZmN0gJ3kt2Z0t4cdAf5PvRmUHpBiFRRfy
 aADRqXdaCMNdHKYTvS3T7+F72nMYQPB7GwzCJI4//u/dYWJt2iuRqWM9AEGM0DrssZ5y eg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnds9gcmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 20:43:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKQClU024498;
        Tue, 10 Oct 2023 20:43:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnskay2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Oct 2023 20:43:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AKhqOK19137042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 20:43:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7722558068;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3495E58056;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Oct 2023 20:43:52 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v3 0/2] fsi: sbefifo: fixes
Date:   Tue, 10 Oct 2023 15:43:46 -0500
Message-Id: <20231010204348.2600242-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3MIkQGpSs15SY-npvr9opF8SjJNwtsBj
X-Proofpoint-GUID: 3MIkQGpSs15SY-npvr9opF8SjJNwtsBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxscore=0 mlxlogscore=674 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Please review the version 3 of the patchset. I have incorporated review
comments by Eddie.

Ninad Palsule (2):
  fsi: sbefifo: Bump up user write cmd length
  fsi: sbefifo: Handle pending write command

 drivers/fsi/fsi-sbefifo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.39.2

