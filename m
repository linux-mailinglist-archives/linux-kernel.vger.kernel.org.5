Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D060878CBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbjH2SHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbjH2SHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:07:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313F1BC;
        Tue, 29 Aug 2023 11:07:16 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TI6qAs017141;
        Tue, 29 Aug 2023 18:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9N3469yYamWUG/G53scrJuF70e6otIYfurcvQpyjq3Y=;
 b=Is3Y6RdjevQ8TnHSMz801S1IAUF8SVQoUkSBg/s1Vu3VwDonnLHUds5EL+66dt5SEyJI
 MpgPfJf3uCSwADRyUsewNKyfV74fuV62DS3zmgBtDOUSD+bOhM0i5lBKN3YuL9WHXqya
 AGhYmcYdL+rHw2dwgDyeIeRMS7PgymGZ0sOfOHkg1Ntkot28zNEoO2KApKP1WU5VyyrE
 0WHPv5GCPO+dHjWE3K4aYZWAVWaJwpKFsqtho+QsIZjUAlqdbHHmRImjadBpubrTvBXL
 WSbpg9r8onr7JmfOvfWgX+y5NHfQPwIXYlSPgWFPrlpS3rBLKsVUGHQXovpmTIwEVDRk Bg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssnadrfkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 18:06:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TGIpVx019193;
        Tue, 29 Aug 2023 18:02:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1mvxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 18:02:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TI2bGP62587190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 18:02:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC8A58059;
        Tue, 29 Aug 2023 18:02:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADB8258057;
        Tue, 29 Aug 2023 18:02:37 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Aug 2023 18:02:37 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 2C95874000A; Tue, 29 Aug 2023 13:02:36 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     eajames@linux.ibm.com, jic23@kernel.org, lars@metafoo.de,
        joel@jms.id.au, andrew@aj.id.au
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v1 1/1] iio: pressure: dps310: Adjust Timeout Settings
Date:   Tue, 29 Aug 2023 13:02:22 -0500
Message-Id: <20230829180222.3431926-2-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829180222.3431926-1-lakshmiy@us.ibm.com>
References: <20230829180222.3431926-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZXuwQpf-cySnSnYnB1yURUJNFunTJ_4q
X-Proofpoint-ORIG-GUID: ZXuwQpf-cySnSnYnB1yURUJNFunTJ_4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPS310 sensor chip has been encountering intermittent errors while
reading the sensor device across various system designs. This issue causes
the chip to become "stuck," preventing the indication of "ready" status
for pressure and temperature measurements in the MEAS_CFG register.

To address this issue, this commit fixes the timeout settings to improve
sensor stability:
- After sending a reset command to the chip, the timeout has been extended
  from 2.5 ms to 15 ms, aligning with the DPS310 specification.
- The read timeout value of the MEAS_CFG register has been adjusted from
  20ms to 30ms to match the specification.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 drivers/iio/pressure/dps310.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index b10dbf5cf494..1ff091b2f764 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -57,8 +57,8 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 
-/* Make sure sleep time is <= 20ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(20000, (t) / 8)
+/* Make sure sleep time is <= 30ms for usleep_range */
+#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
 /* Silently handle error in rate value here */
 #define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
 
@@ -402,8 +402,8 @@ static int dps310_reset_wait(struct dps310_data *data)
 	if (rc)
 		return rc;
 
-	/* Wait for device chip access: 2.5ms in specification */
-	usleep_range(2500, 12000);
+	/* Wait for device chip access: 15ms in specification */
+	usleep_range(15000, 55000);
 	return 0;
 }
 
-- 
2.39.2

