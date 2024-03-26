Return-Path: <linux-kernel+bounces-118783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39188BF42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FE61F3E44B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866E7173E;
	Tue, 26 Mar 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h08lFlKR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08A71727
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448644; cv=none; b=sDZLKFEEySO9VCHvYThil+oaWnY7NXeTqsfrpejCT43L+vwOZ8Rx/GerY6RTZK44/kh+GincWpFCPZ8a/TDOmQH9CmWTnyo0U4UcF8cCT5G0vo+bCzGpC5ZUyq/5Qt2tQdpu4Pqv7h1pbCbsUa0mKh/yAAPCqfamW0upnUCibLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448644; c=relaxed/simple;
	bh=0eBX029BCiLTue40MgYy0Z6NggPwsRuK/phCsbkLIbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeH1Cj2JKonOThzpa8zniO2WezntYFuBtdASIyMKJ+ZOOlY+5a1+Km06/CdNxax48w91lIPxaYPUX9uVfFN6Q1nIjtijEEFk2QqR6EkhRmnfKxaSqpAowk+VQuGmJ0fyVveowdBjAlov4jplbKY9Ez0Hv3lnrYS2VJ+oCcCFqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h08lFlKR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448643; x=1742984643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0eBX029BCiLTue40MgYy0Z6NggPwsRuK/phCsbkLIbo=;
  b=h08lFlKRg/2SF86g6i9Ji6K90wqWEb6Dy9XOYfJRCsBp0+0w6sibiKGA
   UpK6o5ittE5K+8EPKVu6LzIUvTf6wIaYpxsVZv1W9PFJf8iRS6Kr4bk0V
   Q62g5xVF6NHjwxlvNjMDWXs3dtTDQ4VqW4w2iU69QgSnz0o7UML0VvXRQ
   rX/TU4LN5nOm0CGGozYjkaaeaJDT2JreoecOY7hQkZpz22MBYQ39G4gwF
   JwG8+p94nlG+0j2vQpxycPwWf5vgJ7ATziogEFp9/KYBNDxPUiXXwQ8oG
   fFhej0dZyyip2dg+PgvuwTsfGRcuNwqZMUIgikk1rZ8LyMNaqJHjWVomU
   A==;
X-CSE-ConnectionGUID: oo+Pj7oVQOeyR+Pfc8werA==
X-CSE-MsgGUID: jPsG+tF0T52r5Qkjf/w1ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6678780"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6678780"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="39029406"
Received: from pyong-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.75.208])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:24:00 -0700
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
Subject: [PATCH v2 4/5] x86/virt/tdx: Support global metadata read for all element sizes
Date: Tue, 26 Mar 2024 23:23:31 +1300
Message-ID: <bb4b780694f962a90e00de11a244c9c648070902.1711447449.git.kai.huang@intel.com>
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

For now the kernel only reads TDMR related global metadata fields for
module initialization.  All these fields are 16-bits, and the kernel
only supports reading 16-bits fields.

KVM will need to read a bunch of non-TDMR related metadata to create and
run TDX guests.  It's essential to provide a generic metadata read
infrastructure which supports reading all 8/16/32/64 bits element sizes.

Extend the metadata read to support reading all these element sizes.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 59 +++++++++++++++++++++++++------------
 arch/x86/virt/vmx/tdx/tdx.h |  2 --
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index eb208da4ff63..4ee4b8cf377c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -271,23 +271,35 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 	return 0;
 }
 
-static int read_sys_metadata_field16(u64 field_id,
-				     int offset,
-				     void *stbuf)
+/* Return the metadata field element size in bytes */
+static int get_metadata_field_bytes(u64 field_id)
 {
-	u16 *st_member = stbuf + offset;
+	/*
+	 * TDX supports 8/16/32/64 bits metadata field element sizes.
+	 * TDX module determines the metadata element size based on the
+	 * "element size code" encoded in the field ID (see the comment
+	 * of MD_FIELD_ID_ELE_SIZE_CODE macro for specific encodings).
+	 */
+	return 1 << MD_FIELD_ID_ELE_SIZE_CODE(field_id);
+}
+
+static int stbuf_read_sys_metadata_field(u64 field_id,
+					 int offset,
+					 int bytes,
+					 void *stbuf)
+{
+	void *st_member = stbuf + offset;
 	u64 tmp;
 	int ret;
 
-	if (WARN_ON_ONCE(MD_FIELD_ID_ELE_SIZE_CODE(field_id) !=
-			MD_FIELD_ID_ELE_SIZE_16BIT))
+	if (WARN_ON_ONCE(get_metadata_field_bytes(field_id) != bytes))
 		return -EINVAL;
 
 	ret = read_sys_metadata_field(field_id, &tmp);
 	if (ret)
 		return ret;
 
-	*st_member = tmp;
+	memcpy(st_member, &tmp, bytes);
 
 	return 0;
 }
@@ -295,11 +307,30 @@ static int read_sys_metadata_field16(u64 field_id,
 struct field_mapping {
 	u64 field_id;
 	int offset;
+	int size;
 };
 
 #define TD_SYSINFO_MAP(_field_id, _struct, _member)	\
 	{ .field_id = MD_FIELD_ID_##_field_id,		\
-	  .offset   = offsetof(_struct, _member) }
+	  .offset   = offsetof(_struct, _member),	\
+	  .size     = sizeof(typeof(((_struct *)0)->_member)) }
+
+static int read_sys_metadata(const struct field_mapping *fields, int nr_fields,
+			     void *stbuf)
+{
+	int i, ret;
+
+	for (i = 0; i < nr_fields; i++) {
+		ret = stbuf_read_sys_metadata_field(fields[i].field_id,
+				      fields[i].offset,
+				      fields[i].size,
+				      stbuf);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
 
 #define TD_SYSINFO_MAP_TDMR_INFO(_field_id, _member)	\
 	TD_SYSINFO_MAP(_field_id, struct tdx_tdmr_sysinfo, _member)
@@ -314,19 +345,9 @@ static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
 		TD_SYSINFO_MAP_TDMR_INFO(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
 		TD_SYSINFO_MAP_TDMR_INFO(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
 	};
-	int ret;
-	int i;
 
 	/* Populate 'tdmr_sysinfo' fields using the mapping structure above: */
-	for (i = 0; i < ARRAY_SIZE(fields); i++) {
-		ret = read_sys_metadata_field16(fields[i].field_id,
-						fields[i].offset,
-						tdmr_sysinfo);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return read_sys_metadata(fields, ARRAY_SIZE(fields), tdmr_sysinfo);
 }
 
 /* Calculate the actual TDMR size */
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index b701f69485d3..4c32c8bf156a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -53,8 +53,6 @@
 #define MD_FIELD_ID_ELE_SIZE_CODE(_field_id)	\
 		(((_field_id) & GENMASK_ULL(33, 32)) >> 32)
 
-#define MD_FIELD_ID_ELE_SIZE_16BIT	1
-
 struct tdmr_reserved_area {
 	u64 offset;
 	u64 size;
-- 
2.43.2


