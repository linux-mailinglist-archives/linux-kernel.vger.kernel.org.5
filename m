Return-Path: <linux-kernel+bounces-115529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C35889C31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DC91C32F88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C41241070;
	Mon, 25 Mar 2024 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjVd4dWY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DE11ED706;
	Sun, 24 Mar 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320986; cv=none; b=NcDIL0+Vnvazq4C9nVcgH5vdl+z7IZL8MXjt6bqfjkI1xult1rGZGVFGQr9tZlHlltCAOEz17jYsgbVMnjILJFzcEfTfeLmNdAWnCmpYqGZclvFrA+n+vz/8GDUa1KH1PK6JsDdvYLJJrB8S6Ez4uZTvq7VWRZrKstyHYOuIBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320986; c=relaxed/simple;
	bh=lMDwXgjBgx1W6oFjiAwsW9y0JAZStVheK4KXw9VyuEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBer/Gsbe5odUhChJrHhQM//aCuwNSLGQRD6b7atWHfxqH1Js31Syn5X23at9bhBxggQONNWhfZCn2IAL+mgOUCpXQK44ZD5BB+dUfOnrEE7og3QegJOOUWBLZ+IJidBuqUCkVG0qZ0bstlJVm0UyePoWIq0DP8AuzqzGl3IBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjVd4dWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E5AC43390;
	Sun, 24 Mar 2024 22:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320986;
	bh=lMDwXgjBgx1W6oFjiAwsW9y0JAZStVheK4KXw9VyuEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjVd4dWYPGJha9hgiC8rWwRGY0k9y1bDyhqOcWKnn3pc/Q9L7xmEsst4ScnJ4RF7k
	 xHhEQ5QUt9cp07RrMI8hKBe9uW7rlyHJWo/siI47r59rYiE2FSdamp14ufX2jvMZWX
	 yJ7Xv3e2XGnAOLdX9v+Nff+BXpDRCnHaOXp6vuU3++amtBWWjAGpbQGeBIUphLv5yC
	 xdx2hA9Xv2bYECqj6sgyulMLhXt7HWLAC5MkyO7pzRIIGpNwe1Yjt1Fn2SjaFOb9eB
	 Cm5aoYxc0U6s7Jzb50QxVgbUaR/9GYUt4aPKLsi933+BU5UXsBSoBMjO1ewWC5E5j0
	 XI3simW/ukuLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 549/713] clk: Fix clk_core_get NULL dereference
Date: Sun, 24 Mar 2024 18:44:35 -0400
Message-ID: <20240324224720.1345309-550-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit e97fe4901e0f59a0bfd524578fe3768f8ca42428 ]

It is possible for clk_core_get to dereference a NULL in the following
sequence:

clk_core_get()
    of_clk_get_hw_from_clkspec()
        __of_clk_get_hw_from_provider()
            __clk_get_hw()

__clk_get_hw() can return NULL which is dereferenced by clk_core_get() at
hw->core.

Prior to commit dde4eff47c82 ("clk: Look for parents with clkdev based
clk_lookups") the check IS_ERR_OR_NULL() was performed which would have
caught the NULL.

Reading the description of this function it talks about returning NULL but
that cannot be so at the moment.

Update the function to check for hw before dereferencing it and return NULL
if hw is NULL.

Fixes: dde4eff47c82 ("clk: Look for parents with clkdev based clk_lookups")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Link: https://lore.kernel.org/r/20240302-linux-next-24-03-01-simple-clock-fixes-v1-1-25f348a5982b@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a8248..20c4b28fed061 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -418,6 +418,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
+	if (!hw)
+		return NULL;
+
 	return hw->core;
 }
 
-- 
2.43.0


