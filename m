Return-Path: <linux-kernel+bounces-62718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A08524C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166791F232FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D186634;
	Tue, 13 Feb 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ6mJJLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03985C48;
	Tue, 13 Feb 2024 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783819; cv=none; b=ZjBDJfdK7P1MGT/obFKXPsYGAHbAJaNMYeVq+ffIGLpnYTtfptX06WgFtBg0THPRMF6bzEYsMhMrhKvgb9Vkcna5IqpN5FlH0v6rtyLftSLUf37Ehgpq7XCCLiEW9bfw3MABK5T0fsBjiNCTJz0raIgebmEFpfNyOX1ZCHNGd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783819; c=relaxed/simple;
	bh=19CLHTehqeiZVP9eVEHK83/KTH9aK2QdhecAnpJq68A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u16MumuRKgVYqqUozeozARFO8MyoPTJkYPvCBHA5S1rqYQ2505JsDXBG8czus3V6BDuG/wLoHU8PcSwHU/WGy9E37Wu1vSDw+9sjKJ0O2iXZJ8ZHDjLAlHUpRgb+Dis6bodn6ImVXRNYvRrIY3mPnXOEkT1mUr5D5ZXH8+qkDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ6mJJLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971B2C43390;
	Tue, 13 Feb 2024 00:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783819;
	bh=19CLHTehqeiZVP9eVEHK83/KTH9aK2QdhecAnpJq68A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WJ6mJJLeLGDFpL8fEiPcxDIqs/NmUlCsSmXkSCbIhmM/4Cm/y48FWdsh9hp7zT1si
	 ET8d1GA9KcGFYDjUWp/sQMMmsrw9MFuLB/MXUnQ8iyz2Pg84JzmIJXKIntWlCarqhZ
	 eVV6rsjNJ04skTdRtmS9B2zAiBc8xUP2tA/D7a+LK+6DFWG+2TqcetWAxmbSuwPy2H
	 yQgw5AdtOLV5fxXGSi2Sb0QXULfrSU/QqIcTM40wV22t5Sd3riX13RGyZ7HiJv4s/w
	 ydSnifOWwwD0x8y8zIND1/Tefina2T/dBUC8bvjVJBmC3ioqF/p2deok6XlpBiAcHj
	 +m1ZUrdYFpYug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 06/22] fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()
Date: Mon, 12 Feb 2024 19:23:08 -0500
Message-ID: <20240213002331.672583-6-sashal@kernel.org>
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

[ Upstream commit aaab47f204aaf47838241d57bf8662c8840de60a ]

It is preferable to exit through the out: label because
internal debugging functions are located there.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 1d5ac2164d94..64a6d255c468 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1583,8 +1583,10 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			le_b = NULL;
 			attr_b = ni_find_attr(ni, NULL, &le_b, ATTR_DATA, NULL,
 					      0, NULL, &mi_b);
-			if (!attr_b)
-				return -ENOENT;
+			if (!attr_b) {
+				err = -ENOENT;
+				goto out;
+			}
 
 			attr = attr_b;
 			le = le_b;
@@ -1665,13 +1667,15 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 ok:
 	run_truncate_around(run, vcn);
 out:
-	if (new_valid > data_size)
-		new_valid = data_size;
+	if (attr_b) {
+		if (new_valid > data_size)
+			new_valid = data_size;
 
-	valid_size = le64_to_cpu(attr_b->nres.valid_size);
-	if (new_valid != valid_size) {
-		attr_b->nres.valid_size = cpu_to_le64(valid_size);
-		mi_b->dirty = true;
+		valid_size = le64_to_cpu(attr_b->nres.valid_size);
+		if (new_valid != valid_size) {
+			attr_b->nres.valid_size = cpu_to_le64(valid_size);
+			mi_b->dirty = true;
+		}
 	}
 
 	return err;
-- 
2.43.0


