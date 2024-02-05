Return-Path: <linux-kernel+bounces-52642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D5849ACE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E00C284A09
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB191CA84;
	Mon,  5 Feb 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeCoFDZJ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F12DF9D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137133; cv=none; b=maD5TSwbN3yg4rURSklVzLdHPMsdQN28Ec3xRRXjEZRqsjWaWTcdaj4xzBJJcJ5Ab0RO7FK2jeX7asjlhEjprCEX6KP/Cqc9NDGEfvkTKWMu8h5t+78QIXkmXI9SgJ5QjdLOE+iIqUPY0oTgYTsbgBJMm2ncXj7qQHfZDKxTvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137133; c=relaxed/simple;
	bh=GGwL2SYhaZcDhgFBzqCu/yNX0n9hK+RzU0b+WitgpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN4tYfCDfEjhRRqyIc4EpHXlghQC9SpP284NRREXhOLDIasRl5S4K9KvBHMdNxBYMj//eW6jqSLKIJe9HCJj+ZH1pTdiN6moBNSSZ4/LeBnNJGfW/Md2ZN3iAXqydIn1n3uOifydh108bY1+dWvr0qIdRE95Yfrd1y/e10/pTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yeCoFDZJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5114cd44fdbso1945135e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137129; x=1707741929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeZOS2Z+VG4P/iRAp87EuShVVs7fGWt6JlzNyGBkAOc=;
        b=yeCoFDZJBBjvF7Evx+Gex05TZkjECl/Eqv/i1/P/eWT+aqXssDO0hZ4OHh3HfEu5n3
         9modg+YVtYuUQvojZ5+8gCvPBjj4nBeTlnHK6LsLOzesZoii2p6fE05k2FcSc2dI9Duz
         encAMQkEIqXbnSwuy3RCtzoljYqg/6LBGShsTG9AyOwocXyJ7krjT7zEfzljcYYFpv9U
         zL9yTFVMMkaxDgOAGC63nwtKLtDltHD8+fMcYrO2WvSnk32ZTWWc45L58YWjjNuLEPOx
         Igu8ZE3WCLJwD5n+wog3Uys7TYiQ4LtFb7GfJnQ9lECC//is28pDUU4ns8A9soWLBtu6
         CD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137129; x=1707741929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeZOS2Z+VG4P/iRAp87EuShVVs7fGWt6JlzNyGBkAOc=;
        b=sX4D4dsLixYNthEPj2X8yEcfFz+J7lj5TZAxBuqeMigZjFm53Zapks7tSn54MbRWrS
         82oJDjjG/JvRCleTN1WdDD9Y6rGHSAF8WXB/LCBnJ8DQugtbzbxkL+PAIML8QZIiNOzM
         dwyplRr0XlvMqdMIdM1K6BXp8t77kfK5L3EJsQteVm2iaxjt393VjsfSGeKP3e4IpOOq
         6AX33ztabjDCdhvPxDuyrgdFksald9fQi9ZNDFZWKQO2b1j8K/d+P/CD0qIOY078qSHM
         ob/zTYAiaO69+NXS4Uts4vYmtuoMAFiS0RvTbxJFFpwVPjWuMzSs5d0tl4NLuDs91BUX
         H9DA==
X-Gm-Message-State: AOJu0Yy+frGS11PntjmUAFWJlXhc4sQRn6wYFjNSCkOCBZ8KtTayNujX
	GDaD6j9gNkRqAiH6GhbUo9qN9KpF1cuqwNfgugpGh4HPfQRHCfby7aaHZMJ4U6y74XBs1ZfHcQK
	+cXev2w==
X-Google-Smtp-Source: AGHT+IE1mZbxXVQps2jZE3OUPQWt1FaUJXLkEeIn02wh0XP0QYhwUFNqTyidAJP44tKJ7W72VSQ+Wg==
X-Received: by 2002:a05:6512:b94:b0:511:5328:6f5b with SMTP id b20-20020a0565120b9400b0051153286f5bmr1349244lfv.53.1707137129604;
        Mon, 05 Feb 2024 04:45:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxyPgcgxfiE+kR7RyEi6zp53fCuacTX2viE9B5R90V9SyGN/7KRwimz7oLuTFX224e0mH+u/tSXCoq1cSEwBorkzsCwd3cexHCa40WP3rZhgXKNoXdij2lelf9q97xuZbLOwIqGQfF50hoWChBZC+0w3RSFZRBR4hWRKaWnXaV9FU6UpnAWNBP+B1UO2RWHTFKKEGWS1P4LwMUvxD0Mzn0+YAk0Y1j2WIYdb5assLOxXZSG3XZ8e4WfSJ15Bwf606rnIZHDSuWbd8lBOH5RZTR/03gsZrnRNoPZHRrWU+iLqrDJXp26rLMeQ8jZOkFjHrK/dmz6ulOICea4Uc1AO0brJm9Z14E1i/x2lLtCOfeyMfWeQ9V+j1s2kCxHjUEETJG5KgDBJF+B5GswQnoet8g3nuQl6u3BU4TO/dzk3K0ttwfj5g01hfGBsyNYSSHHKUv37Rz0YA4zsxAZ1FodqoTnjX7LBdvADzuv6ZsGads7ThFJrj0kRRm7tQgFw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:28 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 12/16] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
Date: Mon,  5 Feb 2024 12:45:09 +0000
Message-ID: <20240205124513.447875-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ETIMEDOUT is more specific than EIO, use it for
wait_for_completion_timeout().

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index a51b5ff27d5a..fff430b9e849 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -526,7 +526,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/*
 	 * If the previous xfer was completed within timeout, then
-	 * proceed further else return -EIO.
+	 * proceed further else return -ETIMEDOUT.
 	 * DmaTx returns after simply writing data in the FIFO,
 	 * w/o waiting for real transmission on the bus to finish.
 	 * DmaRx returns only after Dma read data from FIFO which
@@ -547,7 +547,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/* If timed out while checking rx/tx status return error */
 	if (!val)
-		return -EIO;
+		return -ETIMEDOUT;
 
 	return 0;
 }
@@ -577,7 +577,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	if (use_irq) {
 		val = msecs_to_jiffies(ms);
 		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
-			return -EIO;
+			return -ETIMEDOUT;
 	}
 
 	val = msecs_to_loops(ms);
-- 
2.43.0.594.gd9cf4e227d-goog


