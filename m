Return-Path: <linux-kernel+bounces-63152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B90852BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59278B21290
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53781B593;
	Tue, 13 Feb 2024 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="WFc/QEsF"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63381B598;
	Tue, 13 Feb 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814175; cv=none; b=JFlIcNUCqjA2lYfweTTp9A8CC0GvSIblkAfmgc8GPa3wejmxfPcGCFtSLCkFfA7Er9Zxz+So7ANaIfScCvR60HinyC2mHLF7lLXtVlvo43yE0PcgChnwhrv9cavoKfz/B8anCXBncWNQhvKW0yy7urFR8KVMSgL61um090kVQmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814175; c=relaxed/simple;
	bh=rz4JcM8VahfCNX3woN71uZO8vOJEYNCoO2bOK1Cp9iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiPF/SyGHO97tj2S4HG/QdK7NJcrAx8koAT88i70IHR7Mdo8cHU2vojF/ss0uVxMKeZdURY9hYld518so6retkwpxXCAlGCeKnvlyvcKV6mpiS4YxsrbODXUzOA2Q+0gX3DGau6mTchn4dkdIOA816PmO88rs3uF3fTnO0QdC/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=WFc/QEsF; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id CA61A60505;
	Tue, 13 Feb 2024 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707814172;
	bh=rz4JcM8VahfCNX3woN71uZO8vOJEYNCoO2bOK1Cp9iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFc/QEsFVnpeGM/KcSUtWxtdMucDp3wZZTotFlWXrMM7YjY1GnvEN/iYrOHemRgjc
	 HjZJdHCpH5yJDA23d8QOiTQZZzEjZf+HiPsHVuUWehCxfrrhGMYuxrquG4IWfhTeVx
	 yQqgHC97RemNrWRKPV45QIsKFQyVPVx4xtEhMZV63F9gisogLPq1XjlRtq1kBJ1SbX
	 W89NCnANAwC2EcaJphr2DpuaMRnVbVAaP7/80S2nW1kEe1Ugfn1PArDCK2gpkzsew+
	 p1i3+d8z68tDhhK4suT+vnFqpWnspwyEVEnPb9EnxmIlJzHDZFbMaw3Iw/ljTARsu/
	 sZzdwKksfG2rA==
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
Subject: [PATCH v6 5/6] serial: core: Handle serial console options
Date: Tue, 13 Feb 2024 10:45:12 +0200
Message-ID: <20240213084545.40617-6-tony@atomide.com>
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
2.43.1

