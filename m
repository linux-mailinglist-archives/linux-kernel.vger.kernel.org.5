Return-Path: <linux-kernel+bounces-137509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29C889E310
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AE71C214A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F77115886D;
	Tue,  9 Apr 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="FxqWLLJQ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C3157A6A;
	Tue,  9 Apr 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689766; cv=none; b=rl4zEHFyOKb9w7I1UNjwvsUQRjdxvvX610m4MaWaYIOFfdv5Ol4FqcFmr6vaqrUxpkv0yPpB+FlczCnPW6f+M3YUWkpdVa3zYa1d3J2fOq9TsogBvV1QYZOK+bvb/fXhpzEHoaxL1Iaffamf1PkH3J/sGQbapJa/ZZdRbJAiAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689766; c=relaxed/simple;
	bh=wMDnHgnYs7AW48U2V6cSxZ0CSbn34pxaTzUEUaog99c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYI2/L96n+OLm9D5zhYqWGKxAVcxQPsmQeX3kG4dE7GCzFBXB8SO0YiTkMJLbLlYWH+9h76SnleY/vDkGD23CKjbr5q4lJXm+J7LXzPSuDJ4v2avdGe/DnPeQI2YOKPEiatdv4xr0iDf7x0kBIpqxpvIEvThMqy6FLw3bSQgTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=FxqWLLJQ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E26BA1F9E1;
	Tue,  9 Apr 2024 21:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712689755;
	bh=8HBcyBdPVsmaJNOEvQjpbeVhjHTtKMf/foYSm62Avc0=; h=From:To:Subject;
	b=FxqWLLJQAxsTD1oXA1/ZawjgTFpWvfmYc69imb17qwhNorBuNPVf0kCR0F6QCEghw
	 WflYncv6vE2DRdYP1pkNHIZ2yd25H/n3IsoCfBx6vf7PZ/OfCHmx3182sem0KfvYjr
	 IghyzGMCMRDxTVqXY/Y8ysPkGgbYhgE3ddes6XL2aYQ1dD5YTgeCiMWO0kpfHBfiyo
	 Ar11BlcwcUWeDvzURMDiL1Vy9Z2e/bhq0pzO4rtSiyd5fGLs7GoAvLiE/MHMt+CPuI
	 PT61jOkcr8C1MoxvxmEZtH1HxM3NRj/l/6AZyJVEJDAJ+QSFbJkohz51ibrEdjnmyZ
	 PNGR5iGafyRWg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v1] usb: typec: mux: gpio-sbu: Allow GPIO operations to sleep
Date: Tue,  9 Apr 2024 21:09:10 +0200
Message-Id: <20240409190910.4707-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Use gpiod_set_value_cansleep() to support gpiochips which can
sleep like, e.g. I2C GPIO expanders.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/typec/mux/gpio-sbu-mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
index ad60fd4e8431..374168482d36 100644
--- a/drivers/usb/typec/mux/gpio-sbu-mux.c
+++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
@@ -48,10 +48,10 @@ static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
 	}
 
 	if (enabled != sbu_mux->enabled)
-		gpiod_set_value(sbu_mux->enable_gpio, enabled);
+		gpiod_set_value_cansleep(sbu_mux->enable_gpio, enabled);
 
 	if (swapped != sbu_mux->swapped)
-		gpiod_set_value(sbu_mux->select_gpio, swapped);
+		gpiod_set_value_cansleep(sbu_mux->select_gpio, swapped);
 
 	sbu_mux->enabled = enabled;
 	sbu_mux->swapped = swapped;
@@ -82,7 +82,7 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
 		break;
 	}
 
-	gpiod_set_value(sbu_mux->enable_gpio, sbu_mux->enabled);
+	gpiod_set_value_cansleep(sbu_mux->enable_gpio, sbu_mux->enabled);
 
 	mutex_unlock(&sbu_mux->lock);
 
@@ -141,7 +141,7 @@ static void gpio_sbu_mux_remove(struct platform_device *pdev)
 {
 	struct gpio_sbu_mux *sbu_mux = platform_get_drvdata(pdev);
 
-	gpiod_set_value(sbu_mux->enable_gpio, 0);
+	gpiod_set_value_cansleep(sbu_mux->enable_gpio, 0);
 
 	typec_mux_unregister(sbu_mux->mux);
 	typec_switch_unregister(sbu_mux->sw);
-- 
2.39.2


