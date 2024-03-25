Return-Path: <linux-kernel+bounces-116526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7936488A3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65E9B3721C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD874E21;
	Mon, 25 Mar 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GyoJx6SM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F713E3F8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341982; cv=fail; b=gCE6WbHIQpMkMrxYZEnIo6kR9FlkUWvScU3YLaG6p2cY/46473RwQND5pHLvDqL2l/v8vgLJCpkR9g0QHfjWmBhznvVCJ92dzJPSHGWfqzlwOE46pEtSdKkaGYja1VCqAGLg2YuYeYYulkPv7zPverPKCzu+28XMH6CY5Zpp/pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341982; c=relaxed/simple;
	bh=GXslnCKQCeO34MMjieXCR3Gzae9Qg0ELjKO8z1bWW20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ihhAFnjvr0qV8FgvxxqEwIidIGqYOaJJ0ByBfybXLYuadBzF3APAB1O8Jr8B6f2Y+su8y4SQUETT3XiKObEzgju3FLFffkoaemd6Tte9sovD7ItIyxRm/ZUae0coXcgfyfGHv8A988mfGRHHgag9rNdSWn+yegKEoKib91nIEI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GyoJx6SM; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7gAiaCg7RcNLOfLU9bhRJXdfLS6RlQDNxz8zJNlg+GWMhEUmjVRpPBnz1574PRlECL9MiUsKtprpVhmw+QEbRrkEOCIurgFhfVVorUtRbdSSeMGsTaLcjvajUte9/FGKYljVr2xZOPdZJ5KS40tt2vHjEiYOy+VqujSl0k6P7Kqf0YvSOM7PKExbdtMBlalrY0SvKCoBEtvPAMITHz6IkuKH8lQ521UqNyXbS7AccwIuo+LmiRsbOb6AXeQJpRaObCQ+gXj/SFiG2bTY3rrMGnyErbt22ZO1f9bRL5TNlYvfWLuiwL2stVc8cGszYvpW5JY5vMkgWeW1U+BwCA0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRM2c46Ff75/AqLwVQefBUyqOXAt4HFlfpfmBETDQeE=;
 b=GP2rjJHF1+ywUZpWhSnTLeUUQa39ARMqmbLcwHkBF8e0SKQlaGuIFHKm7xPRcv4qTKVeQ0/uDLwvyVuiCP53xnYM9bEApme+io4OpXNiTSySI91J9e2BeuXfgYslJStDiXzrPCbxZexmADllFBwR9aYgHxYzfJgXBTT59+YmIixj4jRCQnc1nYPB2Xrr/tX/5IdSpqSwp/gFOM2GCw5a8C2aCACboS4x5KJhxN1/pcoLkrwnBeYafBYhe3yU8WcWrkHy77nAUIOmvP2iD3GXCXPtz+b+lS/p/KSpqVED+DDEvrXBdZp5ttpjURLX3al6PrxubqeNqpvloYcdtizu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRM2c46Ff75/AqLwVQefBUyqOXAt4HFlfpfmBETDQeE=;
 b=GyoJx6SMM8wNt7ReudpUnny0ottmC5W3AYRjJ2rKxmhq5qLF45ls8PaTcTo6BcZ851l54XRsA4gvW3l1q7/5//ZmKM0y+9mq+0ShjVrHs2tZyKn0C1PvSWYDFDrAQAU1KpxQgUCtm1y4uEyoLv3l6uSQAbWHLjmkwejlU+/0B8QvlRsAO2MILxpZdVm0vmFmexVYn0EpQL1SuwK/lQH+0QRiEKOQxb3Jpz452RPLcwCdkOskuH8YigPhUtADhNPXDnU54ovRtpWahAtSx1waAmPLYpN5JLgPubmuRes3MbW2EUTtgozP3Kd65zVdO2YyIUyp4AkRX53uD6DEvCTUaA==
Received: from BL0PR0102CA0002.prod.exchangelabs.com (2603:10b6:207:18::15) by
 PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 04:46:15 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::57) by BL0PR0102CA0002.outlook.office365.com
 (2603:10b6:207:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 04:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 04:46:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 24 Mar
 2024 21:46:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 24 Mar 2024 21:46:06 -0700
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 24 Mar 2024 21:46:05 -0700
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, John Hubbard
	<jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH] huge_memory.c: document huge page splitting rules more thoroughly
