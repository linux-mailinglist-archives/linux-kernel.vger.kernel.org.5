Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55905798F97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344929AbjIHTdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjIHTdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:33:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCAF2132;
        Fri,  8 Sep 2023 12:32:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A19C43397;
        Fri,  8 Sep 2023 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201529;
        bh=Ge+4fWFayUbITINuJLiw6XbxOHKzoUCdo4Ja6QrasUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyCC004oNi5VcPbauASoz4ZOrVHGxyd0aH+i7boLKCPRhIIYbDL+99/fmx3YIixB1
         Nr5EYWvJE8lDkeYwzCzcHS1Ph34LSsciFx7i6pQSbQYNGuGpW4b7WO5uOOU0K4uq7m
         sdky45hcmpFeptZV4Yr8kUTiquA8MAXbsuPXOD7d58KKY7h7EkVmdLoXsIZWUg6Lr8
         TeZo0AeWLLz8KKAeEJhCFqWMaxAsXFSwX506PQyEvXXHc9E5WksO32bFVY0dmpEXSP
         vS2dZAjdwYzx1aZ/+AYBkqa4a/sU8rYv5S0ysVSX+RMfq7TJD+JJ52pC0MdUNxWpYN
         qbHLoxiBsGLyg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sasha Levin <sashal@kernel.org>, inki.dae@samsung.com,
        m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 03/31] drm: bridge: samsung-dsim: Drain command transfer FIFO before transfer
Date:   Fri,  8 Sep 2023 15:31:32 -0400
Message-Id: <20230908193201.3462957-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193201.3462957-1-sashal@kernel.org>
References: <20230908193201.3462957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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
index 3194cabb26b32..891ec0245a910 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -932,7 +932,7 @@ static int samsung_dsim_wait_for_hdr_fifo(struct samsung_dsim *dsi)
 	do {
 		u32 reg = samsung_dsim_read(dsi, DSIM_FIFOCTRL_REG);
 
-		if (!(reg & DSIM_SFR_HEADER_FULL))
+		if (reg & DSIM_SFR_HEADER_EMPTY)
 			return 0;
 
 		if (!cond_resched())
-- 
2.40.1

