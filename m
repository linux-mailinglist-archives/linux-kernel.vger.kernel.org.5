Return-Path: <linux-kernel+bounces-133491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574F89A477
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A9FB22220
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939C173326;
	Fri,  5 Apr 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USmXZR+P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE3172BBC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343457; cv=none; b=k86Y/5fzYALBRfy/CDYQR1vxlrsRRJPLDWegPzKgbZ4TwENENU08s1DS1rMkFkDfdF/Ssn40P8nXKRr/9YL3/NbVXQHNSKlWUoS7x2r4aE6ZSXX3RrVEr+rtsHjLL3KBpssLJTzX8CQNsLmtpom4HEiZQGN7qBAT6HUW1R0f+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343457; c=relaxed/simple;
	bh=Ke66bLRD8Q49/xiLe7HuCYzlVvZQIPCGTxagy/FSt+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uc/8m+ajhpSrxZuil9pYrjTeeTvGcGdV9Rk28HZDm8bSt2QEwlB7ratvr/tPAXI/D3PSpCqWWxhRlCLnGAuUdpHn1fvXDKosqJtB4jmtLX3IEsmh8f6OROiHBE7FcBUUSv0kXCywSBOJ5ajV4Bv60+hGbZ57ZiZ496jN8H1Gbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USmXZR+P; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712343456; x=1743879456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ke66bLRD8Q49/xiLe7HuCYzlVvZQIPCGTxagy/FSt+k=;
  b=USmXZR+P29zgz/kCGga+3e4NCAMZXWGPtWNyoKTt28hKFx91+qjNgpEU
   SMiLNFMaJF8wdVGQY4VawNTiazB9sTFq+KHgM9pYeAaLkqVA2FRobNKxR
   WApav/0YliUlShr5Od6N1Dwb9wDzw68JokcybHgkzZY6DgUmlsAkmcMey
   BZJoEwew1EorVwqKEx5jH3vEVPzGWTXoXtcZeCMWgP5uIA8xttIagKVV7
   i3GOPeSig+7pl6U1oWgt5/eza5W2ydQ8EB5z5E6kyJ1jO9xyBM4EL3prB
   sjL6OEkk+8dtRELcYRuR3jPDQl3vNY4Jt25mvCVD3/LLRfY4hfPz6AIWU
   g==;
X-CSE-ConnectionGUID: 6qJrJR56Suu2cgZCTA/kBA==
X-CSE-MsgGUID: eDu130Q7SBmvcS9M23yMKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7588310"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7588310"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 11:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="937088096"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="937088096"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2024 11:57:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F2FAC3E5; Fri,  5 Apr 2024 21:57:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] genirq: Update MAINTAINERS and trivia fix
Date: Fri,  5 Apr 2024 21:56:44 +0300
Message-ID: <20240405185726.3931703-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update MAINTAINERS and trivia fix.

Andy Shevchenko (2):
  genirq: Update MAINTAINERS to include IRQ related header files
  genirq: Fix trivia typo in the comment CPY ==> COPY

 MAINTAINERS         | 6 ++++++
 include/linux/irq.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0.rc1.1.gbec44491f096


