Return-Path: <linux-kernel+bounces-62585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0BD85234E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E29B25BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AD5224DB;
	Tue, 13 Feb 2024 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fImPgBlm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEB22334;
	Tue, 13 Feb 2024 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783538; cv=none; b=dzCNb3pqYFwHIHTW6OtyYoxe0QcMjq+yfIQznKVsc/t2Di7LRkAuqHM6IhyyZlZkxioq0g1wy46QhGBAc1iZYC4aX66mt7nKpJXd9C/PiD+nugT4V5hJOEfJy579HSWE/LznO5eIUOX4eDkBuHntYyYtT4YSCP/VBu4s0i5jVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783538; c=relaxed/simple;
	bh=eaZz1eGGu0+8ILrSadYxbm20ikxjoWcYRrt/FCqn+Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrE2TR4bFvaIGsFz3CYMD2/n/If9caNhd++xmYyDTvG3mlvJLyT7xDPSmBbas5B12lYm1kJ1kZMSOjOEabLHTnDONMCQ0CTA8DgO9HDDphh4TL/OP1A0WUXzHGwkeSg3CXVWgRW5fkauAo+tMmN5WqIxGwn18OYqVayiKplglqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fImPgBlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED31EC43394;
	Tue, 13 Feb 2024 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783537;
	bh=eaZz1eGGu0+8ILrSadYxbm20ikxjoWcYRrt/FCqn+Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fImPgBlmcmw7rMQjtW7kJItPGbgFM0UXscBJZpk2Ve/6tjLsBmLQaXJW/qMJDFTTC
	 MA7KWz8xMumDJxj3sTJikbDj7jkOdRPfHTsPOdsEOJ3UJmVlM7QQWQyKtgqwNHjE8g
	 at/VIXWMZd1IDt5DXTsQu4v1rW0ZXKPBJgOglIpUftcMLI9DfAV//Wf8WQFi55zhYf
	 wdS8tzOzkMcf1DHaKpTwaAtCr4QbpyZsj4a9WmsSZT+0tIJxIMRXHc4vcg3ZoX8ara
	 PXeTR/3b+qDVe6WwNvbAxIJMcYMjTuEbXczS7qaoiLClE7K2wNZxKVxJ2ocw5E/Rji
	 wBdr1LY/x/U/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 16/58] fs/ntfs3: Fix c/mtime typo
Date: Mon, 12 Feb 2024 19:17:22 -0500
Message-ID: <20240213001837.668862-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 652483bfbc45137e8dce556c9ddbd4458dad4452 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8744ba36d422..6ff4f70ba077 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3291,7 +3291,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 			modified = true;
 		}
 
-		ts = inode_get_mtime(inode);
+		ts = inode_get_ctime(inode);
 		dup.c_time = kernel2nt(&ts);
 		if (std->c_time != dup.c_time) {
 			std->c_time = dup.c_time;
-- 
2.43.0


