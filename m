Return-Path: <linux-kernel+bounces-118784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C888BF43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2C51F3DFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F71D6CDA5;
	Tue, 26 Mar 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgSPhqRs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150806BFCB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448648; cv=none; b=TlJQ4Q6IESjt3x27mewtXmy9YxoFLMSntk5uVKfzS0yB7iszB3HLgs8kDMroJV0ZfjMQ0Cv47+gWd5y9j0TzoPTYBY5bw/dVg5cumM+mDnDRYspF9/pie5ynHxdi9ubRS91jWuVvYXKJ3rPlvaOUeXwQMWSWo7YTKGOyABtV49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448648; c=relaxed/simple;
	bh=0fN7gsqYsnGc6ao955RNcoGm8yBWFIYv/ncU5MgaFNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFaeUqzV6kIdO3x8OLkuyZjfxknSLz5CQTFuJX0HThqiOqFA6LDcWXrIEuKzuGJcaHGVdlZDesDl0D2GE7gkUSeJJ3unlIFMJq6WCQkvrjx462ra2xlpgCSMia8YTdHWmwOHpYoEsRRlUDuMvU8NCLpBmRtRjciTI1+vfgvGqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgSPhqRs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448647; x=1742984647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0fN7gsqYsnGc6ao955RNcoGm8yBWFIYv/ncU5MgaFNM=;
  b=kgSPhqRseXGda87W+bnxPA+ntG7A/McFa/lEpNLoBtBeuGBB5+e17YT7
   HKITdg+O8GobNemaN16XToLrKSl6/fFnY/PrUjo9C3MD8aQZ1GdN0y7fx
   O6BnstsgSoDjG1reaPcgg640kQd/0VhAFS+5jUAF0Bhh519n5mRIf1oXs
   aTVfGhQPpKv4JeYEIno9ezhWJ/zBgNBM2H6xkkzNp3uRhb3zf1y3+Fj/Q
   ltsdf23mad2pH59dXWBWNoLJsfurGf2ghVOWgsEDOk/qw9DBzITxc7u6M
   oxAVnRBVnI12PvL8CBGzYalQMxXd1xT4cgRUrmkvLnMA0eQjEz8f3zkpZ
   Q==;
X-CSE-ConnectionGUID: CF0pCFjaQ4ekEm7EQ2DeHg==
X-CSE-MsgGUID: FMMUS7LURdSds3+Ps12czQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6678792"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6678792"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="39029428"
Received: from pyong-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.75.208])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:24:04 -0700
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
Subject: [PATCH v2 5/5] x86/virt/tdx: Export global metadata read infrastructure
Date: Tue, 26 Mar 2024 23:23:32 +1300
Message-ID: <20d6035063f00825b3f4e1f2b6c9abc20c73f177.1711447449.git.kai.huang@intel.com>
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

KVM will need to read a bunch of non-TDMR related metadata to create and
run TDX guests.  Export the metadata read infrastructure for KVM to use.

Specifically, export two helpers:

1) The helper which reads multiple metadata fields to a buffer of a
   structure based on the "field ID -> structure member" mapping table.

2) The low level helper which just reads a given field ID.

The two helpers cover cases when the user wants to cache a bunch of
metadata fields to a certain structure and when the user just wants to
query a specific metadata field on demand.  They are enough for KVM to
use (and also should be enough for other potential users).

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  | 22 ++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 25 ++++++++-----------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eba178996d84..709b9483f9e4 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -116,6 +116,28 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
 int tdx_cpu_enable(void);
 int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
+
+struct tdx_metadata_field_mapping {
+	u64 field_id;
+	int offset;
+	int size;
+};
+
+#define TD_SYSINFO_MAP(_field_id, _struct, _member)	\
+	{ .field_id = MD_FIELD_ID_##_field_id,		\
+	  .offset   = offsetof(_struct, _member),	\
+	  .size     = sizeof(typeof(((_struct *)0)->_member)) }
+
+/*
+ * Read multiple global metadata fields to a buffer of a structure
+ * based on the "field ID -> structure member" mapping table.
+ */
+int tdx_sys_metadata_read(const struct tdx_metadata_field_mapping *fields,
+			  int nr_fields, void *stbuf);
+
+/* Read a single global metadata field */
+int tdx_sys_metadata_field_read(u64 field_id, u64 *data);
+
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4ee4b8cf377c..dc21310776ab 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -251,7 +251,7 @@ static int build_tdx_memlist(struct list_head *tmb_list)
 	return ret;
 }
 
-static int read_sys_metadata_field(u64 field_id, u64 *data)
+int tdx_sys_metadata_field_read(u64 field_id, u64 *data)
 {
 	struct tdx_module_args args = {};
 	int ret;
@@ -270,6 +270,7 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tdx_sys_metadata_field_read);
 
 /* Return the metadata field element size in bytes */
 static int get_metadata_field_bytes(u64 field_id)
@@ -295,7 +296,7 @@ static int stbuf_read_sys_metadata_field(u64 field_id,
 	if (WARN_ON_ONCE(get_metadata_field_bytes(field_id) != bytes))
 		return -EINVAL;
 
-	ret = read_sys_metadata_field(field_id, &tmp);
+	ret = tdx_sys_metadata_field_read(field_id, &tmp);
 	if (ret)
 		return ret;
 
@@ -304,19 +305,8 @@ static int stbuf_read_sys_metadata_field(u64 field_id,
 	return 0;
 }
 
-struct field_mapping {
-	u64 field_id;
-	int offset;
-	int size;
-};
-
-#define TD_SYSINFO_MAP(_field_id, _struct, _member)	\
-	{ .field_id = MD_FIELD_ID_##_field_id,		\
-	  .offset   = offsetof(_struct, _member),	\
-	  .size     = sizeof(typeof(((_struct *)0)->_member)) }
-
-static int read_sys_metadata(const struct field_mapping *fields, int nr_fields,
-			     void *stbuf)
+int tdx_sys_metadata_read(const struct tdx_metadata_field_mapping *fields,
+			  int nr_fields, void *stbuf)
 {
 	int i, ret;
 
@@ -331,6 +321,7 @@ static int read_sys_metadata(const struct field_mapping *fields, int nr_fields,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tdx_sys_metadata_read);
 
 #define TD_SYSINFO_MAP_TDMR_INFO(_field_id, _member)	\
 	TD_SYSINFO_MAP(_field_id, struct tdx_tdmr_sysinfo, _member)
@@ -338,7 +329,7 @@ static int read_sys_metadata(const struct field_mapping *fields, int nr_fields,
 static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
 {
 	/* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
-	const struct field_mapping fields[] = {
+	const struct tdx_metadata_field_mapping fields[] = {
 		TD_SYSINFO_MAP_TDMR_INFO(MAX_TDMRS,		max_tdmrs),
 		TD_SYSINFO_MAP_TDMR_INFO(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
 		TD_SYSINFO_MAP_TDMR_INFO(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
@@ -347,7 +338,7 @@ static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
 	};
 
 	/* Populate 'tdmr_sysinfo' fields using the mapping structure above: */
-	return read_sys_metadata(fields, ARRAY_SIZE(fields), tdmr_sysinfo);
+	return tdx_sys_metadata_read(fields, ARRAY_SIZE(fields), tdmr_sysinfo);
 }
 
 /* Calculate the actual TDMR size */
-- 
2.43.2


