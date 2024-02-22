Return-Path: <linux-kernel+bounces-76977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 850CC85FF51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158F6B2306C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E9156960;
	Thu, 22 Feb 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is+kwkLo"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39952155303;
	Thu, 22 Feb 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622940; cv=none; b=TBIWNvT9CV0CU5UDj691KbnsJPrP4txqeBlz4U/2EugniFuQxzfmFIlwZcEhyV9Z5JiRfEZX7ttWhze2+t/yUbf2BGpzcYu7cvhYE4E3Ui5q1axDxlTup934kqIUJtbDsStGhwHM5XSya+E5IBtzwGuGpR09PByjSqYP68POqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622940; c=relaxed/simple;
	bh=K1UkPr+qwrl0AxN89XM75ZcSZhSG0ZNbLMmfwU7qP70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhrXSIorcTFChyhhOyDHC/RxbOGfTxuA/0xV9ZqVEf1gclOtQcz1pS29Fzpl6MgxUar+JiM7L1xndRptetVj8A1xfTrBX/GVWzqM77i6wo44Yv66WyrjtEw7wOhbMoQ3DzLSDWKWbSGoUk4BeOX7X16vdLsZmyt6kVV2siyKlxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is+kwkLo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d2531294faso120251fa.2;
        Thu, 22 Feb 2024 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622937; x=1709227737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkIadt0nAZR1d0O39/7H5hjsJWBN2vmdJ6bdv/9nuZs=;
        b=Is+kwkLoPJ2ej3KdZeiT+bn9HfOj6r1DE94Tkx1zQzd8UBdPeic+UcaR4On9qZkUml
         HTpwVmwzMHbJEzmvSWNTcJHk2oQMiYqA3kR8LYp+B6EzM7Q8gtlO/x0k6ea6N0d8DiWx
         tlYvByC3PGG+LUrsL1Mx5B7ckU0YAF+w6Z3iZGHPbLyxhFPhTTAcIFNNGIMvcuFv3xtW
         ZGhZlJLKOLzFa1hpn/hOGW7SdQt+8nUAuLsiLoqdxifovuEIJgMoB/+3/5UBfH2zm5BS
         scqFBNFElWibUmCg/3+MT0mo920ZmRUxm7SoGXn+O4P6iX21IES4TL7AHBkbRqEj7/A/
         WwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622937; x=1709227737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkIadt0nAZR1d0O39/7H5hjsJWBN2vmdJ6bdv/9nuZs=;
        b=QZKSBu2XJHAv2KYAIwqN6HiW3u4NHbY8hVnKOvKw0JYPZTcuh9x8x5/Yd7zeKjLt1r
         oyKgWjSnMt/VomW/ylIAnABGLE5EH/OSN2/PUOGq+kKRIwngF2Xyfqruiuoxvl9lMP6v
         mgltghJQCrHV/8m3QpTtfA3c038Y415HSW55qMrcKs5DfcCQpXGjEvIVROVonPz7Ro+7
         MNIvZSVmwV1iN6RNCi+LsInMxVwKvveFvqjp4ai4n0ENl5K1I1fRCCeCpGlpW0mDso8o
         KCYePHSPDEqoH2PuTEtQsFYI9Nsxen3+aOw5PUw34eSXtPH4p2MgM+OJUvHLYeqSWCS5
         llGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0/LFHTrYdqJBQ+wcpET3UsEkVWXUFB8p2POBJTuITnA4ORDIg/VT4aG5X75+Lz1T+M+f8rK4oWz+FoYfh/Nm0uCsUckFBpLwKnGHSuCOR/b3mKT4jxOg7O+0SXTRLpAoCeavL6ScY
X-Gm-Message-State: AOJu0YzkGI9w/eokKa1SFhkKwG1DtwmduDnzAuSHa2yVAgEKcJPAGaAt
	XVGUlWgIzYaH0vJT1tnCyUf0IV/3Hm+ODfDE/LN91eTh7k3EH7zo
X-Google-Smtp-Source: AGHT+IGWZTNp8bR2uQibBqGN1L2Owt1NmKxyQapvJfK6J7h3cvhVVIdamGG05CcQtoHd9CLvYLiyKQ==
X-Received: by 2002:a2e:a7c3:0:b0:2d2:65b9:b420 with SMTP id x3-20020a2ea7c3000000b002d265b9b420mr1122817ljp.1.1708622937331;
        Thu, 22 Feb 2024 09:28:57 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w4-20020a2e9584000000b002cdf4797fb7sm2368004ljh.125.2024.02.22.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:28:56 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] spi: dw: Convert to using BITS_TO_BYTES() macro
Date: Thu, 22 Feb 2024 20:28:44 +0300
Message-ID: <20240222172853.25082-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222172853.25082-1-fancer.lancer@gmail.com>
References: <20240222172853.25082-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit dd3e7cba1627 ("ocfs2/dlm: move BITS_TO_BYTES() to bitops.h
for wider use") there is a generic helper available to calculate a number
of bytes needed to accommodate the specified number of bits. Let's use it
instead of the hard-coded DIV_ROUND_UP() macro function.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-dw-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 0274c9295514..722b5eb1f709 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -421,10 +422,7 @@ static int dw_spi_transfer_one(struct spi_controller *host,
 	int ret;
 
 	dws->dma_mapped = 0;
-	dws->n_bytes =
-		roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
-						BITS_PER_BYTE));
-
+	dws->n_bytes = roundup_pow_of_two(BITS_TO_BYTES(transfer->bits_per_word));
 	dws->tx = (void *)transfer->tx_buf;
 	dws->tx_len = transfer->len / dws->n_bytes;
 	dws->rx = transfer->rx_buf;
-- 
2.43.0


