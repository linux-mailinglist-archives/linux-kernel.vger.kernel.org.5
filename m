Return-Path: <linux-kernel+bounces-35549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB7839317
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03451C23E66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125F61688;
	Tue, 23 Jan 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpekW4G5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098660DD2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024080; cv=none; b=iaN4O9iZFTBGjcyRp0j+nf5LmgVJjVcdJMgMvKI6r2juaS/EkLyw5P6M2EsQGlibN1ys6usKVVeSOTGYa7ezp+no6pVv/lC+HivFOZEriWlT155mw55AEJ7SuYeeOb7fOI6x4wXDxudUeFj/GMItPzFUbagaxLuWTTboO1EDQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024080; c=relaxed/simple;
	bh=azFcV/mgHmxVyLvuazK3I1eqSDB4DgGiyfhf9SMqDgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggvi5rYRkLcpMyFRFBTkRUQHSxJgluDSIItv4nI/AO7mZtGWPoDMuSKoakqYHjVXbpbSbY8E4o5S4MW+QFMNgJ+Y3IGFsPvQ2A6g0Cdx3QgLJUSDLrhnEXwa+PujwI6hziQPfE1KXcJUJods0O+ME2rFRnuH0/7s4oroWWjswpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpekW4G5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so56392355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024076; x=1706628876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+YMzDyGNc/zXRSdUvNiD+W2fMYH+c8kFJSxO3iDixs=;
        b=mpekW4G5d289qPbVUvpkAx8dBz1CQgT4/WEtGZYW7xdwyvJSb9jRMGSPwByj1kCtgF
         2LdcPLya6CDBrGEfsyh2EV/dJdPCVn3YQ4C0xEOFDCy/Eu6OUXZu27B5pyfGy8fcYsxl
         52TuZpwdJlbRz88Wyc/Ou58kG9b70Oelvt32wxIZ05LGnT1mK/egInn2APLvu4brVNQN
         3enQu9MxqjIZoVvFdlZw86KAQJKCbxWuDeZ7sJC6cNQQDqkgGPK2RO8uOH1CWZiuP7NY
         Z37j4r6HSoQyIzT1xgKfjEDPcNlSJuJAT3JTstiqQAWY0E88S3MLVMrBB7NTP54WiSj1
         S0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024076; x=1706628876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+YMzDyGNc/zXRSdUvNiD+W2fMYH+c8kFJSxO3iDixs=;
        b=PrPn0mKIg9vzZx/IGVRh7lPYSD3RKJFmucf6OsVIr9nyhZFjCRilGG3UChWPOOeBd4
         GI5+HyoQBtnpcAAt8NSPRNNoVJVQ5lEjLk/GZr/YDghGUhYWng2jjb1ynr/v3FWz5weQ
         qcLWqnfxyNZqeRg4l1aLQzmxmiF/ZPs8c5fFwpYY9FSFMuD0b9B+IEXl4L4KA7PDVcJo
         hGRzFbrUxNT/mCvnBI+epo6FbJDC8By/ZWOLAwyMBa3/lkbjqp021m2769oxuj41/KDW
         1j6t0ScwwoU8ZwoeCk7knfZKztwGuK/KNBqbDZUAjo7AsfW+8pfGKzNIPDBo6uCJTOh7
         /tHA==
X-Gm-Message-State: AOJu0Yz0rPad2R9G4fcmxm0f1KiJh/+iunHY3qh3Mc3X6L4OYZAtqYla
	1LB3bkU8TgnKeqfacsPwa7LyqxEGJw7jzrD0yfvSnzE2yIz/OlmFb6Ao1miJHE4=
X-Google-Smtp-Source: AGHT+IHzfN1qnVR4UVsM9mJTMqExDKUWTqRX/JTb9E8bTyCwoGow8h3nokE07jWiTAJ313YlGKAHHw==
X-Received: by 2002:a05:600c:12cb:b0:40e:4179:d060 with SMTP id v11-20020a05600c12cb00b0040e4179d060mr280263wmd.65.1706024076431;
        Tue, 23 Jan 2024 07:34:36 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:35 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 12/21] spi: s3c64xx: propagate the dma_submit_error() error code
Date: Tue, 23 Jan 2024 15:34:11 +0000
Message-ID: <20240123153421.715951-13-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate the dma_submit_error() error code, don't overwrite it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index cc33647eab14..2b088a190ab9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -315,7 +315,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	ret = dma_submit_error(dma->cookie);
 	if (ret) {
 		dev_err(&sdd->pdev->dev, "DMA submission failed");
-		return -EIO;
+		return ret;
 	}
 
 	dma_async_issue_pending(dma->ch);
-- 
2.43.0.429.g432eaa2c6b-goog


