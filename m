Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBB75E80C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGXBhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGXBgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:36:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A11BC0;
        Sun, 23 Jul 2023 18:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9122360FAB;
        Mon, 24 Jul 2023 01:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D79C433C8;
        Mon, 24 Jul 2023 01:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162313;
        bh=SQAM2L3JQPA6mYdvL8zQwXPMB2kLpBmxl887lyvs2n4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O89wKNr3uYFc7vShM0sd+CTIhBkCncZWDPX8KMi5aqFeX7dvqAIPR3hj+Anr3ncam
         ZWoYEl/7NN6jGSe3RD2lG+Okkc0mz6ylvJYdxx+rFxIzCGBIDe0OuQrGm5nJLjGWG3
         TPILEk8vcTYvlhPspjCXktX/w+XJLJ5jocZgL/TSVsMIYoceacDj7BnjhR9cZAin6h
         VD3jEiits5NzT9mueEp74fMUQviKTNpL1V5Smo5LxISEi8idRH8uV2e19vVSYoFEf0
         U5q6ot/CHDKRQNh5WInSYnkxTYVqDWjPC+JQPlWSw7aTYDECf6HXIwkce1vQ1r5Bcg
         qMswGImTl+2TA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com, yehezkel.bernat@intel.com
Subject: [PATCH AUTOSEL 6.4 08/40] thunderbolt: Read retimer NVM authentication status prior tb_retimer_set_inbound_sbtx()
Date:   Sun, 23 Jul 2023 21:31:08 -0400
Message-Id: <20230724013140.2327815-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 1402ba08abae5cfa583ff1a40b99c098a0532d41 ]

According to the USB4 retimer guide the correct order is immediately
after sending ENUMERATE_RETIMERS so update the code to follow this.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/retimer.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 9cc28197dbc45..edbd92435b41a 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -187,6 +187,21 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 	return ret;
 }
 
+static void tb_retimer_nvm_authenticate_status(struct tb_port *port, u32 *status)
+{
+	int i;
+
+	tb_port_dbg(port, "reading NVM authentication status of retimers\n");
+
+	/*
+	 * Before doing anything else, read the authentication status.
+	 * If the retimer has it set, store it for the new retimer
+	 * device instance.
+	 */
+	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++)
+		usb4_port_retimer_nvm_authenticate_status(port, i, &status[i]);
+}
+
 static void tb_retimer_set_inbound_sbtx(struct tb_port *port)
 {
 	int i;
@@ -455,18 +470,16 @@ int tb_retimer_scan(struct tb_port *port, bool add)
 		return ret;
 
 	/*
-	 * Enable sideband channel for each retimer. We can do this
-	 * regardless whether there is device connected or not.
+	 * Immediately after sending enumerate retimers read the
+	 * authentication status of each retimer.
 	 */
-	tb_retimer_set_inbound_sbtx(port);
+	tb_retimer_nvm_authenticate_status(port, status);
 
 	/*
-	 * Before doing anything else, read the authentication status.
-	 * If the retimer has it set, store it for the new retimer
-	 * device instance.
+	 * Enable sideband channel for each retimer. We can do this
+	 * regardless whether there is device connected or not.
 	 */
-	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++)
-		usb4_port_retimer_nvm_authenticate_status(port, i, &status[i]);
+	tb_retimer_set_inbound_sbtx(port);
 
 	for (i = 1; i <= TB_MAX_RETIMER_INDEX; i++) {
 		/*
-- 
2.39.2

