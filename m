Return-Path: <linux-kernel+bounces-115972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D510F8898E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755FB1F3350E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8AC3949C5;
	Mon, 25 Mar 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8cSYEND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0814D43D;
	Sun, 24 Mar 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322259; cv=none; b=CGWX1zIdojWgq8a2JdKjje7C+xbGH4WSJZm4F8Af/U7hIfNwswaI1sSj1oKlOSu5jeOCKtrIZODpJIMhHEyHUfvTNk/yHKufmKy4G0lKDI1z4V3IOZU/QbxEW/96/m3TpW4MQk/lkZIa5zsz3znlaSiYYIYVf08RQScr47FVvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322259; c=relaxed/simple;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl3DANxNSsJlhynzNnTzWkcqms/hGUkgErqt5A12mEcjU0wySZTDqv1NUrBvaHaWb/Xl+M3VfQ/oqGzKmDgrRCJPoBKWO6uYiXfxRk3QCyoa3ijqiddx6K0n3x9lPaX44/TvVv9bzCKjZYm4xCJIw7XUI7b/HuOWWPul4gMwjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8cSYEND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE83C433F1;
	Sun, 24 Mar 2024 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322259;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8cSYEND805U5KXFutCFxoVK3fJnWzQ/eiijMN9GkY2fn58SqHmf1/PmhucMtRBf7
	 2L6bCrktq9KqrlY6PD3tVI886824ZiO20In26osZDSfq0XFMJEsjgAXPHAEdvhyY9I
	 6K9YtfLUV+p+w6PdIbB39sOht/PWzM5uQsNW1g/2ed196Z9NFOJOTAiZq6TfDj+947
	 EwiPdoeZ4YxyGTO26OLA8NoqUS8KOjuW/p0enRQkJ38p+hxURzOBwXjrPL5i1xXlsv
	 CAItREDR4jVG8K1+FmNYFKRUop8WHkHoVEKWJpiayJABsFLCudTjLwrxj42Op+4Asr
	 ReG2/x7Au0jLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 342/451] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:10:18 -0400
Message-ID: <20240324231207.1351418-343-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index ba42f3fe0c739..d9b95dbd40d30 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0


