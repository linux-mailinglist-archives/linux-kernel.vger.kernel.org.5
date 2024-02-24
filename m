Return-Path: <linux-kernel+bounces-79766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856786266D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586B51C20C34
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FE4C60B;
	Sat, 24 Feb 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdvWCZAS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650F47F59;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796547; cv=none; b=mbTamu+tk0kP0zUwTZuOs5BLS4DefPyraK+l7lMXHCfDNcsx+Zy9UkGkheL/hOAslN1Yy21o2UxQ0HDLvkOSLfO3wKmX633XfTzJJno/wkPGg9P9hpb0bEb/AnVJu/gYdKEGsjvEs4/OE41HVBXzAeybvoCra3cab/InMbrLUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796547; c=relaxed/simple;
	bh=cTWwSnGLk/pM/d3HuBGFVevuzYQU4YydbqLVII6r0V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rphqdJDW6uhYDld/tTzca9+SDGzDRUqkkTUQBYigkkuwSP8TkuzpWX3T/sIZHf5gmiQRaoO3pyrRdTOVRww+lVxOgT2qrNebHUj8nomwmVmg33FnZvFD3LjVq5lNKJ1C6Peub5yFdTt69vMwYkOj3cgxh1fbzPDuEuZYyrByq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdvWCZAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ACDDC43394;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796547;
	bh=cTWwSnGLk/pM/d3HuBGFVevuzYQU4YydbqLVII6r0V4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pdvWCZASAi+WNfRDh2KsqzBL+9Hc/gzwtu7buOAMWaXRROJV1/Dt756GV8/vgOzDl
	 +9NWVatyLUb4uanYAYh/aq1FRsJM5q5IeXjSUyAGJlQvCsL48hwIK84adtC7b7EZnm
	 Lx0WjCtragrMPIW7fw42Fno5S6ALJydead7DUW4FZQZszKlx5XGU48o9IeulMRkipI
	 zJDik67RT0wgv+Y3lv0dEGP9JR+t2Z7svtiprL+gELIPFXIqQTWo2GhSj/9xr/E6lN
	 h6pppKoeplQVj36+loti7iq9it37sYNw3PGAoRp7y4TdeGvBlHor0qMVxa7GU/Jgaz
	 5xJqmXe1e6tAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A3C54E49;
	Sat, 24 Feb 2024 17:42:26 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 24 Feb 2024 18:42:24 +0100
Subject: [PATCH v2 3/7] mtd: maps: sun_uflash: Declare uflash_devinit
 static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240224-sam-fix-sparc32-all-builds-v2-3-1f186603c5c4@ravnborg.org>
References:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
In-Reply-To:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708796545; l=1022;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=1CQEn1rR62vDngISirB1bMAgXc9+BD3JSgTxbntNHpM=; =?utf-8?q?b=3DJ7vmq08a1WA/?=
 =?utf-8?q?yKaJnn8961lo1M50MdiWJaS56NAsS66meT3rhpm7+wO7l1LTep/srhdb9PoD+9SA?=
 OHZdMimeCmy5hI9xnAPkeScVn7WU6Yy3CoFvNqOgAlKwHkwNbP+z
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

This fixes the following warning:
sun_uflash.c:50:5: error: no previous prototype for 'uflash_devinit'

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/mtd/maps/sun_uflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index f58cfb15d6e8..b69dade3f7ad 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -47,7 +47,7 @@ struct map_info uflash_map_templ = {
 	.bankwidth =	UFLASH_BUSWIDTH,
 };
 
-int uflash_devinit(struct platform_device *op, struct device_node *dp)
+static int uflash_devinit(struct platform_device *op, struct device_node *dp)
 {
 	struct uflash_dev *up;
 

-- 
2.34.1


