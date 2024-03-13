Return-Path: <linux-kernel+bounces-102283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F087B02B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2150C1C266E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806D0657B7;
	Wed, 13 Mar 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXEjV1Gx"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C5524DD;
	Wed, 13 Mar 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351618; cv=none; b=QzsVggBQWgXLcTCWFq6n6hwOWi4MBXIq8y+te9qreasu1WSqk6WlQLDFuPIOMiTW6KXezOzvuYx/L2piiLh9lFfOLJaZbdRxXx97rKtFaDUhMtiD6TtZzc+7BbJ2ZXGT9w09zSKK/zGV5mklFji5qswD+rWhumQVUfrRVsRpe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351618; c=relaxed/simple;
	bh=6Ouxyk1MFE8oPL5EtYMsLRqOrNWjyubaatGPHGKRHrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0gJY/OpsOd/2fTM7Bf8Lsx+pAaBgY96KVFgc8BYpp+JZhrk8/N2Xy9vkcq/67H5P3j5Q9VCYzCiToyxFkUq3uWUTN8PfFnoI6w9dRotE4r1LkPZE9x8VNtu25bTE/xOVGkKo05CJDK7STib6Kmc/oKVZ/QCPfkt6h0nXbIyXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXEjV1Gx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44665605f3so10646966b.2;
        Wed, 13 Mar 2024 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351615; x=1710956415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6laUTApqd01ANpCuz0jrMfAwGjaFU1xJS3mFm+uw6r0=;
        b=IXEjV1Gxdn/4ASL8GtLHdlwDb8we+OZodmg2hFo3Th2vG85ol1pEIgXxtZQ1kJ8/0D
         VJkmADTjQcoxibVEyWtWb1Jvht4bftg+WGTjOBIkDWLqtXmyOrg9Nr0pGaWMG1GDdwud
         N5NpqBAF3zu00pwRPDK2S9LyNijC6QIJBISZYrBalwCah+lXaeutd7iDmQzOJzKzq2Q5
         8B3551Q+nOX4U0ksJHKwos8N7heIQ7jb9WS3GXt2PwFjR+s7CCH/AcO0VDTICsa4dnD3
         f2Mx39UIguMwEBvPfMDo980+w4qf10h4DwvRcCeV7YadcokWvabw618zmRGAMpSA+3IB
         bLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351615; x=1710956415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6laUTApqd01ANpCuz0jrMfAwGjaFU1xJS3mFm+uw6r0=;
        b=OBykvX2hxCdVNb66k933IaWxDctjcDzyILhhbBwFga07CtCu6DCnEzb6sfZss0DLkR
         BmXX/FxFrsNBULM0Bk07VxZavyYxmecwz0ZSUtK/Z/cm5kz6UuX3R5xNLLwSzQq597p+
         aplN6L+5ihxeXqzpeB/I197OCQyC98BqT7P1iV5d8TyzaymAp0CdXyXL2VQ1cWose68T
         8Z7xXB0yQFpBZ4eom6ynxxrwcSniphJr1QRP6s8z1SpEBL4Tg5t7aDckd8tkSBHm7n7u
         d9N6zuwENukKORBDu27lZGGx1qNJmNkueK9q20GLNwYNjGiRYZKQDfpMscC2kyWMM02e
         nDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUivlDLmJn5UEZOefLmhyYqw81SPgVm1oVWUduZGNX3V7WxrnuNYoU3wsx+wfv2crv6ejAEB7obOhdl+WuzOGNvMDdOszvzB1C8AF0kibgt3oUYzASZbuIctdITerEVNnjjh72LaYlf
X-Gm-Message-State: AOJu0Yxp3OfZ5KlNw6LrGdl0ikXdjswxuRoQVUF4EKO366Kdq4pf6iAS
	zua/gW/xMDplRut515nJthE1aTe9+msUT9Xkhl1fJGyz5pno4PrI
X-Google-Smtp-Source: AGHT+IGHlFExJN1yZ70hUjVMTDdX6foAzMMX10X8m78kkMw1BMjLQrxPvlsaPFOBXAoHTe1iMbWN4A==
X-Received: by 2002:a17:906:e292:b0:a46:651b:b62 with SMTP id gg18-20020a170906e29200b00a46651b0b62mr985545ejb.15.1710351615513;
        Wed, 13 Mar 2024 10:40:15 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm5028215ejj.53.2024.03.13.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:40:15 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	linus.walleij@linaro.org,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 1/6] iio: pressure: BMP280 core driver headers sorting
Date: Wed, 13 Mar 2024 18:40:02 +0100
Message-Id: <20240313174007.1934983-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313174007.1934983-1-vassilisamir@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort headers in alphabetical order.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe8734468ed3..871b2214121b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,20 +27,20 @@
 
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/nvmem-provider.h>
-#include <linux/regmap.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/regulator/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h> /* For irq_get_irq_data() */
-#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
 
 #include <asm/unaligned.h>
 
-- 
2.25.1


