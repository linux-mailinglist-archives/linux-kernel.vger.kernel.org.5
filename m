Return-Path: <linux-kernel+bounces-62695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D4852475
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3721F229E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3C79DDF;
	Tue, 13 Feb 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR+pxk77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB579DAF;
	Tue, 13 Feb 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783769; cv=none; b=IB4FYVgLIFUZnhQbat1wTZzcxybAbZmLDI1INv+tBxZlyz4uqE1hHdBI5ZfFzuxUE9gleRTaSm+vSn6mSURoqh3CSTs+BuN9ngAzaoSS6JbJKYj+CmeQAr3mU8d/8/118zIpSlSLMPgY95igTX4/Br9O+bDEBSbKjkSTWi3mC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783769; c=relaxed/simple;
	bh=F5MHgzuXk0iDG0DDLth14bhgesw6odfg8Tl4xBXoi4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4FdvCMTCbv7bQ8RXoaoBWJE/qfgUBZI0rq1feeSMkF+QBGNnTi0pLyejbHrFofLukx8megtcmivZY1dx66GiTYNfLmqgsqjkrrm5YYF19IlB3zSU3p7ISwZFUuPX+SsZaVgFwITM6qFXAInoOX4HL39OH+zXiLN9YK7MhY9FxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR+pxk77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3616C433C7;
	Tue, 13 Feb 2024 00:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783769;
	bh=F5MHgzuXk0iDG0DDLth14bhgesw6odfg8Tl4xBXoi4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BR+pxk77agH0v7rGi9gas3uRIgt2KaC8ykg6RcjatV8PPbdAQGXqko2PuwsgWcXhr
	 veckIBgfSZzMkAqzHRhpJ62PkKjOKaYV9G84F8KNzKfwDMZ3N1w9fpprfL3b0VNBwm
	 1D+gxT86xSbpppjhh+JQ0D0iWCrSwVeqc1MXs46am2Um+X/NexsTnUEXbwwalQ9jnA
	 uoHk+edAimox+q/3lvfMTKbx5QFsE2ICURBU3cYkCuBYbulIwUrI80PFFU23U2P/+i
	 KgVP1nJvR8MP/mTLJuYrnSbKy6eKe1gLO1A/4whJYPRur/anTydySBEB5nGQKFB6XH
	 y6ZCkLaLCxHig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Giovanni Santini <giovannisantini93@yahoo.it>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 11/28] fs/ntfs3: Update inode->i_size after success write into compressed file
Date: Mon, 12 Feb 2024 19:22:09 -0500
Message-ID: <20240213002235.671934-11-sashal@kernel.org>
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d68968440b1a75dee05cfac7f368f1aa139e1911 ]

Reported-by: Giovanni Santini <giovannisantini93@yahoo.it>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index f31c0389a2e7..14efe46df91e 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1110,6 +1110,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	iocb->ki_pos += written;
 	if (iocb->ki_pos > ni->i_valid)
 		ni->i_valid = iocb->ki_pos;
+	if (iocb->ki_pos > i_size)
+		i_size_write(inode, iocb->ki_pos);
 
 	return written;
 }
-- 
2.43.0


