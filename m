Return-Path: <linux-kernel+bounces-128257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D39895866
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779041C233E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD3A134733;
	Tue,  2 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKdtPB2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAB1332B8;
	Tue,  2 Apr 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072548; cv=none; b=tqBcOYmpD6UAxyhqQw5GeTvgnhqXKwgEOWbBXuJlB1Z4jGSuQoPfTWmzGkWcel5KZk77EdKlLDLijY25U73iL1JHrBWRaeYj+j/bazLWWsmqpf29GxF848bflNRY0sunzGMIth8IzeYYTcS2GjgZj3vOOUhrFvR/64nv1mUHL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072548; c=relaxed/simple;
	bh=iiqZkjQzkOKvdMO7xpjs8WUDJFSjOVUqV0uwKR1JZaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCflpYMSyTB6uOgTu9aIgA4n0uUbZKrjjYYVNfdTbXyXCMPKLAcFiePFq8M0/lzt34saXMHICn+ovv4zq1br82EXp8q1eyeNTw+3waDfQkx5LGkMs/Ga0yjyDGGeePyNkb7MdzYr7Lv0VwQ4+RrDrh3r/VCxIJ6TQ/ynHuEd4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKdtPB2s; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072547; x=1743608547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iiqZkjQzkOKvdMO7xpjs8WUDJFSjOVUqV0uwKR1JZaU=;
  b=PKdtPB2snKA7rhJw/MLRRPiuxcU4e+iUH0xjPBS6X6H5BzY5MICew+iX
   ftYafeQJhfSRdZXLIDPDKHTfn2ZPeLBYJA7opj/TAhFIU7T22dPrIgFUb
   m6zRPgaVRbM1XtEZwLfCaIcODFzDw/938JgjXVhv9gnI3r7vabJOQRMCp
   YkHS7FUHRv6EgPGYqM36oaG6HJyt3Rh4ZiqwfHw/Ujc2becsaErmK0m6C
   ahtJk+h1kspTX3s7dAXNVW4D8v7xRrZRusoo2fXlrL2jgYh7Ad2vInHRj
   gNpEblR6PMogrn5zkhrFcAGWJ5vhw/32Jk91lUlDJ4u/+Hvc6WTkKP0xN
   g==;
X-CSE-ConnectionGUID: CnCeqm47RNuRcEUm4YoUaw==
X-CSE-MsgGUID: CwFwFDwQTLOFNqt0/e0TzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870057"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083638"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083638"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2AFE1133; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 01/16] serial: max3100: Lock port->lock when calling uart_handle_cts_change()
Date: Tue,  2 Apr 2024 18:38:07 +0300
Message-ID: <20240402154219.3583679-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_handle_cts_change() has to be called with port lock taken,
Since we run it in a separate work, the lcok maybe not taken at
the time of running. Make sure that it's taken by explicitly doing
that. Without it we got a splat:

  WARNING: CPU: 0 PID: 10 at drivers/tty/serial/serial_core.c:3491 uart_handle_cts_change+0xa6/0xb0
  ...
  Workqueue: max3100-0 max3100_work [max3100]
  RIP: 0010:uart_handle_cts_change+0xa6/0xb0
  ...
   max3100_handlerx+0xc5/0x110 [max3100]
   max3100_work+0x12a/0x340 [max3100]

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5efb2b593be3..45022f2909f0 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -213,7 +213,7 @@ static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 	return 0;
 }
 
-static int max3100_handlerx(struct max3100_port *s, u16 rx)
+static int max3100_handlerx_unlocked(struct max3100_port *s, u16 rx)
 {
 	unsigned int status = 0;
 	int ret = 0, cts;
@@ -254,6 +254,17 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 	return ret;
 }
 
+static int max3100_handlerx(struct max3100_port *s, u16 rx)
+{
+	unsigned long flags;
+	int ret;
+
+	uart_port_lock_irqsave(&s->port, &flags);
+	ret = max3100_handlerx_unlocked(s, rx);
+	uart_port_unlock_irqrestore(&s->port, flags);
+	return ret;
+}
+
 static void max3100_work(struct work_struct *w)
 {
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
-- 
2.43.0.rc1.1.gbec44491f096


