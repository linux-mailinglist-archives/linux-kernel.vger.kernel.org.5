Return-Path: <linux-kernel+bounces-36412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5683A046
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDEF1C248C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399356FDD;
	Wed, 24 Jan 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rgznz5BT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAA6105
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068525; cv=none; b=k02atuGPo8H17mSJfL3VJQKz7mkKAMHE2ZOzo2tHSg0ZT3qDbRNj6goGTauNEmgS85skpErzqnTt9puc1g7BlCCfGxcpQPdi7xKxWT0wV/IWWt93G5YbrN4QkTIgEfgzvKW+4K5OvWSMwBV0JfhMkyqjH6Q/yhNy7mpWLztWIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068525; c=relaxed/simple;
	bh=nHrFvNM3bh3lbKS38lsuzZRKTu1bEfaTjCo0hUglgFA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EAZ/jLHWLJ9ucw1qZuQK+8i9+3v51reJYw935Bn94HgzFO8K3l7QXDAJeEHWdwXTXaF5bkghKqQmlqGTP5EKYg67wYWcwCC0uqV35NUrRp+KeADErFrI0uEShs/fP8rZnwyq0v4JfGgpiaEDlDRiw+0I3WClCwHbwRdXRFJTJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rgznz5BT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706068524; x=1737604524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nHrFvNM3bh3lbKS38lsuzZRKTu1bEfaTjCo0hUglgFA=;
  b=Rgznz5BT4RHuh9m7TiqrYDxfj1C3ii3R8uVe+xaTHfnBY8yUaBnFB4YR
   ADvjBFRpJsJGhnzAJLTL/LAPOpBGNkaINGPhzhcY7K3k6AGR6gRNPPFb1
   VTMV4u9a7tfw6CHEhUTckZExyVxC0gGdlf6thQ7qn74MKZ//Ki2YoF6EX
   00fsTNbxkbaD1At94M7ahzgzETJlnrjZi9IOmZvQXveKeP7DaJSU4+KC+
   DAoRg4hkenOzZASmo6cxH5f6cDtjIGHJ1e/Yl2k1Jff6pyCl63+ZgSJVa
   nySIbzAb1yEJNRQTx4LtP+MNmhxX7AfNiUqbULjimxHNE/y0GRto2dZjC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8407804"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="8407804"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 19:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="28255527"
Received: from lmichele-mobl.amr.corp.intel.com (HELO desk) ([10.209.71.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 19:55:23 -0800
Date: Tue, 23 Jan 2024 19:55:21 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com, daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com, rick.p.edgecombe@intel.com,
	sohil.mehta@intel.com, alexander.shishkin@intel.com
Subject: [PATCH v2] x86/lam: Disable ADDRESS_MASKING in most cases
Message-ID: <5373262886f2783f054256babdf5a98545dc986b.1706068222.git.pawan.kumar.gupta@linux.intel.com>
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

There are no processors in market that support LAM yet, so currently
nobody is affected by this issue.

[1] SLAM: https://download.vusec.net/papers/slam_sp24.pdf
[2] LASS: https://lore.kernel.org/lkml/20230609183632.48706-1-alexander.shishkin@linux.intel.com/

Cc: stable@vger.kernel.org # v6.4+
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
v2:
- Updated commit message to reflect that currently there is no exposure
  of this issue.
- Added review tags.

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



