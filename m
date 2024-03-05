Return-Path: <linux-kernel+bounces-92678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D143F872418
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5CD1F21A99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF5C12C7EF;
	Tue,  5 Mar 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHTkWrqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A481292D5;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655745; cv=none; b=uhkLXYkld/bHntiw1POf6qGW4rFJ/0M/RfuU3PuE3iYfAXZQ3zQeLKyjXre5+g79bA8PpLaXv5JfuLK20EXQP+8CzA8JP19ceTKswzADRmxgsc3PoUBkVwmY2f8IunBqbraDweY0XI/r4GHOy+MkQ7qwroMgzMLgmZJWcajDaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655745; c=relaxed/simple;
	bh=i0LdvblO+6yEGrvNyUl2IAspDPgAsyM84cHs2Ob7qNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6bd2kGLHrDpeB4/Jf06fOw1EkBLrWvCG/8Zh8szy8rQIQpPrWb4e9I/faoQKpF0o64zd7UN/tQYLhCo4ijuip/3SBCzpl0inIom8SFFp0/3cp8sSwueRrUdTNtKUq+53M0Iw1sxTPoxLbKe3NY1wiVAf7fw+MuwMNGTlg2drzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHTkWrqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2EE4C433B2;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709655744;
	bh=i0LdvblO+6yEGrvNyUl2IAspDPgAsyM84cHs2Ob7qNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gHTkWrqeGU+opFYQuMjbHyMFAD/Gtyh9Qe0QSCuvKn0WW08RPe30ubbp/A2r5oZIh
	 2w1Cj25AXWgXed9uSEI1Wl5kSHyTZJOR7SeT1IuU0/ZjFoaYXEbwsd9B7VIcovho/F
	 QJuzFKTR4yPMTcTNpuRj1OZVt6DnfMT1AwQ0ArwZ0HIQndRQiDFXnRXMQbQpJEbjCc
	 VznEPFLUsEIEhGke7PSavt6RA4MEKxCIbcU8e/AiASWpboWXW05I99pruCANdYzVCy
	 tys0CDtGeqgB76haToO0dsRkblBNH8l0NxPYh8TsbDUVstVueKh/++ynUlSQtHPj46
	 ASfSByAY0Zd2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B924C54E41;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 06 Mar 2024 00:22:24 +0800
Subject: [PATCH v2 2/2] clk: test: use __clk_mux_determine_rate() and
 remove FIXME
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-mux-v2-2-92a5fa461fd2@outlook.com>
References: <20240306-mux-v2-0-92a5fa461fd2@outlook.com>
In-Reply-To: <20240306-mux-v2-0-92a5fa461fd2@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709655743; l=1658;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=V02NfOQOSUmVUo/qMJu9x6OdiFLOhTtTpAJh6FrUtjc=;
 b=s1EiXjZNeM8uWPA80SvuRGX7cXgQ1n/vcR21IzpPY6kl+V0gmKSPZLw7/+kes24ffoPgL/r/v
 P/w30J9+K12Aa4bh0csQONBp7dNdEOrJzCjmKsCyxwN5t3wa+MEl0kG
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Recent clk core fix resolved the bug in the FIXME comment. Now replace
the .determine_rate field back to __clk_mux_determine_rate() and remove
the FIXME comment.

Fixes: aebddfe2dfaf ("clk: test: Add a determine_rate hook")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk_test.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 39e2b5ff4f51..0c91dc14d942 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -106,23 +106,7 @@ static const struct clk_ops clk_dummy_minimize_rate_ops = {
 };
 
 static const struct clk_ops clk_dummy_single_parent_ops = {
-	/*
-	 * FIXME: Even though we should probably be able to use
-	 * __clk_mux_determine_rate() here, if we use it and call
-	 * clk_round_rate() or clk_set_rate() with a rate lower than
-	 * what all the parents can provide, it will return -EINVAL.
-	 *
-	 * This is due to the fact that it has the undocumented
-	 * behaviour to always pick up the closest rate higher than the
-	 * requested rate. If we get something lower, it thus considers
-	 * that it's not acceptable and will return an error.
-	 *
-	 * It's somewhat inconsistent and creates a weird threshold
-	 * between rates above the parent rate which would be rounded to
-	 * what the parent can provide, but rates below will simply
-	 * return an error.
-	 */
-	.determine_rate = __clk_mux_determine_rate_closest,
+	.determine_rate = __clk_mux_determine_rate,
 	.set_parent = clk_dummy_single_set_parent,
 	.get_parent = clk_dummy_single_get_parent,
 };

-- 
2.43.0


