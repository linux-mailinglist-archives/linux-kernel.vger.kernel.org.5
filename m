Return-Path: <linux-kernel+bounces-36882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F6183A80B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6CD2843C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D61B275;
	Wed, 24 Jan 2024 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="VczUFGy8"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60E2C684;
	Wed, 24 Jan 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096277; cv=none; b=CZV8O9lDAXtsxaUNuf7W07RdIglgrWXC6c9+6PDqYioQtNefcMw2MMEhNs1Rm9BCFS27zamcgkNxJR93O7mgpxadIy5VAITNFH/z7sggDtZyay9F0Z7oNYW2dj1b+9kYNSiwITYgA9UXSda13iO9N9JAB942yzoeGbKoDFB7eiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096277; c=relaxed/simple;
	bh=XIsLLG2ZFt0geBQkPbktDRQpYOT8D9Qc0zub56ZzOiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NYPKXvuFzfEBaQIo6eGnqoZwQqIkeXrDVaSQSppN1SwmFrULUKfMabungqz+zBCLaTRF9I6x7H8R51rUTd4X0yeRYGGGROWHyA4VANSN7waoBOQ2ZPYrsWtLSOBLW5oo35zjrxZNWmv1zK4SVYR4oo8UuzU2lCD5UKBFQqDlcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=VczUFGy8; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1706096273;
	bh=RCaHE0tC3khu9dAk+5tzPS8eeRLwaUKDTUQ372q36T8=;
	h=From:To:Cc:Subject:Date:From;
	b=VczUFGy8q6fADu33Zhmykpkrai+NufFHS2fbkU+lKfW2Tkcr1iSnGqsg/UngczZ8l
	 A1k/gAQKoFHuOC4fxct9l1xciJvJ/l7U/+pO7jg68ZwaSj7wpyZiEQ3Scy2b+Jdy9Q
	 YZkgMX/cH7g6jk4gWc3PXZW2j7HQdaKemqXbs9sU=
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
	by uho.ysoft.cz (Postfix) with ESMTP id 335E6A047B;
	Wed, 24 Jan 2024 12:37:53 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Christian Lamparter <chunkeey@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petr.benes@ysoft.com,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH net v2] net: dsa: qca8k: fix illegal usage of GPIO
Date: Wed, 24 Jan 2024 12:37:04 +0100
Message-Id: <1706096225-23468-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When working with GPIO, its direction must be set either when the GPIO is
requested by gpiod_get*() or later on by one of the gpiod_direction_*()
functions. Neither of this is done here which results in undefined
behavior on some systems.

As the reset GPIO is used right after it is requested here, it makes sense
to configure it as GPIOD_OUT_HIGH right away. With that, the following
gpiod_set_value_cansleep(1) becomes redundant and can be safely
removed.

Fixes: a653f2f538f9 ("net: dsa: qca8k: introduce reset via gpio feature")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes in v2:
- Remove the now redundant gpiod_set_value_cansleep(1) call.

 drivers/net/dsa/qca/qca8k-8xxx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec57d9d52072..3663de8f2617 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -2037,13 +2037,11 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	priv->dev = &mdiodev->dev;
 	priv->info = of_device_get_match_data(priv->dev);
 
-	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
-						   GPIOD_ASIS);
+	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset_gpio))
 		return PTR_ERR(priv->reset_gpio);
 
 	if (priv->reset_gpio) {
-		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 		/* The active low duration must be greater than 10 ms
 		 * and checkpatch.pl wants 20 ms.
 		 */
-- 
2.1.4


