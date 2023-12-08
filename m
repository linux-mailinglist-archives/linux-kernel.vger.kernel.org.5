Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D080AA77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjLHRSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574453AbjLHRRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1229D54;
        Fri,  8 Dec 2023 09:17:27 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vgJz6wmXY2UczkVy8k3Q1WmRUBF75RtD/+nsZIWtrFI=;
        b=GXL5gBCOXDqB0MJF3eJX+9gQ2GnOXl9WBMVPm6a8Aie0/gVZxtBzPjS5g+2J+wL6frgdhv
        wTTjzCv0q8lXuU1lPFawgiriVd4lyBZY6FGspMyqWbZM8DuuhDb0bivd+d/+fJQ7Rdzsxt
        q4pS0Fqfo9yYxxkpHd9UGyMIynKpdP6owVIgifBEQQrjfhg+Wr13ninObZJjyc11BDY6w0
        2knls5LXRP0MfEn1AcwK5kYAbXJx5/733rh1YMrvHhEjKXTdIiTfgtzOSIFyZpdXzbaot5
        Cg2rLVs5Q45qjB62M4ssF7RT5EAelSmVjglj2bu5tKOfIfcqqVuqOUipXZ9S7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vgJz6wmXY2UczkVy8k3Q1WmRUBF75RtD/+nsZIWtrFI=;
        b=0HwQj9SBTC5g/rXFQNfM4DvJLyPkH7lK84vKZhhMjvLFsI6kltz8GNlNTH8DlCFIjt0M7l
        pcMWHLNQFYYT3GCA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Get module global metadata for module
 initialization
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584556.398.6635190576849842408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     cf72bc481634b7c4cd780b6338f222e2892b0232
Gitweb:        https://git.kernel.org/tip/cf72bc481634b7c4cd780b6338f222e2892b0232
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:28 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:18 -08:00

x86/virt/tdx: Get module global metadata for module initialization

The TDX module global metadata provides system-wide information about
the module.

TL;DR:

Use the TDH.SYS.RD SEAMCALL to tell if the module is good or not.

Long Version:

1) Only initialize TDX module with version 1.5 and later

TDX module 1.0 has some compatibility issues with the later versions of
module, as documented in the "Intel TDX module ABI incompatibilities
between TDX1.0 and TDX1.5" spec.  Don't bother with module versions that
do not have a stable ABI.

2) Get the essential global metadata for module initialization

TDX reports a list of "Convertible Memory Region" (CMR) to tell the
kernel which memory is TDX compatible.  The kernel needs to build a list
of memory regions (out of CMRs) as "TDX-usable" memory and pass them to
the TDX module.  The kernel does this by constructing a list of "TD
Memory Regions" (TDMRs) to cover all these memory regions and passing
them to the TDX module.

Each TDMR is a TDX architectural data structure containing the memory
region that the TDMR covers, plus the information to track (within this
TDMR):
  a) the "Physical Address Metadata Table" (PAMT) to track each TDX
     memory page's status (such as which TDX guest "owns" a given page,
     and
  b) the "reserved areas" to tell memory holes that cannot be used as
     TDX memory.

The kernel needs to get below metadata from the TDX module to build the
list of TDMRs:
  a) the maximum number of supported TDMRs
  b) the maximum number of supported reserved areas per TDMR and,
  c) the PAMT entry size for each TDX-supported page size.

== Implementation ==

The TDX module has two modes of fetching the metadata: a one field at
a time, or all in one blob.  Use the field at a time for now.  It is
slower, but there just are not enough fields now to justify the
complexity of extra unpacking.

The err_free_tdxmem=>out_put_tdxmem goto looks wonky by itself.  But
it is the first of a bunch of error handling that will get stuck at
its site.

[ dhansen: clean up changelog and add a struct to map between
	   the TDX module fields and 'struct tdx_tdmr_sysinfo' ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-8-dave.hansen%40intel.com
---
 arch/x86/include/asm/shared/tdx.h |  1 +-
 arch/x86/virt/vmx/tdx/tdx.c       | 88 +++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h       | 39 +++++++++++++-
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index a403614..fdfd415 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -59,6 +59,7 @@
 #define TDX_PS_4K	0
 #define TDX_PS_2M	1
 #define TDX_PS_1G	2
+#define TDX_PS_NR	(TDX_PS_1G + 1)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 6a3585b..e76ad7c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -237,8 +237,85 @@ err:
 	return ret;
 }
 
