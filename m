Return-Path: <linux-kernel+bounces-56451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4157D84CA54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC83228E6E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA41B5D725;
	Wed,  7 Feb 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHA7CYIG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619B5B20F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307496; cv=none; b=niEV2V+Z1ne38D+lzAKbeqq956FDumvYIoRsIpNbygm+eeUQv5jNWl99NjuMxFLcI3e6mx1jWYS9730wvICe+A5JsZLeQJwhef2Gy9Y2M0rGe6d++PW/o33lrmRn/3/Ye8KZy2jIojsMoe25LEB5DPpJ7x5xjrLyxyKuO6OSnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307496; c=relaxed/simple;
	bh=m1U2ibNS2o4vQmNNZdCySzHxJgiI2IGiRefG6tMF48Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i62mm6omW+8Mqef0HJWJ78nlSODJQPiLefcE1FDHv0pNlOfKSS0oLR9rDcqoKNTHRyf/RkqStpWiFtcb4pETMIRhGuqDr77RkbTcMREWe8faiNKcIKmMiij3RPXUJrSTxsWNZSuH0G/rULG6NvEaTqiOWnYwQzKWTuS9E5rItWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHA7CYIG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b29b5eab5so367361f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307491; x=1707912291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw2MVCnXePoaGoFwhILfXnUXamqqjuyMAhC06ZDA+Mc=;
        b=CHA7CYIGDFaxAthUuyoMT4LtUHxzxqyWQAXJT2cRYhunpf3xXRsmTby+HcFl6n25yV
         HSdwbUlesUq2QerWOEntSP2s+BCvbEYlFYJgqyQWw/FjvuU5FFj8qelh1gp/m8SerICC
         okKnR77bONbx7QOrMEv1NSFYrtmfDfxX87l/yu1Zqv57YnKYhiyXfQkw2MEv3oPSJ0d7
         yIr8+sOnKKPmptxXL5RxHE7xIbuBK5I051Z1sGnR2IidQgW4YTdn9oYhK7iRuJlO2sF0
         Khs4omdTNWL5qiyT9Aa9VZdTRiIb2Pqd9q3LmWbayekDJ83xOAKffIZzMG+u1J6Te7YG
         AAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307491; x=1707912291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw2MVCnXePoaGoFwhILfXnUXamqqjuyMAhC06ZDA+Mc=;
        b=GySNISP/7Ljd2E72KD4RubMlJepI8n6ruKqCyoGKc97WRyV9S1mAVjmWn4blStKWsO
         wHI8dpHqSv7GO7WNyxzpQIOg84ym9XPQklGXL8iCi6F0otXWElzfV+SQlDzvdt7q/HOt
         x92ugNRzYpP5vVFZrHAYcxUNJ2HrhaJUY+8XZIilDAHOI7qhcNgPCS67/BC3oVMTHP9D
         vRO3hXzNm6klQAPUlc+o/rSQ2yFl6nx8gAiQu+r573lOWlDTi4Z7GTXWLOnqsnh+3Kkg
         vlXRZ1V6g8waDfsFJIDupRu2v3PdoNJ01JlnHVYQNChCkrwsykc9DIyODuJARKl0vha8
         /P6w==
X-Gm-Message-State: AOJu0Ywg8n6deu+U/2Fx4N3zlRNosVDZxLHr2TTh0DOMSE6ORc0lIg7D
	LUO9mFQ84W9uq4KUJpF9XR4wSgjmn9Wlqfggk9PcBcFXDAyIljQF4fIgD/6N1LU=
X-Google-Smtp-Source: AGHT+IHAYlMgGVbJm1ulTdNKa/+d0RgWGvnEGEpkGS2NLVlo4ZSIijWb3cfglDfGFwxik/TiWE7lGQ==
X-Received: by 2002:adf:9b88:0:b0:33b:216d:70bc with SMTP id d8-20020adf9b88000000b0033b216d70bcmr3033646wrc.42.1707307490826;
        Wed, 07 Feb 2024 04:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAVMzVycVD1s6muTwkHOso64lMG/emDU5TiblalPWX7ZMHPJ5//3sDLDgEuNNZ2aejKW5KK9QN7rDbCTgQ2Wj/UBuVCg2IXUOVzlU5gB6mNN1onRg/Jsmvj9MNWKST7hrSIBv2qCpxV4AxqG6CDKNAZqjBq3PsymshtpNimVbZJPX4GC7xX/WWsSaTzZknsKwN1XOo5G8bnWTdaVmBfDL/TIeiHwE7NYFnJRI5RXe+k5TSIk4H33xzDkNeqod5v4+3vhsGtBzwrYiLOywBnRWzgl04dRvB5kwuD/+yuqmjC9UqOizl+brwqNY4GqGKADdhdSrMxTH01oc8sE5ntbRmHTtCKTLkl7joeouwRxmGAACiPA6Qq98RFng40UhReyhxs3JGqC4atlIgyOnV7ERYsOdt6gLbFhEJOucDrjhUWqPFNPIJjVRLs6ty16nLLqdFiX+paCeYJouUXhqtJtN8c0Y9l1OiQPYQyCkFWJocTIClBepJQa2sqjQceA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:50 -0800 (PST)
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
Subject: [PATCH v5 13/17] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
Date: Wed,  7 Feb 2024 12:04:27 +0000
Message-ID: <20240207120431.2766269-14-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
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
index 4cafec877931..bcc00cb5e0d1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -566,7 +566,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/*
 	 * If the previous xfer was completed within timeout, then
-	 * proceed further else return -EIO.
+	 * proceed further else return -ETIMEDOUT.
 	 * DmaTx returns after simply writing data in the FIFO,
 	 * w/o waiting for real transmission on the bus to finish.
 	 * DmaRx returns only after Dma read data from FIFO which
@@ -587,7 +587,7 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	/* If timed out while checking rx/tx status return error */
 	if (!val)
-		return -EIO;
+		return -ETIMEDOUT;
 
 	return 0;
 }
@@ -617,7 +617,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	if (use_irq) {
 		val = msecs_to_jiffies(ms);
 		if (!wait_for_completion_timeout(&sdd->xfer_completion, val))
-			return -EIO;
+			return -ETIMEDOUT;
 	}
 
 	val = msecs_to_loops(ms);
-- 
2.43.0.687.g38aa6559b0-goog


