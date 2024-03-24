Return-Path: <linux-kernel+bounces-113425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB21888438
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790DB283CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D471A929A;
	Sun, 24 Mar 2024 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpbaADs5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58A1A9280;
	Sun, 24 Mar 2024 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320227; cv=none; b=U8e788cCiAMMtNzYNA5v/Rt70R4uANwydluNputnkyafV+vUZvWrlNRp5tPHLvKoFmLpiLnvzpVT4o0sPMFiy8j0QeRCfAyBzItTPLuRSw6bFtnEegqXx37xVjvAzpK+IQa/vJVnFOd4FzV9uXT+7hyvazgsliwtE/ZJxiSC+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320227; c=relaxed/simple;
	bh=lMDwXgjBgx1W6oFjiAwsW9y0JAZStVheK4KXw9VyuEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkY4B8ZGcDnI2BErSS49NGvAxwRMaAn5f4AazTMWJtoNge1D/UYrnejbIL5NmVNZHtM5r3fqetXm6kY3ekrsNqND+IjaLF90EYWtrCgjrE6AjmQ5WDGigUlkCiYlOSvORq1Gz+e5sSzm6AGRicrUyb22mRdR/H+QsJ+DeI1ewtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpbaADs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E880C43390;
	Sun, 24 Mar 2024 22:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320227;
	bh=lMDwXgjBgx1W6oFjiAwsW9y0JAZStVheK4KXw9VyuEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpbaADs53AwIPksvhfmA0Q3EGq2ZO1mRFMxhuPwp7FFcZPkbNmBjzA2yXLEdEErIw
	 42ftwfg5O4K5RgI+1nHruVNy0+w0YiIhveKC54ZM1A90adI2z9IkuJYWTRIxFNh2Tf
	 89hoqf2QPlQHyxdVDl0AND6FLIRJvI2ELagyNtTxiy5JQODOVZpWnmlFxquC5E1FnL
	 LTEDvy1Xh10wAP4nn0uurWmqxxNpoG+t0Me8iUZKlhYTQOgRkSYj/R08wZo//bUE+3
	 9sHJIzCQyjj9g74qwRwrpEHnv7vdoFbFhuSnary/k8Cs3LwujGu6D9/JIINCZY1seR
	 brVi0pWPspkEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 534/715] clk: Fix clk_core_get NULL dereference
Date: Sun, 24 Mar 2024 18:31:53 -0400
Message-ID: <20240324223455.1342824-535-sashal@kernel.org>
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


