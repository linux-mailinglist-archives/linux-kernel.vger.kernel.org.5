Return-Path: <linux-kernel+bounces-118281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F333188B73A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ED62A83BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE565A110;
	Tue, 26 Mar 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lzw0SOWH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED94E1A2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419437; cv=none; b=k3rzAoQAmNXbAjaKnF1+mism4nXyMYEJlUfOLs5lNqyj5S/EniaaRh8TEFS5KEfRx3m719CO2TxKnnhp6geNT4NSU4hJiJ/sIem6uWqtpp7fYke1kJcROxz3/cmDxXYdLCqfQcen1WRibl2FMKIvlXSU4Vm+eZo9v24jIi0kD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419437; c=relaxed/simple;
	bh=C3HKCFW/8Pu4EQqUdufuRIZx47fZhhZskIiwq7U/w8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQgDLVX1DK3KmyOX7HQdzoqGOlv2eER1qqTOv6mODTDRTF2iMAivaF2Te4kIhuQiTXaT1WwtiprtPvHiArKTMnaSGxjKFeZJXq8pPqeBsy/JdtV1NxB8IuUAblozJWkKvddKvjohlWQYz8uX2Jhjo9kmSR5CnZBqLaCGcexYXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lzw0SOWH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419436; x=1742955436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C3HKCFW/8Pu4EQqUdufuRIZx47fZhhZskIiwq7U/w8E=;
  b=Lzw0SOWHPNiaX558/E/Fv/meWpEiMiI4vWXV1oPMJi7s7+J1HrkdG084
   jm5UUmaYHhhCt/P9E2PIlLGzeADwYC8snAlSnM05IgaDHTroinMlyfoUz
   IGj0g/GUDEbWw0N+K5b3BG/S2seaCDPuDZwfaPpYH6XxAB0nPoJU6XI6f
   Ui8/kBvOBNqK9e+s2i7oEMXEmpE3ARAIawl5kSLQK3F/GiVj6C7YjbdmX
   b6L8YC7eSYZRjzp2jFNyb9vvEEFOdydKz9ITwVmCGkR0ZlFdhLp1gp4Kr
   fY94pivLXghVS8HLOiGLzWlWnezpAgQ/mnmSOgtOnQFn0HNT1QuTlJn3K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564205"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564205"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489864"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:14 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 01/14] proc: Refactor pde_get_unmapped_area as prep
Date: Mon, 25 Mar 2024 19:16:43 -0700
Message-Id: <20240326021656.202649-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
References: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will perform a treewide change to remove the indirect
branch that is involved in calling mm->get_unmapped_area(). After doing
this, the function will no longer be able to be handled as a function
pointer. To make the treewide change diff cleaner and easier to review,
refactor pde_get_unmapped_area() such that mm->get_unmapped_area() is
called without being stored in a local function pointer. With this in
refactoring, follow on changes will be able to simply replace the call
site with a future function that calls it directly.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - New patch split from "mm: Switch mm->get_unmapped_area() to a flag"
   (Christophe Leroy)
---
 fs/proc/inode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index dcd513dccf55..75396a24fd8c 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -451,15 +451,12 @@ pde_get_unmapped_area(struct proc_dir_entry *pde, struct file *file, unsigned lo
 			   unsigned long len, unsigned long pgoff,
 			   unsigned long flags)
 {
-	typeof_member(struct proc_ops, proc_get_unmapped_area) get_area;
+	if (pde->proc_ops->proc_get_unmapped_area)
+		return pde->proc_ops->proc_get_unmapped_area(file, orig_addr, len, pgoff, flags);
 
-	get_area = pde->proc_ops->proc_get_unmapped_area;
 #ifdef CONFIG_MMU
-	if (!get_area)
-		get_area = current->mm->get_unmapped_area;
+	return current->mm->get_unmapped_area(file, orig_addr, len, pgoff, flags);
 #endif
-	if (get_area)
-		return get_area(file, orig_addr, len, pgoff, flags);
 	return orig_addr;
 }
 
-- 
2.34.1


