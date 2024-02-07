Return-Path: <linux-kernel+bounces-57122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA684D43E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49922286B15
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0F8595B;
	Wed,  7 Feb 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcOs5n8E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860312E1FE;
	Wed,  7 Feb 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341041; cv=none; b=meUq0+xym3fFcvqsQf27CoGgjoBezhA+KAotqXmUkq9ncz962GVTQyGKcBHcl+yDoGUxiFk2BXn2XO6vcXm3+G4Oh0lFgV2wVcEhH7w6qQTWqecfWWBYUjyUra/nL/tdktXTIIli245jp5K+y6e2FZPQNH64/VfNjm9QdRyFGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341041; c=relaxed/simple;
	bh=8u/nd32w1/51YWuzY0CKu99RPZGadDx3B7M3o4cGG4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA8ZmbQfL8LYlRs4SuN+gQfoMkGslebGhZgmFYVl465xlq6/Zu+8e6EdQNpKapzfEdIIjg/FMVXc6aMY3UGdRR8gdCXhwTmN/m313/eAu4bsjgKtGgN8CwlhR1bGLrtb9dUmvM1EIZY201kWureHCK6MmtL7ZfLEVxvuULyHU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcOs5n8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4C5C43394;
	Wed,  7 Feb 2024 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341041;
	bh=8u/nd32w1/51YWuzY0CKu99RPZGadDx3B7M3o4cGG4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcOs5n8ENptYrn1tEJ6Y+6/GPqBFkjIWEZ0MhOPyR9rMugrApJGqEotdPjO4uW591
	 NNtTerzPsWqrKPYY6ey3SrLFQJ5dyKhAqn75yTqlyUt+NyTnK6k9ViIhRZLR9uaeXu
	 0SH5WqIQVnPqkYe7ZNsPi06vJ6AVjyjK0W1ODyO2LvkRu2H7JslVIxkkFDdpXFi06w
	 UzIvB/vC3uVT4W6PTNA2STrUwFB105M2gb61EEH2VBdGqaV/gltCJ1noSr+c3Xtwge
	 lFC9hOpC+ZSPsbClkSqHkQGV49BCdVX4FpkB9UwDIP1dAQQR+zmSEFZ5tBWGGP2tw2
	 WXTyECan6MBtw==
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
Subject: [PATCH AUTOSEL 6.6 12/38] HID: nvidia-shield: Add missing null pointer checks to LED initialization
Date: Wed,  7 Feb 2024 16:22:58 -0500
Message-ID: <20240207212337.2351-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index c463e54decbc..edd0b0f1193b 100644
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


