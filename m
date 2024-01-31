Return-Path: <linux-kernel+bounces-46119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF5843AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E01C20B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61816994C;
	Wed, 31 Jan 2024 09:15:00 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896D60DCC;
	Wed, 31 Jan 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692500; cv=none; b=g2W0PuvHFL5XXxU9z/zguXwgbYdHzmitJNklyj/eRCSKvU5nwFFWVdZy789we434m+gEEKPLC4g3G823kMFJfu7Z7HXTxUqzao4K0Lg8mHX4sjPEqesSAseqBn+Q2uHgjMX33Hqyk/vDYVnQ7WFOGKU2uosNArUODzUEpUZdI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692500; c=relaxed/simple;
	bh=76RXlR/msdWs4e9OX1WpKtSooLAmtPygvVwdSqDyayY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PAS1sesCzLQJWaXEoUnKchM2O0U+EZn8n/2ida0ToeX4/BujfexaQI3jP1Wky/xYWBgG7AW70/XhHA8XATyA0z8bLpmX5WAYI3DIFmqXjO3f5reONYudm3rzZ6tZ8bLCeExwkkWSZVkFfSQ7EMG1rIfYBjp2lIbW+DaStVBP1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TPxDL2B49z1xmtd;
	Wed, 31 Jan 2024 17:13:54 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 347B71404D8;
	Wed, 31 Jan 2024 17:14:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 31 Jan
 2024 17:14:53 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <netfs@lists.linux.dev>
CC: <dhowells@redhat.com>, <jlayton@kernel.org>,
	<linux-kernel@vger.kernel.org>, <libaokun1@huawei.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] cachefiles: fix memory leak in cachefiles_add_cache()
Date: Wed, 31 Jan 2024 17:17:17 +0800
Message-ID: <20240131091717.1277013-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)

The following memory leak was reported after unbinding /dev/cachefiles:

==================================================================
unreferenced object 0xffff9b674176e3c0 (size 192):
  comm "cachefilesd2", pid 680, jiffies 4294881224
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ea38a44b):
    [<ffffffff8eb8a1a5>] kmem_cache_alloc+0x2d5/0x370
    [<ffffffff8e917f86>] prepare_creds+0x26/0x2e0
    [<ffffffffc002eeef>] cachefiles_determine_cache_security+0x1f/0x120
    [<ffffffffc00243ec>] cachefiles_add_cache+0x13c/0x3a0
    [<ffffffffc0025216>] cachefiles_daemon_write+0x146/0x1c0
    [<ffffffff8ebc4a3b>] vfs_write+0xcb/0x520
    [<ffffffff8ebc5069>] ksys_write+0x69/0xf0
    [<ffffffff8f6d4662>] do_syscall_64+0x72/0x140
    [<ffffffff8f8000aa>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
==================================================================

Put the reference count of cache_cred in cachefiles_daemon_unbind() to
fix the problem. And also put cache_cred in cachefiles_add_cache() error
branch to avoid memory leaks.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
CC: stable@vger.kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/cache.c  | 2 ++
 fs/cachefiles/daemon.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 7077f72e6f47..f449f7340aad 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -168,6 +168,8 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 	dput(root);
 error_open_root:
 	cachefiles_end_secure(cache, saved_cred);
+	put_cred(cache->cache_cred);
+	cache->cache_cred = NULL;
 error_getsec:
 	fscache_relinquish_cache(cache_cookie);
 	cache->cache = NULL;
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 3f24905f4066..6465e2574230 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -816,6 +816,7 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	cachefiles_put_directory(cache->graveyard);
 	cachefiles_put_directory(cache->store);
 	mntput(cache->mnt);
+	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
 	kfree(cache->secctx);
-- 
2.31.1


