Return-Path: <linux-kernel+bounces-93628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D44687328E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8A0288457
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE45EE84;
	Wed,  6 Mar 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rv6s1wlB"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC61BDEB;
	Wed,  6 Mar 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717418; cv=none; b=JoMxFNwtjokj+RjKr7TdD+A2bJTtwRnW4AgmukWIoKQIjTQ6pt2vGQG9ViStK2lmCE/l9Ie2s4t8LxjpoMlwJu1Me7DJa7VcUwtxYr1aHQAlbVjdEbv0SDPbH66gaRxCWWvXNvNdTCFMODJqGKMNUZHkotw2fC21CUeCTyEMuE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717418; c=relaxed/simple;
	bh=v/PTUsmXjwTYqBP3hqhN/SNIkFflE1GoSi/yKBKur+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4RzUu5wqfk4vuSEDaXhlR65kCEyj4bwifkJ8edGR0TzuEkIX3HlTHVp2sdC6RKSsfQ/hL5o8m/zBsQh12/QQrY4FXhpV1h+uiMBnIqRW0SasRMikkEY51yUS3goCJ63HidXq4ycvUNDIYnS7CTgVk7+f6JUD9IrSIPyBVAKEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rv6s1wlB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 680321C0005;
	Wed,  6 Mar 2024 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709717408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C64T2jK/k8mcNRemqy1jld39vwq5/AiYYHCI9ylD3s=;
	b=Rv6s1wlBUezNztKgZhMPyxdrgbHoOKa/qEf6WAf/6qxyeO+wRvEQ2ZnAc/rQM0U8Vw8Hd/
	Wn1n6gdwL+S4whjAXpwY87GMZE7m21X7HlaeucitSsRnVHGm/dTn/guTiqENRZ5S2CwtXG
	gYu4kyv5oIn7Lu49ySPRgMTJT5HY/nokM7JpgIW2bUkJFp7oKA+utPVv49Wy/VrwiiZrjQ
	lJjBUwhK2iQshIRun2li+TAvvApewVNVdm3eqTKxPTN570MPqK9Hjhwe0nL5ryNvcejaae
	Wb+9vJqRoXIbA9pnCLZcgmlVItsjrXb8MC0nXOINkcGnAbyWle33bCwH/VvBMw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 06 Mar 2024 10:30:00 +0100
Subject: [PATCH 1/2] ASoC: trace: add component to set_bias_level trace
 events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-improve-asoc-trace-events-v1-1-edb252bbeb10@bootlin.com>
References: <20240306-improve-asoc-trace-events-v1-0-edb252bbeb10@bootlin.com>
In-Reply-To: <20240306-improve-asoc-trace-events-v1-0-edb252bbeb10@bootlin.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The snd_soc_bias_level_start and snd_soc_bias_level_done trace events
currently look like:

           aplay-229   [000]  1250.140778: snd_soc_bias_level_start: card=vscn-2046 val=1
           aplay-229   [000]  1250.140784: snd_soc_bias_level_done: card=vscn-2046 val=1
           aplay-229   [000]  1250.140786: snd_soc_bias_level_start: card=vscn-2046 val=2
           aplay-229   [000]  1250.140788: snd_soc_bias_level_done: card=vscn-2046 val=2
    kworker/u8:1-21    [000]  1250.140871: snd_soc_bias_level_start: card=vscn-2046 val=1
    kworker/u8:0-11    [000]  1250.140951: snd_soc_bias_level_start: card=vscn-2046 val=1
    kworker/u8:0-11    [000]  1250.140956: snd_soc_bias_level_done: card=vscn-2046 val=1
    kworker/u8:0-11    [000]  1250.140959: snd_soc_bias_level_start: card=vscn-2046 val=2
    kworker/u8:0-11    [000]  1250.140961: snd_soc_bias_level_done: card=vscn-2046 val=2
    kworker/u8:1-21    [000]  1250.167219: snd_soc_bias_level_done: card=vscn-2046 val=1
    kworker/u8:1-21    [000]  1250.167222: snd_soc_bias_level_start: card=vscn-2046 val=2
    kworker/u8:1-21    [000]  1250.167232: snd_soc_bias_level_done: card=vscn-2046 val=2
    kworker/u8:0-11    [000]  1250.167440: snd_soc_bias_level_start: card=vscn-2046 val=3
    kworker/u8:0-11    [000]  1250.167444: snd_soc_bias_level_done: card=vscn-2046 val=3
    kworker/u8:1-21    [000]  1250.167497: snd_soc_bias_level_start: card=vscn-2046 val=3
    kworker/u8:1-21    [000]  1250.167506: snd_soc_bias_level_done: card=vscn-2046 val=3

There are clearly multiple calls, one per component, but they cannot be
discriminated from each other.

Change the ftrace events to also print the component name, to make it clear
which part of the code is involved. This requires changing the passed value
from a struct snd_soc_card, where the DAPM context is not kwown, to a
struct snd_soc_dapm_context where it is obviously known but the a card
pointer is also available.

