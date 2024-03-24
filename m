Return-Path: <linux-kernel+bounces-115249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87CA888DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329B628FEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E021CDC11;
	Mon, 25 Mar 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UArEJsp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83442987AD;
	Sun, 24 Mar 2024 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324357; cv=none; b=Y5QMrENMdsLrWBllmcHZo3YtnTHH494btFLTu7rIpU3ZRo4MfZqV92HPjI2xhtDciRcxLtYYjpPmEnKA60zBCSuWO5a+OrtHy3ByM0s7HzqCYJnETJ2WUTR1z3hqIiBM8SE+BkJJPaeEtDjCPK+RsVl/1QC1mKh/zeY6j2hOHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324357; c=relaxed/simple;
	bh=6rOZkmZagTxGbIEmQSiU6HaHcxpk7MeTr4EpEyA+xUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4kSVvfhmo1muvP54wm15J5um1jiGHOF7WQpnY0MNmcPbt4EJENwPDMOepeGcT8kC9WkkzfM4OE3zj0ZE9GtbPjJGs/Rkljudq102zgKqZwJXqpECzwYxmYunpvSq2aYEnLHQIlRTE0+7DRULVslQwcKihTwqdO9BFenIG/8Q6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UArEJsp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBB4C43390;
	Sun, 24 Mar 2024 23:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324356;
	bh=6rOZkmZagTxGbIEmQSiU6HaHcxpk7MeTr4EpEyA+xUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UArEJsp8Zm7H/U9Btu2YMIrDMZ57iKlrOUeifnww+5vGgk4VWBCSkkFQfTHinPibN
	 Rq7E3IhzfPwuqJVzu8OYhq9hqUscMUwGMVnNBqsjcp4cTB7DrTddgziOaPKK6OFSWh
	 Y+bWfOcl+nCdAH2CPe44O8pJj9iyE/aUQtDh0G+dCYmh4nfTfOlTQX+YReJDpuba7R
	 NmsJznjD59peiTqCRsFtwiaXmZQrHucWs0hjqTN1g5p0ODBDXrSmcSg5qffqpKzM5J
	 xEw22YC9xOgbhtKgrqaHQlN5bZSJHtCe5tEsD51U+Le8At+UhkSFa0EUr8WZzzSVNE
	 yIFFqFajWB1ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 124/148] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:49:48 -0400
Message-ID: <20240324235012.1356413-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit abb5a5d951fbea3feb5c4ba179b89bb96a1d3462 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: 0f59858d5119 ("backlight: add new lm3639 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-3-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3639_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 086611c7bc03c..a1ef6f23156db 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -343,6 +343,7 @@ static int lm3639_probe(struct i2c_client *client,
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


