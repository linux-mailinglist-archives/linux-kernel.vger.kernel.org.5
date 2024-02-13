Return-Path: <linux-kernel+bounces-62580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56190852337
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE994B2504F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B31642F;
	Tue, 13 Feb 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0RVxqbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DF13FED;
	Tue, 13 Feb 2024 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783531; cv=none; b=a5sIZMz2wUU3fJEPJAc1jCpxyinbufOQxOyg1QLTPS1zhKoQOZOuK967hcOsyPgI7tpd8cEvKzcy61YQeMOo+OsFtPNeCyq2yeADYIpXhY3jfwqm6O6hFNpLiDZIjrKqcTp1LHEO36O9zG1g3sOxOY89brgupjGgQgQu2J3uuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783531; c=relaxed/simple;
	bh=dGWXQZ5jRSgn7CnokykQO904q5rJws/zB29LT3Fis6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhNwgcseuJVHoRNH9aOfKovbXFfSzQ3cpa0LNr2K37sY0QWdwVSvNOfeipXJwBS7xrfUQAv7Us7BtTbZngozlkXRgJKqLhgm/ouXK8bfZAySplbZ3khfYpByE4pMqGhB7v20YHfZZNZUY6VeKYMiw0uxvhUMdcBDQL9anwZ/u1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0RVxqbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB51C43394;
	Tue, 13 Feb 2024 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783531;
	bh=dGWXQZ5jRSgn7CnokykQO904q5rJws/zB29LT3Fis6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0RVxqbB8xHmuPaYql10JW1rF9xEs0n6hpz3KZxsOx6ARAN+XRHlkIkzDbr+Q8Clr
	 gpbbg0zaOpKLh/GJ+vgDmxcprOCONZabn7guSmRLyoE12Vk41QQuP4WRUi+cSQI1tc
	 xHzgQarbYtcgXtt4NSF2FKvXXFctpU0ztuG3a7rQ3MZas2MPxr4VQM5O5eK72ZVRB7
	 pPC/sp/W70RXopD6YQTYfELDyuwOo2PNxC52ZTFP1yx9qHckx0oslQ2MbWgcigzB0g
	 lhSE7w4h0E54H3CggQNWd3uJaFFGs5fXf4fO6Z5TDSo16VzY9ell+POab1iNBe7nS7
	 lk/hQXAKGjvcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 11/58] fs/ntfs3: Drop suid and sgid bits as a part of fpunch
Date: Mon, 12 Feb 2024 19:17:17 -0500
Message-ID: <20240213001837.668862-11-sashal@kernel.org>
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

[ Upstream commit e50f9560b8168a625703a3e7fe1fde9fa53f0837 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index bb80ce2eec2f..0ff5d3af2889 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -498,10 +498,14 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		ni_lock(ni);
 		err = attr_punch_hole(ni, vbo, len, &frame_size);
 		ni_unlock(ni);
+		if (!err)
+			goto ok;
+
 		if (err != E_NTFS_NOTALIGNED)
 			goto out;
 
 		/* Process not aligned punch. */
+		err = 0;
 		mask = frame_size - 1;
 		vbo_a = (vbo + mask) & ~mask;
 		end_a = end & ~mask;
@@ -524,6 +528,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			ni_lock(ni);
 			err = attr_punch_hole(ni, vbo_a, end_a - vbo_a, NULL);
 			ni_unlock(ni);
+			if (err)
+				goto out;
 		}
 	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
 		/*
@@ -563,6 +569,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		ni_lock(ni);
 		err = attr_insert_range(ni, vbo, len);
 		ni_unlock(ni);
+		if (err)
+			goto out;
 	} else {
 		/* Check new size. */
 		u8 cluster_bits = sbi->cluster_bits;
@@ -639,6 +647,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		}
 	}
 
+ok:
 	err = file_modified(file);
 	if (err)
 		goto out;
-- 
2.43.0


