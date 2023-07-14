Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD53753095
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjGNEaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjGNEaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:30:21 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3932D48
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:30:18 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2JRq0ZPrzBRSVw
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:30:15 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689309014; x=1691901015; bh=dZqnqZqBjGRAEON5ShfXliTdE7Z
        9seHxdVTMng/HwSM=; b=K1SWXeBDwfCAX93KDt4utJr7hNeQiIl1xVs9YI2vutb
        ei2VFaZ06iKbj3VDTCKaYb9kww0rCqb0ZKJ9DbnUEF8o/qM7z5piC+RJYAL+16KC
        xkj5VpoSCF+SyHc3sHm2ZWHusiXD8bwFHqIldd3jfczcCpXAu9DWTodumoUXgDKK
        JH1m7YOOoOvFw0qa+nPegwOEuoXt2/XR7zojtXlFto2/F6KZChwY8UUBAmQUNQYe
        Co1Hy0JYJe1ps7GU+3hAASK1YDdSsGNnnUOHI7+iPFOAjm9tSNPC0vhuC/PHSB+I
        vB2lCNO13dB3lmdPT4QbWGocn1pBhyj2qIIox5ftRKA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sMUKkdQ5hHUl for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 12:30:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2JRp5byVzBRSVj;
        Fri, 14 Jul 2023 12:30:14 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 12:30:14 +0800
From:   liubin001@208suo.com
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] tty:Insert clk_put before return (clk) to release memory
In-Reply-To: <tencent_EF85BF6D0EE7D05E10D527FD335467508106@qq.com>
References: <tencent_EF85BF6D0EE7D05E10D527FD335467508106@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <57adb092639743f2619c4765379b3ec7@208suo.com>
X-Sender: liubin001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


tty/serial:Insert clk_put before return (clk) to release memory
Signed-off-by: Liu Bin <liubin001@08suo.com>
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
