Return-Path: <linux-kernel+bounces-150244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728188A9C35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B55028511B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18820165FC6;
	Thu, 18 Apr 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="NDFuMdPF"
Received: from forward400c.mail.yandex.net (forward400c.mail.yandex.net [178.154.239.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD781649DE;
	Thu, 18 Apr 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449119; cv=none; b=s9Nsyq6lXA1beRjR1i2TExkS3aeiNp6d/alQ9dxlWm/13YsCTWmtaWF3TFO7qsT+DS2YYSfTZB8wxDtc84zkUTaW5/dxxQ3pFIkKqm9ZjIFZQfLlXfNcXWHiOb7Uj1AxIu4RWXhq2wa6Bb8lGXPex0tdZAwccK7WyBkfjVAbc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449119; c=relaxed/simple;
	bh=ex+30tcMVfxyUUaSDHrkFZx2Ws3xvFmrPzJt0E2CC+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rsJ2utA/4LBiiyXsJKK7TUWlHwwmSxcbRQd+d7YUiLW8yUFZbWYYLgYbnDwQU/PgtK6srZ9U+7PBlpiUmpEIkNmkzwxMOZstHSCVRd5odc3tSauH9fkD6+CIamBT5FZN3OR4TjYvyyV7RR2EDFIPMHe6QO8g7497M2Xgktma+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=NDFuMdPF; arc=none smtp.client-ip=178.154.239.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:c8ad:0:640:7c75:0])
	by forward400c.mail.yandex.net (Yandex) with ESMTPS id 0FEDB68E2C;
	Thu, 18 Apr 2024 16:57:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id gvF5FWNoJ8c0-8KFtarnq;
	Thu, 18 Apr 2024 16:57:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713448664; bh=FfhBEk6M6XmT6yLhIJFRQ99L15wWJZxAlbi/OQfzRCo=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=NDFuMdPFBykaLLJO4cPMMoM0oEL4+cGP/LsBY7eK6lCEPgS6x38S6Ofvr0oTrCetD
	 dxmPDbmKRe4PoxW6oAPp09/0nEEtptRqGfFPRQ+5VNJhKNLYJnyrlhaB4NQ1y2AAjJ
	 22ZDw1NDMjIxWq/osN6ftBObHAerkqy8W5h5uQCY=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
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
Subject: [PATCH v2 0/3] add support for EXAR XR20M1172 UART
Date: Thu, 18 Apr 2024 16:57:31 +0300
Message-Id: <20240418135737.3659498-1-rilian.la.te@ya.ru>
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

Changes in v2:
  use full name in git authorship

Konstantin Pugin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  serial: sc16is7xx: Add bindings documentation for EXAR XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/sc16is7xx.c                | 56 +++++++++++++++++--
 2 files changed, 53 insertions(+), 4 deletions(-)

-- 
2.34.1


