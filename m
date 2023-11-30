Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A37FFAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbjK3TKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjK3TKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:10:51 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E7910E4;
        Thu, 30 Nov 2023 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=AEm+IaX9A4uvKk4v1WSGhlTmQPSBKm4TU4lKJNYntmE=; b=Gm9kSMoJBgC1JfrodPB2e0/Yvp
        8xiv7QWolS5WzDxSL3I06gC7hYgmBUIQVJpvlghkP1mO1D8Yt4NxZL3BXM5/fO9h7yryINSJ4MWYd
        jSi5d3SarkgfCVVtil2rAEX3fa9mreEqZQAsVbEovOK2mvP8qLxMCXxFe9UI+UAsMOZM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r8mR4-0003sb-No; Thu, 30 Nov 2023 14:10:55 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        hugo@hugovil.com, stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Nov 2023 14:10:43 -0500
Message-Id: <20231130191050.3165862-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130191050.3165862-1-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Change snprint format specifier from %d to %u since port_id is unsigned.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
I did not originally add a "Cc: stable" tag for commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
as it was intended only to improve debugging using debugfs. But
since then, I have been able to confirm that it also fixes a long standing
bug in our system where the Tx interrupt are no longer enabled at some
point when transmitting large RS-485 paquets (> 64 bytes, which is the size
of the FIFO). I have been investigating why, but so far I haven't found the
exact cause, altough I suspect it has something to do with regmap caching.
Therefore, I have added it as a prerequisite for this patch so that it is
automatically added to the stable kernels.
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 10e90a7774f0..8e5baf2f6ec6 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1700,7 +1700,7 @@ static const char *sc16is7xx_regmap_name(unsigned int port_id)
 {
 	static char buf[6];
 
-	snprintf(buf, sizeof(buf), "port%d", port_id);
+	snprintf(buf, sizeof(buf), "port%u", port_id);
 
 	return buf;
 }
-- 
2.39.2

