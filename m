Return-Path: <linux-kernel+bounces-58026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C784E070
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3A9B241A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035071B35;
	Thu,  8 Feb 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwWn4gFn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39666F535;
	Thu,  8 Feb 2024 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394210; cv=none; b=MdUGKBJDFQSKLSR6bxYRiL5zhAPrYQU8IPcGXHmaoogCxyVNiHwsJZJLWvuJ3+nwxFbAjhX+GnmnavRt0hmB9hvp1uLC00Ueo/I8xgNdn6GI6JK38+UhabXukYuS6lIzb+mDKqGis/dNZoR1m0ruwr58yTpkPr1JMKd8cOhp0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394210; c=relaxed/simple;
	bh=ojkSK2VElFsMJdx1oveSOhBu8M0/A6m0n710BIBFR/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mFmrP2b2c26mHCzhopIrzVzDbjeTH08J1viCdIbFOBeri+0VtsVminhXWD7P6QwHhm1nchl5VOiFyUhU9ykA1i0DvcIWQnMK0ZlC7PEbJpSyNri4Pm7EDrh4QcWohzWSwUW8TgVoWLINOI+Dppv0Q5xSdFDrdtyfm4q+xENWLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwWn4gFn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707394209; x=1738930209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ojkSK2VElFsMJdx1oveSOhBu8M0/A6m0n710BIBFR/E=;
  b=fwWn4gFnhod4c8Fy0YtBLVnmSgyIk5OhWBvMoLvFUMlcm0nVWTAAyXi4
   TP0bXrP6BMHqOwIhHOk1+zbWdDErPUad/RiU22SU5xadlJam6PPsFB0pZ
   QDWgY2MLldn8z66xdp1K5+LZKWmUGGOWsJ5iIVTEn8jpKnedPWkUcwCAF
   5nMLN7bnfOtuYAcOcCNV6IfG0ijXnol40lQgzlIAWE0LK8XP0CfyEluv0
   2Lhifg84gKfs96aAn5W4qwBmImWDV0a1ixQhgIS/81dPMttksCkrbKscM
   NhlOan9sTxIPs7CTGdmjuCUt8YkA/MQgY1YShkNHpc1uiDkIol/CIKzBs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1090795"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1090795"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1635236"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:10:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/4] MIPS: Cleanups to PCI related code
Date: Thu,  8 Feb 2024 14:09:55 +0200
Message-Id: <20240208120959.2513-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cleans up PCI related code.

v2:
- Convert also return 0 -> return PCIBIOS_SUCCESSFUL

Ilpo Järvinen (4):
  MIPS: lantiq: Remove unused function pointer variables
  MIPS: ath79: Don't return PCIBIOS_* code from pcibios_enable_device()
  MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
  MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE()

 arch/mips/pci/fixup-ath79.c  |  2 +-
 arch/mips/pci/fixup-lantiq.c |  9 ---------
 arch/mips/pci/ops-tx4927.c   | 18 +++++++++++-------
 3 files changed, 12 insertions(+), 17 deletions(-)

-- 
2.39.2


