Return-Path: <linux-kernel+bounces-62652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDB852402
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8611C235A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C39860896;
	Tue, 13 Feb 2024 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFSKrczQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822D60B99;
	Tue, 13 Feb 2024 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783678; cv=none; b=m15pTTdo94tkL0ygchakEty04bYtWRn51HxqoplbnnngfQsGF5Xx3lGxnbC86bMLiCiY5NUssCICFGezVRT9p49bPTZnTRfdw0BUfKpegCGsmRroG2zcuYEzKhfeJD84cnUaLHCMxsBYYn3hL2rRuWIxyakyX5L2yylGJfhpDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783678; c=relaxed/simple;
	bh=JZGALJb6JhovRJ3mOWFYjSXwth9epOK7QIkItwUKtJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObwhJEB7ixZOXr0daTZpX2taIgWn0EHEb7IMDL3XV1QtpF9ZGYG7uJsazHLYkvs1FO8BM3DvlUQ6cMJHAbFXl/7EgwFRP/Zgpe+I+rEBnIgtHfQTSZDua+IQDxj8OgPh46yZhticHaGRjxd0omOTVgyWKOCuvxJXhqqF2Fli+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFSKrczQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28081C43390;
	Tue, 13 Feb 2024 00:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783678;
	bh=JZGALJb6JhovRJ3mOWFYjSXwth9epOK7QIkItwUKtJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFSKrczQTLo8xhxk6AKsmLtHw9lpTl6ycsdSbiBe1WKQvAEos5Jgc2DqwZKyCJNaw
	 HfSEHTvovwJPD0A6FhsICkcT9lUkU9bAHG22CBXaKYtRM9vgIU7UeFmiqt4H64V/Gd
	 wSNZ7rj8poBmJrUO07bo+UhCWufQHffY+MbqMMVKs3hrMePV4D3HD0YtjI9dWG0Sxe
	 oo1ul8lCPYeMt6CxpgKgO9mzsn17eVf1u6N5E+gOsJLBW0hEd3QJ9Gh0nVbWgx405J
	 iBz0F2gOo4MOYaHyq25YqLz+SjxnlBSzK2j1pe7mlUui1Fj8bnPRKOSyDRzT6L0AR0
	 UM+SsoIIK+tNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Giovanni Santini <giovannisantini93@yahoo.it>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 21/51] fs/ntfs3: Update inode->i_size after success write into compressed file
Date: Mon, 12 Feb 2024 19:19:58 -0500
Message-ID: <20240213002052.670571-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 0f6a78aef90f..dfd5402a42e4 100644
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


