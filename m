Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E092798780
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbjIHM7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243410AbjIHM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:59:33 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73B71FD8;
        Fri,  8 Sep 2023 05:59:25 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 388AY4Ew022890;
        Fri, 8 Sep 2023 08:58:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3sycfuqtjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:58:56 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 388CsWYv028495;
        Fri, 8 Sep 2023 08:58:55 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3sycfuqtj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 08:58:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 388CwsHl034591
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Sep 2023 08:58:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 8 Sep 2023
 08:58:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Sep 2023 08:58:53 -0400
Received: from debian.ad.analog.com ([10.48.65.137])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 388CwW6g008873;
        Fri, 8 Sep 2023 08:58:35 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Lennart Franzen <lennart@lfdomain.com>,
        <netdev@vger.kernel.org>
Subject: [net] net:ethernet:adi:adin1110: Fix forwarding offload
Date:   Fri, 8 Sep 2023 15:58:08 +0300
Message-ID: <20230908125813.1715706-1-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _HiZIgaNSr2uD9kivUrSlWd7IYvjb2ZL
X-Proofpoint-GUID: wcHIv9gNUWl0snVUWcd2QKSMn_wz7r-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=965 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309080120
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when a new fdb entry is added (with both ports of the
ADIN2111 bridged), the driver configures the MAC filters for the wrong
port, which results in the forwarding being done by the host, and not
actually hardware offloaded.

The ADIN2111 offloads the forwarding by setting filters on the
destination MAC address of incoming frames. Based on these, they may be
routed to the other port. Thus, if a frame has to be forwarded from port
1 to port 2, the required configuration for the ADDR_FILT_UPRn register
should set the APPLY2PORT1 bit (instead of APPLY2PORT2, as it's
currently the case).

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 drivers/net/ethernet/adi/adin1110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 1c009b485188..ca66b747b7c5 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -1387,3 +1387,3 @@ static int adin1110_fdb_add(struct adin1110_port_priv *port_priv,
 	other_port = priv->ports[!port_priv->nr];
-	port_rules = adin1110_port_rules(port_priv, false, true);
+	port_rules = adin1110_port_rules(other_port, false, true);
 	eth_broadcast_addr(mask);
-- 
2.39.2

