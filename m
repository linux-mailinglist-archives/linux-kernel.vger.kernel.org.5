Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127180A36D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573742AbjLHMhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573740AbjLHMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:37:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D661E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:37:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FE1C433C7;
        Fri,  8 Dec 2023 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702039042;
        bh=gqQmFdVmCQcNd8eKCMxCHIDAeVXnQ1wKVZgIjb/cu7E=;
        h=From:To:Cc:Subject:Date:From;
        b=rGRLCeNzGWF3GpJdrEeFpcxOAAO3hSBToCupmGi0kWqtNUDaK5uGOOum3/+R1nCIG
         M21XLvFvzPQV0ZKl7Jptqcb67rDybpXqqQSgESiZjyKnhkEskWo8suGEWt6v3p6E5x
         n/X7wP1pd+75peLzsXgV0mPX/Qo1uyIl2c0yZYA30n4Rt57/0Qptu4Xf7jYFDLpp30
         jT4cKNTdm5DP7S8ZneFs98UKXRVhnDCaowJZax3Uueqg57fL1MqwkWQoGp7rm4HKBs
         tKeWMP1ybW4TtBCJq7fcEG9t7g7zl/MfIXByv4Wva7GlYSk38LyyI0EbtdErq3rBml
         EIClylnvCZCjw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rBa7P-0007o9-1V;
        Fri, 08 Dec 2023 13:38:12 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] usb: typec: ucsi: fix gpio-based orientation detection
Date:   Fri,  8 Dec 2023 13:36:02 +0100
Message-ID: <20231208123603.29957-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the recently added connector sanity check which was off by one and
prevented orientation notifications from being handled correctly for the
second port when using GPIOs to determine orientation.

Fixes: c6165ed2f425 ("usb: ucsi: glink: use the connector orientation GPIO to provide switch events")
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

I found this one through inspection when skimming the driver.

Johan


 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index db6e248f8208..4853141cd10c 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -228,7 +228,7 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 
 	con_num = UCSI_CCI_CONNECTOR(cci);
 	if (con_num) {
-		if (con_num < PMIC_GLINK_MAX_PORTS &&
+		if (con_num <= PMIC_GLINK_MAX_PORTS &&
 		    ucsi->port_orientation[con_num - 1]) {
 			int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
 
-- 
2.41.0

