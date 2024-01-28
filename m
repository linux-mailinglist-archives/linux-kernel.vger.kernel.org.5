Return-Path: <linux-kernel+bounces-41720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86F183F6F8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75240288951
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DC459144;
	Sun, 28 Jan 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tY0dEH4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA1E58AA5;
	Sun, 28 Jan 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458379; cv=none; b=Rh2TykeRd+dwHIyxwdu3ISusgVwVvnZf/ZLwA+IDZ9//hT6UvTiWdcNf2jdvukiTRiUxRKy3Vj5Jwej0aaTi54xUUpxfd6pbFefgNgXIXfondQppcI0XSQAiZrhn/8dip4Qhi6uuIRZlQKW/a+27RirKD19mEc2FHOh5nFwX1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458379; c=relaxed/simple;
	bh=pQa7YpwrQOyq63PQ2Q7ZkEOrrI8ZRQA0RlDWMSvtQYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni5HmCA9YKyd+p+G58Bm4oBLxbN0mf5K4Cmz4kHGggXv3K8hk15WEbeWu7P32dWMadNTxsydcCqLKpMxH3LctUVxduZHGqkQrISaRB0XG/6CQRIdtNEiV9tyUweigsJB1Ss3VKTLNFWRYgLvfsE7nQmlKy5nJeHpWn3w+X8cjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tY0dEH4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959B1C433C7;
	Sun, 28 Jan 2024 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458379;
	bh=pQa7YpwrQOyq63PQ2Q7ZkEOrrI8ZRQA0RlDWMSvtQYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tY0dEH4kImexMGykMthxLzgThflzchCcg51EbA5oy6Sp6qlrrGOTC2v+7XR5he4Ci
	 LRz9yy2m61/pUK5WGRBw69urAakQ1ERzRyax4Acd7PI5LxrxHAkfeEAURMYd9qM1Or
	 5dIRxIrsXMj3oT6mMATv4JVjvAJwAR/3xjHLunWO7DaIp/kiFxTT+JT8dCqlS7YoOA
	 7QyT5LJ3KGfTTUim9ORgBc2K2bzqrdIeFJnwaAjG2CVtOa8p9/FqxdccvRq78ej7sY
	 EzmycjbI/onoPdmjFaO7/0Bb+XaqpAUs4DMsCYMJLUstw2K/kja00/SFPVmayCu/6g
	 o1dfkIiDJT78Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 38/39] drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries()'
Date: Sun, 28 Jan 2024 11:10:58 -0500
Message-ID: <20240128161130.200783-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit d7a254fad873775ce6c32b77796c81e81e6b7f2e ]

Range interval [start, last] is ordered by rb_tree, rb_prev, rb_next
return value still needs NULL check, thus modified from "node" to "rb_node".

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2691 svm_range_get_range_boundaries() warn: can 'node' even be NULL?

Suggested-by: Philip Yang <Philip.Yang@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f66f88d2b643..9af1d094385a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2680,6 +2680,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 {
 	struct vm_area_struct *vma;
 	struct interval_tree_node *node;
+	struct rb_node *rb_node;
 	unsigned long start_limit, end_limit;
 
 	vma = vma_lookup(p->mm, addr << PAGE_SHIFT);
@@ -2699,16 +2700,15 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	if (node) {
 		end_limit = min(end_limit, node->start);
 		/* Last range that ends before the fault address */
-		node = container_of(rb_prev(&node->rb),
-				    struct interval_tree_node, rb);
+		rb_node = rb_prev(&node->rb);
 	} else {
 		/* Last range must end before addr because
 		 * there was no range after addr
 		 */
-		node = container_of(rb_last(&p->svms.objects.rb_root),
-				    struct interval_tree_node, rb);
+		rb_node = rb_last(&p->svms.objects.rb_root);
 	}
-	if (node) {
+	if (rb_node) {
+		node = container_of(rb_node, struct interval_tree_node, rb);
 		if (node->last >= addr) {
 			WARN(1, "Overlap with prev node and page fault addr\n");
 			return -EFAULT;
-- 
2.43.0


