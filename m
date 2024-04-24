Return-Path: <linux-kernel+bounces-157466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266E18B11F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D679528ED36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF6717994C;
	Wed, 24 Apr 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAAcl3uF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D3178CF1;
	Wed, 24 Apr 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982513; cv=none; b=kbUi8Ltz8BhWdB+lpoVkxbJ0UDdbTnyLCPggx2KRJuTW5MhwokLCWbbkN1XgzedesL8D5DMjqR2AlgqWCclhwp6R8Xr6t9yB+AozmduJdMHApsbNshKAA6Jbu0YkaYACIVS71nAJCLf0fhIqn6jtt1IGPeMa4v7UBotbNvbuwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982513; c=relaxed/simple;
	bh=CwybUVe8crx1l4CZK03c9vCx8DvC8Bgt8uPcKdw9g+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVzH1jitA5Sh2gx09/HvH3daPjAfI7gBk/Ilpss1IwsFGWJoG6NEd2mDWmv8XS+O2AOZC0dX3Kt+xp1lji1pJbHrtAMpeEYIr5o6xztmwAzMoh4GugFzZWrP1cIgcv2xhKolnZitRUNY+vLJYQKSh7cMzMloqQ2jRoPTAClaKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAAcl3uF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982511; x=1745518511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwybUVe8crx1l4CZK03c9vCx8DvC8Bgt8uPcKdw9g+E=;
  b=bAAcl3uFqRB9u8Gf3IwmVVdlEML24vDkIZ2J+EnIUeNIIq7e3dq7Ssnp
   9vXumMjUDrBdGa/HQIBK8QGs+DZ6R4lcnF+Zvtn61Jkr0ACKiyYChRNHJ
   WmGCHjXe0RHGaGqxfx61OuKJ5aOsUO6wImFJqOe/JOHcMw87vYu3eCzuN
   fFkMWL1X8euGoplAqtDb+ccVBoe/rkasHlcW6mlbpoBkpqtjdSMtPNKpK
   GiKyypZfilfBXyFK2/p/FvSEcZ3MQ1Dfo2iScVOVxGBinIdod3Qxw1qSL
   POPrseuLRSm+DB9nMfDsdweAP0ikM4WMhtQ67a8JCod4/K6wRzpFJG27n
   w==;
X-CSE-ConnectionGUID: uHGqBQJ0SkOyduGKD8eHjA==
X-CSE-MsgGUID: RZ+vYtXeQyKgftJTZUb8xA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481843"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481843"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:59 -0700
X-CSE-ConnectionGUID: fIvJjhdlSqKYHN3AWZyHZg==
X-CSE-MsgGUID: jJio6ahnToe8mAdZagIthw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262631"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:14:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 17/71] crypto: x86/twofish - Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:14:58 -0700
Message-ID: <20240424181458.41481-1-tony.luck@intel.com>
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
 arch/x86/crypto/twofish_glue_3way.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/twofish_glue_3way.c b/arch/x86/crypto/twofish_glue_3way.c
index 90454cf18e0d..82311249048f 100644
--- a/arch/x86/crypto/twofish_glue_3way.c
+++ b/arch/x86/crypto/twofish_glue_3way.c
@@ -12,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
+
 #include "twofish.h"
 #include "ecb_cbc_helpers.h"
 
@@ -107,10 +109,10 @@ static bool is_blacklisted_cpu(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
 
-	if (boot_cpu_data.x86 == 0x06 &&
-		(boot_cpu_data.x86_model == 0x1c ||
-		 boot_cpu_data.x86_model == 0x26 ||
-		 boot_cpu_data.x86_model == 0x36)) {
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_ATOM_BONNELL:
+	case INTEL_ATOM_BONNELL_MID:
+	case INTEL_ATOM_SALTWELL:
 		/*
 		 * On Atom, twofish-3way is slower than original assembler
 		 * implementation. Twofish-3way trades off some performance in
-- 
2.44.0


