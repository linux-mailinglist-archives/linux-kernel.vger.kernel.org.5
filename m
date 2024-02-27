Return-Path: <linux-kernel+bounces-83130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84F6868EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38702B230CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26BE13A24C;
	Tue, 27 Feb 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rvney9wi"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007555E63;
	Tue, 27 Feb 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033682; cv=none; b=HccO9634FUWqHGePI75+Dl5fKIFUDsG1fHdiBwdVGFZ4qqvnQWVqAiLwnCuKv+dIIG35b5YXW+SnScWXY2fjqjV/dXrNQkOJyGTDPvUsDZm/zL3fhc0iv1mvHlqHNrN+gdOWxHAsbI6LyANgYTgRqGNgQKaHU0hgqqoLYht4NwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033682; c=relaxed/simple;
	bh=Pl6RzP7eVBM1SX/LSO8FN5EW7VXMT3LIJ50I1lG39SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYH2ttn9WJoxTCkThHOSTzfBa8F0OtbDTSy+AwLGGjkxYnuZPV42UH5BABPblL2UFNF0zmwjy31iM3rrSJ/qpanp7hqR5JJpKFQU4C86SpXJLVGQGdhGR4PJfdN9s+mYquniZabuvffJ9CNVkdFRnbXxCg0HSQRBK2CQF8e0BQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rvney9wi; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 3641F1C0004;
	Tue, 27 Feb 2024 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709033672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QhfBBpBWQgyBYkE4IR+OyuoUGnqKUWopm8WIsqzfqQc=;
	b=Rvney9wiUF3QWebEBIP7qQyiOEdbTsvbj6jXvyFjQ8bOFtWX5pwGMFIuLdr+0MDFdq+5H5
	HAbm9mBPeLjAH/7YozPDy+6IehJINT0b9dF02C7FqjIhM4asE8h+RUHfN06OoWSg9pymY7
	NZQP+GfI/5PrSA2GWEq6Yy6teb24vJTOOyXl8XbgS5I4B2gKKLlNHr/Vl8rHnGBt1897An
	O0Jxiu0TcJTYcCtuzQ33fT8IctA3ux8fELGixbtdtzdmKuy/0WR83tipvBHvwMjEBYfFOH
	gPc4katisPQdZmH06sJ6Tnj9+vJqpyWjoiL+wSfvpAOTYUPB0BgIiNj5TjA9lA==
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio chip removal
Date: Tue, 27 Feb 2024 12:34:23 +0100
Message-ID: <20240227113426.253232-1-herve.codina@bootlin.com>
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

When a gpio chip device is removed while some related gpio are used by
the user-space (gpiomon for instance), the following warning can appear:
  remove_proc_entry: removing non-empty directory 'irq/233', leaking at least 'gpiomon'
  WARNING: CPU: 2 PID: 72 at fs/proc/generic.c:717 remove_proc_entry+0x190/0x19c
  ...
  Call trace:
    remove_proc_entry+0x190/0x19c
    unregister_irq_proc+0xd0/0x104
    free_desc+0x4c/0xc4
    irq_free_descs+0x6c/0x90
    irq_dispose_mapping+0x104/0x14c
    gpiochip_irqchip_remove+0xcc/0x1a4
    gpiochip_remove+0x48/0x100
  ...

Indeed, even if the gpio removal is notified to the gpio-cdev, the
IRQ used is not released when it should be.

This series calls the gpio removal notifier sooner in the removal
process in order to give a chance to a notifier function to release
the IRQ before releasing the IRQ mapping and adds the needed
operations to release the IRQ in the gpio cdev notifier function.

Compared to the previous iteration:
  https://lore.kernel.org/linux-kernel/20240220111019.133697-1-herve.codina@bootlin.com/
this v2 series set gdev->chip to NULL before calling gcdev_unregister().

Also, this v2 series was rebased on top of for-next branch of the GPIO
tree.

Best regards,
Hervé Codina

Changes v1 -> v2:
  - Patch 1
    Set gdev->chip to NULL before calling gcdev_unregister()

  - Patch 2
    No changes

Herve Codina (2):
  gpiolib: call gcdev_unregister() sooner in the removal operations
  gpiolib: cdev: release IRQs when the gpio chip device is removed

 drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
 drivers/gpio/gpiolib.c      |  6 +++++-
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.43.0


