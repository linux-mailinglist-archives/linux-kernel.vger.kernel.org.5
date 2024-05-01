Return-Path: <linux-kernel+bounces-165413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C928B8C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACA61C20A90
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93D812F58A;
	Wed,  1 May 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CZhMs9Jj"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2049.outbound.protection.outlook.com [40.92.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863414012;
	Wed,  1 May 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575792; cv=fail; b=CjVKijBTY0lJELBPSYYkvkhJAMtYghpe4Esbk14XIiHgjZCvWoVl6m0fL1UthIUft0U1zP3A2fdltAK70MHto0yEiFPKE8fsdBBLZj1na6r1ExRtrzVERDNB5PpZK/RAnhWu6sUlAyZAUlMxAUZllCZkvvruuTy9CHrJLmP5L1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575792; c=relaxed/simple;
	bh=eVXzdoMcT+TqaoVvW3d4nVdGFEiqhR7p6zj7CoeSZnU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YLBgElVXMETJBSXPqfhZkhEP5Hl4rlnzdpPRnhdCYfx5DnhskW/g05Vjok8awTnmHy1QQAVytoNKANofTauvm9XMA97sUYbvyjJU4PsV8gEwMN3Hf6g743qP1qGddTFP+rN+K95MPFK5zYC2KQzo6LS6RhEBf0gNkKJh3PRwB7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CZhMs9Jj; arc=fail smtp.client-ip=40.92.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H946XqrOSWkmqrRcHQrc5Yx4VE4w46pECfQsuPTXlf6+4ENJJk4/DmhJKE7vo4sueOJ6atLQO6zvcOBJ7/3+GwlTdwO+3yAuRzyJ/+20AntFiWyaCsKjLG/GyyllkqH2Y6eImqfHr8s/ex8ipailaG9biapQ0FDcpCiN9jE7xvFAy6sChs0wSadRgxGGolYG3ZBJt56kWTF+3So+cj/Coacd/6/xNchFeTVNbZ3n5YrD96DPJQ/7uZZt8duI2uFFLb35tWeLTYiiBUMvEFWnzr5QsOja6NkMTkwZWTVWECz1IJAn9e52rtTDjL2hPQrIjq7BDyuNNiwaAa9Y6nwKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQnpgDZbgfR03GHCw1uuEcglzZ0kuvsUMlWln8jcunU=;
 b=jFMPICxp62oMiD9hXS5vH3Y7By14DLV/8oMBXRDSUC1QHDT6SpKM5MT4Qj4YQjbvUlKxhqdzyo1oSB5duPCAay6bWTFZ6zAeIxpmc471lCp0nCmHlZjr6VkekxfTZwQTwse2z7ovltOhVbZz92eQZqojVMHYH1/0TL0fSSRxJzYPtcgI5HhfrlNcVOpykDcWN0e5ZHMrs7n/E+pMMPhI8qIboOFUgnCNhe6bSPCAmtxeNWUJh4xjecUsTiBZLtG2k25tGi6aX3h3V5fFheYZ5JuUx2Kzqrr+53ADoeoNU5nlpDDy4U6TP/7vCkH7moo99XwgQGIyOXe/7dC1LJMrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQnpgDZbgfR03GHCw1uuEcglzZ0kuvsUMlWln8jcunU=;
 b=CZhMs9JjzfHx4ufVWE+4RFCmfryYxQmMkJzgltfNwWKvIUOy6vzi+/5gFYDbMLfwENsdvnAi+g3GE/6ml0kZfrhM0EhVszmFaNaFFO4ft3b3FOEmHiES//WKkKsWACwiIcRJhf7PA2mtuyEASLO2l1kWXpkEZ8vBPiDOjrftQ47HSIl6b66LfI6C+e9VjLQItsvZ+ZH7TEnQgOTES9MG1lYIuLIZK0s+i9AH16T2ctX1XTdwmXvDrOYLLRtyq/JDMjxs3x/0EGPzIVgpkVya9gTFYKqarhq3AFjE/PNh8VdnaOz1YUkkXgEs1Jt+hI1MOxOforSsSiOe5mb24JufxA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5801.eurprd02.prod.outlook.com (2603:10a6:10:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 15:03:06 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 15:03:06 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Wed,  1 May 2024 17:02:42 +0200
