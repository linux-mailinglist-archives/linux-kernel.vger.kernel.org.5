Return-Path: <linux-kernel+bounces-62724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB7C8524D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EC5B287D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05AF1272C3;
	Tue, 13 Feb 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0J0wFxE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0B128376;
	Tue, 13 Feb 2024 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783827; cv=none; b=bnszmJ/EdJl9o334YpvcO04YXQiFFXS+qmQH2SLzo+SCDjRrlCw8gWS+4kGDUK7ClxOmwWzZ7y47/HvkRcENkHRQQky9Rmk5rzf+CIn66+dOO7IJsw21RB4eG8fwc/vcUEdz8KarAiToO0S0NIoTpaRh/S0JWGaCZD6i2RDCFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783827; c=relaxed/simple;
	bh=izmuI3L5atRkTiiozb8n4IWjISJZNUDm1SJ6sz2EJ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it9TEULXpA73pf2CrnlP+OhLYJ352WME6TqxocqHTSHHUJ2b2e8kYXcvJbJNNgYnsLZm4MIinzbj6EtTL50ug3ypLEqxJZp3Bc0MwKhXo67hMYtwl39Wn0y4VSO1VfeE+nsYILn7N2ofQyQmsjvrwQ1oSPR3hoIDGj3goF5gWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0J0wFxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92214C43390;
	Tue, 13 Feb 2024 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783826;
	bh=izmuI3L5atRkTiiozb8n4IWjISJZNUDm1SJ6sz2EJ8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0J0wFxECLWA9eHBQGORkVp8QXGX/ci6O488EFLNPyPY+mdMI0ZzUpmYjIn3dFfes
	 23zl4Xl+FH3bGQzXUE2PY5C315uoyBUV1/WHBeDb+cgoce1YBOqc7G55DdTcH+mirA
	 PLsmNGAwNNspZ+2JZQpVK/WoNn11auOzn7nddAerY4Lu8ANUiC80xBPdiZSMKU47Km
	 Aj+f8VntortMGJKMj6Xy8gP5+p1f3SQy0tmjQmWCiKM16W/3nbcd9y0KRNE50mzDwC
	 uMFAvBbSzcfc4YHAgrPxQDrqw1abs0AFRWIrpQeizclMrYxkK1FTtNWTMmUrduHVs/
	 Wd0gFFxkqFiug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 12/22] fs/ntfs3: Fix oob in ntfs_listxattr
Date: Mon, 12 Feb 2024 19:23:14 -0500
Message-ID: <20240213002331.672583-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 731ab1f9828800df871c5a7ab9ffe965317d3f15 ]

The length of name cannot exceed the space occupied by ea.

Reported-and-tested-by: syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 8e739023e305..d0b75d7f58a7 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -217,6 +217,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
+		if (ea->name_len > ea_size)
+			break;
+
 		if (buffer) {
 			/* Check if we can use field ea->name */
 			if (off + ea_size > size)
-- 
2.43.0


