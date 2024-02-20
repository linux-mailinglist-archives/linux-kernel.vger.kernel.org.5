Return-Path: <linux-kernel+bounces-73251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 988DE85C010
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288D9B2300A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF0763F7;
	Tue, 20 Feb 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgAcGyS4"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6976051
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443347; cv=none; b=tH+pNatGVP2nItHs6+170+p5YO5AVMRTblZcf2xj4vajmyfv3W33wIN/YqScFAupIiCWAiMQ2VTTdD7zGyciufvtXJlzAPZnqNOM9HxESOR92YWWtSp/ppmLmLgB3OfRQHStt2cynptAj/TVNUY3Dr2YjD8xb1ScmLMW8k0IUvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443347; c=relaxed/simple;
	bh=Bdr6esLRbtemkpFIIDa1y5ugHKxf8AG0iRZ2eQuhhuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P46+E9zL9eSEC0loy662ugHkakzYFjAi8qYKz6EGoUJemXvqF24eRpzaMwWWPGlkCJDxn32ugvrCEbrK1ODM4zqJsPcqB3GSU2vGpJpyaon9OcpnNoZdiIq/kdFgVSylp5hruDeRW99la84ugc6NA8f6wOnMQCaOfBQjoPmA+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PgAcGyS4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41270d0b919so3672495e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443344; x=1709048144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcW5EHUKgbIlTJ9AkvlcTH/1qNEKLD/WUfYuV6zpMeg=;
        b=PgAcGyS4m3MARmG7Pf4cdSb/D7vA5SIgtDC3mkRGsipnpN28tjNxL6hr4TLddZ67+P
         owTW1oZANz/ZlKYkHO/5e3704isLy+NMOwdchknQfdKTobcFnUZqwq4vQWsuNpsyjy4+
         kOqbbbrifaStO8sjkSDeKL6PDPtYkA9/3XcbYeP+AwF28r4fwcKVHdSmIFWArQ76I/aK
         KUWiYgIR7qElJzu829Qr4ety3HPG3HHObTGjuieMREW0xD+rSimDmwazbNqkFZrPzPMH
         vQshWmrTkOubhq2odNcaQuTNYK2RtNDLqKnkW5OXcsO1j8nBiLreHYjjqzFeFjzvnj1I
         hagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443344; x=1709048144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcW5EHUKgbIlTJ9AkvlcTH/1qNEKLD/WUfYuV6zpMeg=;
        b=lWcTcTb5vhHpFnpiFby2RS3/l16SlvirSbMXgnbYwEDaYBAJMJO85PExXXi/o8qlRd
         FY019c19RpcvXm7ITaaBci4a6xLv/LWhT+dj7+ucSXLN89yvzapAAFvaQc9Z/CDjfpWN
         3P4LW8cleb4X12N5yMgaQE45hFNIn1+xvJhRz0GOcPMIGpFBFoVXo4tAOQP0qryLLzDM
         pl2k7fkRduC4cDnrBAvo72UNW0j2Bi0VadB1XhV435XeojoH2RK+w9jI7WJvtXdZvUhb
         FrScC+VngA5StKCRHrRotw632fj+1J2ggaHj1HSlIIjQpRYKcazjUOr8xho4aMRz3P6H
         Dobg==
X-Forwarded-Encrypted: i=1; AJvYcCU7A7rpn7Tk2dy04CtK9IgXAx1BEtviaKNv69zOgLlHY+6DaDFauIqjZsLr1JRL+VZmhc8WrO9WrSVs8Q/g5Duy307UlLFEgvlVthZW
X-Gm-Message-State: AOJu0YwkiFM+MNYPkgSjSJN3RW1ZP7Sald5ZYrzE9jAngHueu/c/w9x0
	15XnjtondneaMZ+LIplFWSIwV6NdRIXuSik90kVrcUTDliAi9LFVbqQO9JQSnhE=
X-Google-Smtp-Source: AGHT+IEpCXV6NsmkOJ9aSe37i5U0I9NvAzq/Dog4zLeK5T/NulYxyznqCpuNmqivjX1f01yhov8nMw==
X-Received: by 2002:a05:600c:314b:b0:412:71fb:7732 with SMTP id h11-20020a05600c314b00b0041271fb7732mr408200wmo.38.1708443344393;
        Tue, 20 Feb 2024 07:35:44 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b004126ec2f541sm2444905wmo.0.2024.02.20.07.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:44 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/4] backlight: lp8788: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:35:26 +0000
Message-ID: <20240220153532.76613-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153532.76613-1-daniel.thompson@linaro.org>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props is stack allocated and the fields that are not explcitly set
by the probe function need to be zeroed or we'll get undefined behaviour
(especially so power/blank states)!

Fixes: c5a51053cf3b ("backlight: add new lp8788 backlight driver")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/lp8788_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index d1a14b0db265b..31f97230ee506 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -191,6 +191,7 @@ static int lp8788_backlight_register(struct lp8788_bl *bl)
 	int init_brt;
 	char *name;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = MAX_BRIGHTNESS;
 
-- 
2.43.0


