Return-Path: <linux-kernel+bounces-105841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7D87E54A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835C41F22095
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948128DD2;
	Mon, 18 Mar 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2SIpIfIB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z5QGDrCw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2SIpIfIB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z5QGDrCw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5FCEAD7;
	Mon, 18 Mar 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752149; cv=none; b=L1E3uLZ1stxFO0waF1YQ0L4B1Jg09SsffFqHPdXl9xBbbqofDBwGlOY3KJ43n4gvvUdPSnG4DyE0IghGtM02FUcUMNS7mgVH9jxE5N0Kl9Jf/JZ5vnnqRzrecUWhBxdrLQ77bMYSOPesxoQa4D3ysAbxJtMoZvTPgud+0//1WdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752149; c=relaxed/simple;
	bh=/fB2tphTIRzK7XGA5TcnCZsCEUMQG1ulyI1hCwC4Bw8=;
	h=Date:Message-ID:From:To:Cc:Subject:MIME-Version:Content-Type; b=X1zUcCii0cBtwK/PyJ2Zg+dKyzjFtu9PIQ9j8O2dXkRNR8kwnjrd+9tTndoHi/2bN7N0/wDrl5H4bN0KejZcdrUIdzEgthcL+VZKayjR+zAsgsE3Y6dzY5KjXQiXk6yfpZn48ruSG0xNhAELPkqjjB9SQRlEgYS8ttvlFjrAc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2SIpIfIB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z5QGDrCw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2SIpIfIB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z5QGDrCw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2A155C2D4;
	Mon, 18 Mar 2024 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710752145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=joiuEo91VaTCIwnvp+a7CPqnwqgmwdAIwB6fL+M9w4g=;
	b=2SIpIfIBkbLcg16opl1AI6CC1Wtdmlz5OFDbcRe1IMHczWM3IGOBQLothI0c/ae93xrglZ
	0V1Y7PTEJubCZ5wOk10j3k55Y5L5TXuLu7UjEEW+vCykfY1jtrI9omiza3JoE2F/DST4Pw
	ehPQaWLueNiylw2Co68YofgZKhaBQeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710752145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=joiuEo91VaTCIwnvp+a7CPqnwqgmwdAIwB6fL+M9w4g=;
	b=z5QGDrCw7unS8nkjac2KKiKrM5C8zIDGQHEEd1rb6WWVYEfT0Z0DFxAOJNuaakDAnDg6gm
	kCfp9GBwQTYR7OAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710752145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=joiuEo91VaTCIwnvp+a7CPqnwqgmwdAIwB6fL+M9w4g=;
	b=2SIpIfIBkbLcg16opl1AI6CC1Wtdmlz5OFDbcRe1IMHczWM3IGOBQLothI0c/ae93xrglZ
	0V1Y7PTEJubCZ5wOk10j3k55Y5L5TXuLu7UjEEW+vCykfY1jtrI9omiza3JoE2F/DST4Pw
	ehPQaWLueNiylw2Co68YofgZKhaBQeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710752145;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=joiuEo91VaTCIwnvp+a7CPqnwqgmwdAIwB6fL+M9w4g=;
	b=z5QGDrCw7unS8nkjac2KKiKrM5C8zIDGQHEEd1rb6WWVYEfT0Z0DFxAOJNuaakDAnDg6gm
	kCfp9GBwQTYR7OAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EA8B1349D;
	Mon, 18 Mar 2024 08:55:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IiFnHZEB+GW5QAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Mar 2024 08:55:45 +0000
Date: Mon, 18 Mar 2024 09:55:45 +0100
Message-ID: <87o7bb9awe.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sound fixes for 6.9-rc1
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: 6.69
X-Spamd-Result: default: False [6.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_ALL(0.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.71)[83.53%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ******
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Linus,

please pull sound fixes for v6.9-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.9-rc1

The topmost commit is 585f5bf9e9f65b1fec607780d75d08afee0f0b85

----------------------------------------------------------------

sound fixes for 6.9-rc1

Two regression fixes that had been introduced in the previous PR,
additional HD-audio quirks, and a further enhancement for the new
kunit.

----------------------------------------------------------------

Ian Murphy (1):
      ALSA: hda/realtek: add in quirk for Acer Swift Go 16 - SFG16-71

Jichi Zhang (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga 9 14IMH9

Takashi Iwai (2):
      ALSA: timer: Fix missing irq-disable at closing
      Revert "ALSA: usb-audio: Name feature ctl using output if input is PCM"

Takashi Sakamoto (1):
      ALSA: core: add kunitconfig

---
 sound/core/.kunitconfig       |  5 +++++
 sound/core/timer.c            |  2 +-
 sound/pci/hda/patch_realtek.c | 22 +++++++++++++++++++
 sound/usb/mixer.c             | 49 +++++++++++++------------------------------
 4 files changed, 42 insertions(+), 36 deletions(-)
 create mode 100644 sound/core/.kunitconfig


