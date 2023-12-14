Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08285813390
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573558AbjLNOuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573312AbjLNOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:49:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31010F;
        Thu, 14 Dec 2023 06:50:05 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEkk4Y005093;
        Thu, 14 Dec 2023 14:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=kHHl0f8RwfUu7HzgV3Mii9bAXDUHulH0KGOvLW3qpr8=;
 b=OEtuXcUmEVlV2I8stlty9/r/55lnt14br2es7A1erCv0VW5nx5NobRqlIzPmHa/Md7Gy
 VqRHfVEHMicYHER3uFy91N/nF8kRiqigqI0H6bp+cix2JxBpFdiBPsBA2zJseXjhWK3I
 SzwCj2zwkkmhgKLzGrCfBsiPXPmRcQy33WNfZBfGM/yNXw3RTGFp2co6Bz9knlRqbdn7
 Ea9ya1b//DTZ4yXBO8yUI/hRyeLGQ/hxYcDIXmQLaMpWxJDbsaKTfSdOjfDxIM4gY0de
 A0OydKEW4rngE18MQ9xC7TUjja1jlBiUjX+YjGQjv4jYq0ZLJ0XrbKDWeQkO+SwR0Sx2 SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v03e01145-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 14:49:58 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEEl88g009151;
        Thu, 14 Dec 2023 14:49:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v03e0113h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 14:49:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEOUx3014136;
        Thu, 14 Dec 2023 14:49:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592gmjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 14:49:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEEnvm024314506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 14:49:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11F565805E;
        Thu, 14 Dec 2023 14:49:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB0FA5805A;
        Thu, 14 Dec 2023 14:49:56 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 14:49:56 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc:     Ninad Palsule <ninad@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au
Subject: [PATCH v1 0/1] Add more compatibility strings to tpm-tis-i2c
Date:   Thu, 14 Dec 2023 08:49:52 -0600
Message-Id: <20231214144954.3833998-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MlqJ9OKR5yEFp8lNCfRY4eC5ZMX0K3jU
X-Proofpoint-ORIG-GUID: tPir1ZFJtM1OLt-xegOvT3RfYyi5qy0V
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 mlxlogscore=777 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312140103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new IBM system1 bmc machine uses Nuvoton TPM chip. I had this commit
as part of the device tree for new machine but reviewer suggested send
the driver commit as separate patch.

The patchset for IBM system1 bmc machine device tree is as follows:
https://lore.kernel.org/linux-kernel/20231212164004.1683589-1-ninad@linux.ibm.com/

Joel Stanley (1):
  tpm: tis-i2c: Add more compatible strings

 drivers/char/tpm/tpm_tis_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.39.2

