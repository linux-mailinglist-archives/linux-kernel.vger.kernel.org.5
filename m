Return-Path: <linux-kernel+bounces-5463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8176B818AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD041F22242
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980E224CB;
	Tue, 19 Dec 2023 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ef3yLxo5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984920DCB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9x1RS031609;
	Tue, 19 Dec 2023 15:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=V6IUUm4WYnN5Ho5RFmogccesju20LkZ9tUpYKLChUyY=;
 b=Ef3yLxo5QP4Ya1/lLmCDz3Ry0Hko9IMIWHe/G7wlVnqeB5eWZZGeze2OLVQrdPmoU10Q
 5Kzmf9L0R/0ZSAaH5foQ0uT3Pq+Jp3rmGdLZ0kseh6AaYAItGjjTUqn2GnAreRqE0iMi
 TFb233Sq3g+1PZmZAnqLdLbXg5GuxI+XEk/elOPPRSJXVC1x5KNdbYAHOojNiamXnE8w
 4DJNYqrRKSKz5OCXa/tytvK0KnpEt76QGg/q/qc2nihHP6PjFJLVb5YvT04aPbGbhDYJ
 qrFh9sE94bN+Ts4m1gFQEUyJXqHltU/x84v5uRzd17wl2zCoGC/pMRPtE1tqy9EPsLlr vQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13gue417-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJE9F5K029212;
	Tue, 19 Dec 2023 15:12:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6w791-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJF7SdN008899;
	Tue, 19 Dec 2023 15:12:11 GMT
