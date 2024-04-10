Return-Path: <linux-kernel+bounces-138093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C6989EC97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3D01C210BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B913D52D;
	Wed, 10 Apr 2024 07:46:27 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E713D277
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735187; cv=none; b=eMyMTIPBOZOTshF8mKYiP60B1RS8QFOOOWGNSeDp0vhjeC9EEQDFZrDn3dxgImbITlWcMXE/q7EExhkOC2cPcKJ+BoYpEcaxEhNfv1GQFUz3gXXkiz73AgVSj2DOFI5fN5uEoeowCRG183RmJtLaaXWLkDDkMIVV6ZtNDYdxglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735187; c=relaxed/simple;
	bh=d9Ej8ntCDFOjoGPqr+Pgq3K+CtVkLVX3NE5guWyHk6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LKPXmnE0c0naBNowvaW8EQ25vIt2ZB+rt0PJA7RPNZA5FgZGM13Au2XuQ/QOCmf65Cc58/5no11u/b7/66cz/7486cAnRLT3VTzkgY+HSmf/iiyOj1/pL9hE6jpSHAbg9gPg6xg0ZD3bcUoGawSTK8h0pVcQ43cKWLVH3qXwlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VDvxv3t04z21kf6;
	Wed, 10 Apr 2024 15:45:23 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E21D718001A;
	Wed, 10 Apr 2024 15:46:18 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:46:18 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
Subject: [PATCH 0/9] ubifs: Fix a serious of inconsistent problems when powercut happens
Date: Wed, 10 Apr 2024 15:37:42 +0800
Message-ID: <20240410073751.2522830-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

UBIFS is tolerant of powercut, this patchset fix some inconsistent
problems when powercut happens.
Xfstests,mtd-utils and powercut tests[1] are passed(Enable chk* debugging)
after this patchset applied.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218309

performance regression:

4GB nandsim 256KB PEB 4KB page

1. fio

direct=0
bs=4k
sync=0
iodepth=128
rw=write
iodepth_batch_complete=1
iodepth_batch=1
numjobs=1
directory=/root/temp
size=1G
runtime=20s
time_based=1
                         before     after
1 thread seq write      412MiB/s   409MiB/s
1 thread random write   402MiB/s   397MiB/s
4 thread seq write      163MiB/s   164MiB/s
4 thread random write   162MiB/s   160MiB/s

2. fsmark
fs_mark -d /root/temp -s 10240 -n 1000
      before               after
   7131 Files/sec       7090 Files/sec


Zhihao Cheng (9):
  ubifs: Fix unattached xattr inode if powercut happens after deleting
  ubifs: Don't add xattr inode into orphan area
  Revert "ubifs: ubifs_symlink: Fix memleak of inode->i_link in error
    path"
  ubifs: Remove insert_dead_orphan from replaying orphan process
  ubifs: Fix adding orphan entry twice for the same inode
  ubifs: Move ui->data initialization after initializing security
  ubifs: Fix space leak when powercut happens in linking tmpfile
  ubifs: Fix unattached inode when powercut happens in creating
  ubifs: dbg_orphan_check: Fix missed key type checking

 fs/ubifs/dir.c     |  91 +++++++++++++++-----------
 fs/ubifs/journal.c |  14 +++-
 fs/ubifs/orphan.c  | 155 ++++++++-------------------------------------
 fs/ubifs/ubifs.h   |   7 +-
 fs/ubifs/xattr.c   |   2 +-
 5 files changed, 92 insertions(+), 177 deletions(-)

-- 
2.39.2


