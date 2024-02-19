Return-Path: <linux-kernel+bounces-71543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F043185A6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C1CB21C89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88E39FD4;
	Mon, 19 Feb 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvytw4WL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A18383A6;
	Mon, 19 Feb 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355196; cv=none; b=mjQltGgd77T0FIrsWqtrBThDTm3gVNmXvelju2bh5/NrWMwpKsTul5UvbDVNrun0MpoXrQumz5ZNgu+ud1R+h0Sf4UUEEdkHIPQ32bT+r/TusRzZdSudvACQILKeVv8twmcrX2lNHOBIdmQiuDMNuFTZJD0+l8Otj5xuPqS5Pfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355196; c=relaxed/simple;
	bh=07e8tH5p33pOlIv3860uVekz8GN+sz+b+6ZdzYF0wWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOoJNTHPsGOA8slEidraBtOLMWK6ol/N/E8sFmBE4UCAZDyMsExsQAdr6bEK/e/nK3wBhsI19SxeiNGzzjzpDz8WQ06pAGYHUO1x2rYXPD7o91swZOdfU3dZhaLDdlXF5mc6LcpSSbfH2TesOeJt0Ljx75AKDAaWxlStaUFFUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvytw4WL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355195; x=1739891195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=07e8tH5p33pOlIv3860uVekz8GN+sz+b+6ZdzYF0wWw=;
  b=nvytw4WL8gECXRr8O1YGPJrOu97xNLFHzPW7yxTQW5pObK8lgm1d7BXv
   /hWgyFmakgvrClNbVVUVrNJzcmDj9B0dXh2spCJIYvtdstgfVi4tGGjtm
   XXBSl8xzKphgA2er8+ltE8TG1ayopFYk0dLzAGFhS4gfgsKWgkC8Sg0x5
   c4kPKWXuCfahNE1gg6BuZlsDhlOAiFc+B+p6WweyamRoHv52RMfq9H6bA
   QJqy/alrB9p/GFiPGnvwEGYpQOS3HVqtHptRmn9cffpj8PKdUe63/vSii
   b2RNkk3vVLYrxpqlt451sl7CaG8d8tf/2Ig2TJ0MTDBLeM3fIDb/YRPTI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543775"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543775"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302990"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302990"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EA87A3E5; Mon, 19 Feb 2024 17:06:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 2/7] serial: 8250_exar: Use dev_get_drvdata() directly in PM callbacks
Date: Mon, 19 Feb 2024 17:04:58 +0200
Message-ID: <20240219150627.2101198-3-andriy.shevchenko@linux.intel.com>
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

PM callbacks take struct device pointer as a parameter, use
dev_get_drvdata() to retrieve it instead of unneeded double
loop of referencing via pci_get_drvdata(to_pci_dev(dev)).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 6580265e1763..28478b9c537b 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -748,8 +748,7 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 
 static int __maybe_unused exar_suspend(struct device *dev)
 {
-	struct pci_dev *pcidev = to_pci_dev(dev);
-	struct exar8250 *priv = pci_get_drvdata(pcidev);
+	struct exar8250 *priv = dev_get_drvdata(dev);
 	unsigned int i;
 
 	for (i = 0; i < priv->nr; i++)
-- 
2.43.0.rc1.1.gbec44491f096


