Return-Path: <linux-kernel+bounces-62593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097A852366
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534C71C23324
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657F2BB06;
	Tue, 13 Feb 2024 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjEE7EfR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32992AF11;
	Tue, 13 Feb 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783547; cv=none; b=GxCkkSzSu8SPhpvQsoyoX8sf01sZod5uL3HgZuQOlDYv2cHOPRTHJ+IABiaWOc86e9yT5+cwBtR4nXABr5/NnLYzpA2ZbuWPJXNnkSyGf0uVdy3MoWkar6ha2pNlZm+Xa4psjK1lg2bca2AzMDLkDsfPyDw4xEEQjSQ74BWlxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783547; c=relaxed/simple;
	bh=sdvJYBJtApfSaW7mad1eNWcv4KIMY0s8//64ExQkjKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItH9qVIMU5x21fi7FVqJka6tH47P7MBgXLjmqBfY4BRAbv91ObuaTb/TjgxuaRy6JufC3mPmJK50YfGiONEmat1EcPAQ7a/YrmjRglwP7gUkGODr9TWI6Var95JUxmDvNPRQ5b/mNer2WCi/3Y7hjUb4VNNJ+aPseXY+8ht/RcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjEE7EfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9406BC433F1;
	Tue, 13 Feb 2024 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783547;
	bh=sdvJYBJtApfSaW7mad1eNWcv4KIMY0s8//64ExQkjKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjEE7EfRVsjyezachdJiBQv4YYoOtuGKlfSqudi9kYQVZs6Uc0YAZwwqy5J/AYjft
	 v8NZyAoumpIoRyj22uhp/NIlS783ic8OYmLSHZtfGgd2VKVBmy4b1pdl5LeVU/Dih+
	 riqn5cj8HH1hN2HExwYauErSEIv/mSmx34rg+Sgx8+dWxyfZ7IJ9ReDTX1M61LJy5G
	 C8opO2IvTnv520upuyXr+r5k8fE+nS7V1TLwmvC/GM2qCy7NOW+M5ZMWNmW5mahyMu
	 BcfvMcY+TGW6VHBKmWjJDEJgP9yt2TsS6aBHsLAwemVsxsbQvQsgxl5hx3B1QfTNDR
	 7vtyGmafkgPSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Giovanni Santini <giovannisantini93@yahoo.it>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 24/58] fs/ntfs3: Update inode->i_size after success write into compressed file
Date: Mon, 12 Feb 2024 19:17:30 -0500
Message-ID: <20240213001837.668862-24-sashal@kernel.org>
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

[ Upstream commit d68968440b1a75dee05cfac7f368f1aa139e1911 ]

Reported-by: Giovanni Santini <giovannisantini93@yahoo.it>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index b702543a8795..691b0c9b95ae 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1054,6 +1054,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	iocb->ki_pos += written;
 	if (iocb->ki_pos > ni->i_valid)
 		ni->i_valid = iocb->ki_pos;
+	if (iocb->ki_pos > i_size)
+		i_size_write(inode, iocb->ki_pos);
 
 	return written;
 }
-- 
2.43.0


