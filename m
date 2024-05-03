Return-Path: <linux-kernel+bounces-167970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FA8BB1BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FD61F22021
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250261591F4;
	Fri,  3 May 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8eUGwp/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0B15884C;
	Fri,  3 May 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756789; cv=none; b=qHE35s0ZsdZfjvz+MMpsHd5fOOlM0tsFeFNzpUmGvQNdx0Njrh5Wk5M6Eyr6r1ccZgQfNmKmZSJ9Sic27f55szKUfA19F33r6E/LQcfolaE8ICaFzTnuPeNTMSyNdHJRPgygFq/b7cmTVsAsYUbaSJiIDnzD1rQ0fKr9WGTpOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756789; c=relaxed/simple;
	bh=hObYXdggnnGcIGY/QpdcdvBx2An46+qLFoFlXZdehw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfYchPPzXbXXGlo4R7lo+A7ZU/Dw+bo6EZHknJWpZDOjYATlKrafxH0ZSYsKA/LjtBF4595vFjR4CITyc0jnKxE8EhAEQqq98CZfYpvpKQbR410WYyaDdJYzJXALsGmiSUZ6kewuAzqFIbiSjdSSm+ea5LN4pFVn4sfUacWyde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8eUGwp/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756785; x=1746292785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hObYXdggnnGcIGY/QpdcdvBx2An46+qLFoFlXZdehw8=;
  b=G8eUGwp/93J20gykztza1xwRybtXzXM0FyYrvJk0HEnn7MqztQYvpWYi
   AXopZPmW53T/NArSvIHhRSyHKrndqE7wbZK1nnWFnAvaQvzFn2n8JuKAm
   s4XIPim2DuR7BxRk0MKmX57m55bu95hnaMmwEUSIJ4UbCqBLvb532cayP
   PLbTM/LaH+3o7O+R28i9xnLmw97T6EEqYBVgpAj6ayhthAiANjp8dNlbM
   1gIBnmgev3GlZADE1g2Afp/8rzpVPujBuvysWgPXh9QsT4VqNauma4xIx
   Q6Vil1OVT6d1Fk/o9Yd5qUNhLtrNPkE/GiYRTxraeAh30Ey4M4eHMd8d6
   w==;
X-CSE-ConnectionGUID: j3zawxqLRcy9SZsjXBw6Vg==
X-CSE-MsgGUID: zq6bbyDrRSiCyuFrUA9GiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11107817"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11107817"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:44 -0700
X-CSE-ConnectionGUID: L4cfylrMR8yzeftlaInYXQ==
X-CSE-MsgGUID: SKSyKEq2RkSlxeQUzWOEFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58415427"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:19:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9A3DDC01; Fri,  3 May 2024 20:19:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 11/13] serial: 8250_exar: Use BIT() in exar_ee_read()
Date: Fri,  3 May 2024 20:16:03 +0300
Message-ID: <20240503171917.2921250-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
References: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BIT() in exar_ee_read() like other functions do.

While at it, explain the EEPROM type and the dummy bit requirement.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 306bc6d7c141..93d2c8dd3cd8 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -324,6 +324,7 @@ static inline u8 exar_ee_read_bit(struct exar8250 *priv)
  * @ee_addr: Offset of EEPROM to read word from
  *
  * Read a single 16bit word from an Exar UART's EEPROM.
+ * The type of the EEPROM is AT93C46D.
  *
  * Return: EEPROM word
  */
@@ -340,13 +341,13 @@ static u16 exar_ee_read(struct exar8250 *priv, u8 ee_addr)
 	exar_ee_write_bit(priv, 0);
 
 	// Send address to read from
-	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
-		exar_ee_write_bit(priv, (ee_addr & i));
+	for (i = UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >= 0; i--)
+		exar_ee_write_bit(priv, ee_addr & BIT(i));
 
-	// Read data 1 bit at a time
-	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
-		data <<= 1;
-		data |= exar_ee_read_bit(priv);
+	// Read data 1 bit at a time starting with a dummy bit
+	for (i = UART_EXAR_REGB_EE_DATA_SIZE; i >= 0; i--) {
+		if (exar_ee_read_bit(priv))
+			data |= BIT(i);
 	}
 
 	exar_ee_deselect(priv);
-- 
2.43.0.rc1.1336.g36b5255a03ac


