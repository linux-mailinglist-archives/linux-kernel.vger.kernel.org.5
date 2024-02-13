Return-Path: <linux-kernel+bounces-62694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC61852473
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B731C232A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208787995C;
	Tue, 13 Feb 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQqS1Y0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6180A79924;
	Tue, 13 Feb 2024 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783768; cv=none; b=lKMoNWSPsse5gsJ/Oc6nk6FNpSAuXnwZb9BILQgkYaDVdp/Xlg7XHkVLR7X9CeeFw8qoOin49gvNSJ+STqNalw/1f/3ljxx1kIzx8Mp62l9cyqXZBjozwQao0nVKPlG0+9Hq6g80T5CZgDt7wllk1YYv+pdez2TfMVZE+hrmF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783768; c=relaxed/simple;
	bh=DM/oJ02iFG+93phrWttB18O9CbwS834Lr4C862I6x90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAFKAXMDm7J23EZlwMyDcCPvNoJdGK4gnb8PwcM7tinEThO/ueSH6m65TzHgZF9zjd+yOmMHaM5HQHGhdeyvkBmFcu0pyYZJ8+TTF3zWZx5ymOKwxkoXLAxv1oAN/8C0NG3cGUFjmOWBOjxCOuALh/8qYqGJX7T2oZIAjibjQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQqS1Y0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEE7C433F1;
	Tue, 13 Feb 2024 00:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783768;
	bh=DM/oJ02iFG+93phrWttB18O9CbwS834Lr4C862I6x90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQqS1Y0mnC7zvIGFW+yfYEe6xkYeDqlBrjt+dvl/aPefbAXBhtFJt9fAnjiNR9Sg4
	 HG89o7SqJ0YD8BfhaM7YKJR0EvHb3KcyewLGh2r/AehynEE2lm9YFb7G/+91vOazGr
	 R6Q1XtM9MwzAqbTUFm1g7XJaeHb/vykdm9VV5LsdLFd/pjeD6Q5oq3X25QN+CZIW75
	 f9dZKmQk31F/AvoBkkr1wcCIy4ALcvFrAT8MunU9ENY79FX7xTH5WYVAMss5HL2WSo
	 yrVM0IKrkNoUFALKzy1UkW9G2Ms00WcErQ2BlZzKmfbFR5vNI/riGTj2NENE8aHbLz
	 POIQqRBcRhUGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 10/28] fs/ntfs3: Correct function is_rst_area_valid
Date: Mon, 12 Feb 2024 19:22:08 -0500
Message-ID: <20240213002235.671934-10-sashal@kernel.org>
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

[ Upstream commit 1b7dd28e14c4728ae1a815605ca33ffb4ce1b309 ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 710cb5aa5a65..d53ef128fa73 100644
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


