Return-Path: <linux-kernel+bounces-90568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E764870156
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DB31C21E02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE383DB81;
	Mon,  4 Mar 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkJl1K4k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCBC3D540;
	Mon,  4 Mar 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555449; cv=none; b=I+KHiLu7WODymBUyLo2a7PazSY1045lZMOW2+J5+7qT3ZKf7t88wwUWEmxDvqUKXsxkZAJmcr2M6RexD6kR/V+uAwwvmT4h4t4QStCxOe9LZz+UdLHAIMAyhOQ1ksm220MCso7sFN442BBMZF3+x/KAJ2WJgxWB6PKrxbOW+MQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555449; c=relaxed/simple;
	bh=IPNtP2dbEC5nwNRrbZdk3a6zN5igpayNS2XgmKDfk4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnKt0FjDHFNKBdpgBh3O8XV/f8oYWfyV77C6tqsUaDn438xqGeiRGq84AIJqZiVbBjBnhHls+h71WXP5/sxBfqwLLlzM1JeByHHVaGePDjWdlx4jNGBft/xnX2dV+RgZyDkmqED2S+vgPNpilPc42+sNFgk6EQJyF8Kxim9K4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkJl1K4k; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709555448; x=1741091448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPNtP2dbEC5nwNRrbZdk3a6zN5igpayNS2XgmKDfk4s=;
  b=NkJl1K4k4UbsoNWOo51ytyhNAOYYqIyEH6svC4PfNMD4r0wkCJ5HMenP
   GxQGTtmeniF8SfZmD8Z1QL/RmpHdPcogsKHpNjPgGiM5V6FZ5gRbunMsb
   IDBvke36KnNStK7agNKa01cJd19BVVdxIsX/J13c3Qs8txGh8NkC+HoW0
   uatIUOdwoQ27xo9pFkMM245gCI/3GwvbGAbEisIlmYIW1SZwiOU6ONzEN
   cLuVhw9C53zYx5ASKYkH9RHotXq58pP4GvFcXEaA4t+trUHoTNfYkUNm8
   gokmOBK3JeuRt26W4pqhTse1NhCtbyS6GtznylzNzPab3ScCKnPaJId2+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7815060"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7815060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 04:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040422"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040422"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 04:30:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4975231F; Mon,  4 Mar 2024 14:30:37 +0200 (EET)
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
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 02/14] serial: core: Add UPIO_UNKNOWN constant for unknown port type
Date: Mon,  4 Mar 2024 14:27:03 +0200
Message-ID: <20240304123035.758700-3-andriy.shevchenko@linux.intel.com>
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


