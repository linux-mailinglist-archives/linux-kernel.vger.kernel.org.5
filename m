Return-Path: <linux-kernel+bounces-157607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED808B1383
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611C0B23C68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E7757F5;
	Wed, 24 Apr 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Pv3zBFK8"
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65880B;
	Wed, 24 Apr 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986788; cv=none; b=C8WmjtKz2iRlzxGBMw2RKKMCGOtDXmANyihdYTw/qVdVQVZCxw1t4LfUysILC7c2rqEtSioxwe3QC8geJJIP2k8iWhk3vAdqF/V1G0y7HrlYitnXQZJ5qbtgAYV+FvGjWhzXnjg4bE9Jsvk/sfLny6Fy95rvIp55e5Z4CxvKFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986788; c=relaxed/simple;
	bh=mtGAUP81+EmP6+VFLJ80bl9LUE0KaTLnjvBtd7w6Vtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sp4KH6U8ctp+6qBaR2OAa1CXhiGwsxpOCCFd1L0rE0w+7Jn0Jy6A2+fyKf71fyiaYu9/R8z2eJF4U405RfBmZ6lQIKjoY9RHPitmpK8SqSWALiHs2pSkQqdACmEBtgel2RYWMoxwm/p1CGKkCKtqRt+jEeLdOReLNSXJ2ulcUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Pv3zBFK8; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id 602CC65B1F;
	Wed, 24 Apr 2024 22:19:31 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:332e:0:640:784d:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 72680608FD;
	Wed, 24 Apr 2024 22:19:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IJRtcgXMoCg0-VK32ez4Y;
	Wed, 24 Apr 2024 22:19:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713986361; bh=dfDbTKHMR7KjK37OGOCNOeQF7wb5Q5FlxomK3hLIzTc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Pv3zBFK8G1+IPkYIi2usvOVeS4xkShZSUn2fkY1eeo07nriHReLISV9sXGPhiSLu8
	 WUOcnfX88MbTE7sfSJyi2YKijr2ijnQnJEEwzwCC1T50mRnT1fZK8jv1gm21P097jC
	 S5u0vskv2F0Ty1uoeSquyNP/Hkz3hCv9A+UCJKyM=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <rilian.la.te@ya.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Konstantin Pugin <ria.freelander@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v8 0/3] add support for EXAR XR20M1172 UART
Date: Wed, 24 Apr 2024 22:18:51 +0300
Message-ID: <20240424191908.32565-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
it has additional register which can change UART multiplier
to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
flag to guard access to its specific DLD register. It seems than
other EXAR SPI UART modules also have this register, but I tested
only XR20M1172.
Yes, in datasheet this register is called "DLD - Divisor Fractional"
or "DLD - Divisor Fractional Register", calling depends on datasheet
version.

I am sorry about too many submissions and top post reply. About second -
I do not know how to reply properly to this ML from GMail phone app. About first - I just
get very good feedback from Andy Shevchenko, and want to fix his review picks ASAP.

Changes in v2:
  - use full name in git authorship

Changes in v3:
  - change formatting of commit messages to unify width
  - rework commit messages according to code review
  - add XR20M117X namespace for EXAR-specific register
  - do not use UPF_MAGIC_MULTIPLIER for checking EXAR chip,
    use s->devtype directly
  - replace while loop to fls function and expanded check
  - sort compatibles
  - reformat multiline comment.

Changes in v4:
  - rebase onto tty-next branch
  - added Kconfig mention of the chip
  - used rounddown_power_of_two instead of fls and manual shift
  - used FIELD_PREP instead of custom macro
  - removed has_dld bit from common struct, replaced by check function,
    which checks directly by s->devtype
  - fixed tab count
  - properly apply Vladimir Zapolskiy's tag to patch 2 only

Changes in v5:
  - fixes for tty-next branch
  - address a new code review picks
  - send properly to all participants
  - added Ack tag

Changes in v6:
  - KConfig fixes
  - New code review fixes

Changes in v7:
  - Added missed tag
  - Added missed v5 fixes

Changes in v8:
  - Fixed semicolon
  - Added missed tags
  - Fixed commit messages
  
Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/Kconfig                    |  3 +-
 drivers/tty/serial/sc16is7xx.c                | 63 +++++++++++++++++--
 drivers/tty/serial/sc16is7xx.h                |  1 +
 drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
 drivers/tty/serial/sc16is7xx_spi.c            |  1 +
 6 files changed, 64 insertions(+), 6 deletions(-)


base-commit: 660a708098569a66a47d0abdad998e29e1259de6
-- 
2.44.0


