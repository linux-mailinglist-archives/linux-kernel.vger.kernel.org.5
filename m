Return-Path: <linux-kernel+bounces-116201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A74889D73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3094F1C351C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D51290BC2;
	Mon, 25 Mar 2024 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahdN6Q4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E417CF62;
	Sun, 24 Mar 2024 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323812; cv=none; b=oZlGZmxjAyOk5T3R5ZLOKVntxYKrQxbPffZyuZnCHCJnF2oNCASZNG1ZUw7RbX/UkOIx2cRjGBOmklCmWrnedQeV23s5WAKF7HwSwzkzxUBxvXfkPn1wj6e/efVjubrAJkBj6GRNCRdEBOAZLvQPBDMQ4qdTNnFfrNRSrQME3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323812; c=relaxed/simple;
	bh=c11w0jzUesCGbhTP5ywTHIqFThlwXA1KhgSKdpQ7Dq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5MpuEv2Z19H3yZSXTaIgluoeASk9ELXyOpfku5aNgt5bQ4wEVAOkrO1pYVLueRjedFq0Wm29SryGEZCqsgLfd1yFw44rX84F7iKIi1JBUwWeJXtW6E6NTp9wAQh8WHLnD/cDeovO9xw66xd0xdYNyYRkWxsxqxWOdYQNYn8bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahdN6Q4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34203C433C7;
	Sun, 24 Mar 2024 23:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323811;
	bh=c11w0jzUesCGbhTP5ywTHIqFThlwXA1KhgSKdpQ7Dq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahdN6Q4itJe8ZqizwOqIxSJ1aa8MLBflVzQRIz2oXOzCVfFFWumJlnYPSf/BFIk68
	 fDxlT8CqX6LVU/5F1wRCTkYZG/DNAAS8TsQPzyjcf8Fh7D9xSe/nybQnGGBWMbh+sd
	 ahaQ3wlapafgS62nJpCeF9NEiOJsP8QlXulR+gD3jIk/SqmfMbOMViG9AFE0bLch1w
	 9XWzDWZdw5JAimqeY8WnXOSkWFwPtW52MOAi9KDJOPjqhmOAam582uMUe1fCuJgro3
	 2L2tV7VrYUXSkmiSUIxZr7selLRCiLXmYa+9/5d+GSYfvHacrl4NvP0ndCuETIFZEd
	 wG6vduBCI3GAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 190/238] clk: Fix clk_core_get NULL dereference
Date: Sun, 24 Mar 2024 19:39:38 -0400
Message-ID: <20240324234027.1354210-191-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 62572d59e7e38..aa2f1f8aa2994 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -425,6 +425,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
+	if (!hw)
+		return NULL;
+
 	return hw->core;
 }
 
-- 
2.43.0


