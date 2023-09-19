Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922BB7A6352
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjISMml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjISMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:42:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4A799;
        Tue, 19 Sep 2023 05:42:31 -0700 (PDT)
Received: from mercury (dyndsl-091-248-212-118.ewe-ip-backbone.de [91.248.212.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1585F66030BF;
        Tue, 19 Sep 2023 13:42:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695127350;
        bh=w2VcAcMkxLks9jiD73Z3mgV3/9YOXxzVvLTa256WXS0=;
        h=From:To:Cc:Subject:Date:From;
        b=k5FzJThkM+6CtrIb0jRFjbILwmasCZsobdDhD/p4pP7MsSUtEOIDpxGELPapUvq12
         iVtaJ3BYgdUCiRacVbAQLK/u+yRjHvnMp3Uv95/Y3PTWf58pOgFFw6myN8mKuLqXxm
         ioIQo9m7T1X3GU1Iw3VqtMv5rugI53fXAosVZAgrvGU3TrIzbpD3ITbULZlRNSjVyL
         skFUsgd2mJB0UDb4kJz//l5FSAeYep3sCDOdukAz4fEuYTMQDJ4g43Q9lXbj56KaIu
         lXEjFPw1wDX5aZS3OPU187de0L4Z+/tP4Xbey5zfpxrUoE3Pw7GZsXsVgWr9eFCSYy
         bDIO8Tii/V9nQ==
Received: by mercury (Postfix, from userid 1000)
        id 7AF8E10604FC; Tue, 19 Sep 2023 14:42:27 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] power: supply: qcom_battmgr: fix battery_id type
Date:   Tue, 19 Sep 2023 14:42:22 +0200
Message-Id: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_battmgr_update_request.battery_id is written to using cpu_to_le32()
and should be of type __le32, just like all other 32bit integer requests
for qcom_battmgr.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309162149.4owm9iXc-lkp@intel.com/
Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/qcom_battmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index de77df97b3a4..a05fd00711f6 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -105,7 +105,7 @@ struct qcom_battmgr_property_request {
 
 struct qcom_battmgr_update_request {
 	struct pmic_glink_hdr hdr;
-	u32 battery_id;
+	__le32 battery_id;
 };
 
 struct qcom_battmgr_charge_time_request {
-- 
2.40.1

