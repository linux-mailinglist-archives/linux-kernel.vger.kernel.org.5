Return-Path: <linux-kernel+bounces-62723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10E8524D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6130D1C22341
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1C12836C;
	Tue, 13 Feb 2024 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1cdexyh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738D127B5F;
	Tue, 13 Feb 2024 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783825; cv=none; b=QEMgu7PvLbSKxRDDZsAP9GtiKPLpwCShuvKPkRo8GI8raRI45sjkHpJGgYLaiWSY/FWPj+1rgbueji5xo6fYIfOER3P/Fy6I4uyrm1Pc072H9K3MjjIQeZzJ8Ks8D6mAD9WeLnwhLxOSxHp6ImP9NyvrJYA6Rslezs5AeYUzUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783825; c=relaxed/simple;
	bh=nA6uUqOHkziK8A3kVoWfrYRKPyWyjSawbjGytWuTpno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmOa2uxG6c9RykC+ObF2s5c9x7h9aOrJ/v8s04FMUUDVN+yrCS/7BeMJHesfvk5RiQlDKFrSrxuxp2gLSJbnDeEmlDvtrANXZnlOo9HlTY63UpUozaXFFT3tt9B7ss1VxQ2wtZaA0AP1/CvCypSgR2DMLv8+rC2ZGyFgNqID/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1cdexyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66195C433F1;
	Tue, 13 Feb 2024 00:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783825;
	bh=nA6uUqOHkziK8A3kVoWfrYRKPyWyjSawbjGytWuTpno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1cdexyhs6rc5GqACuh8peGU1yEm/9qlDafQ5L+h6/fK5aJVSRoD2C0fSBoGRV2Yv
	 9zyK30AYNIDqV9sOPCEnfG14SWN0cXTC50g/GKCqvqNa5QbCkeLLcRPnc5E14Bub6z
	 8ZjO84q55QEIBK5Kv8Un6FodIGSscJSlbI5PA4hJDJPvegiDeU3AgCGQDic3ICP9Lr
	 35guKxEZg0cET/rUXd49K/il3kDK6iKZBH86IgCL8L2ox4/GHaPzTiJCVRk6qLN9bB
	 Dp+3AgeJYm626dDu0vGCuXm0xQbMPLNuvswJ+2vIqsCIUEU0jeX1vv8EGlA5ll0aaX
	 AMymS2Ljw9pMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Giovanni Santini <giovannisantini93@yahoo.it>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 11/22] fs/ntfs3: Update inode->i_size after success write into compressed file
Date: Mon, 12 Feb 2024 19:23:13 -0500
Message-ID: <20240213002331.672583-11-sashal@kernel.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d68968440b1a75dee05cfac7f368f1aa139e1911 ]

Reported-by: Giovanni Santini <giovannisantini93@yahoo.it>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c526e0427f2b..6d4f3431bc75 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1090,6 +1090,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	iocb->ki_pos += written;
 	if (iocb->ki_pos > ni->i_valid)
 		ni->i_valid = iocb->ki_pos;
+	if (iocb->ki_pos > i_size)
+		i_size_write(inode, iocb->ki_pos);
 
 	return written;
 }
-- 
2.43.0


