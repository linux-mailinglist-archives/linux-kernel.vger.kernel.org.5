Return-Path: <linux-kernel+bounces-71544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5585A6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4651284859
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A403B7A8;
	Mon, 19 Feb 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrYqS8b+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94F38F80;
	Mon, 19 Feb 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355198; cv=none; b=J5fzb3ToWcyQCgdhj9Ob24z1hqiuW19eDY7lLbKyAzqcuWTfnzgUsRLIsO4mCNw2F+DwPHAQNUTRDepwh7MifeniYWE73UlaO+zRi85n/LmLPUuPMi3fyUEfM7mVtded2yfP4YW9WqLtd+wI5yeCi5l2dRL6pfkFnf9qJW3iN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355198; c=relaxed/simple;
	bh=82ATjiA+fWRlO+HzDk15/yNSFBbE2hQxY9S14sFvXLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrb7oexmK5SNPmsxOzPctSyJvUml+OQionLuGNrtrlX9tpStD0WZEFrIRoAOlOirkYWyzURuuZzSONFtrpbS2+bFRpZxqY59JfJBGL8/CTfHgUXEE4Tj6DN3Ir8r0WLjR1tb4O5s/39r6hDwJ2Q4JhFEjOJn34s9dCHzvHhh5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrYqS8b+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355197; x=1739891197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82ATjiA+fWRlO+HzDk15/yNSFBbE2hQxY9S14sFvXLs=;
  b=XrYqS8b+fs09PdbIJVRt/UAeBsS+WTU9bcGeI3pO01nLcd5xOAtSM+DO
   1lCUOtU5bxDAs94VQcrIAIGsQ+3aiuBJjvGGjxAhNhFY29JH/1z+aJZBB
   gnsIScVX7oeVVINbQCnUtHkSC74HuhnnuwnjwtEV1CT+Esg8JORkvmrbN
   fIVDKq1n/izAJZHkdIFY06kJa/S9yDYKYgltdZLMXt89zCWaw2EGMvFvd
   fMEyMBABCBLehuFD3lFhNbwveq2vAf1IWY2W+z1TY2pbwo/C70fnvPmxI
   gnWYYBQegS1Ix7SDlyl4STplvJty2LohK7CYzHCEBDnDhPFBLBRsoefEh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543777"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302991"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302991"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DA9152BE; Mon, 19 Feb 2024 17:06:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/7] serial: 8250_exar: Don't remove GPIO device on suspend
Date: Mon, 19 Feb 2024 17:04:57 +0200
Message-ID: <20240219150627.2101198-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
References: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems a copy&paste mistake that suspend callback removes the GPIO
device. There is no counterpart of this action, means once suspended
there is no more GPIO device available untile full unbind-bind cycle
is performed. Remove suspicious GPIO device removal in suspend.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 1be838122bca..6580265e1763 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -741,6 +741,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	for (i = 0; i < priv->nr; i++)
 		serial8250_unregister_port(priv->line[i]);
 
+	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
 		priv->board->exit(pcidev);
 }
@@ -755,10 +756,6 @@ static int __maybe_unused exar_suspend(struct device *dev)
 		if (priv->line[i] >= 0)
 			serial8250_suspend_port(priv->line[i]);
 
-	/* Ensure that every init quirk is properly torn down */
-	if (priv->board->exit)
-		priv->board->exit(pcidev);
-
 	return 0;
 }
 
-- 
2.43.0.rc1.1.gbec44491f096


