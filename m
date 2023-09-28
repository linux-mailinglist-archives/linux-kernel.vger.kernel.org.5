Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44A67B1709
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjI1JUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjI1JUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:20:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DC28E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:20:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1222DC433C7;
        Thu, 28 Sep 2023 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695892805;
        bh=BMuxTiku+IlvNWwdHgMDtNzm/glYc+SS1e8AMX4mWDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcQuR0gUyWlSbivUkssE/B80V9GssI/Sv70+YozuQ8mwVjvvCppHi6w79RQGWwM0A
         AXrNFtz6WHErXiRxjmbS+BQomkhMwtD2/nhCPai/v0RdA7qvXrmb7lSGSIJ+bnW7tV
         8pblNnvZfW6PVrPPTSmp2phezQQges2ydSBKEzuGMjMoiBm3JFojfdKj7a57M6ewy2
         PFm33xdcHFLvd1P/WVYknIwavX2OjMngsTN5Bb/Di45039mGZW0IPE275scvjABXVj
         IzQMnpIx2IvUpCbGPUgaTZPGbDsUDDoHdCnBFC8X8UuCE1UB/itxbXPGAQAmPFzzZO
         4Cyl1INTMbrHw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 3/3] accel/habanalabs/gaudi2: perform hard-reset upon PCIe AXI drain event
Date:   Thu, 28 Sep 2023 12:19:56 +0300
Message-Id: <20230928091956.47762-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928091956.47762-1-ogabbay@kernel.org>
References: <20230928091956.47762-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

Non-completed transactions from PCIe towards the device are handled by
the AXI drain mechanism. This handling is in the PCIe level, but the
transactions are still there in the device consuming some queues
entries, and therefore the device must be reset.
Modify to perform hard-reset upon PCIe AXI drain events.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
index 57e661771b6c..b2dbe1f64430 100644
--- a/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
@@ -1293,7 +1293,7 @@ static struct gaudi2_async_events_ids_map gaudi2_irq_map_table[] = {
 		 .name = "" },
 	{ .fc_id = 631, .cpu_id = 128, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "PCIE_P2P_MSIX" },
-	{ .fc_id = 632, .cpu_id = 129, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
+	{ .fc_id = 632, .cpu_id = 129, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_HARD,
 		 .name = "PCIE_DRAIN_COMPLETE" },
 	{ .fc_id = 633, .cpu_id = 130, .valid = 1, .msg = 0, .reset = EVENT_RESET_TYPE_NONE,
 		 .name = "TPC0_BMON_SPMU" },
-- 
2.34.1

