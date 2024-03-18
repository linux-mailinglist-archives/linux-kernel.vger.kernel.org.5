Return-Path: <linux-kernel+bounces-106155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA487E9F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D961C2106C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BBB38F99;
	Mon, 18 Mar 2024 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b="XVReJsTx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BA3BBDA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767876; cv=none; b=gIKgNGdPkYAdY2xyPMO7WppZZrRcaKta0AqOPJcsHLmqKjTRsD2zXPfHGjz8QtkxveNuv5Oc40jvC7ZzeplnB01de2rjMQuo8jII059kCYcqsRL9aN5C1jfImWFSzZWNcmhKtU6+dq6wP6TWBhkn+UmTnRm2h3ITB2WX9x8mrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767876; c=relaxed/simple;
	bh=hTRXqs+87AcQQdwX7hLXmpkNLX8eNTZwj5xd3y9wDh8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AjO5a1jspLnx8IDozQyCiYxTjB9Yuh/q60/6hwSp62j4WGSIsIgXMI3njAiUxaBnCvuHRvzuwTWLJyhVVf/drJKYUdN4W/LEq4K9kYb5srol7vAM2/CEGEexxiBFhOA/eqdasSLSqCdo6NiE/bCLPu6kZkVKjLSxkWMu+RlQN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in; spf=none smtp.mailfrom=cpp.in; dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b=XVReJsTx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cpp.in
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6f6d782e4so2419536b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cpp-in.20230601.gappssmtp.com; s=20230601; t=1710767872; x=1711372672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TccUwvnyA3+iIKaf7kLJqh49DkBa5LS6qGPxBEluav4=;
        b=XVReJsTx+m3aEhPJ9BjJu+4J6ssFgLqY/vJPXGV20hNYsTeU30IR3nc1cv1hPKg3mE
         ekSRdRgaIbqFUtN4TTsPGkCU/8LA814SwR457HjifMCECCDpc9crrIH9AF5I9BBYhSh5
         24x9c93qpfAfKNwp7OyCEkq/A6Cf/bmFJA0xTOZ3fGAmT4vsJ1NwXrculfP4ClfNMcGD
         iiJ3L64lxVAdLT7wgAVMfpN6a7PPUZwlxyW/wgq7VA3x4Kc8bDP/LD2tK/PJQp0lRFKr
         pz90IfRr/2gPFpzE3IxNcGQYMVomWD2/DnxH3xnrENN4AnVPQBKohEVAjA2hdbQr+p1A
         g97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767872; x=1711372672;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TccUwvnyA3+iIKaf7kLJqh49DkBa5LS6qGPxBEluav4=;
        b=sLiNL9F6fLYfwq/xMJ2gQty2UUU3HW8uHYYOYXyIQzovDsrhC4gdoqIjQoN08w763l
         BiXjuhnMWkpVKHLVOmf4X3TZS8C6NKdrqLe2dXky0fh1tu4Za2EP/x2qksE67EWPhwG1
         qjMJj1GiakBd/VKzIRkZjW2UZwAg/U58DggB0sHmhqzr2kICWajlaN+AGMo6g78SnmY2
         TTeaJW4CexP/kZaVZXVOhp637tTmJPXhIcIvgB3pgw4HOLTXnp+JLyQr5DmHxeZwXDWe
         kr5MSWKQdMQBirtkZYmn+5kZAxMA77SEvb6pyCSnXhN52HtP0cPbcS7I/V7hnAG9LlCX
         mlzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrxfflNMW/d+xKcJD/EvNqGVm0BXd8Q7WaWfABfLphCY47EbMMiy1v9WpVZhzEbAnp5PotfQl68IAhOiY0AkdMS+AzAuB9iEy784nm
X-Gm-Message-State: AOJu0Yzeq6otMw3W0tG+/isTeYEOJ0GsBltwIcJRp+Frid8RAxeD5vx5
	2t3cvnwiv41/WGxtjKxCpXSjx5WbcrxxuYOUzY1erFguy9JNi5EB7lvVUWT4Rw==
X-Google-Smtp-Source: AGHT+IE3BSS+qytG3C84b34czAdsgC/GjVd/Z/ylH0iIydUB/nO09+ycIyS4kwBZj2jrjPH8Tx9v1Q==
X-Received: by 2002:a05:6a20:d807:b0:1a3:5336:f303 with SMTP id iv7-20020a056a20d80700b001a35336f303mr6672409pzb.15.1710767872001;
        Mon, 18 Mar 2024 06:17:52 -0700 (PDT)
Received: from [192.168.3.16] ([183.89.29.155])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78141000000b006e6c0080466sm8054389pfn.176.2024.03.18.06.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 06:17:51 -0700 (PDT)
Message-ID: <e2a7aaed-e9d7-4d36-8abf-b71dfd32a0ff@cpp.in>
Date: Mon, 18 Mar 2024 16:17:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anthony I Gilea <i@cpp.in>
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for HP Spectre x360 14 eu0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

My original patch was based on an old branch, sorry for that.
I've re-done it against master and tested if everything works properly.

Cirrus amps support for this laptop was added in patch:
33e5e648e631 ("ALSA: hda: cs35l41: Support additional HP Envy Models")

This patch adds fixes for wrong pincfgs, wrong DAC selection and mute/micmute LEDs.

Signed-off-by: Anthony I Gilea <i@cpp.in>
---
  sound/pci/hda/patch_realtek.c | 39 ++++++++++++++++++++++++++++++++++++++-
  1 file changed, 38 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b6cd13b1775d..c2bed68b88e2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7097,6 +7097,38 @@ static void alc_fixup_headset_mic(struct hda_codec *codec,
 	}
 }
 
+static void alc245_fixup_hp_spectre_x360_eu0xxx(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	/*
+	 * The Pin Complex 0x14 for the treble speakers is wrongly reported as
+	 * unconnected.
+	 * The Pin Complex 0x17 for the bass speakers has the lowest association
+	 * and sequence values so shift it up a bit to squeeze 0x14 in.
+	 */
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x14, 0x90170110 }, // top/treble
+		{ 0x17, 0x90170111 }, // bottom/bass
+		{ }
+	};
+
+	/*
+	 * Force DAC 0x02 for the bass speakers 0x17.
+	 */
+	static const hda_nid_t conn[] = { 0x02 };
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	}
+
+	cs35l41_fixup_i2c_two(codec, fix, action);
+	alc245_fixup_hp_mute_led_coefbit(codec, fix, action);
+	alc245_fixup_hp_gpio_led(codec, fix, action);
+}
+
 
 enum {
 	ALC269_FIXUP_GPIO2,
@@ -7373,6 +7405,7 @@ enum {
 	ALC289_FIXUP_DELL_CS35L41_SPI_2,
 	ALC294_FIXUP_CS35L41_I2C_2,
 	ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED,
+	ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9562,6 +9595,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
 	},
+	[ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_spectre_x360_eu0xxx,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9924,7 +9961,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8be8, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8be9, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
-	SND_PCI_QUIRK(0x103c, 0x8c15, "HP Spectre 14", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8c15, "HP Spectre x360 2-in-1 Laptop 14-eu0xxx", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8c16, "HP Spectre 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c17, "HP Spectre 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8c46, "HP EliteBook 830 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),

