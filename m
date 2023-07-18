Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD767575CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGRHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjGRHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:55:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A5010E3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:55:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4rpg5TxWzBQslf
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:55:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689666923; x=1692258924; bh=n941bsO1050Sy4x8o1CeSfhHj64
        suA3ZJc6fKjpS3K4=; b=XZWNtzOpvIrl3nMBaw+wVal0chvmvovmr9DOaYhlEa7
        35OTuqeb+YyqctOlgy7o3+GfTDfUtkW3Z0rWFMqwVCXNw0IB1E/JVbpfNw+bPAoP
        32CfwNzbDmutQV8ZssLPVqxSmweGQTk07YpjvDTswSvt3mF+hRWLi5ymkXU0ANh8
        PwHurBwkO/pYkiSNZ/qaCO/+KXTWFYG2gXm56hExtTkX7DJRg0J6dZrj0htZP6DI
        tCnzHRGckxQeO8zj4w5zRCgEoA0k80fyCpGgawP/EoiciaI5rdVHv1JN3PrAq1jY
        YXSQMr6mpVCQs9TedrNzNjipAuJacS1zXdK41AMdwHg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eqzqOUMCKRdt for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 15:55:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4rpg3KgpzBJDj9;
        Tue, 18 Jul 2023 15:55:23 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 15:55:23 +0800
From:   sunran001@208suo.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: add missing clk_put()
In-Reply-To: <20230718075401.16668-1-xujianghui@cdjrlc.com>
References: <20230718075401.16668-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <047273ae4e4c25eb7b81fd69d761161e@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following Coccinelle error:

./drivers/tty/serial/bcm63xx_uart.c:854:2-8: ERROR: missing clk_put;
clk_get on line 849 and execution via conditional on line 853

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/tty/serial/bcm63xx_uart.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/bcm63xx_uart.c 
b/drivers/tty/serial/bcm63xx_uart.c
index 55e82d0bf92d..7353b683952d 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -851,6 +851,7 @@ static int bcm_uart_probe(struct platform_device 
*pdev)
          clk = of_clk_get(pdev->dev.of_node, 0);

      if (IS_ERR(clk))
+        clk_put(clk);
          return -ENODEV;

      port->iotype = UPIO_MEM;
