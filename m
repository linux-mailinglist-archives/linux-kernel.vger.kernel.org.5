Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F02798F07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjIHT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbjIHT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:28:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CDC8E;
        Fri,  8 Sep 2023 12:28:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AB6C433C8;
        Fri,  8 Sep 2023 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201335;
        bh=4Vb0O7tEAtwagkbyHbC6dQRhTxZ9MQuRYeS7RYl8Q9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpPSXCAmY+WBbahyVnv3n+0YzS66ASxAhbCp38d2SMU6WXZMKAFNy8pcwHHKC4hDB
         fuNMazIV4u7zJ0KVZpD+6D5Hzc6tx12h3arGw5+ynognDDBYo4mid+s4MSLRiPpCZa
         2TuCDZpHMTBLC+LGQNcVdTBHznTixPnJCMqpDHZWJmeeh5nNIwK9D07on07jeEpix5
         JdAx8uAjDd5U8m4eD3IJRPlnad0W3Uwhjnn+gQyDVdYtge7XGgYMpLHcRcNaGw927X
         Y1cqILveMbu/XylE2yIBxVxCpUZ39hMLq5lBpIe8HKWuLy3P0sGFlvckDsY0eyptQU
         rV55kRu8a93yw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sasha Levin <sashal@kernel.org>, inki.dae@samsung.com,
        m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 03/36] drm: bridge: samsung-dsim: Drain command transfer FIFO before transfer
Date:   Fri,  8 Sep 2023 15:28:14 -0400
Message-Id: <20230908192848.3462476-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 14806c6415820b1c4bc317655c40784d050a2edb ]

Wait until the command transfer FIFO is empty before loading in the next
command. The previous behavior where the code waited until command transfer
FIFO was not full suffered from transfer corruption, where the last command
in the FIFO could be overwritten in case the FIFO indicates not full, but
also does not have enough space to store another transfer yet.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
Link: https://patchwork.freedesktop.org/patch/msgid/20230615201511.565923-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 73ec60757dbcb..9e253af69c7a1 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1009,7 +1009,7 @@ static int samsung_dsim_wait_for_hdr_fifo(struct samsung_dsim *dsi)
 	do {
 		u32 reg = samsung_dsim_read(dsi, DSIM_FIFOCTRL_REG);
 
-		if (!(reg & DSIM_SFR_HEADER_FULL))
+		if (reg & DSIM_SFR_HEADER_EMPTY)
 			return 0;
 
 		if (!cond_resched())
-- 
2.40.1

