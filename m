Return-Path: <linux-kernel+bounces-129995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8E9897303
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD52EB263BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331032F844;
	Wed,  3 Apr 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/kqoURk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0B2F28;
	Wed,  3 Apr 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155655; cv=none; b=Sr82TxQvlPSZ1B1BoFp1Dbw6ZYie2vhbc+bCgXmVid/gkBUtSfynJ7wDQg180VjcVy91jhVZdzAd0juxXfiXsI7+wq93KEN8uPd6gvcr0HoSWR+l2Q+yNnGIZFhkRfsLR3+Ua5N+D3BSdyDz4FygLPd1m/Gf/QdXUnRg4D0K1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155655; c=relaxed/simple;
	bh=gTksTsumFlenpsCVho1lUNgk04tJb4nLbosDVRyHfbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdOfseoT2uJmZF0ttXK9ZPDM7FFKyJzhhaMnW/ryz32QiA850ytY8x70my6mZSrXn3OogMmI7Ep6SUbqIJP5Q2GmxJasDJz63bkYxyHcN+OJkfjpeAp2prt/xP2xar/Pm6RJ9AfLdScmI/3O0oFE1hAZmdCA1CCy02gWfz/e65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/kqoURk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712155652; x=1743691652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gTksTsumFlenpsCVho1lUNgk04tJb4nLbosDVRyHfbM=;
  b=e/kqoURkQDZaCkvSUZFsTnRjc2RWK18iXjnGAUk1bO864PFMHJkXN5hJ
   PRELhXxw3SJy8BoOrIe7i5TH4djVrDMsN3b8GvsPk4OagLkWazR5ZXcvz
   2nLDIt3CSYOqjjuRMItiqOUFmDd2KEE5YtSS7LdM9jHAScCc7Z70Lsfb1
   1VVTQm+NAvUYmzzzlfVNS+fnGsid8t6y+xouY3W8wqR56HWY0+7oh3UY/
   sntNB7V4Epf4FVDjvnCVFdVeHEDwCAMFfd+WS9eewS+6vaOdCqIBNtM+a
   dsicXyjNUgrqhfA3REvMbQ1EuF+T+7baw5X0PANoFh7meLxPhdov1JGkf
   w==;
X-CSE-ConnectionGUID: 9JoAN9/tQFimWRZcF9KhQg==
X-CSE-MsgGUID: MSKqmDOQRA+uyTdMuZGpEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="17963772"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="17963772"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085161"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085161"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 07:47:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 06199812; Wed,  3 Apr 2024 17:47:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] serial: sprd: Don't count XON/XOFF in the statistics
Date: Wed,  3 Apr 2024 17:46:17 +0300
Message-ID: <20240403144722.860258-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403144722.860258-1-andriy.shevchenko@linux.intel.com>
References: <20240403144722.860258-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't count XON/XOFF in the statistics in sprd_start_tx_dma().
It will make it in align with other serial drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sprd_serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 15f14fa593da..3554b9e7678f 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -323,7 +323,6 @@ static void sprd_start_tx_dma(struct uart_port *port)
 
 	if (port->x_char) {
 		serial_out(port, SPRD_TXD, port->x_char);
-		port->icount.tx++;
 		port->x_char = 0;
 		return;
 	}
-- 
2.43.0.rc1.1.gbec44491f096


