Return-Path: <linux-kernel+bounces-84105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7886A278
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B05B2FC84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D447158D79;
	Tue, 27 Feb 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOPsbWgN"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB041586CF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071856; cv=none; b=I2IKXoxsNgwf5hF+HRvLkidlDAXyqsswF/7GIOTpai23Vb/ygUSilnF1SVM5TVY/iYjhzB8mrZwYKxx3aaHlF2BGmZomYiYD5Sug8DcWMsOGYbcr0jBvyJEhna1IDMexFUWSYx6hJ+mgiSsppKNMEFw8N7qTWTmwXy4F71nY8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071856; c=relaxed/simple;
	bh=6ysg+o0Q0vjgeb3Ub2WmvlFjV3vQ+V2XEH/LWmQtAJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0jfaKtm4+5JjrtlY93v5vF4hw6p1+U4LxgkOY6UHaJ6DkyV8jEf+DS5g5MLGVMDDzF58uYzqzh698piZU0tead10dt5bYhJrzpLK9GK0QuiHJHRe6PmJTnTdTjY7KZmvru5kgZ0gAkGd5j/grArERIfrRYyKAYi6UOoxiNmGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOPsbWgN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ddd1624beso142650f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071853; x=1709676653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j82VF811BuKi5ly+pi6Q+j5FxiMcza1ds+iHobKFqbw=;
        b=kOPsbWgNz0jtWW73qcYDwpPQWEOkaFbRKEmAOgoqIBbew4uDm1snqaWS5JwWv0o5iS
         FsVIUhxBtmOE2FgyboMOmsRRQu5Gwj2Tl3SqtORMh5MV5XCM4X/UxVw13ASz89hQl9+E
         ojKCM1JC4ralDCID3XZAxTjax1+kJrjzPT2S7COHS6o1l6ovyzvQA5ezR+Ly7BaMg3Dn
         IcX6bYTRbCEmGDx+VZ3KIjfIF2MQHmzJ+bpcL7RhaZXkxZ02l7+r59t7YP8MSaF3Hqib
         avTrXEVB1OkoG8GWMF3427m3mR3O/5qiLqRFjaUf/n2slqk5JdcxyXHMGALSf+My300x
         rhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071853; x=1709676653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j82VF811BuKi5ly+pi6Q+j5FxiMcza1ds+iHobKFqbw=;
        b=OahggbrmJBAjlpR68jeR1Z3xbEnluiQZZFTU0fnog2QCoEczX9ONIJesYa83tgUdhM
         liuXEZHyIQzdoidZ7n0iEKrSGlrQjkxAS2e0P78pRbLfdP3Jjg+GxqpK3lSOo5UDqAv9
         aqYtYWMvrNYbbnZd5/Dw2iY76g9LC/REm++gluOLyTmjNfCCEMiqmWCV8ugS35kQfdEJ
         /rSBCxnSjf9FMa0inKQlVu3bhZT0rBo820pqOv3Z6VMo+3wpgXxxQDW2VpG55V7Qjcf2
         cEj+l/ETYrGA/mN/dCz0WZaT+awIc8zz/90uQiCsy3QnK297R5T2jT8rytkrUSD9Ahd6
         dzrg==
X-Forwarded-Encrypted: i=1; AJvYcCXgV3Fxg7R1LN5Og1CjTMDrlV4idG2pclw2Pj9KcQWE/Bb2xXPFku9p9okZeya1n+KVYOWeNjOHr4Jp+HTvJdRexYRoawbzEBppC1z3
X-Gm-Message-State: AOJu0YyQt2jV2C9TB+e+dCdIyf7S3qj9Is3jsrJ3dvadnWg6TixI1LgG
	ksgQbVt6jUnfbTSVUahyvUj3Ya1M3jFtU/nWKO8G/Rey7IwoW5Pv
X-Google-Smtp-Source: AGHT+IFnm5CgoXpjkoOGc+8NXxBEfljeWrLa1V6gUofvLnYG1AdqxRTRaIhPDPhqxbYMDfZu+me7OA==
X-Received: by 2002:a5d:50c5:0:b0:33d:545b:a33e with SMTP id f5-20020a5d50c5000000b0033d545ba33emr521008wrt.13.1709071853541;
        Tue, 27 Feb 2024 14:10:53 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0033cf5094fcesm12562384wrc.36.2024.02.27.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:10:52 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: pi433: Move FIFO_THRESHOLD define to source file
Date: Wed, 28 Feb 2024 00:10:43 +0200
Message-Id: <20240227221043.532938-6-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221043.532938-1-ikobh7@gmail.com>
References: <20240227221043.532938-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIFO_THRESHOLD is only being used in pi433_if.c source files.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 0ec3130225db..b6c4917d515e 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -49,6 +49,7 @@
 #define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
 #define MSG_FIFO_SIZE		65536   /* 65536 = 2^16  */
+#define FIFO_THRESHOLD	15		/* bytes */
 #define NUM_DIO			2
 
 static dev_t pi433_dev;
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index e63e87fd6cce..76f0f9896a52 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -12,7 +12,6 @@
 #include "rf69_registers.h"
 
 #define FIFO_SIZE	66		/* bytes */
-#define FIFO_THRESHOLD	15		/* bytes */
 
 u8 rf69_read_reg(struct spi_device *spi, u8 addr);
 int rf69_get_version(struct spi_device *spi);
-- 
2.34.1


