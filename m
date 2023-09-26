Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593677AE7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjIZIOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjIZIOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:14:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579A97
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:14:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B19C433CA;
        Tue, 26 Sep 2023 08:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716039;
        bh=Zj1LbCF+4qNSxbYeKTNC7s+VtkpmrrJmwaIr6viPOS0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NKwBwIkX+PbX7WRGiC1ezRUi5L+rofVbX4/U24pNvcZ2r9nDoOx+LTRwfW780fY9e
         OoiLolkibQYzcRwLH1E59VLwEI6Y5pTX7D+mPvNI/Ja9Wd45i1jOzfJTdeWF/R3SnX
         +iqWMcWfhlTdcHMtCIt9pf7QXDJwhWDHVNZR07JB9RsOqfWYEFPF9SYs8e1nSOGO0R
         xzHznsW/zcHX0kOrOugdpEueLZT54pcauYOlE8lT6178YtxXeJaX1BTlgvMWTWWKRJ
         ZkkIAnImLR+CbArfkFJn0SDEMcvnfe+4dCa/YsB9+bqEZwYl/oKSdmluQCymArjjQ7
         wJNGz4pF0MM2w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] accel/habanalabs/gaudi: remove define used for simulator
Date:   Tue, 26 Sep 2023 11:13:44 +0300
Message-Id: <20230926081345.240927-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926081345.240927-1-ogabbay@kernel.org>
References: <20230926081345.240927-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't support simulator in upstream.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h | 2 --
 drivers/accel/habanalabs/gaudi/gaudi.c       | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index b1b1c51aa5b1..a8ccc04e7f92 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -85,8 +85,6 @@ struct hl_fpriv;
 
 #define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
 
-#define HL_SIM_MAX_TIMEOUT_US		100000000 /* 100s */
-
 #define HL_INVALID_QUEUE		UINT_MAX
 
 #define HL_COMMON_USER_CQ_INTERRUPT_ID	0xFFF
diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index 31e04af46876..53292d4c15c8 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -4623,8 +4623,7 @@ static int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
 static int gaudi_scrub_device_mem(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 wait_to_idle_time = hdev->pdev ? HBM_SCRUBBING_TIMEOUT_US :
-			min_t(u64, HBM_SCRUBBING_TIMEOUT_US * 10, HL_SIM_MAX_TIMEOUT_US);
+	u64 wait_to_idle_time = HBM_SCRUBBING_TIMEOUT_US;
 	u64 addr, size, val = hdev->memory_scrub_val;
 	ktime_t timeout;
 	int rc = 0;
-- 
2.34.1

