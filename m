Return-Path: <linux-kernel+bounces-113404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2452788840E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3442868D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1021A50F6;
	Sun, 24 Mar 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfEw7QwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561491A50DF;
	Sun, 24 Mar 2024 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320206; cv=none; b=Yk9+9STRYlWp2gjXNKEi/84l+spwDF68rBCyMWn0L9sZ12izZT0Ni4kavK3jtnLZfZAuKdFb5CmJa83pN4odDB4fEpJBc6rk+LOoBEg87lmJrcXoqObQJmP8nlKNgu+MDXSAGqJGUHt6HqNQlLQWreqDwFT/I6ySnajF1wFAoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320206; c=relaxed/simple;
	bh=5quXF4FdgTJX7eNpmboTLcTJhuBwuYS8glB/aHDKKD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Svq+JMCGimaF1bremMwuZ1JEL3eBh31eM+Y3qHPtj/gZP41j39zPKk9KDoLR7hIMO5sRq0/Anu4vU14QXgpbCuotfFV0FncVRlpHu6IkTeNfMx0PJIh8x/QLJDlJhBImmWK6BVOQdY71C/VNx7fQ12biIWP35ArGNDlbn0gTVYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfEw7QwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A407C433C7;
	Sun, 24 Mar 2024 22:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320206;
	bh=5quXF4FdgTJX7eNpmboTLcTJhuBwuYS8glB/aHDKKD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfEw7QwLVwfzBZ+4b+OPofR1j5evLsPFwrWAKbpfFhuJBvwPXxy7JJWa2c7uWcwud
	 REq61ScBVrwZbz8tkMdFInb8ecfgvgBP4ZD39zd5ru9h89bUo7qpYUoEbda5nPCRdQ
	 uUxKar0eZKrN2RHz+OhWCDAvAs6DyVw9aSGtzaDwKrad1pTXTp8p339dUFU3V0KS3a
	 wcDQkbBzfamAXRXfFTAaYU3fMNzZPU4HxpYZ+9djo5kV0D1Nu9NLcQWpPja77qEgLP
	 iMs6EDP2cNr+NEsmmkljkPq6X3fGHRvM+mj0NE2FP7MHscijbf5yNI8OOs0SX+Tsny
	 HWJZfO7KLQWLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 513/715] lib/stackdepot: off by one in depot_fetch_stack()
Date: Sun, 24 Mar 2024 18:31:32 -0400
Message-ID: <20240324223455.1342824-514-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit dc24559472a682eb124e869cb110e7a2fd857322 ]

The stack_pools[] array has DEPOT_MAX_POOLS.  The "pools_num" tracks the
number of pools which are initialized.  See depot_init_pool() for more
details.

If pool_index == pools_num_cached, this will read one element beyond what
we want.  If not all the pools are initialized, then the pool will be
NULL, triggering a WARN(), and if they are all initialized it will read
one element beyond the end of the array.

Link: https://lkml.kernel.org/r/361ac881-60b7-471f-91e5-5bf8fe8042b2@moroto.mountain
Fixes: b29d31885814 ("lib/stackdepot: store free stack records in a freelist")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c043a4186bc59..c1ec2b4b6dabf 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -490,7 +490,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 
 	lockdep_assert_not_held(&pool_lock);
 
-	if (pool_index > pools_num_cached) {
+	if (pool_index >= pools_num_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
 		     pool_index, pools_num_cached, handle);
 		return NULL;
-- 
2.43.0


