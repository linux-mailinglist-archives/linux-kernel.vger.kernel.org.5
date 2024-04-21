Return-Path: <linux-kernel+bounces-152481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44DC8ABF16
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E275A1C203B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4E2DDDA;
	Sun, 21 Apr 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AfO+t8R1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF110A24;
	Sun, 21 Apr 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713699402; cv=none; b=rgP3cHq7WYpofUu6Ef8uuPTA2GN+1s1Qk1EE2OjJ2NXakFTlrQjZX0JH0e07U+UZrNhfekK9pD+euz0CQLo5OfbHJ5M0bKthNiM/wmgC+xhKEYDd5s4edLcyQgDYg05YxpJh+mGSutv5vCwjDRxpIn7Zkh4VHOwi2B3TOcDqYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713699402; c=relaxed/simple;
	bh=OpbhkVliQNWCFuHym8PGxYxe8z+jqzYUfofpXH1psvg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h385HFlHXEo4/b0OpgnpyREjThd/Zcg7+QubR5s0ybkjhq4tW1RCzHHzq3ICjObwW3Se6cSSt8+euP1mauZgf9DhrzI/oEy3osHDuoWr+xlUZNhwytQXOzqJdRDkAEJhWcnT7Qgme2ZsSeJ5Mpn8B1kbg7nqUgebbvvTPU+cf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AfO+t8R1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57B3C113CE;
	Sun, 21 Apr 2024 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713699402;
	bh=OpbhkVliQNWCFuHym8PGxYxe8z+jqzYUfofpXH1psvg=;
	h=Date:From:To:Cc:Subject:From;
	b=AfO+t8R12NPqM20oIh9/iesxZTnuWRN7lDslFAmZefcAwN0m3cjctMzyhGK5AO2F7
	 7KQEJfQ4j4Zj2W8E/6qvDUKCxNSIGfaWs1N+B7xgAyxI0qROZqAM80uz9Ljd57IZ6+
	 5YSAAXnmJUaPYTBUbFFNei5SnSVBw7/rKOm9wOdU=
Date: Sun, 21 Apr 2024 13:36:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.9-rc5
Message-ID: <ZiT6R-j2EEg1tJZH@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.9-rc5

for you to fetch changes up to ea2624b5b829b8f93c0dce25721d835969b34faf:

  serial: stm32: Reset .throttled state in .startup() (2024-04-17 13:26:45 +0200)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.9-rc5

Here are some small tty and serial driver fixes for 6.9-rc5 that resolve
a bunch of reported problems.  Included in here are:
  - MAINTAINERS and .mailmap update for Richard Genoud
  - serial core regression fixes from 6.9-rc1 changes
  - pci id cleanups
  - serial core crash fix
  - stm32 driver fixes
  - 8250 driver fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_pci: Remove redundant PCI IDs
      serial: core: Clearing the circular buffer before NULLifying it

Dan Carpenter (1):
      serial: 8250_lpc18xx: disable clks on error in probe()

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Hans de Goede (1):
      serial: 8250_dw: Revert: Do not reclock if already at correct rate

Richard Genoud (1):
      MAINTAINERS: mailmap: update Richard Genoud's email address

Tony Lindgren (2):
      serial: core: Fix regression when runtime PM is not enabled
      serial: core: Fix missing shutdown and startup for serial base port

Uwe Kleine-König (2):
      serial: stm32: Return IRQ_NONE in the ISR if no handling happend
      serial: stm32: Reset .throttled state in .startup()

 .mailmap                                           |  1 +
 .../bindings/serial/atmel,at91-usart.yaml          |  2 +-
 MAINTAINERS                                        |  2 +-
 drivers/tty/serial/8250/8250_dw.c                  |  6 ++--
 drivers/tty/serial/8250/8250_lpc18xx.c             |  2 +-
 drivers/tty/serial/8250/8250_pci.c                 |  6 ----
 drivers/tty/serial/mxs-auart.c                     |  8 +++--
 drivers/tty/serial/pmac_zilog.c                    | 14 ---------
 drivers/tty/serial/serial_base.h                   |  4 +++
 drivers/tty/serial/serial_core.c                   | 23 ++++++++++++---
 drivers/tty/serial/serial_port.c                   | 34 ++++++++++++++++++++++
 drivers/tty/serial/stm32-usart.c                   | 13 +++++++--
 12 files changed, 81 insertions(+), 34 deletions(-)

