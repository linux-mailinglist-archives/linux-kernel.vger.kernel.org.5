Return-Path: <linux-kernel+bounces-111127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EC88683E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D226A282F80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8241756D;
	Fri, 22 Mar 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k0rBfayv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2grr9aKX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k0rBfayv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2grr9aKX"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2216CA4A;
	Fri, 22 Mar 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096432; cv=none; b=UcYYcJAchv/43LfMpzdA+igXSVGjv5wkrpbgK2W56FRiouVJWihGf2bK6jffV2AE1OFE1PFkDLX+W5CjzeHZyMY82pDltXWNNmR5xSFn5pqAeBWhciBS23aqkVllnQxjPhToT81x9vJUKTZXq9caYiEuonQeaJlB2xHf02imyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096432; c=relaxed/simple;
	bh=S1fSKPGfqTSlj0nruv3EJJSWjVO2uwXlISmnmX73GrU=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=AWFe+1scJJQcaxwbbARHSAyOwi3Q2ZAgfKslJrIfbFyb7Sw3OfwtwZCgFII6RjacjvW4MZbqFmxxtRCYNRU+xHyy82/RA8g2oKG0i+ppmY0MDnUQZupfLGdB8w2C5edODGKHBMp3Q4GDTHbsmLpAa1Xl6kSpak37dxiKurnoL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k0rBfayv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2grr9aKX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k0rBfayv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2grr9aKX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A258339CF;
	Fri, 22 Mar 2024 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711096429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8/qdVkgphyenrjVkkJ3P3ooDkxe09gRUQgzequ/ZsA=;
	b=k0rBfayv+RLD8c3gBoeejWTrwnxHQvBbHsxLAgijQUvjZ1qE7GYbcs/e5lXLaPOn/KZEBH
	2iZ1yzQuQxY6CC9gA5Fbb9mOny41Oyi2iVRJDHvVLjF1Mh5JeasUnRzy5hiZMS4BdrSkwQ
	lpJNqkO318Jj7ZZ8Ts9l55V0Jd2tjKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711096429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8/qdVkgphyenrjVkkJ3P3ooDkxe09gRUQgzequ/ZsA=;
	b=2grr9aKX2AygMpJfIlIXMgUxy3P6APw+43hz2vwRdKbG6vSbu9KmMLTd7OADSK8SRFPpv6
	sJCCy7p1+nJGp4DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711096429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8/qdVkgphyenrjVkkJ3P3ooDkxe09gRUQgzequ/ZsA=;
	b=k0rBfayv+RLD8c3gBoeejWTrwnxHQvBbHsxLAgijQUvjZ1qE7GYbcs/e5lXLaPOn/KZEBH
	2iZ1yzQuQxY6CC9gA5Fbb9mOny41Oyi2iVRJDHvVLjF1Mh5JeasUnRzy5hiZMS4BdrSkwQ
	lpJNqkO318Jj7ZZ8Ts9l55V0Jd2tjKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711096429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v8/qdVkgphyenrjVkkJ3P3ooDkxe09gRUQgzequ/ZsA=;
	b=2grr9aKX2AygMpJfIlIXMgUxy3P6APw+43hz2vwRdKbG6vSbu9KmMLTd7OADSK8SRFPpv6
	sJCCy7p1+nJGp4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0C9A132FF;
	Fri, 22 Mar 2024 08:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sGKTNWxC/WXOMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 22 Mar 2024 08:33:48 +0000
Date: Fri, 22 Mar 2024 09:33:48 +0100
Message-ID: <87a5mqzmvn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes #2 for 6.9-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.18
X-Spamd-Result: default: False [-0.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.91)[0.970];
	 NEURAL_HAM_LONG(-0.99)[-0.994];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Linus,

please pull sound fixes #2 for v6.9-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix2-6.9-rc1

The topmost commit is 9f2347842b526cbc2655068591fb0166362d2999

----------------------------------------------------------------

sound fixes #2 for 6.9-rc2

The remaining fixes for 6.9-rc1 that have been gathered in this week.
More about ASoC at this time (one long-standing fix for compress
offload, SOF, AMD ACP, Rockchip, Cirrus and tlv320 stuff) while
another regression fix in ALSA core and a couple of HD-audio quirks as
usual are included.

----------------------------------------------------------------

Anthony I Gilea (1):
      ALSA: hda/realtek: Add quirk for HP Spectre x360 14 eu0000

Chancel Liu (1):
      ASoC: soc-core.c: Skip dummy codec when adding platforms

Cristian Ciocaltea (2):
      ASoC: SOF: amd: Move signed_fw_image to struct acp_quirk_entry
      ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED

Hui Wang (1):
      ALSA: hda/realtek: fix the hp playback volume issue for LG machines

Jiawei Wang (2):
      ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"
      ASoC: amd: yc: Revert "add new YC platform variant (0x63) support"

Luca Ceresoli (1):
      ASoC: rockchip: i2s-tdm: Fix inaccurate sampling rates

M Cooley (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS M7600RE

Rob Herring (1):
      ASoC: dt-bindings: cirrus,cs42l43: Fix 'gpio-ranges' schema

Shalini Manjunatha (1):
      ASoC: soc-compress: Fix and add DPCM locking

Takashi Iwai (1):
      ALSA: control: Fix unannotated kfree() cleanup

Tim Crawford (1):
      ALSA: hda/realtek: Add quirks for some Clevo laptops

Uwe Kleine-König (1):
      ASoC: tlv320adc3xxx: Don't strip remove function when driver is builtin

---
 .../devicetree/bindings/sound/cirrus,cs42l43.yaml  |  11 +-
 sound/core/control.c                               |   4 +-
 sound/pci/hda/patch_realtek.c                      |  68 +++-
 sound/soc/amd/yc/acp6x-mach.c                      |  14 +-
 sound/soc/amd/yc/pci-acp6x.c                       |   1 -
 sound/soc/codecs/tlv320adc3xxx.c                   |   4 +-
 sound/soc/rockchip/rockchip_i2s_tdm.c              | 352 +--------------------
 sound/soc/soc-compress.c                           |   4 +
 sound/soc/soc-core.c                               |   3 +
 sound/soc/sof/amd/acp-loader.c                     |   2 +-
 sound/soc/sof/amd/acp.c                            |  48 +--
 sound/soc/sof/amd/acp.h                            |   7 +-
 sound/soc/sof/amd/vangogh.c                        |   9 +-
 13 files changed, 137 insertions(+), 390 deletions(-)


