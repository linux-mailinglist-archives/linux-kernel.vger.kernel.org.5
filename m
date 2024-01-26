Return-Path: <linux-kernel+bounces-40097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632283DA3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6CB26AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D2E18EDE;
	Fri, 26 Jan 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eiFrHeEP"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DF1B802
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272454; cv=none; b=ldPFFBPL4iDv6/5U8WiggKneDkVEQcm7N89ZkDXpHXbgJ5JrpyNS3xez6l6ZeiSlWPmbL5F/lQMctZ3BUo4QlcBz43C2IdD90H+TdwhPjkZ0Pu1BYS5ryNk4x97nD8ymgTRt62LlFp4JqKs756ZT6MYEjhgluWOgxPie/2oPzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272454; c=relaxed/simple;
	bh=3IjwAENZiSvBgm1+TCTIKPp17huEQPjULECpXRVLdSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgSyi6ePigfZ3JMHYOdxPZyuPsodEugNWHhlOpEkT7GNWs/+8gCH5kk3ruhGxOedTXdLbThkmRswNdMx2Nc3m0CqmZhezVlVvnOf2ev0R6+ZaYAwN9cE39PV8Fi8ZRXM44VPo+hhPobj9E28RyTi8zkhU7c9PqqKZSedKZVAqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eiFrHeEP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eac352733so7495755e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 04:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706272449; x=1706877249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0soW0v5yVfsW4Bsvs0S98TR5cuZkvArabmQNCI3ohqs=;
        b=eiFrHeEPeB4U5+ny/rkEvtJM4LBFbqLfOC5LuaxQfuNi5v2QKZGv0Xy4SWM/r9BnYw
         gv94sH9edUypjJ+f9jW4+jas4cIq+Qx/Z18z+eh+HctXP139WjkJ0uLeFIabetQ9yMU6
         HEDWHEE3afiV9+oqZGjXTHPOyGqcopnHewgSlTldjdvsBbJzlm1QJXp+xsm/lJRUwLbA
         v+a/IfkOmSbI/zr816qFmu6dDn/9n6XKapBcbyIV8j2TQ+w0vv40FqgFQM7PTMsQKQmG
         qlsMwHx8E1r4rL8HqB2DPB989vLx+ckRxJ2P3pTTg7LMVOjn62Ut6j0b843yCoORwVZ2
         nihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706272449; x=1706877249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0soW0v5yVfsW4Bsvs0S98TR5cuZkvArabmQNCI3ohqs=;
        b=s2aeVNckxidR4cPycZI0h8D0RZbPzyGJmU3lI49Q5S+c67ZgbfBAbQz6OchkZ22JKh
         Iyig4l/kDhMavGiP9BoDoSmLoRpVv0pgN0hbwdEnEi1KvKoBteOihMorQNRokbpvMtJr
         PVM8kJJLDgi8lDyszaMGIxSdjzpxjsildjqVWHLH5smUWDKI5RkbtSIV7y7bfn5HPLyb
         01nomLEzf1w/kEPai+Y6wZ/Li4dTfgAmJqG740qecqnj9Y5Zlqy/g1SVsooa5fvXJoL7
         lWFiNiywcHMr/nn2KyaXMAMiOFUpCVIBVm6+4k5psIIjla93Scz/BthjXpaDX2jZJjib
         Gtaw==
X-Gm-Message-State: AOJu0YzA86S+Aouu2PexztgAh1WTAHBgBcgl6fjgRJi0cGdYqsUy0AvR
	Pg/BJNtuKTg6BXIrRJRG3vLAF+EWueEzUzeoFHgFJVYNAoeZX4gTlSNaueYOTbc=
X-Google-Smtp-Source: AGHT+IGSi+euc5CvULgroSe+CYz/TOquvGv3zNUeHmiSkBBOJFVWHUdT7kDMryUMGp6vjyPeh2/Qxw==
X-Received: by 2002:a05:600c:3d18:b0:40e:e66e:956c with SMTP id bh24-20020a05600c3d1800b0040ee66e956cmr243328wmb.159.1706272448465;
        Fri, 26 Jan 2024 04:34:08 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5168:e401:d707:9e79])
        by smtp.gmail.com with ESMTPSA id t18-20020adfe112000000b0033ade19da41sm426985wrz.76.2024.01.26.04.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:34:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.8-rc2
Date: Fri, 26 Jan 2024 13:34:05 +0100
Message-Id: <20240126123405.35367-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following GPIO driver fixes for the next RC.

Thanks,
Bartosz

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.8-rc2

for you to fetch changes up to 84aef4ed59705585d629e81d633a83b7d416f5fb:

  gpio: eic-sprd: Clear interrupt after set the interrupt type (2024-01-22 11:38:08 +0100)

----------------------------------------------------------------
gpio fixes for v6.8-rc2

- add a quirk to GPIO ACPI handling to ignore touchpad wakeups
  on GPD G1619-04
- clear interrupt status bits (that may have been set before enabling
  the interrupts) after setting the interrupt type in gpio-eic-sprd

----------------------------------------------------------------
Mario Limonciello (1):
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Wenhua Lin (1):
      gpio: eic-sprd: Clear interrupt after set the interrupt type

 drivers/gpio/gpio-eic-sprd.c | 32 ++++++++++++++++++++++++++++----
 drivers/gpio/gpiolib-acpi.c  | 14 ++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

