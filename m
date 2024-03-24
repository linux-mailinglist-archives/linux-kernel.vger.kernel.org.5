Return-Path: <linux-kernel+bounces-115527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD396889C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1EF1C32F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171D240863;
	Mon, 25 Mar 2024 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgTuCa16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EAF12BE95;
	Sun, 24 Mar 2024 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320983; cv=none; b=YKQWa9oHjzWXEoRTMEax1srZyWRSSL8/o3i4AVbbLVCtF45w7NUb0Qkt1X8712qF5LL5VogmbC686BkV/St+RWCUMoHqa899RLs7cAVYZDM0MY3tTnHgq2wqD7c/MFN7c/uWG5Of+G/PX/qn9mi0lH/5CZPFZVAr4TMTrReJvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320983; c=relaxed/simple;
	bh=vXv6RwD2T4GSRX/k7xQwPN1CXiLLNq2tTZjiE206sV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHJXx2oSN8N21GarDOe2GJ/fwAHTWSHOb9Ydmjv8AwqF3+5dgvzJWYF8m8y2fZMkJkYmpRE4q6YOx4nhTt4wO/e2XuWAp8+N8UA1ot3aCuFO6ryF0sfLBmhLNz+R2FGNuaJ7bVX6yORrPkNEF7QO/FUf5CKrBimjAtn3pw3mFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgTuCa16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B6C43394;
	Sun, 24 Mar 2024 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320982;
	bh=vXv6RwD2T4GSRX/k7xQwPN1CXiLLNq2tTZjiE206sV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgTuCa16I+hTLfNdBj1NeA/8y/gJbiSSkKvOXlBBD+Nvp1E5Rk5sXSvzVBW1i3xYl
	 9REMrkt7P+cKP35ooHiRLEGYxWpGAoq8VWNz14SogHc3ue8H7CeOb9OpPrnYkE2mK2
	 RuS+VL/yHvxr0bmxN5ZASSPUbH+Gm5MgYtDMmdGwQT9xtP3I3g99mi6ylYbl5JqgII
	 T7Jt9FXgppwN/BPd2AKw0g3b8JFT6plh7y9XsWszWN2d7PGbX+/yXbMYD9Su2HVDAP
	 DlXRb/meYC2W4mbQxUt/RI8rX5B1cK09Pd8KWWgrEz6pqA0hBZVjLE+cL2aETpxWZv
	 vXlJCDE6TWejg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 546/713] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Sun, 24 Mar 2024 18:44:32 -0400
Message-ID: <20240324224720.1345309-547-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index d1a14b0db265b..31f97230ee506 100644
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


