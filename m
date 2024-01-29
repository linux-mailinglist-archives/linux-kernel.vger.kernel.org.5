Return-Path: <linux-kernel+bounces-42277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D357A83FEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EF01C20E01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971AC4EB54;
	Mon, 29 Jan 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQFJhcJE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A14EB4B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512604; cv=none; b=OV7qOwrF4mNYVYEaxFEJEfP4d6D0z8o1uaG3kEmpKMX9h2SnOaSOgPW4UN6403XYelEuTUnRxRvqe1XWyB3EA2uD8uU5pWha0LINjcsoIAWaj7E1K9QcZeAlE9ovi6kPtfXM0BLCqiXHR8FcamCzGcng0UKg9aMEkvaQiaLIMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512604; c=relaxed/simple;
	bh=eu/lfYcQTfH29bR12vR2FEP4YlJ9vPNwxcdt4UtKOJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqysKCJDXuOfWSVl9eb6yzHcvkbgek5Aib16aZEdszrDKmHRpuk/lddWy7j8KWYnbfJqa6LKCF4tNKeu/JfKtqiueKoS1R7GvXmeRpHqaookVhqECCGoWRCut7n5RSA8+PsMumtX5mTA8C5OV5dCabLK2j6t01Ais/EDpCB8n30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQFJhcJE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706512604; x=1738048604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eu/lfYcQTfH29bR12vR2FEP4YlJ9vPNwxcdt4UtKOJY=;
  b=nQFJhcJEIUXbcSXbT4TTBMW+Hq4dImuoliNn9bPZbosEy1VsSD9huGas
   Z4Hp/H4wde6ftDqlIEPWj6z2B/7VpeVMh8Q3ILtH4BhPdGheicGQv+heX
   gZaqTbhaiLFoV1PY30f/ZapC8kEIqwk2riAvgAPRrZk9vk12As1Bouhg3
   fZ/iPiuET8iWnpqajqNtmochcGussTHJ/2CnMlqUOrhPm7A506eQGd9fB
   GT2JqBeZZZBVJUruyB2PVIchnC5CsWHGAT2xCeP60m9MYVzLMLFaUrs5Q
   yRt+iz4AZ8b0UgzwfpObfbm18BmSZEcAV/jdjGcU5GCWAS4HJyQIwVOs5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2761650"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2761650"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 23:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="931001233"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="931001233"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2024 23:16:42 -0800
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
Subject: [PATCH v1A 1/2] x86/fred: Fix build with clang
Date: Sun, 28 Jan 2024 22:45:21 -0800
Message-ID: <20240129064521.5168-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <882e400f-913b-4ed5-9611-ef87cd8b58b2@zytor.com>
References: <882e400f-913b-4ed5-9611-ef87cd8b58b2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the .fill statement that referneces asm_fred_entrypoint_kernel()
before it's defined, which breaks clang build.

Use the .org directive instead to fill "int3" into the memory between
asm_fred_entrypoint_user() and asm_fred_entrypoint_kernel().

Fixes: 5e0636a41485 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/lkml/20240126100050.GAZbOC0g3Rlr6otZcT@fat_crate.local/
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Change since v1:
* Use ".org ..., 0xcc" to fill "int3" into memory (H. Peter Anvin).
---
 arch/x86/entry/entry_64_fred.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index eedf98de7538..a02bc6f3d2e6 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -43,14 +43,12 @@ SYM_INNER_LABEL(asm_fred_exit_user, SYM_L_GLOBAL)
 	_ASM_EXTABLE_TYPE(1b, asm_fred_entrypoint_user, EX_TYPE_ERETU)
 SYM_CODE_END(asm_fred_entrypoint_user)
 
-.fill asm_fred_entrypoint_kernel - ., 1, 0xcc
-
 /*
  * The new RIP value that FRED event delivery establishes is
  * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
  * ring 0, i.e., asm_fred_entrypoint_user + 256.
  */
-	.org asm_fred_entrypoint_user + 256
+	.org asm_fred_entrypoint_user + 256, 0xcc
 SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
 	FRED_ENTER
 	call	fred_entry_from_kernel
-- 
2.43.0


