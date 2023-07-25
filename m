Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D67761B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjGYOU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjGYOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD12698;
        Tue, 25 Jul 2023 07:19:02 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PE6isf029962;
        Tue, 25 Jul 2023 14:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=d5F1KO0SVqTGkQNnrUVyswalXVag4bmTZdMD2hG6dnw=;
 b=IV0xItgVNLtfQIB31kXD5MheV8vVU1++ojsYNg+0Lf1scTnzXbXazDxL1fM0WsvM2IID
 NG0xIhvtU0RedE6xvfh+VjKRcqbfcYvjay7Lx+hRF3aqboEJ3lNj20DymVc0JgWjgwGz
 jRqW64bmrBpCUMdFCHnaBajNRlh7z8DISGAb6L7IDLdlZpj7b1kWHDehTnZ06fYdd7Sa
 cfWAm3Is3Ll71Obg8z9zvR41QBoySIMZ9JuNDg8iPSplp4XVvJB+5jsX8Qx3d1pSC29l
 Gsa1fAsnj1QkSsqTHARlI6TUPMwm7bWiwUKdIlEijAa9WKx7CRWME4J1mF9tUWxTuSKX xQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s20jtmyn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 14:16:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36PDsuK3002381;
        Tue, 25 Jul 2023 14:16:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txjve38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 14:16:39 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36PEGcIJ23790264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 14:16:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44A7C5805A;
        Tue, 25 Jul 2023 14:16:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 350EF58056;
        Tue, 25 Jul 2023 14:16:38 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Jul 2023 14:16:38 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 858C07401EE; Tue, 25 Jul 2023 09:16:37 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH 0/1] ARM: dts: aspeed: Rainier: Remove TPM device
Date:   Tue, 25 Jul 2023 09:16:05 -0500
Message-Id: <20230725141606.1641080-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dp_NfcHyUeSW42wsQzgJHHAi-ysMaANq
X-Proofpoint-GUID: Dp_NfcHyUeSW42wsQzgJHHAi-ysMaANq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=380 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPM is not supported in Rainier, remove the TPM device.

Lakshmi Yadlapati (1):
  ARM: dts: aspeed: Rainier: Remove TPM device

 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.37.2

