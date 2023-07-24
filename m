Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD775E7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjGXBgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGXBgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E4C1994;
        Sun, 23 Jul 2023 18:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1355060F5A;
        Mon, 24 Jul 2023 01:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D1DC433C9;
        Mon, 24 Jul 2023 01:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162303;
        bh=ajbydh6J7RiNdqCXQT3mKx9KBNV0cMbI9Ija70sq5+g=;
        h=From:To:Cc:Subject:Date:From;
        b=OLl6ozcZiKMZ8Qn5ZfnINaAd4ktJznJ2LUCTYgb6Z7CHwUZepdlMcQnu1B5N20O+E
         6pz1ZDCmt5iGzGMZmLO1qL08SX+7HMLgBVH4nSzjrM0XdqlFGfhccz43z3cwVKPzmK
         o5PiTf4iBxAu01Lbdu/wmztImaYcfCucT4ZiP4WdpV+LVm1qxhNMhZkUvTna9Pmplm
         c6RxgBbiVttgMQYzRRLXzFQs+DDvNCRzId2QkMU3guRhCgMFZauYFw9HvvYJMU1Zm0
         /i7g6AXIuAAipOkWDeorRGCCbFQl8UpdtOh+nimgzmqivScQ1V8fXIbRaw1eRPIxnj
         Es6uqc4/KFl8A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, jslaby@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 01/40] serial: stm32: Ignore return value of uart_remove_one_port() in .remove()
Date:   Sun, 23 Jul 2023 21:31:01 -0400
Message-Id: <20230724013140.2327815-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 6bd6cd29c92401a101993290051fa55078238a52 ]

Returning early from stm32_usart_serial_remove() results in a resource
leak as several cleanup functions are not called. The driver core ignores
the return value and there is no possibility to clean up later.

uart_remove_one_port() only returns non-zero if there is some
inconsistency (i.e. stm32_usart_driver.state[port->line].uart_port == NULL).
This should never happen, and even if it does it's a bad idea to exit
early in the remove callback without cleaning up.

This prepares changing the prototype of struct platform_driver::remove to
return void. See commit 5c5a7680e67b ("platform: Provide a remove callback
that returns no value") for further details about this quest.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230512173810.131447-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/stm32-usart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 1e38fc9b10c11..e9e11a2596211 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1755,13 +1755,10 @@ static int stm32_usart_serial_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	int err;
 	u32 cr3;
 
 	pm_runtime_get_sync(&pdev->dev);
-	err = uart_remove_one_port(&stm32_usart_driver, port);
-	if (err)
-		return(err);
+	uart_remove_one_port(&stm32_usart_driver, port);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.39.2

