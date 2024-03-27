Return-Path: <linux-kernel+bounces-120714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACBF88DBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512F91F2C805
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E46374C6;
	Wed, 27 Mar 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="bjPfJkNR"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38454760;
	Wed, 27 Mar 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537404; cv=none; b=fLZRzo+h1qY6HL8X+9GN1OGOnc/iTzq3lxjTwkggfQrYzMGgQqlp4ha5LnqF0mweg8C34r6DVeNfi5L7GgB9e48iEoKQeP+LAxB+g9SGXXtEb27oZ4/sUhwFU1gMsElQh4zboD+uofQu//gGTc9GC6soZI4oh2T9/9xI+1GoPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537404; c=relaxed/simple;
	bh=vUly8NV1gJ6HwWIMN43IuZorZ85oWvydp9mvQMeOnUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwbeGGBsgfGBJ8S8AgGzpWMVZ/6JwDKOzlKoxTkKEzswcHXQiyFAIy/Nn9277r9IKdGgZVJsTUeac2ZFcDOMi58L93u8Aj8lo+hb/vxfifIWalkKW085DTstnvTvbdSoWqmJHvfuADN30Th1wb0cedyNYjVnhQ6VmHhE3izqb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=bjPfJkNR; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id BF050604C8;
	Wed, 27 Mar 2024 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711537402;
	bh=vUly8NV1gJ6HwWIMN43IuZorZ85oWvydp9mvQMeOnUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjPfJkNRpv5ngZ2eGer1lsoLomOM7dTQfZAUJ8L6WksEX0Pzjoh2tIVyXQZ56QrLd
	 BMBBV6TOSf1ouheIxqZp2smMRTkEXoezDnOd0lexQk4MxtK1gy3n0d4PoHffrdYl2p
	 Lo2eX71v4VtFoOHwUGPpoQXp66UtzhNG7oeg84QVvfkBSKxAV/kZaWOdluIQjgKkUs
	 ZpuVuk+gvVQpjV6gr+AlWGAYF77u42YTgzEHB3+vWFw1K36hg3Dfkuk+vSP+24sUNP
	 XKurHZtVnH3K2FiyHqdw0k9urpYRaaLnELZmCJM5WCXtDG7N6nnch9OFdwdxIlzqz0
	 aAs0Mmem5STYA==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
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
	linux-serial@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 3/7] printk: Flag register_console() if console is set on command line
Date: Wed, 27 Mar 2024 12:59:37 +0200
Message-ID: <20240327110021.59793-4-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327110021.59793-1-tony@atomide.com>
References: <20240327110021.59793-1-tony@atomide.com>
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
@@ -2498,6 +2498,9 @@ static int __init console_setup(char *str)
 	if (console_opt_save(str, brl_options))
 		return 1;
 
+	/* Flag register_console() to not call try_enable_default_console() */
+	console_set_on_cmdline = 1;
+
 	/* Don't attempt to parse a DEVNAME:0.0 style console */
 	if (strchr(str, ':'))
 		return 1;
@@ -3501,7 +3504,7 @@ void register_console(struct console *newcon)
 	 * Note that a console with tty binding will have CON_CONSDEV
 	 * flag set and will be first in the list.
 	 */
-	if (preferred_console < 0) {
+	if (preferred_console < 0 && !console_set_on_cmdline) {
 		if (hlist_empty(&console_list) || !console_first()->device ||
 		    console_first()->flags & CON_BOOT) {
 			try_enable_default_console(newcon);
-- 
2.44.0

