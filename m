Return-Path: <linux-kernel+bounces-41754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0DB83F758
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD15C1F21309
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B005679E3;
	Sun, 28 Jan 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwZfER5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F47679FD;
	Sun, 28 Jan 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458450; cv=none; b=TbvpQKlVlqrzlvGVErnp2hF8pIp1TRAWcL5zeuCzWkUBIhKFQGTGpePaZuiSFcNEHmIYnD1LuVGp5n8/0EpoFeiAdZfwH0xIG/8SmFjDWNqtnV4ymYAYbH09nyx/KLrEsaCztujSCckJdXVJXXhk6Rj3h3FsEXDHLsPoMFCU7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458450; c=relaxed/simple;
	bh=dM9F9FRSH+8z+4gXHcvshjUeqW/w4s1Da/WUeWX3ZoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hP/TUPxz+5/CDtDfRK/VStxWxfjc5/334TQ1v9LUJE70RM8F6oPPrXFq/5qkwP8WJwk09nvgSc07kIeqbqSdSWILXUIGo1Rgr2xIs8he1EQrpTZ3rcRqbq4IFBbqkzPOYEdabmyCUSaq7hLJlIZrmvsQLLQwwtRxjlzM6iTcZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwZfER5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3562C43394;
	Sun, 28 Jan 2024 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458450;
	bh=dM9F9FRSH+8z+4gXHcvshjUeqW/w4s1Da/WUeWX3ZoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwZfER5IUFIy13buI8eT1GviVQifKUACPYfCdRwhMr9QSWfBJ72Hae9rXYVNytgQF
	 3ZXF0NxpPX5QCOnI7nNdfrA8hVGWKZ9XDRk1v8TQwzkvM8FMosQPPauQIcDVVZA9RC
	 /H0QCTYDf1JMNwqdAegQB37eOT/HTgy2qHV0HumGp5sjrUCPx6GgIwz0jGw7B6CNW2
	 5b0X9lLcb5YuAcjDSJUmRMHpT/RkPpH/z/Z6JE2IwrA5iom7c6hcuJaUUfkoNWwaYF
	 7gE9j4LqyxNagAN17CwitC+QvW1axr+v3yba6FRgsnUrPkDDT/GaWD8KMGEztOoJ6L
	 aEn0JIU3+5kNQ==
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
Subject: [PATCH AUTOSEL 6.6 30/31] drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries()'
Date: Sun, 28 Jan 2024 11:13:00 -0500
Message-ID: <20240128161315.201999-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
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
index b51224a85a38..87e9ca65e58e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2657,6 +2657,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 {
 	struct vm_area_struct *vma;
 	struct interval_tree_node *node;
+	struct rb_node *rb_node;
 	unsigned long start_limit, end_limit;
 
 	vma = vma_lookup(p->mm, addr << PAGE_SHIFT);
@@ -2676,16 +2677,15 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
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


