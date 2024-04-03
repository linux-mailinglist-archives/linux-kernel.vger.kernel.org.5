Return-Path: <linux-kernel+bounces-129998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F324897301
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416B41C26BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11927149DF0;
	Wed,  3 Apr 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az89PdXa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2B71494A1;
	Wed,  3 Apr 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155658; cv=none; b=PEd/OTvvOqZUQd8wZGKYFRJI4zil9LiNvvzAwbfrj/W+6Lvfdje/rNlwrJkHeqMVGvBEtxfvoABS6ArgSUy5qF1IMpE55iQbzgrvINCYCbIUVij1s241vBUiWcXOoeDKkY5LzMv/rNPTMIictmvmCseL2xWC8lHnJeZq/28o1LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155658; c=relaxed/simple;
	bh=l768EKMi5Qcmw0SI+NUxxzGDRtMSPlHXPvp9gOd0qD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5f685PcI+doO21A9zxOdGrr8XqeldP9f7XzWQqrCxYXTT7kYYSEFqQbh6pdSbBe11YjkqKFiKE0c8MbLUvbViCfbQ1Q5M2IWdhIv5AdMBva04DFEosyXZEYQpk+dysqkUmGUcnnCBzgr3By98dFKtiAdxoEOEpUlKZJCek17AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az89PdXa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712155655; x=1743691655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l768EKMi5Qcmw0SI+NUxxzGDRtMSPlHXPvp9gOd0qD8=;
  b=az89PdXatea4m3wDtjypL1chVzn31JB6erGbcLlDZW4U/1wxhQqeRSB0
   XCCLwRIzoDy5CTtgqlE6QVxol/douYLQaM9fg70AtwY2Dl87pRigA8C1h
   2eBB56OtH1FVavntgKGpvz0AzDE9n1RiqsmUzhsQeF0Ian7wAQ89LfHpX
   FG2Z3J9x9dydvLKk/e3ne+tLQ+a1CtSIWn8kzEdx5FmlxwqThGZz9KQ4u
   MyBzOouOLAl7g35o1T+iwxi6rR3oNvfxav+UKsDYgkMTbEFgtmrTW351f
   rZ5SpgQo+vuv05XAoc8yTWt9AK7BvhLTxwfiHed5kwvi1x7/hb+2Aw17n
   g==;
X-CSE-ConnectionGUID: 0N/UmaQ6QiK5PETMPvNZfQ==
X-CSE-MsgGUID: P0mmy9FSQHaRyWeAa0WVGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="17963790"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="17963790"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:47:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085160"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085160"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 07:47:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EC7EE670; Wed,  3 Apr 2024 17:47:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] serial: fsl_lpuart: Don't count XON/XOFF in the statistics
Date: Wed,  3 Apr 2024 17:46:16 +0300
Message-ID: <20240403144722.860258-3-andriy.shevchenko@linux.intel.com>
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

Don't count XON/XOFF in the statistics in lpuart32_transmit_buffer().
It will make it in align with other serial drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bbcbc91482af..a1cdb0ccc40e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -761,7 +761,6 @@ static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 
 	if (sport->port.x_char) {
 		lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
-		sport->port.icount.tx++;
 		sport->port.x_char = 0;
 		return;
 	}
-- 
2.43.0.rc1.1.gbec44491f096


