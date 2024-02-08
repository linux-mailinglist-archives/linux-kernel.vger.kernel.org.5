Return-Path: <linux-kernel+bounces-58030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3284E06D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916241F29CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65473185;
	Thu,  8 Feb 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dbg6R4PW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0B71B37;
	Thu,  8 Feb 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394238; cv=none; b=Ykqbj8ROuxTOBXtMyhU3z0ptpHZ0CbOTkQWFL3U34S+Uff2AImjj9iodagL+bwIOHSLE+fFpZCHp7Y6MVodY804pORYXO/3jEFpRxEidlluDdmh0JjKmBfOVyiK4Z6UOd599MmnoeRVv793uWv7DlBV/WUj/l9G69P3zB55ttBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394238; c=relaxed/simple;
	bh=gp0Jc6yWvRgb0ZO7bBbrnkeUPabEgmu355DVGo33jtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAvtw3pcZjNt2+SGLa/+G6AFvXlhcohMZlRtViNpZwnUsN1Q0TqXP7hjS0C4xFjjvcA2lH4kLKfwzvGSaMzsuClAPUQWhlnGxibxs2IX1btoZTY82ByUXjvndBSfajZkf4obaOlOtemtPK6idmSKkk6rzIge7WAH6W2qqqbLktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dbg6R4PW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707394237; x=1738930237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gp0Jc6yWvRgb0ZO7bBbrnkeUPabEgmu355DVGo33jtM=;
  b=Dbg6R4PWkO1rd+HkAynLWhW/UbG7OYlF571/VBCkjZd9hnDFxHDP7Ts/
   tiAdZw7Kx5b/ysNkBzpHz5/RG+Te7B3vJ23LAXyQY+aMgOBeUIJfgykDh
   3DcfItG7wi9nwQzUnx4u8ViMNt9IInt3ia7ubsABVAqtAxSBfJOf2UyAF
   c7tRxkpEAGoyPBvND2dwl0tF5zpLXYkIVxpypvmr9CyzFvWSrqd7t0hEi
   rXhXwyiRGbR56IMEoQf4PSKFLoepyHZMdwcFMe+CKHUTdq9mEhzCoTYl3
   zeRvON9VaSvev4MdRWVGkPSqJNkvreQRvZN6FlmptBCvW9sjYbGlztjie
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1341362"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1341362"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1625964"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/4] MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE()
Date: Thu,  8 Feb 2024 14:09:59 +0200
Message-Id: <20240208120959.2513-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
References: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
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
index 670efbc5c585..37087f4137ee 100644
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


