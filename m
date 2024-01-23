Return-Path: <linux-kernel+bounces-35654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CF8394D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854BE1C22456
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6747F7E1;
	Tue, 23 Jan 2024 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVKP4mxg"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F07F7D4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027788; cv=none; b=Xw+z0diSRsnMqo3am/w9Y6tuw1cp5PhW8gf/bdbMUMuYrSL0PwgmRaca3RxlODhnA2PWmFEBv5Da8XdO1qbSKGCnE/YFEVR7XCKNXRZTOtMC2sds8JG25aw9/DSOTYDXSxcJFJUJhL/WGgxepyi3UCjO6urjGA0rjrlut/F28qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027788; c=relaxed/simple;
	bh=I5Pr9VrhFDT1EYyfq7w0S3sXfpiBp5IxVXRO7Ss02Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FtXFyaqlwTx1L+vRTI58whGm2vCbi4Kc4I0dZeHJB/pF22voHZECkNiVsEgnJ1yctPsx5jl0Z2XuPhq68J09XQGcgfJ05jRno3AJgMDGhSaTeekkmeG8lx5X8+Rm/eLX9gMHE7AP3GU+20Hk42SH8BEeQUno5GE6BO1jV59s9VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVKP4mxg; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706027786; x=1737563786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I5Pr9VrhFDT1EYyfq7w0S3sXfpiBp5IxVXRO7Ss02Ss=;
  b=OVKP4mxgVjAx97Kybw/C2Gy01Y3W3bwa5accLDQsmUigJU6zait4Exk8
   hBIUyzoX7DVaw9oY3asDEkMA85uwc38LqXEISEQZgrT2GD9l4DjhP87Ig
   SXkD6Jh16gzsXCTO7bjnxwOWIzdBHu11AANQoUesVw0N4l+SUBE+UFI71
   at8nC6YVL71L/nWWFbjCMXwYDZeAS6tPL4rbJRGorJ3daxTf6uhhvyYsV
   kn3FDMpHOXBhdkytL47aVDfRAx9GKQ4JJExat+mgtAKi4YN9/HSGkvR6K
   f/C7sHchJDwP5fxNXkevnSxqEOHqluwKG346DFIfwVWLoDKne3LunLOYX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="391996001"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="391996001"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 08:36:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959186714"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="959186714"
Received: from viggo.jf.intel.com (HELO ray2.amr.corp.intel.com) ([10.54.77.144])
  by orsmga005.jf.intel.com with ESMTP; 23 Jan 2024 08:36:25 -0800
From: Dave Hansen <dave.hansen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	David Binderman <dcb314@hotmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH] x86/mm: Simplify redundant overlap calculation
Date: Tue, 23 Jan 2024 08:36:23 -0800
Message-Id: <20240123163623.1342917-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been a couple of reports that the two sides of the
overlaps() calculation are redundant.  I spent way too much time
looking at this, but I became convinced that they are redundant
when a little test program of mine produced identical disassembly
for both versions of the check.

Remove the second condition.  It is exactly the same as the first.

Fixes: 91ee8f5c1f50 ("x86/mm/cpa: Allow range check for static protections")
Reported-by: David Binderman <dcb314@hotmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---
 arch/x86/mm/pat/set_memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e9b448d1b1b70..fdc00516c0b54 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -435,8 +435,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
 static bool overlaps(unsigned long r1_start, unsigned long r1_end,
 		     unsigned long r2_start, unsigned long r2_end)
 {
-	return (r1_start <= r2_end && r1_end >= r2_start) ||
-		(r2_start <= r1_end && r2_end >= r1_start);
+	return (r1_start <= r2_end && r1_end >= r2_start);
 }
 
 #ifdef CONFIG_PCI_BIOS
-- 
2.34.1