+static int read_sys_metadata_field(u64 field_id, u64 *data)
+{
+	struct tdx_module_args args = {};
+	int ret;
+
+	/*
+	 * TDH.SYS.RD -- reads one global metadata field
+	 *  - RDX (in): the field to read
+	 *  - R8 (out): the field data
+	 */
+	args.rdx = field_id;
+	ret = seamcall_prerr_ret(TDH_SYS_RD, &args);
+	if (ret)
+		return ret;
+
+	*data = args.r8;
+
+	return 0;
+}
+
+static int read_sys_metadata_field16(u64 field_id,
+				     int offset,
+				     struct tdx_tdmr_sysinfo *ts)
+{
+	u16 *ts_member = ((void *)ts) + offset;
+	u64 tmp;
+	int ret;
+
+	if (WARN_ON_ONCE(MD_FIELD_ID_ELE_SIZE_CODE(field_id) !=
+			MD_FIELD_ID_ELE_SIZE_16BIT))
+		return -EINVAL;
+
+	ret = read_sys_metadata_field(field_id, &tmp);
+	if (ret)
+		return ret;
+
+	*ts_member = tmp;
+
+	return 0;
+}
+
+struct field_mapping {
+	u64 field_id;
+	int offset;
+};
+
+#define TD_SYSINFO_MAP(_field_id, _offset) \
+	{ .field_id = MD_FIELD_ID_##_field_id,	   \
+	  .offset   = offsetof(struct tdx_tdmr_sysinfo, _offset) }
+
+/* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
+static const struct field_mapping fields[] = {
+	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
+	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
+	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
+	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
+	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
+};
+
+static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+{
+	int ret;
+	int i;
+
+	/* Populate 'tdmr_sysinfo' fields using the mapping structure above: */
+	for (i = 0; i < ARRAY_SIZE(fields); i++) {
+		ret = read_sys_metadata_field16(fields[i].field_id,
+						fields[i].offset,
+						tdmr_sysinfo);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int init_tdx_module(void)
 {
+	struct tdx_tdmr_sysinfo tdmr_sysinfo;
 	int ret;
 
 	/*
@@ -257,10 +334,13 @@ static int init_tdx_module(void)
 	if (ret)
 		goto out_put_tdxmem;
 
+	ret = get_tdx_tdmr_sysinfo(&tdmr_sysinfo);
+	if (ret)
+		goto err_free_tdxmem;
+
 	/*
 	 * TODO:
 	 *
-	 *  - Get TDX module "TD Memory Region" (TDMR) global metadata.
 	 *  - Construct a list of TDMRs to cover all TDX-usable memory
 	 *    regions.
 	 *  - Configure the TDMRs and the global KeyID to the TDX module.
@@ -270,6 +350,8 @@ static int init_tdx_module(void)
 	 *  Return error before all steps are done.
 	 */
 	ret = -EINVAL;
+	if (ret)
+		goto err_free_tdxmem;
 out_put_tdxmem:
 	/*
 	 * @tdx_memlist is written here and read at memory hotplug time.
@@ -277,6 +359,10 @@ out_put_tdxmem:
 	 */
 	put_online_mems();
 	return ret;
+
+err_free_tdxmem:
+	free_tdx_memlist(&tdx_memlist);
+	goto out_put_tdxmem;
 }
 
 static int __tdx_enable(void)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index c11e0a7..29cdf5e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,6 +2,8 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
+#include <linux/bits.h>
+
 /*
  * This file contains both macros and data structures defined by the TDX
  * architecture and Linux defined software data structures and functions.
@@ -13,9 +15,39 @@
  * TDX module SEAMCALL leaf functions
  */
 #define TDH_SYS_INIT		33
+#define TDH_SYS_RD		34
 #define TDH_SYS_LP_INIT		35
 
 /*
+ * Global scope metadata field ID.
+ *
+ * See Table "Global Scope Metadata", TDX module 1.5 ABI spec.
+ */
+#define MD_FIELD_ID_MAX_TDMRS			0x9100000100000008ULL
+#define MD_FIELD_ID_MAX_RESERVED_PER_TDMR	0x9100000100000009ULL
+#define MD_FIELD_ID_PAMT_4K_ENTRY_SIZE		0x9100000100000010ULL
+#define MD_FIELD_ID_PAMT_2M_ENTRY_SIZE		0x9100000100000011ULL
+#define MD_FIELD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
+
+/*
+ * Sub-field definition of metadata field ID.
+ *
+ * See Table "MD_FIELD_ID (Metadata Field Identifier / Sequence Header)
+ * Definition", TDX module 1.5 ABI spec.
+ *
+ *  - Bit 33:32: ELEMENT_SIZE_CODE -- size of a single element of metadata
+ *
+ *	0: 8 bits
+ *	1: 16 bits
+ *	2: 32 bits
+ *	3: 64 bits
+ */
+#define MD_FIELD_ID_ELE_SIZE_CODE(_field_id)	\
+		(((_field_id) & GENMASK_ULL(33, 32)) >> 32)
+
+#define MD_FIELD_ID_ELE_SIZE_16BIT	1
+
+/*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
  */
@@ -33,4 +65,11 @@ struct tdx_memblock {
 	unsigned long end_pfn;
 };
 
+/* "TDMR info" part of "Global Scope Metadata" for constructing TDMRs */
+struct tdx_tdmr_sysinfo {
+	u16 max_tdmrs;
+	u16 max_reserved_per_tdmr;
+	u16 pamt_entry_size[TDX_PS_NR];
+};
+
 #endif
