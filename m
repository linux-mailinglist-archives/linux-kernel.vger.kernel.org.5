Return-Path: <linux-kernel+bounces-3084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8607816729
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639731F221B5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575ABCA4D;
	Mon, 18 Dec 2023 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="gqej+RJ6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4879F8;
	Mon, 18 Dec 2023 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id CF38B603E6;
	Mon, 18 Dec 2023 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1702883551;
	bh=kzAidhy8zpKe5tgeK43XUshUlfG4P+Tce1ryVoHcL6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqej+RJ6aZ+I73/1JjzQbOu7RhV9WhSM6ZPoHEFtIR1m9bYLcXDlWiDRIp130+6sY
	 q99S+LC8Vp+gjHKdsJHSVgs3s0pfsLRTf5X1/i2YJH6gPiPIxXJnziptSbd2Dzp1WX
	 0j7+8NTsHYYT4p91u+DFJBO7dBlfvC+zACZ26UA+DiVJgEc/eTcWJyeQhanKtTlJ5U
	 X8wutJuK1Oh1nGtJXVZcSO0PMSTJsdHUWBTQvhu7Flee87P9YOkmjzE/OpCZOqCiyI
	 YWB+UMOCW9aP1YP9AGrY1qw4HTDXQpeQfMY+ea13eI/SjxKwrhXMIodI0HgwM0J9og
	 1Ij2lzTk1ELKA==
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
Subject: [RFC PATCH v5 2/6] printk: Don't try to parse DEVNAME:0.0 console options
Date: Mon, 18 Dec 2023 09:09:49 +0200
Message-ID: <20231218071020.21805-3-tony@atomide.com>
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

Trying to parse the console for a console=DEVNAME:0.0 style console does
not work as console_setup() tries to make a console index out of any
digits passed in the kernel command line for console. In the DEVNAME:0.0
case, the name can contain a device IO address.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2459,6 +2459,10 @@ static int __init console_setup(char *str)
 	if (console_opt_save(str, brl_options))
 		return 1;
 
+	/* Don't attempt to parse a DEVNAME:0.0 style console */
+	if (strchr(str, ':'))
+		return 1;
+
 	/*
 	 * Decode str into name, index, options.
 	 */
-- 
2.43.0

