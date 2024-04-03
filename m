Return-Path: <linux-kernel+bounces-129570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE8896CB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714F3B272C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DE01411DB;
	Wed,  3 Apr 2024 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA0fKj7F"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CB13958A;
	Wed,  3 Apr 2024 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140674; cv=none; b=mg7KUEtibpjXvub1dS/FWGBsPu/FSL4Xr9SBw6z6cPWw7iGeEfA2H/pk9IuRE1Q/b0IM8XnP3e7hXX09Mx1DIuOs2udvjCHaZj8uoK9GTn617gJyf1Xaq4DzSO4L52v0qvlFixGEooxdXn89XX5uUf8RfpgkNGKsP2Dxc9NAGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140674; c=relaxed/simple;
	bh=NEqzIM5bhXOMyShh8NovoHydAS2pG4mVH0/rNoV63CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgTdKSmgGDiRq/ca3ZZPDe7bx1CEAisquKk7pr6VJzNEwq+6gUcLDhOZpaaszmMzGZs2ekMSZTF4WYrGng04onDP0HLf6z877tyaOlxdWo+8za9SGtUTmBmfpA07BVATnAwCKc3ATc7h4HDGJe0L53I3Q1s26+OQdk5yGj18nRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA0fKj7F; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e06116eb4so662228a12.3;
        Wed, 03 Apr 2024 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140670; x=1712745470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whafif4/IiKhd9fS47gOJyRBUsqdTIZqNGil9vLxZwE=;
        b=UA0fKj7FzMCGbjzSJz2tLmINcBFgIstH3N1RHWMMFxBzGffdwcLLbIN6rkq7+a7SpJ
         3BQS/IXUL2uKjf3jGRsBPBcKpQ/mflgzH4DjuPSOdDzFAPt8gEnn/FlhLc6Z9fIoSjdu
         aS/NbRukh1QIUj1dKe8t4GxKrk46s5M0YlRxPRoxWKz84dncshsUXkpqaa9o1MaCqS7/
         q3BxWWbx+Yx0WJhA/inbeTsZOHbeN+f+4loRT8B40S1Mn00vpdhuaBTACUnPTPbcQu1N
         HIOAl5kf4R0fJ5LOp82NGIqrd7f3NZ10JH/5DmDn228yvwHdmbqepqFMHmNaTnG3lZW+
         0viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140670; x=1712745470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whafif4/IiKhd9fS47gOJyRBUsqdTIZqNGil9vLxZwE=;
        b=GthgoUx+EQnYY6e/mJ42z9COMzT69PR+CLQ2f4tHxZKqF5L7ASGyKNFBkt36UmzsML
         6LVrHvv7mU05WJyDyP3F8qC5aQ5Inbsp2IWE9Qe9Xio+bb7SZE5Jn2bmv7mq64ZqTlxo
         QVN6vLesd6E1cpO460Mq9QUcu2UmZaB7ZuIdA96XzAA54/9dHQnjP0/ZrxS2OlGFwSxP
         B1y62iA5bdwXBwNRBW6zNS7PAPfAkfy65EH1+VEAhRzmeyW+R75sfvAgs0NOzDot+/Ac
         yqo8EWn9rBzDk68z4zEzrTOPRXWPoWPl+M1P34pfW6W0VwY2IHaK4x59PU77SrWW7m42
         z30Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHRWw0TRmgZkJ22G8C9IkEY2ZekEOalZm50NOt9Q5eIio5iMVyUJSrJYP2bie5vPXG95ToyajYq/RxQLhmJrBIlnY6IbUDvevse5/U
X-Gm-Message-State: AOJu0Yw7XHvgEp0xqy2pJDPMuhDXNhIwpfRh2JsKA6hgO6SEV22731hy
	zF6P+IKsXZhXB995urj/GeHLUq9lplhuUisGxrvqAPGfBStZqOKkBS4xWOpaDfg=
X-Google-Smtp-Source: AGHT+IGg+Soh0OpIGA9gJVVkEYdQ5aCywZ7/pT7hhDShjFIipLmHSNkUBKoRZVBHVEFRaqiTwffCMA==
X-Received: by 2002:a17:906:2882:b0:a4e:b3f:1dda with SMTP id o2-20020a170906288200b00a4e0b3f1ddamr1518235ejd.74.1712140670331;
        Wed, 03 Apr 2024 03:37:50 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm6858169ejb.11.2024.04.03.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:37:49 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
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
Subject: [PATCH net-next v8 01/16] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Wed,  3 Apr 2024 12:37:17 +0200
Message-Id: <20240403103734.3033398-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403103734.3033398-1-paweldembicki@gmail.com>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
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
v8,v7,v6:
  - resend only
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


