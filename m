Return-Path: <linux-kernel+bounces-52725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBD849BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493DA284C65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4222F0E;
	Mon,  5 Feb 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcUITd3Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4022260A;
	Mon,  5 Feb 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140129; cv=none; b=Fz2C6BcTUfEeKrBqN2DOkyU3On4g3eeGzHagTLVoAv1pst5nPCSud+a3C8XvXgXUoL30COiAOfboMNxuKQmhDO4bPY9+bEQ33frv0dTvjY0pw1EyrK0vhQ6QG2e8LYwyrEnpvak9gnWx3MKShpie0vOF83DI7VqwpB444HZCW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140129; c=relaxed/simple;
	bh=Q3+800fhd/fwWAp0F7nWO/Ih5K1cq1Tqdf0ZT226Bzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbwOxQRJ2+zi7NvXDdxPfDQNSx4GbyGd0aHUMsSxzWU5WQcDhOklomCRcPlvwrjtdUA7vF82KUZDlDmz9foXyipSjNE8HNc4bVmiC5XfQ8ur+I+NUCBJauyQprksXj4CB43J4RGV7cFwuhEq96pEDV4UW1eI35xVEimyKeKmY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcUITd3Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707140128; x=1738676128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3+800fhd/fwWAp0F7nWO/Ih5K1cq1Tqdf0ZT226Bzg=;
  b=RcUITd3QMEvhfE9bwSJwnvNIVikJeqzeg6S0BGkUEuXmM0I3+vJgOGGY
   /zKgfrSPlZ2adJel2Lhxt/n5w/Ins7HkMr7k0mL/THR+q48IniqVfzHgP
   eu38ospjuK791rZwodxB2dkhhgZM2ryDKfqS5O1lGCMMGRdAgQyh8YpeQ
   8cUNjjIwTsL2EJvNHKq3KGs3c2JPfFgKpPW85cl/Rp8tqmXUU7hpvgAcT
   T99xRZ3jFfAgsaBkOtr6wSnP02GrhpJfmvK5Coe+/VYJ6wjWPut7gq5JP
   5gAZiTijsiBfbdeMlAgdv3ByiKydRu+m1UHxIJCbPKHl3w0mV8SwDB7ZG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="690079"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="690079"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="923292"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/4] MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
Date: Mon,  5 Feb 2024 15:34:49 +0200
Message-Id: <20240205133450.5222-4-ilpo.jarvinen@linux.intel.com>
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

pci_ops .read/.write must return PCIBIOS_* codes but
tx4927_pci_config_read/write() return -1 when mkaddr() cannot find
devfn from the root bus. Return PCIBIOS_DEVICE_NOT_FOUND instead and
pass that onward in the call chain instead of overwriting the return
value.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/pci/ops-tx4927.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index f7802f100401..4dd8b93985fb 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -60,7 +60,7 @@ static int mkaddr(struct pci_bus *bus, unsigned int devfn, int where,
 {
 	if (bus->parent == NULL &&
 	    devfn >= PCI_DEVFN(TX4927_PCIC_MAX_DEVNU, 0))
-		return -1;
+		return PCIBIOS_DEVICE_NOT_FOUND;
 	__raw_writel(((bus->number & 0xff) << 0x10)
 		     | ((devfn & 0xff) << 0x08) | (where & 0xfc)
 		     | (bus->parent ? 1 : 0),
@@ -140,10 +140,12 @@ static int tx4927_pci_config_read(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *val)
 {
 	struct tx4927_pcic_reg __iomem *pcicptr = pci_bus_to_pcicptr(bus);
+	int ret;
 
-	if (mkaddr(bus, devfn, where, pcicptr)) {
+	ret = mkaddr(bus, devfn, where, pcicptr);
+	if (ret != PCIBIOS_SUCCESSFUL) {
 		*val = 0xffffffff;
-		return -1;
+		return ret;
 	}
 	switch (size) {
 	case 1:
@@ -162,9 +164,11 @@ static int tx4927_pci_config_write(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 val)
 {
 	struct tx4927_pcic_reg __iomem *pcicptr = pci_bus_to_pcicptr(bus);
+	int ret;
 
-	if (mkaddr(bus, devfn, where, pcicptr))
-		return -1;
+	ret = mkaddr(bus, devfn, where, pcicptr);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
 	switch (size) {
 	case 1:
 		icd_writeb(val, where & 3, pcicptr);
-- 
2.39.2


