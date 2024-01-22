Return-Path: <linux-kernel+bounces-33376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083CD8368F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA751F24B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B026E2D2;
	Mon, 22 Jan 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnUZxFU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDF6E2C1;
	Mon, 22 Jan 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936037; cv=none; b=ChBFq0pAVuL5i7lBIe6jVirXy3QwTTctA2KkRkJACJenbLp9lt4srfRv1zAh6ZfG5lOStBOmGU2XMoVV7HqWCqO9bJJvrj9MLAmBu0zG0IeQDtV6e7YZOsgV/mywC9aDy+Azl21EgPCAVg0T8VZ1sU9W7CWqPEASOqHhudGX7UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936037; c=relaxed/simple;
	bh=gi/zS+FijJoacGOzitI9u1y72nJ7iavRiUxAwlBWS9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTItRP7+GPJxT+nVIlRSLWbtUSfaNaD9+bjsAKj9UwMB5ti6Y3Z9Jwzq8EYqUByi5IY88rZocYk2xmTJKERpCQ2yqE4Uzy+oZC5HHKrzYLFwvilfXHXVHMRohZJDHPTgxveRznwyCAVOsO0CtyeTBTM1tcs38ZiP1ChYukoRyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnUZxFU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89AFC43390;
	Mon, 22 Jan 2024 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936036;
	bh=gi/zS+FijJoacGOzitI9u1y72nJ7iavRiUxAwlBWS9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnUZxFU1Kavc+oCxcqg+OK/1lKB193vwZ8uEx3oIisart/W5tNer+wd+EmDbtGhyu
	 YHZ4DT0Q5afmi0zEzOAdCXmeR7uOvBOQc1msGK1D+AIzHdb+ObfR09qto0skaXytXd
	 5WYrlMLgUFWUiCiwPUzpjvmgGmw21zwyuW5M8gtild3ySU7JOOrer4cNnf6mNDl7LC
	 9cSLZp/qLisTsEpUJ9SZSRQkiwt1vvn82fE6LfnKnIugrLCuuFR8jhWglAus5Yuw2R
	 pIXzb0P8FDaXek3SnEOuhEiobpYqQYLDx1uZL1lZMIXHWcoFeTFv0fut83Xmvpcw1F
	 tFyfeFXi+d+zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	duje.mihanovic@skole.hr,
	conor.dooley@microchip.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 52/73] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date: Mon, 22 Jan 2024 10:02:06 -0500
Message-ID: <20240122150432.992458-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index fb0df64cf053..c5a7ba1deaa3 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -308,18 +308,21 @@ static void __init pxa168_clk_init(struct device_node *np)
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


