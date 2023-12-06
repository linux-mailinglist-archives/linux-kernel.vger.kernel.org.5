Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3F8068BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377002AbjLFHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377033AbjLFHic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C831FC3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA96C43391;
        Wed,  6 Dec 2023 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848273;
        bh=sL9jADnOH5s9rXM78Nf+CIz2brDSijTdhq+NDPBkjUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AII4ZFvk5eHb0lgbdW0f+lYVXKurtgSL/1tSJ7gtopSCrC7Fpkwiq1yWfg7XHLh45
         L32NfbbtWCZpdml4zrjxwLKv8CXgBEZ4R6/gpCTVoa4Mn8dryRO8hTvnCenEh1zhR/
         PwL+BUlb3LyiMs1+x9/LoSPDfgayqvnJ3lruwsSpnG+R94MBSZqFLqjhgYKdUUh+7d
         FfvpodAenm6UEjzS8awFwPCeXTcBgsCw7IOUAlh2pL1iJ/eSQa1/N/iBnWEdDfRyhL
         646oO2lSNqMllxML3quTiZ0Jd6NSOU4roAa+o4ytL8CeFM+VsSp2cThv8zboKLDOHN
         DIZmZu1AzsQgA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH 16/27] tty: mmc: sdio: use u8 for flag
Date:   Wed,  6 Dec 2023 08:37:01 +0100
Message-ID: <20231206073712.17776-17-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch character types to u8. To conform to characters in the rest of
the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/sdio_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 370fadf1d6d1..575ebbce378e 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -354,12 +354,11 @@ static void sdio_uart_stop_rx(struct sdio_uart_port *port)
 
 static void sdio_uart_receive_chars(struct sdio_uart_port *port, u8 *status)
 {
-	unsigned int flag;
 	int max_count = 256;
 
 	do {
 		u8 ch = sdio_in(port, UART_RX);
-		flag = TTY_NORMAL;
+		u8 flag = TTY_NORMAL;
 		port->icount.rx++;
 
 		if (unlikely(*status & (UART_LSR_BI | UART_LSR_PE |
-- 
2.43.0

