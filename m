Return-Path: <linux-kernel+bounces-79160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640FD861E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1672528495E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182571482FF;
	Fri, 23 Feb 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZkQfmV9"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372E14532B;
	Fri, 23 Feb 2024 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722106; cv=none; b=gR8oVuJ/AgiDfjPI+1wFUlT2oV5clhsQJ560hdm6il2/lJIkRUm8a6tGXf7jGC7Ccs8/oXepHeDrHwIAKil93AhM9d4u1GKIX2kfUl3mhF0MCR4Ro5LLL0qRP01s5FGQFd6VRAzoXsoXHJ1eP+uFUKGvqyY5zvhHKnJlk9OrdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722106; c=relaxed/simple;
	bh=9fsXlW8k/82RP59Hyg0tIsH191jUNaBCZk2e6c+plbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PX8LtAUZn6gYgbcOF0ryYnW1LRuqL4ulkQ1g7MD2WWivqmTaeibriv+ED3RW8E+x6N+1HTViYLaFYEWXCKykinzTa7DsMMXE4PhR6jpvUDJzts23Dn6tAMnUSAIraA3SleKCBVfSrH5aUrfGDInX+uvgQFLhbzHAeCWn7L5qBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZkQfmV9; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564d9b0e96dso1033848a12.2;
        Fri, 23 Feb 2024 13:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722102; x=1709326902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QouBmNwC5Mz1DDSViLi9LfWxt2YyADxYyZ8tYZSUz6c=;
        b=LZkQfmV9jkh4J2cPZVvJLYkwY5hwpptqTF3SFuVaCbyvEFxy1rAEottee777Xgl7Wn
         s8AzwKc3y0d5wVUh8XBW/R8N3by6xFfzO2Md5pTschuTKITSAQ5zBlRjn774fIaVkzTl
         kRlnVYYnl0w9vI69ZZ+AX1GQ0+vKh5rtN6YUVKKDDCixiorQRE77W3gsPn1y2iHz5/jK
         oAfYDyM8nrmFKKCiQdk2KaMS++OLsUzMiLo0mBEr5JWqUiueedYIrTT7aTpU2X2W7Z3+
         KYsB9x/fVDoefu4Fnb70qyZ0BbY2ocRgFjhAb017l72RonQ/N19t0FG6b+V445kyLauL
         2g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722102; x=1709326902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QouBmNwC5Mz1DDSViLi9LfWxt2YyADxYyZ8tYZSUz6c=;
        b=FSVVeuc5vk3+ARBTqVmHz5ZimWTxk//jOk4lZAMcgijjbaoS3enVDoxLRqIL2/TOB/
         kW/aKx2PaRdiPmZIu8YfYn8U6srlA/aeKimgJg+dcKzn7QPaMwPi4DDr0ziCbC7RyEwi
         HGuGxxkw2jP5KnRChYGoHBjKiUQnl4cCWT8f/O6w1WvJhnBdxuTcgN/Gg75F+S7AYIyo
         43H5dJg0ynvgFhTznok1CARjiq2JNrgQKkCA1TT0K/64hnJqvwGw2BLw1cQyAE/TsvUr
         QRVrwcb8apEZu24wYfheU+rD16tsUkmhOMItzTrZlPr7N4KQGLbqX8+n3gTHTPU+ULVE
         dwgA==
X-Forwarded-Encrypted: i=1; AJvYcCVHl8xljZCDROysb9ST7Tl8ZF0Nr9U+72XuiJpJ1njnHcNX3PsnlhcZUyk2OBfIZp5mBbN2JC/T6y8s5yHjzYtMy/JGmtPCI/YER12u
X-Gm-Message-State: AOJu0YwWJEmQpjgBmpuIpIDnKeU/cQOOd3xknuPIzMNGUYdvW0w7UY1P
	iOqNjDArbAD4YFZezAMoVi6DxG4z6w67U/W1dntnTRnLxVoGnjhqjtx4IRuv3ZQ=
X-Google-Smtp-Source: AGHT+IE+PDfUSbpkJadKxGFZIZzUyuC/W/FK5GgZQlcn7ptjpfuXp14gxEB//j6Z9tG2+jLFaqhIAg==
X-Received: by 2002:a17:906:7c55:b0:a3e:6501:339d with SMTP id g21-20020a1709067c5500b00a3e6501339dmr666452ejp.61.1708722102190;
        Fri, 23 Feb 2024 13:01:42 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:01:41 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 01/16] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Fri, 23 Feb 2024 22:00:31 +0100
Message-Id: <20240223210049.3197486-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the delay loop during the Arbiter empty check from
vsc73xx_adjust_link() to use read_poll_timeout(). Functionally,
one msleep() call is eliminated at the end of the loop in the timeout
case.

As Russell King suggested:

"This [change] avoids the issue that on the last iteration, the code reads
the register, tests it, finds the condition that's being waiting for is
false, _then_ waits and end up printing the error message - that last
wait is rather useless, and as the arbiter state isn't checked after
waiting, it could be that we had success during the last wait."

Suggested-by: Russell King <linux@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - improved commit description
  - added two defines instead magic numbers
  - added include with iopoll.h
v4:
  - resend patch
v3:
  - added "Reviewed-by" to commit message only
v2:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ae70eac3be28..ab5771d4d828 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
@@ -268,6 +269,9 @@
 #define IS_7398(a) ((a)->chipid == VSC73XX_CHIPID_ID_7398)
 #define IS_739X(a) (IS_7395(a) || IS_7398(a))
 
+#define VSC73XX_POLL_SLEEP_US		1000
+#define VSC73XX_POLL_TIMEOUT_US		10000
+
 struct vsc73xx_counter {
 	u8 counter;
 	const char *name;
@@ -779,7 +783,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 	 * after a PHY or the CPU port comes up or down.
 	 */
 	if (!phydev->link) {
-		int maxloop = 10;
+		int ret, err;
 
 		dev_dbg(vsc->dev, "port %d: went down\n",
 			port);
@@ -794,19 +798,17 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 				    VSC73XX_ARBDISC, BIT(port), BIT(port));
 
 		/* Wait until queue is empty */
-		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-			     VSC73XX_ARBEMPTY, &val);
-		while (!(val & BIT(port))) {
-			msleep(1);
-			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				     VSC73XX_ARBEMPTY, &val);
-			if (--maxloop == 0) {
-				dev_err(vsc->dev,
-					"timeout waiting for block arbiter\n");
-				/* Continue anyway */
-				break;
-			}
-		}
+		ret = read_poll_timeout(vsc73xx_read, err,
+					err < 0 || (val & BIT(port)),
+					VSC73XX_POLL_SLEEP_US,
+					VSC73XX_POLL_TIMEOUT_US, false,
+					vsc, VSC73XX_BLOCK_ARBITER, 0,
+					VSC73XX_ARBEMPTY, &val);
+		if (ret)
+			dev_err(vsc->dev,
+				"timeout waiting for block arbiter\n");
+		else if (err < 0)
+			dev_err(vsc->dev, "error reading arbiter\n");
 
 		/* Put this port into reset */
 		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
-- 
2.34.1


