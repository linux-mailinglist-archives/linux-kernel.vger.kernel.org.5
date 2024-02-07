Return-Path: <linux-kernel+bounces-56450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B77E84CA51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E6128DF92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EA5C618;
	Wed,  7 Feb 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHC9BZ2V"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE75A7AA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307495; cv=none; b=tXq6NFnm1gyb7A0DnV/2GB/a7+4okKM7sQGbmCikDfYMqguZ7vCzmfwAk9fm2Bg+u8UV4swoE3uhsnGzHWEfNI/XIofYrw5TfjimuI5MD8vsHO93tCHuw4hfiN0t5/m0kLirS34t6YWbNFNBJ2m3wLsMyUlH3ncx5/mRnIaoaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307495; c=relaxed/simple;
	bh=UUTdIh3Xj1RnoDrVpRDf7wnRZi1N2KMZYs/hAqRGeLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUOXIdJIx7lfnlLw7D72gIO4OUddRkovK1O/+5MOLuNgoLGyD5h54JwOMfMQ02CeW2YnuFQ9Tzk+nuXz8GSlQUO7WKJ5N59lWqWr5RMNA0NmoOjPaprjX3T/KZjXd8MHZ7JzfFdvjTnjVBTkEX0fmOKNHVvU2XyUzzL7Q3XdmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHC9BZ2V; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b45e8a670so325565f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307489; x=1707912289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyB/rIEWzg0qFsjqRP7XGwF0lM74d/iwYjphW748AMs=;
        b=zHC9BZ2VYIAuvCjT7sGQrvpL5XP0IlBLVfn+E3qKoNvV0C0ItjsMO1huR7mlFp4AWM
         xKhR7vsFeoVDOo5Sq6VVE/YAPtl6mwcQ+SiJ6HEbh1np9Cody/ChjoygE7mKI0CUfKvL
         DWjBbhSuZS1ywJJH1UwWerJEd89cWx5JtZ9wmJ20Sh/D+UOfLcIi5IEoFazw1ydR8zea
         1v6QZYGrU6LnH2lOBJLJz1Cx+FQmruUAhvzgLTIFbWhLl4vESbbyEzkIkeKv6BvLA5ny
         lJMtOGzWSWZjd2gGlUlFZv71ttPkcWnb2G9JtWjVcE/Rspq/w1sc6Ora+w7z+0BpXqwD
         tRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307489; x=1707912289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyB/rIEWzg0qFsjqRP7XGwF0lM74d/iwYjphW748AMs=;
        b=jUYMHyjqD0BhCTrMPFgDcGbiyjGn+tPD8fh5SAfMbvTjuN61bBgrDup24jVjHRaWIU
         LF2P0e9jU5sRVzBlf1YfF0EYkLWKpbywwNWSKAfSxqRIANx9Bms4AP0XWNYQ7NOq/skm
         UD0Phyj5oTYIrFMmMHSnUw6lE7aYHcYNd4LlGm7vvIWY+XV7lCyFLhI008DwXiVS/486
         NK1VxTA3g2miwmO0+fdxYv0CJSdL9do9jTUNmG4NHC0mgMdjxaaZU64GgTc5/M7RBVdW
         H/b8fgYIFGZGIsrP2wiZPbE5PcIR1NUj/iXhxUQHvtSQH787UhFcCpNsAOCwPw3qDv4E
         yiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+VJiwd7wFmC6noJnv0FBULpkpEwHYZFlC6Ag1Vag/ssiChHuQTthboVW9a9eGemK/fA4wEJOxSMShl15Y7OSG/IMGQekA93d9ekkS
X-Gm-Message-State: AOJu0YynEZx6FMwlAyWHUMd7tQFIyggm0j9i4fnnfeKAzplGnoqZwI7J
	2IMr1ywGUSRz5EEZZpJmcnPFdBL1NGscV/SIG5+DvOrzbw8dLsyJV84CWVcDw7g=
X-Google-Smtp-Source: AGHT+IHLdYTOpuM6YVl5VQ8KSmozpR6YZJf1vCyR7Jm7pldciiKf3Zxcsp8BxcHt6HVkzpmmahJfLA==
X-Received: by 2002:a5d:6989:0:b0:33b:1ae4:10be with SMTP id g9-20020a5d6989000000b0033b1ae410bemr3112553wru.46.1707307488917;
        Wed, 07 Feb 2024 04:04:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPoi9waljrhcc9Du9f7ChdJiFb7bX6DdMzhB6TZiVx1S6gG/nPe729BwNqPKcVyZuuPdA0jWoPjSZwBlPwgoGv4/+7VcutaOWWT7HZ/3E8KzjuD0LOtpjL0KJJBvdcnNnl7DjKH9MgkFM+oOQxMagBpYbUSNp+A0jDqH8NN2oxDXjkv9Czp7X62NXW5WDOIraHpUkXlQrhFTumVMhvNi2/fuvQOmrhzuwXTN5b0Xg+BD8zux/iMilXXTbwuTHqAP03e4h0gtwf0TXw8YZnH5aDaUAcLltEVIOw3dI8iuambt30B7iLPUkTQcl5whcPC6+OBnzA0glExTxAon0OgcvfTnCNygZplHw+HOEJkdkfLPNEFmao4a8VIZQiPLVaARwFsy4ppTJHvaD9+xssFBf4zYZUcC60X4vqjIWfKWGON6SA6CBFPOQg56CTSps8XueWb71vVnuDitaohl0PNzBRtFUQfoQZtyrmFl5+hfaKawwtkHi2Hh19s739xw==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:47 -0800 (PST)
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
Subject: [PATCH v5 11/17] spi: s3c64xx: propagate the dma_submit_error() error code
Date: Wed,  7 Feb 2024 12:04:25 +0000
Message-ID: <20240207120431.2766269-12-tudor.ambarus@linaro.org>
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

DMA submit should just add the dma descriptor to a queue, without firing
it. EIO is misleading and hides what happens in DMA. Propagate the
dma_submit_error() error code, don't overwrite it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 1f7356f6e5d2..ba17c5a04eef 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -324,7 +324,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	ret = dma_submit_error(dma->cookie);
 	if (ret) {
 		dev_err(&sdd->pdev->dev, "DMA submission failed");
-		return -EIO;
+		return ret;
 	}
 
 	dma_async_issue_pending(dma->ch);
-- 
2.43.0.687.g38aa6559b0-goog


