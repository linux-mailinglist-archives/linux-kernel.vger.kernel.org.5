Return-Path: <linux-kernel+bounces-33519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3B836AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC4B283D96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC1144628;
	Mon, 22 Jan 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFcRNIa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C556464;
	Mon, 22 Jan 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936586; cv=none; b=jyTT1ki88T7IIbSSJFobfIdIYuoPO4cDomHD2SnFBiGkl0N5fJCRdfrs7GJHxRxrwODlcZ0wvdtjO5i+/fpaENp8B7MW3eHWrOPZOu+qfYaix7gHd4P6XdEIzlEmUIVzd+Gl14vtFtqxeNvZnrSEhIG5wxgAywzrZ42V/FYqRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936586; c=relaxed/simple;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O303oiBSBiKKurE906ytPVzR6/nH3DuUu1c0pzitijZcBTVo0Vm9UE5iormKJ9koarlrMMxMWl+wsEVMEzsGbhSuMrynfOILPZ85pVzjHYeWFqoNdPNp6qS7nQcHwYT28PdnmumCmmRvQW/7m9VPSaeC26l+B79ykyMz5eUSRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFcRNIa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF7DC433C7;
	Mon, 22 Jan 2024 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936586;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFcRNIa1E50p6b/ichbiKorBkcc+Aekk4iARnQm3/P4YfphY1tkW1PrlTXe9gWXv0
	 oHMm9FFCVOLNXUyDvq6d4G6MZyh/Esw7hLXCcBRlehA9GrwrKRlMkWaFLRkFyVIUwE
	 JKtWqYTjTyalIw2vxNC1qyBc9ZDqasd1sfD4rbufcYKveP7l6hf3cWdtBeN1Iuz+m1
	 EomNm/eVm+J3ujSwLL1W2OUfqY7I7m/qyPJBDUqXaA6C8ncKI84pONJRLWfx0vyCN5
	 wMirXLtFTdXIOrdaEQnvod1j8WIc3CVAdUnoQ+Y4y16ZNs2CkFWWvU5TyN9RPl9FJQ
	 Fh0NnHkkPYSpw==
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
Subject: [PATCH AUTOSEL 5.10 24/28] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date: Mon, 22 Jan 2024 10:14:50 -0500
Message-ID: <20240122151521.996443-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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


