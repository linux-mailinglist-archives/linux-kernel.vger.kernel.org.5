Return-Path: <linux-kernel+bounces-41151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08983ECA0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4B61C21B60
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04658200D5;
	Sat, 27 Jan 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZI86kCx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE21EB32
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350137; cv=none; b=VlyufzOkmL0lU4ZXs8Wasz+4ME9CW6sUKDMvYZaGFMiO1ny/oURMXKUNH6yfr2ve5CgnZATY1iyA9XVIc6Kh9UbEvb1l4H/OTIsa8n1nQiqC1vb1Aykhf8vnQN9GIpoj4O+pN5BhHyy5wzh7896eUg6ysZkCoql2px9EmkPUpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350137; c=relaxed/simple;
	bh=Q0bhMrxpzirRicWRr76Yp7IjH2KX2X0N9M5pN7rBDOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXCrJA5d1Ao67+Nzonx7H8+L+pL+fOeHWgI6vchqdYM9+WQVV6luZO8toxXmIa660R/FI+/S8WrAIZOyF71lbg/H20m5cAZCKz9mLQX7Yi6v0IveWWN8gohebHcOb0CuLQstFnnILbw+5ViPLoePO1hAQR3l7XEDL7hz4thdgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZI86kCx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706350135; x=1737886135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q0bhMrxpzirRicWRr76Yp7IjH2KX2X0N9M5pN7rBDOU=;
  b=FZI86kCxsv9/+Z7PgqLu8vqRIiE7Y0gSgE3/8JG0xO/u2Ad5BL0luetM
   BScQ1b484Gaykahg0otPDfZ5/8MjowzBrF7VJjft4BIMyvLnGXnNoto30
   4dotHcxgQrmKVNteBrpdm9XQbFEWxVwVUnxeNYyA0c2qJip8HnqHuFP7s
   EY16FQ9WmDqbA2WrWpJ9aAxEncp6m+Bf5IEY1dBfGfTV7Ql8TBq76rZ8N
   LA4Z+i9zhe2mtTYFm7Af0CzYeiTjPvJhYqNmhDq+DNHabeD48n8lLe4ih
   WBRix6NYY4WaVmdZteqLw1Hm2BvO8VTQiOlwpHgF6SyDVFUG1a/I6ckEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="16190982"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16190982"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 02:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736923492"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="736923492"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2024 02:08:52 -0800
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
Subject: [PATCH 2/2] x86/fred: Fix build with CONFIG_IA32_EMULATION=n
Date: Sat, 27 Jan 2024 01:37:28 -0800
Message-ID: <20240127093728.1323-3-xin3.li@intel.com>
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

When CONFIG_IA32_EMULATION=n, int80_emulation() is NOT defined, fix it.

Fixes: 5e0636a41485 ("x86/fred: FRED entry/exit and dispatch code")
Link: https://lore.kernel.org/lkml/20240126100519.GBZbOD3xFB0v3mp5B1@fat_crate.local/
Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/entry/entry_fred.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 06d00c60ea64..ac120cbdaaf2 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -62,11 +62,13 @@ static noinstr void fred_intx(struct pt_regs *regs)
 	case X86_TRAP_OF:
 		return exc_overflow(regs);
 
+#ifdef CONFIG_IA32_EMULATION
 	/* INT80 */
 	case IA32_SYSCALL_VECTOR:
 		if (ia32_enabled())
 			return int80_emulation(regs);
 		fallthrough;
+#endif
 
 	default:
 		return exc_general_protection(regs, 0);
-- 
2.43.0


