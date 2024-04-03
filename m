Return-Path: <linux-kernel+bounces-129997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CED8972FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E799B1F27BDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7E149C47;
	Wed,  3 Apr 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2uk5nOo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80B148844;
	Wed,  3 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155657; cv=none; b=C3NiWHt4TVcd1wnYynTNtUbF9T/r2Fzv+zCcG1xFBOy3WQLEV+lq5pHhjF0aGqgl69ecGQ76tnzfrguBMbhFK/NmK4pq0RJGAKx2iz2zSDu4xvB5xMFwKq8JiH3HXGx+VNKt0LODUu9OkgOJ+4QYT4oSjF0XvzpDmXL4lvLZAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155657; c=relaxed/simple;
	bh=S9rwJ5DHZRi91bSNfJSQU+68qy20MCGdSgbhClo+h0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZNqoNj7nXlGtzzBSpU9xCGg+JQj/O3wL9dVP8qPX5cjZK8jvVwl/6WCKZQJ9B90i8h5CHlucgdZa0ZdYK/Fx5PauqRAujBgiHZG76S4k6PL0M3FW3j2+GV0h6aXM8UyB0FFaj3fnmU6MVNoNbBB4/fuJ15F8Iy/ewllGP7Qu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2uk5nOo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712155654; x=1743691654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9rwJ5DHZRi91bSNfJSQU+68qy20MCGdSgbhClo+h0U=;
  b=Y2uk5nOomGBUThPtTVrZR0SXM9Aodplo+iVZj0XZpoPJdG2e3mYuXtO/
   ElY0lGCB15caeJOre6EvHblVmhyRerV7saypWNcoKtor4vV9565w/LG35
   bQyptoHdsmPk8WzdtTBQ9rgSRN/AabkT+JE+eqA5oiWL/TslIw+x031G8
   lXG1HWQpbWdy1iudUAqyKOTVxWaEA2DqQiPBZ9u7fSxyYEwXfHOd863VQ
   3CO1ukmEPyQUlqOnvx69MIeEF8I886eLoQDvEpOAj5yuLTDVQXQu+8qej
   sxKmgd5CXs7vh/vAqdSIG07QNRL/2GMr41C+xesd2ya9TVoSqjplshMbh
   Q==;
X-CSE-ConnectionGUID: bM0E4HkiSEmmEcDMxOQizQ==
X-CSE-MsgGUID: N3atT5wjRX+q/5Jl7fJE2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="17963785"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="17963785"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085163"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085163"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 07:47:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E37E33E5; Wed,  3 Apr 2024 17:47:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] serial: core: Don't count XON/XOFF in the statistics
Date: Wed,  3 Apr 2024 17:46:15 +0300
Message-ID: <20240403144722.860258-2-andriy.shevchenko@linux.intel.com>
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

Don't count XON/XOFF in the statistics in __uart_port_tx().
It will make it in align with other serial drivers. With
this change we may use uart_xmit_advance() API instead of
open coded analogue.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 0a0f6e21d40e..9579d70a367e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -767,7 +767,7 @@ enum UART_TX_FLAGS {
 	struct circ_buf *xmit = &__port->state->xmit;			      \
 	unsigned int pending;						      \
 									      \
-	for (; (for_test) && (tx_ready); (for_post), __port->icount.tx++) {   \
+	for (; (for_test) && (tx_ready); (for_post)) {			      \
 		if (__port->x_char) {					      \
 			(ch) = __port->x_char;				      \
 			(put_char);					      \
@@ -780,7 +780,7 @@ enum UART_TX_FLAGS {
 									      \
 		(ch) = xmit->buf[xmit->tail];				      \
 		(put_char);						      \
-		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;		      \
+		uart_xmit_advance(__port, 1);				      \
 	}								      \
 									      \
 	(tx_done);							      \
-- 
2.43.0.rc1.1.gbec44491f096


