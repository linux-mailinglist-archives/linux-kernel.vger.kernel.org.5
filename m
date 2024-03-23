Return-Path: <linux-kernel+bounces-112240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E622A887750
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241151C216E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA58DF78;
	Sat, 23 Mar 2024 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="o96+n8a/"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800EC4C6B;
	Sat, 23 Mar 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711177055; cv=none; b=REWIheXR0HSIPaHau+DzQcNYmPMVAQ6IK7+0ydOwUVTB9YA77Iu49ojWc0soY6QaYlwFIUEqOxB6FY0I5du5FkxaNfxzdugmK1bpop3KwiBd158QrA0VzvbN/Pe7zs51w6qhSJerpvunSNV7Y2jOKg/JgCfku6ZC+T7JE/HZhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711177055; c=relaxed/simple;
	bh=Vepnq6HR03my19K7lEmsnKur7lcLWcR+/WSr2aInfXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFs7hNJouKmJ22GgDVC5VVOK4Yx0c9l3hvmrxi+SFIHnEGSzUaJIRvHtWWs7XJZCenahL5gh6yZ8bEcSvd4RoW+xSmQxTPUA1s8Ts4FsNpSkGShLp5G5JFEbRWHOyCEMLZ4NxujttdGeRCUQdO9SzjrZ37bb/KLH6F4vjKPZ+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=o96+n8a/; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id nvJZrKeyIixjunvJkrMrfv; Sat, 23 Mar 2024 07:57:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711177045;
	bh=VPQNyHwgvojt0bPFXEppRTGCqNsSKPdraCVqPoBN/Ps=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=o96+n8a/XbwTAnqQHGJHBCurGcWzgxVSnMoFmYgfAYMqUmr45BOaVcAkScFXRNsHI
	 RkmMVQIzUbDsmVDNb8PPXdSeuf7/1pVkRwwsBx0OjsNptTPsdu9QeB1bEY907MJw/x
	 6jNck/9jaaeFn9Ehh7vXT/QfNc1zrGJgXX8d7Z7yw08mIeDSc2y9SuIXcAAuOaXREv
	 y8Y8brk0/H2HlcCetHNMR6E6tetvDFqZ8LJE6+Sa1xhG7KXLJR1DUZFYVtw1y/ZKOq
	 W5Uxa3b2hsV2zeN9qA/zkxaLbTbiBdz8FHW556KABQtlA+X/BNfDoV0LGWIIC752Db
	 svaGJ7QGHL05w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Mar 2024 07:57:25 +0100
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: gregkh@linuxfoundation.org,
	jbrunet@baylibre.com,
	ruslan.bilovol@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] usb: gadget: u_audio: Use the 2-argument version of strscpy()
Date: Sat, 23 Mar 2024 07:57:04 +0100
Message-ID: <e7fd0ec5a8b37799271c6d74c325cfb980d44181.1711176701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711176700.git.christophe.jaillet@wanadoo.fr>
References: <cover.1711176700.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to be consistent with other strscpy() usage in this file and less
verbose, use the new 2-argument version of strscpy() which computes
auto-magically the size of the destination.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/usb/gadget/function/u_audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 00ff623b4ebb..5dba7ed9b0a1 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1243,7 +1243,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	if (err < 0)
 		goto snd_fail;
 
-	strscpy(pcm->name, pcm_name, sizeof(pcm->name));
+	strscpy(pcm->name, pcm_name);
 	pcm->private_data = uac;
 	uac->pcm = pcm;
 
@@ -1386,8 +1386,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		prm->snd_kctl_rate = kctl;
 	}
 
-	strscpy(card->driver, card_name, sizeof(card->driver));
-	strscpy(card->shortname, card_name, sizeof(card->shortname));
+	strscpy(card->driver, card_name);
+	strscpy(card->shortname, card_name);
 	sprintf(card->longname, "%s %i", card_name, card->dev->id);
 
 	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
-- 
2.44.0


