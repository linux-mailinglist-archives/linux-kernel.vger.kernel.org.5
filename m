Return-Path: <linux-kernel+bounces-105271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A51F87DB3D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1835D1F217F5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B851C280;
	Sat, 16 Mar 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOh6ycAj"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F01BF27
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710613723; cv=none; b=SxixDWx0lx1ynNXU2y8mKQ8ZTjODsCz3o9W5V5+QFqlhmPZ+Dggcsa3LLucLMmOjqBH2FM/xAxj/d1a1fhsPBm9CqhPb9EMOsdsafQCX89SLxGFk3sqENvEusFIP/ytpV+CpfBlPiX0esy0kSyUZIZe0aa4yc01/o8vl44Qrivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710613723; c=relaxed/simple;
	bh=NDVqjzn4n6OdgsETCttBImMgMrVz+07fLfVjZJRu0bs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cdWUII71KXuEowdKobeHvoPpAQGqT560zkCxRs7SVPkMjc0ZaB/Wp0hebNwDMywQHEwqjO2rjiG8nm8s78sFpVpV2QkR7XCtMeSNLw1s8bWZ6KLkJn7+JvaJgXFo70jan3LxTNI28Qpn77zcoRTKJMksvD6rfqsUbV4dfACuHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOh6ycAj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a466a256726so518810866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710613720; x=1711218520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvqZz7jfkhpn8mxvVVvmdkK5C/FZ80SalXY0kVcCy4Y=;
        b=fOh6ycAjb6NMmyvq7r1wbPu15HQgQbP4f1qcF7Yy+5hiYdlnpaAmnrVzZDxX/UZti+
         6uxu8Db9ieCdA09F9fdI3YdVn80Im2QUjJyTud+dhKMCiY48/80GDKJMMNKsVq3vkv+L
         GQ4bqWZ5VvK4zP8RQEv/nVk+nkfoIXUFXFofYxmmYiR7YOuOZmlg0h4mXYtKq4StGLO8
         7IxJC+VmUUmvu4tLqffWBPnfJR05J8T7GPRwTE/LcQqGlJstAqFZVXaaC4RkU9bdis7o
         dEH83HqesaPPxStmqedw6xJ4ZMWDFsSecYYLUQAZYTdK0YPf0YVHMCnyZONogFqPjiFt
         hHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710613720; x=1711218520;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wvqZz7jfkhpn8mxvVVvmdkK5C/FZ80SalXY0kVcCy4Y=;
        b=axwxnV5KjonxTI0P7xIdNx7o8jgrIFT8UHSkUtv+UQrJXYUehR/2ttAxSYhPU2YV6n
         HVrvj34VhwO4WUcVBS70QIxPkyIDoUR5dDbM6BfGBGCTTjiJiqN08yzvIbEKpLVzKU03
         nGfjo6O9OP6CTJUuq8a0+sYAIfT5uywgPZ7rw59/EyGQWx6aTDjusj/YujyI0LEh2vQ8
         mzA2J4jPPNZwD0XluxmcGfNyhVe6k1bEPkSS0ZLJiAXAZ4wyqAscNDQKq/ZeisxhSQpR
         OZKb+ES7ZFpd6VKI/N4CUQTuSXdZAktl7KZdgKyR45gP6C8qNXkbSpfCQaUPsIS5c2Qn
         Q+Tg==
X-Gm-Message-State: AOJu0YyjgqaFcvfEZPCycKoO82ONPG3LaFSUPAa/DfmeLs8AiO3eZARz
	ickLYF5jd2NdQ788pIoViPsVgZDKZK0cgcNidy0ystKft29eyESkC3G3Lyyb
X-Google-Smtp-Source: AGHT+IGlwubVFxQAOK4L9rQ81bWYmrepGa165kaIGX0BBfLUFIOtx4G7Ig+E6Zd/0rRVJRJ8jLqQ1w==
X-Received: by 2002:a17:906:3b84:b0:a45:fa87:b011 with SMTP id u4-20020a1709063b8400b00a45fa87b011mr9568373ejf.20.1710613719906;
        Sat, 16 Mar 2024 11:28:39 -0700 (PDT)
Received: from ?IPV6:2a04:241e:501:580:d03e:506b:69fb:b04c? ([2a04:241e:501:580:d03e:506b:69fb:b04c])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090635c700b00a465b6c9a67sm2973467ejb.6.2024.03.16.11.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 11:28:39 -0700 (PDT)
Message-ID: <f568faa0-2380-4e93-a312-b80c1e367645@gmail.com>
Date: Sat, 16 Mar 2024 20:28:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leonard Crestez <cdleonard@gmail.com>
Subject: [PATCH] mailmap: Update entry for Leonard Crestez
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Put my personal email first because NXP employment ended some time ago.
Also add my old intel email address.

Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index bd9f1025ac44..69d20689ba05 100644
--- a/.mailmap
+++ b/.mailmap
@@ -338,11 +338,12 @@ Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
 Lee Jones <lee@kernel.org> <joneslee@google.com>
 Lee Jones <lee@kernel.org> <lee.jones@canonical.com>
 Lee Jones <lee@kernel.org> <lee.jones@linaro.org>
 Lee Jones <lee@kernel.org> <lee@ubuntu.com>
-Leonard Crestez <leonard.crestez@nxp.com> Leonard Crestez <cdleonard@gmail.com>
+Leonard Crestez <cdleonard@gmail.com> <leonard.crestez@nxp.com>
+Leonard Crestez <cdleonard@gmail.com> <leonard.crestez@intel.com>
 Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonard Göhrs <l.goehrs@pengutronix.de>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
 Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
-- 
2.34.1

