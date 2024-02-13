Return-Path: <linux-kernel+bounces-63471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E93852FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254CC1F238C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A9383B4;
	Tue, 13 Feb 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN2cMZVA"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773136AF0;
	Tue, 13 Feb 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825396; cv=none; b=cBfjbGnUD+PV97GOYUJDkWgsPAX+jZJH1tw4NuOxrIwr1RzOyxtIAhQESTo2K8nF2BUO0VXr2kScLelRGSvjJr3VHf3NHcQ7YYcouv+ZcrjmlZeRFOvYq/PTLWPEA2ueHMV9SEIgmZpS56+2XuoCu8bm/hexwwaAdr+2GItaSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825396; c=relaxed/simple;
	bh=qxXy/4C00miKD08z6hE3dWYxSISHDwA054ygcHf/2YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOR0pwnBPRG8hlb3REdmtr8cfzZcVJt5vAOJPJCGbMkv0XyLBULHyOU8n61Rtk0bH2qoDJCQKzVIdu0VOsotipu5mMd8725Jki6gOkFRKB4rjrq3N8MjhDrM+lE3AxbnxlDvCC2q7WK6EWzZzWWlWyop7zJdU5ZXj4hTrhYMBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GN2cMZVA; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso345156366b.3;
        Tue, 13 Feb 2024 03:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707825392; x=1708430192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdZyvgYPBQJDkU+5nXmVSJQwMHfnGYfuPE6w4sZ9NNI=;
        b=GN2cMZVAddDa5LhXsWjGEo1LhxsYzGRJ07NY2KAyFJFzoVdD1y3RCEx+u1EwoZ8FiQ
         eruIkMEZBjTPXv7aRP4o7/LfMvn3berCpKxDgJ940Kc0zeCb/wHANyHxVLgWlrnJFPLk
         DZVbcsRDdsb7GAenJXPyYTIDI/kOga4fDzTmZ/eE3ZKdk0xk4O0jj+a4rhE2ZU32X3DB
         8zxTmz0tMcuSLqaHd/lGPrGmk3zhV7V+hv85nmaHlHlxBIYJp56RsrMDY7SOsZX9D36i
         vtTAId/v0YrZIfLv0c8h2tCLyioPrsygw2uWbmpI5RS5kdyZiWFo63u91oWbuONaisLB
         0odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825392; x=1708430192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdZyvgYPBQJDkU+5nXmVSJQwMHfnGYfuPE6w4sZ9NNI=;
        b=r91SqOKmfFocR50UfXzv9YUYytxEi2xdKawoSfX0GqhzkmfTYnPkJbuH95El7MoLcF
         GfAZstl5+g4BJdFASevmFqkK+pK383gVwbZU6AdafwX0SrF+w2j3bGBG8fUycIuhLiTq
         Ul2+wixieFj0S+oWoXcwAquc1Ts6yx12AQqWakkxFfRdfih8S9LpRSRASKSCJIr1frST
         lSwX9MeXgurTDw3pzxWdlbFMcfLBm+Vj/xAHEHroMjBJ6oVekpDTOoScmaUWR/r5ymcs
         V1DB6439fyl2BByf+8g380hv+prL70CMR/9Kitht40k+j8JIxsc53mMkO8DUKugMeE11
         uoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzYXhCwGxx3Iz6mPxLL6pkbWsZNMbFEhIrYxX0kaTUXhao5TQ6hxQPJduX7LSdwRNoUKZZ+744y+T5tIPHil6D8eGRJ5GCMrXWkQp7f7460r1zlLuex63EhD0nEGUmJlILo/PsfvaCYfg=
X-Gm-Message-State: AOJu0YwMDfuE/1WuYGeNxTzKgwWT3LUCMg+O5oyiq3IPe4DJ81aPxiJb
	PeiE4tCvDXrWWX9ltPlqAzoIO57Fzwxv0BDEzkarOlZmcFlX+mii
X-Google-Smtp-Source: AGHT+IFJ3mbfGEX2qIRIEu25yk241CjyIBnoIdCtd8nefAcZm7zc6/cYHMBElh5ZVRd+hyp8DWHIKA==
X-Received: by 2002:a17:906:a392:b0:a3c:c97e:7d64 with SMTP id k18-20020a170906a39200b00a3cc97e7d64mr3576268ejz.48.1707825392367;
        Tue, 13 Feb 2024 03:56:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiR4FYMHwWf5HfXJFc5o/vmOXgOdH+m1QxxIMk+tMNt/b0/PEPFeNwzT49q7WLJHVcXpEdBL5qRrfyu04SsgH3Nx7bzCM5ui7pa28OzCBo/NCBYJXYmMNGostuyZ3lBo70R9Y0Y3UIp5EZKq1EWGyWRW2Z20YIEQrtajQU9tyafMchFwib/cN4QVFmsWQIL6hYN94ff6wJMEJc3xyBwwc3ufmHSZAsaEYGlCm4dT9xSGUJmOPauaWart7nitRjNanOpmUd+G+8pwX9qbJPDyxuobBvE18Zdf+VKKPllKI557luRdMllm3qce99BUkhmTWb6iogLSQ5mf4yrVADtIThf7Z4eJqqEZcbMXRZtI/nq1Jp5QgKf0VngjTuWyMsWv5VrBZ0djf8nLDeCDItvNj2JQeWmQjfZiNZZs2oQ+y//tcaD6Z/aal5oJOs615rCwBylYAXceT/oXtHYsnzAaZT2c0deEX2lGqyAb2C+f/l6x5NA2sSsOU2Qngjt4SErQ8SOpxLRu9ZDop80UzGgV9mEpLNjUy0aA==
Received: from tkudela.. (c156-103.icpnet.pl. [85.221.156.103])
        by smtp.gmail.com with ESMTPSA id k13-20020a170906a38d00b00a3cb2295aefsm1210723ejz.205.2024.02.13.03.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:56:32 -0800 (PST)
From: Tomasz Kudela <ramzes005@gmail.com>
To: sbinding@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org,
	andy.chi@canonical.com,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	kailang@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	luke@ljones.dev,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	ramzes005@gmail.com,
	rf@opensource.cirrus.com,
	ruinairas1992@gmail.com,
	shenghao-ding@ti.com,
	tiwai@suse.com,
	vitalyr@opensource.cirrus.com
Subject: [PATCH v3] Add Lenovo Legion 7i gen7 sound quirk
Date: Tue, 13 Feb 2024 12:56:14 +0100
Message-Id: <20240213115614.10420-1-ramzes005@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000101da5e63$6a2565e0$3e7031a0$@opensource.cirrus.com>
References: <000101da5e63$6a2565e0$3e7031a0$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tomasz Kudela" <ramzes005@gmail.com>

Add sound support for the Legion 7i gen7 laptop (16IAX7).

Signed-off-by: Tomasz Kudela <ramzes005@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index d74cf11eef1e..57b21285ab6a 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -95,6 +95,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -431,6 +432,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA38B4", generic_dsd_config },
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6994c4c5073c..0029f61d4693 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10260,6 +10260,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
-- 
2.34.1


