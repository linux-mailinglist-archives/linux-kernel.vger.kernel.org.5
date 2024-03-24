Return-Path: <linux-kernel+bounces-115142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F0888E47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDC6B2BE86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C3301B86;
	Mon, 25 Mar 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tggs57mD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F6182706;
	Sun, 24 Mar 2024 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324156; cv=none; b=sh/nbfUhyQUNEM8ZNbmrRrbMZ7Wmz+2xWr1b2tfjH06+5DQtXIk24BF38VEvLY8SmuX6rOhDCLLegcT1n8RhGP+gs8rC1aFNN3ZfmSqSwl6s+M81l4b4OmgWOTVi4BDoEPw+N0C+Uqe8rG411U37bv/ey6mcjYAcxB+D1eSpIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324156; c=relaxed/simple;
	bh=raSnZxxYv+1ksNyxbMF21iR0NoR16Zg/SsHuOY0he4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBqnRMhKMuphwPkCSV6vlAGvTmKRZEPAmKHxPAu3yc2am3u06pVhCdrMJAB+FIgFERA5QbkrAcCPrLzx40kIZxpa9DnVq9lJI8hsDdeNte2WR0Cghk5FLEXvWU1M4+lLbKOrYS+DtD3c6xmlTzVozdWgFgwQXgQ/IQ2RF72S8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tggs57mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D4CC43394;
	Sun, 24 Mar 2024 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324155;
	bh=raSnZxxYv+1ksNyxbMF21iR0NoR16Zg/SsHuOY0he4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tggs57mD8huj06SB+YltfjMUSQkJnmTrr/Y38mNJWpJJYTZJT2WIOg1qH/IA3n21Z
	 WJBuyNZDRNOF/U3ZGLWwH+8Zc9I15eSrX5lU853b8/uqz3YBqCARY88AehVnB6bdwr
	 BE2Ixrf/KiQv37f2oW3zcI389W2kDd4NI+XtQc2FEYsbTWzLyFy3ckq87H/8IS3G4E
	 4zzLkDOkzI0vVJ15WnRNtNGsXSkDK3KIZ0d3SE1AVGIZshQuyZgnFk76LFAB8NlSkV
	 C0mU35rDrD85AbTIZI/jBgcwFPo+usB5hR2Mlv/IBGMjhbH7AA9pOL3d7FGxsbwPlq
	 ueMLOvpDCY3qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 151/183] clk: Fix clk_core_get NULL dereference
Date: Sun, 24 Mar 2024 19:46:04 -0400
Message-ID: <20240324234638.1355609-152-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 661d456fb0adf..67051ca60920a 100644
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


