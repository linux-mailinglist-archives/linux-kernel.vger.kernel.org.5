Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38E47F93A1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 17:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjKZQEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKZQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:04:21 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471CFB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:04:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd6a86a898so37062127b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701014667; x=1701619467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jAcVnKA6iADA9vLnhJjfNDjx1x+ezMFBfqAWXzVOUug=;
        b=qxpCeGJLfF1BCtxowMWAsfvRVIv/6qZrnIrK/Xl5809mDWHNzkIX7uE999sOckKP79
         DN2Purd3BvPqXnrl6nFdfvZ6cWbSFnbAzz6T1SLRYaOqrv/LSKAdNO2Z7SqVe5aN8KEO
         TWLG6Wo0k4O7deHKhrgrhWmdq65QJwd0Kqotz6lDgxZXs4dwrDRierRwYIQNEGQGInuq
         YGYjpssDOzVLRN7U1LYM0ZRfIZiYLQbu8jAtqoc2qFzaG7+oOTdSYNIseyyqLUlxvZfr
         TjvQOSxdZ1hxh9pznfRok2ZZ65iTbpznhZ4QTcKvo0Pjjbja3Ivzolj9OI87B0yP4coL
         GU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701014667; x=1701619467;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAcVnKA6iADA9vLnhJjfNDjx1x+ezMFBfqAWXzVOUug=;
        b=gO1IV91rzMwwcLzNkc8lw49IorDDZZk5MYvGTbdHcqMTPJ+3IToPmU8QLTfmd7rv7y
         BTOjSuX/dW4ajbRDKoG3Wl6F89JbvnXCJvk65DoQ+l1D3hpFsoscp5AwqXz0UdviLQbN
         ZGOLzjyfgZUEfeRUHr1XH4pEAI1AuQ6JkjIWXVMVTGkIQFQ5ymJ4AWxluhh3zdgxSq3i
         leWJZUXyCyihQeWscUkGYU/YribbKDQKVI9VOBAQZI5iTANz/H2OTv9gYcqeeVoiO5U/
         K5TW6TahVN5Z8lYLitbub55VVKHWW1Oc2lmJT6SRfoRRY6o1s37twLKKDoJhGj3/jqK4
         0XKQ==
X-Gm-Message-State: AOJu0YxazooANWB8jxiRc7K9qP7ful+PwnMKUwCOoHUHp+if2arInxyU
        X8aYRwqJIY5JlP6FDBsRjZ1ZdipKddodk8bOoXd7
X-Google-Smtp-Source: AGHT+IH7cSvAl+dD9EIaxrdjmVvg/Xxrak/8orkiMKrBN+wcdRVvxz+40ZTE5uo29YN8WI2xwKeM0LN6CAvXzZhldwne
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:9b10:0:b0:5ca:5fcd:7063 with
 SMTP id s16-20020a819b10000000b005ca5fcd7063mr318515ywg.3.1701014666758; Sun,
 26 Nov 2023 08:04:26 -0800 (PST)
Date:   Sun, 26 Nov 2023 21:34:20 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231126160420.2442330-1-vamshigajjela@google.com>
Subject: [PATCH] serial: 8250_dw: Decouple DLF register check from UCV
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Jiri Slaby <jirislaby@kernel.org>, ilpo.jarvinen@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Designware UART has an optional feature to enable Fractional Baud Rate
Divisor (DLF) through the FRACTIONAL_BAUD_DIVISOR_EN configuration
parameter, and it is not dependent on ADDITIONAL_FEATURES.

dw8250_setup_port() checks DLF to determine dlf_size only when UART
Component Version (UCV) is non-zero. As mentioned above DLF and UCV are
independent features. Move the logic corresponding to DLF size
calculation ahead of the UCV check to prevent early return. Otherwise,
dlf_size will be zero and driver will not be able to use the
controller's fractional baud rate divisor (DLF) feature.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 84843e204a5e..136ad093c5b6 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -259,17 +259,6 @@ void dw8250_setup_port(struct uart_port *p)
 	}
 	up->capabilities |= UART_CAP_NOTEMT;
 
-	/*
-	 * If the Component Version Register returns zero, we know that
-	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
-	 */
-	reg = dw8250_readl_ext(p, DW_UART_UCV);
-	if (!reg)
-		return;
-
-	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
-		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
-
 	/* Preserve value written by firmware or bootloader  */
 	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
@@ -282,6 +271,17 @@ void dw8250_setup_port(struct uart_port *p)
 		p->set_divisor = dw8250_set_divisor;
 	}
 
+	/*
+	 * If the Component Version Register returns zero, we know that
+	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
+	 */
+	reg = dw8250_readl_ext(p, DW_UART_UCV);
+	if (!reg)
+		return;
+
+	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
+		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
+
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg) {
 		reg = data->pdata->cpr_val;
-- 
2.43.0.rc1.413.gea7ed67945-goog

