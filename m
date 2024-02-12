Return-Path: <linux-kernel+bounces-61425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C259851230
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C31C21F19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6B39861;
	Mon, 12 Feb 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUw6YATQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5139843
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737186; cv=none; b=F9TMkPvJVqkfQIaToSnrNVMFNJnctojZyYjsEFV4LsUjjfxxcddOu5EGjxxoesO5SGOJD31Sik8NMx7NILxDZxjxBE4i+b8wwosNH0F3m3l4nrvh5KsavgEUD7dp5BCI8SOx3eBjfNBCHH7BgzRifKXxr21R4rLHncCp+2AYGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737186; c=relaxed/simple;
	bh=kQ/S3yu+q6V9l0izkm6EyVa7NqjSw7TIbz/RHpeNZGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZejiGBuxt8E5VlRRuemjFBSQ/aLOoiGhjFVbd99ipi4L1gH7qcRWDmBjAs/uKKsRbFfufPL75xND6t+1j+HPDLtMbhUt9WeKXVdHjK9i0z8peIZyyoCyi+QO5I+AEhaK8rdkEjVE6B5t2B3Hot0CYAYfSz3GzwbRTiMqix976Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUw6YATQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC46C433F1;
	Mon, 12 Feb 2024 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707737186;
	bh=kQ/S3yu+q6V9l0izkm6EyVa7NqjSw7TIbz/RHpeNZGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mUw6YATQ8JVpYKdj2Lw3pu47bZv2hsO0fbcavt4UmDk8fbiUf2lPstw2uC2/g377D
	 fYIZ5fPNWQdmxs7ZMxqgjgGawEPUpRUQPDXKvGl1lbu6MRRiyQ8EXLUFjMG2GySi1v
	 gYlSSofEBkzYsHhsF6xbL4DwplxkVTpEb/8NHMgLUb0az88Ok064+CTWW/EUDhwNmv
	 zOKHhn04toeNuWxoQgMFe9or1xx2Q/Nfw7y7Y/jKD5bN2YmHuvt0VyN5BfbWnE4uUm
	 UJNFR1alaa0FkMGseyCWIJUHx3xwB932WbEdDfjil5+9Pcd5ut063YZr+HhNEBhRdk
	 ZwSCc9nLlKJIQ==
From: Arnd Bergmann <arnd@kernel.org>
To: NeilBrown <neilb@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Luca Vizzarro <Luca.Vizzarro@arm.com>,
	Tom Talpey <tom@talpey.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] filelock: ignore 'lock' argument to for_each_file_lock()
Date: Mon, 12 Feb 2024 12:26:11 +0100
Message-Id: <20240212112620.1272058-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_FILE_LOCKING is disabled, ceph causes a warning about
a variable that is only used insode of the for_each_file_lock()
loop:

fs/ceph/locks.c: In function 'ceph_count_locks':
fs/ceph/locks.c:380:27: error: unused variable 'lock' [-Werror=unused-variable]
  380 |         struct file_lock *lock;

Rather than working around this in ceph, change the macro definition
to still contain a reference to the variable in order to shut up the
warning.

Fixes: 75cabec0111b ("filelock: add some new helper functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/filelock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index aabd4bdf7eba..69290173280a 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -283,7 +283,7 @@ static inline void locks_wake_up(struct file_lock *fl)
 {
 }
 
-#define for_each_file_lock(_fl, _head)	while(false)
+#define for_each_file_lock(_fl, _head)	while((void)_fl, false)
 
 static inline void
 locks_free_lock_context(struct inode *inode)
-- 
2.39.2


