Return-Path: <linux-kernel+bounces-69961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B4A8590DA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E3B1C20DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E4A7CF2D;
	Sat, 17 Feb 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="YIfeNqHX"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C477CF0C;
	Sat, 17 Feb 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708186840; cv=none; b=gprqEi4BxBuM8eCV4svnRnSe/ZE7Iv8pzplW0xRGSIfYxKhMNty3Jeio+5i9/Kgqn42mmDyJeFdM5qNQ9FsC7IdBD5OrP+h06ekt/P0Evf4N1YvYXk/zvNmB9+jli0nAwe0tPLd0evifIdGN6cfWKuCQcwGA1O+p86KGEwuyLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708186840; c=relaxed/simple;
	bh=RMZ/XWlCqeCx+75CqNA5sIFLnWQchRr9VYsbdrIqm8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjQ336eqUlcQ74ZJkAd4r1xeVRA0YdgM7vUO0FT/E2dbi41m6c+EOG4YvyQM+RH/4/ACVOpzEwCFBjGxoaSqYEjRexVGaVqqAQ1VxOdgQZc7w3ZmvRx6nuCKJuYTVoFpAJHn8roXRTi/9vWKgmYi+q5/CZb7Y6lNiMcRWG/n5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=YIfeNqHX; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708186834; bh=RMZ/XWlCqeCx+75CqNA5sIFLnWQchRr9VYsbdrIqm8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=YIfeNqHXk/5q7NU9A7y1Pv7CWXn4HoF6uIM+QUJCPS7MOGeWDPu1MWi2QquItbGob
	 bzmUlzFCCggh4tMNC9HUo+6w+T8Ji7+utFe46Dci8cYJYCDfG5FWAMe7qBJUfb9w8c
	 SsxGtHLv0Z92T7GIfvSaSnP7TBw2dvZa6FNs3Y54=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org (open list:USB TYPEC PORT CONTROLLER DRIVERS)
Subject: [PATCH] Revert "usb: typec: tcpm: reset counter when enter into unattached state after try role"
Date: Sat, 17 Feb 2024 17:20:21 +0100
Message-ID: <20240217162023.1719738-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

The reverted commit makes the state machine only ever go from SRC_ATTACH_WAIT
to SNK_TRY in endless loop when toggling. After revert it goes to SRC_ATTACHED
after initially trying SNK_TRY earlier, as it should for toggling to ever detect
the power source mode and the port is again able to provide power to attached
power sinks.

This reverts commit 2d6d80127006ae3da26b1f21a65eccf957f2d1e5.

Cc: stable@vger.kernel.org
Fixes: 2d6d80127006 ("usb: typec: tcpm: reset counter when enter into unattached state after try role")
Signed-of-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ---
 1 file changed, 3 deletions(-)

See https://lore.kernel.org/all/odggrbbgjpardze76qiv57mw6tllisyu5sbrta37iadjzwamcv@qr3ubwnlzqqt/
for more.

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f7d7daa60c8d..295ae7eb912c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3743,9 +3743,6 @@ static void tcpm_detach(struct tcpm_port *port)
 	if (tcpm_port_is_disconnected(port))
 		port->hard_reset_count = 0;
 
-	port->try_src_count = 0;
-	port->try_snk_count = 0;
-
 	if (!port->attached)
 		return;
 
-- 
2.43.0


