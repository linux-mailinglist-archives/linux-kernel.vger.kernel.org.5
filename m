Return-Path: <linux-kernel+bounces-114366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA4888A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D60FB25280
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C921EEF1C;
	Sun, 24 Mar 2024 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4gu9epe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6E216904;
	Sun, 24 Mar 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321761; cv=none; b=A4lPa31vI1pYW35zeSwhDb7Xq1Kfn4cqiGlJzv6Sf39aa0hkesiydjwE2WLS82mD71NtB1wYCda/vsMQFuBtki/LZVqkaunQLDBl9NVTZxG924mq9C3+/rotMhmu8QQM6HKdzk2nxvGhAhvoxj02tv0OYVdF1KxE7ZcLh9WE2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321761; c=relaxed/simple;
	bh=4PlkdmqB6yZ6noXjc3qFkk6SADhbWCGGBO9b/AhRtr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFY0TcuuW+J9PF5I1tnaZekQQFJRmYYPt1Pmyhr8GtHDXc17KrR6f7X22+bH/V+x0u3BaGeBh42W29Ns/7WLnrDaownBOm+u5Q2QEWTecyWArGTSmaZ/YLhSsF/ZFvr6yx0O9fw1vpreyNAcT0IOpFSuNA93MgCpo/k3LlGsF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4gu9epe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECCFC433F1;
	Sun, 24 Mar 2024 23:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321760;
	bh=4PlkdmqB6yZ6noXjc3qFkk6SADhbWCGGBO9b/AhRtr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4gu9epeenoorRwzk3rdwoJHMs8ti60uLTBEJdpYB+sp+dq7g9MVHQQJcgkkumitJ
	 awLJBKuJKAdvt/dKzTeoVYjMkmFfE4QfzP+JwbAQO1UITeWllQfp3uKaFCpRYcGK9i
	 mfz35RCi/OZS6oxc84X5Lxgkj8sE2SJeAnL9hGjhUrocY+qhR6i19TcSsoYY60ZmYK
	 g4EqKeqwBEybMUdFLpnAw/hDKEBAc+htVFuXkOOY3vLyxbY9josQqBZbsmZfMYLuNJ
	 3h0vNoFdBcgpSXxCJy1frUMcV2ETbwZmXzf/ojRK8lEK6Y9CvZ7ZUAR3NsBUwcT5Jf
	 cd/89Rylyw4Hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 488/638] backlight: lm3639: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:58:45 -0400
Message-ID: <20240324230116.1348576-489-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 5246c171497d6..564f62acd7211 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -338,6 +338,7 @@ static int lm3639_probe(struct i2c_client *client)
 	}
 
 	/* backlight */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = pdata->init_brt_led;
 	props.max_brightness = pdata->max_brt_led;
-- 
2.43.0


