Return-Path: <linux-kernel+bounces-36007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A04839A04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D011F2450B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD585C53;
	Tue, 23 Jan 2024 20:09:28 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7B82D8B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040567; cv=none; b=pIeAGElW2cAHx9yBIJIFTLLoqjc70i1kvDgz6U3MdT7gvtQW0/0+M6QKGa3hx3/qi4oBEtF1SiUjRYi3fEOA+9L8Azisui0PxktenBV4SbGA9Lqop4IAKf3IHhQpNXe4dxI6xm8pWlsxVwAWUGOV6UU50MdrxtRdvTs8yyIP//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040567; c=relaxed/simple;
	bh=EKUqlFr4uDKDaZclr/fZ6Kuqd0TROioAJn3MAot9Wcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gSl1MSOEjCDd/31qe+s4jcecxfqVybSh/GSml7Js7QmY/GpDMjdOiIHeMQbftcmS9dovtmrJIjVoh5sfnmyE4Vf7GnlLp0V/kiLwqVsofXxFwu4rM0HBI/KaxrFPs1IheucMKzCB47zlz9JHRLEqcza19WSkBaRZa9LxU6Isg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8ec8:24bf:c2ed:213e])
	by baptiste.telenet-ops.be with bizsmtp
	id eL9G2B00T2E7G5801L9Gb5; Tue, 23 Jan 2024 21:09:17 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSN4M-00GNTe-Ku;
	Tue, 23 Jan 2024 21:09:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSN5A-00Eta1-I1;
	Tue, 23 Jan 2024 21:09:16 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Johan Hovold <johan@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: txx9: Add missing #include <asm/txx9/generic.h>
Date: Tue, 23 Jan 2024 21:09:15 +0100
Message-Id: <818be2380061c19fe65819f7b7f10ab6e7aaa082.1706040343.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drivers/tty/serial/serial_txx9.c:933:12: error: no previous prototype for ‘early_serial_txx9_setup’ [-Werror=missing-prototypes]
  933 | int __init early_serial_txx9_setup(struct uart_port *port)
      |            ^~~~~~~~~~~~~~~~~~~~~~~

This function is called from arch/mips/txx9/generic/setup.c, and does
have a forward declaration in arch/mips/include/asm/txx9/generic.h.

As the TXX9 serial driver does not support compile-testing, and thus can
only be built on MIPS, fix this by including the MIPS-only header file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that the initial version of commit 8720037d55dbfa30 ("serial:
extend compile-test coverage") did enable compile-testing for
SERIAL_TXX9, but that was dropped later, cfr. the discussion in the
thread at
https://lore.kernel.org/all/CAMuHMdXKWDB89Hm-LQcpfTq=0yjm_xvQsQiD4QuEtW=yVymuRw@mail.gmail.com
---
 drivers/tty/serial/serial_txx9.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index e1897894a4ef58cb..abba397229581851 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -23,9 +23,10 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-
 #include <linux/io.h>
 
+#include <asm/txx9/generic.h>
+
 #define PASS_LIMIT	256
 
 #if !defined(CONFIG_SERIAL_TXX9_STDSERIAL)
-- 
2.34.1


