Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF72754E1E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGPJh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPJhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 05:37:55 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE74E45;
        Sun, 16 Jul 2023 02:37:54 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G71xRc019606;
        Sun, 16 Jul 2023 02:37:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=u3UVgM7x4wqx72JKmwETgwQbtQ4974KGNu1bjFcRfuw=;
 b=i6ZB06yQ3/eZu/aTesEH+z7Br5RPXApFMSVOzjrmLfi5Ixf8isksBGogYLhjbXDPzRBM
 T96AZVlU03ySiQgU9ZKL6fvlEKx6kts0Bz0R+Gy//1z4BRVm0yRobVeKuCsI5Blf14SJ
 9XPWw2y5hQgH7w+BCQBMO+r6UIr4iFQKV8ejQ0RxBDV1Q6uDT2Wje0tx66oXibHQF4qy
 Fl2BoMAk7kfBUG11amjceoTvmpeA9swsIejRhnNig6BPiOI0rjHACONFOnL6T+aTIwBm
 Ef3mwR0d0Yaf3+wXBUcwnO1dmfUKra2dOEkhi0vDj1W0ZbnA3/IdkzjJkDxohpKjUgfG lw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rutygsmgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 02:37:47 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 16 Jul
 2023 02:37:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 16 Jul 2023 02:37:45 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 91A275E686A;
        Sun, 16 Jul 2023 02:37:42 -0700 (PDT)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-pf: Dont allocate BPIDs for LBK interfaces
Date:   Sun, 16 Jul 2023 15:07:41 +0530
Message-ID: <20230716093741.28063-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 7ShzuYIFd5bswaevYpk2JoVeC0DorjhH
X-Proofpoint-ORIG-GUID: 7ShzuYIFd5bswaevYpk2JoVeC0DorjhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver enables backpressure for LBK interfaces.
But these interfaces do not support this feature.
Hence, this patch fixes the issue by skipping the
backpressure configuration for these interfaces.

Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index fe8ea4e531b7..9551b422622a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1454,8 +1454,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	if (err)
 		goto err_free_npa_lf;
 
-	/* Enable backpressure */
-	otx2_nix_config_bp(pf, true);
+	/* Enable backpressure for CGX mapped PF/VFs */
+	if (!is_otx2_lbkvf(pf->pdev))
+		otx2_nix_config_bp(pf, true);
 
 	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
 	err = otx2_rq_aura_pool_init(pf);
-- 
2.25.1

