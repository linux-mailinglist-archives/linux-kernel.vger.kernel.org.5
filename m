Return-Path: <linux-kernel+bounces-90903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01547870696
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446B8B25979
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB624D13B;
	Mon,  4 Mar 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HIh9XJsY"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AF487B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568418; cv=none; b=mN5adOE5T4O1LM1G7Zv9FxGsfpgP31fd6NhYOhzqbXhjcoyacEFmmF3HVe48MEBGGdzZgVZmENgwWM62L8Rfva0GNNoA2BLfK93eeXcsVeIELd+e0GX+mpzgHG/cpLw0mzCdwL1GBTmKDZWc1+o8NNyyh7Ytm+istDLhXnZCgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568418; c=relaxed/simple;
	bh=HDTEIEeTth+YlarlZwpbtqNSffqitQLrinmgPBP7yu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpU9UR5tQLrmZYVkDIYMIgrPVW16wxuVgT5stO5clZqdaQXLC/E7GZTXkMQ5iUwHcUFdfdEY/4cuCAlYjqSGrR5vPY62p0j65Q1BZDjyeOjkuze8zTLIzWEt8OELXLGtyArTNFFdcz9m65NpujykAzEi1iaHzhMuEAAQI1MWsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HIh9XJsY; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21f5ab945e9so2306817fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709568416; x=1710173216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn3BxlJjgBPLtIhw8+vZTdHKWgVz7bubHMhhj+7dA28=;
        b=HIh9XJsYBqEMYRZ8eqTP1tlbkwygZg35Z15NyWUUL9pqFI+K7BC8nxqaRJCUP4bTYa
         fJNFOGfr89S6ZL1dr12WqBLdhoRmjg0PRO0L/Z/tc5HgQB0DA59XtGE5yZKpLjA720Ll
         kTNbBKV90lMMKndvzQ1EJU5DFWuP4+mZ+UivCTHTfN2yywKjzrNayUQh/+JfvQeQYHO3
         tdlRTiY6oiycYraN+2Pa97OQEmeseynPpZ6Zk2HfrkQ/Hij0uByIY0JQivFE0eVqJnUo
         geRetPZWlRrrs22mfqNq862Lw3xhLMKRbg4K9Dg/1zkvr3BVU/X37m3NOYBtGT7c5ixA
         GXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568416; x=1710173216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn3BxlJjgBPLtIhw8+vZTdHKWgVz7bubHMhhj+7dA28=;
        b=BNjVU2CHtMWAzYZWlt+/jC8MOWwAmb6lQwspv+KIN+UdyJc4t/gIZbrr4ovqIpg7Op
         E7uoHGC3/MktCvliY2Xgc+Q/aze6kmon3maRIlowaC3U/obb6LQz5nOFvxC3hX3vfOYK
         FtP5olCHSATz0Ufhm5j9A6uEa2LOc46OJrP1qspL2iRQ6cZLL6gVSysKNvxi2awybHC0
         ijuIf3ZWs8qxqeLvSOn/4fNpPMejkeUn4HGju4UwNm/TUOXMH2aleITpRyVe4wgwK/Gb
         N6w+Lm+iplQq2AFzuPUm8ujKKAIEdbdkxXgjG4HdD7HH78bpJc1s0jp4SKxGVl75/DsH
         Vlxw==
X-Forwarded-Encrypted: i=1; AJvYcCVuCbdpnGsDkHwicNvX+Y1q4qXBBUuoO6vJ7lVbrF4OnwwmTxQWDlRLyovkFsTB2r84uu+hkFZT4nN5OPwTK1F7tjFW4W6zBDxHP43Y
X-Gm-Message-State: AOJu0YyV53VLzLzYbbXS/1ViXQh2wxbzBxbchxWjCzxXR5PODPCXVFou
	tydhZ7RgjistIMRmFSTysWFNRMeNiotGw7pNKtmnDqlHCcL7wDttTzAgkIgDhV8=
X-Google-Smtp-Source: AGHT+IEf31u9H/Myq6t1QuUwWolHTsna+Q0D0Xy9VLu1SozYg1bm/W09fH44eW599tqlHTEORQ0BUQ==
X-Received: by 2002:a05:6870:55d2:b0:220:c434:385b with SMTP id qk18-20020a05687055d200b00220c434385bmr4105937oac.0.1709568415975;
        Mon, 04 Mar 2024 08:06:55 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id lu6-20020a056871314600b00221287ebd03sm83392oac.4.2024.03.04.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:06:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 3/3] spi: axi-spi-engine: use struct_size() macro
Date: Mon,  4 Mar 2024 10:04:25 -0600
Message-ID: <20240304-mainline-axi-spi-engine-small-cleanups-v2-3-5b14ed729a31@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the struct_size() macro to calculate the size of the
struct axi_spi_engine when allocating it.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index a8f626165f44..7cc219d78551 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
@@ -502,15 +503,13 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 static int spi_engine_optimize_message(struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	size_t size;
 
 	spi_engine_precompile_message(msg);
 
 	p_dry.length = 0;
 	spi_engine_compile_message(msg, true, &p_dry);
 
-	size = sizeof(*p->instructions) * (p_dry.length + 1);
-	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kzalloc(struct_size(p, instructions, p_dry.length + 1), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 

-- 
2.43.2


