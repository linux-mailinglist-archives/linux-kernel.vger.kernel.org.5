Return-Path: <linux-kernel+bounces-111719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E77886FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E6E1C2187A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F354FB0;
	Fri, 22 Mar 2024 15:48:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2153811;
	Fri, 22 Mar 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122505; cv=none; b=mBPyuyIPvFYCdYv6iNA6bL2kUMwMFfi+O/XFFPyRz8yEh1TL6RtOR8DNFwhNRKi7xLkZlF7mCNL8lAOq4ZMMWSvj3v2+uyrEd7oSMINSPAI+DsDTvYF9abA5aSfDPb0Ca8jAkHLZAWZAMiv2JAO5hEI9o8dk0JFBWXL+FOMOxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122505; c=relaxed/simple;
	bh=XHECZqNFfXYbkWZS+VFqR2nCwONd95UHFkfpDhF+1u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qckDquzAbhQmX1MLywpwAnFc8+XuhAGZCHW+g1Q4u125IddKDm9zRc03gL/uYYAFry+5G0X0dCAlNsBpmhkkfhmSYupIqBR0YfbaIRTKaTZYBa5ZRB5atPQYt67D63E2MalsOQtbHSZPEL522kBsEX8/XNCldt+qPgxjF8nf4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1RWh3GpJz1xsQg;
	Fri, 22 Mar 2024 23:46:24 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id AC31B1A0188;
	Fri, 22 Mar 2024 23:48:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 23:48:19 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>, <corbet@lwn.net>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <lizetao1@huawei.com>, <linux-mtd@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/5] ubifs: Add ACLs config option
Date: Fri, 22 Mar 2024 23:48:08 +0800
Message-ID: <20240322154812.215369-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322154812.215369-1-lizetao1@huawei.com>
References: <20240322154812.215369-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Add CONFIG_UBIFS_FS_POSIX_ACL to select ACL for UBIFS, but it should
be noted that this config option depends on UBIFS_FS_XATTR.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Put this patch first.
v1: https://lore.kernel.org/all/20240319161646.2153867-6-lizetao1@huawei.com/

 fs/ubifs/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 45d3d207fb99..9ac5ddd5ded3 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -98,4 +98,18 @@ config UBIFS_FS_AUTHENTICATION
 	  sha256, these are not selected automatically since there are many
 	  different options.
 
+config UBIFS_FS_POSIX_ACL
+	bool "UBIFS POSIX Access Control Lists"
+	depends on UBIFS_FS_XATTR
+	select FS_POSIX_ACL
+	default y
+	help
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the Posix ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N
+
 endif # UBIFS_FS
-- 
2.34.1


