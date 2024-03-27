Return-Path: <linux-kernel+bounces-121881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFD688EEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FC8B23C64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128C6152507;
	Wed, 27 Mar 2024 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh1Vm78d"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720015217E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566618; cv=none; b=m1k//QjVvdF3xD4eQz3oO/6OM7szj+702GFcglfDntiaUwhZuJMhmznXmH6L7uQt6lg18/8G8PXNy20Uc6wXi2FIJ95h+1ViacQ5qdmcMXLkJd4lvU6Y2V91kG8C5tCdIFOoGldequV0f+KzOb+3GJWF5M256yIVTvxzcxIQa64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566618; c=relaxed/simple;
	bh=2P53dqZLCQDgClrPxw8cwYgJMflZz0YJKHxb+dxtGz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmKpqk2lFjHSuOa/6u3Y4ndvsG0Wb98nk3mdtgEmBWf2TZTBm+gHp5+vlhIuqwNizW7K5NhEmsxLGYDtKyiNNvmHnOj4iyQjPjgA8TTgwUowfWuthSCtzdAN+qw7LBDrLqf/bQr0Yb4cBYNbwZ3USX61zkdeMHrhVfLqUWyuY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh1Vm78d; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78a3bccc420so7207085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566616; x=1712171416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OJvFLyFknhUDss3UMv5MZgT0NYrVcq8IA8NPybvW4I=;
        b=Yh1Vm78dmyp73VkevfaG+nYGvtESO6LIEovemiUzn4Qrii+PwCxfqokJYPz/Sw+SJV
         2hb3xWJ3Hc1cUnAh0SW+OVp+SIWRpetQY10D5Sqm74mAKRwCl8hXH7f8wIwkoBPOZJc+
         OcJ7YvS9QT9Np+3tt0ImLpYS0yxxmXSMEg7lsxa/FRd9cCn3BAn4xp1jtP17LZZ5bK/r
         5zS6cv6/IlQw+6rtdsIPPGYDnK7a+76fGM9wM8Qo7k1JTK+t0hobvBHiIwqSUxuY5k1H
         e/i9bo58FFl1CmpCnyfqxC4zlz/BWVgdXF6AS1+y5mGSFZKtiGZPeJUkhFSE2zYtCV2f
         XKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566616; x=1712171416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OJvFLyFknhUDss3UMv5MZgT0NYrVcq8IA8NPybvW4I=;
        b=AU/J1maoLa7W0xOtaqGp2d9sB2tCnkGasOYV+QpYws0Dx0MZjIxUCuoRDV/jrwjTLD
         1aniE4cLqtREL2+iLDzFjfU5VG4Cfdfu2WIOv+YoZR1izQZ8Uq8MXuwN3Gv40s19gnvR
         2NA6+EW6rzLnxweqJxbsyjlXMx8DeTFGX9ldc2dC4mQToA/qFT4agFWGrTTWFLwEKM0i
         c0FGk6UxlryvajvRZOuzB2KCJ37g6To1rdz/Bjk5VKOks5B7QymjDFlBb1oX+LyKv7sk
         8uxJ10fCCkMPgeOYIq9K8XknQ5+mXBp3ozH2+hhn0GRrz/cJ9Itvt6LepIOSsNhXShRw
         hOHg==
X-Forwarded-Encrypted: i=1; AJvYcCUEhmFurhVqAQ2EIqgtK4sEs63Yz7EW3cxFAeBDVe0ayYc4Fk7Poj8JTWibBJR/avbYSWP3u4ndGV0cxBoZxBJ9drMK3cbiYg4tttHB
X-Gm-Message-State: AOJu0Yyar21IcNsFJDbsWUZ57L7Dpeq78SmAvXJHAjG5Nda6l8pLVXaF
	eiSIjelzWYQ37ogTd5C8fa/NNEQqQss6yNyg/k7AKurS/FOP6IJMgmzLt3V8
X-Google-Smtp-Source: AGHT+IGiE1RuN1c9CUcRzRJsXLn7mb71lrh5W4dd3z2jLlJLq3px/AkdtBHo967VE8WV3ZXbJkMCPQ==
X-Received: by 2002:a0c:ea25:0:b0:690:a800:8ffa with SMTP id t5-20020a0cea25000000b00690a8008ffamr541916qvp.31.1711566615922;
        Wed, 27 Mar 2024 12:10:15 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id 10-20020a05621420ea00b00696a1f5dd18sm1784789qvk.116.2024.03.27.12.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:10:15 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] staging: pi433: Remove an inaccurate comment.
Date: Wed, 27 Mar 2024 21:10:03 +0200
Message-Id: <20240327191004.619748-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327191004.619748-1-ikobh7@gmail.com>
References: <20240327191004.619748-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment specified the wrong number represented by the macro.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
v1->v2:
        Undo macro change. Remove comment instead.

 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 0c12b31c4642..ec9f07a4f769 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -47,7 +47,7 @@
 #include "rf69.h"
 #include "rf69_registers.h"
 
-#define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
+#define N_PI433_MINORS		BIT(MINORBITS)
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
 #define MSG_FIFO_SIZE		65536   /* 65536 = 2^16  */
 #define FIFO_THRESHOLD	15		/* bytes */
-- 
2.34.1


