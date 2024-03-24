Return-Path: <linux-kernel+bounces-112625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D4887C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B12C1C210C2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579417BCB;
	Sun, 24 Mar 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VufvP2RW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39934175AB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711272736; cv=none; b=cOCHUaGa26WHfAnzlNqWGUakhXX8uQ0OEXEQ0jW7EGs85zUupQROvvD9zI8h3CQEsPeFFE+mDdAH386WEdy9w403097YHG7qnLw3fm075qyouxL6V6H6N2HuPDq4m2abTkwEgRi3fD0laz6NZ9HQ8SdFgAnt9hV3CbmnIdJ+/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711272736; c=relaxed/simple;
	bh=u5pB1sDbN4TWFvIqouYPN1Z7rf5l2iCYMwm/u0Zd89Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HizZMB8eP9VNBnxNL+TEqBYU5VU0yDS5s9lge50JKQ1AdFQDSEhJ9Vev10vfWJe0EcNnpuXXty0cjvkusW4+mAiYAppy3rQMR+kKTXN6fs8VmNvPPkFaNZyxG04VNZ0SDNg3vlBbaBzGAD0DfPu1stl2bYDUiA1sijGh3wqPOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VufvP2RW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso2347835f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711272733; x=1711877533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LopSDTAPBYKt0PL+7kumsFXpTtF7FOQgTtXMVa1BlOc=;
        b=VufvP2RWxOcxPgN47DruWnxHaFz4QD/cGJ1WADEfu1YWG9i/rQjECkhR3pzFek/UkA
         k9KzEGZ8P5q1OSTxeFaohkA8Qo5wY7QxSrferkQnqJEMf6dlLwsWyFS+nYaLOhYJGloY
         rvMOK0+Sg03xTg6QiNpLDFQSPBwDivWyPJyv89cXY/1RAYog+LZ9dFsYJ/lSafPHdlld
         zpMpwYpyb81AiT/T7lpSw7goqtWN9xJm3bzec/+s6HmLfOnQKWsfZbaOCL1wryPl0SHp
         /AP5Aj2+awka7B58qnGjCOGRq2sG0YkKDUoqn7fQEFbRx7WAdMg+fa8f2IVaKw5fU3rM
         4YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711272733; x=1711877533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LopSDTAPBYKt0PL+7kumsFXpTtF7FOQgTtXMVa1BlOc=;
        b=mEYV7k4fl+GolkQfBAVyIqkLlXB7DVnxUUdNpuBEzFZTw8VVqggVZ4+tTdpy8MBKzE
         gKSCClYMmYvKgFBFDVEbdohADCLrsYmwT19wQWhPhJmKbqnQBx7iEYEPCxfsfi42lLxZ
         w0/VNoZN774Rw+CralHUdzK729PuHaJTl0od/n07/Vlspp4mDo353cXwyrk9EavqZkOU
         tWeryxAOXDCgnjpY8mbn5FI0wovIiW9hCLaJR6luHqL21Ax5VBNLBPtCoZUsEauCFexV
         rD3GYsYGn+vy76BLRyPmej9CqjzJ5VkzyEfjvz3Hb3ML1LEUIXUfGGaEhgWAKU8QP+yG
         YKGA==
X-Forwarded-Encrypted: i=1; AJvYcCVBU65EYAJ2/FQEZcP7nKaB0PLE+oLNkh/Xrq81QFtEMvxjAGSg24mWNwM0+EebSkBga78EHJ6RVE5iMRnyD/rAAypYTmsQX65ekcEt
X-Gm-Message-State: AOJu0Yz2fPqBGYhckgs4hW0n/34u9o99wEPa469DEcYLcAbiU4ofHhIR
	TNIvZMUKwkxjMXIHXzwg7NJ/BpeEAiw9BwIlM7ivNVZ0gzHizhSh
X-Google-Smtp-Source: AGHT+IF91Uh6i88LrUzD+gi+FwyOQaAtfAZXHw4cg56yiqD7KbRaau00hOa/ZC4pWwll5Q63J9ScPg==
X-Received: by 2002:adf:e885:0:b0:33e:781e:da57 with SMTP id d5-20020adfe885000000b0033e781eda57mr2494177wrm.53.1711272733665;
        Sun, 24 Mar 2024 02:32:13 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:42b5:8c78:fc9d:7600])
        by smtp.gmail.com with ESMTPSA id ay9-20020a5d6f09000000b0033b87c2725csm6490711wrb.104.2024.03.24.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 02:32:13 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: pi433: Make use of spi mode macro instead of magic number.
Date: Sun, 24 Mar 2024 11:32:01 +0200
Message-Id: <20240324093201.793485-4-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324093201.793485-1-ikobh7@gmail.com>
References: <20240324093201.793485-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use SPI_MODE_0 to setup spi mode.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 9fc93fa454b1..2a22342eda69 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1164,7 +1164,7 @@ static int pi433_probe(struct spi_device *spi)
 	struct dentry		*entry;
 
 	/* setup spi parameters */
-	spi->mode = 0x00;
+	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 8;
 	/*
 	 * spi->max_speed_hz = 10000000;
-- 
2.34.1


