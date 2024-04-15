Return-Path: <linux-kernel+bounces-145139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688BC8A500D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EB9286A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBBC12B158;
	Mon, 15 Apr 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIdI6pb5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA912AADA;
	Mon, 15 Apr 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185419; cv=none; b=Y4u3PVo0fFxpsfhF8v9p0/IaAUg6VWq6SnwlSK1YXWKUiIH+gV3U0hmkgS00znOUZCn+tUAhNv8EnFsf+GJeFWidar+QuU+PgR1HgANoLadlDOU1mSVUWjQIcxYdMLdOKmwi8ofbmT1C8hS1oQjsGPaHSJpAOlZDRN246HddwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185419; c=relaxed/simple;
	bh=Zb45CGiimLJ+iCFQbr/1dMX3rg5VTxcd5gnaZe4eH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IE6DuUp7Ye3QqH2Lh1LXr1h9ghvjixBS39cU7B5DgWFVTp44GXIgRhRyshRqhxUiL/FkWsymm9/CB8ZbskutC6iYWDCKi9XH6b2W6EiwMjCMwXk2QnlkrprnH4idetLA0DIAdUF9+vBAbvNzlzUojLkhIU/B12wK45PNHUJ5yvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIdI6pb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC338C113CC;
	Mon, 15 Apr 2024 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185418;
	bh=Zb45CGiimLJ+iCFQbr/1dMX3rg5VTxcd5gnaZe4eH/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIdI6pb5FN3Nw0yAnwcurLPqbbYZTvuq+BbsuLnRk0huNPcQvVu9BhypERlYVWFNk
	 /DBh2oTc1Ls+zWB9EH8qYP3pxzJWSmhWeo4/swJLsBS9tfF4Op0x1fcc3184brovQv
	 4UB7bRCj2RRVBYrroENwDdagC9C7AOXbvn/TEsnEH/0Kh6Jsg2NuSMxxYO+JDkNTLC
	 8reGPz4mgNk+z7EZoq3xqLV4Xn9JM/3Bb6Z2L8nk5shICg0maB0yroL1TgJk9JhwSm
	 eAnZ9//4cpEZceiCJyjE9WGL4JRVEuERi+n9kOScjJyO+M2vssU7F5ZIXuYG9NSOwu
	 /WYJlyCmPBsIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linus.walleij@linaro.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/12] ata: sata_gemini: Check clk_enable() result
Date: Mon, 15 Apr 2024 06:03:46 -0400
Message-ID: <20240415100358.3127162-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100358.3127162-1-sashal@kernel.org>
References: <20240415100358.3127162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.27
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit e85006ae7430aef780cc4f0849692e266a102ec0 ]

The call to clk_enable() in gemini_sata_start_bridge() can fail.
Add a check to detect such failure.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_gemini.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 400b22ee99c33..4c270999ba3cc 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -200,7 +200,10 @@ int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
 		pclk = sg->sata0_pclk;
 	else
 		pclk = sg->sata1_pclk;
-	clk_enable(pclk);
+	ret = clk_enable(pclk);
+	if (ret)
+		return ret;
+
 	msleep(10);
 
 	/* Do not keep clocking a bridge that is not online */
-- 
2.43.0