Received: from localhost.localdomain (dhcp-10-175-58-169.vpn.oracle.com [10.175.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b6w71u-2;
	Tue, 19 Dec 2023 15:12:11 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 1/5] x86: provide new infrastructure for GDT descriptors
Date: Tue, 19 Dec 2023 16:11:56 +0100
Message-Id: <20231219151200.2878271-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219151200.2878271-1-vegard.nossum@oracle.com>
References: <20231219151200.2878271-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190113
X-Proofpoint-ORIG-GUID: 9R0Z_daTIlJ9l5KVFqEgRmnzkj4sdOB3
X-Proofpoint-GUID: 9R0Z_daTIlJ9l5KVFqEgRmnzkj4sdOB3

Linus suggested replacing the magic numbers in the GDT descriptors
using preprocessor macros. Designing the interface properly is actually
pretty hard -- there are several constraints:

- you want the final expressions to be readable at a glance; something
  like GDT_ENTRY_FLAGS(5, 1, 0, 1, 0, 1, 1, 0) isn't because you need
  to visit the definition to understand what each parameter represents
  and then match up parameters in the user and the definition (which is
  hard when there are so many of them)

- you want the final expressions to be fairly short/information-dense;
  something like GDT_ENTRY_PRESENT | GDT_ENTRY_DATA_WRITABLE |
  GDT_ENTRY_SYSTEM | GDT_ENTRY_DB | GDT_ENTRY_GRANULARITY_4K is a bit
  too verbose to write out every time and is actually hard to read as
  well because of all the repetition

- you may want to assume defaults for some things (e.g. entries are
  DPL-0 a.k.a. kernel segments by default) and allow the user to
  override the default -- but this works best if you can OR in the
  override; if you want DPL-3 by default and override with DPL-0 you
  would need to start masking off bits instead of OR-ing them in and
  that just becomes harder to read

- you may want to parameterize some things (e.g. CODE vs. DATA or
  KERNEL vs. USER) since both values are used and you don't really
  want prefer either one by default -- or DPL, which is always some
  value that is always specified

This patch tries to balance these requirements and has two layers of
definitions -- low-level and high-level:

- the low-level defines are the mapping between human-readable names
  and the actual bit numbers

- the high-level defines are the mapping from high-level intent to
  combinations of low-level flags, representing roughly a tuple
  (data/code/tss, 64/32/16-bits) plus an override for DPL-3 (= USER),
  since that's relatively rare but still very important to mark
  properly for those segments.

- we have *_BIOS variants for 32-bit code and data segments that don't
  have the G flag set and give the limit in terms of bytes instead of
  pages

Link: https://lore.kernel.org/all/CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com/
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/x86/include/asm/desc_defs.h | 66 ++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index f7e7099af595..b33f5bb240eb 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -8,6 +8,56 @@
  * archs.
  */
 
+/*
+ * Low-level interface mapping flags/field names to bits
+ */
+
+/* Flags for _DESC_S (non-system) descriptors */
+#define _DESC_ACCESSED		0x0001
+#define _DESC_DATA_WRITABLE	0x0002
+#define _DESC_CODE_READABLE	0x0002
+#define _DESC_DATA_EXPAND_DOWN	0x0004
+#define _DESC_CODE_CONFORMING	0x0004
+#define _DESC_CODE_EXECUTABLE	0x0008
+
+/* Common flags */
+#define _DESC_S			0x0010
+#define _DESC_DPL(dpl)		((dpl) << 5)
+#define _DESC_PRESENT		0x0080
+
+#define _DESC_LONG_CODE		0x2000
+#define _DESC_DB		0x4000
+#define _DESC_GRANULARITY_4K	0x8000
+
+/* System descriptors have a numeric "type" field instead of flags */
+#define _DESC_SYSTEM(code)	(code)
+
+/*
+ * High-level interface mapping intended usage to low-level combinations
+ * of flags
+ */
+
+#define _DESC_DATA		(_DESC_S | _DESC_PRESENT | \
+				 _DESC_DATA_WRITABLE)
+#define _DESC_CODE		(_DESC_S | _DESC_PRESENT | \
+				 _DESC_CODE_READABLE | _DESC_CODE_EXECUTABLE)
+
+#define DESC_DATA16		(_DESC_DATA)
+#define DESC_CODE16		(_DESC_CODE)
+
+#define DESC_DATA32		(_DESC_DATA | _DESC_GRANULARITY_4K | _DESC_DB)
+#define DESC_DATA32_BIOS	(_DESC_DATA | _DESC_DB)
+
+#define DESC_CODE32		(_DESC_CODE | _DESC_GRANULARITY_4K | _DESC_DB)
+#define DESC_CODE32_BIOS	(_DESC_CODE | _DESC_DB)
+
+#define DESC_TSS32		(_DESC_SYSTEM(9) | _DESC_PRESENT)
+
+#define DESC_DATA64		(_DESC_DATA | _DESC_GRANULARITY_4K | _DESC_DB)
+#define DESC_CODE64		(_DESC_CODE | _DESC_GRANULARITY_4K | _DESC_LONG_CODE)
+
+#define DESC_USER		(_DESC_DPL(3))
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -27,14 +77,14 @@ struct desc_struct {
 		.base0		= (u16) (base),			\
 		.base1		= ((base) >> 16) & 0xFF,	\
 		.base2		= ((base) >> 24) & 0xFF,	\
-		.type		= (flags & 0x0f),		\
-		.s		= (flags >> 4) & 0x01,		\
-		.dpl		= (flags >> 5) & 0x03,		\
-		.p		= (flags >> 7) & 0x01,		\
-		.avl		= (flags >> 12) & 0x01,		\
-		.l		= (flags >> 13) & 0x01,		\
-		.d		= (flags >> 14) & 0x01,		\
-		.g		= (flags >> 15) & 0x01,		\
+		.type		= ((flags) & 0x0f),		\
+		.s		= ((flags) >> 4) & 0x01,	\
+		.dpl		= ((flags) >> 5) & 0x03,	\
+		.p		= ((flags) >> 7) & 0x01,	\
+		.avl		= ((flags) >> 12) & 0x01,	\
+		.l		= ((flags) >> 13) & 0x01,	\
+		.d		= ((flags) >> 14) & 0x01,	\
+		.g		= ((flags) >> 15) & 0x01,	\
 	}
 
 enum {
-- 
2.34.1


