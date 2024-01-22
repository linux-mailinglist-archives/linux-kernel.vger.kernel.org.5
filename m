Return-Path: <linux-kernel+bounces-33486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF374836A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787D32812EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F1135A6F;
	Mon, 22 Jan 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJRMCSSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885B135A7F;
	Mon, 22 Jan 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936474; cv=none; b=c6xnNuRBw8cxWPQBBu9eoSjwh2hhQLKB2ufCy6UWg0YjlJIV2t7Nz9TP7beJNR4qkV91ff0coyg6DfDHO6BbXubJpw4WOmNP7d2JBTNT4VduTDOYcpG9e7VnwbfuFwCNuV8m97WKBXwnm/w+oFwNCnIIjLNTGRuwIJIO4C2KJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936474; c=relaxed/simple;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgpjgFdD7J4cJZn48YHCZQF7Z8kIzaEJXeIC4FuZuPUatbUmrwG/Q3wswdAJp9teP5Wt8rgIrFUciIy7zDaHFp5Nah82pywvoPbC1vJjNOU7gdRXREVfLnLikLgoEwlX48HtG7As7IiPdkphhRumj5FtUFeHqtvaltlLKXPr6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJRMCSSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B756FC43399;
	Mon, 22 Jan 2024 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936474;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJRMCSSZTRuRMOhn7clrFiUnVGTLQ5JYwfl2U39KModixW7a+2WjiQtPLnh15uas+
	 qsuitSgWZzmwrV93j/RA4JJE2ltSCeTpwnRI7EebeWr6gI91tHfOBHm+0SU6m9wdDi
	 bIcUOTY7zzVoNZxSWk1GHrxodZfNg6QhvnVABY4PGR9fWjxm9QZ0Kr+Nd0UYnA0+Bg
	 xbOJnrO7jsCBuxJEXFQgyfiQYXM5BK5YgWEEm0CVVdpIbLJw9VKbStPhA1f8hzMATm
	 I7IuE45WHOBrtsDFiHVakQEavp5Eyto8szgrCK/oPTVRR+O3/2frGQSwViVSePcSAH
	 SCwSYG1cGEK5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	conor.dooley@microchip.com,
	duje.mihanovic@skole.hr,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 28/35] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date: Mon, 22 Jan 2024 10:12:25 -0500
Message-ID: <20240122151302.995456-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 2fbabea626b6467eb4e6c4cb7a16523da12e43b4 ]

In cases where mapping of mpmu/apmu/apbc registers fails, the code path
does not handle the failure gracefully, potentially leading to a memory
leak. This fix ensures proper cleanup by freeing the allocated memory
for 'pxa_unit' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20231210175232.3414584-1-visitorckw@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mmp/clk-of-pxa168.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index f110c02e83cb..9674c6c06dca 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -258,18 +258,21 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa_unit->mpmu_base = of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apmu_base = of_iomap(np, 1);
 	if (!pxa_unit->apmu_base) {
 		pr_err("failed to map apmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apbc_base = of_iomap(np, 2);
 	if (!pxa_unit->apbc_base) {
 		pr_err("failed to map apbc registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
-- 
2.43.0


