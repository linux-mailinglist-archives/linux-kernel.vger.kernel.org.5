Return-Path: <linux-kernel+bounces-56535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E71384CB60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EF3B233EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71F77F0E;
	Wed,  7 Feb 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVupF5ad"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83976C81;
	Wed,  7 Feb 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312020; cv=none; b=TvnB3bsNQnjVHOXW+P9z/dW+CCVYbHPlglf4wfy7gu4JIjZQ13v66ZIhhNvrSCJSlVlrQ1TSCrA/SPIOR1DNRFfZHg8gCzJEAUq+MBPN0tsQjtHb2p9JCK0hrFLw4Fz3XnBD42U0tZM70yAYaqKHXV4Jpq2wOVoZuieNa0en9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312020; c=relaxed/simple;
	bh=0IeWIuV89GhyH6S9xNFkwCTY+H/TKB0wj2Cx7ah5+64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldMx5scmbQ6WP2GuH62a8w6frcA2H8Hz7mFqzWxbFvbd6PuJgKNUkIU86svR5fuJCLhhVYE+MhrsBqxVW9QREpOLYGCVMQxCD9bpT00II6JReydSydHrES785QrxvoapFWf2PZah3Rvrl44XpULZDvaAOFCmzEmy1dfZf/NbU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVupF5ad; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4101eb5a115so1853115e9.1;
        Wed, 07 Feb 2024 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707312017; x=1707916817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrmsP2bX51lU6YyoXTaVoFbq35iYHP9ljJnfgckCYcc=;
        b=KVupF5adZFboZZMQnC8UEGBRGOYMT+cJOxrdKCcj0TEMZcSQhiVbJe54sgoRC5HwVK
         xearQLnh30TyJaaYDNn31/YjfbLBCkrmfyMD7HeIqj4o4ABOlwY7PWLC1NyhzCyxIVH9
         df7J/RQbQt+HDef8pIrZN5UVY3tU3qMREn5GCxZg6cB7vg4tJTTgFl9Eh1Aa8b6k3J73
         LMmAVaVUYJD81s45jaJ/gJZY4C9uQx+h7tBVpqKyLubiaqw4RdmtonsGWIk0eOCXsDJw
         lSGcUODpKrZLG8Jq6NzQ4ovfkHpoCQIQ07zGFSnS9vdBbn2ATYRUjul0Ys+BYI6OEOMr
         nGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312017; x=1707916817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrmsP2bX51lU6YyoXTaVoFbq35iYHP9ljJnfgckCYcc=;
        b=wzWRi8mHNkzwY/WL3wrArc3vMKK7UZ6akUS5BhgIPEvPv2hy7f2ZOxuY4gw6woKrZA
         kvX5vsK9291slOkDwx+ahy75KsOp3UUcdCDom/At+nDlxYyEmn8geIxjl8Q8beiYCzu+
         RdpGHVQiUb6sP+guMziBcphlLobhGO16+KjxCpUVDPdbspoV1F+QjV1yQb4w1ym0sv6C
         NAFciwdNaZALE0MFQc1vr3RGpkxKgCYLvMMAA/3M6+u0NH77IkEr1Bu5G6XO/qE4DQG8
         1QAjkMkiRtoJc+pCPsJiWToBbKhbNQZ1ALD/boyDRf1AHoPkTQyniiSFUgO6Y8Wv2xwf
         ie7Q==
X-Gm-Message-State: AOJu0YxPafmUWbw/YlDSd6dOKaDLN1lW8pvumJBQaWeLBWtf88sKxr16
	UUgDsxd7FfehP6gk8zpHlM8UULjAB5W6QHW9K3yBuMX5zUzApXuW
X-Google-Smtp-Source: AGHT+IHcCCSXdJpdXy18Oog6sr+qR7ui39IjPjZop7d67hoXMdgKrYjYhYQPCYuGjrvyFa4RaaxkQg==
X-Received: by 2002:a05:600c:34c8:b0:410:44f:195b with SMTP id d8-20020a05600c34c800b00410044f195bmr1524639wmq.28.1707312017151;
        Wed, 07 Feb 2024 05:20:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvqjaghWk+Kd7OSOeNRuWQoEQkxid/kvk/znCTaO+6H/n+2IRhNQgE08H89NVwOZ9a36K0nvttHKOWOCcLfj0R47bZ9DstRD0P/iXtfZsTpoBZ0hNTUHYBbFec8uQc/NqNJxetkrgPdj/MFh6MpSJXoVFQPODI1gICdIDW3fZqEzR/zfN51MugB43MdIZWtQRmv3GTjTchQJyL8pzunnALxcWqz2PTfBiblhiX2qDLEfYeEDWU2yfV6+zWV3aKgSpfw2ep6Jdr50M4IaXO2gKza5XGztpEoShzQw==
Received: from demon-pc.localdomain ([188.24.52.65])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4f05000000b0033b1b1da2adsm1495764wru.99.2024.02.07.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:20:16 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 2/2] iio: adc: ad4130: only set GPIO_CTRL if pin is unused
Date: Wed,  7 Feb 2024 15:20:06 +0200
Message-ID: <20240207132007.253768-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207132007.253768-1-demonsingur@gmail.com>
References: <20240207132007.253768-1-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, GPIO_CTRL bits are set even if the pins are used for
measurements.

GPIO_CTRL bits should only be set if the pin is not used for
other functionality.

Fix this by only setting the GPIO_CTRL bits if the pin has no
other function.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/iio/adc/ad4130.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index c7df499f9775..febb64e67955 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1864,10 +1864,14 @@ static int ad4130_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	/*
-	 * Configure all GPIOs for output. If configured, the interrupt function
-	 * of P2 takes priority over the GPIO out function.
+	 * Configure unused GPIOs for output. If configured, the interrupt
+	 * function of P2 takes priority over the GPIO out function.
 	 */
-	val =  AD4130_IO_CONTROL_GPIO_CTRL_MASK;
+	val = 0;
+	for (i = 0; i < AD4130_MAX_GPIOS; i++)
+		if (st->pins_fn[i + AD4130_AIN2_P1] == AD4130_PIN_FN_NONE)
+			val |= FIELD_PREP(AD4130_IO_CONTROL_GPIO_CTRL_MASK, BIT(i));
+
 	val |= FIELD_PREP(AD4130_IO_CONTROL_INT_PIN_SEL_MASK, st->int_pin_sel);
 
 	ret = regmap_write(st->regmap, AD4130_IO_CONTROL_REG, val);
-- 
2.43.0


