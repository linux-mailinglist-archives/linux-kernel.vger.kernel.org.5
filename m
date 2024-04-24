Return-Path: <linux-kernel+bounces-157484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3D8B1214
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776DE1C2116F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26718410B;
	Wed, 24 Apr 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fl5OGbmq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB2181CF8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982525; cv=none; b=qmutXNqke0mcQzZza2RPF9kWTdsMAOu4NJOJy9RgkKO2JOqmoZKOti7S11aaiY9Oex9edIvJbIBPoX8nzEY6vcCG+mZyO9Rx+Ucmk4F6gZSReyysieKurjJrx1H0Dn83nmZJS3ILN6wjyZenL6S3dSleYaU5Jr0IaJuekQsQSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982525; c=relaxed/simple;
	bh=MetFmFlhAPE7vpRJ4pnmuEjVeVxyl19C3RDm5bFHSMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC145a1rvDMVQ5N4APDCQx2RV62F/lho2q7gyGVB574wyVu2vJChY95B77WndIhvSLwN3uXAI6aAuBfpBfxBkiQ3AF1UxvXfAXgLd/04/2YzJbkvoY8VGrx/E0rIEgVh4kXUbna79Kd5+cOm3fmhN1tDVFD5bCfr1DeyJWRhnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fl5OGbmq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982523; x=1745518523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MetFmFlhAPE7vpRJ4pnmuEjVeVxyl19C3RDm5bFHSMs=;
  b=Fl5OGbmqlIydLqeI8Viidm4TijDTbD1J4QNhWSbgCftdFjgMVzWI/kzg
   q42nk8OqAhV1cBrLJawantDGN0zbWuaNLV9ZLsPBwrXkm+7sS0mfBnr0a
   dIt2AjaLNf3iAPsFrBPTZUMciLvuIWQOH0l/8PUu/ZmFJr0SHhwiVQkIC
   /KTAvyVclzcW3hNeB8JSUY/iekRliGlyu9EqlY1fSOEv77wnT7T/8/UYQ
   2mV/E2TsnWgO/YwMZj6PgKUN4R1pa9W6ruVfDBcsGRXrRlvG9183QjbKi
   QbBjHpOKRcPGCVESwSa/GyPAjnoieBfDPUl2ydXGLx78Gw82Qq/KwptL0
   g==;
X-CSE-ConnectionGUID: q1OIDzYERnm4luQVcvM6EA==
X-CSE-MsgGUID: voberBd2RSaILcIjLVavSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482022"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482022"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:14 -0700
X-CSE-ConnectionGUID: AfJ2xFzOSQqry4fUNXU0nw==
X-CSE-MsgGUID: BHJJCOJSQFefEC9GPZ5QeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262762"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:14 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 35/71] x86/microcode/intel: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:13 -0700
Message-ID: <20240424181513.41829-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5f0414452b67..815fa67356a2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -21,7 +21,7 @@
 #include <linux/uio.h>
 #include <linux/mm.h>
 
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
@@ -577,8 +577,7 @@ static bool is_blacklisted(unsigned int cpu)
 	 * This behavior is documented in item BDF90, #334165 (Intel Xeon
 	 * Processor E7-8800/4800 v4 Product Family).
 	 */
-	if (c->x86 == 6 &&
-	    c->x86_model == INTEL_FAM6_BROADWELL_X &&
+	if (c->x86_vfm == INTEL_BROADWELL_X &&
 	    c->x86_stepping == 0x01 &&
 	    llc_size_per_core > 2621440 &&
 	    c->microcode < 0x0b000021) {
-- 
2.44.0


