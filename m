Return-Path: <linux-kernel+bounces-30705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7591832359
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DA31F21733
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741715A4;
	Fri, 19 Jan 2024 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVOe6Ok9"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF81362
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705631757; cv=none; b=qRGXSKeqNc3eSkfW3g0qCt6hQ8y0ZVGYHHbmlfvaP3EV/zRMtZYxQX0bFZ/xShWn+3O+cOESmuCnKnLnvNqsY4H1DtGCC3tMzDU+RVzZsD9xpBY5t0bW59Qi03i2jlGinpKaKycyB8wU48RTir8Hu8WtG5NA5SezYhF80SxjIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705631757; c=relaxed/simple;
	bh=FWdvLRIjZQjdEsuLa7S5VAS5JZs8laiq1LL6yRWxQOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pPWvdbyj4tmbdNMVE2rOSVmrPcmyKH1/mMxWgajdYTaKeJqoVeXanRaJyp/LKI2PYFrWSewTkIKLpNM8mkKzrBhHZdifgQLcJ4Q0CUNxiXyOM4Psi8CysQz5Ncuwo67tn4Y7GfGq3/Uu3UOi3RPNfd2kFkfmfjs5KwbL5wfk2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVOe6Ok9; arc=none smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705631754; x=1737167754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FWdvLRIjZQjdEsuLa7S5VAS5JZs8laiq1LL6yRWxQOA=;
  b=OVOe6Ok9vdfeOswGcJg0deVrXdfyTj23qqjTfx9Nqjo+ljzwNdC/EYCW
   dZ8RsGYIiJdlraFoP1C5bTN7qK4romV6CRA+SElFvgo3CvEaCGKmKC7Hr
   Jg010uTUC/Wtq09LoEgzChLmIbuQ5eIdJgBd+KYvtmXZum/3a+WQGKd+M
   Yg4hk9RUatcKHWhwD+vfeshLRQdIKhWL4q5PWAGmfhFresVf/UxurWyHp
   /bAKDQYT3ty8lCq8jj33wwUOGFQ4FaWMlISkTKgkYBzU6ry896Mzrk3yl
   6k8BtYQh+vFs8BlnJ1SDfHzdxTCtzBCtO8gelZGnhCNChcdDpwo+WNxfz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="467015121"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="467015121"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 18:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="499769"
Received: from pialybar-mobl2.amr.corp.intel.com (HELO desk) ([10.209.49.165])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 18:35:49 -0800
Date: Thu, 18 Jan 2024 18:35:47 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com, daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com, rick.p.edgecombe@intel.com,
	sohil.mehta@intel.com, alexander.shishkin@intel.com
Subject: [PATCH] x86/lam: Disable ADDRESS_MASKING in most cases
Message-ID: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Intel feature Linear Address Masking (LAM) has a weakness related to
transient execution as described in the SLAM paper[1]. Unless Linear
Address Space Separation (LASS) is enabled this weakness may be
exploitable.

Until kernel adds support for LASS[2], only allow LAM for COMPILE_TEST,
or when speculation mitigations have been disabled at compile time,
otherwise keep LAM disabled.

[1] SLAM: https://download.vusec.net/papers/slam_sp24.pdf
[2] LASS: https://lore.kernel.org/lkml/20230609183632.48706-1-alexander.shishkin@linux.intel.com/

Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1566748f16c4..794517df8068 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2270,6 +2270,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 config ADDRESS_MASKING
 	bool "Linear Address Masking support"
 	depends on X86_64
+	depends on COMPILE_TEST || !SPECULATION_MITIGATIONS # wait for LASS
 	help
 	  Linear Address Masking (LAM) modifies the checking that is applied
 	  to 64-bit linear addresses, allowing software to use of the

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.34.1



