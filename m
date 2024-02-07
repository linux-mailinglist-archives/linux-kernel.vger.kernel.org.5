Return-Path: <linux-kernel+bounces-57192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B384D4ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317481C22481
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01E535C0;
	Wed,  7 Feb 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzUH6k2y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994013541D;
	Wed,  7 Feb 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341198; cv=none; b=mK6LjxdrO1+Nzy2IMO7To2tqLJjDqCnunD/7ZkX1jHDis+LKnPQuP36FW8bySejjLmU99tpCPPo288rU2JbPhm7mjrTDUDkifTaMptGKmZ/71eYFGBWn/LZzucy25/7FguEtlOwx9iQ06Gvb7MfaHEy7Cb2K744nM7Ae/Zc4VlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341198; c=relaxed/simple;
	bh=vLGX9cgNvvE7OOqZYy6JEy2ZFuLj5csREoW758lScko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOeTNxVO1ZBZWVOHErNh38wr0oATTEkOYGkz0REhUweaY4I4DZqQRPo85uxR1CIXgDQHSCF+UMIiYbbXza5GCcckiWfoVi24NvIJIvZJwarXhCHHybYTGrvfJwpT5dgfffp7mFwd8EzuehvkPsT48LFsKShWbmTQwhzA/J+6D+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzUH6k2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A715C433F1;
	Wed,  7 Feb 2024 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341197;
	bh=vLGX9cgNvvE7OOqZYy6JEy2ZFuLj5csREoW758lScko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzUH6k2yLQ0mOpCEQfg5Gsgxcv6Oz0HinexVkte5Xl9tL9KOtGCfOPkIK5E9FJ0B2
	 pAJPQCXuaz8F/8SSxfkzxZStrUufqFUgmUD4fguIpTCkGJevFdITFGsI/5oyMqidIZ
	 xwkqiIlaImXb85VylDXs4wVua2V/CTEaxNeglzj0xXJr9hTMMvnPtMJQZPegyRgnxx
	 f0UrgAFVBiffeGFDTHDsyZvY/gB8z+P6B0d5fif4JeDcwgVkV9wgqA6+q7UB/St1ob
	 A5PTZ0Q1rOMcj8zdM4Fs88+8/FZtitf297yywsjVA7Mlq7Bkh7VZn+jfXxcZDD2g45
	 HF0F/4yH0Wbcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/23] ALSA: usb-audio: Ignore clock selector errors for single connection
Date: Wed,  7 Feb 2024 16:25:54 -0500
Message-ID: <20240207212611.3793-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index ccca9efa7d33..970e14ff54d1 100644
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