Message-ID:
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [mQzIvD4x4eK5gb4bGWB6c6X6fYFrffUG]
X-ClientProxiedBy: MA4P292CA0001.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::20) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240501150242.16159-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: b31d4515-5949-45aa-0c3e-08dc69efce84
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	qFAcOOK4bRThDdtlyobiamSTHLyW+FLuC30yakUSw9HdhgvQvirTtPtfDrlGWNGSLYR83kL1lHrVluIvkXdbrYqT88HGCA7LTgP55GEcotFIYF44kOkCRLwnlGUv6O1RADAUCpFo7tesXPJcvdpW+bB4/UDo3s05puEF6Y51rB76HF2uD1aqKSlcJk25c21e1snHCVOvGCe0BUiCtipb6YAIA7AWymhj+rKYLariXuaGNBSiejn/WWniDc0GaIu8H5NE7oCX5Y5vwOO1we2BQtrZkDHmazPSQBYMLuQLbAhcIu5KE7S0lfRJZFnJq3RL1WkSMq2P1xhu7uyGdy9ok+Nbfa8oGaCupmGxjPrNMGZwFktMC2SuPe+pGB4y2YOSgThTXS2GKudTDy0+y+xaYfZQX+H91kaatWe7V3nM4CWdP2vStG+4shQaIwpjrqNTqjpg7J5MhmtsKgJtsiiMbZwnkriGTWfseEuqRixwVOf5vJKM4TDvqxEOiPY+obf0L1/i7C5r7PVdmY2lloOaqzkOoDDcPerYJpEZvehqaIJOns8oj9oQUXOpX624yh8vos9tRKMXuxV+CmklObdka2wSiBci2glXi1B9IQ59bDGUI2qmzhGKEfEEJFnQPYLYBD5YhsV6ElPsjVYgVBgcM4sdKLkvdHGvsVPVzw8zwOHk7RMjNKW8V7yMSIOT78gT8rtxq4JDbVwoCq/uriF3cQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1HX5x6Tm2g7aOt0oAVbxlxn7WTlXGMcPHE4uR4a42YFIVtgg7shT+GMWRBr9?=
 =?us-ascii?Q?Q5uYw4uh6mKqBBjHApjcs/pJvg5HT1pLMPffeefJc0NlywEXgS8LGkdht+qk?=
 =?us-ascii?Q?CRavqeBizdPPLLg7MowUwcZr3OogNiGhShPU/960tKNdchpKKxDRPXson2Eh?=
 =?us-ascii?Q?eHbTdCjMPqKPEIIqhZuChpFWtSjEdZQgXPJcK3zZiNovuRBz0Ohs1vCxA7ge?=
 =?us-ascii?Q?AhKako/bm3mFWos5wW3WD0WGa6+mG+1Q2Z7zY2GbuIkttf1qUwx8rcB0179B?=
 =?us-ascii?Q?v6llwX9LaRa/DCCudnLCwL6D7D3hYxIVA553maF/zgokgXqJLcFjjeNeCEhu?=
 =?us-ascii?Q?KJrEOt0nzTRFvYb50yUoIxy2BPGjepf85EXLei7nrenJBhetOt+Zox1+Z0zl?=
 =?us-ascii?Q?TDXtcMsYFshZYk+zXA/J/U7wshoDFI51i66FquBWHeEqvEh+ynZixDvA5hIj?=
 =?us-ascii?Q?ah4td+f1DO1t2VxqS6GqobgppqcuR5nXcrU78/dwcGP4A5vKTnhRHA4CU2w5?=
 =?us-ascii?Q?v7RX7dPFHsTfJcv1aQQclvNLt8Ka/egaSrurY6bP/2NAoV4w8NGTo34ifUnV?=
 =?us-ascii?Q?5VamI1Kc+vrptoM1FTYPQiT4YBhxspqVxFRrRJwJM8kvfz/DIZc3VplGIjeq?=
 =?us-ascii?Q?Bk4MpXHU0C+ac8cSIXz4/ZXMdaQBVSuryO0dB8pjduPn9tbKaHAdR330tHL4?=
 =?us-ascii?Q?byDBv7tVoKkM2NchBujy/wPu+cmVgZBrT4EgJ+aE2sxAGsesSwNlbTr072Pw?=
 =?us-ascii?Q?nU0y4MdPtsK7D/9IoD2rJT5nzl0Pl+iaQXeXLwB6ueh0lmKrZE3pTEtSduJD?=
 =?us-ascii?Q?JZ6VHINihZdYv8pPSyUFgEOwdLZuTEzeMiA2BG1MRm4R88Cd7UZlWXfXhRBw?=
 =?us-ascii?Q?S/2BNzqaDf1GM4fOdmA1ZjDtFziLxsOiCS9EeRLcr7NiOjahn5I83M1ojXs5?=
 =?us-ascii?Q?uVZkb4m8GNtrRWhMga3iIqKOLTNAFLRdZtsIIF0oIWaKl4Ywo/uwysj0vbtG?=
 =?us-ascii?Q?j8eMqVoqoX7I++etBYc0kgG5UVHWvm8YFZUDFWDasgobEJiVMi5iLzpWJ5M/?=
 =?us-ascii?Q?1p2d2QHA2dVQqY+IeFvwSuq1Bn+1gpIShlyT4KLv/9IXQfrH9k56vm6ysu5T?=
 =?us-ascii?Q?zlkAR9rf24yLXf5/AsyMOER2GU4Da2eFYomvp6N9rIoMHynLHA8t7yOk7/qR?=
 =?us-ascii?Q?QJUp2FvWjGMaGW8w/xgXUJDxcOchnhfOVy0S4yqE4leUp6KsRielSP5G5aAl?=
 =?us-ascii?Q?Eaq2h8yegGUjocLL5Wlz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31d4515-5949-45aa-0c3e-08dc69efce84
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 15:03:06.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5801

