Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E57E55A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbjKHLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjKHLfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:35:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B17186;
        Wed,  8 Nov 2023 03:35:18 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8Ax01X016951;
        Wed, 8 Nov 2023 11:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UeT9yNcWappliLtJ3N08X4ymwKwY56nnVJvuLu86Aks=;
 b=dQvDlfxihh22f5670eBIp7WAX2qQcAB/swVAw9pxQdhCTZl1T5nF91NmSQl7R4ncMb5s
 d8DDw8Dm/j4xz44VtFgrlvWZi+6pjVBhydhJInozXUrq89WFfxr88ondp6NPpGo88FdV
 dZRFaWglH30BKnusMFqqIuR0F6gH1rfYdxVJ6ZTqDMz7NbEUJULYVPc65+HCGFonAwaT
 O8nzI1aSOa+yMZv13U9Nryr+PJeogfb+aNvlwufXtemxERCuG5pBN70s7SuADPO/eksr
 VPCKxlDLIU8600VAHN0Rs5taCsv+WKikTcuiD6LboJ4XJdXuKqt0VSoFRJ3HOJKaZU0/ xA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7wt29crx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 11:35:03 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A8BZ2ic032213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 11:35:02 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 03:35:00 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] add qca8084 ethernet phy driver
Date:   Wed, 8 Nov 2023 19:34:42 +0800
Message-ID: <20231108113445.24825-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aBeikOUZ9fktA1YnNnXNLNpJ8mXLbbg-
X-Proofpoint-GUID: aBeikOUZ9fktA1YnNnXNLNpJ8mXLbbg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=588
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA8084 is four-port PHY with maximum link capability 2.5G,
which supports the interface mode qusgmii and sgmii mode,
there are two PCSs available to connected with ethernet port.

QCA8084 can work in switch mode or PHY mode.
For switch mode, both PCS0 and PCS1 work on sgmii mode.
For PHY mode, PCS1 works on qusgmii mode, the last port
(the fourth port) works on sgmii mode.

Besides this PHY driver patches, the PCS driver is also needed
to bring up the qca8084 device, which mainly configurs PCS
and clocks.

Luo Jie (3):
  net: phy: at803x: add QCA8084 ethernet phy support
  net: phy: at803x: Add qca8084_config_init function
  net: phy: qca8084: add qca8084_link_change_notify

 drivers/net/phy/at803x.c | 112 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)


base-commit: 2220f68f4504aa1ccce0fac721ccdb301e9da32f
-- 
2.42.0

