Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D009A7B1E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjI1NZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjI1NZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:25:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CF19E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:25:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6257AC433C7;
        Thu, 28 Sep 2023 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907532;
        bh=kpXvGHsuIpubDwPWsxG1yKQwQdGOQjiLynpABCN6ypU=;
        h=From:To:Subject:Date:From;
        b=fXBHJkpg6i2vDlJs6D+QionODnpVKu+usgloZeLW0L2Txuv9YlLZd7yOog7ppUx4L
         xzb/A9KwCQij8xikHNRhKT6EKGzwYSreE51opSG0oE9oG9cfqbywzWcY3dOHpDAySI
         bw/G3S7WX8+MrVDEAM7qCVqyZWJaYTSgHCnXfUChGdXuQyci0/9Lv7Tuxf2xt3ZUFm
         tYlfPNQDNS/Lego09QsnN5mSjOf40GDRraRcpLGjDIXVPwPK2grdu6N64SIRjXGoGi
         7F5fWcRtwAvNf839zh9IygyCjU4uH0SZGlRoAiHSP9KnSPlghFIT/Si05s58d1o3F9
         ig8oNsL2/B4ig==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] accel/habanalabs/gaudi2: fix spmu mask creation
Date:   Thu, 28 Sep 2023 16:25:27 +0300
Message-Id: <20230928132527.89451-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
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

event_types_num received from the user can be 0. In that case, the
event_mask should be 0.

In addition, to create a correct mask we need to match the number
of event types to the bit location such that bit 0 represents a single
event type, bit 1 represents 2 types and so on.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c b/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c
index 14a855cdc96b..2423620ff358 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c
@@ -2500,7 +2500,8 @@ static int gaudi2_config_spmu(struct hl_device *hdev, struct hl_debug_params *pa
 		 * set enabled events mask based on input->event_types_num
 		 */
 		event_mask = 0x80000000;
-		event_mask |= GENMASK(input->event_types_num, 0);
+		if (input->event_types_num)
+			event_mask |= GENMASK(input->event_types_num - 1, 0);
 
 		WREG32(base_reg + mmSPMU_PMCNTENSET_EL0_OFFSET, event_mask);
 	} else {
-- 
2.34.1

