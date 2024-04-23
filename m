Return-Path: <linux-kernel+bounces-155030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002788AE48B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD28287EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD313A87F;
	Tue, 23 Apr 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYV7ycCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A513B58A;
	Tue, 23 Apr 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872439; cv=none; b=AaqJk75Z4EYuix8EUR9Ns8Mi66BTrHrPQI5TtFZuSP7o6rBjZFFATBtw3k3iofIObvKLdCIZyhS7+fzXA4+ipiZaC1PUnKwV8HOP0haOqa2MxUW/KOHXLn2uQnLaq3chQBSxvG9CKC7Z9KWFjMiC6Jxo9p+BUcVvSkL0VDDUjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872439; c=relaxed/simple;
	bh=bAtX3o9gj4AZ2aPWXyT0Ta1s632fUx0qRDXoyWz5f3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsYGzCaurinG7ZvVlYwFMG9Lyr4MFJYEQTCRd2OoUKfU/64x8GrUYu6LqlJRTjw2J1XsLClkuQVSHejJfaaz7InkHeiAGfITIwPBAhKpuuqEheOjK/PmzlUCR5lWCDUroPMK6apIuRESUscw99ZQjRAzXTJP+tMuuL1CQk+3YF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYV7ycCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28750C32783;
	Tue, 23 Apr 2024 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872439;
	bh=bAtX3o9gj4AZ2aPWXyT0Ta1s632fUx0qRDXoyWz5f3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYV7ycCoZZqeLbRwJ1aQrjQ/QBZeatj1ovUs+1PkPETVBwxsaQ5sxEr+9bhtxdWnD
	 gsoRbIEYApcpQ8COVHgUf2qarM9hYSSl8QubCUjEdHt+VBg9imB/315eHYsiyeX81+
	 lDhkWoU5Owprs3tojZkaAs3+x16JKV9rG6sAvhULOHPhDAtr5YqJ5PZ7tUsb4vHb5/
	 IaWKX+FO5j78fVaLL6ZZgkTBebc57lT/olV3IZqXRM2cjExXUMmCPuT10qtN0f8Mpz
	 iXosI8znYbUUvGRRRSjU0iU7HRkVUyLLkGXQQI3Ph7w1a4WdXJofF9BA1ZeP7DAGCT
	 cWpFsAjG1Gssg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 04/16] 9p: explicitly deny setlease attempts
Date: Tue, 23 Apr 2024 07:01:37 -0400
Message-ID: <20240423110151.1658546-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 11cd8d23f6f23..8566ddad49ad5 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -591,6 +591,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -605,4 +606,5 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
-- 
2.43.0