The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
trailing elements. Specifically, it uses an array of structures of type
"batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
declaring a flexible array [1].

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions). In this case, it is important to note
that the attribute used is specifically __counted_by_be since variable
"num_vlan" is of type __be16.

The following change to the "batadv_tt_tvlv_ogm_handler_v1" function:

-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);

+	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+						     + flex_size);

is intended to prevent the compiler from generating an "out-of-bounds"
notification due to the __counted_by attribute. The compiler can do a
pointer calculation using the vlan_data flexible array memory, or in
other words, this may be calculated as an array offset, since it is the
same as:

        &tt_data->vlan_data[num_vlan]

Therefore, we go past the end of the array. In other "multiple trailing
flexible array" situations, this has been solved by addressing from the
base pointer, since the compiler either knows the full allocation size
or it knows nothing about it (this case, since it came from a "void *"
function argument).

The order in which the structure batadv_tvlv_tt_data and the structure
batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
type error.

Also, avoid the open-coded arithmetic in memory allocator functions [2]
using the "struct_size" macro and use the "flex_array_size" helper to
clarify some calculations, when possible.

Moreover, the new structure member also allow us to avoid the open-coded
arithmetic on pointers in some situations. Take advantage of this.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Add the #include of <linux/overflow.h> for the "flex_array_size"
  helper (Sven Eckelmann).
- Add the "ntohs" function to the "flex_array_size" helper removed
  by mistake during the conversion (Sven Eckelmann).
- Add the "__counted_by_be" attribute.

Changes in v3:
- Address from the base pointer tt_data to avoid an "out-of-bounds"
  notification (Kees Cook).
- Update the commit message to explain the new change.

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com/
v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com/

Hi,

The Coccinelle script used to detect this code pattern is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1) + sizeof(t2) * i1;
..
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Regards,
Erick
---
 include/uapi/linux/batadv_packet.h | 28 +++++++++--------
 net/batman-adv/translation-table.c | 49 ++++++++++++------------------
 2 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 6e25753015df..dfbe30536995 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -592,19 +592,6 @@ struct batadv_tvlv_gateway_data {
 	__be32 bandwidth_up;
 };
 
