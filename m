Return-Path: <linux-kernel+bounces-33152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF5836557
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9198B24FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B73D55A;
	Mon, 22 Jan 2024 14:24:45 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD23D55B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933485; cv=none; b=PaKg7jK4rculTEnH32E5IiVpFzMoSW1XCX19RxpZEjFeUfavTVBm8gC0GpWeu8+he3+tZzyQ7mOBE33NLgp4UtrapDrvsfNGbM1JSGApnWBdH7u5rpMd2BXFDwbIKcjvRMqeOy0n18BpCj3BUMDT4eWqsDiUy82ZCRwhWlbzCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933485; c=relaxed/simple;
	bh=u3lCWVWgAgWl8h7GW8PVAHDWbnbB0UjtV3vO7hRzYG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gOKe36nx2aC5iFADtZZlmS7Bp4BYTw423snJK1NegLfoYHzHCWPZCJVXU7Yp4Szo45ltlmhNVOup4LPtLg1N2YeDbC0mxeM+yrigMUJ8j3WHy6F69n76OfIw3/XFyMjqHZ98GnzqQgE70qIPnBovtVj9lR3xaM/450C7yQtfiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by xavier.telenet-ops.be with bizsmtp
	id dqQa2B00h0ZxL6o01qQbti; Mon, 22 Jan 2024 15:24:35 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvDF-00GGwo-Pc;
	Mon, 22 Jan 2024 15:24:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvE2-00CFAU-OO;
	Mon, 22 Jan 2024 15:24:34 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/4] staging: Remove EMMA Mobile USB Gadget and board staging support
Date: Mon, 22 Jan 2024 15:24:29 +0100
Message-Id: <cover.1705932585.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi Greg,

Board staging was introduced to host temporarily legacy board support
for platforms that are under active conversion to DT.  Currently it
hosts:
  1. USB Gadget support for the Kyoto Microcomputer Co. KZM-A9-Dual
     (KZM9D) development board,
  2. Display support for the Atmark Techno Armadillo-800-EVA development
     board.

During the last few years, the KZM9D development board didn't receive
much love.  Also, no one really cared about the EMMA Mobile USB Gadget
driver, which is also hosted under staging.  Recently, the SH-Mobile
LCDC DRM driver and Armadillo-800-EVA display support have been
converted to DT.

Hence this patch series removes all board staging support, together with
the now unused EMMA Mobile USB Gadget driver.

Changes compared to v1:
  - Drop RFC, widen audience,
  - Drop EMMA Mobile EV2 clkdev registration patch (merged),
  - Add Acked-by,
  - Remove Armadillo-800-EVA and core board staging code, too.

Thanks!

[1] "[PATCH/RFC 0/3] Remove KZM9D board staging support"
    https://lore.kernel.org/all/cover.1686325857.git.geert+renesas@glider.be/

Geert Uytterhoeven (4):
  staging: emxx_udc: Remove EMMA Mobile USB Gadget driver
  staging: board: Remove KZM9D board staging code
  staging: board: Remove Armadillo-800-EVA board staging code
  staging: Remove board staging code

 drivers/staging/Kconfig                 |    4 -
 drivers/staging/Makefile                |    2 -
 drivers/staging/board/Kconfig           |   12 -
 drivers/staging/board/Makefile          |    4 -
 drivers/staging/board/TODO              |    2 -
 drivers/staging/board/armadillo800eva.c |   88 -
 drivers/staging/board/board.c           |  204 --
 drivers/staging/board/board.h           |   46 -
 drivers/staging/board/kzm9d.c           |   26 -
 drivers/staging/emxx_udc/Kconfig        |   11 -
 drivers/staging/emxx_udc/Makefile       |    2 -
 drivers/staging/emxx_udc/TODO           |    6 -
 drivers/staging/emxx_udc/emxx_udc.c     | 3223 -----------------------
 drivers/staging/emxx_udc/emxx_udc.h     |  554 ----
 14 files changed, 4184 deletions(-)
 delete mode 100644 drivers/staging/board/Kconfig
 delete mode 100644 drivers/staging/board/Makefile
 delete mode 100644 drivers/staging/board/TODO
 delete mode 100644 drivers/staging/board/armadillo800eva.c
 delete mode 100644 drivers/staging/board/board.c
 delete mode 100644 drivers/staging/board/board.h
 delete mode 100644 drivers/staging/board/kzm9d.c
 delete mode 100644 drivers/staging/emxx_udc/Kconfig
 delete mode 100644 drivers/staging/emxx_udc/Makefile
 delete mode 100644 drivers/staging/emxx_udc/TODO
 delete mode 100644 drivers/staging/emxx_udc/emxx_udc.c
 delete mode 100644 drivers/staging/emxx_udc/emxx_udc.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

