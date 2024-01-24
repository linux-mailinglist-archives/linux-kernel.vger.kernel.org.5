Return-Path: <linux-kernel+bounces-37005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDF83AA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C692853A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7C677639;
	Wed, 24 Jan 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JiEjYfOq"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675717543
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100206; cv=fail; b=GwiXFNoBKLxXJ5fH+9eOSrgY+Whe9ZQEFPk9762Sgo0nH8AJhWJZlbxWqqQQC4S8azDcr8+75Dt1OPwXhqeyt6pgB65oUOgs/yWVnThuw9otZqEu5royNrGNc6UnfocTLEqpHJkbx637HNqv2nmWpsSUzpEIhHqDB/0CPNOeydc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100206; c=relaxed/simple;
	bh=KGmEmOvdmqy9i92i/TNYFQI/3P8b3CE9wyArfmvLmvE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ctNK9vNyu3kHLTXYMefmrjzDPtFKStpQE+R6M4Wr+JvkuOVgF9XUreGOZuc+ii74yNp/o59piOtrsKB3dwL74/+GWkF6R5+V2BY2O2jam2GXUIarQZw4i4gHv7OSsM5kmWRSUlbXnUBjigfISKPCo8Zz3lvfDYGzF+kXp45Mqx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JiEjYfOq; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqUTJxLwjLI5O7DLUMzrw3I7q8Z0LNWFmHfXx79GD2Stg+JAzeVNiugrbvR5GTjoRmKgNjQ22/+wdgeaWfW6+SVH+Q3YZx2UY9zO8UB3kS4lZVi2Rztbjd+ro0C1K2RTzCmLVtF124Db9WB5gJUZvO1hVmJ8hxHG3ER4OX142EOx/eL4LNM4hq7wlIjeMJTiyfTfhJtoAg4KV72mOck4gqGm3z7eBB0xA67CKnfXBwdNKhsRkfKzpnRsxyxrbNzVtz4+xX74K0BkLiMm9BvoY6QfyJ8z1MH7PCSXN5kRrKsRSkHX12fUnDvvGxMJVjXUdKUI6o+P6W5oNFp2UqIC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4txKrtP0kZcCa/oe7j+wbX42JzdlRtRJtMtzfCObxM=;
 b=lilngLgXwxtr4DGngct2R8nKH/N3NYJQJYn+SgJ/pV7DA7Dnrwu6rcGH0sQZJhfwlmaFquUl1lFZFMQuyXMKXzdPSKV7xXu/F+QHgRHdBaU3iIXZZ5WYxd26v5mAmIde/1P6L/5anNPjo+lM9ErTUeMFJ3Pb12VnwfAbMVrv7baOawvV2t0vtyw+ToYxLZ+kujlML5i+KSqQkXdkS1jTviat1duKOSZ6qdizAj6T3n/SvgHOaDx456u4cfkToyT/0bmlr7lj8xnC6M7IpvqCHUEOD/2QEI2LTkhuR+ifLH+8guW00qf+a1fPaGbgB53bQ7DXwLNlCtQ0FfJTOFWIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4txKrtP0kZcCa/oe7j+wbX42JzdlRtRJtMtzfCObxM=;
 b=JiEjYfOqx8WrUavSE5EDLKHaDKbb1Sc0DgyJsbpkiySw/3gj81BeNyzB+ddCZHmeYjAJNQvaNKqKMQaUh7TFOWApkQNDBK5W5NG4goNe6Q2rK4lM4ISH8x18rTuDoZsL8uRKTzE7LORzAxo+aXMZ6xvZ6vgudQtMoJ40N8A9jud9BrTkyDgdw0X87crjLr55dQ4L07CtvdGEU38Y14sU9IWbdo1W0ZfrYtYUrPrwIk6XIcsxuOAVndaM5q9jwWW/5WlVcnvxlyZgE3Tcfw3eGqLurRqiUjOj19OkmxdawjGuRbl6LoZf+fju7A5SNQe6kUFuXvd+mTKCVDkhgB5WVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB7030.apcprd06.prod.outlook.com (2603:1096:990:6d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 12:43:20 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 12:43:20 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm:vmscan: shrink skip folios in the exiting task
Date: Wed, 24 Jan 2024 20:43:07 +0800
Message-ID: <20240124124308.461-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a842d0-506c-4538-7733-08dc1cda0b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fKyihKWcJtA5zHPHEPVoOtFqoFMTolpSNgFXtj/xds5tLPLZXT9O0EZ6xeD0gaz4b06azlRHCVrukW7y22GBTDIjEBZWE78wkOzMNDPfNububJ0Pzvpkeni+Qsb/clg+S+4h64HBpA35dZ+GXm/Gnpo6OKMeOywk4ckanOJxcM6KFt2KxVjXdawJ9WZG7uWIuaECRLu7xJLZ6YMARrJcHnbZtGnCL1NcPpZdv9eAbP9puP461Q8fnq4BpEzzL3PxXrjWLhBv+jMYVvC3bZNZTZl9JgBA5XVgoq1T+2Nsw6tYdAO0IviDJsj7rwQb8jlhQ4lPWNYBt/AalyzvBngswr98cqwPbP7z0mEo91NyMT6qY73OjCW4/i99wYtOPOHFZAsAZc6l/SufN4cJW05f3N5AP/ukp+C7KvhKDhkJMiERWECjnpYbrO8F1NGn8ihDK1sUQHWpOW44zld9+h4c7WAROxTzV+obLZDmMLyY17jAbRrIZ16hrha03w7HqUSGZqxN9+BmOFNod0FToUIaveuwlPFyuyII2LeJWuF2NhkEfce4lCtM1t5sgMxb8Z4YjooU7D0ZYBFeqvyRf/i5OX9JSiSsIjWwlYA8dsqkfcu5FaAZLwjHzIQDyLb3ko9v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(316002)(66946007)(66556008)(66476007)(6512007)(52116002)(26005)(107886003)(2616005)(478600001)(6486002)(38350700005)(6666004)(1076003)(38100700002)(6506007)(4326008)(8676002)(5660300002)(8936002)(86362001)(2906002)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/1NsiH6TviywoIjCrjG8bw8IJT4tg0nJo5aobGr1j7nganx9hmNH6ft3tGd?=
 =?us-ascii?Q?zVcBvgk363NXTS0qWoP3JUd8gaC+5pj2K4Go86Fw8NSaqeZWXlBosTGlGhb3?=
 =?us-ascii?Q?AwEgj7+xapu/3caA0RoFJXJbiVSrMy06s9JJGlewCiQ0nnNiy8GHe+SwURpn?=
 =?us-ascii?Q?+5skwDGjJGBTB1hJSinc/AA9ACDmGLZ5I74XIJ/Lb3zZV40wBVj1yNmhp3XU?=
 =?us-ascii?Q?UrVJSYQGPgn6k8XxqQGAISHYTkQ0rWyh2XSimJqAeVHb0xbBZ+q7mQZ4QZAg?=
 =?us-ascii?Q?o2ATQa7kG7IE6n967BM2yTTtALjGfBh3uQwR6fWKvaShHs2J6Q6bW3iDn2cQ?=
 =?us-ascii?Q?/3LZgYYmhIsPCN3FnNI5AWuhJlWwC/kRNRWFJeq0z7M5+v6BhlH0FwVyyOpG?=
 =?us-ascii?Q?1of/RF+rXCkdkAkuQsfY9awpkdubOREga17UGvlCX3/V1MQtNUSaWVsrxWV+?=
 =?us-ascii?Q?DR9P1XKk66o+OuxsVkvxoHeC7+kIBS1vQIx5WADim9kHopDzF1NjdPtIz/FY?=
 =?us-ascii?Q?bh7o5c0qianXhgOlZgBVhMD/oGDWJgvCCo5JTSjYlPkpJNVbSPcq8ELSVMjY?=
 =?us-ascii?Q?0P0ibuviDB/QeGuyGTq1L9X3D7ohpwksgdX2iqrcfyeQlvdtKZW5K4wHxNpT?=
 =?us-ascii?Q?W/tegbSJjUVSiiRih5dGQH+19ZxmQrczC7lYHarTevi8Sj35BiRqwJe+VGEW?=
 =?us-ascii?Q?A5MmbhI/aCMGHP2DI+H+6bHeS+XEiCMTQSP4kaJC2R5l6mGd+PwIP+e2bsl9?=
 =?us-ascii?Q?exFaUfeEhfsF4D5sQYGMgMqGL+BQNtP1aa1r08JtIXg1jK5sWOgnN437t+bv?=
 =?us-ascii?Q?Eie5FtpiZHwnZ13MKIEOTxKS1FCJ+dxeTpyRrsc18FVG8pjxUktPGG8twnST?=
 =?us-ascii?Q?ItKc6PJPvg4KujZArKjRZRvsMOmQYY8GyGb9tpfBJ6acMyVspaOlE+Miqep5?=
 =?us-ascii?Q?VnfidF+/SV9L/NYYROxkv3UgpWV0Aas5W+izmpyKDApVaoszuYlyJwxGW79W?=
 =?us-ascii?Q?pMbKIgVcN9WGuhsV8FHRERufCfPgpr71F3/FFK+x5nUNaxe0O321EerEKALm?=
 =?us-ascii?Q?YAZ88jO62y9i6m5c25GP88lz7SBJ8GDlMHiX+qqeDpppgGnBPVr5PlE+uyhG?=
 =?us-ascii?Q?ptuJrdPpyhlCD4p5qygGC06fBzbvqrafCIdI8o//wcd5+EBxNP+02DEgj37U?=
 =?us-ascii?Q?rcxo5vt6g7zfGa1AMXbSq9Mqs66X3Bk+w2p9ZS6iyCozRYAdVzS0UZGQXOY/?=
 =?us-ascii?Q?UN+sOt03O21vG2EY5MpdMHB5o9iPC584qwJlQt+l+KA6ehvtHHV7Ff+ypIGW?=
 =?us-ascii?Q?t1h3vMbL6hpFzMHZK9L3QD9VT/GaAJiWw185LAdg6VzwPqX9OqtkcYAOzTQm?=
 =?us-ascii?Q?OKxqhg9dqvok+0ZiqBXvxbPbt+eOiuw6JInazy6LA+0CDJsk5H2WHCdBVbUC?=
 =?us-ascii?Q?FzjJXAeT+Q34NyP5L9Wf0inQeBHLGDn5Umv8fqNZpMSwfFfdqevAdWoXr88y?=
 =?us-ascii?Q?ToUw75JVgOH+mvpw1RMzcCliBDwfwFn+hgRiwIsTEQ8SfW9MXiqPgS3F2U+I?=
 =?us-ascii?Q?XxLZn59q+vj6JJkRMAlcq+Ktt7NwvW3n141vc/sW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a842d0-506c-4538-7733-08dc1cda0b74
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 12:43:20.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVzCSIJQ9qRWfPR40yaqP9eUTv/GklZU3g4ud8qYeAauq5pwuBzvP1k/IxswsNFlYLA5artqTZaGupGYsRRvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7030

If the shrinking folio is belong to the exiting task, this folio should
be freed in the task exit flow rather than being reclaimed in the shrink
flow, because the former takes less time.

If the folio which is belong to the exiting task is reclaimed in the
shrink flow, such as the anon folio, the anon folio needs to be first
written to the swap partition by swap-in in shrink flow, and then the
corresponding swap folio needs to be released in the task exiting flow.
As is well known, releasing a swap folio will task more time than 
releasing directly an anon folio.

In the scenarios of the low memory system and mutil backed-applications,
the time-consuming problem caused by shrinking the exiting task's folios
will be more severe.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 include/linux/mm.h |  1 +
 mm/rmap.c          | 12 ++++++++++++
 mm/vmscan.c        |  4 ++++
 3 files changed, 17 insertions(+)
 mode change 100644 => 100755 include/linux/mm.h
 mode change 100644 => 100755 mm/rmap.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 42652bc8ceca..67e84b7d1928
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -312,6 +312,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
 #define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
+#define VM_EXITING	0x100000000  /* The task which this vma belongs to is exiting */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
diff --git a/mm/rmap.c b/mm/rmap.c
index 1cf2bffa48ed..deb419fd095b
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -943,6 +943,18 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
 	if (memcg && !mm_match_cgroup(vma->vm_mm, memcg))
 		return true;
 
+	/*
+	 * Skip counting references of the folios in the exiting task, and
+	 * these folios will be freeed in the task exit flow rather than being
+	 * reclaimed in shrink flow, which is shorter time consumption.
+	 */
+	if (likely(vma->vm_mm) &&
+		unlikely(!atomic_read(&vma->vm_mm->mm_users) ||
+		test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
+		pra->vm_flags |= VM_EXITING;
+		return true;
+	}
+
 	return false;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b3ed3c9c3e3d..40ea4128044c 100755
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -887,6 +887,10 @@ static enum folio_references folio_check_references(struct folio *folio,
 		return FOLIOREF_KEEP;
 	}
 
+	/* The folio belongs to the exiting task: rotate */
+	if (vm_flags & VM_EXITING)
+		return FOLIOREF_KEEP;
+
 	/* Reclaim if clean, defer dirty folios to writeback */
 	if (referenced_folio && folio_is_file_lru(folio))
 		return FOLIOREF_RECLAIM_CLEAN;
-- 
2.39.0


