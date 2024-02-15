Return-Path: <linux-kernel+bounces-67589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20C856DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE94B27533
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D314B13A249;
	Thu, 15 Feb 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="g02ySvEJ"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB31386AE;
	Thu, 15 Feb 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025648; cv=none; b=hwqSypCUdgYvaU3H7bCMm+ML9UqidyM3hZvWBWDzQD6fAG1frSiF+6SLFNgZbw6nVbvR+dOB6XWFR8cu+M3LLa2oy4V+kPffTkmwoGY28j+3B3p5DNtIlgVxTPFa37OsinS+iAZhNJtVRZBQGWtwdqjyNyjRkswGSAUQSVMwqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025648; c=relaxed/simple;
	bh=pwr40pe20aNMHUfTjs/G++NlbzwOhpj6C+tL7b0oO2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUUtOERJ3epL3o/nPj2XZQFUkl7E/1VE53S9ger5MyYvaYoD8alkWdm0Sk2v2pvXhKI/7EOZNHzoC2oG981jvlIt2n3wyi005+qw2ieEGLNpEwq9QZ7dRu+kOEhdR2fUGkuFDN5Yls5FkVLHo2ynFSF9CfD7sKVjMeoqNgm25hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=g02ySvEJ; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708025635; bh=pwr40pe20aNMHUfTjs/G++NlbzwOhpj6C+tL7b0oO2A=;
	h=From:To:Cc:Subject:Date:From;
	b=g02ySvEJW41OZpOAIQqt+yYPmbgc12PSVMzwqFuTFh0V683CfHdTtB0FHTTmmxY30
	 7gjC18Wmp6M36jJ5KhHgC2rNnZ+3JqpJkU1SqX6bPQp6HMImVhsPMuYyqo3wEv/UH/
	 s7JFEWsqUUlRSlkFF+bZmE+8JFsTwtyOytylQ6NY=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-usb@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "usb: typec: tcpm: reset counter when enter into unattached state after try role"
Date: Thu, 15 Feb 2024 20:33:50 +0100
Message-ID: <20240215193352.1026707-1-megi@xff.cz>
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


