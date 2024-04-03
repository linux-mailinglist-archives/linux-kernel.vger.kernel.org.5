Return-Path: <linux-kernel+bounces-129792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03366896FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B611F28627
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1FE147C89;
	Wed,  3 Apr 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXWddArO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52B141991;
	Wed,  3 Apr 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150151; cv=none; b=PCuOXxYybnZV9/8cOd3CbPQOJvn/hJ/AHl+sIw57Y3SnS18tMVeM3Obfe/O89iZZkWSQUBXlMAL1tVQNDuTTltFJpTd74L2DlXZsvPZfFvOpZSXyLfcuXXirJcvSa9J5KHAod87dpq6wrYu04QvtJx9uqM8k4hGaNcZQzVWzMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150151; c=relaxed/simple;
	bh=NwuOgeSZZfuy/bcZe5g5vIbq4ic/8AeLqX7XSqcwRWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FPJQiOuqsYUqIqsK47/r3ixUPxDAWeX+wNoGItBoR7KJmc3FIIUFGauJtyUyOaXVsExzHuuycvnmeJ+rTGOywthIWcvjScqs+wAHkQ0dxFC5phUdH7eLbEdOcCikiWV8Y95aJe+BtilygFsxTJJ+Izrak+duxNo5AAzGtgOH6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXWddArO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0d8403257so49679435ad.1;
        Wed, 03 Apr 2024 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150149; x=1712754949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHeGHNpRkBLOu8kBNyEl+Q1XXeuLyPUmsIwfIXB3dAs=;
        b=RXWddArOFexplIpP3Tv80s8NvUL9Xp9nHfmV6+U1KdM/pJRPjS5BKCnGdTnIq0G3Pg
         EKAkP6wmJWUvNLrI5XIUi5WnVGKuv8HlAvL0YFIFcKf1ecscNtv+IIyXkh4/ljzkkwHL
         0Zny/bwzbiW+FyJmnMZ4bC3PiuREaKSx/tWMmwZFwt3krHUNs+1YV4cV1BPvPauePoHa
         4SFOC2vTKiUagNjfL8qcb93NngRmNtIzo353XcOzQyEeR9xGCMbtKnBRNN5sZtYzJL4C
         akC6Nd18MizjXSIpUHfAyuPwTjijqBDrjsWxj6rZZetje8rTwcIyacnx7EtiL1RIV5GI
         w7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150149; x=1712754949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHeGHNpRkBLOu8kBNyEl+Q1XXeuLyPUmsIwfIXB3dAs=;
        b=IsOXx6UgoFi0cWszjUKsnhNLP2fhVKkh1N5BcVPN5qDimKb/0vBIDPFkTSpyvdorMR
         Q30hCfNwf+pmRBsMr5P9Kgw0uoGKvTxTal07sdK6VMUOGglCO9TEHrpi0uuzurY6sfuw
         1r8KVZR8ZVe6DdGXv1oOUW4pKALsTp+AT9ZHmZBCXmDMO17lxP9HGvZMGiQnQmo8q8KN
         Z5zfTc321Ps6P+NZ6d7d5eFl4AEIH0Y9wvr4YB7nLKWIY12fEZNaCV4P1LsoHX7EhMn+
         yjDXnZCASWvbMBzd0gZBLSozh0mSIob1E/fx9wkswZrSGSGPdbEc2gfegxlfqQpuCeOJ
         MqBA==
X-Forwarded-Encrypted: i=1; AJvYcCVTS0RSm7xTo9zh5nXbXhqBd7HuuFuG7rWhGDdVBjG71xs2RLwxJ039f9M5AlySI4V3SMgpMqUbik7nU+zG/wjxdM7E31k0lgKBinfLMG9Gm0sgLIqoSrtR7+XJQZ9+xI2tKw==
X-Gm-Message-State: AOJu0YwdztzjycjPH0wp7dP2hQmcClapp5ChYdny/5roToxcfLBRFtY/
	W/85BYdXfPny07khB6VQdARC7tWsM6U4nIHgBNI+ix9tZvJwe9ocVT2DBv9u
X-Google-Smtp-Source: AGHT+IFTBWsvCk3AK9wrix0ySDyfm5TvC3l3Jo7sBwAiUWtQCDbHSXBu5pKcPVHSwGLKJPaxnEnEBg==
X-Received: by 2002:a17:902:6546:b0:1e2:6f09:f4da with SMTP id d6-20020a170902654600b001e26f09f4damr4362295pln.50.1712150148673;
        Wed, 03 Apr 2024 06:15:48 -0700 (PDT)
Received: from rigel.home.arpa (194-223-186-215.tpgi.com.au. [194.223.186.215])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902784e00b001e010c1628fsm13417604pln.124.2024.04.03.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:15:48 -0700 (PDT)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org
Cc: Kent Gibson <warthog618@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] gpio: cdev: fix missed label sanitizing in debounce_setup()
Date: Wed,  3 Apr 2024 21:15:17 +0800
Message-Id: <20240403131518.61392-2-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403131518.61392-1-warthog618@gmail.com>
References: <20240403131518.61392-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding sanitization of the label, the path through
edge_detector_setup() that leads to debounce_setup() was overlooked.
A request taking this path does not allocate a new label and the
request label is freed twice when the request is released, resulting
in memory corruption.

Add label sanitization to debounce_setup().

Cc: stable@vger.kernel.org
Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting the interrupt")
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index fa9635610251..f4c2da2041e5 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -728,6 +728,16 @@ static u32 line_event_id(int level)
 		       GPIO_V2_LINE_EVENT_FALLING_EDGE;
 }
 
+static inline char *make_irq_label(const char *orig)
+{
+	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
+}
+
+static inline void free_irq_label(const char *label)
+{
+	kfree(label);
+}
+
 #ifdef CONFIG_HTE
 
 static enum hte_return process_hw_ts_thread(void *p)
@@ -1015,6 +1025,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 {
 	unsigned long irqflags;
 	int ret, level, irq;
+	char *label;
 
 	/* try hardware */
 	ret = gpiod_set_debounce(line->desc, debounce_period_us);
@@ -1037,11 +1048,17 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 			if (irq < 0)
 				return -ENXIO;
 
+			label = make_irq_label(line->req->label);
+			if (!label)
+				return -ENOMEM;
+
 			irqflags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
 			ret = request_irq(irq, debounce_irq_handler, irqflags,
-					  line->req->label, line);
-			if (ret)
+					  label, line);
+			if (ret) {
+				free_irq_label(label);
 				return ret;
+			}
 			line->irq = irq;
 		} else {
 			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
@@ -1083,16 +1100,6 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 	return 0;
 }
 
-static inline char *make_irq_label(const char *orig)
-{
-	return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
-}
-
-static inline void free_irq_label(const char *label)
-{
-	kfree(label);
-}
-
 static void edge_detector_stop(struct line *line)
 {
 	if (line->irq) {
-- 
2.39.2


