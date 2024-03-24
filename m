Return-Path: <linux-kernel+bounces-115018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41C888C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4016F1C2A0BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9851C1303;
	Mon, 25 Mar 2024 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn05a89H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E028452D;
	Sun, 24 Mar 2024 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323786; cv=none; b=KfjVmkyp4DbF7pdIw5oNbob2JNK2gQZfQ2JdgbL3/aylOqEpL3Il8x527u8Lewx8v1h7RPMoMbOahWruc7UK61umByzPt2tbdPF2iadvQ5S6XYnNAOogmMGWSBq4nWVGcTPvFI4VfX5TlMC+p1xvzl9UBLIqrUz43GjNCZYzdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323786; c=relaxed/simple;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEg0I/IeVlkgq8Ys+CGlehhIFyiHi2cR7pRbYt/4f6/uBf/j08+ViEL6LNciCCy+yc3Fp3OR1MMZAXTpMa0SukFw45ZIFscB4tpd5u6udNu6bo2UJSLh5+kGrFTHAzX+UhKRbPH2D2xlVNhsR3Nv0KFR8nQ3rGeqwB8+vHIWmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn05a89H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314FFC433F1;
	Sun, 24 Mar 2024 23:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323784;
	bh=rNDijfEyC5ir0j9HjxxEwdGbtVG4058Sq8QzGTqaCdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hn05a89HpiMO4DA9nrlbCSJS5TWfP2JDv39N4dYZc4ENDpIZvr1BThMR8kB2DL6DT
	 ZStOR6sNhTV/JFiEMBpEB4qM3fXrHzlIrObqUSuwuQ4agz/EINDHLxiMHygkNWHp7d
	 FQzgmNQbUfIbh/iZCO3GIBOmO0sVrSyir2TuHrQmudlIq8WCnhsIHMhVzf39LfXk8t
	 JDjVMvgEhYasKNjvvVdLW6nPlSL44CeHx4UVTK7niNuAkxx+PFAK7W7uRdwZh+2dcO
	 984qY069g436619uxVdSk32oewsCpFtBuvztFaN5cgrF6BLUrMQ8Qp50MY6PIj8WFs
	 NMkeRz4xVleGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 161/238] clk: hisilicon: hi3519: Release the correct number of gates in hi3519_clk_unregister()
Date: Sun, 24 Mar 2024 19:39:09 -0400
Message-ID: <20240324234027.1354210-162-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 74e39f526d95c0c119ada1874871ee328c59fbee ]

The gates are stored in 'hi3519_gate_clks', not 'hi3519_mux_clks'.
This is also in line with how hisi_clk_register_gate() is called in the
probe.

Fixes: 224b3b262c52 ("clk: hisilicon: hi3519: add driver remove path and fix some issues")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/c3f1877c9a0886fa35c949c8f0ef25547f284f18.1704912510.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3519.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f350cf03..60d8a27a90824 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -130,7 +130,7 @@ static void hi3519_clk_unregister(struct platform_device *pdev)
 	of_clk_del_provider(pdev->dev.of_node);
 
 	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
+				ARRAY_SIZE(hi3519_gate_clks),
 				crg->clk_data);
 	hisi_clk_unregister_mux(hi3519_mux_clks,
 				ARRAY_SIZE(hi3519_mux_clks),
-- 
2.43.0


