Return-Path: <linux-kernel+bounces-41781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2483F7A2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B121C212F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F253129A7F;
	Sun, 28 Jan 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azOleIcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0294CB5C;
	Sun, 28 Jan 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458514; cv=none; b=G2xLXNfE6E6UqJLd7cwf2tYYTiFyHQIZdNY35qZCYZdjaUc3XmSMqEu1oz/kI5PJRja+KbJsryzXyizAugPjG/mBUoDXpk67uxUe1ztY1LMKPNI17VoOmtxRHioB+Th6ZlPo657W9rr3uum/XJ2IfFOc5kiafVSehpJZVPWI5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458514; c=relaxed/simple;
	bh=NpCssRGcPw6Ho6Q1LNkhGIO2w4cpnGoDPuYXWBLOIns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PM5BRzYWKQZ7TP3vdVULHkf7Bu9ezjEg8RUZ8mANirvIBEzxasCIlNDxe14ai9nIDSmKbTZrnHZ+Pd7GcUrFKt4hHagDz2TlkfIAUJzxPJ6jfr4PfBUWkyLgOVJT1D94LQ71UpepuxT0wbMWMXnijxyRBg+82CT0/NFnfeaXZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azOleIcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7F5C433C7;
	Sun, 28 Jan 2024 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458514;
	bh=NpCssRGcPw6Ho6Q1LNkhGIO2w4cpnGoDPuYXWBLOIns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azOleIcHycB9c7GtudfTyKsscHRfNYAoli3++BuxP+QXi3mhKmACH1YiUE2BE2zXR
	 ic9bUNaUV7YGH9PVCpsrc40Rh+7F8PWuLrfwqiC4lXPbvwNSykZgZnVeM8tQuEg/yL
	 1xaNFh2QzWHrPnK+PDUrKFsT48L+7+HQwioHLnL7YloScd40abazok1ekRfbO4w7Dn
	 oSnE3Da88w5jzr4wLgT2wXlpuR1uYPBQ0sMRNhj3hRpjJNMBfgE48gIyuirt0SPF3q
	 B3eMCambfS12iluXTQITaBBpTe3/PN10Z9PkLuJG/KoHvu+tTxetclB/hG6nIxIs0J
	 rJC+6HBhRvbug==
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
Subject: [PATCH AUTOSEL 6.1 26/27] drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries()'
Date: Sun, 28 Jan 2024 11:14:11 -0500
Message-ID: <20240128161424.203600-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 5188c4d2e7c0..7fa5e70f1aac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2553,6 +2553,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 {
 	struct vm_area_struct *vma;
 	struct interval_tree_node *node;
+	struct rb_node *rb_node;
 	unsigned long start_limit, end_limit;
 
 	vma = find_vma(p->mm, addr << PAGE_SHIFT);
@@ -2575,16 +2576,15 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
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


