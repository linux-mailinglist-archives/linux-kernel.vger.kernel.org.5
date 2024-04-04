Return-Path: <linux-kernel+bounces-131666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACDF898A94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679301C283FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2F65C8FE;
	Thu,  4 Apr 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O849EgRl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E21C2A1;
	Thu,  4 Apr 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242843; cv=none; b=fV7gdlVtvkKOI31MSL7DM4m21aqMiL3ufXE0QO0Nd35wrEc3es3c3UXvLkWQEF6JRLrvv4RAhPFgDrlnDH6NFzabFv+1l2ONsN5MTZtLkfcUacl/wI96y2yX7e9HaLJwjTrD0xeuCq5LASWqoJ6euJA9naN4M+ZI5Jm8jeJWy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242843; c=relaxed/simple;
	bh=k0VeJYbpn/TShgzYqdD2a34SZlW9LgfGRcTUiFmDZpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMQ9fP8BibXJM8BbKrKLXn4ZossHTYtyIxage2zWNovppJJpOptE2udlXFLmW0TipZb3uUNRxhbNY369njcOLCAjRISb+Ix7G3uIBp2w22bT5ExJoQwfquifMj8eTqAvOBmksgKTszyQc1QvjK58QNxTjzbhDxW8VrmHRTVRZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O849EgRl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712242842; x=1743778842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k0VeJYbpn/TShgzYqdD2a34SZlW9LgfGRcTUiFmDZpg=;
  b=O849EgRlT3B2Zfy6hyTh+yMgUlPyzGLPyEHFn8+ZEELo2+N7Axwp760U
   DGdhKOvNf2EGCOzUuy6FsJHPHbzRLHCLHSGJYq+AeW0y5xDXda1Gu55z8
   PXvdiF7+aVcUqREMdZ8vSCwoKowcTk2FNqKcc7ET06B2mBfgvxGjzM0t/
   9p030X40HU/zsIge/z9BDk1IbooLO/HwOgSw8wkNpf30heMan2gxU0nIO
   14/XFOUkKdTtqueVHR8uj6ihRyAD+ukpx0OFgoHQMgyUMMT+QrwPTGqZz
   vHS1pWGCcLmW3F0DiSZY0/Lu6LLSVG2DFAHu7jimAga+TUnDaRtQPKL2D
   A==;
X-CSE-ConnectionGUID: Xw7L3KaYT6qE5fb+DpLugQ==
X-CSE-MsgGUID: Ho72HPApTxm6FQ8oLsYZPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7766868"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7766868"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:00:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086705"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086705"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 08:00:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 28DED812; Thu,  4 Apr 2024 18:00:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v1 1/1] serial: core: Clearing the circular buffer before NULLifying it
Date: Thu,  4 Apr 2024 17:59:26 +0300
Message-ID: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The circular buffer is NULLified in uart_tty_port_shutdown()
under the spin lock. However, the PM or other timer based callbacks
may still trigger after this event without knowning that buffer pointer
is not valid. Since the serial code is a bit inconsistent in checking
the buffer state (some rely on the head-tail positions, some on the
buffer pointer), it's better to have both aligned, i.e. buffer pointer
to be NULL and head-tail possitions to be the same, meaning it's empty.
This will prevent asynchronous calls to dereference NULL pointer as
reported recently in 8250 case:

  BUG: kernel NULL pointer dereference, address: 00000cf5
  Workqueue: pm pm_runtime_work
  EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
  ...
  ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
  __start_tx (drivers/tty/serial/8250/8250_port.c:1551)
  serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654)
  serial_port_runtime_suspend (include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63)
  __rpm_callback (drivers/base/power/runtime.c:393)
  ? serial_port_remove (drivers/tty/serial/serial_port.c:50)
  rpm_suspend (drivers/base/power/runtime.c:447)

The proposed change will prevent ->start_tx() to be called during
suspend on shut down port.

Fixes: 43066e32227e ("serial: port: Don't suspend if the port is still busy")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404031607.2e92eebe-lkp@intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I have got into the very similar issue while working on max3100 driver.
I haven't checked the 8250 case, but for mine the culprit is the same
and this patch fixes it. Hence I assume it will fix the 8250 case as
well.

 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a005fc06a077..ba3a674a8bbf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1788,6 +1788,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	 * Free the transmit buffer.
 	 */
 	uart_port_lock_irq(uport);
+	uart_circ_clear(&state->xmit);
 	buf = state->xmit.buf;
 	state->xmit.buf = NULL;
 	uart_port_unlock_irq(uport);
-- 
2.43.0.rc1.1.gbec44491f096


