Return-Path: <linux-kernel+bounces-124920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829AC891FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B4B32CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F214C598;
	Fri, 29 Mar 2024 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl8Kg3jq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038D36ACCA;
	Fri, 29 Mar 2024 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716432; cv=none; b=I5UC/EG77yjyKLJ2n9Mccbti6caPQ0qSo0a4RCuyhwMpSI6ZWbsI0pzbyLaBmvYmiP25UJp1Wf6KWK/OzpPnFFw2gPpvYXjIGFkJSCEekM6r9kQiTOWmZUTdgQEwp8zhDIXiwy+InbjTVJNufGbHKHt5juBPcgf46l0NwXZogjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716432; c=relaxed/simple;
	bh=iYeY20XcboZyv15kHL+2YC404iUv3HZCguH9uan6L2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmMPNWX1KMkqIbKDVABvKwPVWD88P6CWph048b1mq/RIsj/HCgA7e4UxzW5434eIGBd1bq9hjg0fusbPG/c7Bi//EYm+KU1sRySZQ/xiy0hUDaBiPVapYbT/vZ/hlRCFD7LNaGMMVKsKOzOjhEVdUspp/e7lrc/dBUbjb0YE0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl8Kg3jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65877C43609;
	Fri, 29 Mar 2024 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716432;
	bh=iYeY20XcboZyv15kHL+2YC404iUv3HZCguH9uan6L2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dl8Kg3jqpKDiQg+ffB01F+mvNGSjGXn42TbPWP86hUZMADAeXqSa7ixDLM1ldcXFe
	 DTZ48YjsPX1Lm8Gy86Ypuq0Ktxu42/FLiXHIhZ4EgUjGBzdP8L0NYv81V4WcPUG/la
	 f5wTjFxY1O+MPS5MNJSvy921/RWxf95yfvzEqX/0zV64ULlP676C55VOrQvXU+m6FA
	 jAgY6QW/xck1FEKJry/fq2OiSu3UkWpmvy8KEsrQ+dXxeBbnja1lK0jSL654PFfAlx
	 NzO1RrwGXArpnrSWnDCqnWf7YpczUB73vJzzMfN+a2yPnFkMedizEAzFH0LPhbuMiP
	 A7wPzEBxxDMDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 36/52] input/touchscreen: imagis: Correct the maximum touch area value
Date: Fri, 29 Mar 2024 08:45:30 -0400
Message-ID: <20240329124605.3091273-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index e2697e6c6d2a0..b667914a44f1d 100644
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


