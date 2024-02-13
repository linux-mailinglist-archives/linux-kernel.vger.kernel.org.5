Return-Path: <linux-kernel+bounces-63150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F173F852BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915471F24450
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D0224DF;
	Tue, 13 Feb 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="YY6waZAJ"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6946A20B02;
	Tue, 13 Feb 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814100; cv=none; b=bPEVuhedA1nhI45HNSrIJQ/0TpLALFId/ixnJflZHI7uJ4awzgqXPciIxYkmMkKL1yOnhN35CZMXGk8VDA8mHFEUyTwLjn+qXGwkQJhtZNox3vwrEHMK2AOiu4L4pM9ZvleBPLQ1ivZW/FK8eEdZfGSNFC85oBUhwcSkkikyY/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814100; c=relaxed/simple;
	bh=sn7vv21RB73KdSX+wG/5mdCKt2LfgvUB4qrMtCZOKKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruba703/MxLtwUf4XBmKsWptGLysv8P2fAMYNC++Cno1zVGilIgFGcIiKCeXHMMkk723INmNGgaz55f8GTEQZoZLgGevCIh0y7+IdSzrjYBvS6Gft8DKeTY5/krCqr8KWtWtgmORq43b8kUoNDFde7K0jZKmzxE21rfWlirVM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=YY6waZAJ; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 557F760505;
	Tue, 13 Feb 2024 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707814098;
	bh=sn7vv21RB73KdSX+wG/5mdCKt2LfgvUB4qrMtCZOKKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YY6waZAJ7aPs9BTx+htes4TfteIi8fqtyJP7zKy7zXWsrhcPw5iWiYFEuC472ta13
	 u7rFe9cKLY7lf9hmtli512BnDGFzQoKZwfHR34snzb3OYvCZshrS2S7+Uyl0x2UgF6
	 W+6sa1JP97F7jYR6d7026lDk1MOBlLajpjGLKWbdzf8lzuM+gCx/4Vqdr5MNm5rodi
	 x49jKYht/0A3LMFpRB8y1Ap1tcAGK50+XpXREHuAOVD+crRqHg9+PJaLfg/a/OqLUe
	 GclSUf+AQ2GkwB2WHcNBc5o0LAj8qpugI9ncA2xb4bzYshcqOg9gmthzIucJNHHwJM
	 qpcIgFDbsk/4A==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 3/6] printk: Flag register_console() if console is set on command line
Date: Tue, 13 Feb 2024 10:45:10 +0200
Message-ID: <20240213084545.40617-4-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213084545.40617-1-tony@atomide.com>
References: <20240213084545.40617-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If add_preferred_console() is not called early in setup_console(), we can
end up having register_console() call try_enable_default_console() before a
console device has called add_preferred_console().

Let's set console_set_on_cmdline flag in console_setup() to prevent this
from happening.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 kernel/printk/printk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2459,6 +2459,9 @@ static int __init console_setup(char *str)
 	if (console_opt_save(str, brl_options))
 		return 1;
 
+	/* Flag register_console() to not call try_enable_default_console() */
+	console_set_on_cmdline = 1;
+
 	/* Don't attempt to parse a DEVNAME:0.0 style console */
 	if (strchr(str, ':'))
 		return 1;
@@ -3480,7 +3483,7 @@ void register_console(struct console *newcon)
 	 * Note that a console with tty binding will have CON_CONSDEV
 	 * flag set and will be first in the list.
 	 */
-	if (preferred_console < 0) {
+	if (preferred_console < 0 && !console_set_on_cmdline) {
 		if (hlist_empty(&console_list) || !console_first()->device ||
 		    console_first()->flags & CON_BOOT) {
 			try_enable_default_console(newcon);
-- 
2.43.1

