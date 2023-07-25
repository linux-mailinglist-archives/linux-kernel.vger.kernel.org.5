Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485A761B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGYOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjGYOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1F2715;
        Tue, 25 Jul 2023 07:19:03 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PE8Bcw023085;
        Tue, 25 Jul 2023 14:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9LrowsiH0qimY8fx2iBLQSsR4UWWIwLCcdpsJLPZPu0=;
 b=Euk4s757QmqtZB9mP+aBEDO/iuW5O+nUvxsOuMnksIg8tR0wg3PWPstld27PoBRJqd1v
 JWY0P7BYdFertLBczb5ssB3NGFWhxE7obkHzK7wJ//nweDZMgtFVXmRko8bUrEqZIyEw
 K93eoVljCz3pICrCvQA9UJ102/h9F45NjTBAYeJ7fg9Dr3bjlB8Q1Pq04BSv8AMtEkqr
 47qQrX7PqfPDQm5MZagJYUaTJJUrCP0T6Z+taE/aC0VrytUI3pYHdhUVQw4yL1pWibWt
 qv/37HKLoD1GzNois7JxycVmIrTBIBP6U8VCel/4WEpnGEhWd1FWi+Eo5lasHr+pweER 7A== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2942bpbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 14:16:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36PDHXpF002068;
        Tue, 25 Jul 2023 14:16:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0temvkv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 14:16:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36PEGc3h721432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 14:16:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CCE158067;
        Tue, 25 Jul 2023 14:16:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CFA958052;
        Tue, 25 Jul 2023 14:16:38 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Jul 2023 14:16:38 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 89E8E7401EF; Tue, 25 Jul 2023 09:16:37 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH 1/1] ARM: dts: aspeed: Rainier: Remove TPM device
Date:   Tue, 25 Jul 2023 09:16:06 -0500
Message-Id: <20230725141606.1641080-2-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230725141606.1641080-1-lakshmiy@us.ibm.com>
References: <20230725141606.1641080-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uzub2ztTzDP-xb-rHHtdLY7nuxO2Judr
X-Proofpoint-GUID: Uzub2ztTzDP-xb-rHHtdLY7nuxO2Judr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=684 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPM is disabled in Rainier, remove TPM device.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index 7162e65b8115..8dd94cd478fc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -2092,11 +2092,6 @@ eeprom@51 {
 &i2c12 {
 	status = "okay";
 
-	tpm@2e {
-		compatible = "nuvoton,npct75x";
-		reg = <0x2e>;
-	};
-
 	eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
-- 
2.37.2

