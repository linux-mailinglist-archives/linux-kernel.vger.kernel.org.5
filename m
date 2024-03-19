Return-Path: <linux-kernel+bounces-107820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1BB880219
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729051F233F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1383CA2;
	Tue, 19 Mar 2024 16:17:01 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453783A0E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865021; cv=none; b=kMS7Y+l5R0TNSDZQ3qO5DXjCWmXNNHUJiQQE4oYKAWrT0oiTX9Hu0gm6auhzigAMLpD8T9np0eShEsX+Z2tAHVNZ53r2GGbGYff01+vdLFGSTli0hKptwdF7UBEzkgFgMqnFECYoOpkMtqcTWQw4mEoRUT4GuK1yYBeCsyhJ+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865021; c=relaxed/simple;
	bh=YMQ8U69QsWfZvDlD8KiOq8prLPpCkh50zePjz2CKXO4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIoV5unOjqh89zFFQ9+7+6AO1bPWEYy9QhsmT9TZWRbi60iRt9ZIYvWyGIoAG2EMQui4wRO4vcfGJLulvekSO5OK4kGU4hPpaRHs9VkBlLFNXlm6QVVPYmHBc8dsYz9aPUDOavMo1Fch0l9xjSnyXkkk9OBTRsW8XE+YLz39SE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TzcKr6RmDz1HBj3;
	Wed, 20 Mar 2024 00:16:32 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 5324D18001A;
	Wed, 20 Mar 2024 00:16:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 20 Mar
 2024 00:16:54 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>
CC: <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
Subject: [RFC PATCH 0/5] ubifs: Support POSIX Access Control Lists (ACLs)
Date: Wed, 20 Mar 2024 00:16:41 +0800
Message-ID: <20240319161646.2153867-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

This patchset is base on [1] and [2], adding implementation of ACLs for
ubifs.

Implement ACLs features based on POSIX to solve some difficulties that
require fine-grained access control. At the same time, it is also to
facilitate cross-file system migration.

In order to simplify the implementation, only v2 version POSIX ACLs are
implemented, eliminating the need for in-memory and on-flash format
conversion. And no need to implement security xattr handler in ubifs.

Some testcases have been tested and passed:
  * generic testcases (modified version) for acl group in xfstest[3], they are generic/026/053/077/099/105/237/307/318/319/375/389/444/449/529/697.
  * tacl_xattr.sh (modified version) in LTP[4].

[1]: https://lore.kernel.org/linux-mtd/1441962597-13543-1-git-send-email-shengyong1@huawei.com/
[2]: https://lore.kernel.org/linux-mtd/1476046382-19185-1-git-send-email-pascal.eberhard@gmail.com/
[3]: https://kernel.googlesource.com/pub/scm/fs/xfs/xfstests-dev/+/refs/heads/master/tests/generic/
[4]: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/acl/tacl_xattr.sh

Li Zetao (5):
  ubifs: Implement POSIX Access Control Lists (ACLs)
  ubifs: Initialize or update ACLs for inode
  ubifs: Support accessing ACLs through inode_operations
  ubifs: Introduce ACLs mount options
  ubifs: Add ACLs config option

 fs/ubifs/Kconfig  |  14 +++++
 fs/ubifs/Makefile |   1 +
 fs/ubifs/acl.c    | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/dir.c    |  18 ++++++
 fs/ubifs/file.c   |   6 ++
 fs/ubifs/super.c  |  40 +++++++++++++
 fs/ubifs/ubifs.h  |  15 +++++
 fs/ubifs/xattr.c  |   1 -
 8 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 fs/ubifs/acl.c

-- 
2.34.1


