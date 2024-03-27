Return-Path: <linux-kernel+bounces-120723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49A88DC01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F2C1F2CEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF8452F93;
	Wed, 27 Mar 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="r7A/g2cc"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CB1CA87;
	Wed, 27 Mar 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537580; cv=none; b=Ie/0EdTwjTlr+ZrKNiuEaLWHd0DHmtjC4DAzlCOccT1LHHnKSyggRHjAFBarO9/W2+Q8HLA2cFBTgCXEirtgkCeGpQtBAT+OeI2U4l4I7S3s8XVwhiDMqMOjckpa134XNBuoNt9I4n8xnTSoOhV5005mE7bUTl/3acXwJdnmvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537580; c=relaxed/simple;
	bh=hZErjMhbMur3G6+yLs7/2PSHAumNUkNnSGgGasOMYD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n11SqeeqS1YKfXBJ+CCVb6kEEUxC/+n9z/csT82VZXttD0sG09kRDvcGF/eMX9tL6hRiMb+WwthHS5wE3UXsX602OnxJDJ5RH1YLNsna88KACGTCsMfAqvAlazdfpHSe4cZUodcR0jD9pzsPmCe8z0qWns8sRS+hEZFlACW6cDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=r7A/g2cc; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 5C986604C8;
	Wed, 27 Mar 2024 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711537577;
	bh=hZErjMhbMur3G6+yLs7/2PSHAumNUkNnSGgGasOMYD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7A/g2ccUWCSqiKzLQs+I7VY2TayELWt2El9JI+6jUY943RhaHZdMz02xhMAjihkJ
	 ZVtTvGaTcJejjJfM+anyF4yeBOFC1OltUMv+bgbYpa0v2ynvX1kbk1gNIx4LEEWUWd
	 QI4ceyB2ytp+AZBjdv4h+FlBV58ZbuLxPj6Z4e7W//nZHqeN1siNTGNO8fipPZO4D5
	 AkAgruKQWGmN0zQMhQJ0p2+eMd1J/30u2kOt00rLkoFqlKh8X6ZpciLbO20HuggUST
	 wjrpshtGzhzCCEC6+5jAAOiSlKm+6L8mbJuqwbpfVq4EebtJBWTF+QW9KSnQhWEz0y
	 GJe8AIIOQQDvA==
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
Subject: [PATCH v7 7/7] Documentation: kernel-parameters: Add DEVNAME:0.0 format for serial ports
Date: Wed, 27 Mar 2024 12:59:41 +0200
Message-ID: <20240327110021.59793-8-tony@atomide.com>
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

Document the console option for DEVNAME:0.0 style addressing for serial
ports.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../admin-guide/kernel-parameters.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -785,6 +785,25 @@
 			Documentation/networking/netconsole.rst for an
 			alternative.
 
+		<DEVNAME>:<n>.<n>[,options]
+			Use the specified serial port on the serial core bus.
+			The addressing uses DEVNAME of the physical serial port
+			device, followed by the serial core controller instance,
+			and the serial port instance. The options are the same
+			as documented for the ttyS addressing above.
+
+			The mapping of the serial ports to the tty instances
+			can be viewed with:
+
+			$ ls -d /sys/bus/serial-base/devices/*:*.*/tty/*
+			/sys/bus/serial-base/devices/00:04:0.0/tty/ttyS0
+
+			In the above example, the console can be addressed with
+			console=00:04:0.0. Note that a console addressed this
+			way will only get added when the related device driver
+			is ready. The use of an earlycon parameter in addition to
+			the console may be desired for console output early on.
+
 		uart[8250],io,<addr>[,options]
 		uart[8250],mmio,<addr>[,options]
 		uart[8250],mmio16,<addr>[,options]
-- 
2.44.0

