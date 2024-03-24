Return-Path: <linux-kernel+bounces-114606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A5889082
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B76291CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6B1870CB;
	Sun, 24 Mar 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsxNZpUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83515E201;
	Sun, 24 Mar 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322263; cv=none; b=CwCU7H6O1UpTe/HDJG925yQ1uKrVr4zicfCJkWjAgpuO1SWLUbRFTvohFStMybedUatmz/JjusOqhcvc2+okqgIeGytKF9hST7oxtQfSBJE8Nq0wGE5Y4XQobv81NbzZYqVUDdFCbdTIqYI2WxCKWQhR44gmwF2a5Y8jEOOYWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322263; c=relaxed/simple;
	bh=WmDERopOBJ/AkiQn5WK9ud8tPBDWlJkX5I8iDlIKvOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBlZynfoLtJGIygqsT9Wef3n6onwJHIdMDQlNe0iotTE+YPkAffzLlsPtq4ui5cTzu+XFMZcDx+quRcE5pG/7+Br+oYZ8+0L659E+RqRU5GWG9wny930zbxAqQpEijgQGYF469MeVrYG8gS7HHHseoZMKobRtvd5HieEVEE5NeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsxNZpUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167BBC433F1;
	Sun, 24 Mar 2024 23:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322262;
	bh=WmDERopOBJ/AkiQn5WK9ud8tPBDWlJkX5I8iDlIKvOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZsxNZpUZ5mOO/VDQnnE3Vg2CrQsv7R1h2zo3bb8QcPyXf+dG2zuuIe9pB5/9cSF/D
	 tktb4js108Qr1DEyHQOVG4SxuXK0b29gP3tsO6qS+23JiBQW4vH9ySbgXLzlHzIj/D
	 PUNHMd8I3VNxTb0QIP3YenFdbiNMEx8QdodD2xg2qPyiEXDs/fn7Hv6zqpjwfpd1pj
	 h8c1amZJl32aN42xF6uUr0ngTefXesZveF4h5BhTS9XWQslm5RW7gT1buItDXSE3+U
	 4qSWuKjMHlJ02pfajBWOK2dDVWJabDBA4c9okuYAT3ZWso9uOFn36y+6mrocJg+mjI
	 z4zVYg7ucc+/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 345/451] clk: Fix clk_core_get NULL dereference
Date: Sun, 24 Mar 2024 19:10:21 -0400
Message-ID: <20240324231207.1351418-346-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 33fedbd096f33..9004e07182259 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -407,6 +407,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
+	if (!hw)
+		return NULL;
+
 	return hw->core;
 }
 
-- 
2.43.0


