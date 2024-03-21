Return-Path: <linux-kernel+bounces-110443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E0885F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E5AB2708E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4084142635;
	Thu, 21 Mar 2024 16:52:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB2B142621
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039975; cv=none; b=Gn/p4kHmXlBU+tfdeq+zEXMn7a+bk9higeRga/X2K9Ks1tu7045IfxjAKJogqVm09Q9nspy8kWgOwIDlDmlx2mKDvttHZ3tZmTWE1nxHLfjppzTFGDXGyKxEx/0nXTiasLuKSN1pd2FbRwJfIgQvcIYLAzldEnN4n15iE+PtufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039975; c=relaxed/simple;
	bh=vE8ObtSbNXXuQbtQiG9u6MeSrab/F7HqkgTUdTMXcBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbsXkv46qpnBuhSC5pCnDjTD/NwPTlM8OLJLWlQ0CLonFUCtNfgak1IPqn0ihx1rUgNjB28ESFJjzJ4tA8iz/icHhBIXAMh3qieNNHLbOU2t77VQGSmrAvCuh9EsfdcecTaKkYSaIQEB7hlLpyZ7cXN604kIFzfPLG/MuzbPOFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18508168F;
	Thu, 21 Mar 2024 09:53:28 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEF593F67D;
	Thu, 21 Mar 2024 09:52:50 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 26/31] x86/resctrl: Describe resctrl's bitmap size assumptions
Date: Thu, 21 Mar 2024 16:51:01 +0000
Message-Id: <20240321165106.31602-27-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl operates on configuration bitmaps and a bitmap of allocated
CLOSID, both are stored in a u32.

MPAM supports configuration/portion bitmaps and PARTIDs larger
than will fit in a u32.

Add some preprocessor values that make it clear why MPAM clamps
some of these values. This will make it easier to find code related
to these values if this resctrl behaviour ever changes.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/resctrl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 84420253dc05..f463fb949677 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -26,6 +26,17 @@ int proc_resctrl_show(struct seq_file *m,
 /* max value for struct rdt_domain's mbps_val */
 #define MBA_MAX_MBPS   U32_MAX
 
+/*
+ * Resctrl uses a u32 as a closid bitmap. The maximum closid is 32.
+ */
+#define RESCTRL_MAX_CLOSID		32
+
+/*
+ * Resctrl uses u32 to hold the user-space config. The maximum bitmap size is
+ * 32.
+ */
+#define RESCTRL_MAX_CBM			32
+
 /**
  * struct pseudo_lock_region - pseudo-lock region information
  * @s:			Resctrl schema for the resource to which this
-- 
2.39.2


