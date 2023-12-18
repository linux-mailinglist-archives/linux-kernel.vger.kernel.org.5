Return-Path: <linux-kernel+bounces-3087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEDA816731
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB0C1C221BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016D79EB;
	Mon, 18 Dec 2023 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="oAZvLSH0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C22F519;
	Mon, 18 Dec 2023 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A32C2603E6;
	Mon, 18 Dec 2023 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1702883660;
	bh=4HBQW/GgIjvWli0+SMeQEsuVWaT3PJ2i4XEk11NeR2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAZvLSH03WJr8omtxTAFNR5axlxaIwiUYk7rcofP8YV91KcrpSfI0zudexZXWoCb2
	 rG/98zMYFsk94HO7SkUlJBrGn9kPpVMYFOD2foJJvqq5C5xEwBsRFT8HSnc///thHW
	 T1iU4Nqkmv6Y22oYioNvg+d7scPEBr5/wqdCY4VdFUmVhbd7CaHacd2jzvY3KVPKd1
	 vj7jq5f1aLJemGrXWRAgmPza0kzA0ZWcqfRb8YvkfinxWl3r3oyK2bjdPqtRbtjCXF
	 tm3ZjQ6X1jDnvFr/m4yBuZnpzJKqCidZ5l1xElaiRFbOOR9lQ4OQiSAVmbeFt7PSGw
	 dsJz7i3nbMaBg==
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
Subject: [RFC PATCH v5 5/6] serial: core: Handle serial console options
Date: Mon, 18 Dec 2023 09:09:52 +0200
Message-ID: <20231218071020.21805-6-tony@atomide.com>
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

In order to start moving the serial console quirks out of console_setup(),
let's add parsing for the quirks to the serial core layer. We can use
add_preferred_console_match() to handle the quirks.

Note that eventually we may want to set up driver specific console quirk
handling for the serial port device drivers to use. But we need to figure
out which driver(s) need to call the quirk. So for now, we just handle the
sparc quirk directly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -219,9 +219,58 @@ static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
 	return ret;
 }
 
+#ifdef __sparc__
+
+/* Handle Sparc ttya and ttyb options as done in console_setup() */
+static int serial_base_add_sparc_console(const char *dev_name, int idx)
+{
+	const char *name = NULL;
+
+	switch (idx) {
+	case 0:
+		name = "ttya";
+		break;
+	case 1:
+		name = "ttyb";
+		break;
+	default:
+		return 0;
+	}
+
+	return serial_base_add_one_prefcon(name, dev_name, idx);
+}
+
+#else
+
+static inline int serial_base_add_sparc_console(const char *dev_name, int idx)
+{
+	return 0;
+}
+
+#endif
+
 static int serial_base_add_prefcon(const char *name, int idx)
 {
 	const char *char_match __free(kfree) = NULL;
+	const char *nmbr_match __free(kfree) = NULL;
+	int ret;
+
+	/* Handle ttyS specific options */
+	if (str_has_prefix(name, "ttyS")) {
+		/* No name, just a number */
+		nmbr_match = kasprintf(GFP_KERNEL, "%i", idx);
+		if (!nmbr_match)
+			return -ENODEV;
+
+		ret = serial_base_add_one_prefcon(nmbr_match, name, idx);
+		if (ret)
+			return ret;
+
+		/* Sparc ttya and ttyb */
+		ret = serial_base_add_sparc_console(name, idx);
+		if (ret)
+			return ret;
+	}
 
 	/* Handle the traditional character device name style console=ttyS0 */
 	char_match = kasprintf(GFP_KERNEL, "%s%i", name, idx);
-- 
2.43.0

