Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE37BE82B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377887AbjJIRcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377487AbjJIRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457ADA;
        Mon,  9 Oct 2023 10:32:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAB7C433C7;
        Mon,  9 Oct 2023 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872739;
        bh=hEEuhVXB8jp3AkUNOcjWDBzJbGLaSJnvN8RUFaE21U4=;
        h=From:To:Cc:Subject:Date:From;
        b=TYyL+4tOoVHormNoyYzlFs41+kBwRCWzQ1RjpCVa8R+Eg8z+ly8uzQSRc3uL5AQnJ
         SS/klPxwVxHrdxfK1ahqQ83DANXbmFEl8R/W7p3FuiEjnyZWYODv7d4gwH1r5/FLYv
         tF4bUi6M2UOba1gdiXweHmR+tSF8f/5zSow2Uw1Wig+T/5qjKxkp+R6R2XEVWYX570
         3peoQs07wT4hJ4Hwm5BYBo2XcV7jeJTo+KGG4+vHAlOI0MmoO9HE5iZQuM1vZZfhxa
         ELgXzSpDY4VQ75G5HjtQAlFHxTipo1kmTUbsiDSwLQKlNYbcky6bz1I6fZtygtpSO7
         t4CC/FsPJcJ8g==
Received: (nullmailer pid 2523356 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: wireless: ath11k: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:06 -0500
Message-ID: <20231009172923.2457844-11-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 1215ebdf173a..235336ef2a7a 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -6,6 +6,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/dma-mapping.h>
@@ -1084,19 +1085,12 @@ static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
 static int ath11k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath11k_base *ab;
-	const struct of_device_id *of_id;
 	const struct ath11k_hif_ops *hif_ops;
 	const struct ath11k_pci_ops *pci_ops;
 	enum ath11k_hw_rev hw_rev;
 	int ret;
 
-	of_id = of_match_device(ath11k_ahb_of_match, &pdev->dev);
-	if (!of_id) {
-		dev_err(&pdev->dev, "failed to find matching device tree id\n");
-		return -EINVAL;
-	}
-
-	hw_rev = (uintptr_t)of_id->data;
+	hw_rev = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	switch (hw_rev) {
 	case ATH11K_HW_IPQ8074:
-- 
2.42.0

