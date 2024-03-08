Return-Path: <linux-kernel+bounces-97045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA08764D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C951C21655
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE12209E;
	Fri,  8 Mar 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR+K6M+P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3633D3B9;
	Fri,  8 Mar 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903751; cv=none; b=Y6Wek6dxxuPvFaLHnRQuJKNTK7zzZApOlrBTY7dIRF1FPWMWd1+TKEz6Nu2f64hNwPebLUDUyYiz9lO03moNGjEY1tR/ghyR3CWPL1ihdBQK0ggoPUhUhZBP55YB9x0gQB5Adn8M+MUyS0/11Tf915cbCzwSQoB6AyOUfu2TgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903751; c=relaxed/simple;
	bh=bS1S2X2CJjfZI9Wdu/gKC/PtojbjfoojrJoco+YT8K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPL3qCRDJppDeKEJS1+waz5c6hVfcYq0xgdts0p6jHlkACaF3Vx+pmwr0rtuKD9r6yxqpaKI+HXdSmgPk8vToRsbCxJi8SotKhzC3ekzGRltk5kAdZkERQG/B+eTYNKOVbZdf/onyGwpk5LoOxnLGo9EdxQ8RKg3h04mfmB48qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR+K6M+P; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903750; x=1741439750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bS1S2X2CJjfZI9Wdu/gKC/PtojbjfoojrJoco+YT8K0=;
  b=AR+K6M+PiMSFInoWU8aHUXT/cUkPQYyi+gOWGcMZr0z1yQJnBqxCGy06
   /ABuvKs3SF3shO4GnDTPrtYYoJHAICe0cOlE9mxKVLO2uv9pjVJc08agL
   vU78ykaHhn70ZsPMzv+Dzv5EK3UO0dEi7jqvGKTYy+4n/OI1giL08PJhU
   kuXCa2f9kz5RO2Cuvv81rHGRXI9sOII2LchJjZXbJgj1OOasjAbI7kOYg
   IuZ/EaPy64+jxruVnKGteV2gIXiSNswxaz1PuX4USE6MVl9SMj54fWRTh
   IRWic35vuj/jezoma+UlZWO6nWO9BHY9i2SEFUCBy2d7Fl1UL/JqPEUFe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342442"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342442"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161375"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:41 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 03/19] vdso: Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
Date: Fri,  8 Mar 2024 15:14:56 +0200
Message-Id: <20240308131512.44324-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308131512.44324-1-adrian.hunter@intel.com>
References: <20240308131512.44324-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT in preparation to add
multiplication overflow protection to the VDSO time getter functions.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 lib/vdso/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac299508..c46c2300517c 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,11 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
+config GENERIC_VDSO_OVERFLOW_PROTECT
+	bool
+	help
+	  Select to add multiplication overflow protection to the VDSO
+	  time getter functions for the price of an extra conditional
+	  in the hotpath.
+
 endif
-- 
2.34.1