With this change, the resulting trace becomes:

           aplay-247   [000]  1436.357332: snd_soc_bias_level_start: card=vscn-2046 component=(none) val=1
           aplay-247   [000]  1436.357338: snd_soc_bias_level_done: card=vscn-2046 component=(none) val=1
           aplay-247   [000]  1436.357340: snd_soc_bias_level_start: card=vscn-2046 component=(none) val=2
           aplay-247   [000]  1436.357343: snd_soc_bias_level_done: card=vscn-2046 component=(none) val=2
    kworker/u8:4-215   [000]  1436.357437: snd_soc_bias_level_start: card=vscn-2046 component=ff560000.codec val=1
    kworker/u8:5-231   [000]  1436.357518: snd_soc_bias_level_start: card=vscn-2046 component=ff320000.i2s val=1
    kworker/u8:5-231   [000]  1436.357523: snd_soc_bias_level_done: card=vscn-2046 component=ff320000.i2s val=1
    kworker/u8:5-231   [000]  1436.357526: snd_soc_bias_level_start: card=vscn-2046 component=ff320000.i2s val=2
    kworker/u8:5-231   [000]  1436.357528: snd_soc_bias_level_done: card=vscn-2046 component=ff320000.i2s val=2
    kworker/u8:4-215   [000]  1436.383217: snd_soc_bias_level_done: card=vscn-2046 component=ff560000.codec val=1
    kworker/u8:4-215   [000]  1436.383221: snd_soc_bias_level_start: card=vscn-2046 component=ff560000.codec val=2
    kworker/u8:4-215   [000]  1436.383231: snd_soc_bias_level_done: card=vscn-2046 component=ff560000.codec val=2
    kworker/u8:5-231   [000]  1436.383468: snd_soc_bias_level_start: card=vscn-2046 component=ff320000.i2s val=3
    kworker/u8:5-231   [000]  1436.383472: snd_soc_bias_level_done: card=vscn-2046 component=ff320000.i2s val=3
    kworker/u8:4-215   [000]  1436.383503: snd_soc_bias_level_start: card=vscn-2046 component=ff560000.codec val=3
    kworker/u8:4-215   [000]  1436.383513: snd_soc_bias_level_done: card=vscn-2046 component=ff560000.codec val=3

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 include/trace/events/asoc.h | 29 ++++++++++++++++-------------
 sound/soc/soc-dapm.c        |  4 ++--
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 4d8ef71090af..b7ac7f100bb4 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -17,38 +17,41 @@ struct snd_soc_card;
 struct snd_soc_dapm_widget;
 struct snd_soc_dapm_path;
 
-DECLARE_EVENT_CLASS(snd_soc_card,
+DECLARE_EVENT_CLASS(snd_soc_dapm,
 
-	TP_PROTO(struct snd_soc_card *card, int val),
+	TP_PROTO(struct snd_soc_dapm_context *dapm, int val),
 
-	TP_ARGS(card, val),
+	TP_ARGS(dapm, val),
 
 	TP_STRUCT__entry(
-		__string(	name,		card->name	)
-		__field(	int,		val		)
+		__string(	card_name,	dapm->card->name)
+		__string(	comp_name,	dapm->component ? dapm->component->name : "(none)")
+		__field(	int,		val)
 	),
 
 	TP_fast_assign(
-		__assign_str(name, card->name);
+		__assign_str(card_name, dapm->card->name);
+		__assign_str(comp_name, dapm->component ? dapm->component->name : "(none)");
 		__entry->val = val;
 	),
 
-	TP_printk("card=%s val=%d", __get_str(name), (int)__entry->val)
+	TP_printk("card=%s component=%s val=%d",
+		  __get_str(card_name), __get_str(comp_name), (int)__entry->val)
 );
 
-DEFINE_EVENT(snd_soc_card, snd_soc_bias_level_start,
+DEFINE_EVENT(snd_soc_dapm, snd_soc_bias_level_start,
 
-	TP_PROTO(struct snd_soc_card *card, int val),
+	TP_PROTO(struct snd_soc_dapm_context *dapm, int val),
 
-	TP_ARGS(card, val)
+	TP_ARGS(dapm, val)
 
 );
 
-DEFINE_EVENT(snd_soc_card, snd_soc_bias_level_done,
+DEFINE_EVENT(snd_soc_dapm, snd_soc_bias_level_done,
 
-	TP_PROTO(struct snd_soc_card *card, int val),
+	TP_PROTO(struct snd_soc_dapm_context *dapm, int val),
 
-	TP_ARGS(card, val)
+	TP_ARGS(dapm, val)
 
 );
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index bffeea80277f..7e8a2a5312f5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -725,7 +725,7 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_card *card = dapm->card;
 	int ret = 0;
 
-	trace_snd_soc_bias_level_start(card, level);
+	trace_snd_soc_bias_level_start(dapm, level);
 
 	ret = snd_soc_card_set_bias_level(card, dapm, level);
 	if (ret != 0)
@@ -739,7 +739,7 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 
 	ret = snd_soc_card_set_bias_level_post(card, dapm, level);
 out:
-	trace_snd_soc_bias_level_done(card, level);
+	trace_snd_soc_bias_level_done(dapm, level);
 
 	return ret;
 }

-- 
2.34.1


