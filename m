Return-Path: <linux-kernel+bounces-52726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0921C849BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0491C237E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405520DFF;
	Mon,  5 Feb 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1g2MzPJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4D28E1B;
	Mon,  5 Feb 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140137; cv=none; b=Hj1f2f1LCZPRPRZk8lzZsXN3ZV3zA+JslzCVPzsuQdwjE+eQy8DgJIoR1HvgwHVa1FauB6UhJhv5CV4/Ua7y0wb8Nbmo3YDnaoa+Fx2r8WkFEKSQbjThFcUhTyiyaAgmdBtmQBlqCemFDEQsQEhBRVJki8P9hdW/jzHz6WoCuOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140137; c=relaxed/simple;
	bh=w3ZRuyQJPqlcygfflqUwjB5dmA/ao32uXeZE76jR82g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o05OHy10fhW+wrCYiuIMh5VVkNDb591WRKtT8miEgKmAbW5iboLx5dJyJztAN1HRKFbwX7QmbqxytjwDTWbCp8EplZ2iDGu+XoMiLvopHMV61wKMnCk5MuosH8dCNy017lwT60eZKLWB4OZTXgdlEqUyyZJen/4VDSvjXDrq538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1g2MzPJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707140136; x=1738676136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w3ZRuyQJPqlcygfflqUwjB5dmA/ao32uXeZE76jR82g=;
  b=k1g2MzPJgPT9UN6EmG5QeXVFGb8i3M94xCGmAHBDHlcdLXHiTScYxEqw
   YA7fBe3GC8OSUiuepnwNTritQ9YtCHkYz96lXXgWJ/7RuFNA10lSHycZH
   qiHLYlH8ZPctzFK+5+je03WKOVc3qxYBbUE+BSqGkMR35W9+bbYe+Sigx
   r/99gV4vil9JzVMDLfCFMSP4S5VdN0R3I2cs/2zienY51LQzJBeGpE8L3
   ykSH3qQIDgs3fgT2Qt9ErcE948h5ulAHzuspZpjgHMkzhE5/9xw2bNpOi
   e5dqII+lmQ0hOmPLK3DbkmKbcCnPb77klvHiHkZ5/i9/GvL2oMLCQpJDV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="670979"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="670979"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933155273"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933155273"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/4] MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE()
Date: Mon,  5 Feb 2024 15:34:50 +0200
Message-Id: <20240205133450.5222-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205133450.5222-1-ilpo.jarvinen@linux.intel.com>
References: <20240205133450.5222-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of literal, PCI error value should be set with
PCI_SET_ERROR_RESPONSE(). Use it in tx4927_pci_config_read().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/pci/ops-tx4927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 4dd8b93985fb..2db4938d3c75 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -144,7 +144,7 @@ static int tx4927_pci_config_read(struct pci_bus *bus, unsigned int devfn,
 
 	ret = mkaddr(bus, devfn, where, pcicptr);
 	if (ret != PCIBIOS_SUCCESSFUL) {
-		*val = 0xffffffff;
+		PCI_SET_ERROR_RESPONSE(val);
 		return ret;
 	}
 	switch (size) {
-- 
2.39.2


