Return-Path: <linux-kernel+bounces-89080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DACF86EA46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CB4B26610
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCF3D0B6;
	Fri,  1 Mar 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RDfXWhiN"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B83C48C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324752; cv=none; b=Cnr7Cc+CfIdxhFk79qgMqtkRKanZvRrOFjZBcYVkw2N1seejdGqyaH8xHTcP9vYKlEDqdocN+S2vLKJp0Utpu9YqGKByKZihxI5/z/Lz5Au8SXg1DEMXWyvGe5aCJvuhIr6s/suvoi93tIyhL0O3HnvSylRrCJ2e9CIqB9qAGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324752; c=relaxed/simple;
	bh=Nwtado1oao3+/dr6Ja7f0D8y63CaM4wWirvmaJDankQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9GuvVjxN0aSzw++yI3J433/TQ/Jpni81kbTCTRcO8+7jxkfDizElRbFM/0NCm68WZAS4uRbUjNktm62OyzIg1vyLnqOT/1xwz0KiwvrC0j8fPFjKZ1PRCf6KqfC5HdTP2LfK+zS+gpStfVNbO3+mIVsy+AtPFh8ybTnTO7SCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RDfXWhiN; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e47a9f4b70so1358035a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709324750; x=1709929550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N53sN/U1+xpmw3mnYyTxppc9z7x+jOYBw1SYOpnydHk=;
        b=RDfXWhiNKyfc+QRNMmfesLFDocNny9FbkTUtO7mNG3PQ1YF5IqSYMN56pwe0J7s3l7
         Zp2zf3QEmYmM/T6IgzuPuB3fc9aVrWj7bUCZPyh2Uamq0BbeE45kHSoMZF2TE5DMer59
         AFXoJ3TeDcQNlLrjbc+ZOa96RxX4fNC28ZFCm73hUp9E6lUz0AcMQV+K6+OeU+MOeVlv
         JZn12Byl4ovcBf/+opEoqWdUw6w9y8SVOJxoj2vnTJi39ip/cuGAKoxaBlOckXVnKyhl
         RWVNR/9NN8nomqrMpg4ZKYXcMn4fik1B2ggHCi/jTkidN8EHH519sx4AcAGeYf0X6yIS
         b7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324750; x=1709929550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N53sN/U1+xpmw3mnYyTxppc9z7x+jOYBw1SYOpnydHk=;
        b=Ub/5sqqV15r0whg/5sRGZa+9cljCuWnDPvdq692BRoqBtQ1shnkgHzI548cNj3qnPR
         qPvaeVa4jJwF1zAne4rfd4fr6nv3tu3xlcy2yfFHQxh20pc7+GE+Vh3AGrTi+d1BFz1P
         QBVKdmfMXZyu7L/86EkNAQUj6U3JaKlZoWdXw8F7T2X3qmDAgH5e/vNs4CCC/5XOKcMn
         ovKTcnbicwm7rGSIVZSv2q/WPP98A484xiqGrtKruFpPDhbBBygVtAW6X3/zGa4uoKXs
         o4jBI00TGCZfHt088BJYZPdLLltRsAoSf/o0l2cuTJ6w+ZrDJsHmymGQC5wwv0sODeJR
         fDKg==
X-Forwarded-Encrypted: i=1; AJvYcCWyZOs9EvqWyytlqG44E2aCGOEv86R1IueeTMWCA+KBwuO+NA1wZ9LYDREmuSD8t8Y0El5i5FLHUc5OFZQybEWtU3IqsxYYcI8dAZ0D
X-Gm-Message-State: AOJu0YzFNJO3mmyJdwpL+4TNIpCWXLADHyUTKMX21CYsoz9+HpI12cHc
	ipKvn1RfAMXsMFENI2aRgkmSTnjNdJeaLtCLmL1GLq7cXgWQHTL8pilbAuwYgxo=
X-Google-Smtp-Source: AGHT+IGk9Oam5NAqD4qbTMwFeQNceja2+ofM48cakPFOdGJ3lIgV2fOupeQb0XQ09SKibb1/IWoN/w==
X-Received: by 2002:a05:6830:39da:b0:6e4:d195:ce91 with SMTP id bt26-20020a05683039da00b006e4d195ce91mr1043577otb.19.1709324750356;
        Fri, 01 Mar 2024 12:25:50 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e454aa54d1sm806213otq.56.2024.03.01.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:25:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/3] spi: axi-spi-engine: use __counted_by() attribute
Date: Fri,  1 Mar 2024 14:25:19 -0600
Message-ID: <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds the __counted_by() attribute to the flex array at the end of
struct spi_engine_program in the AXI SPI Engine controller driver.

Suggested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index d89f75170c9e..e801eed820df 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -75,7 +75,7 @@
 
 struct spi_engine_program {
 	unsigned int length;
-	uint16_t instructions[];
+	uint16_t instructions[] __counted_by(length);
 };
 
 /**

-- 
2.43.2


