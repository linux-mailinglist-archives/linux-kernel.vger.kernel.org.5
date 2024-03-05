Return-Path: <linux-kernel+bounces-92661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01C8723D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0D8B2523F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287BB1292C8;
	Tue,  5 Mar 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ag08KKxT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D51272CB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655032; cv=none; b=eHi4FF5YoXV5XyRXx9PmwBvwDB/15Kk47kl3m8/IzNqA3F/I9aRONCuqo3/ysz0uDfJVr4BT4tYEpk+6gUGT8MWP3bVpgKO/J2PGRZE9M4yEpqNYWOAdBvNBPWdDMQqRjviO3CM1oEr4pgxY8bQ9LOKaQ3pq0eLTTQxLcw+iqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655032; c=relaxed/simple;
	bh=a6x2jxgLq/Yzn9dFkizHOofXGZQKmLRcZA1c/X5lzdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yrj4wdP/c+rgNwz2fZOO0JAUUO/NLXb4kiry7DGXOFh7C9zbKRdOlYrFNpU+2p+bUA2kFBq9uvaCPgNsiA/ZV1U9pkSusH09h00VXIH4E3rsXp/LeQEM3cIbCwVvpsXBqiC95h+iT7Wx+v8YG1hD65Cdj8GSHSFxWHIddRQVPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ag08KKxT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709655031; x=1741191031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a6x2jxgLq/Yzn9dFkizHOofXGZQKmLRcZA1c/X5lzdU=;
  b=Ag08KKxT/w8P/PQI46qPZBx4G1SCdY3/v4sOM5rVp0DwFICAmbluLlCx
   VUSHiZxs0hdtUt5zh6Kqgvbcb7WRhoUuGOvbxeioQMKFfkuuFJ/iEyICT
   SbWnIidzruvs0ln3HXseM0YA5DP8KjwZc/WNL2DdZet9IHUol5VOaGeGo
   NEsNaTE7pvlG8wVh5qdqA3ziLmkQ6aPP2njm1wy4T6aQbyyx329MgJbfy
   ewVcGQoGK239g62LY3v3+HvaNYnONXxl3LoOqVTzkCj4tvlHqdBJNjRJ0
   SjjWTvvmOzdvlrCo/tcEDVqmRHg9+0MKCkkDgpvjS2KxRF8bFlr0WkWvv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4077828"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4077828"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:10:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042662"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042662"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:10:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 781151A6; Tue,  5 Mar 2024 18:10:26 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] x86/rtc: Remove unused intel-mid.h
Date: Tue,  5 Mar 2024 18:10:24 +0200
Message-ID: <20240305161024.1364098-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel-mid.h is providing some core parts of the South Complex PM,
which are usually are not used by individual drivers. In particular,
this driver doesn't use it, so simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 2e7066980f3e..51a849a79c98 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -10,7 +10,6 @@
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
 #include <asm/time.h>
-#include <asm/intel-mid.h>
 #include <asm/setup.h>
 
 #ifdef CONFIG_X86_32
-- 
2.43.0.rc1.1.gbec44491f096


