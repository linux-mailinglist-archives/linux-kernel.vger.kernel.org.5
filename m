Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18877BE726
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377849AbjJIQ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377753AbjJIQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:57:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88219D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:57:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so4326118f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696870674; x=1697475474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7+J+nUrKbyMvawtQTntvidw+Zsr1uIeHfIIaD4oAvY=;
        b=Aufp1Hk3lgohXDgybb8nz5yFHPTAFEirM9xUWWNAkdB53DGRHVGISI+ukMBCv0A7BK
         jGqKObvJDU/XidDJTA/DZXeQ8XOWuScLoGK8X/ldkwVe0BY3Ug34DXoLgQzflX6KPjul
         /22eqZIO7kUkecYFxTKONV6E8VBAytzo/ot3JxIobU3BQpx2a2fpOoW//Q2YG8TUX9rC
         jFyDgiqzp2tbeIsHY3H4jkiurNby+vN2nvg4xmLNMWn8aTxw9IefFNxA2alzck3epKzd
         alhIrZmWMIczhH5TKYO0x/kfCBhD0X5WkMWU+Flzs25d1LYZF1NNCEjoV1l4cRVQewec
         7Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870674; x=1697475474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7+J+nUrKbyMvawtQTntvidw+Zsr1uIeHfIIaD4oAvY=;
        b=nB+HQA+1E6stStI/hBwYBskdgdR0dscghNLY1xTTZNOKOFfOafv2TR+b56g83stoZO
         8UNVBbe9wzT9Jt/byRS/BZeqHigTOJZ/gzxUyBC0hO4ax+j6j6GSzHUR5Aaa4RxtUT2r
         YRa6//G7nFcxT5EHVZnF24ufNVLjZNi5KRffjDXsiN8+vm8xyMAzOWcqSbNTaDtKqghi
         wqW3PJGMZ+VdEuNl1GPU0Cj/+Fi8ju8aIGpiFqoc88LJmT9N8bRaHvSJ+fNydxl4LEYS
         djAU1Z0bgWHcN0W7yvlwAHgKodP+NZZslzeZYQs+HW0pIpGCUsDkYrlbQtsnZ0rNMUBl
         26TQ==
X-Gm-Message-State: AOJu0Yy6BdRJG1OfnP5xVmTC2tnwGnUpYNIspDuk7WF5kPZouFHY9jaB
        W7B0DskfhuKoccdX09Dbk3ILMrqd4ZCPEQQG6+c=
X-Google-Smtp-Source: AGHT+IHmxYViZWuYKGqL42IKCDycqsHj5+7UiFk7sqsCVMYE8BcDys6CiXB5hAxQi7h9vIP1TxIslA==
X-Received: by 2002:a5d:56c3:0:b0:31f:e32f:a503 with SMTP id m3-20020a5d56c3000000b0031fe32fa503mr12560299wrw.20.1696870674198;
        Mon, 09 Oct 2023 09:57:54 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm10199828wrp.0.2023.10.09.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:57:54 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 5/7] drivers/tty/serial_core: add local variable for newly allocated attribute_group**
Date:   Mon,  9 Oct 2023 18:57:38 +0200
Message-Id: <20231009165741.746184-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the compiler to keep the pointer in a register and
prepares for making the struct field "const".

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/tty/serial/serial_core.c | 11 ++++++-----
 include/linux/serial_core.h      |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..e253ef474fb4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3082,6 +3082,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	struct uart_state *state;
 	struct tty_port *port;
 	int ret = 0;
+	const struct attribute_group **tty_groups;
 	struct device *tty_dev;
 	int num_groups;
 
@@ -3132,22 +3133,22 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (uport->attr_group)
 		num_groups++;
 
-	uport->tty_groups = kcalloc(num_groups, sizeof(*uport->tty_groups),
+	uport->tty_groups = tty_groups = kcalloc(num_groups, sizeof(*tty_groups),
 				    GFP_KERNEL);
-	if (!uport->tty_groups) {
+	if (!tty_groups) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	uport->tty_groups[0] = &tty_dev_attr_group;
+	tty_groups[0] = &tty_dev_attr_group;
 	if (uport->attr_group)
-		uport->tty_groups[1] = uport->attr_group;
+		tty_groups[1] = uport->attr_group;
 
 	/*
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this port's parameters.
 	 */
 	tty_dev = tty_port_register_device_attr_serdev(port, drv->tty_driver,
-			uport->line, uport->dev, port, uport->tty_groups);
+			uport->line, uport->dev, port, tty_groups);
 	if (!IS_ERR(tty_dev)) {
 		device_set_wakeup_capable(tty_dev, 1);
 	} else {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..597de109dbf5 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -578,8 +578,8 @@ struct uart_port {
 	unsigned char		suspended;
 	unsigned char		console_reinit;
 	const char		*name;			/* port name */
-	struct attribute_group	*attr_group;		/* port specific attributes */
-	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
+	const struct attribute_group *attr_group;	/* port specific attributes */
+	const struct attribute_group *const*tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
-- 
2.39.2

