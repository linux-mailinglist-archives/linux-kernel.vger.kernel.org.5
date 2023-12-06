Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7707F807C3B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379788AbjLFXRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379631AbjLFXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:17:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8979D68
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:17:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250AC433C9;
        Wed,  6 Dec 2023 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701904657;
        bh=xHlmGR20SCrHf8Fi+WuUdvFz6wf3sL0KK/pWnjjJEHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1v/QW/16H+qXUvY+0BysMSAcM1TrX8UQoPoodoywnixyHSWOX0FleDPIUyTbzsKh
         Fdp39iypGh5vfvEkubP/VBns0GzPnRPHZx67aEAdvYBFhmlZz3/3aRgNoH23J5JdI6
         mIOPe9o9uqQihp3rNJwVvQVYCgyYzDHqyqdL73IZPu0Svyx+c9PkqQUM9YH1Gny9Ly
         WKTYtGbmr+Sb9SlWp5+VcnH+98sqWoa6swfZmd1yE5D4b7cXKmv2ZG629mYM7Cgi0P
         +Wcg66LT40iYTvGlAFr51Jk5G/BWc8GgtlMPMwAX3CWAN4Gahea5lP7S9dYMEsZkEa
         fATtFkcS851Iw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sen Chu <sen.chu@mediatek.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 8/8] spmi: mediatek: add device id check
Date:   Wed,  6 Dec 2023 15:17:31 -0800
Message-ID: <20231206231733.4031901-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231206231733.4031901-1-sboyd@kernel.org>
References: <20231206231733.4031901-1-sboyd@kernel.org>
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

From: Sen Chu <sen.chu@mediatek.com>

Add device id check for spmi write API.

Signed-off-by: Sen Chu <sen.chu@mediatek.com>
Link: https://lore.kernel.org/r/20230518040729.8789-1-sen.chu@mediatek.com
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-mtk-pmif.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index cc660da6a037..5079442f8ea1 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -384,6 +384,12 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	u32 data, wdata, cmd;
 	unsigned long flags;
 
+	/* Check for argument validation. */
+	if (unlikely(sid & ~0xf)) {
+		dev_err(&ctrl->dev, "exceed the max slv id\n");
+		return -EINVAL;
+	}
+
 	if (len > 4) {
 		dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, but:%zu requested", len);
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

