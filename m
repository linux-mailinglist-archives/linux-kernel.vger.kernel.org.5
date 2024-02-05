Return-Path: <linux-kernel+bounces-52644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F05849AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798221F23438
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE73BB38;
	Mon,  5 Feb 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rt6X/xp8"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAC2E629
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137134; cv=none; b=FDTroGyXYz4zVAqhdkQG3XHsfPLmJsrfCsYeiwA9zKAw9qN3Pi97nmvha/NXgxft0ntUm20Ch+ySy20sTGHRyujz82Er80/YH9pOty4GpapW0TJWU3nYvZx76TvBHCIxfBI9K3bjw8YbvCAkiVw3p5nWBWc/jqVNLAcSJQ98eC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137134; c=relaxed/simple;
	bh=+SyzjPnMT/SK+rtssQCg1kucXywzhF3SnUsMWqB5kHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFXrlpT8qrpsoe3bTZyrilocSsMSGX/osRlpI3iI7rj5OdN/4o6NodrKdXoX3TPE4QIMncDpUae3T6WCqZZ+rDxBU2/FFIIcURUJYCwDEgJDfu8KGD3cN/fXvuc7KgGOw/LNs1PY4IZVQuyqbusMhXx03VaQssNdONlT58Mw5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rt6X/xp8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b18099411so730034f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137130; x=1707741930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMdPKuCa+A0pku+lpKMRGIhG3kodHHE5iXFOt26r9zs=;
        b=rt6X/xp8dU8Jcuqj0H9VP/pZ0rtbWiSR5mEI1wWqNQZacpub6W0e8fIDpKGE6TDon5
         rxOkOaSJv5GkzCPf5Sq+Kv+j50iIbMYZhBrKGcBAzQPHd9+4HR25MYnQHYNCTATgWoNR
         su+2CpqPd1AhzQK8WJf4reFISSvpe5QoBBCEhUyoMzXo7ryoNTV9RIecHVXeR2HhMpcg
         r6p3uSSDMDN7K3iLmw+ZMIKRuhvSYaevkqrYU5tEa2+zFbqHLgDf9UY64ALQgAyDyzbF
         Pi+g6pGKY6H5Bmp1z+KWyndgbn0P7VQFI0u4t2Pu7KnPEP2JJ42iU5pA9S3orK1y9yrc
         xVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137130; x=1707741930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMdPKuCa+A0pku+lpKMRGIhG3kodHHE5iXFOt26r9zs=;
        b=q9SIHqey2+7R5hs0e+9HhL+1bvED0jNrylF+P2TUMuLQzsw9YutFGlIIc3XXDETIXB
         eZcB+lIs4xgTQ6LhFOO6QwoNN1iFJIruayECF6O/GQrv1abHrhtrqNwrrcRRWVzI9grv
         s5KGb7duHeO6p2GOlLPwuvsbVIVC0AD9geDDL9ylen/KUXneqH7bmjTGBU1WqjF4Riws
         UJtXvndwGI3OL8dDzivIRKl4oDr+3+lJObUL4WADt+XOcVRNOhaxdSqB/eiZDe23Ln8j
         iKjWmru1k9WNJLhiyGwilFIM2SKGmnjRiFzFPPM7R0G2qhfrq8eRfRdgohL2+uv/BeF6
         MDhQ==
X-Gm-Message-State: AOJu0YxaMEBHYIHnljkvJnC1/LMgS+J6P+zdSNr8kyZcmdV7hgHPFK5o
	heudot54YlQVGyWonGJ1xkcvDSiZPeLf1nxXx2W4JAZHSXjc9HnWWJA8vBJNi9w=
X-Google-Smtp-Source: AGHT+IGossleR/t3Dta3NCg2Z2WPIoqoJE6vcP3vID1Krxh75KjzP3TERTiV74XdiyGuaLtdV0xObw==
X-Received: by 2002:a5d:608e:0:b0:33b:3d6f:7a2e with SMTP id w14-20020a5d608e000000b0033b3d6f7a2emr1870007wrt.49.1707137130247;
        Mon, 05 Feb 2024 04:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXg3qJOH3WJfmlDrm2ZHHrIR7JlWC3n66rAo3+txIBb+YdC1ewlKXR6QRNOinsD3/ORZJtHBzvEvZ/0t1Xnsi1Pc7WBZOViqG6TZhbIrRxPFDFOUWU6t2Aw6WbbTTLkpru1N5NQP1Jm0gPjsWkzx9ma/8bhKWO1YqaDBGuImg+p3Ve+if6M/tXtMWD1B9t1NcnrGaHpoyDuT47xg7eRyMnefKyv5gYPFUOcY6ypLx77FoIe9+ovMJMfwGhXT0rB04bv1GFTgcTlIOqrVbdHhRk1CiLtcQofE5Y6S1+sKak+XYw4qAw0Dj6Re0R1UniB77mBjiopJW8hEqafNZ1d4k0xSjQIRaGwT6g+0iHZZC8BcP/qxQyIFX+nSe/ts2IGcVeLhX0nWuvsQ6J6KgCPkWT8Df3lfnsPT7J5/qzXr56uwXt1/XD0WLlimQ4/XNgc1AwNjJvlRRcOCAlciIkOHFM+NA3Nbk+2bbFTkm6UybgsBtWaxiINQSu2XSz9Vw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:29 -0800 (PST)
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
Subject: [PATCH v4 13/16] spi: s3c64xx: drop blank line between declarations
Date: Mon,  5 Feb 2024 12:45:10 +0000
Message-ID: <20240205124513.447875-14-tudor.ambarus@linaro.org>
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

Drop the blank line and move the logical operation in the body of the
function rather than in initialization list.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index fff430b9e849..1b84f5fdebce 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1320,8 +1320,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
+	int ret;
 
-	int ret = spi_controller_suspend(host);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
-- 
2.43.0.594.gd9cf4e227d-goog


