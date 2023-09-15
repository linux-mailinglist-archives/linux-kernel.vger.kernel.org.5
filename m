Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D907A17E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjIOICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjIOICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:02:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37871998
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:02:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bee08c13aso19627487b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694764932; x=1695369732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nYHOLD3pC1ETWfuw0uWECAQ4XpRjNOYMe7pbZvIcA3Y=;
        b=XJQCaoN0KcwY+7BwYotsvDSK76B/0eu03bH8/9JGtpJ7BAEfQvWhWN4EaybjHvq3QQ
         c+EcTl7towL+8bjQ94gNTj50RI09Vrdy2R5KlkXQ6L9hqWIqw3Fcd27lCmz9hkCFSyr1
         ykRA9ZNCf1maX4b7MtlQXzCwkQe3TD1VrcZKpz/JOjVLZvVFegGgolAcnU0fpIzKthB2
         +pe5Zate8eDUER1dobjPIyAhJlv53OPti5m5nZuG1m99MVUm2BWA/DefLLTCG+qC56e1
         FU8jMVD+1zGpBiyyP59cwVLcRnSTiZz24aiT7JtMp9ppkm1vzEtqaggWDbq5Dm8myuck
         hZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694764932; x=1695369732;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYHOLD3pC1ETWfuw0uWECAQ4XpRjNOYMe7pbZvIcA3Y=;
        b=ES8NGbS7ZRE0RFD98eYPfk9VRE21rXx8T8wwl/qbm3KsnGuiw017+2ee04POcI6G1a
         mtu154MIuE12rMP+UGevT/v0SCnrrzOA8lfI8FbTLbjI/cSL3A+RuSTXussB0Ks5Eriq
         DmnoUsDfrlxvCIb51oCEANtqAWF3x83oZLHXe1cEc1TIOpQYLfhWeKt9PUJyH13gCABo
         PY6DPzrEJYeMRNjXO1xkcBlpSsVQjHr838JudBQx/zyQlENqubxJTi0gOrZoxac9vqyc
         gb1KAwrKOa6azXmp0uA8hgblsedTxDy/ftCNOMZ8wZ/VZ/cQxPx/xN3mzgelV7lzF9Xz
         L3fA==
X-Gm-Message-State: AOJu0YxdVSmlvejOOJHEau4jNTW6iNMFF6w8lDO1M5wvnFoGZZZua4Vn
        0mvnk2LJtmTCh64EK6XK7WSAdaegGG5Gm0Wd58Y=
X-Google-Smtp-Source: AGHT+IEBkVpfnKY2Kc1b5lhLbb3lUeKAdHI9zibbYxgIirsFQzqmlHQnNu7KDmP9DNW9umpoOOkxO7YqWTCOMv1mW3w=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a81:ae25:0:b0:58c:b45f:3e94 with SMTP
 id m37-20020a81ae25000000b0058cb45f3e94mr19665ywh.8.1694764932176; Fri, 15
 Sep 2023 01:02:12 -0700 (PDT)
Date:   Fri, 15 Sep 2023 08:02:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915080204.2701640-1-aniketmaurya@google.com>
Subject: [RFC] i3c: master: Simplify table prep for ENTDAA
From:   Aniket <aniketmaurya@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before ENTDAA, device address table is populated with
the dynamic addresses to be assigned to the discovered
devices.
Since these addresses are referenced using consecutive
indices of the table, simply get indices starting
from the last unused position of free_pos. Subsequent
positions are expected to be empty.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 The current way of preparing table seems unnecessarily compilcated.
 The device table index is incremented one by one, so we anyways assume
 that all positions are empty after the last occupied one. So we can
 omit those checks.
 drivers/i3c/master/dw-i3c-master.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9332ae5f6419..dbbc96bc1587 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -782,17 +782,15 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	struct dw_i3c_xfer *xfer;
 	struct dw_i3c_cmd *cmd;
-	u32 olddevs, newdevs;
 	u8 p, last_addr = 0;
-	int ret, pos;
+	int ret, pos, start_idx, end_idx;
 
-	olddevs = ~(master->free_pos);
+	start_idx = dw_i3c_master_get_free_pos(master);
+	if (start_idx < 0)
+		return start_idx;
 
 	/* Prepare DAT before launching DAA. */
-	for (pos = 0; pos < master->maxdevs; pos++) {
-		if (olddevs & BIT(pos))
-			continue;
-
+	for (pos = start_idx; pos < master->maxdevs; pos++) {
 		ret = i3c_master_get_free_addr(m, last_addr + 1);
 		if (ret < 0)
 			return -ENOSPC;
@@ -811,15 +809,10 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	if (!xfer)
 		return -ENOMEM;
 
-	pos = dw_i3c_master_get_free_pos(master);
-	if (pos < 0) {
-		dw_i3c_master_free_xfer(xfer);
-		return pos;
-	}
 	cmd = &xfer->cmds[0];
 	cmd->cmd_hi = 0x1;
-	cmd->cmd_lo = COMMAND_PORT_DEV_COUNT(master->maxdevs - pos) |
-		      COMMAND_PORT_DEV_INDEX(pos) |
+	cmd->cmd_lo = COMMAND_PORT_DEV_COUNT(master->maxdevs - start_idx) |
+		      COMMAND_PORT_DEV_INDEX(start_idx) |
 		      COMMAND_PORT_CMD(I3C_CCC_ENTDAA) |
 		      COMMAND_PORT_ADDR_ASSGN_CMD |
 		      COMMAND_PORT_TOC |
@@ -829,13 +822,10 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
 		dw_i3c_master_dequeue_xfer(master, xfer);
 
-	newdevs = GENMASK(master->maxdevs - cmd->rx_len - 1, 0);
-	newdevs &= ~olddevs;
+	end_idx = master->maxdevs - cmd->rx_len;
 
-	for (pos = 0; pos < master->maxdevs; pos++) {
-		if (newdevs & BIT(pos))
-			i3c_master_add_i3c_dev_locked(m, master->devs[pos].addr);
-	}
+	for (pos = start_idx; pos < end_idx; pos++)
+		i3c_master_add_i3c_dev_locked(m, master->devs[pos].addr);
 
 	dw_i3c_master_free_xfer(xfer);
 
-- 
2.42.0.459.ge4e396fd5e-goog

