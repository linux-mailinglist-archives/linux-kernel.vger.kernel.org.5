Return-Path: <linux-kernel+bounces-64420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A82853E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E2295994
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54C626A1;
	Tue, 13 Feb 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXwLVOO6"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BA16217F;
	Tue, 13 Feb 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861902; cv=none; b=ipKMfI2ucwY7kPXyvrk1aGVt05wunZuwSHDIaXwCUJESUQqIGCpuPWW85OethdYQ1NReRdzbZEGbSAxQdN0UhiUNTetowgsNHMCk2oEniRRFSpXWuxT3IjWVbP2ZDmRyPu+5i5XeWAcEPMa3PSZ4VbuPGsnUl1nwZgNv3kR4lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861902; c=relaxed/simple;
	bh=yNXlZ++7NAGaOX0YYjxHAN+47k2zU7Fw/VvDET7htxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmgwyV5A8cCsfEge+beTXBVN8eUBDTTqIt6x3A5CGBfKuTY33WjLc1GTF8M5sLH9lc9J1h3LkScHZYbZ3umUtpxdFJuuCOHqzn7x9zhXzQLBWemBImZsIiPKFDLTyLPm1F68g+OfW6noSg988oY9HBmSwrD7VJSKopxZIyiqWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXwLVOO6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso421905266b.3;
        Tue, 13 Feb 2024 14:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707861898; x=1708466698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=silDmACUiIN4OlWaMhBDDBG9aJpm66HeXuSytRzPWjU=;
        b=jXwLVOO6EOauyFKCsoWBBdPtHNxyhAYfovuE8UflP7BObmCfpNI1v7sOQAJLEPj8s9
         Oba80e+noQlVz1a9oWnTOSdO+5TZJb7bUN39nFrBUtTJMk9YQTU7fMxEopEJgrO6r4f8
         wbFLmWWn6lvXo1HrJisq4CfslYGqnYg2z5J0cb1EcLUDPyBr/MeA+b1EbIqHtNhnxhh+
         XASmlWZazy15XVzWXdBrtX0OengYrnY9BdSs9VxFx0xUSSxTqRwqBq+KqDbsqq1TtXy3
         7cbsyw2oEPfm69BSY2JQy9rGr/0gL8jKqaILwMASEOnH9q49dbY2Oc+JxtDrZQurYc7S
         qlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861898; x=1708466698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=silDmACUiIN4OlWaMhBDDBG9aJpm66HeXuSytRzPWjU=;
        b=VejM2BBvn3mUeI7kPl/x+AmCCmOd/Pu9IU8+mzBdSkr9oPiz2Pjb4xK5gGpf2IGdM+
         RvygogrHGixEKcCdy4oMqVUd/KGTPldOx/ckFy5M4vxL+auHyZE1uL2fqW6j3Zs7Dy9J
         9Z/vGdJyrwBINYNd23ow7neDHJHcYGmhJpFyrtWLdw72v+KikfuMyBcvMslFHLUVSryW
         ErnWEum+JceEZxq6VNGwoOEETy/egPSQIbKPPYG62dTjPXmHOQu21srtofALyjORNhOQ
         lo6Ad1IC2LNGaQCvh1QfsQ5ZJW6eon4Os79Y5CT0Sdce+9z6Tl2pgozYI5NBqOUL8C4p
         ylBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ixz+1kLO/h/FD+RcMQpXSciQA8raUm3Yo9ZHLZ4ZWW8vH2ljYFqlvoynATHi5SAHv3duwoEOXl+O/7acgsRruVlet6aIFcvURotH
X-Gm-Message-State: AOJu0YxSK/XlVSMyNKXjUgo8tCvWZykU6vhW3aXtCXql9GUhg8fct0ei
	9Gzc5g6wxNgxK8KRhwNcECWJhDyfsbvsTHIYSL2/nAGWLQgONDPofEsh1EnnYJ4=
X-Google-Smtp-Source: AGHT+IEAUz4HcNtgkz4NzDAJ0SL5yOtJ53J5yjTRwaNv+NCAJBjyyzDAgo+kvdqTr7SoncmTgvu+8g==
X-Received: by 2002:a17:906:3942:b0:a39:6c07:d31c with SMTP id g2-20020a170906394200b00a396c07d31cmr421164eje.25.1707861897737;
        Tue, 13 Feb 2024 14:04:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2XgLzqsfLyjsePJy8TDVdmG1U/m0sZ2DzjH2daoQnPowSsVcGQ6863Gp850N7ma9gdoUnjdSurb74OPKWC+WV/3vEH5gVhcoqgKTJb4cXdn9J8VAuZNw8c4TKVbo08QGtvvRqNGyAQIPB9aXd7RGYZ/5hD1MlqnjRF90+6v3Nxo4rE+EiWw7ZlA6ZabpArjDY1G0Vo/G9lbSNZzW7M3cDPE8G3BrdJXfHDN01JWQ31UQ3+LnoSuS4yMR+Fu9l6KwB98eg4Y/VDfvfrcZ3ZdaCN+eQr4NByJAqnDk+I7SL4O+3Wk+IjgBh/rUBBV93GB3BGS1IBG/LxqbImiRXmegYczs7ZoBfFTjP2lT0n7Yd7U0c3KaCbsg7aFt7t3kMfvLxPRIU9wPKMEBszbKj0xVqThhLrn6sqHqWTsOTVsW9ErEWzkdNO2KyfXs6IQmekXXr5t/Lsvr6Dw==
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id p12-20020a170906b20c00b00a3bdf8ae86asm1706800ejz.10.2024.02.13.14.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:04:57 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH net-next v4 01/15] net: dsa: vsc73xx: use read_poll_timeout instead delay loop
Date: Tue, 13 Feb 2024 23:03:14 +0100
Message-Id: <20240213220331.239031-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213220331.239031-1-paweldembicki@gmail.com>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit switches delay loop to read_poll_timeout macro during
Arbiter empty check in adjust link function.

As Russel King suggested:

"This [change] avoids the issue that on the last iteration, the code reads
the register, test it, find the condition that's being waiting for is
false, _then_ waits and end up printing the error message - that last
wait is rather useless, and as the arbiter state isn't checked after
waiting, it could be that we had success during the last wait."

It also remove one short msleep delay.

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4:
  - Resend patch
v3:
  - Add "Reviewed-by" to commit message only
v2:
  - introduced patch

 drivers/net/dsa/vitesse-vsc73xx-core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ae70eac3be28..8b2219404601 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -779,7 +779,7 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 	 * after a PHY or the CPU port comes up or down.
 	 */
 	if (!phydev->link) {
-		int maxloop = 10;
+		int ret, err;
 
 		dev_dbg(vsc->dev, "port %d: went down\n",
 			port);
@@ -794,19 +794,16 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
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
+					1000, 10000, false,
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


