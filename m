Return-Path: <linux-kernel+bounces-106898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96EA87F52A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0E41C2149E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E216F65198;
	Tue, 19 Mar 2024 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfV9D6U4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E18F72
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812937; cv=none; b=e9PWNTNbinEba5vK2FN2xa1I9hWFk4HzXCguFw254SzwmnBlsqPqbcOd31r2W+BhrasyUkI1U+38TNQahzh1/VcG3OHp5ecDL5VRODuirGKaFEBJ5RnuhcRgAaOV5VuydAJ4BAGDUQKJ8j/sVT0ZFi7ZQMgk3JNK12C8Hsl85CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812937; c=relaxed/simple;
	bh=LnWlBNfTDWHh58y1phkPOt1JzGmEm4RmOHBPdmXruQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kCn7XmdOTI2iyFKd/aNWMxsj5l0rAwxvWIkZk4+FFrT0b+Wlt80uiI7Sb/BgTSwyIU7xlHlwkZZunclOotn4e69zJyBO+RS5ywZqwlvHmDpXSuIdK4LTPlVP3i198Wxs+D9BlAMRmU/hYiChMAI1r8W5BEJdi2OHXRJjbb8xWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfV9D6U4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710812935; x=1742348935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LnWlBNfTDWHh58y1phkPOt1JzGmEm4RmOHBPdmXruQo=;
  b=UfV9D6U45lnUDk4nSWSCFpT/CO8qpOZqoUkZp2DYPqJpOrwtoJ0anDiD
   bETaFEZolMIM8wrA8GujaaaMpvehvcDCxTZwdpJz/p8tJjaBD80aEgjDj
   2L1ylMsDqxsRSlpXk4IIVta/r/Qtwc1VTeuYmJemW1+OOl1iMAXiKUbB4
   xCScKfzOi2HdwJdAH63JYT4PA+hpOR6lzLrPTcc/HhR4dWmhwY4Vpk29f
   hpbcIeYmnAzN+IrZ1D83BcS1+JPNkYcs8pyH9hRkNfPhZCfd7qCDpjKxy
   dnz+bXWSDhCKYnbeHFfKbD7MU1qZ7b5fsgikmEO2cYMua7H/1H6VFbSE7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5776866"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5776866"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13697312"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:48:50 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v2 0/5] TDX host: kexec() support
Date: Tue, 19 Mar 2024 01:48:43 +0000
Message-Id: <cover.1710811610.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kexec() support and TDX host are muturally exclusive in the
Kconfig.  This series adds the TDX host kexec support so that they can
work together and can be enabled at the same time in the Kconfig.

v1 -> v2:
 - Do unconditional WBINVD during kexec() -- Boris
 - Change to cover crash kexec() -- Rick
 - Add a new patch (last one) to add a mechanism to reset all TDX private
   pages due to having to cover crash kexec().
 - Other code improvements  -- Dave
 - Rebase to latest tip/master.

Hi Dave, Sean, Paolo,

The last patch provides a new mechanism to handle all other TDX private
pages when they become possible to exist, e.g., when KVM is ready to run
TDX guests.  It's not mandatory at this stage because currently we only
have PAMT as private pages, but if we agree it's the right way to do then
it can be applied together with rest patches too.

KVM will be the first user of this, could you help to review?

Thanks in advance.

Hi Tom, Ashish,

This series touches AMD SME code too, and I don't have AMD machine to
test.  I appreciate if you can help to review and/or test.

Kai Huang (5):
  x86/kexec: do unconditional WBINVD in stop_this_cpu()
  x86/kexec: do unconditional WBINVD in relocate_kernel()
  x86/kexec: Reset TDX private memory on platforms with TDX erratum
  x86/virt/tdx: Remove the !KEXEC_CORE dependency
  x86/virt/tdx: Add TDX memory reset notifier to reset other private
    pages

 arch/x86/Kconfig                     |   1 -
 arch/x86/include/asm/kexec.h         |   3 +-
 arch/x86/include/asm/tdx.h           |  16 +++++
 arch/x86/kernel/machine_kexec_64.c   |  30 ++++++--
 arch/x86/kernel/process.c            |  17 ++---
 arch/x86/kernel/relocate_kernel_64.S |  13 +---
 arch/x86/virt/vmx/tdx/tdx.c          | 100 +++++++++++++++++++++++++++
 7 files changed, 150 insertions(+), 30 deletions(-)


base-commit: 7e19a79344df2ed5e106091c29338962261b0290
-- 
2.34.1


