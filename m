Return-Path: <linux-kernel+bounces-155012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F68AE454
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479BA285CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A078625C;
	Tue, 23 Apr 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csC/30zU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF58564C;
	Tue, 23 Apr 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872408; cv=none; b=c6NlMBXiSLFDuF0qduFKNV4wWRr2tq+A/lerUa3UMGWZFC4k/CZTZZw/dLH2NLVmBja1xOMviJ3kZWvMMduKl7eRihWBPqon0XJwrng9E4MtcZlP+wLQY979kGdT8CW8bnAGMXm2t5S6zPoVyvhqag5vtfpCle783WxjQLIF5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872408; c=relaxed/simple;
	bh=UDaPVYxqUw/Q45OpXoGSqA3JFjqw/Mtk8GrIqSNtwPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKSqF00yeH0X/ZpSYilEHSzOMjb4U5dsfMoQT1D179bg54SmjvrMWQ+6aGEqiyIi4D/sxfejjgVcASIdhw79woLD9RBkYnGSvnfvII/Yj6OnUbeQazI0ql4dnYgCtivEovQuAsl4VRrX/ahcw8JDrtJ97HPp5+0P5nYjUQnX+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csC/30zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88EAC32783;
	Tue, 23 Apr 2024 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872407;
	bh=UDaPVYxqUw/Q45OpXoGSqA3JFjqw/Mtk8GrIqSNtwPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=csC/30zUj3Wl6U/wxBzwqJSGnFwiEO5KYW14e/JcbNaS/zgm6RT+aT2Z8gQEm/izc
	 Hn3xcGW/J+xh6WmxZHZPq96nrpA9IOLDXI77cnzOcs58fztOZUf1d/AudnVFoDxjnf
	 S4nahdlqq+rs29bW/tAxZGy5m5q0fi1t5Jvqd7/z9J3Sn/+/DmcvBW2SLKnqFhj+W/
	 9vdGHAn+gxxzx+Fc/SMQdgv4tsH5LYq1XqCXPQNKBgHm04Db3fBL9Ylh/PimT6aJir
	 jNgVTXmZ7rDfwQFg+wUuq92u2gSQFhkT5xzL+blbiJApVWmE4n+p+vlR7pLbrPsjos
	 k8ljleiID8ZZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 04/18] 9p: explicitly deny setlease attempts
Date: Tue, 23 Apr 2024 07:01:00 -0400
Message-ID: <20240423110118.1652940-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index bae330c2f0cf0..a504240c818c8 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -520,6 +520,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -534,4 +535,5 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
-- 
2.43.0


