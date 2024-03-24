Return-Path: <linux-kernel+bounces-113274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38052888303
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC368B2252E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE7518B60E;
	Sun, 24 Mar 2024 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtARr0iV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AC18B5F9;
	Sun, 24 Mar 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320075; cv=none; b=P5JOepunnznsPfKH24xoBsuSJHgqXkErI9C7NHOcqI4lITyU/Ew0gjpVFsPgq3l7eNpelCR/4dp/Umoqt+vh6FLj3O1lpGSfhWuUeegR1rZWObIVndKbsc0gzSGQbyBKaM5ZlZUItklDz3CDzpVKtoVsyZqzQ8gxei7d2X3o6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320075; c=relaxed/simple;
	bh=15la2HOP4BZJOz/HljR3aeBvlmkYLsdL1e3Rm1CDSGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV5G+XKBjO5M+tse11/WGtVf/mtVot4Lw65cM+wRIsyILWTA+K1fODXWRQ7czcOFAy8FB2Zd03Yo+OSuG9FH6g4QO6B1Y0JUz00b64PWN2g9kfJTuLuDpP8XFLUbUckRidfP9YWMssVly7lUbE2GgwwqqQYzYNlY/EgatKz7iVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtARr0iV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDAFC43394;
	Sun, 24 Mar 2024 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320074;
	bh=15la2HOP4BZJOz/HljR3aeBvlmkYLsdL1e3Rm1CDSGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtARr0iVN/PRXk2IkwtzM0z4zN9KaeCYaXP0NzSbJVG4n43uV2NvtmwpXXBQG2hgg
	 1wB/aFfU+h68dc9cAcP0sHu0AJk2LefXOQbSVUieL9TFDbYtpKTWGDWjakz2QtJ0tU
	 rEViXvk7vkUqop9wMiw5hs1YPe+/ozFPhaqZqip3wM4UHVxWON39MvAsdfwTdgyA85
	 nhtpi8PghTqpLVQj8CmgNE6rvWSmckekGfkjIqa/Tqhkc/el5wlh0cZuk8p/cJ6a54
	 aO7pT+7JUN+3eq9yjndJL/0qvw63d0gCu9ZyyffFuaClm3IFJmeCUXjTK5xNdxR++O
	 XkxH0qqqBLIJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 383/715] ASoC: sh: rz-ssi: Fix error message print
Date: Sun, 24 Mar 2024 18:29:22 -0400
Message-ID: <20240324223455.1342824-384-sashal@kernel.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 9a6d7c4fb2801b675a9c31a7ceb78c84b8c439bc ]

The devm_request_irq() call is done for "dma_rt" interrupt but the error
message printed "dma_tx" interrupt on failure, fix this by updating
dma_tx -> dma_rt in dev_err_probe() message. While at it aligned the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Fixes: 38c042b59af0248a ("ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://msgid.link/r/20240130150822.327434-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 14cf1a41fb0d1..9d103646973ad 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1015,7 +1015,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					       dev_name(&pdev->dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(&pdev->dev, ret,
-						"irq request error (dma_tx)\n");
+						     "irq request error (dma_rt)\n");
 		} else {
 			if (ssi->irq_tx < 0)
 				return ssi->irq_tx;
-- 
2.43.0


