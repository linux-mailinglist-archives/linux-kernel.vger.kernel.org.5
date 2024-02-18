Return-Path: <linux-kernel+bounces-70460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375C859839
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69AF1C2086B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15246F064;
	Sun, 18 Feb 2024 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PUkcQkmN"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3F1E898
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278119; cv=none; b=oxNeMGnbqP3D/+bstGygZIY8uzhvm6dLVLbzLo4eZvSpJ9e0NC/NhOjdo40z4sLIvumW4j3FlpPD/hBwCdRAmgaGEYNC9dsyMdw9JrtKip2rHhLy/q8IioA81ALI1Ktgt5SinIsARmvxDiaVxkzICMc4R470unwetqcxq76RvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278119; c=relaxed/simple;
	bh=cayEuvY0y6KSIvUSRCJMPz3JMbb0E4NVb59LARBko7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrW0F92TlGIGLStteQV0W5vj5g7Tq7bIR92wwvKboCkQBqv9n6pdP4J9lbdPRcRu58fdn3qgyLugvyFzTN7krwGrH0K9+ICyCrhzYwVz68Ll6iTCvsRSOUXUnRZWgcYTZnOG+bWMHeBJPTvFQ0FE8Slg2u5pjFwsjsbKBbxY7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PUkcQkmN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so28814766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708278116; x=1708882916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaCqvU53nYmBQryCKQsHvs+sWViqj1uVc9DsWMftjUA=;
        b=PUkcQkmNDoLSWshEv5a3dx4QarJ8oaXCBIUmo7+9/aXfqUC9K2CF/g5NYJJEtkGi8V
         TrSWKD0MVUBd+/G9voTlteJsfK2/FVQMZK94lo4koXWahrPaBSjwDBPzmk4AYSX9SLba
         HpWOagkze+gZbxV9Ipw7SBvTph2OUbDE5ePzlysRhVZ0G7MwjOW1oxkuBYuOBz2vdG72
         4WY+7zXBO6cSnbiop2T/XMCcE0L2HKcFB0gHvM8SQ6S11tX9aIhVs7A9JEn9R7onW1z8
         rUzVs9M0C1Tr00tYTxVSXjFtKPJsb8SW77vZo4EOTKdTr1gQIkKeTi70UU1w9pt9F3M2
         bWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708278116; x=1708882916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaCqvU53nYmBQryCKQsHvs+sWViqj1uVc9DsWMftjUA=;
        b=pCV9/VDBUI3WbY/TZ/ucQ0pcYOeB7YWJPtR4NOCLOOKs3/UqQDZmMcAq337AvfMCQf
         3yLchEC6bFDzBAcHP+usF16v9wn86AU6H9F1aYxyxhzzyGhFKU7CKCNf2HI71SSOeBI9
         BfWAJHNRkrXHZygRdkvny1V3bUUTSDVnz2kA6R2fhJXal8RiJS8VzbJ184/3ko6G+tEI
         A7Ep1CjVbwdqXfCKd9A0Eass0vmjv7QXH5krjPVkM/mg4D1m4We6BOoLD0YQxs/KbzHf
         l8BIXuZQF4O9/po3x2ap4h8envYaM2NAShWHygB7c//J3G45MLcK3NOOOo7Pw6Rl1PGf
         CLJg==
X-Gm-Message-State: AOJu0YyEBPiALvKcv6I9nnRe0uieFbikLXAXrsC0HhTE6oZ/FGTZRxeP
	G0t8yjrTrpeuQTo7+bBQKDaul6yl0npkPYMwbhdisa4Fa2LlpIqG
X-Google-Smtp-Source: AGHT+IFlYBT6ksVioBlVjlddbvg2wEd7d2F3dsvv5wNPPzTQReB+780t3HgaPw+jxSi5NdYGoqKG6Q==
X-Received: by 2002:a17:906:359a:b0:a3e:9353:d379 with SMTP id o26-20020a170906359a00b00a3e9353d379mr476736ejb.60.1708278115482;
        Sun, 18 Feb 2024 09:41:55 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b37-4900-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b37:4900::e63])
        by smtp.googlemail.com with ESMTPSA id r16-20020a1709067fd000b00a3e88f99cf1sm412710ejs.149.2024.02.18.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 09:41:55 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andrea.merello@gmail.com,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/2] clocksource/drivers/arm_global_timer: Two small fixes
Date: Sun, 18 Feb 2024 18:41:36 +0100
Message-ID: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series consists of two small fixes:
1) incorrect max width (and therefore mask calculation) of the prescaler
   field in the Global Timer Control Register. The field is actually 8
   bit wide according to the Cortex-A9 MPCore Technical Reference Manual
   r3p0 [0]
2) non-function: a stray tab which is inconsistent with to the coding
   style in the driver

I don't have any ARM/STI hardware to verify the first fix. However, I
tested this on an Amlogic Meson8b board with Cortex-A5 which uses the
same Global Timer implementation as Cortex-A9 SoCs and the documentation
confirms the same register layout: [1]


[0] https://developer.arm.com/documentation/ddi0407/g/Global-timer--private-timers--and-watchdog-registers/Global-timer-registers/Global-Timer-Control-Register
[1] https://developer.arm.com/documentation/ddi0434/b/CIHJGFEA


Martin Blumenstingl (2):
  clocksource/drivers/arm_global_timer: Fix maximum prescaler value
  clocksource/drivers/arm_global_timer: Remove stray tab

 drivers/clocksource/arm_global_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.2


