Return-Path: <linux-kernel+bounces-57136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9484D460
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6721A1C20D39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F8152BEC;
	Wed,  7 Feb 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXpJlblP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE9152BE1;
	Wed,  7 Feb 2024 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341072; cv=none; b=WsIz5mfLxRE0JJXvOLdT7ghpXqZRzIiJG3SIbRr5NVgARfxF4NRE46PmGenPutY5/37Q0Jg/s1MG/0Lbayxqb0s8/12iOajgnDj8E8wzgQv+BMOu0lYkgkIMvFFgEas7lZnQfsbV9VlJWpkd7KZ9utXyAFwDO4PhCNFlmsyz3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341072; c=relaxed/simple;
	bh=xgTP9W8lG1bV+HHqB+8kMNTs0bVYzKjOPBJ4jQ6pZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itomEhKSPXNSGjdWLBNdvyYyuVPkSIed7R4kuAR5QNgWyYZq93p/sbt6Jn21FD4OGUWWUSVCmfVRvAnljJO80XWgOvupQi49YzVJ6LCyMoUQK14b0pcClJEW728wUJszqAszL5qgw6xGwvUujyvIHYHd28p57qxZ6n/69GQop1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXpJlblP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264CEC43394;
	Wed,  7 Feb 2024 21:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341072;
	bh=xgTP9W8lG1bV+HHqB+8kMNTs0bVYzKjOPBJ4jQ6pZLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXpJlblPtbZ0B8vqO0Mtg2Rem1jjYGEldjOgFIH1XPZA21fhmPDpSK0WFMnmvcYIu
	 XWZunc0l7tYKDtvBNirLmTkkak6pAuK8X5Q0UIFJ9xZIrzrcdDmRIs6A3GqR5j63x5
	 IRt/l8Fa5XIoak5ZufDcpm+YaTVkgTOxYa3+zlajYGnhnbf6LWCFhpsDq8UQX+DkoX
	 /ryRfYJK7LTLcp+NemMQV3j6XN8ELaDO+fQKI8Awg3HaVpd2kUab67WUzsNneq4TRD
	 LYBxj66jiEKOhkRlolF4Pn3PI7QLkNR+V7xAzKAFeOkjBgDZx7tIGPg3YvERspyYYw
	 ECS5uMPuI5Kxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/38] ALSA: usb-audio: Ignore clock selector errors for single connection
Date: Wed,  7 Feb 2024 16:23:12 -0500
Message-ID: <20240207212337.2351-26-sashal@kernel.org>
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


