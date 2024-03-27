Return-Path: <linux-kernel+bounces-120718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEFC88DBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3512929D3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BD352F8F;
	Wed, 27 Mar 2024 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="E78haD/l"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC71CA87;
	Wed, 27 Mar 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537494; cv=none; b=hVcGWJNZthfnvMjCZkN0b7oQsKhIo4fv0rA0ZxMhAvD8rJMRJHVRNpf5vIbW3Vw8XdGUpYw4Tn0prA8x36A6qGXNgA+TLUz+Br7Rveyy1keW7EkzFER4NOC+VetqDWNXKy1eUjZr2tEfbr/6R6Ssk2HhoyctFbqgS5xuHgZP2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537494; c=relaxed/simple;
	bh=FVa5bi1yq0xqqzfDtP5OhrFMjnS0wCkQGnO4ANrGaIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZHRjgyQevlNF6Ot1//xbgw127Jw18oJe9ynZJkcgGAoQinSdxGGUyeuF8jmGOgifrS19+e2n8LqVxkTV5IuKhQOMpwNZKdCadJO2YLrGrPRPBEiYb2rsg0AuCjbtmPIW+0wYU35S61xXeOUtEpO/8IliabMkZHWxJlQXnXfvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=E78haD/l; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id DCA65604C8;
	Wed, 27 Mar 2024 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711537490;
	bh=FVa5bi1yq0xqqzfDtP5OhrFMjnS0wCkQGnO4ANrGaIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E78haD/lP+5ZeHx6W02O895pt9KyLcJ1lCN5xn6RvQjXOJwhp8hoIVNSetyk8MbBs
	 oOrHHm4BRTFP1EIPRAGzKQZRSWc9diEGPwn0pYcpcFKPx0HZLbzdVe3br1k1t9xMU/
	 aFViEEAxS0j4OGYa3bRFVVEbCj1ABYMS+580VDe6l8yC0jGtxhU2Te28uy9gLbXWcT
	 gYQyiKY2l9/K27DuVuVHY0b6tCe6cYgcujqIW6ANcUui/Tsw/5f38SYhWdOFOw4Sk3
	 q7ye56PdUCalsZh9H04+ZKjacM6nGKfzlKpYagztTm6h23pOg7P4UhZBk+rr7tS+3P
	 h7hqOgQKCFB7g==
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
Subject: [PATCH v7 5/7] serial: core: Handle serial console options
Date: Wed, 27 Mar 2024 12:59:39 +0200
Message-ID: <20240327110021.59793-6-tony@atomide.com>
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

In order to start moving the serial console quirks out of console_setup(),
let's add parsing for the quirks to the serial core layer. We can use
serial_base_add_one_prefcon() to handle the quirks.

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
+	const char *name;
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
+	if (strstarts(name, "ttyS")) {
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
2.44.0

