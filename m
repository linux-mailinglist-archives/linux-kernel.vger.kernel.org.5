Return-Path: <linux-kernel+bounces-142197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3D8A28BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31811C22597
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B2151C50;
	Fri, 12 Apr 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfwLn7vm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B242C50246
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908988; cv=none; b=ImXy2MFHClSrgnenfeaEG6JeMIC6enP0xumX0uwJu+Wu648q3hgJ5w17MzqT4UFELbXgaFtPsSXYDvAos4lWJ6S+d6M06CX4AFVr2dyN5VM6PX0f6isr8zpk4xNEa4DkkWlWgbNPBZRgbCqkHaKXZ6tnGQp7+MvR/IeeJ5HMa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908988; c=relaxed/simple;
	bh=gTnC52BuFuHklvm77ihUpKGOwdcbvc5JJ4SAx0eGNp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnHDdMWvI2Q/IYlhBDigLwFNgTNQo5Wu+gZKdRZa1ebjCPbGAo34QsNnBD6VXkm8lU3JGCm2ZZhlPqpYm04bDltlhXKOZQGgpaqK7KE5ejFao2pu8pP8lv936qXzfGEgNZ0T7Xssfzp2yhoiWDKsMzUGjnKq9gAyG0ppUPhrej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfwLn7vm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712908985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imYSfgUV9tShp4d1ydGnn8vza1QDI3KMYtf8eE+SzCg=;
	b=cfwLn7vmVB+h5H6pNZ+ARZ+p8MdhYoC0uhj8O1R/GNINJHaBuTbM49DbDn7kLaRDKRu9A5
	PqSnCCDG+I/WkfJ5fYQmixBCMHY61HVGmQWYK7QMh5uVMf9iVhMVT/9S9+6837xbYRXMR1
	g7YoExWfCTewefMFDXlmVXkBS1BrdDI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-5jsAVSnzPmOdZgsSxHJ_ZA-1; Fri, 12 Apr 2024 04:03:04 -0400
X-MC-Unique: 5jsAVSnzPmOdZgsSxHJ_ZA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2e0a51adfso649736a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908983; x=1713513783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imYSfgUV9tShp4d1ydGnn8vza1QDI3KMYtf8eE+SzCg=;
        b=lBKQjCBYZ4oYmXFeTUqArdnAoLYGJk5zU1BRNDWuDCzigt4aBTj2Nba3orgTyW140l
         p1+dMwlwkY+u3+6LErL574S9oXwH04B0FNLM3F63DPV0/HdGLH/Qy+D8UVCKa4JiF4ow
         VXmodIk5FVdrZx2PVab3gSz/+t4rdqQdfzQEnFnPwzXAg2rXiUgsXkEkW9WRTomTF4MB
         SQEYBDsHnTEMT2xoXuRin8ro3gw1ZfJ0Qo+u7zrBwE6zWzzDo1jOcmOzZoriLYzYuZGg
         uEKWdYMtDmPeQl+XXFwdn5qtDS2UpAGbJo3FkKVJRU2/+VUNvIZie9s7m1/OfAk+/zHW
         WzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXRCqrtvlbpqHkqLvKsbrrTCVjFf1uKyazlvq6tIenmi8bAjIKngZ9kZdoIFld14Cd9UPP1fyaooc8pPX9WP4QIa/DIZv9zGewL+Dr
X-Gm-Message-State: AOJu0YwCjhhhkQ5goGJhF6+Kc0UHPDIrQZns3lNQBUbexPjJKPenGhMT
	07aOOmRd9PN/6nU7Db4rBj3xkuZT9kI9qi3Mv0VbkAZczUYxC15wlnXIW5MI9f14yFipPIamsRf
	8tVQ4GVngr+gwzewO2ZPwxSUCUW5SB9jXM6oLunGQsmWAtzvdXyvM3EwG/cdKiA==
X-Received: by 2002:a17:90b:3149:b0:2a5:2ef2:4ce4 with SMTP id ip9-20020a17090b314900b002a52ef24ce4mr1583953pjb.41.1712908983314;
        Fri, 12 Apr 2024 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgFOZohr24G1rXc3Bo3/PYBVjDbfNE4fUPuj6ECJPGPkq7S6KSCCxgCSovuRZVguBmCNTFpw==
X-Received: by 2002:a17:90b:3149:b0:2a5:2ef2:4ce4 with SMTP id ip9-20020a17090b314900b002a52ef24ce4mr1583940pjb.41.1712908983043;
        Fri, 12 Apr 2024 01:03:03 -0700 (PDT)
Received: from Samantha.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm2601514pjs.6.2024.04.12.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:03:02 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	guoren@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 4/5] Kconfig: Enable APM X-Gene RTC for XuanTie TH1520
Date: Fri, 12 Apr 2024 16:01:46 +0800
Message-ID: <20240412080238.134191-5-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412080238.134191-1-wefu@redhat.com>
References: <20240412080238.134191-1-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

This patch enables APM X-Gene RTC for XuanTie TH1520.

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3a89f1e6095d..b219aeef4ce9 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1880,7 +1880,7 @@ config RTC_DRV_MT7622
 config RTC_DRV_XGENE
 	tristate "APM X-Gene RTC"
 	depends on HAS_IOMEM
-	depends on ARCH_XGENE || COMPILE_TEST
+	depends on ARCH_XGENE || ARCH_THEAD || COMPILE_TEST
 	help
 	  If you say yes here you get support for the APM X-Gene SoC real time
 	  clock.
-- 
2.44.0


