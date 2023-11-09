Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF187E69FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKIL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjKIL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:56:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849A258A;
        Thu,  9 Nov 2023 03:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699530989; x=1731066989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HF7MlTTHWaoqqF7UOJWx6jm6FNM58OFAIxssBuNOECk=;
  b=QSeI+6e/PJY4+MK+g7ETg/VBnFUpWBMHmF5eGjm4btSNFfdH+CLbU0Nw
   KT3zB4mIAX1w7etE9p9lW/5gPDtGdOmtZrFf7EbSr8M65FXk3b54veI/X
   Xi4J6gV4vi8AzDdm/1M6Wj5cuYioRPmhG2XY7hnfdXRENqZAmRH6tl46N
   j8ISxSckVW2yzQ7JNKEuR8HQHttBqjsITM3eX7PR8bnp49YGtcbK0hXYU
   pZNeXlx/cnyIhw5fcpKany/zczNkNuOo9RsCF7BoJ0G4j4mknYsPRcPdA
   Hoxz96MqhKCjWUA09DYiIoTmtJPSxwkaThB1hEueaPOAsgeYh+B5cY9p5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2936287"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2936287"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:56:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="766976597"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="766976597"
Received: from shadphix-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.83.35])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:56:22 -0800
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, peterz@infradead.org,
        tony.luck@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, rafael@kernel.org, david@redhat.com,
        dan.j.williams@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, ying.huang@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com,
        bagasdotme@gmail.com, sagis@google.com, imammedo@redhat.com,
        kai.huang@intel.com
Subject: [PATCH v15 02/23] x86/tdx: Define TDX supported page sizes as macros
Date:   Fri, 10 Nov 2023 00:55:39 +1300
Message-ID: <0bd08623a4cb11d783592977f74d04b3678990b3.1699527082.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699527082.git.kai.huang@intel.com>
References: <cover.1699527082.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX supports 4K, 2M and 1G page sizes.  The corresponding values are
defined by the TDX module spec and used as TDX module ABI.  Currently,
they are used in try_accept_one() when the TDX guest tries to accept a
page.  However currently try_accept_one() uses hard-coded magic values.

Define TDX supported page sizes as macros and get rid of the hard-coded
values in try_accept_one().  TDX host support will need to use them too.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/coco/tdx/tdx-shared.c    | 6 +++---
 arch/x86/include/asm/shared/tdx.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 78e413269791..1655aa56a0a5 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -22,13 +22,13 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	 */
 	switch (pg_level) {
 	case PG_LEVEL_4K:
-		page_size = 0;
+		page_size = TDX_PS_4K;
 		break;
 	case PG_LEVEL_2M:
-		page_size = 1;
+		page_size = TDX_PS_2M;
 		break;
 	case PG_LEVEL_1G:
-		page_size = 2;
+		page_size = TDX_PS_1G;
 		break;
 	default:
 		return 0;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index ccce7ebd8677..a4036149c484 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -55,6 +55,11 @@
 	(TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
 	 TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15)
 
+/* TDX supported page sizes from the TDX module ABI. */
+#define TDX_PS_4K	0
+#define TDX_PS_2M	1
+#define TDX_PS_1G	2
+
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler_attributes.h>
-- 
2.41.0

