Return-Path: <linux-kernel+bounces-81507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380AB8676DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58531F26035
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7A12BF25;
	Mon, 26 Feb 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dZq1GW+U"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B512BE8A;
	Mon, 26 Feb 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954824; cv=none; b=m3pNUoPHYuh2nTuMTlLrfw4B3b/kovL7RKuL2jneWaPg8a92QUHI0Rw6lZw2TOSGar90rixM7FyhE3G8ZKCBkNDo8n9+sY1QLTYb/nq6d8dJDmXFn+77yisXJ+dQyINrtZjgXPYcZyoUndcA9z5YF9gg48yGBJtd2lGRU0vmSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954824; c=relaxed/simple;
	bh=t9DftvwHYXJXtsEXtK9HBnIXPvK2VHYobKs97PldUo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3pSApAeDyx3mMCf3WcfoE5IAup/8KUGQxUuon5PSrpoqQR3VlS8djMj7CVOuWH+wERWRfRF0PeEwi9C5dpLSBp1W0e7zq6akdISiVZNhOtpaVFxRchuPLQNvsKgVsqwS41F+RFjF2FfJx9SNVrXYP23YpXIJgejk63y16CFXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dZq1GW+U; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A97840005;
	Mon, 26 Feb 2024 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vt7pqaInPUQVg2cWblp5rRamZytG6+i7+g/PwgWu1us=;
	b=dZq1GW+UEpEo83BboWrvtDMWPAGFxaUcbSnq/vgaLFIGb3CkEZIaUI1YIvvZqlgDXE1Iux
	qYyuOcp38TVii0QQprYgqIgCWziChp8AMytvNLa7UnWIIH0eMg2FarVR56sIEbv0aV6qhg
	He2m8S8XsrzJWdk07PZMGgdkCy1QN013XLrsXjHamf3eWAxJ4llWNzrE5eyiHhZkrksWZX
	GG01sjWDKSJC5RYZ8LRjkmV3J1WiEX5tE3MYHS5DrrDmtKeVPlJajMhrTwdxYmisI4skUW
	g8Wt4FlGf7hxKjHo2OTdVlQ+PTW2JlHnevhyr+STMMnMqryTb1M57Vans0pN3g==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 26 Feb 2024 14:39:58 +0100
Subject: [PATCH net-next v9 07/13] ptp: Move from simple ida to xarray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-feature_ptp_netnext-v9-7-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
In-Reply-To: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com

Move from simple ida to xarray for storing and loading the ptp_clock
pointer. This prepares support for future hardware timestamp selection by
being able to link the ptp clock index to its pointer.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v8:
- New patch
---
 drivers/ptp/ptp_clock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3aaf1a3430c5..f374b1e89780 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -31,7 +31,7 @@ struct class *ptp_class;
 
 static dev_t ptp_devt;
 
-static DEFINE_IDA(ptp_clocks_map);
+static DEFINE_XARRAY_FLAGS(ptp_clocks_map, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC);
 
 /* time stamp event queue operations */
 
@@ -201,7 +201,7 @@ static void ptp_clock_release(struct device *dev)
 	bitmap_free(tsevq->mask);
 	kfree(tsevq);
 	debugfs_remove(ptp->debugfs_root);
-	ida_free(&ptp_clocks_map, ptp->index);
+	xa_erase(&ptp_clocks_map, ptp->index);
 	kfree(ptp);
 }
 
@@ -246,11 +246,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp == NULL)
 		goto no_memory;
 
-	index = ida_alloc_max(&ptp_clocks_map, MINORMASK, GFP_KERNEL);
-	if (index < 0) {
-		err = index;
+	err = xa_alloc(&ptp_clocks_map, &index, ptp, xa_limit_31b,
+		       GFP_KERNEL);
+	if (err)
 		goto no_slot;
-	}
 
 	ptp->clock.ops = ptp_clock_ops;
 	ptp->info = info;
@@ -378,7 +377,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	list_del(&queue->qlist);
 	kfree(queue);
 no_memory_queue:
-	ida_free(&ptp_clocks_map, index);
+	xa_erase(&ptp_clocks_map, index);
 no_slot:
 	kfree(ptp);
 no_memory:
@@ -511,7 +510,7 @@ static void __exit ptp_exit(void)
 {
 	class_destroy(ptp_class);
 	unregister_chrdev_region(ptp_devt, MINORMASK + 1);
-	ida_destroy(&ptp_clocks_map);
+	xa_destroy(&ptp_clocks_map);
 }
 
 static int __init ptp_init(void)

-- 
2.25.1


