Return-Path: <linux-kernel+bounces-150539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8A8AA0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200081F21E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A7117164F;
	Thu, 18 Apr 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="lWsXwBeY"
Received: from forward401a.mail.yandex.net (forward401a.mail.yandex.net [178.154.239.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B543AA2;
	Thu, 18 Apr 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460004; cv=none; b=pnvx2hYV6KEM9hb8htljT/RKsO2qtoaZoHs+FtZKb01ACgJ87JyOEeyKFDdNgm551/VqgBvIVJhnXK5GDzs6ctY6612jaEWNbel5gpXPA8U+0Zc489xcqPm0b+w26B/4fWFhepN1H82JPqW5HCRKn7q7+NLwMfBDDgwGczXoo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460004; c=relaxed/simple;
	bh=bTGTC2b2ikJQMVlDSeZIfpkVxKwxgckKEtIc7PIXIus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzYQroSRYWgH5y4bLXzebhnYO6Qxi+7FtRkQExuKeAyv3yI/ru6XiH4PwAIqGczdawxI1jsVTWMxee5bS8i5Pgx35ZHLMO0RkZPZuJAaAJYjyCbYtBhZO4btQLHGqsf/6KbZL86GsSlgQPjLmYtpXMoeufUaM/GZVgMLVBDGXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=lWsXwBeY; arc=none smtp.client-ip=178.154.239.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:2c01:0:640:acf3:0])
	by forward401a.mail.yandex.net (Yandex) with ESMTPS id BFD5860DFE;
	Thu, 18 Apr 2024 20:06:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id M6JHjm3m3Gk0-xfkrvejs;
	Thu, 18 Apr 2024 20:06:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713459984; bh=Linf+kVK6y/ZgKvcMKej4Dz6kiLTbngwEJFfajgKgYw=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=lWsXwBeYWx01buT3Aiv7K5MzIJol2uof7H295aERZxzpw+1xA5RDqF92srdPimBUH
	 duz2mphU+LcYPUiEn48YlFSSmN4PDd7bX4Qsms+5GRq/SQdc9ZKA6n1Sny26vMOrnQ
	 vji59BLhE0LT+GKi2AxQ9nl28Djni7fVS/Z9ogNI=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin Pugin <rilian.la.te@ya.ru>
To: 
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 0/3] add support for EXAR XR20M1172 UART
Date: Thu, 18 Apr 2024 20:06:04 +0300
Message-Id: <20240418170610.759838-1-rilian.la.te@ya.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Pugin <ria.freelander@gmail.com>

EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
it has additional register which can change UART multiplier
to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
flag to guard access to its specific DLD register. It seems than
other EXAR SPI UART modules also have this register, but I tested
only XR20M1172.
Yes, in datasheet this register is called "DLD - Divisor Fractional"
or "DLD - Divisor Fractional Register", calling depends on datasheet
version.

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

Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/sc16is7xx.c                | 57 +++++++++++++++++--
 2 files changed, 53 insertions(+), 5 deletions(-)

-- 
2.34.1