Date: Sun, 24 Mar 2024 21:44:52 -0700
Message-ID: <20240325044452.217463-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: e98b56d4-88f6-4a37-572e-08dc4c8680c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KQ+EPSIA+rZpqJLLKITlx6fhGDctAb9Cdmy8NpBS6luIMNMfykwTlGe/hpUB9e3iwEXvJtv9xchlVYsHf05Qx99fFMwECfX3pVwhS1aiFDreCa/z9NCGVRwQaJDXdgOO3dapnbK8Kgh8BM3w5rwofsHREDek4neGKO3wO100UmKzxytjYDYTsKjEWnx+gaj1/kUTadZoBYASjj8tZwDXWSb2TglAQ+tG1mkic9b6RDIx19oPv4atl9a5/NmbpE0Xv4AaSbAEUkIw/2w64N4RZyqnZ7EqEsTLY3E3wWaCVdVfZFhvBNNKfk/ffxvsIqw67ggPtBgEhbzQI0bsegv+XnZk86h+uFNIbq6VggEu/STN97hujAA3mzc5V07JZZvD2tY120Fn+w43jQ94gbBYLV5CO7VO1na8sFgMdXnXZkI1o1UGWcoEAxLPRxNlw2KgzYXF/ZWdgrLgOMo/otUIFHg1ZgOmBl2yxh7NcWOfr7GYaf/LDrq6lRWiDzgsJS5qswkErsQ1tmU4WYMdZAwqAPuWjp2J2BLSJ7b33ODnO3vidi90LmfE/cWhKAcsB5gNghO47H2w5GN2KHpMdHWq5Y1Y1NO/Vzo/+WpE/1qu6kWNyxipOCJoX5KoCIkPm9ipInZTR9xgwhor+4AANDB/Im0zh65AXXRgKXQ5CyPtd0Se9PUTt3UDFf4n41hhy13HJeiMvljwgMURj7xmw/bfnQ3hxEI0Fu8o8yBshTwG+btzOflaswjfiadKpNIXkWGo
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 04:46:14.7310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98b56d4-88f6-4a37-572e-08dc4c8680c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

1. Add information about the behavior of huge page splitting, with
   respect to page/folio refcounts, and gup/pup pins.

2. Update and clarify the existing documentation, to compensate for the
   ravages of time and code change.

Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi David, Matthew, Zi,

This is a follow up from our short email thread of a week ago [1].

Zi, I've inflicted some minor violence upon your original wording, and
moved it into a Prerequisites section (item 4).


[1] https://lore.kernel.org/all/d9c06bec-805f-4d53-9f91-6b8ad29fcb6b@redhat.com/

thanks,
John Hubbard
NVIDIA

 mm/huge_memory.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..9f2354068359 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3013,28 +3013,40 @@ bool can_split_folio(struct folio *folio, int *pextra_pins)
 }
 
 /*
- * This function splits huge page into pages in @new_order. @page can point to
- * any subpage of huge page to split. Split doesn't change the position of
- * @page.
+ * This function splits a large folio into smaller folios of order @new_order.
+ * @page can point to any page of the large folio to split. The split operation
+ * does not change the position of @page.
  *
- * NOTE: order-1 anonymous folio is not supported because _deferred_list,
- * which is used by partially mapped folios, is stored in subpage 2 and an
- * order-1 folio only has subpage 0 and 1. File-backed order-1 folios are OK,
- * since they do not use _deferred_list.
+ * Prerequisites:
  *
- * Only caller must hold pin on the @page, otherwise split fails with -EBUSY.
- * The huge page must be locked.
+ * 1) The caller must hold a reference on the @page's owning folio, also known
+ *    as the large folio.
+ *
+ * 2) The large folio must be locked.
+ *
+ * 3) The folio must not be pinned. Any unexpected folio references, including
+ *    GUP pins, will result in the folio not getting split; instead, the caller
+ *    will receive an -EBUSY.
+ *
+ * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
+ *    supported for non-file-backed folios, because folio->_deferred_list, which
+ *    is used by partially mapped folios, is stored in subpage 2, but an order-1
+ *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
+ *    since they do not use _deferred_list.
+ *
+ * After splitting, the caller's folio reference will be transferred to @page,
+ * resulting in a raised refcount of @page after this call. The other pages may
+ * be freed if they are not mapped.
  *
  * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
  *
- * Pages in new_order will inherit mapping, flags, and so on from the hugepage.
+ * Pages in @new_order will inherit the mapping, flags, and so on from the
+ * huge page.
  *
- * GUP pin and PG_locked transferred to @page or the compound page @page belongs
- * to. Rest subpages can be freed if they are not mapped.
+ * Returns 0 if the huge page was split successfully.
  *
- * Returns 0 if the hugepage is split successfully.
- * Returns -EBUSY if the page is pinned or if anon_vma disappeared from under
- * us.
+ * Returns -EBUSY if @page's folio is pinned, or if the anon_vma disappeared
+ * from under us.
  */
 int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 				     unsigned int new_order)
-- 
2.44.0


