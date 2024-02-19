Return-Path: <linux-kernel+bounces-71932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A785ACAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24351C23565
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09B53370;
	Mon, 19 Feb 2024 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h36kLlcW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F2451033
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372699; cv=none; b=eNxv+LJR1iUxqapVgr5+vO3EdQM/FSUw3sG4RJ3CRbq9RBkg2PdXPHDgL66Gn5uemNWnS0mYF5uv00oawQXUZGPSsb1kCi6Tk9/QMEhNtfx4fRzrG/RO3qUXjMWVOobV2f/YbouJWCKfnzdSlfCmrGILUX0ruJ5cMvIQ4PRWcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372699; c=relaxed/simple;
	bh=TquE1dW+qm+nVtngnRKRNtP2lZTiAhrMZ6Ch/QG2DI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQtbnXSOQybKUj6K2A57OAiFQ6fF4xFUAiBUeWrpjRHVzvwiWCi+3DhOjp3wix2ZnB3xiXqdkxjVpqHKnp53QjARKfYBzmqj0UdnO4jKQiSB94vmmSca5ukag3YCdsXg9PgTs6c6xP80sU4OlMkrm5nK9w0PFGEGSIcP6b+W4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h36kLlcW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708372698; x=1739908698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TquE1dW+qm+nVtngnRKRNtP2lZTiAhrMZ6Ch/QG2DI4=;
  b=h36kLlcWT41Km2bnHbnqIMtkxibn6hWt5bUK+lgwpv6gr0woKlY5XHqu
   4q1fE/qYTAy8tBnmtNDFX07/cbHtvLNEi/BjL3fc3JwpGs3R91LlUsSFm
   kJZtaSFUlEzzmJw/cd6Y9MhyfVp0dx0n1PuBl15hKa+Y0KSVHOOMZ8KkH
   0CLPmiXvFe7x7exa57/TTWRdclapNwT9SXdr/TUXkfdPv+7zDAR1XE95N
   zOABs5e4HnWJvezLgTzXoBXxuXTF+4hY8NlL4F9CEeTdII6S6sONYG71X
   BJvMLIxDxymIk7QXFdUXa6BXCel4mEtW2jCzj9l91z6JqpEEeNDa9cCFP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="19893439"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19893439"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9239476"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:14 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1BC0611F855;
	Mon, 19 Feb 2024 21:58:08 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/3] mei: vsc: Call wake_up() in the threaded IRQ handler
Date: Mon, 19 Feb 2024 21:58:05 +0200
Message-Id: <20240219195807.517742-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hard IRQ handler vsc_tp_irq() is called with a raw spinlock taken.
wake_up() acquires a spinlock, a sleeping lock on PREEMPT_RT. This leads
to sleeping in atomic context.

Move the wake_up() call to the threaded IRQ handler vsc_tp_thread_isr()
where it can be safely called.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/vsc-tp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 6f4a4be6ccb5..2b69ada9349e 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -416,8 +416,6 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
 
 	atomic_inc(&tp->assert_cnt);
 
-	wake_up(&tp->xfer_wait);
-
 	return IRQ_WAKE_THREAD;
 }
 
@@ -425,6 +423,8 @@ static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
 {
 	struct vsc_tp *tp = data;
 
+	wake_up(&tp->xfer_wait);
+
 	if (tp->event_notify)
 		tp->event_notify(tp->event_notify_context);
 
-- 
2.39.2


