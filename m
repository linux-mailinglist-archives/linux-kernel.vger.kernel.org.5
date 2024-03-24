Return-Path: <linux-kernel+bounces-115216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C55A888DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D24A1C2A9B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279C295CE8;
	Mon, 25 Mar 2024 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4l/D5Bc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F993296BA2;
	Sun, 24 Mar 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324321; cv=none; b=r6ci0/iW+MnEIcnCWJ/abztLUktCyiClgl9JPeF9mLFlMbRoWYFjpkwTcbM+tZEThrnfLxC8A+T4R+/MC9POq2CBwC6LhmmPBLmNJ2JMFEF69SiQSCoOH0/osmDxDq169gVUtPWRDPra5tCc3VCp0kt9IHVx5I2PUO8nk9ekMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324321; c=relaxed/simple;
	bh=j88f6MVWIj6QWwWfbnjDtoeTnPFD2JD3YzW5KfJVf3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO7SERxzb6ZknVqc5oXRlc4U9NYxJ+KTNhHrTb1Wtyks2lGBlGICqIbN7zrHkxTuV87qnKbwvWehOMBO0aS5J1UBPLwsXH8DAZ7GMTPzVKM8H0kP4cWxwy0U79pj+wm+UPGlFfAhle/cbRcgq/o6YzcGX8itBrQ0QQpisMjyAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4l/D5Bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2293C433C7;
	Sun, 24 Mar 2024 23:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324321;
	bh=j88f6MVWIj6QWwWfbnjDtoeTnPFD2JD3YzW5KfJVf3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4l/D5Bct9FjdDNI0UfIiNAI2AHaeo3YFVGUafl62Za/pCyWwYRUND0oLBvcvVw7G
	 0xcjbsgh9Eq00UfXgxH1IICnfZuKiwKjKb+R7D2RSSx8OBs+OaJPvFp/cdpMYaU8lP
	 k2RWIXRaB/QEVL7MTq0I8UFvqSME1WIVIcAzjPP7NjCRJQQ/VMws0jzeL8uH+Za+rf
	 JNRpPDv28lwbA+ojCJfRGHQ+9t4TLNepvUIOLHc5d1z/CrbNVf4FQvLLfiJP+cr4vi
	 FXrCCZLMJ4ywtk9JfjXJgkbh9CBMcq0o2WI3c5yxQGtrOYAhnzSxFRsVGnNsQHhujq
	 oc7eNJChpKzxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chengguang Xu <cgxu519@gmx.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/148] quota: code cleanup for __dquot_alloc_space()
Date: Sun, 24 Mar 2024 19:49:16 -0400
Message-ID: <20240324235012.1356413-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chengguang Xu <cgxu519@gmx.com>

[ Upstream commit df15a2a59d0b29d86e17140b83ed231adaded12f ]

Replace (flags & DQUOT_SPACE_RESERVE) with
variable reserve.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: 179b8c97ebf6 ("quota: Fix rcu annotations of inode dquot pointers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 868936076f41d..683727c5758c0 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1743,7 +1743,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (!dquots[cnt])
 			continue;
-		if (flags & DQUOT_SPACE_RESERVE) {
+		if (reserve) {
 			ret = dquot_add_space(dquots[cnt], 0, number, flags,
 					      &warn[cnt]);
 		} else {
@@ -1756,7 +1756,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 				if (!dquots[cnt])
 					continue;
 				spin_lock(&dquots[cnt]->dq_dqb_lock);
-				if (flags & DQUOT_SPACE_RESERVE) {
+				if (reserve) {
 					dquots[cnt]->dq_dqb.dqb_rsvspace -=
 									number;
 				} else {
-- 
2.43.0


