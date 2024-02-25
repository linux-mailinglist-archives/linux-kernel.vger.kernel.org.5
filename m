Return-Path: <linux-kernel+bounces-80170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1B862B51
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698171C20B17
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7457817584;
	Sun, 25 Feb 2024 15:55:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A510979
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876517; cv=none; b=sXccqd67kaBSmoSPlEKo35ZQx/OHDWzNpV62ENDmMLXykZhb5iBoFyFxZplwwvMDXdJVeQL0h8yiDoylB0cd+L9u6nRZ6bjBp5hp98vgMLOrJMBy6kYJELkEbOSmpPKeZ8tfYfj/IZU9ix/OaIkoInddN9mWlWiCGS6wO/C3ftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876517; c=relaxed/simple;
	bh=1JpHSpddy36EcQ6+aJdq28iICB9b0TQZtbuvPq3JZ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZ2vSlFHqhZerVsKc5UZmMlxxUMXVSOAXnbYEq3Mpts4SRVuGAyuiKrLdWlNG6s+Ul/4fR4tWaNeUCAen387IWxSl2xJDFx47nGuQ2DRpVTt5roH8tHv8Q9RHw7KEMblB6Ywp6h5kxZKLRymO7awRsYxNCc1Lg3Ygft2uFpzL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqN-00006U-Rj; Sun, 25 Feb 2024 16:55:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqM-002pK7-Hd; Sun, 25 Feb 2024 16:55:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reGqM-00BKoo-1R;
	Sun, 25 Feb 2024 16:55:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH 0/7] extcon: Convert to platform remove callback returning void
Date: Sun, 25 Feb 2024 16:54:49 +0100
Message-ID: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1JpHSpddy36EcQ6+aJdq28iICB9b0TQZtbuvPq3JZ+g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl22LJ3SQ+x2V90+4T3aiRyKJf8uPBLY+8QQ18X kMMIsX98W+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdtiyQAKCRCPgPtYfRL+ TqBVB/9kn69bbAsltKLjjJyB0zB8C8k48RFkzSSAiaXs9ShL2josYmzWvDfyyBNCYjsfnFUy3DJ GwEDsHxDndmsjbgOFK715uxVJfZIb4u5PRg/fHOkUALjH7dnXuUnsbCtWOrrGh3eUK0on1hfHMB upxuD2fqaHqPKmmpnwbn3GQmQtycxFfnQu8mXUAS8xVwjhd4k1KIApgSETjwPy6zHekj+tY7ZSD aBilDE2LMNPEslOPU6rRqO+4csWI5gEHVnD2hbC0YBrpTpYSxFPvn9dTIbeosYhZdwmZFbrFlSz uk934IGcKsNvlXvTawQGzP6O008H2I/EUv/00UxJTqAhMFPF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts all drivers below drivers/extcon to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

All conversations are trivial, because their .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they could be
picked up individually. But I'd hope that they get picked up all
together by the extcon maintainer team.

Best regards
Uwe

Uwe Kleine-König (7):
  extcon: adc-jack: Convert to platform remove callback returning void
  extcon: intel-cht-wc: Convert to platform remove callback returning void
  extcon: intel-mrfld: Convert to platform remove callback returning void
  extcon: max3355: Convert to platform remove callback returning void
  extcon: max77843: Convert to platform remove callback returning void
  extcon: usb-gpio: Convert to platform remove callback returning void
  extcon: usbc-cros-ec: Convert to platform remove callback returning void

 drivers/extcon/extcon-adc-jack.c     | 6 ++----
 drivers/extcon/extcon-intel-cht-wc.c | 6 ++----
 drivers/extcon/extcon-intel-mrfld.c  | 6 ++----
 drivers/extcon/extcon-max3355.c      | 6 ++----
 drivers/extcon/extcon-max77843.c     | 6 ++----
 drivers/extcon/extcon-usb-gpio.c     | 6 ++----
 drivers/extcon/extcon-usbc-cros-ec.c | 6 ++----
 7 files changed, 14 insertions(+), 28 deletions(-)

base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
-- 
2.43.0


