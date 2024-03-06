Return-Path: <linux-kernel+bounces-93627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E9873293
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7CCB2989A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0F5EE70;
	Wed,  6 Mar 2024 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DlefIBq2"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D035DF15;
	Wed,  6 Mar 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717417; cv=none; b=CchVU0PrZKGAp+yM7hSahj3Mj90M+40uNY28Iqph13fVX0t5hc3aqbOUbWpLW81mmgT4qGqReMy3dlEjlGSYo80IN9gb/u08YxbypLcomTMnCc8lZRatTMVvRctkNL5En4tqFveD6AS91gn33RDzhexYrXgvhd7smYgbUf8+dPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717417; c=relaxed/simple;
	bh=1QIofYlPLaZazIzFiSyKooWgjJyMBhb0LmNv+SCvwiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fICNPjhfbnqeB6zwBt9DlDWIIPWWyJWKP7yg5nbyeS526z2UvfLqhxKNSklcHK0xZEnuHskC4o8jnz7fFOWA2MQeG1Dop4Y7eI+EYCuRAlbfMw6GUT8ly1LGnBqBt86zEjoOfe9vDx3Qk0iSlTFZdycKQViuAU/hzbXmfDHtGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DlefIBq2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7205B1C0002;
	Wed,  6 Mar 2024 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709717407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c+7c8y7LxrFjFPDV57l6DgLORtNVZf2nyVmNjPhP4A8=;
	b=DlefIBq2nchZVKk30u2V3EzmpT/O/dKHoPzfiKr0ZuCMeZ5cz0A8JlMu6PBfeNa3Rj9dVK
	un6wvQED+3xEcOOiQ8HFfJ41/+Tiz3R0QIk2iVx4rmK0Aa9tWcM3ikmnzGN2JJkrdW4ECK
	Jz4QkmG7thxixu0pIbtW31+rXKqeMQ6eqTXSKcwNOzYMS0403Vjd3eVAnfduPrGS7GSGL9
	2mfknCQQ1FdBv/eQ+MVczyxKNYCa2dMprBIPTzfosLMzVMpdJYXqlo1C/bo2Ci0a8A3lQP
	6KfbPwdtRw3JjmEK74Z1MTMH1BEpKNVYQ6lfmv+2fbGBbvbB4gMT7MELQJn8Rg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] ASoC: trace: trace more parameters in ASoC DAPM events
Date: Wed, 06 Mar 2024 10:29:59 +0100
Message-Id: <20240306-improve-asoc-trace-events-v1-0-edb252bbeb10@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJc36GUC/x3MQQqDMBBG4avIrB1IVRR6leIiJr/tLJrIjARBv
 LvB5bd47ySDCozezUmKIiY5VbzahsLPpy9YYjV1rhtc70aW/6a5gL3lwLv6AEZB2o2nGJdx6Sd
 EBKr9pljleN6f+bpuJefx+2sAAAA=
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

This small series adds parameters to existing DAPM trace events to make
them more informative.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      ASoC: trace: add component to set_bias_level trace events
      ASoC: trace: add event to snd_soc_dapm trace events

 include/trace/events/asoc.h | 45 +++++++++++++++++++++++++--------------------
 sound/soc/soc-dapm.c        |  8 ++++----
 2 files changed, 29 insertions(+), 24 deletions(-)
---
base-commit: e7cc5f08886d5a86cada34b421d75989413fdea6
change-id: 20240306-improve-asoc-trace-events-7ddb6b37edec

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


