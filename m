Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69A75C272
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGUJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjGUJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:06:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05730C1;
        Fri, 21 Jul 2023 02:06:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMVun001996;
        Fri, 21 Jul 2023 09:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=YB3+L26ub9a+qZKv1httf41gShc8qMgp1o2GqmrvXwk=;
 b=lIQUlM5s4RByMw5LwdenicUoeV5Pivu1dSJrUYYzF3ZbHgYRIMp884wwwnJy09x6UlSx
 8OAbACFNP5HYpmkp9eSA6+fPCTopbPqe4Ba7HjnIxf/Ka98ebFKhaLk3FSXOmulfFMyg
 uJofxcwK8MA5VV5vp4ep5uVDoP5QUUYMML2TzArQkp11O2knTHV0+9vWu7RqB7uRd5ul
 RJHONygHmw5uzZmQ9JqzQFXaduY7ma3SmwQPHPDJCb2xN6mP/BFeOQeQr+tnwMPfOIlI
 i5adqE1VLT+IGzPZrrlECNLzRu3oEysOa8ZpsPdtMmwHFX4AXuNkP28ydzlXuRMx0zWL Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run773huq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 09:06:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36L84IH4000832;
        Fri, 21 Jul 2023 09:06:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw9snxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 09:06:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36L963fv036820;
        Fri, 21 Jul 2023 09:06:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw9snvk-1;
        Fri, 21 Jul 2023 09:06:03 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        David Yang <mmyangfl@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Pengcheng Li <lpc.li@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, christophe.jaillet@wanadoo.fr,
        julia.lawall@inria.fr, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: [PATCH] phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()
Date:   Fri, 21 Jul 2023 02:05:55 -0700
Message-ID: <20230721090558.3588613-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_05,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210081
X-Proofpoint-GUID: MsdSk9BPopQYkgz-7sX5dUtYzmn80bqo
X-Proofpoint-ORIG-GUID: MsdSk9BPopQYkgz-7sX5dUtYzmn80bqo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of array 'priv->ports[]' is INNO_PHY_PORT_NUM.

In the for loop, 'i' is used as the index for array 'priv->ports[]'
with a check (i > INNO_PHY_PORT_NUM) which indicates that
INNO_PHY_PORT_NUM is allowed value for 'i' in the same loop.

This > comparison needs to be changed to >=, otherwise it potentially leads
to an out of bounds write on the next iteration through the loop

Fixes: ba8b0ee81fbb ("phy: add inno-usb2-phy driver for hi3798cv200 SoC")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is purely based on static analysis, only compile tested.

Inspired based on a patch from Christophe Jaillet:
https://lore.kernel.org/all/cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr/
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index 498afd81696b..c138cd4807d6 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -185,7 +185,7 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, &priv->ports[i]);
 		i++;
 
-		if (i > INNO_PHY_PORT_NUM) {
+		if (i >= INNO_PHY_PORT_NUM) {
 			dev_warn(dev, "Support %d ports in maximum\n", i);
 			of_node_put(child);
 			break;
-- 
2.39.3

