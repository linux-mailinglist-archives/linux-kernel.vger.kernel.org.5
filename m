Return-Path: <linux-kernel+bounces-155075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FE8AE503
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3735B2548B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB331494C8;
	Tue, 23 Apr 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw1Vu0a+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4291494B1;
	Tue, 23 Apr 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872511; cv=none; b=PmtJgFih2C8pVgH9gpS4cWKsQ50htJRU9I2K55aS4xI33Bhtzwe9C67yFgFSBrPxjDx9oIyba9bSSs79FGQKxc9zVH8qcuQcIApAU/XHKU5TJ4S+4KgyN21vnltE1aUS/4Gli1Swd7hmpFQCknF/o7/7UI4Q5desTwKyHZJM46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872511; c=relaxed/simple;
	bh=s3bgpOqEVPgxz+WTua/CVDLsS7TiwNKqMPEHlzHIwek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr/aQJkg3tT2CiKnqWB990yR7cE45m3EHdn61XP+Q03rV29LM8VGIjfIy7DnUPDQXoKI3mo7TPpPqJgpPfueAJTlIHk4pAZkAdn43v7sq6adhSRxbpStlXaDrNpVzJAIWUSLsEqgePqBGyTkcMfuwL9EY2zIY5S/ZH5NHNoNtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw1Vu0a+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86D1C3277B;
	Tue, 23 Apr 2024 11:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872510;
	bh=s3bgpOqEVPgxz+WTua/CVDLsS7TiwNKqMPEHlzHIwek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cw1Vu0a+dPKHObhlUx0UpEMDbFysjsvE+zmQweeQmhmuTiTjIgXxdZTNK9cKg5169
	 Sd5d/E/tJ1FFxwB5tyqay3af7hHuTy6aojBGzvaYSs47XS/R/R1qIHwxJZ44WNS8Y3
	 vWXWa7LzlZolArX+FDXTOqMERPxSLVQOJWr6wufRPPrORi6N8wdEZ5IrPmNukcdzZo
	 NjTzaaYX+zNm3YgBA+lqE45fB2HfAHFNwTD4AXoVgXl4UKJ1otOGkNnFXLXFcKtGew
	 02JtxK726wj/7eUZZ+8cmyrNw/Dsmw0hxZKShxaj1cU5atAMEvOwJFrdvq6cjqUya7
	 qrslJp6EFIQHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 3/8] 9p: explicitly deny setlease attempts
Date: Tue, 23 Apr 2024 07:02:58 -0400
Message-ID: <20240423110304.1659456-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110304.1659456-1-sashal@kernel.org>
References: <20240423110304.1659456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index ee9cabac12041..14d6cb0316212 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -676,6 +676,7 @@ const struct file_operations v9fs_file_operations = {
 	.lock = v9fs_file_lock,
 	.mmap = generic_file_readonly_mmap,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -711,4 +712,5 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.flock = v9fs_file_flock_dotl,
 	.mmap = v9fs_mmap_file_mmap,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
-- 
2.43.0


