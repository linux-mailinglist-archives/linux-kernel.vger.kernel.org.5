Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6F8137AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444022AbjLNRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444027AbjLNRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:11:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C0B7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:11:10 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEGpxj0019652;
        Thu, 14 Dec 2023 17:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UuLYDTsEP4p3ZaN5YQ2x0vOvKHdjmfFWLpCx6Rhf3ak=;
 b=P0ArWGvO5M3qLG5Kr13y+DmlU/DJSXGvc1T3vwP/SNJhiiqadRI3c0S4LVxFPfBlOh21
 E0AkR4Vy9osn4GwN42yId55r7cJDBvLLjrD6DD/RdmmeKHcNC2dKr9s2grSPPgWN3hZb
 o9YFV8xOdIAj9Ek7HcfI2I/LiSM0KwiGWI+AmCAzi8cqUv3OiB9V1Cfu4xhmuHgMtK09
 VFFOS5FKsT/J9H0ZPOhuPnMSYqcLzyORl37GCHEV0HwpPWQrUL3rIFmG15JAj304+Wi1
 tS16KjtrHkDLvDMS5sxamdIk1PqfXjF5AHBGTNoqGy8hZJkjOaqsV+ssTONC2wJdNbpK Rw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v04cgb0ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 17:10:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEGpbvu013937;
        Thu, 14 Dec 2023 17:10:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592hjkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 17:10:58 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEHAtax20054744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 17:10:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B83CF58056;
        Thu, 14 Dec 2023 17:10:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA8E95803F;
        Thu, 14 Dec 2023 17:10:55 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 17:10:55 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 6A50E740051; Thu, 14 Dec 2023 11:10:55 -0600 (CST)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     joel@jms.id.au, eajames@linux.ibm.com, ninad@linux.ibm.com,
        alistair@popple.id.au
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] fsi: run clock at 100MHz
Date:   Thu, 14 Dec 2023 11:10:42 -0600
Message-Id: <20231214171042.3889056-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kXOEO9kwfBx624Gtujtxl3dqadqRIwPi
X-Proofpoint-ORIG-GUID: kXOEO9kwfBx624Gtujtxl3dqadqRIwPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=906 phishscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust FSI speed to 100MHz for improved stability and optimized
data transmission.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f0a19cd451a0..b065e1bb9054 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -87,7 +87,7 @@ static const u32 fsi_base = 0xa0000000;
 #define FSI_LINK_ENABLE_SETUP_TIME	10	/* in mS */
 
 /* Run the bus at maximum speed by default */
-#define FSI_DIVISOR_DEFAULT            1
+#define FSI_DIVISOR_DEFAULT            2
 #define FSI_DIVISOR_CABLED             2
 static u16 aspeed_fsi_divisor = FSI_DIVISOR_DEFAULT;
 module_param_named(bus_div,aspeed_fsi_divisor, ushort, 0);
-- 
2.39.2