-/**
- * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
- * @flags: translation table flags (see batadv_tt_data_flags)
- * @ttvn: translation table version number
- * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
- *  one batadv_tvlv_tt_vlan_data object per announced vlan
- */
-struct batadv_tvlv_tt_data {
-	__u8   flags;
-	__u8   ttvn;
-	__be16 num_vlan;
-};
-
 /**
  * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated through
  *  the tt tvlv container
@@ -618,6 +605,21 @@ struct batadv_tvlv_tt_vlan_data {
 	__u16  reserved;
 };
 
+/**
+ * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
+ * @flags: translation table flags (see batadv_tt_data_flags)
+ * @ttvn: translation table version number
+ * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
+ *  one batadv_tvlv_tt_vlan_data object per announced vlan
+ * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
+ */
+struct batadv_tvlv_tt_data {
+	__u8   flags;
+	__u8   ttvn;
+	__be16 num_vlan;
+	struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
+};
+
 /**
  * struct batadv_tvlv_tt_change - translation table diff data
  * @flags: status indicators concerning the non-mesh client (see
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b21ff3c36b07..b44c382226a1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -28,6 +28,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/overflow.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
@@ -815,8 +816,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 		num_entries += atomic_read(&vlan->tt.num_entries);
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -835,7 +835,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		tt_vlan->vid = htons(vlan->vid);
 		tt_vlan->crc = htonl(vlan->tt.crc);
@@ -895,8 +895,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		total_entries += vlan_entries;
 	}
 
-	change_offset = sizeof(**tt_data);
-	change_offset += num_vlan * sizeof(*tt_vlan);
+	change_offset = struct_size(*tt_data, vlan_data, num_vlan);
 
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
@@ -915,7 +914,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->ttvn = atomic_read(&bat_priv->tt.vn);
 	(*tt_data)->num_vlan = htons(num_vlan);
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	tt_vlan = (*tt_data)->vlan_data;
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -2875,7 +2874,6 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_tt_req_node *tt_req_node = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan_req;
 	struct batadv_hard_iface *primary_if;
 	bool ret = false;
 	int i, size;
@@ -2891,7 +2889,7 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!tt_req_node)
 		goto out;
 
-	size = sizeof(*tvlv_tt_data) + sizeof(*tt_vlan_req) * num_vlan;
+	size = struct_size(tvlv_tt_data, vlan_data, num_vlan);
 	tvlv_tt_data = kzalloc(size, GFP_ATOMIC);
 	if (!tvlv_tt_data)
 		goto out;
@@ -2903,12 +2901,10 @@ static bool batadv_send_tt_request(struct batadv_priv *bat_priv,
 	/* send all the CRCs within the request. This is needed by intermediate
 	 * nodes to ensure they have the correct table before replying
 	 */
-	tt_vlan_req = (struct batadv_tvlv_tt_vlan_data *)(tvlv_tt_data + 1);
 	for (i = 0; i < num_vlan; i++) {
-		tt_vlan_req->vid = tt_vlan->vid;
-		tt_vlan_req->crc = tt_vlan->crc;
+		tvlv_tt_data->vlan_data[i].vid = tt_vlan->vid;
+		tvlv_tt_data->vlan_data[i].crc = tt_vlan->crc;
 
-		tt_vlan_req++;
 		tt_vlan++;
 	}
 
@@ -2960,7 +2956,6 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *res_dst_orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool ret = false, full_table;
 	u8 orig_ttvn, req_ttvn;
 	u16 tvlv_len;
@@ -2983,10 +2978,9 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	orig_ttvn = (u8)atomic_read(&req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
 	/* this node doesn't have the requested data */
 	if (orig_ttvn != req_ttvn ||
-	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_vlan,
+	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_data->vlan_data,
 					ntohs(tt_data->num_vlan)))
 		goto out;
 
@@ -3329,7 +3323,6 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	u8 *tvlv_ptr = (u8 *)tt_data;
-	u16 change_offset;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
@@ -3342,10 +3335,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(&orig_node->tt_lock);
 
-	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
-	change_offset *= ntohs(tt_data->num_vlan);
-	change_offset += sizeof(*tt_data);
-	tvlv_ptr += change_offset;
+	tvlv_ptr += struct_size(tt_data, vlan_data, ntohs(tt_data->num_vlan));
 
 	tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 	if (tt_data->flags & BATADV_TT_FULL_TABLE) {
@@ -3944,10 +3934,10 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  u8 flags, void *tvlv_value,
 					  u16 tvlv_value_len)
 {
-	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
+	size_t flex_size;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -3957,17 +3947,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
+	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < flex_size)
 		return;
 
-	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
-	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
+						     + flex_size);
+	tvlv_value_len -= flex_size;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-	batadv_tt_update_orig(bat_priv, orig, tt_vlan, num_vlan, tt_change,
-			      num_entries, tt_data->ttvn);
+	batadv_tt_update_orig(bat_priv, orig, tt_data->vlan_data, num_vlan,
+			      tt_change, num_entries, tt_data->ttvn);
 }
 
 /**
@@ -3998,8 +3989,8 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	tt_data = tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
-	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
-	tt_vlan_len *= ntohs(tt_data->num_vlan);
+	tt_vlan_len = flex_array_size(tt_data, vlan_data,
+				      ntohs(tt_data->num_vlan));
 
 	if (tvlv_value_len < tt_vlan_len)
 		return NET_RX_SUCCESS;
-- 
2.25.1


