Return-Path: <linux-kernel+bounces-155011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350E8AE450
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DF71C21EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588CC85C73;
	Tue, 23 Apr 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABrEVlbr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0D68003B;
	Tue, 23 Apr 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872406; cv=none; b=ucjxMfA7cz1FeXH2dAojRZyqUf7kRr2x0Lx04oUgjCn1MOIW0mLPho5yCjA2Nb08wBhCEFpypuCUOmQkEFLb1IDUloWzEVd3AOlm3etRs6jhU/GADqw/FUo+vzJPh7cUBiMeyaSEzcX1PNvDwA0YYvaOCYS+l2Mm5695LMflBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872406; c=relaxed/simple;
	bh=qkx2RDy5sGGcMieIR873OJNCriqJRBJBTL7GSFJbAhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prGMQ8SK6+qADzXV/0AGnkSTAs4IHSrCrtLo7Z7ndZlK7v/FeNhz3WPtL12HNbMY4wfokWJ2tF0JwI9BIhrGbibNesPkawIGCv3hmRVOdElKK1UIwDJoXdkg5EcioYXUjADlRA1Ifl31igX3YAXCIw3IjLyoEHLwe4CYm6A5ceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABrEVlbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5513BC2BD11;
	Tue, 23 Apr 2024 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872406;
	bh=qkx2RDy5sGGcMieIR873OJNCriqJRBJBTL7GSFJbAhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABrEVlbrxvlgM0b6LGyvu/00NWegrMFLXzubDoLfH3ULQ3M6//a9oyrWClP9nmoyJ
	 O/sY7GUozxUs1wt4wehhBCyctIhr5BXIB1pb8QpSXlTR+lflWapzp+N3NyKBnpl91Y
	 s8jvdSsL+AEMHcCoBvmz1ebPrO0G+c80oGskMisjNZxkadh5q1Eg4sWC2qLzZNjJ2l
	 UZbbGdjdEyDr3wf0D1YGTkbu2xtftMjyQR9E0U4GlnTu4arXUdgL6jeVDnFtnQVlEG
	 ObrnAXU8GPHoUiXE3fCREW6AT0XtppxlFqX3mp1P+PPbXV0miL84eKx8oMqvxvHN7M
	 408h+qiO8BH2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 03/18] fs/9p: fix the cache always being enabled on files with qid flags
Date: Tue, 23 Apr 2024 07:00:59 -0400
Message-ID: <20240423110118.1652940-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit 4e5d208cc9bd5fbc95d536fa223b4b14c37b8ca8 ]

I'm not sure why this check was ever here. After updating to 6.6 I
suddenly found caching had been turned on by default and neither
cache=none nor the new directio would turn it off. After walking through
the new code very manually I realized that it's because the caching has
to be, in effect, turned off explicitly by setting P9L_DIRECT and
whenever a file has a flag, in my case QTAPPEND, it doesn't get set.

Setting aside QTDIR which seems to ignore the new fid->mode entirely,
the rest of these either should be subject to the same cache rules as
every other QTFILE or perhaps very explicitly not cached in the case of
QTAUTH.

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/fid.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 29281b7c38870..0d6138bee2a3d 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -49,9 +49,6 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
 static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
 	unsigned int s_cache, unsigned int f_flags)
 {
-	if (fid->qid.type != P9_QTFILE)
-		return;
-
 	if ((!s_cache) ||
 	   ((fid->qid.version == 0) && !(s_flags & V9FS_IGNORE_QV)) ||
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
-- 
2.43.0


