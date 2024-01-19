Return-Path: <linux-kernel+bounces-31032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247428327D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498DD1C21416
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D644CB2B;
	Fri, 19 Jan 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhkE8z2L"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F964C3BC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661134; cv=none; b=MLuFQoxa/URoj6tejG9yxZvISWrcDVgswTBJoJYd6+Ftjz5dGsxlBmvM3hqua7gHVi8OXb/OPA9neZyEhBqgY1Vv4b7La8zMM0FE0lbyp6m/Pm51btg4xNPX38PyVp85aMmbh88a7Kk9QGHRTTdqOPa2oG/QwM12k9B6kdpS9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661134; c=relaxed/simple;
	bh=t7gRYgG5bMRtFTVmk9IzLAC+h3lcEvsViPIBwnpUPb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pogN05ZVP0NCnZz01A0KNrrdc+4t+gWNyOWDpPehv9HZOWWwM0fkRpKddXOrOcmLwkuWS0qhBMfZHBsFQnDnOb3Ga7+QmbnpCt7m2YLUjW8LFvFaMQ5mASyTK7Y6sP/YWqoBaIqvXg0nLHyfTK9TbmzpPzpKSVxYS2aoduCMUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhkE8z2L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e80046264so7273515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661130; x=1706265930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JVTKruPLtxL591cRzZcEtaSDrfblTI6Ru/0UXyWKbE=;
        b=WhkE8z2LZ3XLGVEFQPjgSScKrabwDOlbkk2JQB5HCq65Ztqd1w+1c3s+s1Vmu9rBv0
         Yr3Pp/2oc4eaiaZcCtySlSLf/nnqc2wqvM9uk5WCUTdlBossWZU4EvopMm0LCXt1qssq
         685FcRO0coYPFOJqGMOYbqpfpYkWLOmUjpjF6KQXoHenhB0hgdO/t2rblOt20FAyr7Lw
         mSync90pBPoUY7iB6gQibDHoCkmuhheDbpqZoalnTpTvdcYbsi1yh0uXp9I65xAnN9MG
         K5T+vA/cFnbgWnzMWIvNqvpBVg1FzoCLrURfQJez2evjbnx7CsP1Aqo30rIbMl3wLM9l
         M0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661130; x=1706265930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JVTKruPLtxL591cRzZcEtaSDrfblTI6Ru/0UXyWKbE=;
        b=N2cuhjhNN1e8571MReznFokLYDl3tIOSGtn/Q3SqmdLdwp2jTubAwaggOkxvj9wEF6
         a3VYg7MHyNR0xEgXDJCT8Z6ejfwYc6LXl0F8BqOC1YphK3mOynCYVrcrFe9svf9lBk39
         +gYtXb6aECKC6xxs+l6pkTTFFQNgf9eWVoyeBxAj41JL+0TNyO5TotOyHeVQw1g7Y5j4
         uGBh6brdp/aKqjilFVuZjjI8/A0Qr4C2mclW3ix91gqYjVin1OfYUGUcKyM2aDlEbUMk
         Q9URT/eWNYgUNJEj2yI2mqaiHKRfXffmTgtkqvlPvP/tW8BunGo4PphZFIJcLZmbu2Gm
         FkHw==
X-Gm-Message-State: AOJu0YwOJmqf/eIIZhAD+3Yqrl+JhDH4wLqvd3ss6bcYaUkiYaChc3Cc
	CQ17Ci+aImybBfKH/NGlCqsaDdxeLim9X4z5q+azZ6dtJCUfGJn/ILo8/EvqCyg=
X-Google-Smtp-Source: AGHT+IF68W0CE7/RmrCIDeyTMK59Z+AGRACrkjEoAPxJPcDwNgTNmegWpv1XXTv4rh9h1rjoCKS7Hg==
X-Received: by 2002:a05:600c:5106:b0:40e:9699:141e with SMTP id o6-20020a05600c510600b0040e9699141emr932166wms.54.1705661130155;
        Fri, 19 Jan 2024 02:45:30 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:29 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 01/19] tty: serial: samsung: fix tx_empty() to return TIOCSER_TEMT
Date: Fri, 19 Jan 2024 10:45:08 +0000
Message-ID: <20240119104526.1221243-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core expects for tx_empty() either TIOCSER_TEMT when the tx is
empty or 0 otherwise. s3c24xx_serial_txempty_nofifo() might return
0x4, and at least uart_get_lsr_info() tries to clear exactly
TIOCSER_TEMT (BIT(1)). Fix tx_empty() to return TIOCSER_TEMT.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 71d17d804fda..6fdb32b83346 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -987,11 +987,10 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 		if ((ufstat & info->tx_fifomask) != 0 ||
 		    (ufstat & info->tx_fifofull))
 			return 0;
-
-		return 1;
+		return TIOCSER_TEMT;
 	}
 
-	return s3c24xx_serial_txempty_nofifo(port);
+	return s3c24xx_serial_txempty_nofifo(port) ? TIOCSER_TEMT : 0;
 }
 
 /* no modem control lines */
-- 
2.43.0.429.g432eaa2c6b-goog


