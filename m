Return-Path: <linux-kernel+bounces-145773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929548A5A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04E7281793
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297F156645;
	Mon, 15 Apr 2024 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apiY294b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAE156237;
	Mon, 15 Apr 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209626; cv=none; b=oaMKZzU34UZiHwNLNevu8Fjl3nLmhEJmAGjiQ6BegStZ+WWbpOLZlsLISZph0UtB+u9DKbhpQw0RxcoAc5Kj1CNarAo3qYfJH/BdC9rSqRFarb943oXcdQ7BRL5drdwRgV6M+trljjZt+vPYyJ0/9qoIqtLJbZr3ibZAyE3KbH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209626; c=relaxed/simple;
	bh=/bh7HrbemkmP9VKg1BdllL+PdypLV6SqDxAFQIT7RK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkMYWI8W6k67dJWmk56kTOJXE+Oo6RyvNgfbWVqklkK/c/iGTdKO1C5UDNWIFkM7A49tMQ/oNHREJSi/TErtkMThXPTOm+N9VUmjqGmXty+/9Y6BGBh1qXL2NHhcTuqapJd6m7nXnuGcJ4/LJaYW5UH06xMC9Eal+l0d0lpedhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apiY294b; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713209626; x=1744745626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/bh7HrbemkmP9VKg1BdllL+PdypLV6SqDxAFQIT7RK0=;
  b=apiY294bRjR/VA0KI4cj3MUKRfCpG9CA5sbNpOXetsUecu0FvTU4nWRP
   hiDGKE9oCfyA2l1zZv+MhC01WMDXJEe1znRKJaoKIc9WZDID2IYIIx9GH
   7CO0cxcl9iGGVgIOfrSV4wnF6RXWYH4fqfytEcoVv1ssEeAA3G7v6Lu40
   6FdsgCg+WhqBDpR6C2S+JZlYjCj6t4lrrzsq1OVGjwhxCwb1IUIs+nKSu
   oA3dklTeYrnSA7RTJtoS0dsr4vgQ9/nFL8QcMx4qFnjDj8RLcMK2sa9ew
   NxWB2DwHlQrQQHjN2MMJwr9+5bG3EqHQR8ER6gR3mPUFNpKqQ6ccizSPT
   w==;
X-CSE-ConnectionGUID: 0xL5GWE0RCiqV1FSDShtkw==
X-CSE-MsgGUID: pfwdbdoqRw69BHrakbb1Fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8741048"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8741048"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 12:33:45 -0700
X-CSE-ConnectionGUID: 30p081VISIKyXMZv1dBjJg==
X-CSE-MsgGUID: C3Nqq2r1SP6vFOWAefmRJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="53214030"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 15 Apr 2024 12:33:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 04A8F483; Mon, 15 Apr 2024 22:33:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] spi: More refacroings after multi-CS support
Date: Mon, 15 Apr 2024 22:31:18 +0300
Message-ID: <20240415193340.1279360-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of additional refactorings on top of the multi-CS support.
One is to make sure that the comment and the code are not disrupted
if additional changes come in the future and second one is f or the
sake of deduplication. In both cases it also makes indentation level
smaller in the affected pieces of the code.

No functional changes intended.

Andy Shevchenko (2):
  spi: Extract spi_toggle_csgpiod() helper for better maintanance
  spi: Introduce spi_for_each_valid_cs() in order of deduplication

 drivers/spi/spi.c | 63 +++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


