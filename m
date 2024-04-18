Return-Path: <linux-kernel+bounces-150165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC138A9B34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D05D1C22A80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B815FA79;
	Thu, 18 Apr 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="QYJYysT4"
Received: from forward400b.mail.yandex.net (forward400b.mail.yandex.net [178.154.239.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A315CD50;
	Thu, 18 Apr 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446733; cv=none; b=LwnDTH/G/Ui2bzCOa7oL6hc7GfnB6bww/uoQu08JU7qUjv80SaD1EjcSkJkzh8Tklf611tqrs1R3iCC/ahTSYvqA8eQSH16bJFs7lbv0W5lsCLCtj8iVhCzwpRpfVoUcCZEDNA2Pj2kVkJO1qAkENR9zKdg7ykrC8RyjrjykOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446733; c=relaxed/simple;
	bh=6WR78XuM8lUYQarv1w5dNxtl+kh5e6PBz0ljAp9dGsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JTj8d05JpqtzlzSZj1KFWnVGK0IL7rpvy8P6Xd9Nu6nSK01f5MilDf9bQs9Z406TSa7QZ7AUFKDzcB9h5BnboXLUV/4STDO8k+tshVJZTgK7iw4MBLJhcM07kgrCe0B/kzCYI9FqX1t+NXBG98uA82lpdwn3RFlGvgbfoPkuJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=QYJYysT4; arc=none smtp.client-ip=178.154.239.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c05:84:0:640:40f8:0])
	by forward400b.mail.yandex.net (Yandex) with ESMTPS id 9CE4C7545B;
	Thu, 18 Apr 2024 16:25:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HPFFWsDX0Cg0-tfjEwGt0;
	Thu, 18 Apr 2024 16:25:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1713446718; bh=DVS5WHJ+HqA1KWKdi8bTsjkikj5AFrUnyRjvjUbKEEA=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=QYJYysT4pboOFWTNMJVyx+BY0+KBJ7siT49IIp4Q4OLCbbPfAmEgqa94uouumbEhR
	 +oFc4JEDEIQEjXp3Suq5CuW3Hvh3ZZY4MpIYljnCQ3RuOM09QUWpYkipSQD6UMwKOC
	 nPmctG7QZUCFrLMt2JWvsE5Kgv8fpz6OygRHTub8=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Konstantin <rilian.la.te@ya.ru>
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
Subject: [PATCH 0/3] add support for EXAR XR20M1172 UART
Date: Thu, 18 Apr 2024 16:25:02 +0300
Message-Id: <20240418132508.3447800-1-rilian.la.te@ya.ru>
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

Konstantin (3):
  serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
  serial: sc16is7xx: Add bindings documentation for EXAR XR20M1172 UART
  serial: sc16is7xx: add support for EXAR XR20M1172 UART

 .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
 drivers/tty/serial/sc16is7xx.c                | 56 +++++++++++++++++--
 2 files changed, 53 insertions(+), 4 deletions(-)

-- 
2.34.1


