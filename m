Return-Path: <linux-kernel+bounces-40006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DF83D8F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1BFB43C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D312E76;
	Fri, 26 Jan 2024 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="BIHv0kK5"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF5D30B;
	Fri, 26 Jan 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266184; cv=none; b=ZJDdkeubxyU3ODCEd0aF5Qz0NqkjDbGN8aL9iBmWrwuBKCA4eJyVuT5UQj9gAw3LNDyuwMY0iNqwYv8Cu4Oveu7OEk8I8OyN6hATv1xjqBj0n5fd5rnZNPZogQUXvGXRKA4Ho/CPogY1XnLls/IkhIO1aMZHhw9BbmjsAb3TZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266184; c=relaxed/simple;
	bh=E1yEn/F9bwmHLCpl/6OPcGlQhqadbJlj7TMLIPNylCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kiGhcEOU7a6O2sjD+Iemk747vNA4NeQl7b0NpfSEj0zd/LhbV1IOM1EIIBbUsCnMbmRW7/LAoEDqbauUCNZZlGrsUcwSMVpODxO4nsquGkFY6veOB0qbzZ7JvMVWm6fIEqPtD0xJ2BbLwfT1VHtNxklf25kiWZ7WnLSvqJcreMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=BIHv0kK5; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1706266180;
	bh=NuAQ3P3OcHowxwqmPPTvuYfMUdpPDuv0q5L9YgWTHz4=;
	h=From:To:Cc:Subject:Date:From;
	b=BIHv0kK5nwyMwURrz4dVMfTbofViqg3lnGfaLM1byyEJ6ESIHIg5+VnSkQViOgU0A
	 CTYfXwjzYAbPFd86zm1cY1ncKC0xZoQIkh5pX+Q6/4+OitBt+MGQt+iHU+11f6S+Ko
	 du0wTlbHMaD3qAdfuv9RTeAshoUm3GvSSmh6gFE0=
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
	by uho.ysoft.cz (Postfix) with ESMTP id 9B060A0717;
	Fri, 26 Jan 2024 11:49:40 +0100 (CET)
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
Subject: [PATCH net v3] net: dsa: qca8k: fix illegal usage of GPIO
Date: Fri, 26 Jan 2024 11:49:35 +0100
Message-Id: <1706266175-3408-1-git-send-email-michal.vokac@ysoft.com>
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
Changes in v3:
- Keep line length under 80 characters for netdev changes

Changes in v2:
- Remove the now redundant gpiod_set_value_cansleep(1) call.

 drivers/net/dsa/qca/qca8k-8xxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index ec57d9d52072..c247ab09874c 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -2038,12 +2038,11 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	priv->info = of_device_get_match_data(priv->dev);
 
 	priv->reset_gpio = devm_gpiod_get_optional(priv->dev, "reset",
-						   GPIOD_ASIS);
+						   GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset_gpio))
 		return PTR_ERR(priv->reset_gpio);
 
 	if (priv->reset_gpio) {
-		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 		/* The active low duration must be greater than 10 ms
 		 * and checkpatch.pl wants 20 ms.
 		 */
-- 
2.1.4


