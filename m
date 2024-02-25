Return-Path: <linux-kernel+bounces-80233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9042862C57
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811C32813FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5262C1CAA7;
	Sun, 25 Feb 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZY56VC/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5C1C6A1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882433; cv=none; b=b71BpG12jj2GIoB/ysUdhj+qNwwUYcLZwWq+peKbNNR8P54iRX+4l5jO2JUhzxNdN5jloG7y2/7NRiCRHv0s3FD42WJjzoHLTyA8LCLJJjWS8B4hPSUe0hzbIx1yORdAkGYQIXthcx9HvgvukonaHzLEC3RzOk+Do9gooOfJHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882433; c=relaxed/simple;
	bh=TDp9wJFgJFP1/5qnvZLn+D5nq97yBt9qKvB9FbuNoGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApFmZ7tfZRmSgqOORn/DPdeDxjS/HVNrRwuPckDAizat6XYd4PtCaEbVnLrbeqIKN43qrBfBuGtOGDK/HH1attxhQIWUPR/aq2n1LOVVZEKlIRctIRUYdkIvzuOC5m21equX+6os6bMCJiIWu8u+w26JiZQAktpj5+kJSompZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZY56VC/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a57823b3so95245e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882430; x=1709487230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxPiVCr0B1dvFMvQofRHKAWb8GEUA/MUQ1QDdLDBjQY=;
        b=ZZY56VC/BaLP+aLKif1Nq5Ptrt1fbXSuZaO7G7CV4MX2q/102L1zMddtlYQEylCWS6
         OUpCKddBE7g0X+c4ItiOzZ/WX623asV2RaTiF2GIL/LO4NHF011SvyOOF+02z4rbXV98
         k/0K/B+msn9LI6/K3umIhhk7HJTp852x+ydNSATAM4SFhtSKlPBUzPPsv05j7m2Vez3K
         HRPUDsz02FZlfRBfr3YP114qPalgC/wszJiP8dZ4IXWo6hO8Gl64+HcM6qsyxorCOHr6
         4FqRRtdAsmoam5QPoc9eOjiTsGlV6DRjb5WLWKgERssdqd9TsaQOmn6UUDQH7PgEru0w
         50IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882430; x=1709487230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxPiVCr0B1dvFMvQofRHKAWb8GEUA/MUQ1QDdLDBjQY=;
        b=B+j8MvTnAl/pm/I5a6N7e3FkstrU6Yb/Tcoz/fq5dVqbV2QLY0QXlelVAmJgrWDbqN
         /9h7OOenFj0x5H1k8uJ/adV+Fx9AmLaVj23Nyi08IwSiIF1usFXPA5qOUDyHIrIfY6Rv
         ObJuIuy6I/ggaykxrzIjDL9LnPC98SfQRqWw2GPWxd0lJm5r6TZXibEPk3wrVHN1yVPS
         ksGpPLSb31aXTsUdbRme3w1wKlW0NGLxecLrzgiNvDIpWxrof2QDVqm7KxuWPDWBUpD6
         8G8+8ncf/7N2ZKumSPR1YEjdhp21TlRY3DxPAgzVrUM9xfhadCPwEQzuBLvweZhDtZkd
         gZQA==
X-Forwarded-Encrypted: i=1; AJvYcCWxgn35Wmf4/t8Snd4HoFZX3/1y7KOtLyngN9qxqa/AN8Y+++52s71tlrbQ7QoL98dcKZNbMi+WibdyfBUXv3gpVL9at8Sw5wvW/oEr
X-Gm-Message-State: AOJu0YzjoIl9JpSqrO+X9jGlYgQLs5V/Ty6YD8c0mmw2cSFj3fdhlC6j
	Y2BCnhn+kLorZcWQalUubahcDPXxHpCHTuvHqLIxJnD35WFUAyYq
X-Google-Smtp-Source: AGHT+IHanCuwRE7xw5G8B5NKLZXGJUPdG0ikeirrDEkNe42/zl1H3JHvTpS51Qh4TDMqfcM77dd7EQ==
X-Received: by 2002:a05:600c:3595:b0:412:a22a:c12a with SMTP id p21-20020a05600c359500b00412a22ac12amr1431655wmq.0.1708882430192;
        Sun, 25 Feb 2024 09:33:50 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:79c9:6db8:8198:3c60])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm9400108wmc.27.2024.02.25.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:49 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: pi433: Move FIFO_THRESHOLD define to source file
Date: Sun, 25 Feb 2024 19:33:41 +0200
Message-Id: <20240225173341.1278918-5-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225173341.1278918-1-ikobh7@gmail.com>
References: <20240225173341.1278918-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIFO_THRESHOLD is only being used by pi433_if.c source file

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 0ec3130225db..b6c4917d515e 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -49,6 +49,7 @@
 #define N_PI433_MINORS		BIT(MINORBITS) /*32*/	/* ... up to 256 */
 #define MAX_MSG_SIZE		900	/* min: FIFO_SIZE! */
 #define MSG_FIFO_SIZE		65536   /* 65536 = 2^16  */
+#define FIFO_THRESHOLD	15		/* bytes */
 #define NUM_DIO			2
 
 static dev_t pi433_dev;
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index e63e87fd6cce..76f0f9896a52 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -12,7 +12,6 @@
 #include "rf69_registers.h"
 
 #define FIFO_SIZE	66		/* bytes */
-#define FIFO_THRESHOLD	15		/* bytes */
 
 u8 rf69_read_reg(struct spi_device *spi, u8 addr);
 int rf69_get_version(struct spi_device *spi);
-- 
2.34.1


