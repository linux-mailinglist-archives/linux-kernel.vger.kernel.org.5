Return-Path: <linux-kernel+bounces-79675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A8986255B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229671F215FA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A64BA88;
	Sat, 24 Feb 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v1/Yf2vB"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C77481DA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782658; cv=none; b=nPIPXR4M9fkZV3v43fvfRLOZOEhzf9ILelRBHZHppU7zGb0RcVmFvbUdPZMWJu0TVo0YcHQkDxw002aKx//ojgHXn0S4GAqH+lb3jVuJMPwK6TWdOlSjqj6/96Hn1Cv/nKXGtU7Zd2x51DkBvEj4ulRmxcDwvy1xOcJP48r2tkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782658; c=relaxed/simple;
	bh=+lBzQhT9s8CESRput5Fswb4v2EVNe03mwvJpUP7DyIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AjeyEqsXSAHpFOsX3HqUaEGSGZ3DmU31JbPFzIg8agU5yV+ZjWeVao2Nu4mXx1cQ5/FvjZuN8So6hb6iqdy6B2s+wxRYd8hRBkM12P/avGSHN0o8Q0IN+yOwaWT0ZbPx/vCOSZAOQc8TL1ZtfsTgHel3n6919OlXRcqZ7XANFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v1/Yf2vB; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pKdyj1A9SUX/WaHCJPxPGzmkwBmjMOncSsbnh/viqYA=;
	b=v1/Yf2vButT2D2Cm1zR//SGX78XXZkeOX8fca2iuhvR07Bd1bzMzi6QqK5s8lktsUM4uTX
	1KVWnchTFS4IqBELE3sVf64zwnqtsZsiBxsC4+uxtjM0ULsDn6LlnzmOMTf8f7Jz35RQZo
	lyfWOj6vHetOHNcKtynN9KtwKgarh50=
From: chengming.zhou@linux.dev
To: jlayton@kernel.org,
	brauner@kernel.org,
	mcgrof@kernel.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	adobriyan@gmail.com
Cc: dhowells@redhat.com,
	zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] proc: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:50:48 +0000
Message-Id: <20240224135048.829987-1-chengming.zhou@linux.dev>
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
 fs/proc/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b33e490e3fd9..b9c5cb63dd50 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -95,7 +95,7 @@ void __init proc_init_kmemcache(void)
 	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
 					     sizeof(struct proc_inode),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT|
+						SLAB_ACCOUNT|
 						SLAB_PANIC),
 					     init_once);
 	pde_opener_cache =
-- 
2.40.1


