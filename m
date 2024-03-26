Return-Path: <linux-kernel+bounces-118780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C603D88BF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035071C2E181
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957086BFDC;
	Tue, 26 Mar 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c04hqpIO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626686BB28
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448632; cv=none; b=C72nQpQRV3IP2L6owYBDm50fvjCtR9q3v+camSA5GMDBr8ISABH396awXuK97qgrzTV+eIMlHyOnxnCPm8SLBezAhsm5R1+MO+kljsNrlQUYqcRVx7q+VX6qRzmnwskGChlEDFZ2+k71TeAPVPA6kiiMU1uOSVHVBp9WEfLHV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448632; c=relaxed/simple;
	bh=oDcmPTmUa3+5vWVp7KasH47l5t7W1RJvL2Omm6CJWHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFvNLLaGikrXp2z2BEATuWzhRqrJLvHSs7BCXmx/iapI+1CSVSAdvX0cSB2l52lbaN0O4zrdCv6jCsgZHnE9xAOpRuBN5ER/ZJITzNgXdlPuX5zVvvV1Tfa0m2rALifAFfwdRUeZl1rwBwRFWeXrFftaEFaV0C7CARbOojv+2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c04hqpIO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448631; x=1742984631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oDcmPTmUa3+5vWVp7KasH47l5t7W1RJvL2Omm6CJWHs=;
  b=c04hqpIOHbVR4d/1YYtfdBnoWQ9O42E0tVzkZamKAhq9Sb8mysdH+0Gg
   OEYNKj+Ks6IutcMoO8aOMCT2lSXeK5wW7YLA61ahppdNQskVkBLYzpd/X
   Z1nxRHeqL8SnodZwlrJfhGNDQKacplqjyC1sDVixSoKzWqWwa3+N7PigO
   lgxn9AtAGWeJDki6SM/Qz/VOiI+US93f1SAwYtwRrPqLVzY5Rlxlaf2r5
   HODB4M5WUKUCH6oU/oXLdgcx5Fs/s46Z3OpGKRSyqiT4tMS5jlgbzzNc2
   lph0GmDhd9NNVHXVNq6mnLQAEMm2ejBqN5rxcYy/hE/WEGgxQKD2VHoUJ
   Q==;
X-CSE-ConnectionGUID: zvhRZq+TRyq4yj1qdfTRcw==
X-CSE-MsgGUID: YGQwqbM3Rq6ejVjsr0uXLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6678717"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6678717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="39029362"
Received: from pyong-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.75.208])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:48 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	jgross@suse.com,
	binbin.wu@linux.intel.com,
	kai.huang@intel.com
Subject: [PATCH v2 1/5] x86/virt/tdx: Rename _offset to _member for TD_SYSINFO_MAP() macro
Date: Tue, 26 Mar 2024 23:23:28 +1300
Message-ID: <fd3eba30108767ed37eee3cd10026cbaa34778e4.1711447449.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711447449.git.kai.huang@intel.com>
References: <cover.1711447449.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TD_SYSINFO_MAP() macro actually takes the member of the 'struct
tdx_tdmr_sysinfo' as the second argument and uses the offsetof() to
calculate the offset for that member.

Rename the macro argument _offset to _member to reflect this.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4d6826a76f78..2aee64d2f27f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -297,9 +297,9 @@ struct field_mapping {
 	int offset;
 };
 
-#define TD_SYSINFO_MAP(_field_id, _offset) \
+#define TD_SYSINFO_MAP(_field_id, _member) \
 	{ .field_id = MD_FIELD_ID_##_field_id,	   \
-	  .offset   = offsetof(struct tdx_tdmr_sysinfo, _offset) }
+	  .offset   = offsetof(struct tdx_tdmr_sysinfo, _member) }
 
 /* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
 static const struct field_mapping fields[] = {
-- 
2.43.2


