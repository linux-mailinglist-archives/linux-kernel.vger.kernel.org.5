Return-Path: <linux-kernel+bounces-90567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEA870151
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D57F286D66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7AC3D972;
	Mon,  4 Mar 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgi6Mo7S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA03D39B;
	Mon,  4 Mar 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555449; cv=none; b=Ggt9FFdnwnWvNSMmECY/8/gYY91TSa/ZWPmRNSnm5SuBFWz8OeMB5AwK/O5eTGaAE4gEG8Y9cfdQcUIAPKO/lKpYSFZZm8HsJEI++YQwLtFWHLOinp/u9MjBZAtDaqU86hu1r2srK21aaGVUfqdySz+Pfyx/aqSYA3/csfNhnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555449; c=relaxed/simple;
	bh=A8p5Npmvda1MkUKRvwcBNktCV2esnRfoVCvpbf/iEPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2pU89nN/wU8zPOKjoSthTcItiB4i+5q/ZCqiVTq39mRqy55cRcLEyM8mzYERlennSKJcENqemItpQ756w+hiN65eK7qpdfuhUDuj4C1vyqCUfnVSPrsm79KT0Nzc/g85m5V8z2rvnRa8IQRc7FplsTwU0bB1B6EQBuOcCQAl1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgi6Mo7S; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555448; x=1741091448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8p5Npmvda1MkUKRvwcBNktCV2esnRfoVCvpbf/iEPo=;
  b=Qgi6Mo7SnoumanKaorb2rLmC5x5r4onLSq7WCz4nDkCrx2QBl/H5MDKb
   JeFYGCx0v+vqGITSTMlnqoFX53QXvPvwmH1VWqpFD7fZ+3z5AwnYVWSl3
   3PN7eY3gNAd8EgQvGVieAEfjA77KBzq0ys7I6vwgfdmQLOLkUUrJzkvJL
   PdtbdMXJQJxwCxamT/EOmcvhWmR+/EMC+peIDYWPK9MAOUHSSYdy7/YBA
   vEVR54WRtEguJK5TI+8rDeS/OXbrP8CJepSQ3Xf8V5bYBfhs9f9aZIbc/
   xZPSzlLDBFD5Kb6SR15hmF45x5iAk+pzP/IgMAP2NyLUhF5/XjSfIhGBN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815046"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815046"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040423"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040423"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 38ECB86; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 01/14] serial: core: Move struct uart_port::quirks closer to possible values
Date: Mon,  4 Mar 2024 14:27:02 +0200
Message-ID: <20240304123035.758700-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
References: <20240304123035.758700-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it's not crystal clear what UPIO_* and UPQ_* definitions
belong to. Reindent the code, so it will be easy to read and understand.
No functional changes intended.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/serial_core.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 55b1f3ba48ac..2d2ec99eca93 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -467,8 +467,8 @@ struct uart_port {
 	unsigned int		fifosize;		/* tx fifo size */
 	unsigned char		x_char;			/* xon/xoff char */
 	unsigned char		regshift;		/* reg offset shift */
+
 	unsigned char		iotype;			/* io access style */
-	unsigned char		quirks;			/* internal quirks */
 
 #define UPIO_PORT		(SERIAL_IO_PORT)	/* 8b I/O port access */
 #define UPIO_HUB6		(SERIAL_IO_HUB6)	/* Hub6 ISA card */
@@ -479,7 +479,9 @@ struct uart_port {
 #define UPIO_MEM32BE		(SERIAL_IO_MEM32BE)	/* 32b big endian */
 #define UPIO_MEM16		(SERIAL_IO_MEM16)	/* 16b little endian */
 
-	/* quirks must be updated while holding port mutex */
+	unsigned char		quirks;			/* internal quirks */
+
+	/* internal quirks must be updated while holding port mutex */
 #define UPQ_NO_TXEN_TEST	BIT(0)
 
 	unsigned int		read_status_mask;	/* driver specific */
-- 
2.43.0.rc1.1.gbec44491f096


