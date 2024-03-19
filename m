Return-Path: <linux-kernel+bounces-107823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06988021C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2E91C22FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0E83CC5;
	Tue, 19 Mar 2024 16:17:02 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CAA83A12
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865022; cv=none; b=ecTlcKbVafLpwNHcahkKCENAQmjSt7SCjb2AnsHl1jAGwzIwtfqo3bQ39dTEQ9vjh7DZoDqG1GgLk3VYupNBdjLf3ciEILmJnPI4z+6Se2/SoO4lCItPQ6aKiAw3saU0TOFjGE1OCii01eSupyLj3/IbcStna98Lgq9KmPSD/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865022; c=relaxed/simple;
	bh=kHPe25315jm6MEoKSd8sEDMfbyuoVewOhJ62IUt1SqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENvckGz0wnA0Tu8WzRD2k0x1U4ROiVOATRYuvVd8PiLbqdJqcWQuOzLCYxu7YAsQRSubt0e1kn8nWRy1wzM2a3v5yjWb7roBZXAYxCkGV2tiGMOWW6dHRAGjPALetjaeznfpKJZ2LVxcGbxArJRvVEjirms7mXddNxszjw81i4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TzcHM57mDz1R7QS;
	Wed, 20 Mar 2024 00:14:23 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id C42E71400CA;
	Wed, 20 Mar 2024 00:16:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 20 Mar
 2024 00:16:56 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>
CC: <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
Subject: [RFC PATCH 5/5] ubifs: Add ACLs config option
Date: Wed, 20 Mar 2024 00:16:46 +0800
Message-ID: <20240319161646.2153867-6-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319161646.2153867-1-lizetao1@huawei.com>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Add CONFIG_UBIFS_FS_POSIX_ACL to select ACL for UBIFS, but it should
be noted that this config option depends on UBIFS_FS_XATTR.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ubifs/Kconfig  | 14 ++++++++++++++
 fs/ubifs/Makefile |  1 +
 2 files changed, 15 insertions(+)

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
diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 314c80b24a76..1e0733a647d5 100644
--- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -9,3 +9,4 @@ ubifs-y += misc.o sysfs.o
 ubifs-$(CONFIG_FS_ENCRYPTION) += crypto.o
 ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
 ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
+ubifs-$(CONFIG_UBIFS_FS_POSIX_ACL) += acl.o
\ No newline at end of file
-- 
2.34.1


