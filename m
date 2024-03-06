Return-Path: <linux-kernel+bounces-93760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DED873439
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F931C21562
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90071604CF;
	Wed,  6 Mar 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="i7oIz5Ow"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB35FDBD;
	Wed,  6 Mar 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720964; cv=none; b=iiksO6Vd1QM00nVNyTWEUBcIR0se5tl/Hbcq1xo4TpDGSC/+IYX/f7UqJ2XtIm//3yNOphF/QMTgNCknXOF4fMVeOpGmhUZG02D8Fj2kuAzPTBSZWBHuz4gTyjpnjMUjBNoyhspWOyphn+dAR9FPiyx054jjmnSy8fQsYvZ+vgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720964; c=relaxed/simple;
	bh=XdN3aG00u/QsuyGD6b2X8W2/qtDpU1h/uB9UBsmVuQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xbkq6fbB8Zf5IpvlZCu+DqBQxKsIvU26AYdgwq/OeXp272AKkdph34EIr/ZKQP6jmPHXvLHwCHiW0jjRTqEKv4wwlPTFNTDkmALbv7zxaF7DpJDjkB+kmZG24YdOVblTk4TLXmhopAj0aRoknqEPWQBhokx7zO1d0vHAaGCMC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=i7oIz5Ow; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720963; x=1741256963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XdN3aG00u/QsuyGD6b2X8W2/qtDpU1h/uB9UBsmVuQc=;
  b=i7oIz5OwHcZcjmSc67Vln7VqltmBwUy9CDi9vzDDyeQKzAVZQpnHo4q5
   Fel2EmdL2U5G4tLpuJQDXV73NqoUd+gfgXq9GwvEqTNbJYrTGBSGHh3DB
   7JmM1Tf8cQsEnj0f1IoZyGbBDB3BkJLv+0NbGhZWO3BvvwNZ0ZRV7ifHy
   TX43EA1E0OrZEOav8olPtPSDv5qQyWS1uGwnFOV9Al7ltVjMoFYQEpN8U
   3iB96TmrZtp3hBausy/DonrcQPhbO1I6XyOAHY3yWvwZK+8DKyqiG/1Fh
   5a4boo8S4tQgRYLabbiLcudJSozgNX75vZJcOnWNLdFuQ4CwLs+ZBdmlk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="151260035"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="151260035"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:14 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B1867A345D;
	Wed,  6 Mar 2024 19:29:11 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E2DABD5603;
	Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 66630401D3;
	Wed,  6 Mar 2024 19:29:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 782981A006D;
	Wed,  6 Mar 2024 18:29:09 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 5/7] resource: Introduce walk device_backed_vmemmap res() helper
Date: Wed,  6 Mar 2024 18:28:44 +0800
Message-Id: <20240306102846.1020868-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--2.753200-10.000000
X-TMASE-MatchedRID: VGeBglENKylzKOD0ULzeCRFbgtHjUWLyPeYVUCg2LRwBLwIiWDU8ay15
	IFUNL+ETjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRcFEiuPxHjsXDCscXmnDN79P7VmP7Drr66us
	OKvlQZawRYCju0yIRX4Ay6p60ZV62Mhe627A+8aHdB/CxWTRRu+rAZ8KTspSzZ9zg/iRwE4LkAQ
	bstzNuLM5Iu+GqAiaI4D/GW2/5ILcxeNB9x03X8fQFNK0GDkNxsoGRy2pyHXLNTBw2qqp0+A7H6
	7Vl1o7oIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

It walks resources registered with flags
(IORESOURCE_DEVICE_BACKED_VMEMMAP | IORESOURCE_BUSY), usually used by
device backed vmemmap region. currently, it only sticks to the
persistent memory type since it is only one user.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Baoquan He <bhe@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Alison Schofield <alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 3b59e924f531..10a60227d6c2 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -332,6 +332,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_device_backed_vmemmap_res(u64 start, u64 end, void *arg,
+			       int (*func)(struct resource *, void *));
+extern int
 walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			int (*func)(struct resource *, void *));
 extern int
diff --git a/kernel/resource.c b/kernel/resource.c
index fcbca39dbc45..5f484266af07 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -431,6 +431,19 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				     func);
 }
 
+/*
+ * This function calls the @func callback against all memory ranges, which
+ * are ranges marked as (IORESOURCE_DEVICE_BACKED_VMEMMAP | IORESOURCE_BUSY)
+ * and IORES_DESC_PERSISTENT_MEMORY.
+ */
+int walk_device_backed_vmemmap_res(u64 start, u64 end, void *arg,
+			int (*func)(struct resource *, void *))
+{
+	return __walk_iomem_res_desc(start, end,
+			IORESOURCE_DEVICE_BACKED_VMEMMAP | IORESOURCE_BUSY,
+			IORES_DESC_PERSISTENT_MEMORY, arg, func);
+}
+
 /*
  * This function, being a variant of walk_system_ram_res(), calls the @func
  * callback against all memory ranges of type System RAM which are marked as
-- 
2.29.2


