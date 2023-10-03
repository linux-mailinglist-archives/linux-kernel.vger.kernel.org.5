Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28D7B6B07
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbjJCOHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbjJCOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:07:11 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C5AAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:07:07 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 393A7Dgf022752;
        Tue, 3 Oct 2023 16:06:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=U4vOdxSVlfELSeNY+vE9G1cuY4dw0I2hF391/hYQ6S0=; b=Zm
        xKyRlusO9cW0t9nMM5vjA/OLmoubXMVe281sYtDf6Wya/zUime6fD6zJ9bOGP2fE
        NRsqcJEyqXVm0ydD90RBQbJZvHWJu4fyKEfhQBIrAuybNiLP4H6FUVWPzXYCpZsf
        7V5dpWK/NYl4pr79x+QhMiC4S/SG+PZdt99bkTmMrjWFvMJuRNDQI6/CTfVAv20q
        7D/ToxEvzmg4g8Sy7FHFvCUdhL7ppE1EBs2y1Ntcp+WFGIyD4FnceL5DReRjeqlC
        kt857D9Q8H0lU7nEtFZ0nNHAeChDrS9nHXLjX9pCCtkTdugtCIQ/yUVhUzMZ79q/
        4yYrSPfqHfMfJHoT9/oQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tggx31460-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 16:06:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AD44100057;
        Tue,  3 Oct 2023 16:06:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D731F2634FA;
        Tue,  3 Oct 2023 16:06:49 +0200 (CEST)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 16:06:49 +0200
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <op-tee@lists.trustedfirmware.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v10 4/4] firmware: arm_scmi: optee: use optee system invocation
Date:   Tue, 3 Oct 2023 16:06:37 +0200
Message-ID: <20231003140637.31346-5-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003140637.31346-1-etienne.carriere@foss.st.com>
References: <20231003140637.31346-1-etienne.carriere@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_11,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes SCMI optee transport to call tee_client_system_session()
to request optee driver to provision an entry context in OP-TEE
for processing OP-TEE messages. This prevents possible deadlock
in case OP-TEE threads are all consumed while these may be waiting
for a clock or regulator to be enable which SCMI OP-TEE service which
requires a free thread context to execute.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
Changes since v9:
- Applied Sumit R-b tag:
  https://lore.kernel.org/lkml/CAFA6WYMyJrW25sdZRkQHDje72+tLDw4T+bjB6tmVf8XH0De1RQ@mail.gmail.com/
- Added Cc: tags and updated my e-mail address.

No change since v8
No change since v7
No change since v6

Changes since v5:
- Applied Sudeep's review tag

Changes since v4:
- Updated to new API function tee_client_system_session() introduced
  in patch v5 2/3.

No change since v3

Changes since v2:
- Fixed syntax issues (missing ';' chars), reported by kernel test robot.

Changes since v1:
- Updated to use new tee API functions tee_client_request_system_context()
  and tee_client_release_system_context().
---
 drivers/firmware/arm_scmi/optee.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index e123de6e8c67..25bfb465484d 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -440,6 +440,10 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *de
 	if (ret)
 		goto err_free_shm;
 
+	ret = tee_client_system_session(scmi_optee_private->tee_ctx, channel->tee_session);
+	if (ret)
+		dev_warn(dev, "Could not switch to system session, do best effort\n");
+
 	ret = get_channel(channel);
 	if (ret)
 		goto err_close_sess;
-- 
2.25.1

