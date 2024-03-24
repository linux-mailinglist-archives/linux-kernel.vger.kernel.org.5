Return-Path: <linux-kernel+bounces-116085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7380A8896B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294F71F321E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD33A59C6;
	Mon, 25 Mar 2024 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTuLqWqs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BCF5B208;
	Sun, 24 Mar 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323539; cv=none; b=S0iMRjX2GqeHZfSkPhfKxdbhmyTa6u1l536sUJbINGIPwvblnU/R3LTqVssHHMWrIDK6NLdbqrUKHCPUFEqtiA+Nozj2Xp3zcIHHhmqz/CeQvvCDUe9bZVi3nA5cobAJ1sDbgQczDOZ2o4q7yFc7v3jpYjNk5it0zzpXVJuvrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323539; c=relaxed/simple;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvhPXSZJgnDvbfS2gV5ZTFkA8Jh2g6JJOu81x3EfO1ixvt1MISW05bNYKjROvvMdnrdwGV1vPOib37jLoGFlcMG7/QMF9F8jTPBrp0+wrUiu9xKK/SDoID/Scfp2tEg2ifMZL2fMhUQaYsPZcjvT9pD6VaqHB2iBrfBXB46ZxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTuLqWqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99A1C433A6;
	Sun, 24 Mar 2024 23:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323539;
	bh=LYhPIjMpKEPwiaOA5bQCN6S1WNeGsEIjM6B9l315d1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTuLqWqsz78aJAqZU08P4MsWSuhA3R9YzPnRL58FMXF2CsM5T0Z0leaHn3GEZeSm6
	 OrfQL7SKbGE8wLkLnxxWnapw7BO/Hsvs8I+s0mDh9egxPlo0eOeWJYT7NNM1Tml8b1
	 ZeZijETdi5IvIRraxbpHi+IMMUjG6a1Fb2CZpGwjlufMJLJeH80c1PDknGuVDg4YYj
	 clum5qy/iSMSZkecs0ZLYvuq5LvbUuDJwFx7eeoUmH3JrA6u0qUE4T51AOr/3WUb1p
	 hSNQYuSwsI6eyB3/sPu2WdKJFSgKPO0QMoIaZwto3lOY7WwsmIPs6pe/GSh0/YQrwQ
	 1F3bCtn7U2mWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 247/317] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 19:33:47 -0400
Message-ID: <20240324233458.1352854-248-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


