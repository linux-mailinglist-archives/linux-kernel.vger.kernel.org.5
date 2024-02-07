Return-Path: <linux-kernel+bounces-57166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817B84D4AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5D11C2106D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AED159C84;
	Wed,  7 Feb 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKB9CEeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923A159CA2;
	Wed,  7 Feb 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341144; cv=none; b=NPIznb9hA3pqfvQ0LivVQHRjCmt5SzwP+cvHvCXhAB2Yuf5TNZpE3IhPKbWBZ1a+jjsRndeceHtEaJ3qleKhXgciqRQPIN0DkjEdAcrYxfJssw9xkJ9Heb5ErRHr7oWTzcugdtscLXJSYIgSXoV5Fu1AZEs4rdUqlRkv2Hy3H7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341144; c=relaxed/simple;
	bh=xgTP9W8lG1bV+HHqB+8kMNTs0bVYzKjOPBJ4jQ6pZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ7qf6TB7q7r1PbIv5/v1Rfwz0vR1mR9LgQMOYW3D8PpuLZFz/Zr990gQC+D+NuqJPLT13CYC0GYhF+R4uQfWxlhaYM5nu3w/dY6+4afHBbabxyvfJNFgWHC0Fl8Ncd+ttU6kPyhdufRE0vFK/Dl7EwCKk+zgDbhKgMJ3u1ZOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKB9CEeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC6FC433F1;
	Wed,  7 Feb 2024 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341144;
	bh=xgTP9W8lG1bV+HHqB+8kMNTs0bVYzKjOPBJ4jQ6pZLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKB9CEeMVewUqF4GzS6vNz+ExO++zhbq//qYQNBwhdtV8x0kW/YuFZEr8GN/SEb/J
	 ry8SGs1pdylR/6ul2PS6+ppym2Q4187YHfAay4iT6ceeGV3gHQFSvjxMHw/Gf/+uPc
	 0AdQBlh76XUFoKq0WcSdBsyke9JkQxhfJAv8k/mV7Otlu2BFu8GM9DmNDeAysSvbrG
	 cCebrIxaQ3BiHfzHrG3YKOBnSE9ZvB0p8iKkFt59SMXwAotW1OmuxUiYreiGdYSajH
	 IkjhqjT/GDl0Rckf05mIMDCYyFgIKpjp7c0h4cDbAxJ7FleW9QM8ZuMP+8Xo5jmOBy
	 HvgTtUbsqwbJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/29] ALSA: usb-audio: Ignore clock selector errors for single connection
Date: Wed,  7 Feb 2024 16:24:43 -0500
Message-ID: <20240207212505.3169-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Alexander Tsoy <alexander@tsoy.me>

[ Upstream commit eaa1b01fe709d6a236a9cec74813e0400601fd23 ]

For devices with multiple clock sources connected to a selector, we need
to check what a clock selector control request has returned. This is
needed to ensure that a requested clock source is indeed selected and for
autoclock feature to work.

For devices with single clock source connected, if we get an error there
is nothing else we can do about it. We can't skip clock selector setup as
it is required by some devices. So lets just ignore error in this case.

This should fix various buggy Mackie devices:

[  649.109785] usb 1-1.3: parse_audio_format_rates_v2v3(): unable to find clock source (clock -32)
[  649.111946] usb 1-1.3: parse_audio_format_rates_v2v3(): unable to find clock source (clock -32)
[  649.113822] usb 1-1.3: parse_audio_format_rates_v2v3(): unable to find clock source (clock -32)

There is also interesting info from the Windows documentation [1] (this
is probably why manufacturers dont't even test this feature):

"The USB Audio 2.0 driver doesn't support clock selection. The driver
uses the Clock Source Entity, which is selected by default and never
issues a Clock Selector Control SET CUR request."

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/audio/usb-2-0-audio-drivers [1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217314
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218175
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218342
Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
Link: https://lore.kernel.org/r/20240201115308.17838-1-alexander@tsoy.me
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/clock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 33db334e6556..a676ad093d18 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -328,8 +328,16 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 			if (chip->quirk_flags & QUIRK_FLAG_SKIP_CLOCK_SELECTOR)
 				return ret;
 			err = uac_clock_selector_set_val(chip, entity_id, cur);
-			if (err < 0)
+			if (err < 0) {
+				if (pins == 1) {
+					usb_audio_dbg(chip,
+						      "%s(): selector returned an error, "
+						      "assuming a firmware bug, id %d, ret %d\n",
+						      __func__, clock_id, err);
+					return ret;
+				}
 				return err;
+			}
 		}
 
 		if (!validate || ret > 0 || !chip->autoclock)
-- 
2.43.0


