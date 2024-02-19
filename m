Return-Path: <linux-kernel+bounces-70898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A111859DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C593A1F21A97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03922EE8;
	Mon, 19 Feb 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zd0EvbRJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72134224ED
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329139; cv=none; b=Haz6xN1xFUHJwLOEP1qd1KHpFB6noD5MhdzYEvDWtn5QJIQHGCNQG9XuyjopXusIyXdKLK77M2bBb38HLnLWSDSREFbCiysZE919DP+N7zhS0R7pv6H9xVkVfzOrmmafrV/P+e+d7Or0O+YjYjJs3om6NcReyVkAov88uAkoTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329139; c=relaxed/simple;
	bh=wh4OmwcFRlWi/ItnT5ktk0oGxcFdh4oAYQhOp0nR3jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCgJAFJct9hSSaGzowZg5tfuS9XW3K9bUEMsZNpSMxM/nGbYBwg1HC6Ht2Ew1a4/07gWli2SoxlF8039Xr3cEbJb5ws8/a/yPrhaISRHG7kNx3MiSTELX3UKo9um/667nuSNhmCYuXnPhZYDvIcWhVDFNeIEVyWsFgewP+atbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zd0EvbRJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-410e820a4feso27565295e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708329137; x=1708933937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2/U/HLhILocJNKhz9qnNNoXbd+eRoVQ2PKzr45zesuc=;
        b=zd0EvbRJLfMdVnfiRKP4d75hXjV8wOf8Va1uUQi+hmBsJgAQBdfgphgJeEPKpA7qGW
         TdTRNwRysYM9PGz4OHhM9w1nhDJvYq0peaVthFjck7OEdy3v7jf1mHZhCoKukx9uTmoj
         JZJh07LhVle2YSfbvgF4r4FnUkqgt2o3BHnx8c0UK10VNkxu7xdeX9aJ/HInMdLelzjn
         v56/kFZjTQKPyXMRNmnHm6BuCATJUuggSXlGK6RBQ2BJfLGhD4dM5zfXjHucYXHf9y1n
         My93Lhs90EbWkjqXP0vb1mAJWIeb/HvYbQQUeVWVErtM3MU748LbQe5Mr5tFWLVfqLuC
         cumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708329137; x=1708933937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/U/HLhILocJNKhz9qnNNoXbd+eRoVQ2PKzr45zesuc=;
        b=b9caRdH1aL6KYWQjNRfTr9rBRMb6T2PpB+mPBj6qUbpjtjL3QThthXttXra5NJzuD/
         5387Ijme2xKP+iLXeYQ1Hi15HGDOgU0onGcKAA07T8Y2OXXVlzdZjQ2cX96C+EPDsueU
         SRRwLnOA6rNnEvqgLqmKgYlLorXtN6gjr9fa2aG/0AT8H/rqQXoKWnGD1UHoUNRJ6deg
         6JrAKfFZNRZ6rVd8SH06CI9Mjfkiu+EQc+w7/eAvyJKZ+3hUI/cwskNmk37ywXC8tRlg
         KiFbuYcNVfJcI4AfF+rhpx5ZF4CJvZJF9Oh1bOQxG1AArddNRuAtWs99d6Y/oX+Zt97f
         d86A==
X-Gm-Message-State: AOJu0YzvgxhulR88u48qCC1cpGYEHr9sqtZrov5cPV02NYrHVWft8/SY
	gBpSu0qeWP0k09Xz7XZ6Ot3HMj+VLzVn4G8E7H4Nhb2g4rnEh0IsACYYsOeAPmc=
X-Google-Smtp-Source: AGHT+IHzFayj07qqwZEtFxSEIAhDseu8F5QgjmRm16RmLOnuksNhRFCUVwH+pJ4w7RfJk0af/ufDGw==
X-Received: by 2002:a05:600c:5486:b0:412:10c2:c73b with SMTP id iv6-20020a05600c548600b0041210c2c73bmr9996038wmb.1.1708329136597;
        Sun, 18 Feb 2024 23:52:16 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:88b:d6c3:a2f2:16d9])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c221400b0040fddaf9ff4sm10449287wml.40.2024.02.18.23.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:52:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] serial: st-asc: don't get/put GPIOs in atomic context
Date: Mon, 19 Feb 2024 08:52:11 +0100
Message-Id: <20240219075211.6949-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Since commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with
SRCU") gpiod_set_consumer_name() calls synchronize_srcu() which led to
a "sleeping in atomic context" smatch warning.

This function (along with gpiod_get/put() and all other GPIO APIs apart
from gpiod_get/set_value() and gpiod_direction_input/output()) should
have never been called with a spinlock taken. We're only fixing this now
as GPIOLIB has been rebuilt to use SRCU for access serialization which
uncovered this problem.

Move the calls to gpiod_get/put() outside the spinlock critical section.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-gpio/deee1438-efc1-47c4-8d80-0ab2cf01d60a@moroto.mountain/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v1 -> v2:
- initialize the 'manual_rts' variable to false as we don't always get to
  the place where it's set

 drivers/tty/serial/st-asc.c | 40 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index bbb5595d7e24..f184de6af313 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -466,6 +466,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct asc_port *ascport = to_asc_port(port);
 	struct gpio_desc *gpiod;
+	bool manual_rts = false;
 	unsigned int baud;
 	u32 ctrl_val;
 	tcflag_t cflag;
@@ -517,26 +518,12 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 		ctrl_val |= ASC_CTL_CTSENABLE;
 
 		/* If flow-control selected, stop handling RTS manually */
-		if (ascport->rts) {
-			devm_gpiod_put(port->dev, ascport->rts);
-			ascport->rts = NULL;
-
-			pinctrl_select_state(ascport->pinctrl,
-					     ascport->states[DEFAULT]);
-		}
+		if (ascport->rts)
+			manual_rts = false;
 	} else {
 		/* If flow-control disabled, it's safe to handle RTS manually */
-		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL]) {
-			pinctrl_select_state(ascport->pinctrl,
-					     ascport->states[NO_HW_FLOWCTRL]);
-
-			gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
-			if (!IS_ERR(gpiod)) {
-				gpiod_set_consumer_name(gpiod,
-						port->dev->of_node->name);
-				ascport->rts = gpiod;
-			}
-		}
+		if (!ascport->rts && ascport->states[NO_HW_FLOWCTRL])
+			manual_rts = true;
 	}
 
 	if ((baud < 19200) && !ascport->force_m1) {
@@ -595,6 +582,23 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	asc_out(port, ASC_CTL, (ctrl_val | ASC_CTL_RUN));
 
 	uart_port_unlock_irqrestore(port, flags);
+
+	if (manual_rts) {
+		pinctrl_select_state(ascport->pinctrl,
+				     ascport->states[NO_HW_FLOWCTRL]);
+
+		gpiod = devm_gpiod_get(port->dev, "rts", GPIOD_OUT_LOW);
+		if (!IS_ERR(gpiod)) {
+			gpiod_set_consumer_name(gpiod,
+						port->dev->of_node->name);
+			ascport->rts = gpiod;
+		} else {
+			devm_gpiod_put(port->dev, ascport->rts);
+			ascport->rts = NULL;
+			pinctrl_select_state(ascport->pinctrl,
+					     ascport->states[DEFAULT]);
+		}
+	}
 }
 
 static const char *asc_type(struct uart_port *port)
-- 
2.40.1


