Return-Path: <linux-kernel+bounces-62722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D7C8524CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6451C2156A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2183127B42;
	Tue, 13 Feb 2024 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5SvWaYe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5C1272C3;
	Tue, 13 Feb 2024 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783824; cv=none; b=NCnWjyhqx0H0aPDu0aDyC0p4RUmh/g0HN6oWFfc6dAdFLqJcOchLo5AebYYsarPqI5HyN7Wr30TU2LxcP0c3nJGgvoIJn2bJu00wRIPyNOmR5yy+enR9BZ4iPJDINK+h83IgCZW2StlzQ6YGxDDt9KIkvKWthlq0sVKymp2VX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783824; c=relaxed/simple;
	bh=zN18JXm5wM17kjVxhbDLZaOyRkLOOJpLKw/kqy+PzCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMqYtAMRYdWZRYo3uH5KvFFvmTyMsRHX1M4H1KhV3tP/uP/qVsIGFgscfv0REFyC4jJUkFQ+SiIO1oSnl+PNiPYbAlH1wxt5ago0ulLxzX4pAvXZt5iNAHfZp99b8rnvBvx8qmJtvbaGyYPDWbu/91a1skFs6+wOl2HuNjT8Mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5SvWaYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF5EC43390;
	Tue, 13 Feb 2024 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783824;
	bh=zN18JXm5wM17kjVxhbDLZaOyRkLOOJpLKw/kqy+PzCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5SvWaYe/RCD1rPkysHLwvufb5glVV6qZoBQ+P9TyE3GSKVmqckKDC8Ihhqf5mFJI
	 rSbHzQEfwqbmhhT8GP5h7wrD58k6fY8aIYaiyc+oj27l4dBklk/9gg6Ktvkr9EwOoZ
	 e3GaEjxF+HnJqGI/bZ6vRUs3JVnSm0foSLGKUkAT5dZLLQk0ph/rIWXAASiws/e8GU
	 oqFKCjxN/FgMGip7kczNCk3up05xcLzjIJW95GwdEYlyzzdAHzJPEMUKgazIQ8rJhs
	 CR/TEoYimtqufuoX1v5kfQbZH6MI/vgVqfI7Xtp0xrvQjlqePrzhBeqdl4YquSUOzz
	 5ZI5h17ARvgIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 10/22] fs/ntfs3: Correct function is_rst_area_valid
Date: Mon, 12 Feb 2024 19:23:12 -0500
Message-ID: <20240213002331.672583-10-sashal@kernel.org>
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

[ Upstream commit 1b7dd28e14c4728ae1a815605ca33ffb4ce1b309 ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 8b95c06e5a4c..6ba1357f3ed4 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -465,7 +465,7 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)
 {
 	const struct RESTART_AREA *ra;
 	u16 cl, fl, ul;
-	u32 off, l_size, file_dat_bits, file_size_round;
+	u32 off, l_size, seq_bits;
 	u16 ro = le16_to_cpu(rhdr->ra_off);
 	u32 sys_page = le32_to_cpu(rhdr->sys_page_size);
 
@@ -511,13 +511,15 @@ static inline bool is_rst_area_valid(const struct RESTART_HDR *rhdr)
 	/* Make sure the sequence number bits match the log file size. */
 	l_size = le64_to_cpu(ra->l_size);
 
-	file_dat_bits = sizeof(u64) * 8 - le32_to_cpu(ra->seq_num_bits);
-	file_size_round = 1u << (file_dat_bits + 3);
-	if (file_size_round != l_size &&
-	    (file_size_round < l_size || (file_size_round / 2) > l_size)) {
-		return false;
+	seq_bits = sizeof(u64) * 8 + 3;
+	while (l_size) {
+		l_size >>= 1;
+		seq_bits -= 1;
 	}
 
+	if (seq_bits != ra->seq_num_bits)
+		return false;
+
 	/* The log page data offset and record header length must be quad-aligned. */
 	if (!IS_ALIGNED(le16_to_cpu(ra->data_off), 8) ||
 	    !IS_ALIGNED(le16_to_cpu(ra->rec_hdr_len), 8))
-- 
2.43.0


