Return-Path: <linux-kernel+bounces-62273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85C851DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDCF1F23141
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4246B8B;
	Mon, 12 Feb 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyM/2gMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789004644F;
	Mon, 12 Feb 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766259; cv=none; b=ZS3zNBQfOAA5r29AI3MUR+V7ZbBGp2ygX2rUI0fMn5w1RLDrNnFeHeaoabKa4QftdMJqUQSCrFs5y/F3JIpt9G0etAgZW3TFkNT4heYOfQGVSK7bJkbMmmvmTEVhdvbEfHkY/yGwRkVrdtCIzXAvDrE3XVsMqUSr0Evr0AGKUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766259; c=relaxed/simple;
	bh=/rhBDl7xe1E+WL+owZXps5bvP9Vg6PrEijQUZDpqhSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oaclM9k8gphJ6EEh5lX+R3wYwMs9+UaadIlYVaffhl8c+y/AM9MDp0F/31r6HJDW8EvCC/5zRocAStdawtmIMpeXX14AGe82kJ5Ea0HQNiw0VJYxbNFsQqKTu2BO9e6LqQzClDn4AHOCdZNQb5I44ckqlvijQi/oww6S6OvFwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyM/2gMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E3C433C7;
	Mon, 12 Feb 2024 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707766259;
	bh=/rhBDl7xe1E+WL+owZXps5bvP9Vg6PrEijQUZDpqhSY=;
	h=From:To:Cc:Subject:Date:From;
	b=YyM/2gMBKPR1BY2Dhqzeg8KnJA56etjOSCiimzNdDy7AkF8yoy1JYKjc7HNc52NmO
	 2PdesYd+VB9mfzxKCmlFbLQopIzt3P0GZtfpn70y2GkatZ8x7n8RDM4Yu0yRtpY1uU
	 RFnxnSsWx1gNlnAKxL/deJo4N4qDi/TRtRHn/qBAGsVpymiy9RBMzZcht6iXbklamk
	 Kx+MckCcNetqMOwJ8fp23wFO7IS34ynvBf6Sv5RgEQASzum5JvuhGm8yxldUqyttZo
	 +ZC2CWYABXCvpy+1WAA7+iyQjwdRUEEskM8onLcUwKR6Iq9nOwGjz5sbcAo9GglJj4
	 q3DUdMiWr8QKw==
From: Will Deacon <will@kernel.org>
To: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ricardo Koller <ricarkol@google.com>
Subject: [RFC PATCH] KVM: arm64: Fix double-free following kvm_pgtable_stage2_free_unlinked()
Date: Mon, 12 Feb 2024 19:30:52 +0000
Message-Id: <20240212193052.27765-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_pgtable_stage2_free_unlinked() does the final put_page() on the
root page of the sub-tree before returning, so remove the additional
put_page() invocations in the callers.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Ricardo Koller <ricarkol@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

Hi folks,

Sending this as an RFC as I only spotted it from code inspection and I'm
surprised others aren't seeing fireworks if it's a genuine bug. I also
couldn't come up with a sensible Fixes tag, as all of:

 e7c05540c694b ("KVM: arm64: Add helper for creating unlinked stage2 subtrees")
 8f5a3eb7513fc ("KVM: arm64: Add kvm_pgtable_stage2_split()")
 f6a27d6dc51b2 ("KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()")

are actually ok in isolation. Hrm. Please tell me I'm wrong?

 arch/arm64/kvm/hyp/pgtable.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index c651df904fe3..ab9d05fcf98b 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1419,7 +1419,6 @@ kvm_pte_t *kvm_pgtable_stage2_create_unlinked(struct kvm_pgtable *pgt,
 				 level + 1);
 	if (ret) {
 		kvm_pgtable_stage2_free_unlinked(mm_ops, pgtable, level);
-		mm_ops->put_page(pgtable);
 		return ERR_PTR(ret);
 	}
 
@@ -1502,7 +1501,6 @@ static int stage2_split_walker(const struct kvm_pgtable_visit_ctx *ctx,
 
 	if (!stage2_try_break_pte(ctx, mmu)) {
 		kvm_pgtable_stage2_free_unlinked(mm_ops, childp, level);
-		mm_ops->put_page(childp);
 		return -EAGAIN;
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


