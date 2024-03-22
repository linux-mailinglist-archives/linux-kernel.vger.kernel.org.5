Return-Path: <linux-kernel+bounces-111721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC02886FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27631F214E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB09256B8F;
	Fri, 22 Mar 2024 15:48:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F5F53E22;
	Fri, 22 Mar 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122506; cv=none; b=cg/I3QCTDEPWljStwfkCKCh/+ZdCrJQKhYBXNGqSG3CSdHuPyUWQBGIbx9HgmsJTQ8WZ3E4UJDq8pYWgA2BEp1IdrtBl39bQMB5yTNNKwkTfn8gSDz8vAvOAWUL+DlBNCC31rmCVBs19U25HLsx+t4qHNMOIGms0OGB8mOuWe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122506; c=relaxed/simple;
	bh=PcH5O9HaXNQY4ldJrDzDDEHScOC3/WH3B6Sy6SM+he4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iqKINQ72BQkTk4CjE/cygTR/XkTnxhr2X7Sh6ZIlNPUmdkK1xzAqA/6wTChiq8HVl5qdTQ+FlObvjNgUMf76Hvc2EwOUQK1FLo5vS0ahPHYP9KR7Bwq7eHjUjWO4PyfN2WAXxuOKbrfxpVgsr3Z4A7eQpADmu+KMVOFEDEJ2XNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1RWh0CDWz1xsCK;
	Fri, 22 Mar 2024 23:46:24 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 420001A0172;
	Fri, 22 Mar 2024 23:48:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 23:48:18 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>, <corbet@lwn.net>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <lizetao1@huawei.com>, <linux-mtd@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 0/5] ubifs: Support POSIX Access Control Lists (ACLs)
Date: Fri, 22 Mar 2024 23:48:07 +0800
Message-ID: <20240322154812.215369-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Changelog:
v1 -> v2:
  * Adjust patch order.
  * Modify ubifs_xattr_remove to an external function to remove the
  * xattr of ACL.
  * Fix handling of updating file mode via ACL.

v1: https://lore.kernel.org/all/20240319161646.2153867-1-lizetao1@huawei.com/


Li Zetao (5):
  ubifs: Add ACLs config option
  ubifs: Implement POSIX Access Control Lists (ACLs)
  ubifs: Initialize or update ACLs for inode
  ubifs: Support accessing ACLs through inode_operations
  ubifs: Introduce ACLs mount options

 Documentation/filesystems/ubifs.rst |   4 +
 fs/ubifs/Kconfig                    |  14 ++
 fs/ubifs/Makefile                   |   1 +
 fs/ubifs/acl.c                      | 192 ++++++++++++++++++++++++++++
 fs/ubifs/dir.c                      |  22 ++++
 fs/ubifs/file.c                     |   6 +
 fs/ubifs/super.c                    |  41 ++++++
 fs/ubifs/ubifs.h                    |  16 +++
 fs/ubifs/xattr.c                    |   3 +-
 9 files changed, 297 insertions(+), 2 deletions(-)
 create mode 100644 fs/ubifs/acl.c

-- 
2.34.1


