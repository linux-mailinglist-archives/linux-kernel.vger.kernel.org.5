Return-Path: <linux-kernel+bounces-62591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B5852362
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFA71F22A92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8655286A6;
	Tue, 13 Feb 2024 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAigndvP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE1426AD7;
	Tue, 13 Feb 2024 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783545; cv=none; b=LPenuWvrAfFTKKZrNZOAjtsJtvd4HatMTEUeUmezQsBOMqirb3Avd/nzFs5HWcBmTxtxHqdpQ5HIKDi8vFEv8ah/KCYdEcbGKYcNowKiTHBpx3jLS6/9kGBspms/WVr0sLqSXELZ1l6Z9/ZPAF6dizoZdJmmGmrlXve6rGhr8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783545; c=relaxed/simple;
	bh=W+YfOegjy/JoYcNfBZtMcJB1iWjTJHvgOOTHqe7Orvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKjsN22g+MgL8ssJ7sJ5aLv7VjcPm3j8EFPRsoJYu/J7ZQ3EXN9dbzEDyyG+TQzIr/PLSCdPbgOhRQp63BWr/xEOlBq92T99qWFKJWqHHhLNROe67kitg4F4Sf9qDWNkfNniq/HSXYvzs2khvpVXhMg0HUQU0/z5FcNuYX2T7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAigndvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F26C433C7;
	Tue, 13 Feb 2024 00:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783545;
	bh=W+YfOegjy/JoYcNfBZtMcJB1iWjTJHvgOOTHqe7Orvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAigndvP7odeca2UShe1zjfRwsec4Ao6hxxLX5lcqvWFycEwgl4ExVMjdDWSsmYQD
	 btvG2jfk/2Mg+jQ77GES/r1S0kuLGnmS0XGT804TVHJBCZ1Gglm+qq15kYmpXEb+jU
	 gpTBGfSIYdZr4tImwYa/fybcBoadW4E3Vm3ZsUW0ZYnP6TfouSbah8zn1QVtVovbGA
	 tusdMrJmsfnY92abYL99c5AW4xla0I41up+8FrePXhrOf0oybcNsJVed2KFzesN0uT
	 /RYNb2nIkwvnBK+tfHIkn3Gsu0e8s1/eACqzi1Eka50UA3cQWHi/2L79v7dW459JXC
	 jnoysIfdp4SOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 22/58] fs/ntfs3: Correct function is_rst_area_valid
Date: Mon, 12 Feb 2024 19:17:28 -0500
Message-ID: <20240213001837.668862-22-sashal@kernel.org>
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

[ Upstream commit 1b7dd28e14c4728ae1a815605ca33ffb4ce1b309 ]

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 7dbb000fc691..855519713bf7 100644
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


