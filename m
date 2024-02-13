Return-Path: <linux-kernel+bounces-62717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E98524BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B300AB2352D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333038595D;
	Tue, 13 Feb 2024 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA/dCLS1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780585938;
	Tue, 13 Feb 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783818; cv=none; b=g4G0Ym1gSB7LbWrW1A9ovIJfCVmSpMLtrbpS34SFVeMAplXjeLnNpxZ8zdbKaV/OMhlrKCZg5dMJExUwvwEyXnZr4vVtSN1oyfq+qgoirOFLloQszoHhvo9kgzzEBwnaeHlyYyx1Asvj70L9V65hfLB8CaMGWtu1GtziJOjqYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783818; c=relaxed/simple;
	bh=5jdQ8ka1cAjXD4ykRdjthiJU48SgqrsTzGpdqupGmCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMF31R76VA/wSzF55swPm9obB+gGPoMiM9L+JBTSe4xj/Z8gjxOM+rE8jJgrATWj8aknhpVcsJwltv/YtUeJV/PJiN8uho3T5i093ZQ6EOtoWmHZKfBG633ooxrhyqtndIr3HARDheP4rJYSCxa9mPzMAfRB4StUorL7P7s6p6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA/dCLS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818CAC433A6;
	Tue, 13 Feb 2024 00:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783818;
	bh=5jdQ8ka1cAjXD4ykRdjthiJU48SgqrsTzGpdqupGmCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RA/dCLS1N2oMGE/jffWxkT8HG6RaHKrs4AKgqS+pV7/WH+ijlPI16FiGbgSoNjMLk
	 TlYKGSEEMADkcOMCHoEzNQpwaqMmVorVvfsyX06CgT25MhxN1woAyl+LMLbDxUCUTv
	 6DPaRFD+yASFMLft/UhlsjHNHhh2BFVwhggktvKX8Ba+pu0WI5WJzAJBxwF7IUYWfD
	 7ispEMIDlNU77zLVxjcZvRbQQVxSK2L/aUWiatdcQTCJPbaJ1mau3UXg2eT5U/2MRP
	 uzfTh+nO1Kt+9zqIwNJ/bjqB0ef61coTVCRt9AH5aVmW2K1mULUxEt7c9SPDJKvypM
	 cxXyS0QLiADhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 05/22] fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
Date: Mon, 12 Feb 2024 19:23:07 -0500
Message-ID: <20240213002331.672583-5-sashal@kernel.org>
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

[ Upstream commit d155617006ebc172a80d3eb013c4b867f9a8ada4 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 0f38d558169a..8b580515b1d6 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -517,7 +517,7 @@ struct ATTR_LIST_ENTRY {
 	__le64 vcn;		// 0x08: Starting VCN of this attribute.
 	struct MFT_REF ref;	// 0x10: MFT record number with attribute.
 	__le16 id;		// 0x18: struct ATTRIB ID.
-	__le16 name[3];		// 0x1A: Just to align. To get real name can use bNameOffset.
+	__le16 name[];		// 0x1A: Just to align. To get real name can use name_off.
 
 }; // sizeof(0x20)
 
-- 
2.43.0


