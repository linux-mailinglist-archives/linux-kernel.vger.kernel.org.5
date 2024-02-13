Return-Path: <linux-kernel+bounces-62696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597E852477
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E88AB25F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1632224D5;
	Tue, 13 Feb 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCmrjVN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212A7A708;
	Tue, 13 Feb 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783771; cv=none; b=l2RAuv3kMOVxihYQCxCHrRVI13+g5tXt7x5RiMrhHPuvpq1j3zc+92+hhF/f0f5wsOd6TRGLRc+f/e+lJ9+siGCB5yFJsOTJnHPZWjA+n/MUmY6/3qKpTp5FJBxZq/314/eyWax5hFAGY/PIU1rY+oAEvvJaW/JRD0BIG2A9+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783771; c=relaxed/simple;
	bh=YjAmsIifFdM1ic+s/g5GLs25vN52ua+ZyccU80kqhaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkAu4FxtIPhG+W19Bxmn/ldFrMFFVL6BAF2SZAx59l7RmjY5flCGln+NIOkICHG1Ngy063hpkmTuxpcyqefZgE+2tHfjBcQCffIanNJLBBOR33R5LAhrbQsK60ueJs0yvU1yIXI6FrxqcemIUINfg5CqmS5zL8oyxFAl/595UCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCmrjVN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E51C433F1;
	Tue, 13 Feb 2024 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783770;
	bh=YjAmsIifFdM1ic+s/g5GLs25vN52ua+ZyccU80kqhaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCmrjVN1NwPAhvS/8FwPlkO4CdfBAOb1bmHutkClv8ba7aMR4cfJi50NeD69KhMpv
	 Xa+Rg6qgMzEA6TuRvdI6Tyb/3k92NWubfxk8pQyprf2EWZeY6G1cde+sdLMOsRuGAG
	 Qh+ZRbUMCW2SGGvNdaRyXWuwL4tdWlCAGcNOw89w1UfK58uLTmiaKNDqzDoYozYFHn
	 H7qu8ijeu8UteYlUrunx67csruGNDS2V2Fhk24zneKYk0u2JjIU7+XVVcymg77qVav
	 VziqGh9iwx/CNt0lDuqD/9T4yEWCkUbjIdlqYV4boCIuWz9hz938vzXRcW8txjYzoD
	 TemBUMpU+ccxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 12/28] fs/ntfs3: Fix oob in ntfs_listxattr
Date: Mon, 12 Feb 2024 19:22:10 -0500
Message-ID: <20240213002235.671934-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index df15e00c2a3a..d98cf7b382bc 100644
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


