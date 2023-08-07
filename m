Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27068773195
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjHGVqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHGVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:46:28 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965FF1711;
        Mon,  7 Aug 2023 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=ec1Zk637eDWVn64eclVyppNTtCvrXv42fcayZ6Lfi9Y=; b=tTfplzTb1uVvw0pB7IziW/RgS7
        kh6UihZgHwGCj1AtHDh5E/HLu3J07XgHfvUuEHirzfE+l3QWwO8q/L0y5z3hcxxEqak9tGYHAZXTD
        mM2/5FItTd/0LLxuiVeS4xvRwI4hXYxqLSjO+iFQCwvUH7flt469zgY0l5Nf9P/HWWZM=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:47088 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qT83N-0000hD-74; Mon, 07 Aug 2023 17:46:17 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Date:   Mon,  7 Aug 2023 17:45:56 -0400
Message-Id: <20230807214556.540627-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230807214556.540627-1-hugo@hugovil.com>
References: <20230807214556.540627-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v10 6/6] serial: sc16is7xx: add missing support for rs485 devicetree properties
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Retrieve rs485 devicetree properties on registration of sc16is7xx ports in
case they are attached to an rs485 transceiver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index cfc88959b2f7..f61d98e09dc3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1554,6 +1554,10 @@ static int sc16is7xx_probe(struct device *dev,
 			goto out_ports;
 		}
 
+		ret = uart_get_rs485_mode(&s->p[i].port);
+		if (ret)
+			goto out_ports;
+
 		/* Disable all interrupts */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_IER_REG, 0);
 		/* Disable TX/RX */
-- 
2.30.2

