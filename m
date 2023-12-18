Return-Path: <linux-kernel+bounces-3085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03981672B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA816B22403
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0779FC;
	Mon, 18 Dec 2023 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="ZeewQB+j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DE101CD;
	Mon, 18 Dec 2023 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 47712603E6;
	Mon, 18 Dec 2023 07:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1702883588;
	bh=W65hS9Wh08vuITZjnUiqgghOncGY2BRKMVeUT9vxU/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeewQB+jurbCkcW+rsOL1WOjOd7GgIAO+l6eQ+Rp7PO4wI0rfo7aRlTZHXk5jpC5f
	 vCQ6GZZjCPfJL1S9tE9w7Urn9PG4h3ecvXg2rrT/usUSAIHVRB4JWPSWoD5lTC8wsD
	 cRxMmFkWhfPvB5pEj8bz8VA/wRuegwPBSt5njkpVWwCbrBllJmCuSTs8gZrywZN7Pi
	 D9aThgs+valqUI9WjQA3Iypgd/5a3YROZmc1CSKd2ESV7exlbH0jFoX2lBlCy+Hbg3
	 KYVyAYY7J8gyAQmlo5fCwEtg+Rf2uskKA2gDxWSOfhkE2BAvg/r+OlNvoeVP1JQYV6
	 qtP8JDEI2m+bQ==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v5 3/6] printk: Flag register_console() if console is set on command line
Date: Mon, 18 Dec 2023 09:09:50 +0200
Message-ID: <20231218071020.21805-4-tony@atomide.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218071020.21805-1-tony@atomide.com>
References: <20231218071020.21805-1-tony@atomide.com>
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
2.43.0

