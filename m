Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3C7FFAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346827AbjK3TLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346800AbjK3TKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:10:54 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993F10F1;
        Thu, 30 Nov 2023 11:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=E3rFIY36xk7w67SNdqRVr/ancYZH1uNQAprnseO50p4=; b=ms58PUp6WubC4rGPiAMDw64R1L
        U5xxgzPBiwvEomi5ygL3iiuZDEcX31ej7lxIAUlwWIsQYO/hxrASVbf8B7bO6Nug/+Lr6YTvlmJaQ
        w3HJhV/1bR6WNIPpJmTgri80yzhuq8q4HZT+4/Lv31nYPm7EwLyMUsJXuJGJug6ALLFc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48272 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r8mR8-0003sb-Mc; Thu, 30 Nov 2023 14:10:59 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        hugo@hugovil.com
Date:   Thu, 30 Nov 2023 14:10:47 -0500
Message-Id: <20231130191050.3165862-6-hugo@hugovil.com>
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
Subject: [PATCH 5/7] serial: sc16is7xx: improve sc16is7xx_regmap_name() buffer size computation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Define macro for regmap port name suffix and use it in addition to
SC16IS7XX_MAX_PORTS to automatically compute the required buffer size to
hold the name.

This helps with code readability by making it more obvious what is the
required size of the buffer.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 750c55b93f5e..b02e6c79da67 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -20,6 +20,7 @@
 #include <linux/regmap.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/stringify.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/spi/spi.h>
@@ -27,6 +28,7 @@
 #include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
+#define SC16IS7XX_PORT_NAME_SUFFIX	"port" /* Used for regmap name. */
 #define SC16IS7XX_MAX_DEVS		8
 #define SC16IS7XX_MAX_PORTS		2 /* Maximum number of UART ports per IC. */
 
@@ -1700,9 +1702,9 @@ static struct regmap_config regcfg = {
 
 static const char *sc16is7xx_regmap_name(unsigned int port_id)
 {
-	static char buf[6];
+	static char buf[sizeof(SC16IS7XX_PORT_NAME_SUFFIX __stringify(SC16IS7XX_MAX_PORTS))];
 
-	snprintf(buf, sizeof(buf), "port%u", port_id);
+	snprintf(buf, sizeof(buf), SC16IS7XX_PORT_NAME_SUFFIX "%u", port_id);
 
 	return buf;
 }
-- 
2.39.2

