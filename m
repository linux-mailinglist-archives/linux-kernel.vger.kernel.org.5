Return-Path: <linux-kernel+bounces-41150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6483EC9F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494671F2366D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EA1F955;
	Sat, 27 Jan 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljV/bZI+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB21E88B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350136; cv=none; b=rR+FpxSxl3d3P0wFkkCVWuAUb71ZV0vHdqT4DSsR6ZJfwyToPtF7hBYQ7yElrWzsOnXKBdPPp0TwihMVBBBj96XbMVlc70O1QFmQwhjx4ELoDFP6PayNS8YGT4MNExqrHIiRH6zjowTtrj//W4i2LEjuuNS8pJulVM+EBgxKuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350136; c=relaxed/simple;
	bh=bXMF274IqJ6MOt+D70wBFlrfZWyDlvVU+rh4CQrcsg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8XBnNPHIbyTa4PfgkWyoK2EqhCLcEcLvT4M570bsXYO7pf+bCWOwmaqPozUrEcd5Ty5HIVs1ZJRWCswrPTt/riiX0zTopWwm8MJwFVJlDIXc+4Mg+XQk3jdcSXptrqZxIyDjOiDtBy+YT8drNDyEppCMcWhug58vrfy3+jVEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljV/bZI+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706350135; x=1737886135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXMF274IqJ6MOt+D70wBFlrfZWyDlvVU+rh4CQrcsg4=;
  b=ljV/bZI+nKVnuetBKnR86yb5MNFco/1g/FuK7am+SWHd5QsmSr/qXTZI
   2Rr74VfJKmX+4QfDpsuG1ZTBsPI4v3rcY1I7aocjT/CXQKEep0T1xZe3m
   8iOLaTQ8xxmVHb7SkZOm11wdcVPTk7NKggsVOAp6PmaKG/YUMhroLHjw0
   X+BBpbUHlkhc7JMWMDCMQ1CqWjRU4yuMsi+Ubdo2BST2KhN5rXw7f9RAJ
   wsCrxX67TdWqRYBXafGDDmxJ6/QhOWdafgNwM9NCt2qwJUwyEKBzTOB9U
   g6K0VQVZoOi2+Kqv3b8pduuDiCYH98BCwkUFQsY70cqVQ0tQt0SZQIjdw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="16190972"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16190972"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 02:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736923489"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="736923489"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2024 02:08:51 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	ravi.v.shankar@intel.com,
	andrew.cooper3@citrix.com
Subject: [PATCH 1/2] x86/fred: Fix build with clang
Date: Sat, 27 Jan 2024 01:37:27 -0800
Message-ID: <20240127093728.1323-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127093728.1323-1-xin3.li@intel.com>
References: <20240127093728.1323-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As clang doesn't allow .fill to refernece a symbol before it's defined,
use asm_fred_entrypoint_user instead of asm_fred_entrypoint_kernel.

Fixes: 5e0636a41485 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/lkml/20240126100050.GAZbOC0g3Rlr6otZcT@fat_crate.local/
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/entry/entry_64_fred.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index eedf98de7538..5427e0da190d 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -43,13 +43,12 @@ SYM_INNER_LABEL(asm_fred_exit_user, SYM_L_GLOBAL)
 	_ASM_EXTABLE_TYPE(1b, asm_fred_entrypoint_user, EX_TYPE_ERETU)
 SYM_CODE_END(asm_fred_entrypoint_user)
 
-.fill asm_fred_entrypoint_kernel - ., 1, 0xcc
-
 /*
  * The new RIP value that FRED event delivery establishes is
  * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
  * ring 0, i.e., asm_fred_entrypoint_user + 256.
  */
+	.fill asm_fred_entrypoint_user + 256 - ., 1, 0xcc
 	.org asm_fred_entrypoint_user + 256
 SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
 	FRED_ENTER
-- 
2.43.0


