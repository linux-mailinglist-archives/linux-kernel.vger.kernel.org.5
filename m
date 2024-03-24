Return-Path: <linux-kernel+bounces-113415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D3F888424
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF851C23B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AB1A7740;
	Sun, 24 Mar 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnuhDtmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9221A7726;
	Sun, 24 Mar 2024 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320217; cv=none; b=eTYThETF5tYhNhedOFgsqMTH46M4WvsJ/YQ1SfjmlqJfkkQK3E/cewBfYOXB07PqQKaJ3xkrdr4Rs7CECn+nbk594RbzXTEY0qT+r2jejFY7OTJdc5WOGtNrHzSpcM0A21C2h1tpwkzMnxRt8NMLgr4Lw6e4cVnoqfR0Io+uw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320217; c=relaxed/simple;
	bh=0Vfk3ggn0VG+zY76Y9T7WSrgxH+Qvl3xIAJjF9Q99Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEmadx6sT7qyy3Ke/I9NAJVEDGQpGl9/UVNroz8XAEX79mZjW6AyRjjV8fyV30gSMpvIv0lLR41FxYn1+HEv1iYTrixWdgUDVaPQTRlF8L9v0ZrpXMNVgNoVZ/H8fh3yeMXah53L5662G97Q89qMLwJjqU27Wld3dcaaBUliYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnuhDtmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B8C433F1;
	Sun, 24 Mar 2024 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320217;
	bh=0Vfk3ggn0VG+zY76Y9T7WSrgxH+Qvl3xIAJjF9Q99Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnuhDtmgQFcGyqXqULx2BdCSoCZEAF5dyWn15HD0LT0YBwL6xOJkr8KwkWW1Q7hM5
	 M/dKCGu3/f+DgPDJuabefmWQAUzDgWJtFwAwJJXBcfYBRwNDzVh42c57bOBOXFxQSC
	 oOPIgmNBF6WGVlj4ePuV5jihzwzOkk73ZbU6vONJ8JR+rtnuQcjLqqjt/wH8sKpVkf
	 Z/dIClzyhv3KcmUN0O+J9ioTW0Jk/zc2RLaw08i7AoL6EfGJz2tbMM6EZEeEHMA2rE
	 QPm0PbLgrF04zB252d8HHf2ziIBjdXdALnQOaRuJ4EXVx/t2MXTetnbPyDmiXkhYTK
	 sED/vPXDUmtcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 524/715] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 18:31:43 -0400
Message-ID: <20240324223455.1342824-525-sashal@kernel.org>
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
index a3412c936ca28..8e275275b808f 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -343,6 +343,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	const char *label;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
-- 
2.43.0


