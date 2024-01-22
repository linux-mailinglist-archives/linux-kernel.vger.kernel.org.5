Return-Path: <linux-kernel+bounces-33282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A06508367ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44E01C211DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C9A5B5C7;
	Mon, 22 Jan 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZpNLkNB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83095B5B5;
	Mon, 22 Jan 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935598; cv=none; b=Bjx4wWKPLkTp/FURnN2IXEaMZgjUmlTRTXBV5ZEJnClk7Yz/M/DYJj0Gi87HyAxwiBlmcoVgilJPYZQnsVh7ZHZQXn0XqOh+4eUILH3SZ2LgXZzR6smnBSkjwRjWRAoVOrOdo5fYyoYwWUryC0dxJgHWSI/qQwVYAC+R4NrmaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935598; c=relaxed/simple;
	bh=gi/zS+FijJoacGOzitI9u1y72nJ7iavRiUxAwlBWS9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n81xX3Nshg0/BJleizj6SnpkevfmYCHLec+Y8H5gg8YtbJQYh8gdH2zp5VtaxhuwRpwCNU84JT15lIqEGZH81RATtcA49YtkkKE5olnAN8WYXF3RdjAMRHpcSQ5Y0sMM5EUxJJhuIHBpWNGZKKlRIbT/WYlvPn+M8+ede57LE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZpNLkNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C7AC43394;
	Mon, 22 Jan 2024 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935598;
	bh=gi/zS+FijJoacGOzitI9u1y72nJ7iavRiUxAwlBWS9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZpNLkNBoACItLuRQxurK1cVKfDWora97NdigFlPqST/Z7VOI9VXIlCCjSadF4AT3
	 Vt7H4VgNwFxAVukK1G/GGaTSvX7kP6NfzFRSJs43dN+na1ErT4+uJrWPXPxX/deN5h
	 4IqthMVrTmdJ7v7vWLnAszY/ylOKjy0/iAC9Xo6q4R3yEOteZs7chkFbA53vLz4L8q
	 ozAwNWWgmadUahcnshs98MZNSzHzeTgughisyyi24VbnXBjdf6G9xU6FxtKiDOMuOl
	 zFAaX/FSrnetY2Av+YfizlgQusMmZWhqrJ2v6WxY0oSNPvpR6BMENw+89A06ycTvMd
	 7k6UhoYe+haeg==
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
Subject: [PATCH AUTOSEL 6.7 60/88] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date: Mon, 22 Jan 2024 09:51:33 -0500
Message-ID: <20240122145608.990137-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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


