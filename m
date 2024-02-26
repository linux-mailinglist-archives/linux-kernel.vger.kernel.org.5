Return-Path: <linux-kernel+bounces-81605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226A867838
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F021F23920
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794E12B15F;
	Mon, 26 Feb 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arD/tviI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D155129A81;
	Mon, 26 Feb 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957527; cv=none; b=oGn5opE2C+0wB/7NLebimdLaWfrRI841lPaxFKpwSGtSLh5/BB/PZseD8Xqv9q6u+tUjYMZqgcZC6C0We4hwYMxCuoITaynaDbyUfMy57Fl3jUsdUcB2CWWi7MkBT8tzd4QpH01xAk0OWXeWf7teNXdhzNbW33GYPeD7yIyoBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957527; c=relaxed/simple;
	bh=IPNtP2dbEC5nwNRrbZdk3a6zN5igpayNS2XgmKDfk4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWGURrZD9pumCm/BWQyX0YutrbNquDXR7fN0vf30glqV6FhbIkIKHnh2A4W08VrsLwKKlrS3/KmiziJKqTuQ9B6Ns9SFlsxTYgTcG5cbd/uz9u+5xFOGSX1XzakdU+T5ukFjBf1NF1qBjVDf/IQOk/Bj0/JnWQoP3uuvyHL1NmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arD/tviI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708957527; x=1740493527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPNtP2dbEC5nwNRrbZdk3a6zN5igpayNS2XgmKDfk4s=;
  b=arD/tviIRB4TGhRpSJE37TCr5fzbISB4zt6QnbhqisFEK0c5YYjG++8L
   8txACz9DgI5ZvAF3im7WEkWM8doVY3/qB/9yfbWHlskH6sSg8j7YA133Z
   C8o2t9VIMvAHgEPOQkkwU2SJTWw6lWteVE/t0uqEY7A4CS7mBUGOcDowo
   qu0f97VCgiE3qrlhOdelCYmuqq2V7nnyUE0TsrmIHN0PlklZVk+h4OvSJ
   Gd0gxhe/mIe/RxKNtwdj6OF2fZOHChhapElstdsC4A2WE96Zl1VsdGwaQ
   ES00A1fT7zElNR8Lf2mTwMLPvdw0GQ/IhZlOLDiNzb4yZhVd8c3tep27H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3375106"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3375106"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:25:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937030138"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937030138"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 06:25:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 18FCD426; Mon, 26 Feb 2024 16:25:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 02/14] serial: core: Add UPIO_UNKNOWN constant for unknown port type
Date: Mon, 26 Feb 2024 16:19:18 +0200
Message-ID: <20240226142514.1485246-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some APIs we would like to assign the special value to iotype
and compare against it in another places. Introduce UPIO_UNKNOWN
for this purpose.

Note, we can't use 0, because it's a valid value for IO port access.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/serial_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 2d2ec99eca93..c2cf9484014c 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -470,6 +470,7 @@ struct uart_port {
 
 	unsigned char		iotype;			/* io access style */
 
+#define UPIO_UNKNOWN		((unsigned char)~0U)	/* UCHAR_MAX */
 #define UPIO_PORT		(SERIAL_IO_PORT)	/* 8b I/O port access */
 #define UPIO_HUB6		(SERIAL_IO_HUB6)	/* Hub6 ISA card */
 #define UPIO_MEM		(SERIAL_IO_MEM)		/* driver-specific */
-- 
2.43.0.rc1.1.gbec44491f096


