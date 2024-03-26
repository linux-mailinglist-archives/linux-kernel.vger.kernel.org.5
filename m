Return-Path: <linux-kernel+bounces-118782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15F88BF41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B131F3DC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAF6FE19;
	Tue, 26 Mar 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3dbxA+X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA0679F3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448640; cv=none; b=kDesUFV2tBymB3q0b84i6fRPItxCdZSS5smYqQli93x8wVxkdBHLzz1LPdLRr/Z+qqHydkOz9Dv7wtpOZZJn9oWhGWfxcIeYP6VRQueJiFdJ63h566O6+iPmRWF9GNomuvpi1TC6EQ1qX2bMa/hy7pbuyuLBH0XUTBjK2TKlJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448640; c=relaxed/simple;
	bh=VOfiTsARqXildYZYXwqKq2uHeJt8ZUUANmWAlLL/yeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfz3egS09pkWEUAE3sX1lAPdbt9RS8qUNaPbP5O7S31Zo/J5wa1+OUiPpy3H2PYNVK3peFP1ajIxonxpjgrQ59Rnw1sOkG3enJ+e6zXmf8uq8ECeuy62b4JzGlsuwWyVOa+QGv//qZB0EJL20YaO3SDH1O/TFi3Bi9sZh09scyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3dbxA+X; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711448639; x=1742984639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOfiTsARqXildYZYXwqKq2uHeJt8ZUUANmWAlLL/yeo=;
  b=a3dbxA+XpILIZPTBCknemRIOu/QFRRxA9p93OCq0D3cI3x8m1/iMBeXJ
   F1z8beirsVa69Sgnj+7Ud0m1dUIbLvRah5CoJxeFuTWTp1n5waGuWbGZC
   azWn1pLHYUZdEenH5O0FNlDmxEkz9wroiqXCTFBEClgkQw59wjXg95T+R
   2Ts7W9MRWhzMPG+CbjXjzNJHuxc5+OEOcbVb2gJZA27aJstcHkgXSXaRg
   Ql7vFUGqcBK03LFY+VKuAfRwLhFTAhlQhCGTjR8R6ozD8Y6kPntw+WNtN
   5XNTpBNm6ZFPQn1okI0pAQc9qu+xNXJdsXYznR7/LReERXSkvDc5h1rro
   Q==;
X-CSE-ConnectionGUID: V+XeYC9kQ1eoVUhPji5iEA==
X-CSE-MsgGUID: KIwPzEoXRlmWt+36CAHUDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6678753"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6678753"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="39029392"
Received: from pyong-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.75.208])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:23:56 -0700
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
Subject: [PATCH v2 3/5] x86/virt/tdx: Unbind global metadata read with 'struct tdx_tdmr_sysinfo'
Date: Tue, 26 Mar 2024 23:23:30 +1300
Message-ID: <523bf31a242c022ced57e41e0d0eb58174a9bb71.1711447449.git.kai.huang@intel.com>
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
module initialization, and the metadata read code only works with the
'struct tdx_tdmr_sysinfo'.

KVM will need to read a bunch of non-TDMR related metadata to create and
run TDX guests.  It's essential to provide a generic metadata read
infrastructure which is not bound to any specific structure.

To start providing such infrastructure, unbound the metadata read with
the 'struct tdx_tdmr_sysinfo'.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index cdcb3332bc5d..eb208da4ff63 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -273,9 +273,9 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 
 static int read_sys_metadata_field16(u64 field_id,
 				     int offset,
-				     struct tdx_tdmr_sysinfo *ts)
+				     void *stbuf)
 {
-	u16 *ts_member = ((void *)ts) + offset;
+	u16 *st_member = stbuf + offset;
 	u64 tmp;
 	int ret;
 
@@ -287,7 +287,7 @@ static int read_sys_metadata_field16(u64 field_id,
 	if (ret)
 		return ret;
 
-	*ts_member = tmp;
+	*st_member = tmp;
 
 	return 0;
 }
@@ -297,19 +297,22 @@ struct field_mapping {
 	int offset;
 };
 
-#define TD_SYSINFO_MAP(_field_id, _member) \
-	{ .field_id = MD_FIELD_ID_##_field_id,	   \
-	  .offset   = offsetof(struct tdx_tdmr_sysinfo, _member) }
+#define TD_SYSINFO_MAP(_field_id, _struct, _member)	\
+	{ .field_id = MD_FIELD_ID_##_field_id,		\
+	  .offset   = offsetof(_struct, _member) }
+
+#define TD_SYSINFO_MAP_TDMR_INFO(_field_id, _member)	\
+	TD_SYSINFO_MAP(_field_id, struct tdx_tdmr_sysinfo, _member)
 
 static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
 {
 	/* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
 	const struct field_mapping fields[] = {
-		TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
-		TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
-		TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
-		TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
-		TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
+		TD_SYSINFO_MAP_TDMR_INFO(MAX_TDMRS,		max_tdmrs),
+		TD_SYSINFO_MAP_TDMR_INFO(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
+		TD_SYSINFO_MAP_TDMR_INFO(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
+		TD_SYSINFO_MAP_TDMR_INFO(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
+		TD_SYSINFO_MAP_TDMR_INFO(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
 	};
 	int ret;
 	int i;
-- 
2.43.2


