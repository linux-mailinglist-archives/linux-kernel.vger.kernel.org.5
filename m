Return-Path: <linux-kernel+bounces-30716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9B832378
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2B1F234AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBAB184E;
	Fri, 19 Jan 2024 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwy9SS3Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E292E15A4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632748; cv=none; b=sb+f3n4U8RbePqCtxBerVBsUgj8i/j6AmWCbMRajXwlXX05YqTTz4rL/fr0YEY69/LdPLZmZDnMomDRR2DQ85Vwhp51ZEjr0FRtt6y27lopktfEN3PYTiSTSxH1e5IheHbOTWMA5SQ01KJY/2Q5L8d1sVLLHOgcrer+J4ELWAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632748; c=relaxed/simple;
	bh=6S2qjNkz/Jifeoy79y+6wsAJfFEcpfQEqDGnMvPzCKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WBha/m/eknn74yRzBEmu/lPTli4lptUvf+INpZ7+Mtem8/aTM62Yy2zYawf3I1A8l56ghl++XUjXR4S8090Rs0mzAKm5yK9ipftwPhDXntcmsyVqYyLw6YwdO7y+w22tGfF3K2JIXo+y/Zz8puuHOTuEniJScbWPTk4T35atNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwy9SS3Z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705632747; x=1737168747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6S2qjNkz/Jifeoy79y+6wsAJfFEcpfQEqDGnMvPzCKM=;
  b=bwy9SS3ZtH4lb/nWVNFDWJ5YHu/fvRyhETpzh7NLl/55xaL7aZUjg4VT
   GUvq+4VzIx8fsqyxciVIf2nzYUb8waOLRnqN10OZy3dA1yaAVAnShT4zo
   U3Xf5x6m7cHM3p4MGXmUBxMbaV0AJpaHsbi5ilB9rdwcj5er2qZ4lTKhb
   7NGLl+S4zQrcFth0uFLPLfP+SznebzSWaOxk+g4XuwIvgqsZu0j+It5Cn
   M5ZdpHDP+ARA8uTDwa2HeTbKKOuc3S4Nt6D5nzyDzttJ5QcXOfT2r2kYo
   4Uzuyh1YHNXjGafQ4HpBNljLdZe5aDTKvalDKsqXnao0b8IGBbCWWQGgJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="537384"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="537384"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 18:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="761019511"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="761019511"
Received: from pialybar-mobl2.amr.corp.intel.com (HELO desk) ([10.209.49.165])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 18:52:25 -0800
Date: Thu, 18 Jan 2024 18:52:24 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH] x86/msr-index: Fix the order of ARCH_CAP_XAPIC_DISABLE bit
Message-ID: <243317ff6c8db307b7701a45f71e5c21da80194b.1705632532.git.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

XAPIC_DISABLE bit of MSR_IA32_ARCH_CAP is not in correct order, fix it.

No functional change.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d51e1850ed0..c72d68fc774f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -152,6 +152,10 @@
 						 * are restricted to targets in
 						 * kernel.
 						 */
+#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
+						 * IA32_XAPIC_DISABLE_STATUS MSR
+						 * supported
+						 */
 #define ARCH_CAP_PBRSB_NO		BIT(24)	/*
 						 * Not susceptible to Post-Barrier
 						 * Return Stack Buffer Predictions.
@@ -166,11 +170,6 @@
 						 * Data Sampling (GDS).
 						 */
 
-#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
-						 * IA32_XAPIC_DISABLE_STATUS MSR
-						 * supported
-						 */
-
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
 						 * Writeback and invalidate the

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.34.1



