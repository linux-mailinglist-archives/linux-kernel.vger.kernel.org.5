Return-Path: <linux-kernel+bounces-155029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8F8AE489
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E501F21BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA7413B583;
	Tue, 23 Apr 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFQ/omUK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662F13B2A0;
	Tue, 23 Apr 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872438; cv=none; b=jtCFIR2GBUE1yzNVvAXQSNxlhML9lO9ikTDi2rMi/VqJk49NKCqg38lfKzab9853H1E3iCtiVIDlbi1NqoE7O0z5bM1tSHeDHY6kWcRYE+63Fnf3OQQ5PXo+3QXyHDVa5RwA6+Cwz5olzEhZOyBS48h6bQRYkdAOFY6+8rAXfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872438; c=relaxed/simple;
	bh=qkx2RDy5sGGcMieIR873OJNCriqJRBJBTL7GSFJbAhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCliyl0c9oukyuo/Azk9eeP6aAnQvGHudklBRgfhPb9gR3LMiVkeWo/Q7SjrCY2bYjGTiJmv/IV2/tZaMOmlU7dmazL4YbntKiSxAn3tripINzXh9RjupW47wzgfgyUnXJsy0McUOnZORbLuK3c6OPq2M20JqefUm/aAn5inITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFQ/omUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8C4C116B1;
	Tue, 23 Apr 2024 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872437;
	bh=qkx2RDy5sGGcMieIR873OJNCriqJRBJBTL7GSFJbAhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFQ/omUKu8zWKMCkOCjNQc73Pwl9NxkWwAS2iZa5nTfwolyMDzBMoyOIDM/gJFcJ/
	 je+lPb1RyrU/oP5b+mz/VtABHcf1yzPWF8LPghlN7TD2s+EcBXAZuHkdJGM08Y5L96
	 Or2wSK3+Sakg5xfsgXoKZ3CFIMwekz7iU1LzQNM5I7r1UR/hKA7MIeC7LM6ObuxJ2r
	 76CCGk6TdhkxQq1TsAXuRTIEtS/FEqBSERZZtDES1CWRG7qA3hokaRlX4Ndlky0jUr
	 20UFjFo1Qf6qP5kneQo9ZBBCxA+bNbJ8SOGzbrSQaDOlUZH+4wmyKPHs0o82vOIvEv
	 oKzbPcUGyPeGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 03/16] fs/9p: fix the cache always being enabled on files with qid flags
Date: Tue, 23 Apr 2024 07:01:36 -0400
Message-ID: <20240423110151.1658546-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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


