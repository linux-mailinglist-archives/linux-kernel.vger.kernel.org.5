Return-Path: <linux-kernel+bounces-61441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA18A851260
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F241F22BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C7339AF6;
	Mon, 12 Feb 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH5sWi2f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7A39AEE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737821; cv=none; b=CwEHuKKmoop8G69EANRyMlvasBIsZGe4oRcQDtFFBDZajPPT8fgUFF05VrIJRogG/zCqLSde9EHCy+0X5v8WG8ukUY4/EGFvfKio+50K0i0CXidRxVcndi2SRzbcaaSc96TyGJBD1QP/y2YDKYQAB5AGPlR9+M4U8458j3gIFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737821; c=relaxed/simple;
	bh=VWZfy27Rgmx2YQk+lzFL4JxIppzdl0mvi57tgaoo/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljeVSw2uedbHAXhaPFh00rUQUYQ9wJuE3N+q/dyEHakUwUxvzQ4vpPHpvUMknEm6DzerwHpfQlN87/SyStWb/gaW8kykYG1ZiDieK09Io0UdGLJp9JdUjKs90WqgNAhTq2RgTKaG0H8GUO0Ozj0NTjmyc1pYaf+ThERsm1I9vPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DH5sWi2f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707737820; x=1739273820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VWZfy27Rgmx2YQk+lzFL4JxIppzdl0mvi57tgaoo/Kc=;
  b=DH5sWi2fJD6KYGUJw2Wt6A/ieuPTmcW87GTZ+FpF/K33R53riJ7o8oTg
   J4Lw18EAz9yUkm0iKqqKJ+CU9jc8t5sIdMoZPLphrrAdPeUAf+yZh0C6M
   mps9Ua9oEuvJdVqgmshXO+tl3cWSgQFKo8fQpB7LnZmUy0Ybux0IQ5Aub
   s6UyZ1y7GjvEeoqE9dJVxHTaCMKjMrQsZc17ZI303ClZ63dFl3+dSpTvM
   0z4hVo8U6qcqHVtXgZ+bH4NIpUHkFGwB7u6U32PVPWiCqknsC6Mrw1NP7
   xty0HymhN2YPFk4YesumrePuMFGJVOPZ6hpBIUX3Z6SV/3e8/OtjPl+v3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="13085179"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="13085179"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 03:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935043706"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="935043706"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 03:36:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E4D57F7; Mon, 12 Feb 2024 13:36:56 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] auxdisplay: Take over maintainership, but in Odd Fixes mode
Date: Mon, 12 Feb 2024 13:36:53 +0200
Message-ID: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have no time for this, but since it looks like I'm the main
contributor for the last few years to the subsystem, I'll take
it for now. Let's see how it will go...

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..bfad581adf24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3376,8 +3376,8 @@ F:	drivers/base/auxiliary.c
 F:	include/linux/auxiliary_bus.h
 
 AUXILIARY DISPLAY DRIVERS
-M:	Miguel Ojeda <ojeda@kernel.org>
-S:	Maintained
+M:	Andy Shevchenko <andy@kernel.org>
+S:	Odd Fixes
 F:	Documentation/devicetree/bindings/auxdisplay/
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
-- 
2.43.0.rc1.1.gbec44491f096


