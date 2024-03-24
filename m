Return-Path: <linux-kernel+bounces-114729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E748890CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E22D298D33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A071B49;
	Mon, 25 Mar 2024 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8EGJGmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BC272994;
	Sun, 24 Mar 2024 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323314; cv=none; b=kd051evwCdk06wqA3LS7jQuCJiLRH19n+j2cvpa9J6H7pPZC+q1fjsUC8I4TEG/U3yUHSrTaonJihIHkuJ+UoQ24SlG0ciISehl4IrM9X5puHQwTX4DNCcwUVCYd1lXmFWWQqN6cRFHzfqYQDboUDWNh03YWZPQyZkBLXp90kXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323314; c=relaxed/simple;
	bh=8VVwG/bIdg9aEww7zqF3oialBxlZZB4yvhDB3Q+do1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvEJYOmDVVewD0z5/4sxjO7+azIdGOduFjXn31BUfLFA+AnaxX5dC9E75jV7Ds5FIuVjtXRjR/5G6/9cJT2fIWzMylL7pjt7Uo7yyD0TGW+gpKwERJcG0DT+CFOAI2zJRbPWQADKl6aG7QC68QOXnhrOiRayFpMIiK360BC1Qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8EGJGmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AC8C43390;
	Sun, 24 Mar 2024 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323313;
	bh=8VVwG/bIdg9aEww7zqF3oialBxlZZB4yvhDB3Q+do1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8EGJGmJSNB3kznwOlcUS5hu+PW1u4J8TxlreTJlc+P2gGMT6ce98CClRumyVfwQM
	 GSlKL0jhF2b9JIj/bixd5Dr+xPlxR0QBdN1K6hFK8NzloqvgKS4ZQneR0fitI9s/VK
	 9Z8MthU2EfstMRgiZ0qVf6Q+ta+tjbqo9QfZp2N3WqruTTckeOtBTGodqDk5hvfpOe
	 OeVAJKMJvQsmqFA9njkvg8UTbqQfRZMvVM7aftTKkLAn/DjdzG/3NfVn4tPdAXgK8d
	 6LV59MWx9tLw8TcC4zZ4knEfwrs3w6v3/n9j4fTnajRvpDBTlttd5DkB3mDTwZQi3Y
	 S9izYY0l7f1UQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 013/317] RDMA/mlx5: Relax DEVX access upon modify commands
Date: Sun, 24 Mar 2024 19:29:53 -0400
Message-ID: <20240324233458.1352854-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

[ Upstream commit be551ee1574280ef8afbf7c271212ac3e38933ef ]

Relax DEVX access upon modify commands to be UVERBS_ACCESS_READ.

The kernel doesn't need to protect what firmware protects, or what
causes no damage to anyone but the user.

As firmware needs to protect itself from parallel access to the same
object, don't block parallel modify/query commands on the same object in
the kernel side.

This change will allow user space application to run parallel updates to
different entries in the same bulk object.

Tested-by: Tamar Mashiah <tmashiah@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Link: https://lore.kernel.org/r/7407d5ed35dc427c1097699e12b49c01e1073406.1706433934.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 104e5cbba066b..ef3585af40263 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2922,7 +2922,7 @@ DECLARE_UVERBS_NAMED_METHOD(
 	MLX5_IB_METHOD_DEVX_OBJ_MODIFY,
 	UVERBS_ATTR_IDR(MLX5_IB_ATTR_DEVX_OBJ_MODIFY_HANDLE,
 			UVERBS_IDR_ANY_OBJECT,
-			UVERBS_ACCESS_WRITE,
+			UVERBS_ACCESS_READ,
 			UA_MANDATORY),
 	UVERBS_ATTR_PTR_IN(
 		MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN,
-- 
2.43.0


