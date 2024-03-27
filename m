Return-Path: <linux-kernel+bounces-120711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FD788DBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29CA1F2BE74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF352F8E;
	Wed, 27 Mar 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Q10j6g4b"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6138FA1;
	Wed, 27 Mar 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537361; cv=none; b=Wo6Jkdo5wDJtdcYDC4mJ9MBjKz5Qi14nNztgfB9n0BAr9UTI68HpDs3oFYC9LcVFxWwsMUY7bnoRfmsbtn7xbG+NUOW2w9ijkWMwkN9ooedvoncEU+3vNelA5VPViucXcj3zUDh9YdeFPh20RLdh1rxAeGd9V3xy+utTfC519kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537361; c=relaxed/simple;
	bh=G/4vgZPxWH/R6/+uOrquQYX/hYERIpcpxtIlcfA8+rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr7FTfYVrQQzszXlg8j8bQsF1wqofR3APJ8QnpvYeYbE08ZclL2s3W6rUXfyBWi6Ld1STnGFqZ157vKakMSIpM/BwlM93bzeYd24dkJ+sHSPkZhuqbFKyH+3hBkRUz7rRVyeVlVXfiDf5MCcgKM1fG+JktTU9Pf+vhVDYiI4Kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Q10j6g4b; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 246DD60868;
	Wed, 27 Mar 2024 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711537359;
	bh=G/4vgZPxWH/R6/+uOrquQYX/hYERIpcpxtIlcfA8+rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q10j6g4byFMzVt8WXX5cAgR7Ap0Nhzqd6ZjBYrGZJZwXr1vEfyXlRLoHu0LXBb5Ij
	 uhiaw6lhkORt6+H8vHQ0Lt0CsIGY6MAwD8Ghvu0D0pRosshsE2CORQezS6SACgVh0/
	 0pzFQW0mMqrfNsBO8v+bz8/f1hvS5ZfryvWEDeNpz3Uvt0GaD2mwVJk//d0fwPdFHG
	 76XQqBokH7EoC2Wfdzbe5DkDrGzz6/10xFWwU2yUdFzSwCX6FEXNyLyftz/4AbOsCN
	 kGmJFRXNDnZNKGkgeLUkTLYtDaVtVwINz0mwACObM1Z3+1MJdYqkMPd4Yn/HYf25yc
	 A9nP8itmf/cNg==
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
Subject: [PATCH v7 2/7] printk: Don't try to parse DEVNAME:0.0 console options
Date: Wed, 27 Mar 2024 12:59:36 +0200
Message-ID: <20240327110021.59793-3-tony@atomide.com>
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

Currently console_setup() tries to make a console index out of any digits
passed in the kernel command line for console. In the DEVNAME:0.0 case,
the name can contain a device IO address, so bail out on console names
with a ':'.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2498,6 +2498,10 @@ static int __init console_setup(char *str)
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
2.44.0

