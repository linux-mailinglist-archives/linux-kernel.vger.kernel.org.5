Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFAC77F510
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350241AbjHQLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350236AbjHQLY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:24:27 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2132D61;
        Thu, 17 Aug 2023 04:24:25 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H3ZFuS017346;
        Thu, 17 Aug 2023 04:24:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Cm5ET/zQ5LW1F23s9rWWuJVG7OKW3B4iSmqVn85MD2o=;
 b=ThpQHqR+VOa4wuqKCWievkh4V3IdhWGHro0qQ8vsDoRLXYvu9tgjbFBVHiJsG6IOQEMx
 Pk8GNtdsqyOZY5hkMc0PtbINAKcN9cbpxAEwbs9GyBOolWWQpa1QF47f2KOesZNyDOIM
 lhSY/KCc4s8mwPmTk25Uh5vps2AIkM2ZyxPbrdBzX88HfUx/rFER0DxJ9aoVFbo998a/
 Wttxs8uInOFlDDi7vRMDm6pQlcZdofmgbGI5t85xONCKIRU+Clc08aYcooDEsJL4nKM0
 cCfMfQu1Gz8XsLtZbdQfeWrczVmXIwKsH1lEi2g3OgEm6/wNmrigGW8sODUOGpROagli 8g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sgptkwmg3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 04:24:18 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 04:24:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 17 Aug 2023 04:24:14 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 1628C3F7054;
        Thu, 17 Aug 2023 04:24:09 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next Patch 1/5] octeontx2-af: CN10KB: Add USGMII LMAC mode
Date:   Thu, 17 Aug 2023 16:53:53 +0530
Message-ID: <20230817112357.25874-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817112357.25874-1-hkelam@marvell.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WFzP3NPP-FjcP29yfLtUANZGF-ZQsg95
X-Proofpoint-GUID: WFzP3NPP-FjcP29yfLtUANZGF-ZQsg95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon physical link change, firmware reports to the kernel about the
change along with the details like speed, lmac_type_id, etc.
Kernel derives lmac_type based on lmac_type_id received from firmware.

This patch extends current lmac list with new USGMII mode supported
by CN10KB RPM block.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 988383e20bb8..9392ef95a245 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -55,6 +55,7 @@ static const char *cgx_lmactype_string[LMAC_MODE_MAX] = {
 	[LMAC_MODE_50G_R] = "50G_R",
 	[LMAC_MODE_100G_R] = "100G_R",
 	[LMAC_MODE_USXGMII] = "USXGMII",
+	[LMAC_MODE_USGMII] = "USGMII",
 };
 
 /* CGX PHY management internal APIs */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
index 574114179688..6f7d1dee5830 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.h
@@ -110,6 +110,7 @@ enum LMAC_TYPE {
 	LMAC_MODE_50G_R		= 8,
 	LMAC_MODE_100G_R	= 9,
 	LMAC_MODE_USXGMII	= 10,
+	LMAC_MODE_USGMII	= 11,
 	LMAC_MODE_MAX,
 };
 
-- 
2.17.1

