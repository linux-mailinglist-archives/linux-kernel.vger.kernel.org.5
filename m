Return-Path: <linux-kernel+bounces-34729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570268386D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADA01F25FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548F53BA;
	Tue, 23 Jan 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOHK/kbF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86AE4400;
	Tue, 23 Jan 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988462; cv=none; b=JFN5115qd4ZIHMnpo2A1H6YDJ5JQxeruZ7JQeYdGUyif+08vTFv9+MS9qISLHMvoAuuDlv7GTL1V6QSwcHhdK+I5KW+X1gXLB7DLSZf+PoJpJaDNF6axPEmYxDX3SKTMDQ0192ATgH7DWmeA+sZ25QFWBSQXRBfoG8i+2R1wG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988462; c=relaxed/simple;
	bh=45JX5R3MtKe14ZwW9pBMEaHbWJ2PGWM2phoKEB3As6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irYRVAb8xpU2MUr6V6wcGtdP/XKgWpA/AVws5UcE39F9KsgFqOnw87VPJ9wuHNARk1brqcXNUsS6ru+bZxPr2DCkQJ2gNuItj+/GYxB/fkdFl2UjRzFO4vzTHvHjHgC7IdtICkCKTUoGDqbJmyBqdn7yawvfK4j9bbvBctq4fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOHK/kbF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705988462; x=1737524462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=45JX5R3MtKe14ZwW9pBMEaHbWJ2PGWM2phoKEB3As6Y=;
  b=iOHK/kbF1RCIy31w4f2T8ABgitPlIUoG8S/2RI3TqQ4xRBpi3irxI57G
   MNCQZI+S/BYsDoVMGLE2QG2S5cn/B8BmnPCgjD7kIMuBnHxXznL66TgLT
   +dE3Rtl3ddXd/2Lkmj/gjFHvp3YqCNpvJbQQvqAHD4DQhrmCkoEcn2+iE
   2jK38+KKwLWSpZgIO/J4SnZ+Sqwgek61ZomUSOJKcCMzkits634MUWWXU
   Ueu9Rz2D4wzbN3qW+UUwXuf60g13gTZMyvEwdyniCAh2lnFdb+KYI2YYc
   9UIl82PBlrYYlqYtkqBmNn+BJbbq6Q3L0M+r29/zf8sUvZIK7aBLX7di8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14770148"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="14770148"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 21:40:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1471996"
Received: from junxiaochang.bj.intel.com ([10.238.157.86])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 21:40:44 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: bigeasy@linutronix.de,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	hao3.li@intel.com,
	lili.li@intel.com,
	jianfeng.gao@intel.com,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 1/2] printk: nbcon: move locked_port flag to struct uart_port
Date: Tue, 23 Jan 2024 13:40:32 +0800
Message-Id: <20240123054033.183114-2-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123054033.183114-1-junxiao.chang@intel.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Console pointer in uart_port might be shared among multiple uart
ports. Flag port locked by nbcon should be saved in uart_port
structure instead of in console structure.

Fixes: 6424f396c49e ("printk: nbcon: Implement processing in port->lock wrapper")
Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 include/linux/console.h     | 2 --
 include/linux/serial_core.h | 1 +
 kernel/printk/nbcon.c       | 8 ++++----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index f8a0628678886..1eb9580e9b18a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -304,7 +304,6 @@ struct nbcon_write_context {
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
- * @locked_port:	True, if the port lock is locked by nbcon
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
  * @irq_work:		Defer @kthread waking to IRQ work context
@@ -338,7 +337,6 @@ struct console {
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
-	bool			locked_port;
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
 	struct irq_work		irq_work;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 245c11753effd..b2221a50fcb29 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -488,6 +488,7 @@ struct uart_port {
 	struct uart_icount	icount;			/* statistics */
 
 	struct console		*cons;			/* struct console, if any */
+	bool			nbcon_locked_port;	/* True, if the port is locked by nbcon */
 	/* flags must be updated while holding port mutex */
 	upf_t			flags;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 1b1b585b1675b..b53d93585ee71 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1586,7 +1586,7 @@ void nbcon_acquire(struct uart_port *up)
 	if (!uart_is_nbcon(up))
 		return;
 
-	WARN_ON_ONCE(con->locked_port);
+	WARN_ON_ONCE(up->nbcon_locked_port);
 
 	do {
 		do {
@@ -1597,7 +1597,7 @@ void nbcon_acquire(struct uart_port *up)
 
 	} while (!nbcon_context_enter_unsafe(&ctxt));
 
-	con->locked_port = true;
+	up->nbcon_locked_port = true;
 }
 EXPORT_SYMBOL_GPL(nbcon_acquire);
 
@@ -1623,13 +1623,13 @@ void nbcon_release(struct uart_port *up)
 		.prio		= NBCON_PRIO_NORMAL,
 	};
 
-	if (!con->locked_port)
+	if (!up->nbcon_locked_port)
 		return;
 
 	if (nbcon_context_exit_unsafe(&ctxt))
 		nbcon_context_release(&ctxt);
 
-	con->locked_port = false;
+	up->nbcon_locked_port = false;
 }
 EXPORT_SYMBOL_GPL(nbcon_release);
 
-- 
2.34.1


