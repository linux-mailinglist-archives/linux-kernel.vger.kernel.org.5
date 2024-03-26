Return-Path: <linux-kernel+bounces-118781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46788BF40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924E4B2386A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B00F6EB7A;
	Tue, 26 Mar 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPykkJJy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652C6E616
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448636; cv=none; b=EXZV44g2SVt368I6+l+SgQS+f7oXRf+Jhu2Hj6Ifx0NRDaBekhVLz/deV2DTJhAEBSmG9aNbKWsLvr81nuLCpTJ1vNbipkoDdxdZ1nphA+UuxnUCkBWryH6XGJu/1WmMA89+dos0bfHLnMEkg2h3Zh1hyXFV3hyt9teWENHiNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448636; c=relaxed/simple;
	bh=51JNBBGZzWTv/aoufz0WmxORKDck5dLGXWqspgSfLHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIRyAIElDB3RqOuaR0Xz/f+qLaiDrSGZ9b3Y1bFSl33T67JLxABH2L1sxVE0u7cdt7rkRQuByagI6qd0VkALNPDulIcKn2tM0d4wH3FEdqADeJ4X6G9Bon0fN7Z0NEB6oWNNVUe9yCYLErGM2rrSLI8sWpvgRWzDaruSLd4A7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPykkJJy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448635; x=1742984635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=51JNBBGZzWTv/aoufz0WmxORKDck5dLGXWqspgSfLHA=;
  b=EPykkJJy3KPZzDg4/XC4mENrJJHG9spH8wVGHAIkPRn7Lw+pZthXJnjS
   UTKcSJNGFkd5AweQynXRXmpF5aRbHLV1WsKUpPBuvVLxZ9zGuJBlTn76l
   UrPEfPqffY9l/giuWLmcH9EaxdZWi/WufJ7oWpArxTGyLYX5Cqwo30R0H
   vtRzVZMA+m64foh6JrKVvimh0+g2ACuhz6X/XO2EUUEeHT3OsIE4zOWUm
   gYfo80Q9F626spZjZrceV42CSLnOZa+PDO7J8fLSpjiRiQWzpHER0wGtX
   twb5UTKq3ZoZIdbz26lw1N3wwD0yX6ypyrg8o0Mxl61bkd3eayG+AP79E
   w==;
X-CSE-ConnectionGUID: tvk0VDYoTPuvW4VHShPfgw==
X-CSE-MsgGUID: L8WkJ/ItTTOO6g3nYCg9/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6678735"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6678735"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="39029377"
Received: from pyong-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.75.208])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:52 -0700
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
Subject: [PATCH v2 2/5] x86/virt/tdx: Move TDMR metadata fields map table to local variable
Date: Tue, 26 Mar 2024 23:23:29 +1300
Message-ID: <8720e0316a713c06d314e7c85fac5b1c501ef4cd.1711447449.git.kai.huang@intel.com>
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

The kernel reads all TDMR related global metadata fields based on a
table which maps the metadata fields to the corresponding members of
'struct tdx_tdmr_sysinfo'.

Currently this table is a static variable.  But this table is only used
by the function which reads these metadata fields and becomes useless
after reading is done.

Change the table to function local variable.  This also saves the
storage of the table from the kernel image.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2aee64d2f27f..cdcb3332bc5d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -301,17 +301,16 @@ struct field_mapping {
 	{ .field_id = MD_FIELD_ID_##_field_id,	   \
 	  .offset   = offsetof(struct tdx_tdmr_sysinfo, _member) }
 
-/* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
-static const struct field_mapping fields[] = {
-	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
-	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
-	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
-	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
-	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
-};
-
 static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
 {
+	/* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
+	const struct field_mapping fields[] = {
+		TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
+		TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
+		TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
+		TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
+		TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
+	};
 	int ret;
 	int i;
 
-- 
2.43.2


