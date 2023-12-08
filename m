Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E569C809C14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjLHF5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjLHF52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:57:28 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59D19A2;
        Thu,  7 Dec 2023 21:57:03 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B81CqNC028994;
        Thu, 7 Dec 2023 21:56:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=HEQnHUIqnjI0rxLDWe/wA9HwPEdz9nqzT9bUL9LwXow=;
 b=ZoAVrR6XhBhqwm3jZsjRCUX1EwrmtYbO3Jeam3qDhwrQy98Uw3BDTpX68yD6IRrR1Y6b
 ZKVMUKJhC9UyFjTXbH6xkqndNnfJIIyC5oUF/AkJ6/418qDFOQK5uth7GDSOQTx/OTC4
 llhbGZTf/ndsMCpYRh+p01JtniX3eu8kAaC622fwzzW3+CuVD6erGoOoGs+yP7Zm8CAR
 d7cUE2heN3K87/OmrEIM4sEprbAa81ZlxKBB8iXlsF4e1CpbSfnyUdgUjkkgfxV1kI2l
 tyB19MrPfCqn9MU+AhCytGDUw2Zn1lAmDlKjT+zbhv1uQta3vBIGf9Zm8ulcgxjGNwtF MQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uubddbuhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 21:56:55 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 21:56:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 21:56:53 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 573F63F7050;
        Thu,  7 Dec 2023 21:56:53 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>,
        "Satananda Burla" <sburla@marvell.com>
Subject: [PATCH net v3] octeon_ep: explicitly test for firmware ready value
Date:   Thu, 7 Dec 2023 21:56:46 -0800
Message-ID: <20231208055646.2602363-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ok7DybbzTglDBUek9-Dr2b8mjc3niAau
X-Proofpoint-GUID: ok7DybbzTglDBUek9-Dr2b8mjc3niAau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware ready value is 1, and get firmware ready status
function should explicitly test for that value. The firmware
ready value read will be 2 after driver load, and on unbind
till firmware rewrites the firmware ready back to 0, the value
seen by driver will be 2, which should be regarded as not ready.

Fixes: 10c073e40469 ("octeon_ep: defer probe if firmware not ready")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Removed unnecessary parenthesis around boolean return.

V2: https://lore.kernel.org/all/20231207074936.2597889-1-srasheed@marvell.com/
  - Fixed redundant logic

V1: https://lore.kernel.org/all/20231206063549.2590305-1-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 552970c7dec0..b8ae269f6f97 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1258,7 +1258,8 @@ static bool get_fw_ready_status(struct pci_dev *pdev)
 
 		pci_read_config_byte(pdev, (pos + 8), &status);
 		dev_info(&pdev->dev, "Firmware ready status = %u\n", status);
-		return status;
+#define FW_STATUS_READY 1ULL
+		return status == FW_STATUS_READY;
 	}
 	return false;
 }
-- 
2.25.1

