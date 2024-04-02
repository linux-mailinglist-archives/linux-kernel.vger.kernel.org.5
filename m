Return-Path: <linux-kernel+bounces-128253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7901089585C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5499B23D88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8795132464;
	Tue,  2 Apr 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9Xpanjj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD584FCD;
	Tue,  2 Apr 2024 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072545; cv=none; b=OAbBVgl+SaRfsWGuNZmNMgDZGZ3h5dGWt+W+HMum1u/QjIER6Neu4cAceyoavD6eh9ZSrQTwSkbCzIZB3kec94wVF3wMPWEkuavfMrVu5qYA0IZlmqsxsaedXpQ8IN6gPtDXuu5j1srwDMr/vqXQjcmxjBoK1cW6uW80OS2uO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072545; c=relaxed/simple;
	bh=3qKFLfNKckxhtzTrYwg8CiyP780i0A8n/fZ4lxrWml4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2L2MG5T70DiLp2MgS3bNepYaJif+qOABy8TpZaNk4KfFSdKKzevXFvdADKPpgAVeiARGgsW5xrYZm+1Cx9E1vlq1QEVYMQV+ZXnxwniEGYDoP5MufywgdBorTSdA5KtyvESUMD8WANc6uOO4YKDn0GopMq31AJvFhi33oy7NUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9Xpanjj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072543; x=1743608543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3qKFLfNKckxhtzTrYwg8CiyP780i0A8n/fZ4lxrWml4=;
  b=T9XpanjjKU5XHedST3pGoTz/xHuWoH98IyhrTNjY+XEZA4kH9fWRbu+g
   Md+uLA7Tftc37cDlvdyH6M5cRe/k+RHIG2TGumws+V91MYdDkJpZmXnJw
   MNKP0tXWTOF/68WPgjBWApf62JWNg1huoCprMsLiGVKpd1ScGPEikwybc
   1VQMJN9hq+GHe9in+wMDzxzVlk9LGeqlSTpcErvrvmI7bIlklKK1hmLbt
   Hgie6eWUGV0Bz2yp4Gt5rseSgumnsYvBEO/Kw9O0mMlWBnm0PHR/0ybiF
   8bStW7tCzNWXApoHPgOpA0dRTVXG5omv9UqMpJ3NXQRsmBvg/Sr/eCciT
   A==;
X-CSE-ConnectionGUID: 0TQIAYzaS9Guf6r60b1nZw==
X-CSE-MsgGUID: VCFQkQNuS5qoeZga4L2L+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870048"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870048"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083635"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083635"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3E38328A; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 03/16] serial: max3100: Fix bitwise types
Date: Tue,  2 Apr 2024 18:38:09 +0300
Message-ID: <20240402154219.3583679-4-andriy.shevchenko@linux.intel.com>
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

Sparse is not happy about misuse of bitwise types:

  .../max3100.c:194:13: warning: incorrect type in assignment (different base types)
  .../max3100.c:194:13:    expected unsigned short [addressable] [usertype] etx
  .../max3100.c:194:13:    got restricted __be16 [usertype]
  .../max3100.c:202:15: warning: cast to restricted __be16

Fix this by choosing proper types for the respective variables.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index efe26f6d5ebf..3c68b8e1a226 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -45,6 +45,9 @@
 #include <linux/freezer.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
 
 #include <linux/serial_max3100.h>
 
@@ -191,7 +194,7 @@ static void max3100_timeout(struct timer_list *t)
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 {
 	struct spi_message message;
-	u16 etx, erx;
+	__be16 etx, erx;
 	int status;
 	struct spi_transfer tran = {
 		.tx_buf = &etx,
-- 
2.43.0.rc1.1.gbec44491f096


