Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF87FD60D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjK2Lww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjK2Lwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:52:50 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A6681A8;
        Wed, 29 Nov 2023 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4KSReBDzzeRrqbkauW
        k2fmkY0a7uOl8FxER0foarfow=; b=IAQKax88RMQZSR24Vm/58+eGq6iiyLyPM7
        smWCU4doydMDmMZxzZQDN2u0hyh8XGBqXZc6EQ+xkYV3JBYCDFwwgpe0dmEGUlE1
        rpkMZbwPWBUQWBgGbQmmitVmIct2VO/5A+PR2Fs9xPWPzWDT1qmHYQyhAF4S06b3
        2apMi2b1E=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wCXd0YGJmdlsP_8EA--.44253S2;
        Wed, 29 Nov 2023 19:52:40 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [tty/serial] 8250_acorn: Add error handling in serial_card_probe
Date:   Wed, 29 Nov 2023 03:52:36 -0800
Message-Id: <20231129115236.33177-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wCXd0YGJmdlsP_8EA--.44253S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWxZr4UCw47ur4rCryUZFb_yoW8JFy3pF
        4DKrs0yFWYqF1xu3srXr45ZF1rGay8tF17GrnrG3s5trs8tr9agr4fKa4jyr4jkr95GF1a
        yF15CrWUCay2yF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEubk7UUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQY3gl8ZaQ1sNQAAst
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handling to the serial_card_probe
function in drivers/tty/serial/8250/8250_acorn.c. The
serial8250_register_8250_port call within this function
previously lacked proper handling for failure scenarios.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/tty/serial/8250/8250_acorn.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
index 758c4aa203ab..378ae6936028 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -43,6 +43,7 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 	struct uart_8250_port uart;
 	unsigned long bus_addr;
 	unsigned int i;
+	int ret;
 
 	info = kzalloc(sizeof(struct serial_card_info), GFP_KERNEL);
 	if (!info)
@@ -72,6 +73,14 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 		uart.port.mapbase = bus_addr + type->offset[i];
 
 		info->ports[i] = serial8250_register_8250_port(&uart);
+		if (IS_ERR(info->ports[i])) {
+			ret = PTR_ERR(info->ports[i]);
+			while (i--)
+				serial8250_unregister_port(info->ports[i]);
+
+			kfree(info);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.17.1

