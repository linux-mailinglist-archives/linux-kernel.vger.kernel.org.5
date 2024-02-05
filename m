Return-Path: <linux-kernel+bounces-52640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65B849AC7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB921C20AA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051E2DF73;
	Mon,  5 Feb 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpHrPGT5"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30511C2AC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137130; cv=none; b=KsSKxcYWJvf9o4LvoAO0kqhVXg9UqyY+mw7v2KMYgXoc/GU2hQrGGjutljtNVxA7fwlUryLK3dcf9y91bC16q3UWhgrrtbPsHzxoCBngExddjLqu+R8M7U3NPf6CeUQfj+TnEnj4dfq/oL0i11AshVEwjuIdwNEvfZ6X0Gp7QmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137130; c=relaxed/simple;
	bh=bjmGyFjFxiqioAr4g1XSOAGWrQhhKSgwyKFYExhglLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGHVTi4MVVJKEv2czwopHFR/qrSzoQ6Y8UhTvwRFDV2pz/rBmALkQZQ6yRsMvRg9zQZoexJ3LAvKJWAxb+y1fZ1WNSYDu8530YR1CDcF7smQQEF8aeeATRJQZAV/W5y+2p88p3eAU2+7T4fv1TZniqKptLhPw2gUUW8U/0fKrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpHrPGT5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b29b5ea86so1439820f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137127; x=1707741927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtonYnG1zvMSmP8RYe4qSrpkG7WWpwfs2mfkmLGPi30=;
        b=mpHrPGT5UJr0ovdh46vE30EcjQcYYa3XvWTOxkNGyHjPL7eDiaZmO03fDC0wBoBgC3
         YJB03qV/99kbTQxc36QqNypUXjXmNoKQAdPhW5k0c+mwbUU98ixUV6nkc4yDSJSQysbD
         CNZwg7tdkP1eolshfqIU9GrwsQOU+Wimqs79/a3gMdPw4XWQt+b+Lf1vIJshb1IbLTAs
         PwWWBgkfHTo1WkBn8IRnSq2R5HYnvdDJPAgxIgYw1PvJXCVi0CUImtnC/LqZEqaecXN2
         I/2h/c1JxSRDUDXRg8YUW54MqFYGxwkwXDV6CLDf/dMnij77NCcLt7SERVtNnCfFiSJd
         fCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137127; x=1707741927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtonYnG1zvMSmP8RYe4qSrpkG7WWpwfs2mfkmLGPi30=;
        b=UXXiBFQBtlFuVfoDFQc5Lnh/fAoUmNnOgv9h265yLq5NDGZIv7rvC4mcwr9jm4Gb6H
         WjCVjWIzoyNFylgOMlSK4aJA3q7GZ4PVkHKBYibq7eHCB44udVi+7LbhR4fu5sVo6uGD
         Gi+PB3p23vdlOIMO0BAxu9vCpDoWgaRM0p8rsJdX/zZHYeyv2UFW+6KdIxnKHITFH+YD
         O/u/e+d3AmluPziFvrF4MHhJq7CGuyieJRa5NQkmXEX1C9r8aSW8zLBA3+tYGs5LI/ut
         IukxvDjDRdEpbamwnmlD3osSvdMbSukYwhIy12Ht2c2en6hWVy8mq/hB6mA9SXNEh6SM
         JRJQ==
X-Gm-Message-State: AOJu0YxPwvl3KoEkyhLu+pN5bk6v1Wl/7q4CwzhMDJCY6saG540yC4dC
	/Voryqk4GcEIDBZApQCNzXRN+D8jgHIbKb3iaVR7We7lfVVMv54F/9VO7vNNIDQ=
X-Google-Smtp-Source: AGHT+IGvOiXo7HPcAuCueUfCXl+hW1dHjHJs0oFybOPNePVj78Eq7mqkrITmY1dHKEpvtlR/onCLSA==
X-Received: by 2002:a5d:628e:0:b0:33b:1494:e4cd with SMTP id k14-20020a5d628e000000b0033b1494e4cdmr8738260wru.3.1707137126957;
        Mon, 05 Feb 2024 04:45:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnB2TnwxP2m+P+k2osg80LUiFMk8AYW9KKJixyKCil1SFvymbNwDnyv5aGOLjkdFIIat4WmSO7a4JXLHXn3VISSvM+7RVQcg0Pc0Fb9CO2WjD9q2jAPVAk+Y81aHewTEE1IiAUbWO2KdsWTh+EVlqaA26G3INEN+MW5DD//ZHCIBgpkDe+Q1yXqKZwi7+TZV6oZgWxpLWtlnC/vbOnnxR5hsTMrwcDUDdAcOhChiLGv2Cy+Fee/HbCH/Faz0FVfeE/fIgfQU1IizkzZZUkIk8biLIW2rCUJFI6sj/09hijvYqXudHO+D77AWOHBK8Jgy5aZtvLBRys53v9c3/ru4AGJtK+iGd5tYVFx0GPzDwqTGRYDcIPSQkBIOWaeLWHB0eNBql9MhxloRoKEj+AwfvCosH7A5tKS0fuUekbdm/MbC19l3fiGQbqdyjkJ62nOFmMU5HkynyBAYQUxajpBYqcz0FL95kIBqlij49YqJmlZcSsEDOd9WIc6DBH3g==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:26 -0800 (PST)
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
Subject: [PATCH v4 10/16] spi: s3c64xx: propagate the dma_submit_error() error code
Date: Mon,  5 Feb 2024 12:45:07 +0000
Message-ID: <20240205124513.447875-11-tudor.ambarus@linaro.org>
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

DMA submit should just add the dma descriptor to a queue, without firing
it. EIO is misleading and hides what happens in DMA. Propagate the
dma_submit_error() error code, don't overwrite it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 43b9792988b6..7a37f5d0abd9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -321,7 +321,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	ret = dma_submit_error(dma->cookie);
 	if (ret) {
 		dev_err(&sdd->pdev->dev, "DMA submission failed");
-		return -EIO;
+		return ret;
 	}
 
 	dma_async_issue_pending(dma->ch);
-- 
2.43.0.594.gd9cf4e227d-goog


