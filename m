Return-Path: <linux-kernel+bounces-72875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC585B9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F91285E39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A44664A2;
	Tue, 20 Feb 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RhL46L08"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222E60EFB;
	Tue, 20 Feb 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427437; cv=none; b=hb7+qOJzBpyZZWZLhq29kmKK2TuxZUdu83Unq8z0w7gnkHPCTe3oRoYfrVs/AD6YXouIac2+rtSIMkzh77CbEp5vakDwXFRuRvdBVxVk+5UKE2gyOabUg1i/yE6RDxWMr3cwJIXDpogCXduIcZVHdf2DQ1XdseNz/JNJcSDr500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427437; c=relaxed/simple;
	bh=4r5xHuvDtpeJSD5sE4rlBgiTdD5DY6axVimQFHMktKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QKuWUobNQ9Il9Y/6nZOwpgWOsCbyGKqVDm2/peJxyfnxH5OcWUcWKTRdVlfgGD9TlOyjeE+t6IJz+Id063NHkVcuU6odbjqmGoQIogkt9jS98d35SYnbLsaxlqrj0n0zgL/bJ3KpNrVpVp31q7aMfB5kBVBzLzLgi6PfNhL99Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RhL46L08; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E25031BF208;
	Tue, 20 Feb 2024 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mB1ESwZoS4AZNAYIIMVqsrJVUx3SAqDDr22iiRILhVc=;
	b=RhL46L084E3pqCNOdgocRMlArxKfoWC4Port0mGLe1Yc18cSw/vWW4XR2O4kXGcUXJlMtL
	abBo/XTi7RIhMUwlo4WIA1kCj/b7+XH7cXGd//i0Xv4UZtLONb71qpf+Kbb7OPO+Z/rikz
	hpu+K+rVJ50dNTBVl0NUfjYp145Om8qbxE7LKcE8YaTI+x8BLiXVwwlKLatliG9myUMjs/
	hbd7GY6XkL97yOEGlodaiSevZHbylEfVcr/vXPg1mB04KmITwMCq2pws83fpe8gP1/I6Gl
	d9Wuyye6lseaDJiU8OFUUCYUJazFngdh2WbtNJtr3cRXCKzFhkexJWGfueW6Fg==
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio chip removal
Date: Tue, 20 Feb 2024 12:10:16 +0100
Message-ID: <20240220111019.133697-1-herve.codina@bootlin.com>
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

Best regards,
Hervé Codina

Herve Codina (2):
  gpiolib: call gcdev_unregister() sooner in the removal operations
  gpiolib: cdev: release IRQs when the gpio chip device is removed

 drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
 drivers/gpio/gpiolib.c      |  8 +++++++-
 2 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.43.0


