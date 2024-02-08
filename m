Return-Path: <linux-kernel+bounces-58029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D424084E069
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4009E1F29C92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6EC71B5B;
	Thu,  8 Feb 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGk9B80S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC274E31;
	Thu,  8 Feb 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394231; cv=none; b=X0Gaqj83R+XR1HQpUHbigBAA26CawlpvzWLwvAGSAclLa2m0v3lfIxyYIjVWTPXYM0PH6oTfsvCXdFEZnOnOFtluR4gQIoWPbNt/3dC2wB4aT11Wo+TZfIMbNvn9Y4MXWXknFn0Bov811XC1WPQz45S+ojoFZzk6YxjGh5qnUUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394231; c=relaxed/simple;
	bh=ivHn9eMnqjSo1Ck3bYq1BD7aGM0SlKEDNFiHnIfMXAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0VoSOCDejFg7twqSQsVA/e4Wow6qQLzLfJ3S5Ofn2kqfZAui8QMTfLeanINpDJ9oYl8EcxZtkXE4aEAb1q49pwIfMl7Q7XVOOBJJf4k8dG/1DT9Gi+HFpVHpEP20gJEApcroLqS0xjVGOkY8C1RStQL/r0LJka+Q2Ud0QcoHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGk9B80S; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707394230; x=1738930230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ivHn9eMnqjSo1Ck3bYq1BD7aGM0SlKEDNFiHnIfMXAA=;
  b=HGk9B80SwqoBiAWLwhqYRXOeRbh3ANwta7SzF/DrX5q9YQtqO4bApgo5
   7TYOYjSdpoz/jfId87Ru+0avKbHkhdvUN7zRfpzoIIRlJQndUWAJSqVOM
   5wDe4McS0KvZHys8rQM9kUbV2T87LggUENIQ3MRHHZukWPYKKUti9XwRJ
   bUqbJR3/gPWR9y2Sv94zTzP97r7npQgK1+IvooKqwQJJEGKFR78kn/4Ey
   a3InvSsZJy3JZIwkMskkMsHhGDJ6KEpy5YaXgA8goPQ+A7Gmh+QIrsLIj
   Bm3UbLjzF03UqP+3UuDANuKxPAL1M2lcptV7qVPzWvuIL2GLpuBccr/Dc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1341344"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1341344"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1625955"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/4] MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
Date: Thu,  8 Feb 2024 14:09:58 +0200
Message-Id: <20240208120959.2513-4-ilpo.jarvinen@linux.intel.com>
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

pci_ops .read/.write must return PCIBIOS_* codes but
tx4927_pci_config_read/write() return -1 when mkaddr() cannot find
devfn from the root bus. Return PCIBIOS_DEVICE_NOT_FOUND instead and
pass that onward in the call chain instead of overwriting the return
value.

Also converts 0 -> PCIBIOS_SUCCESSFUL which has only cosmetic impact.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/pci/ops-tx4927.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index f7802f100401..670efbc5c585 100644
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
@@ -69,7 +69,7 @@ static int mkaddr(struct pci_bus *bus, unsigned int devfn, int where,
 	__raw_writel((__raw_readl(&pcicptr->pcistatus) & 0x0000ffff)
 		     | (PCI_STATUS_REC_MASTER_ABORT << 16),
 		     &pcicptr->pcistatus);
-	return 0;
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static int check_abort(struct tx4927_pcic_reg __iomem *pcicptr)
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


