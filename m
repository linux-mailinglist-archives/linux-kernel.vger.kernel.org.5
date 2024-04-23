Return-Path: <linux-kernel+bounces-155083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5D8AE519
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0964F28484A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359D14A616;
	Tue, 23 Apr 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFT7plzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8C14A4F9;
	Tue, 23 Apr 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872524; cv=none; b=as5IfQgvG/LpOniX9iNMaKxcJ5JOZ/FUEFSQ7BOXYEMhLLcNvJPvpuhea/xtmYOnPkMqfYeEbJ68KceLHBWgl7YrnvHkseHqQPLhxINQkp5I5YCHP3golAAbviFERm+v6PkahTUVmKXMo/mQARdJz0QllBBs0+OF6rATwB7XBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872524; c=relaxed/simple;
	bh=VIkt7ernyuQfMfyUL6sqJyRTWnSKczxNfdRujS7qSV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka18wUF/UP627K1IleiFRirs4visuPnL9Q2LQ6i8pE5avOKWmBKUpxTE+ihui0ydiBiSzzYxlWlff1mFqDpcSaaFkxzB5Cp51pZQnYPU2QGxgj4Y6Doh1XoEpRyZuJkipcFU6YazJkPVnmgOye6HDF+loJ5WpUvOznKAtvJP8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFT7plzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976F8C32783;
	Tue, 23 Apr 2024 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872524;
	bh=VIkt7ernyuQfMfyUL6sqJyRTWnSKczxNfdRujS7qSV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFT7plzrPkbu8eqvZH/PV3Q6JeTRiJZX2rJ4EBUeOVyUdKTPfWabmiIb6oKARbkHU
	 q2innwxNISTCrj7TKuO6hIuh4Z5i+O7g/++eWRdUpgtF9wgt8qHQcjKYRF4fVwJG/1
	 ZZ8Gaeu5JpmvcNK2mQOyGHfCHsiLKYAUrHd6xoG7EWCRRlveiY7BR1GJxgMbPbHNQm
	 DE2uGQklBBve0VhfnfOotMph7nO0t13CDVXiK+6NbGHrBHOXtRZVzjOo9ZsXCD2c6e
	 RmalLyC1cJsgrA/DzCs0mQEbx169rya2ySt4JbyD/AIF1zs/axk2DbQNACtN8P4RjV
	 2+1IvQpWc4OIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19 3/7] 9p: explicitly deny setlease attempts
Date: Tue, 23 Apr 2024 07:03:13 -0400
Message-ID: <20240423110318.1659628-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110318.1659628-1-sashal@kernel.org>
References: <20240423110318.1659628-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 7a84602297d36617dbdadeba55a2567031e5165b ]

9p is a remote network protocol, and it doesn't support asynchronous
notifications from the server. Ensure that we don't hand out any leases
since we can't guarantee they'll be broken when a file's contents
change.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 61e0c552083fe..5bb565856a8f8 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -691,6 +691,7 @@ const struct file_operations v9fs_file_operations = {
 	.lock = v9fs_file_lock,
 	.mmap = generic_file_readonly_mmap,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -726,4 +727,5 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_mmap_file_mmap,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
-- 
2.43.0


