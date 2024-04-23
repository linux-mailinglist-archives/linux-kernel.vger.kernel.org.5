Return-Path: <linux-kernel+bounces-155047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C957B8AE4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B74B25BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1F13FD81;
	Tue, 23 Apr 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg9/a2ZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C971F13FD61;
	Tue, 23 Apr 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872463; cv=none; b=Yca/EIZmXLrsPwZH1oQIeNoxRrXvQ9sMWorSyJ2QQbhsB9T25VsjeoGOpMT5/UMAy0dhiBhg30tHjYmNtN2Z4HYhlkxZ/U6QYS6Dm4lVayxFiPMLhmLuWydJAiBn6kuuI8NSTp54HLcLgsoXZACndLkOp8RZNciYMKhB+bx+vHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872463; c=relaxed/simple;
	bh=RtleWkbbY+Os9CWeeebkpemyAVsN7UYp4fK2i35g3lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNyvDJx9N2k3C8sacHEzikiAFvo6ZPZxtJYESURF3BkV8Po5GL+EUEhOf4Vj9ZZTw1lSv9Rgnu5S3lzudf8bt5995AWIInXd4xTObmF/t08wAGHsxWsZiyCi4i21NVYpNHjt0JY1ULb6+xAoBYhXMY6yxtjucHciaX4mVXXwHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg9/a2ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C375C2BD11;
	Tue, 23 Apr 2024 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872463;
	bh=RtleWkbbY+Os9CWeeebkpemyAVsN7UYp4fK2i35g3lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mg9/a2ZA4IxO1oWiRpVoi74eVAVE8XAZOnjDoGilZpzqKRdR+N8ZLxe/lRNnLhvp0
	 Rqo1pDMRujtCfBo0To5AdRkoye8WYuS0YlIUgDDZQe8xSrEA4WIzP4JHVufTlWHqei
	 uzTtt/vHPYGiOR7VhU9mYbN+lU6UEGpeQ9wFK2uBFuQ8D8u33jjjjlE6hPfsuuU0Gl
	 wU1jt0QR7tmQwjgjARZf6mxJtq4hqgEUqHOvfXfVLvgIIHKiEbi0jg5+Og7b9SuwM/
	 w+WxuwwQlCjnC6nXOzD1bWXUGKM1uTNGi2+jYFTANeaSuZI9Gy2MjPSky2IP1bqQF0
	 SFCi8fq5OaXYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 3/9] 9p: explicitly deny setlease attempts
Date: Tue, 23 Apr 2024 07:02:09 -0400
Message-ID: <20240423110217.1658879-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110217.1658879-1-sashal@kernel.org>
References: <20240423110217.1658879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index aec43ba837992..87222067fe5de 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -667,6 +667,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -708,4 +709,5 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
-- 
2.43.0


