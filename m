Return-Path: <linux-kernel+bounces-79699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D48862585
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4DC283299
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98E41212;
	Sat, 24 Feb 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="omP0CVZG"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961A29438
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708783104; cv=none; b=F7eWD9Fa3THRafyS5ntbRFRm+scJn1TV+VyJO7q6b3dQ8S2IhYWy1KeCg90zTxJqd8nJkecZETO49Ll0FJNhYrceMoC6/gDbjYmT+a1sIsOq1j8xD8mFWZADr0HxQBOY4TebTF8Ouadvz3Dg5aPauElLzN9v88JBcLoRv9XU8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708783104; c=relaxed/simple;
	bh=H3yM90CwtFVBt7rzdRIRr1HuWNvQAnPYVvqbM446TTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RnQihy7gd/KoWQw6tbhc6VvqETYeambNJypb2DOV9N370PV7URHOrVr4Jmr466boARRbw8IECpeBpFWzJrwVxe9EVmJDj77hWoN5+9+EY6GSkpyBIrLvstqRKrzWkpnS9L4O3sX/ZHrJJx9qvl7d0LQBtbBMuaE1DW6iVkdLEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=omP0CVZG; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708783101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bhu2va+UqqcLcHRhe7fhNdtlXWqQF9gbl8QqHkczEiA=;
	b=omP0CVZGkPBRT3fph8qZlElGpMxLCZqK/pMWtpGUTR9LHMbEE4UTCtLbFA8T19yFhCSRtu
	gt+pYcCPA02k8coZHJSp3DDfq3c2v7OB8PAomBG9lSrIudNkH064nXuABJSeZEzj1jJ6aP
	StneKXX+k7O3sqa4kzN+zAhqyf8RQ2A=
From: chengming.zhou@linux.dev
To: sfrench@samba.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	samba-technical@lists.samba.org
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] smb: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:58:09 +0000
Message-Id: <20240224135809.830610-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/smb/client/cifsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 9cd3bb48bd3b..45e57c852f33 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1661,7 +1661,7 @@ cifs_init_inodecache(void)
 	cifs_inode_cachep = kmem_cache_create("cifs_inode_cache",
 					      sizeof(struct cifsInodeInfo),
 					      0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					      cifs_init_once);
 	if (cifs_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


