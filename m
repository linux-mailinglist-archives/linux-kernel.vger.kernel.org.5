Return-Path: <linux-kernel+bounces-63148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A2852B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4E91C229C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E581B592;
	Tue, 13 Feb 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="o9xA/RzP"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39B249E6;
	Tue, 13 Feb 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814063; cv=none; b=D9IjhWmSSrgEDxLtwVil5OThuZAFIz1BnwjKIU0hIcel3iR02ZuWdcZZ6Go3uFF7jqYXA30Dx/PmlzEJMSey/Rk+b6IujuvJVflzUd8rxLRD/+8th0fmL7RzfYj4HI7kGKhzCdG5THJdUntjzXEsCao3+VqL+1TkL9LNZCoDTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814063; c=relaxed/simple;
	bh=5SV44SWLeGqXq0dV3Uad6OtCcRq0auYBygwlmprvpbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd2C8xlTCcglBktpI1wQ1q/u/QRorqMcCFS8n65nsb7+L221PvjUN/vP3pc6T6KF2zJDG/SMFaod5+87YDB0mpbMONPCNhBtEsx8MTIumWBqpLVSi7XajPCYBLlE2QAjNyIBZDZKhykqZKDDT93C+O6lAKTqE9RsBy50xUnZ9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=o9xA/RzP; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 5411E60505;
	Tue, 13 Feb 2024 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707814061;
	bh=5SV44SWLeGqXq0dV3Uad6OtCcRq0auYBygwlmprvpbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9xA/RzPs1l774vhxgA5A4E+pBjEEBZICMQZhaGgCDoT4JJPjuhAMoJ/gemVaJpzj
	 AmO2NhG7WtllQl1n0bxkoLC4+04sLAAfxotqbVSR00hHGt7L/I87P5GsAtOuHpVKeG
	 2ORyWvG2j1WYAR7AjxStdpQPpkpTyQJxWqGW9bjAxQEiZ9+2R1yJdi/Y7IzpU9YWzR
	 oHYkGvXna+Ufnrf95zY3kZai10noSAQZOI4a1d8vNWryocMupp2zmsvZgTGA+QOMX7
	 4g9mqUApsCbTK/TzALK6ZOiRQssPLkFVb836zZAqidHw9Q3SNXF09g2cvFvfq3o9to
	 RlSQFHLOAqb6g==
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
Subject: [PATCH v6 2/6] printk: Don't try to parse DEVNAME:0.0 console options
Date: Tue, 13 Feb 2024 10:45:09 +0200
Message-ID: <20240213084545.40617-3-tony@atomide.com>
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

Prepare to parse the console for a console=DEVNAME:0.0 style consoles.
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
2.43.1

