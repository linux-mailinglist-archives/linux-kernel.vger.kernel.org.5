Return-Path: <linux-kernel+bounces-124786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB42891C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23FA1F222D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF8188A96;
	Fri, 29 Mar 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbQ7xpxp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18708188A7E;
	Fri, 29 Mar 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716140; cv=none; b=NSRGo3E0anNIzcrzZFpHaE5ZD+DqSRO2cMuozQ2ffE3H57vulHt2yB+lZC6IWnpJIyEXkdkzEIVHnOTHICL4k1BGXVcN4AZATr2Fk5+OxyjfpcxcNbfHi7iNjl7wTqEa3jPTUqGdOz1lO0ZLVPXBlqGWo78jrgVs4OU+ZsSpk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716140; c=relaxed/simple;
	bh=nzUqvTnrnZZu0hffpYlA1dzFj49gKFtl/K2Yj1yQ5ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1Na9UYfQN6HN8EnQQzVSyKS/CVPzJlLnj1fn4PseLFmslcICjRnSvErUAIkA3FxM72SlOWlUMej5I4oTlklyRCm2Zj3QRj7nEgtmqhSoA+TblGqseEPUmDkE/iYaExoUKz2NeaDu1c5oUJwjxXQ6c9YXnsOvUf8g60bCnau3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbQ7xpxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24B4C433B1;
	Fri, 29 Mar 2024 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716139;
	bh=nzUqvTnrnZZu0hffpYlA1dzFj49gKFtl/K2Yj1yQ5ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbQ7xpxpiM1ZLyCJC4sXCxkwcOWcWOGRCfzEkmv1pHUdvb686eM5sZJgSFwBdEPh7
	 6zDkAc0gAy1yqWUb8fx6kRroZ2jYfVqitQBEofg7aW+hTiJBO5HjUiruNgHvvNtv3n
	 khOaU6zgdQIariesrXtd2cx5Ao8me9+yRqDFd5P1n/sQN2+s9LQ+/4O+PD1xUV17bT
	 TM8QqiIc1x3TQHMEYFeGCJisVooZOw0gAVb3sf3BsGc7QRHX7wRA5yWMIWI5EB4EEr
	 YELRroQk69UmtjO7evnn9eN3V4FJDO+2vOROmH0a/4SmxDQi4ih1bEF2oJM9ng/8zS
	 mC9/66xUmVsZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 76/98] input/touchscreen: imagis: Correct the maximum touch area value
Date: Fri, 29 Mar 2024 08:37:47 -0400
Message-ID: <20240329123919.3087149-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Markuss Broks <markuss.broks@gmail.com>

[ Upstream commit 54a62ed17a705ef1ac80ebca2b62136b19243e19 ]

As specified in downstream IST3038B driver and proved by testing,
the correct maximum reported value of touch area is 16.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
Link: https://lore.kernel.org/r/20240301164659.13240-2-karelb@gimli.ms.mff.cuni.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index 07111ca244556..e67fd30110278 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -210,7 +210,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
-- 
2.43.0


