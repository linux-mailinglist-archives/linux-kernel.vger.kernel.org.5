Return-Path: <linux-kernel+bounces-57077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B6984D3CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B2928E25D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731F134CE1;
	Wed,  7 Feb 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdxbtFSd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30703134756;
	Wed,  7 Feb 2024 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340926; cv=none; b=YUQdezb1pyANxi5E9kKDnxO9iIUBeMSLSilZBawTpxuZ6R7o91Igt98hZSd+EIKYYNm0UODV6WOXtfs3Zas7366upgpm5fpumU+hxtfKke28O+wDwtbgIRXg94sbVQ+Xhz5eChHSYjWna81IFw33AI+0bbAfeSM17ViGRqXwKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340926; c=relaxed/simple;
	bh=9Zyv7aOpFhgsO+LRJJsTsVa+9Ob+CYBv/nEn7bNmvXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPFTKLfYws+IRPo7CFOs53JM5bem8B0p3Dn9RWD/N+rVE53dbYm8AICEesVFiZupCowVlJ1a8qZutdVwUjfkDT/c190Kygo7cSVysdbIxZm5BEIsa82i7lUT9e2OYQXsRNCzo1QUXCVqOYxswDhpG4lvVLszBgBX2d5cCnsipZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdxbtFSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD205C43394;
	Wed,  7 Feb 2024 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340926;
	bh=9Zyv7aOpFhgsO+LRJJsTsVa+9Ob+CYBv/nEn7bNmvXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdxbtFSdqmeg4dGY+/Ori5W9eRJrSZCWy443PrQWIbRalnIsakydPFNJkS7P2Sg+/
	 3W2qmIKz4HNmWdUojN5NSxLPHav+3wq8mGNdR3S7x6bdWwK7WqGO5AwVs2OrmvCqiz
	 k1tHdH34r1LSRjBq19bagMhktYxxWRWSULK2IPfQEcq+cr62aXhVvu5gRMSVj6yzf+
	 yJnxa+7FtZoy+3X/l8Wbikz4rMPbJesf4pnPkNShwQUOpJoxXAznTmkn+Kpy7nNj71
	 mpwNamWXXTAEi0HlpbpC4HTGRiKEqG44S4H3RDQdPOOgBqvwi/BhBPAUt/B9b9j282
	 1zLh2vNbt4wig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 12/44] HID: nvidia-shield: Add missing null pointer checks to LED initialization
Date: Wed,  7 Feb 2024 16:20:39 -0500
Message-ID: <20240207212142.1399-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit b6eda11c44dc89a681e1c105f0f4660e69b1e183 ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

[jkosina@suse.com: tweak changelog a bit]
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-nvidia-shield.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 82d0a77359c4..58b15750dbb0 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -800,6 +800,8 @@ static inline int thunderstrike_led_create(struct thunderstrike *ts)
 
 	led->name = devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
 				   "thunderstrike%d:blue:led", ts->id);
+	if (!led->name)
+		return -ENOMEM;
 	led->max_brightness = 1;
 	led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
 	led->brightness_get = &thunderstrike_led_get_brightness;
@@ -831,6 +833,8 @@ static inline int thunderstrike_psy_create(struct shield_device *shield_dev)
 	shield_dev->battery_dev.desc.name =
 		devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
 			       "thunderstrike_%d", ts->id);
+	if (!shield_dev->battery_dev.desc.name)
+		return -ENOMEM;
 
 	shield_dev->battery_dev.psy = power_supply_register(
 		&hdev->dev, &shield_dev->battery_dev.desc, &psy_cfg);
-- 
2.43.0


