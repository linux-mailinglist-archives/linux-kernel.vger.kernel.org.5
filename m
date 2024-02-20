Return-Path: <linux-kernel+bounces-72882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD4B85BA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2782834AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7B66B59;
	Tue, 20 Feb 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qti7E+bl"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892566B53;
	Tue, 20 Feb 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427484; cv=none; b=C04STNs4UNP+qoWVIS4AhLYj8IzklDHn80w76fYNFoBGIQ4UFQMEDLAsiPJ3jcKgPtRA8OZjmuJKKqqLw8206eXtj+q23OOpRs34GkoaaB/nmE4qbmJesUQJcfpgEGfynx25xte2ly7OLjajQj8+AL5GMUZAPwinaJ30WPbV4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427484; c=relaxed/simple;
	bh=XVDZEqs1XKALnlDFBu5ExtsMe/5zs/aTyLiZY4pOOVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f93/5ZjpAjVzUU3v6FmUD/ZXexpv0F8cXwbXt7W2pWIpwX57sYxRhiQzHsvPfPZY8AoS4XhQhlf8MdsqagKscwZ8O6O1aLaLwJfVYiC536/4VBEJQfWZB26KCi/PKaEjUCBaIhrVSYOqhfY9UImR8EGVZP0ldz3agzyQeWcIEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qti7E+bl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A8AA62000C;
	Tue, 20 Feb 2024 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xmFK5hcLCBfL8sT1NgJSxwVo8Y8dt6xsqwCFD5JhFCo=;
	b=Qti7E+blmV8mhMSo/RM3F52rfMrHLNSV34HhQ2gl4OFsTv43YEyxakXq1CeIOPzfpVW/I6
	L9TQr160H+Z+biQrF/rUpEY9b5V06RYhMtmnTy5tMFcp/kH5rxFLrKIACjecVq54JJ7YRz
	PAggqpcTeyIkVL6HM1tGLqjWHePPw7YjlU0bJOs/kLBbdegVu7naBEinskJjlBS5cwsQt5
	rAX2YSA6L25CeD8oW+wZVwoMZCCA+XCIUxDFCc58PlV1sra8lx0s1F4ZxPCdeSLou5Kawj
	iSc8G8M+1b5PGT6FWZ7WrAqofU+6WQMG/P041veBhJ9a/MnzPmLTxR8ZJMPaTg==
From: Herve Codina <herve.codina@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/2] leds: gpio: Add devlink between the leds-gpio device and the gpio used.
Date: Tue, 20 Feb 2024 12:11:05 +0100
Message-ID: <20240220111111.133826-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

When a gpio used by the leds-gpio device is removed, the leds-gpio
device continues to use this gpio. Also, when the gpio is back, the
leds-gpio still uses the old removed gpio.

A consumer/supplier relationship is missing between the leds-gpio device
(consumer) and the gpio used (supplier).

This series adds an addionnal devlink between this two device.
With this link when the gpio is removed, the leds-gpio device is also
removed.

Best regards,
Hervé Codina

Herve Codina (2):
  gpiolib: Introduce gpiod_device_add_link()
  leds: gpio: Add devlinks between the gpio consumed and the gpio leds
    device

 drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
 drivers/leds/leds-gpio.c      | 15 +++++++++++++++
 include/linux/gpio/consumer.h |  5 +++++
 3 files changed, 52 insertions(+)

-- 
2.43.0


