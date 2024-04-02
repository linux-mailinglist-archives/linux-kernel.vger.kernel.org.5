Return-Path: <linux-kernel+bounces-127429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EE894B35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFC1C213CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B21B7F4;
	Tue,  2 Apr 2024 06:17:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2217588
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038650; cv=none; b=fNVgtRXPfYqWrI15pKW/czlkLM7KpGZACyySegMYtkPbdNpMimFe8XlPQwQJHVSpAfz3NS1iVkjRJX8kpskOUIGVhHmGTkLhTs0vjWSjp0121yIeTl7ZVOM3jPHPP3EN9RUS/o4m52mvVF1LdOhuDssvOPSSzHrM/sOnQ48KgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038650; c=relaxed/simple;
	bh=U+Nf1QuFWCquu473iHh/IPJTvZRvc75wzaUauYCIx+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dajboVgLG6itwHPbIjEy7ulHrEZWl57Op7FQHfGz0fTOXpeLqsRYIdAP76soFxy0Kg4JgwzjJQFe4jG7IFv0DR/wrjYucd7dg6SKdCPljAXd0DUhexilAy21fWCjIsornGr4cgzNaGA2jOaZ7LvInh/svI+pSeiZqbhnbSg9qtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrXSR-0000Os-GF; Tue, 02 Apr 2024 08:17:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrXSQ-009vd4-St; Tue, 02 Apr 2024 08:17:18 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rrXSQ-00EjtM-2h;
	Tue, 02 Apr 2024 08:17:18 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 02 Apr 2024 08:17:17 +0200
Subject: [PATCH] usb: phy-generic: add short delay after pulling the reset
 pin
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-phy-misc-v1-1-de5c17f93f17@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAOyiC2YC/x2MQQqDMBBFryKzdiCNUWivUlwkcWIGbCoZlBbx7
 g4u3+f9d4BQZRJ4NQdU2ln4WxQebQMx+zIT8qQM1lhnnLG45j9+WCJSl0w/UOySfYLqwQthqL7
 ErIeyLYuOa6XEv7v/Hs/zAvtTD7tvAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=943;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=U+Nf1QuFWCquu473iHh/IPJTvZRvc75wzaUauYCIx+0=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmC6LuNE81S0amaQmfSmF/KBh7C14Fuknru98Ch
 gLdh+mvx6eJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZgui7gAKCRC/aVhE+XH0
 qziRD/40Qtv5ffsI2duehhfk8NOoRsrlTWqzbbHUQ6rijtVH7r4gn4SHrynQwy9lC+LZT/c6Pmc
 1wRNnAmTANJregGqwNdZzpFSlj2Api0L5Kf+2XmF6+PQhs8SXGZ6JNj4sv+kkTC8WPdGIWzESar
 nwet9OqLKdYOAFqVzIyx6697EE8KTNFld/n8jnyKii2WLfyrF+KWlrvX6KB/+ySFqF+LdqFkYU4
 /p/63Fm5I2YSHNF/DoGM37wqkZDegpemwrdY2AXwHbR91dhYovElvJMIjUJQW+TrUqQcK3Io0mx
 DeXFNDzN50Dz61t1Ty2gORlPTohVrcNlUYBjOhh1NMo2WGnh9iDo6XSzYfaK9HLCjlBi190YecZ
 ZWqhiWgHYllu5ueWBe0PWapjGN4Tg/auqxX5hlxc3a7bfwITvQP+zRyd39SS5ubkoxZEajLPMmN
 vhMxztW722Jrx18VkX9yaV13E0k2hlMGoDwk2LzX3CjJbnRlleHs+5fWJoWiFxRQEVdT79tr3Vs
 zG2zljWTtjsgp1jtUjFtcmoc8FI7/bRjULQqJWhH3wuu7ukgR74pfn0YddGhr42dQAywpfIzsiP
 or3U8/uwDsTTWYhfuyIVB9wTMklcCIer1bunGG4GrByFCkud3/tnOeFRFCM1NIzwbb30/2e/XSe
 sLoEhwcpmkN5bZQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

After pulling the reset pin some phys are not immediately ready. We add
a short delay of at least 10 ms to ensure that the phy can be properly
used.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/phy/phy-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index fdcffebf415cd..e7d50e0a16123 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -71,6 +71,7 @@ static void nop_reset(struct usb_phy_generic *nop)
 	gpiod_set_value_cansleep(nop->gpiod_reset, 1);
 	usleep_range(10000, 20000);
 	gpiod_set_value_cansleep(nop->gpiod_reset, 0);
+	usleep_range(10000, 30000);
 }
 
 /* interface to regulator framework */

---
base-commit: 5bab5dc780c9ed0c69fc2f828015532acf4a7848
change-id: 20240402-phy-misc-e3f056ec3f29

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


