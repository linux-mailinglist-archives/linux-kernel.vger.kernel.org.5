Return-Path: <linux-kernel+bounces-116342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0F8895FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492631F30B28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391329C6B9;
	Mon, 25 Mar 2024 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrDZPuNt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD292987B5;
	Sun, 24 Mar 2024 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324358; cv=none; b=PB8pW5U+x+kqdM7mp5v46jDkAihlJND5G8u4/Yu34zERxy0IyswY9htObYKB5bd1DB9lzyjuVAJ8DZSFIylSy/CqW18grN7Rv/WduKLIrUMxNedfdqf6Udv3GP1/xGz6jeGU3o+oYLlYnALL8s8x+gSuR2UsLsV+w2yv44irpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324358; c=relaxed/simple;
	bh=rhiYJP/xlTwzaguLze3wKiFu10IAp5Eb8qurPQwlfeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuPDhd463sJf95bVNB6SRwgY2L3vGw08uJZS8k2Qej5cPVGmO5dJDi/5l8gjWW2zKMdqPg6XVP4YpitnLDysOeaK4kC4xllIl6BoXsJ+OQijN0/ZS1v5C/ihCZKyN0QnHcONOMjnqiRZ2Ko23luFgIqV75sfWyah9p6430V59JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrDZPuNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDDAC43399;
	Sun, 24 Mar 2024 23:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324357;
	bh=rhiYJP/xlTwzaguLze3wKiFu10IAp5Eb8qurPQwlfeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrDZPuNtaQFUDIbSjDg4znz7opOUq4GvIGIHQegi6p4+W8I0OFV18nT+Jy5jIvSGL
	 YycwIKbXI7ghGoiYBwYYGBmthG651nG8dIUqb8ONPehSLv1EizEuH101czJIfzL9yf
	 /T+WMxe2S6+M6sIIiJBiy8Nl2TvqS3nLrc0mrqyf7C6zLoc3UVAj/RWtSlTcm1t4Jv
	 d2BWFPUkbLvKrgUt7vlDHKZQCzIlz/DonwxOTOePHL+dhkKDJ4F7IBginA52hJ//Wg
	 P0g64X9b5FUJ0JB3Y/WHi0IsJ1dNnE5Ty0+T86wc+lTrFmFsWM+cdwFCy6mVw7KXkt
	 9IhNATjUUmX8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 125/148] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:49:49 -0400
Message-ID: <20240324235012.1356413-126-sashal@kernel.org>
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

[ Upstream commit 392346827fbe8a7fd573dfb145170d7949f639a6 ]

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: c5a51053cf3b ("backlight: add new lp8788 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220153532.76613-4-daniel.thompson@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lp8788_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index cf869ec90cce8..a324423f30474 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -195,6 +195,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0


