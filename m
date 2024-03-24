Return-Path: <linux-kernel+bounces-115242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302D888DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E454290458
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAC1CD60B;
	Mon, 25 Mar 2024 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9SJDf2E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639721856B1;
	Sun, 24 Mar 2024 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324354; cv=none; b=IUezCdFeuhaPdpg7gQr98BIqzZmDZqk6zsgvFyxykWaq8FYgOwI9NaZA0bLToKofUZvIzD28acsHO6Er8sPFBKL/KS/6wh1E6xD8BeAqUk/F+X6i+xsgMg2LlS2kU7WP+/Jx4c/NpSZ7dW3+ZF8uEeDjJ/UP2ASgUe5wAjlTzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324354; c=relaxed/simple;
	bh=jmRt95aAvbdTkwPTFzoMRF6qwJaIm36qxy69NxlNjl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrhgOq/1r+IwB0Dp8kf6LZZBSxmfWwTleIvam8skgjy76Ey+385lJLxVZdoSFjcY52+znh9hyP4d7O0W21MOorewzxt4EqLx5XdLYyx80zwn6fsdoEL4RsAhgaH5uW+mE9XpVpq5xWuFIfQgOB/GLyiQjuuL0s3jjZthfiHago0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9SJDf2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCB1C433C7;
	Sun, 24 Mar 2024 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324353;
	bh=jmRt95aAvbdTkwPTFzoMRF6qwJaIm36qxy69NxlNjl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9SJDf2ER2DQdQDfLdramuO6j+Q8fMVFvwoHCLk4UpoHwPT24o9JDLe7nFs4mFwhA
	 ZNYKFq+RpgNfngZAh1kz8X/IKYHLvHApOqwtdFakXv+R0wgDaOR6PGu+E3H9eBGEpE
	 hZunZ0mPw/Wf409WxuvsTmN57L9bWAceNYKWKFWHBE/e1HN496J4YuzqgQPlPzLtcj
	 U1NCfl81yDfiG6c0v23i2A9y5bpLxMkEXd8QCWFf9pKzPASkjyAEuYJCsbq8o1fcTe
	 dd8oL2eIcqP05l7VEQh3iNLkANgiB2xaE3jEcbRgSUZdljxZ70ER6Ef//p8p5BIcuo
	 tnrJqZQc3XwfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 121/148] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 19:49:45 -0400
Message-ID: <20240324235012.1356413-122-sashal@kernel.org>
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

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit ad9aeb0e3aa90ebdad5fabf9c21783740eb95907 ]

The backlight_properties struct should be initialized to zero before
using, otherwise there will be some random values in the struct.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index f17e5a8860fa7..70f5ea5f210cc 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -332,6 +332,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	struct lm3630a_platform_data *pdata = pchip->pdata;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
-- 
2.43.0


